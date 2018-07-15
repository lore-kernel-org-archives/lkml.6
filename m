Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05AECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A420652
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371A420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeGOX6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:58:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:58:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNXB0L922101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:33:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNXBF1922098;
        Sun, 15 Jul 2018 16:33:11 -0700
Date:   Sun, 15 Jul 2018 16:33:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-bbb62c0b024a1c721232667fa1d625cf6b3a555b@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          vincent.guittot@linaro.org, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <1530200714-4504-11-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-11-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Remove the rt_avg code
Git-Commit-ID: bbb62c0b024a1c721232667fa1d625cf6b3a555b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bbb62c0b024a1c721232667fa1d625cf6b3a555b
Gitweb:     https://git.kernel.org/tip/bbb62c0b024a1c721232667fa1d625cf6b3a555b
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:13 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:16:29 +0200

sched/core: Remove the rt_avg code

rt_avg is not used anywhere anymore, so we can remove all related code.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Cc: viresh.kumar@linaro.org
Link: http://lkml.kernel.org/r/1530200714-4504-11-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 26 --------------------------
 kernel/sched/fair.c  |  2 --
 kernel/sched/sched.h | 17 -----------------
 3 files changed, 45 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 38107a95baca..a691b07390ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -651,23 +651,6 @@ bool sched_can_stop_tick(struct rq *rq)
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
-
-void sched_avg_update(struct rq *rq)
-{
-	s64 period = sched_avg_period();
-
-	while ((s64)(rq_clock(rq) - rq->age_stamp) > period) {
-		/*
-		 * Inline assembly required to prevent the compiler
-		 * optimising this loop into a divmod call.
-		 * See __iter_div_u64_rem() for another example of this.
-		 */
-		asm("" : "+rm" (rq->age_stamp));
-		rq->age_stamp += period;
-		rq->rt_avg /= 2;
-	}
-}
-
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_RT_GROUP_SCHED) || (defined(CONFIG_FAIR_GROUP_SCHED) && \
@@ -5716,13 +5699,6 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
-static void set_cpu_rq_start_time(unsigned int cpu)
-{
-	struct rq *rq = cpu_rq(cpu);
-
-	rq->age_stamp = sched_clock_cpu(cpu);
-}
-
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -5840,7 +5816,6 @@ static void sched_rq_cpu_starting(unsigned int cpu)
 
 int sched_cpu_starting(unsigned int cpu)
 {
-	set_cpu_rq_start_time(cpu);
 	sched_rq_cpu_starting(cpu);
 	sched_tick_start(cpu);
 	return 0;
@@ -6108,7 +6083,6 @@ void __init sched_init(void)
 
 #ifdef CONFIG_SMP
 	idle_thread_set_boot_cpu();
-	set_cpu_rq_start_time(smp_processor_id());
 #endif
 	init_sched_fair_class();
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d265fa9756a2..d5f7d521e448 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5323,8 +5323,6 @@ static void cpu_load_update(struct rq *this_rq, unsigned long this_load,
 
 		this_rq->cpu_load[i] = (old_load * (scale - 1) + new_load) >> i;
 	}
-
-	sched_avg_update(this_rq);
 }
 
 /* Used instead of source_load when we know the type == 0 */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 061d51fb5b44..14aac2d2de80 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -853,8 +853,6 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
-	u64			rt_avg;
-	u64			age_stamp;
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
@@ -1719,11 +1717,6 @@ extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-static inline u64 sched_avg_period(void)
-{
-	return (u64)sysctl_sched_time_avg * NSEC_PER_MSEC / 2;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
@@ -1760,8 +1753,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
-extern void sched_avg_update(struct rq *rq);
-
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
@@ -1772,12 +1763,6 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
-{
-	rq->rt_avg += rt_delta * arch_scale_freq_capacity(cpu_of(rq));
-	sched_avg_update(rq);
-}
 #else
 #ifndef arch_scale_cpu_capacity
 static __always_inline
@@ -1786,8 +1771,6 @@ unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
-static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-static inline void sched_avg_update(struct rq *rq) { }
 #endif
 
 struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
