Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id naRBBvRxGltQPQAAmS7hNA
	; Fri, 08 Jun 2018 12:10:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D8046089E; Fri,  8 Jun 2018 12:10:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mfqu9C+o"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E457605A5;
	Fri,  8 Jun 2018 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E457605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeFHMKX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33799 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeFHMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:19 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so13170753wro.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+UXXuIxLDd2ExlgZRDY0Sm8MkqDcF4HECh9MjCADl4=;
        b=Mfqu9C+oMzK8izfYwe5RwEWYqNAtjERs2X512exH3/fFYosiFTwNao2lFF3jYz4QFW
         LKB4YjUNAFuOyjLIwX0i40pErQQ2xnE8w3n9vKHKqVGCNKlPy+CRvziJzudaBl9HNrmg
         e9z0OBCPd4dD7Bq8m9aH/N1YH72y907PMLSko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+UXXuIxLDd2ExlgZRDY0Sm8MkqDcF4HECh9MjCADl4=;
        b=OWN9kVbMJfdCD/7I76KI0RckrXG0BgbD4eYxDAJGR1ip4yeVLR8NrvrfxXmkNp2QAw
         t/SsKnI56aPnVlZvavpl0/xT4HYI1QQNk4qJY11cdzc1DLWBXhltnpTJOFOUyFWGBxLd
         +w0eUiLBLL3BBSBQCCZB7+ATL+KO73R73N6xAtTz671QsRdtOBw70lK2vjENRpLYy9uA
         MDDlqnZvOji1yLawy7+ltzh9vnaxI5RhlZeO9NmQgIq//JddwMoXS1q/Vbk5qlvmQzj7
         sY/uygsseLt0aLgaEbg/jac9SFavL/7upuOgXVpGeMFscBXohq3ZdJDUv3aM2s6SN8ox
         fMRA==
X-Gm-Message-State: APt69E1itx9aAR5fqVGRXipAWzzhM2OkIkwoS3L0e38B4MYLD1geTzAY
        DxCRcmqmaQ321GUc1Ukm8NxY8w==
X-Google-Smtp-Source: ADUXVKImSEo161ZNLGBtKAVm2TbnPx2y1rECskI4gpFY/dZgE8puilrhjMXuJg/LQ/wWNw6dq5cVtw==
X-Received: by 2002:adf:b89b:: with SMTP id i27-v6mr4592332wrf.163.1528459817717;
        Fri, 08 Jun 2018 05:10:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:17 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v6 03/11] sched/rt: add rt_rq utilization tracking
Date: Fri,  8 Jun 2018 14:09:46 +0200
Message-Id: <1528459794-13066-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
tasks are running. When the CPU is overloaded by cfs and rt tasks, cfs tasks
are preempted by rt tasks and in this case util_avg reflects the remaining
capacity but not what cfs want to use. In such case, schedutil can select a
lower OPP whereas the CPU is overloaded. In order to have a more accurate
view of the utilization of the CPU, we track the utilization of rt tasks.

rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
the same at the root group level, so the PELT windows of the util_sum are
aligned.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 15 ++++++++++++++-
 kernel/sched/pelt.c  | 22 ++++++++++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/rt.c    | 13 +++++++++++++
 kernel/sched/sched.h |  7 +++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6390c66..e471fae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,6 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
+static inline bool rt_rq_has_blocked(struct rq *rq)
+{
+	if (READ_ONCE(rq->avg_rt.util_avg))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7349,6 +7357,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	/* Don't need periodic decay once load/util_avg are null */
+	if (rt_rq_has_blocked(rq))
+		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
@@ -7414,9 +7426,10 @@ static inline void update_blocked_averages(int cpu)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 4174582..81c0d7e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -307,3 +307,25 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 
 	return 0;
 }
+
+/*
+ * rt_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
+				running,
+				running,
+				running)) {
+		___update_load_avg(&rq->avg_rt, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9cac73e..b2983b7 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -3,6 +3,7 @@
 int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
+int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -38,6 +39,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int
+update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
+
 #endif
 
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ef3c4e6..e8c08a8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,6 +5,8 @@
  */
 #include "sched.h"
 
+#include "pelt.h"
+
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 
@@ -1572,6 +1574,14 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	rt_queue_push_tasks(rq);
 
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1579,6 +1589,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 {
 	update_curr_rt(rq);
 
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
+
 	/*
 	 * The previous task needs to be made eligible for pushing
 	 * if it is still active
@@ -2308,6 +2320,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	struct sched_rt_entity *rt_se = &p->rt;
 
 	update_curr_rt(rq);
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
 
 	watchdog(rq, p);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 757a3ee..7a16de9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -592,6 +592,7 @@ struct rt_rq {
 	unsigned long		rt_nr_total;
 	int			overloaded;
 	struct plist_head	pushable_tasks;
+
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
@@ -847,6 +848,7 @@ struct rq {
 
 	u64			rt_avg;
 	u64			age_stamp;
+	struct sched_avg	avg_rt;
 	u64			idle_stamp;
 	u64			avg_idle;
 
@@ -2205,4 +2207,9 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 	return util;
 }
+
+static inline unsigned long cpu_util_rt(struct rq *rq)
+{
+	return rq->avg_rt.util_avg;
+}
 #endif
-- 
2.7.4
