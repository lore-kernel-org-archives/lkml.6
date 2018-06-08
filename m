Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BL5OACZyGlvlPgAAmS7hNA
	; Fri, 08 Jun 2018 12:11:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D39E5607E4; Fri,  8 Jun 2018 12:11:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os1IOBxZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 039DF605A5;
	Fri,  8 Jun 2018 12:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 039DF605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbeFHMLl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:11:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36210 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbeFHMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:33 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so13172794wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+Tog/mH6Ne//NBSS9jdySMokBre49Tx7H+19ZJqohc=;
        b=Os1IOBxZprzgMlHk9msuDMtGg4X789KwpEDAxB3GCEU0kJo8oi5g58lB1gmwau5Ikz
         2zjm0uUxnvxs7YZWzuXk55gqOaAADJXJa0olq9l1QSrrdLpL14uKMox9+N33kWsTwGML
         Sge/ISn/Cron0VYRvpmWtAldidzKHmcvtORgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+Tog/mH6Ne//NBSS9jdySMokBre49Tx7H+19ZJqohc=;
        b=kjVNHmaJGIdsDG/dX1EI3ROhAXj7xY8iUoO0AdlhU3tPePor4OWOv0n7Y/RAMC28b4
         52yBDdzGP6EcV4oMldvzXk5G8/jdILcriHZ33uV+uRxEcFZBvXxATvxe5NhYdy1yzA4W
         9qiBc+qiJ02DfztMdwZvQowXMShVvcxB7hrgc9A6VIlZlbwnLD9vf2gqGtVu+GTN7Bvo
         td32T7x4x0sJ7jsJulKrEx6FJ6ONBP+PuKswLoHK+5kjAkOaUOsB7brpQxIolW0vfPFW
         l1XWin6nJstPXSX2rRk50IHIgLtq2lsam0EyYzDpy+xmUIrph21I+7q94SBjMdUtJ5v8
         aj9w==
X-Gm-Message-State: APt69E2AkrrQgw37y/urQFG/V6jY6Rw9uiP4yG6BmJsb3j9V8z7QN91j
        qs2sUlUigjsskVuMrJW8EVjcRQ==
X-Google-Smtp-Source: ADUXVKIzRIwmpnJ1elLN5Sthkq5WG1hsqPgdbVPr9S6R/jn9PVPhZDbrFLZpnV0EKwXRpTDVwU8d6Q==
X-Received: by 2002:adf:fc05:: with SMTP id i5-v6mr4835704wrr.157.1528459831870;
        Fri, 08 Jun 2018 05:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:31 -0700 (PDT)
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
Subject: [PATCH v6 07/11] sched/irq: add irq utilization tracking
Date: Fri,  8 Jun 2018 14:09:50 +0200
Message-Id: <1528459794-13066-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

interrupt and steal time are the only remaining activities tracked by
rt_avg. Like for sched classes, we can use PELT to track their average
utilization of the CPU. But unlike sched class, we don't track when
entering/leaving interrupt; Instead, we take into account the time spent
under interrupt context when we update rqs' clock (rq_clock_task).
This also means that we have to decay the normal context time and account
for interrupt time during the update.

That's also important to note that because
  rq_clock == rq_clock_task + interrupt time
and rq_clock_task is used by a sched class to compute its utilization, the
util_avg of a sched class only reflects the utilization of the time spent
in normal context and not of the whole time of the CPU. Adding the utilization
of interrupt gives an more accurate estimate of utilization of CPU.
The CPU utilization is :
  avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq

Most of the time, avg_irq is small and neglictible so the use of the
approximation CPU utilization = /Sum avg_rq was enough

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 +++-
 kernel/sched/fair.c  | 13 ++++++++++---
 kernel/sched/pelt.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  | 16 ++++++++++++++++
 kernel/sched/sched.h |  3 +++
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d155518..ab58288 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -16,6 +16,8 @@
 #include "../workqueue_internal.h"
 #include "../smpboot.h"
 
+#include "pelt.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
@@ -184,7 +186,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
-		sched_rt_avg_update(rq, irq_delta + steal);
+		update_irq_load_avg(rq, irq_delta + steal);
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 71fe74a..cc7a6e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7290,7 +7290,7 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-static inline bool others_rqs_have_blocked(struct rq *rq)
+static inline bool others_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
 		return true;
@@ -7298,6 +7298,11 @@ static inline bool others_rqs_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	if (READ_ONCE(rq->avg_irq.util_avg))
+		return true;
+#endif
+
 	return false;
 }
 
@@ -7362,8 +7367,9 @@ static void update_blocked_averages(int cpu)
 	}
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (others_rqs_have_blocked(rq))
+	if (others_have_blocked(rq))
 		done = false;
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -7432,9 +7438,10 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
 	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_rqs_have_blocked(rq))
+	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
 		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b86405e..b43e2af 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -351,3 +351,43 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 
 	return 0;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+/*
+ * irq:
+ *
+ *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
+ *   util_sum = cpu_scale * load_sum
+ *   runnable_load_sum = load_sum
+ *
+ */
+
+int update_irq_load_avg(struct rq *rq, u64 running)
+{
+	int ret = 0;
+	/*
+	 * We know the time that has been used by interrupt since last update
+	 * but we don't when. Let be pessimistic and assume that interrupt has
+	 * happened just before the update. This is not so far from reality
+	 * because interrupt will most probably wake up task and trig an update
+	 * of rq clock during which the metric si updated.
+	 * We start to decay with normal context time and then we add the
+	 * interrupt context time.
+	 * We can safely remove running from rq->clock because
+	 * rq->clock += delta with delta >= running
+	 */
+	ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
+				0,
+				0,
+				0);
+	ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
+				1,
+				1,
+				1);
+
+	if (ret)
+		___update_load_avg(&rq->avg_irq, 1, 1);
+
+	return ret;
+}
+#endif
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 0e4f912..d2894db 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,16 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+int update_irq_load_avg(struct rq *rq, u64 running);
+#else
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
+#endif
+
 /*
  * When a task is dequeued, its estimated utilization should not be update if
  * its util_avg has not been updated at least once.
@@ -51,6 +61,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
 	return 0;
 }
+
+static inline int
+update_irq_load_avg(struct rq *rq, u64 running)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bc4305f..b534a43 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -850,6 +850,9 @@ struct rq {
 	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	struct sched_avg	avg_irq;
+#endif
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.7.4
