Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JrL5EGZwGls9NQAAmS7hNA
	; Fri, 08 Jun 2018 12:10:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04E68608B8; Fri,  8 Jun 2018 12:10:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCR4gIPY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 29ECD605A5;
	Fri,  8 Jun 2018 12:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29ECD605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeFHMKb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55447 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeFHMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so2949536wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tqETDECeHvrT5aJ8KzIJhpVxpXGSJNRMYuHT26YsoE8=;
        b=hCR4gIPYlQq/CgpIVbuur9qfPRPpejaabh8BzCWYSOV9dTudICAVEcGhbUpsWWubj4
         12LhSpuAGTAQZwwTgoBgKcUfF/z0RROIvoiSbjjIXcKHz1QATvR+quGiV2wqQBy9VL5N
         vQqBHL77whAICakoVZN3vpE+WEmLxQ2inKHdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tqETDECeHvrT5aJ8KzIJhpVxpXGSJNRMYuHT26YsoE8=;
        b=hHCPAQIOp2gRRwNQXyDRsEtUE/6m2DD+OtZQois+2phS42/RlaIrg7pSdNShMrhoyX
         TjAjP4iHqkOrmnU1uoDabiNWyQ/OWzOBC300MOXS41+OK/Dbj1TN5Dvo4tq/GJaFkd3t
         qmZgoG7wg3uidb0cIL+A9TtYi5uSJhfzEpzeiFYcEk1rvXheC5gWQAtLUyqcHYrb7yoN
         9Lfe8PPUe3NWovS31wE/J7xEnefRG9tpG3co3BA+MK9RVfm+PF2EzL9ruSOWcVBn+MUT
         Tm8bIwaLQancUiO8/KX41ftKBjlPSyc5mk4UxAJneTl+u/+pyYJ8gnALq2L0Zg4mEEmv
         cc+A==
X-Gm-Message-State: APt69E1sYhPbBB8iXltWqXt17lTPUnj82uvr2M08TC/P2kpF+WsvdIve
        Vf09s9vgoZbRsWZCyWFlRFYRMXvwfOY=
X-Google-Smtp-Source: ADUXVKKtFqaqoqoppJPPZjc+juyqRzCmMOvQ0fmdLedsPbhTQwKrtcteY0fECdzd4sF5G6pStYl/+A==
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr1321547wme.54.1528459825725;
        Fri, 08 Jun 2018 05:10:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:25 -0700 (PDT)
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
Subject: [PATCH v6 05/11] sched/dl: add dl_rq utilization tracking
Date: Fri,  8 Jun 2018 14:09:48 +0200
Message-Id: <1528459794-13066-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to what happens with rt tasks, cfs tasks can be preempted by dl
tasks and the cfs's utilization might no longer describes the real
utilization level.
Current dl bandwidth reflects the requirements to meet deadline when tasks are
enqueued but not the current utilization of the dl sched class. We track
dl class utilization to help to estimate the system utilization.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c |  6 ++++++
 kernel/sched/fair.c     | 11 ++++++++---
 kernel/sched/pelt.c     | 22 ++++++++++++++++++++++
 kernel/sched/pelt.h     |  6 ++++++
 kernel/sched/sched.h    |  1 +
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd..596097f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -16,6 +16,7 @@
  *                    Fabio Checconi <fchecconi@gmail.com>
  */
 #include "sched.h"
+#include "pelt.h"
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -1761,6 +1762,9 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	deadline_queue_push_tasks(rq);
 
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
 	return p;
 }
 
@@ -1768,6 +1772,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	if (on_dl_rq(&p->dl) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
 }
@@ -1784,6 +1789,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 {
 	update_curr_dl(rq);
 
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 1);
 	/*
 	 * Even when we have runtime, update_curr_dl() might have resulted in us
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e471fae..71fe74a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,11 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool rt_rq_has_blocked(struct rq *rq)
+static inline bool others_rqs_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_dl.util_avg))
+		return true;
+
 	return false;
 }
 
@@ -7358,8 +7361,9 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (rt_rq_has_blocked(rq))
+	if (others_rqs_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7427,9 +7431,10 @@ static inline void update_blocked_averages(int cpu)
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 81c0d7e..b86405e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -329,3 +329,25 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+/*
+ * dl_rq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
+				running,
+				running,
+				running)) {
+		___update_load_avg(&rq->avg_dl, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index b2983b7..0e4f912 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -4,6 +4,7 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
 int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
 /*
  * When a task is dequeued, its estimated utilization should not be update if
@@ -45,6 +46,11 @@ update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+static inline int
+update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7a16de9..4526ba6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -849,6 +849,7 @@ struct rq {
 	u64			rt_avg;
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
+	struct sched_avg	avg_dl;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4
