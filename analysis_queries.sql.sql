-- =========================================
-- PROJECT: Operational Efficiency & SLA Optimization
-- =========================================

-- 1. EXECUTIVE KPI SUMMARY
SELECT 
    COUNT(*) AS total_tickets,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours,
    ROUND(AVG(first_response_hours), 2) AS avg_first_response_hours,
    ROUND(100 * SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS sla_breach_rate,
    ROUND(100 * SUM(CASE WHEN escalated = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS escalation_rate,
    ROUND(100 * SUM(CASE WHEN reopened = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS reopened_rate,
    ROUND(AVG(customer_satisfaction_score), 2) AS avg_csat
FROM ops_dataset;

-- =========================================

-- 2. SLA BREACH BY PRIORITY
SELECT 
    priority,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS breached_tickets,
    ROUND(100 * SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS breach_rate,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours
FROM ops_dataset
GROUP BY priority
ORDER BY breach_rate DESC;

-- =========================================

-- 3. SLA BREACH BY TEAM
SELECT 
    team,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS breached_tickets,
    ROUND(100 * SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS breach_rate,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours
FROM ops_dataset
GROUP BY team
ORDER BY breach_rate DESC;

-- =========================================

-- 4. ROOT CAUSE ANALYSIS
SELECT 
    root_cause,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS breached_tickets,
    ROUND(100 * SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS breach_rate
FROM ops_dataset
GROUP BY root_cause
ORDER BY breached_tickets DESC;

-- =========================================

-- 5. BUSINESS IMPACT SIMULATION
SELECT 
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) AS current_breaches,
    ROUND(SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) * 0.20, 0) AS potential_reduction,
    ROUND(SUM(CASE WHEN sla_breach = 'Yes' THEN 1 ELSE 0 END) * 0.80, 0) AS projected_breaches
FROM ops_dataset;

-- =========================================