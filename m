Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id W8GXGUNyGlu9PwAAmS7hNA
	; Fri, 08 Jun 2018 12:11:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3F52607E4; Fri,  8 Jun 2018 12:11:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUzTuj/E"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 053E860290;
	Fri,  8 Jun 2018 12:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 053E860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeFHMLT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:11:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40162 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeFHMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so3265958wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pE+h1VuN59ZRcVvHCdR88kNf6zFNrgFECds97E/YUjc=;
        b=eUzTuj/EJznv+ZBeXTJveSQv9cLz2aA2lx7toZySZanODcUu27xRotOKHEYQCp6JpV
         ak68H5qqSQUk5oCOv/+2f2M3/C81vBxB2C6BHzxXz//UeyKqLlHhC80qN1u8qi6IjUyD
         OtPPs+Ci01sJ06ajI4/k/JjQ2JCUuNZlW5B7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pE+h1VuN59ZRcVvHCdR88kNf6zFNrgFECds97E/YUjc=;
        b=DKIdivLKxmZtprSfWJHKUQU82VO8Uyh+0thkTHX2eCK39msFzJ+J79QcGeH/51Sp8e
         CO+rhYeNeZqxmn0Y2/tosHEptHduraOBNp9wwuP6Y5K4YVLilu8hNxu+4a3A8cyO1AsV
         yEprm/gmZsNi6uDgZ8T9l0vOse0eBWfS1hNTH0jig403HwbD4mooyQ7YLwmofIQxMCOn
         2duWwxGx90zD6QVOfkd3P9RD1lU+UpLTpe2qVJNVS6YDp5jNXrcV07tMeI4UBLJWb+vx
         70MPCxI8peywJxPQ33HWK861F7m2YAMYdxbiNKfNi9rnQexKj9ovW/GOhpT3GGw+PBgl
         neGg==
X-Gm-Message-State: APt69E0M2i9X8h2AaZoGqUsIXTcyBZOz6uAp9zww9CbKgWMr8hpLUuB1
        z2tlymeW6nVxpy7W33FPaaCP3w==
X-Google-Smtp-Source: ADUXVKJ1kTxqah6X+UCAnD9F14QCjpjSbWUwbZRJ2vyQMEmkf2cWdXG+ZibYrce5+3X/FGXzu7XByA==
X-Received: by 2002:a1c:256:: with SMTP id 83-v6mr1498778wmc.41.1528459836902;
        Fri, 08 Jun 2018 05:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:36 -0700 (PDT)
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
Subject: [PATCH v6 09/11] sched: use pelt for scale_rt_capacity()
Date: Fri,  8 Jun 2018 14:09:52 +0200
Message-Id: <1528459794-13066-10-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utilization of the CPU by rt, dl and interrupts are now tracked with
PELT so we can use these metrics instead of rt_avg to evaluate the remaining
capacity available for cfs class.

scale_rt_capacity() behavior has been changed and now returns the remaining
capacity available for cfs instead of a scaling factor because rt, dl and
interrupt provide now absolute utilization value.

The same formula as schedutil is used:
  irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
but the implementation is different because it doesn't return the same value
and doesn't benefit of the same optimization

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c |  2 --
 kernel/sched/fair.c     | 41 +++++++++++++++++++----------------------
 kernel/sched/pelt.c     |  2 +-
 kernel/sched/rt.c       |  2 --
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 596097f..c882d156 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1180,8 +1180,6 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc7a6e2..fefd71b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7551,39 +7551,36 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	u64 total, used, age_stamp, avg;
-	s64 delta;
-
-	/*
-	 * Since we're reading these variables without serialization make sure
-	 * we read them once before doing sanity checks on them.
-	 */
-	age_stamp = READ_ONCE(rq->age_stamp);
-	avg = READ_ONCE(rq->rt_avg);
-	delta = __rq_clock_broken(rq) - age_stamp;
+	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long used, irq, free;
 
-	if (unlikely(delta < 0))
-		delta = 0;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	irq = READ_ONCE(rq->avg_irq.util_avg);
 
-	total = sched_avg_period() + delta;
+	if (unlikely(irq >= max))
+		return 1;
+#endif
 
-	used = div_u64(avg, total);
+	used = READ_ONCE(rq->avg_rt.util_avg);
+	used += READ_ONCE(rq->avg_dl.util_avg);
 
-	if (likely(used < SCHED_CAPACITY_SCALE))
-		return SCHED_CAPACITY_SCALE - used;
+	if (unlikely(used >= max))
+		return 1;
 
-	return 1;
+	free = max - used;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	free *= (max - irq);
+	free /= max;
+#endif
+	return free;
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = arch_scale_cpu_capacity(sd, cpu);
+	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = capacity;
-
-	capacity *= scale_rt_capacity(cpu);
-	capacity >>= SCHED_CAPACITY_SHIFT;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index b43e2af..e2d53a6 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -237,7 +237,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
 	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
-	sa->util_avg = sa->util_sum / divider;
+	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e8c08a8..4fd2b57 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -970,8 +970,6 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
-- 
2.7.4
