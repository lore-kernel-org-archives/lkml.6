Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936073AbeEYNNH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:13:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50691 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935892AbeEYNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:12:51 -0400
X-Google-Smtp-Source: ADUXVKIwPamYorVWx/W38rpIy7mtKJx7ZWCe92YLgY396BIAdcjBnTqwk1MXaWZPlGw1Z84iV+n5NA==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 10/10] proc/sched: remove unused sched_time_avg_ms
Date: Fri, 25 May 2018 15:12:31 +0200
Message-Id: <1527253951-22709-11-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/sys/kernel/sched_time_avg_ms entry is not used anywhere.
Remove it

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/sysctl.h | 1 -
 kernel/sched/core.c          | 8 --------
 kernel/sched/sched.h         | 1 -
 kernel/sysctl.c              | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a151..913488d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -40,7 +40,6 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-extern __read_mostly unsigned int sysctl_sched_time_avg;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 213d277..9894bc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -46,14 +46,6 @@ const_debug unsigned int sysctl_sched_features =
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
 /*
- * period over which we average the RT time consumption, measured
- * in ms.
- *
- * default: 1s
- */
-const_debug unsigned int sysctl_sched_time_avg = MSEC_PER_SEC;
-
-/*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1929db7..5d55782 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1704,7 +1704,6 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
-extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a78cf7..d77a959 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,14 +368,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "sched_time_avg_ms",
-		.data		= &sysctl_sched_time_avg,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.7.4
