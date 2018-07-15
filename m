Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6002AECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD4520840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD4520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeGOXzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:55:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:55:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNUA1F921691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:30:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNUAje921688;
        Sun, 15 Jul 2018 16:30:10 -0700
Date:   Sun, 15 Jul 2018 16:30:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-dfa444dc2ff62edbaf1ff95ed22dd2ce8a5715da@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org, hpa@zytor.com
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
          hpa@zytor.com, viresh.kumar@linaro.org
In-Reply-To: <1530200714-4504-9-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-9-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Remove sugov_aggregate_util()
Git-Commit-ID: dfa444dc2ff62edbaf1ff95ed22dd2ce8a5715da
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

Commit-ID:  dfa444dc2ff62edbaf1ff95ed22dd2ce8a5715da
Gitweb:     https://git.kernel.org/tip/dfa444dc2ff62edbaf1ff95ed22dd2ce8a5715da
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:11 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:21 +0200

sched/cpufreq: Remove sugov_aggregate_util()

There is no reason why sugov_get_util() and sugov_aggregate_util()
were in fact separate functions.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
[ Rebased after adding irq tracking and fixed some compilation errors. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
Link: http://lkml.kernel.org/r/1530200714-4504-9-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 44 ++++++++++++++--------------------------
 kernel/sched/sched.h             |  2 +-
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7016bde9d194..c9622b3f183d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,12 +53,7 @@ struct sugov_cpu {
 	unsigned int		iowait_boost_max;
 	u64			last_update;
 
-	/* The fields below are only needed when sharing a policy: */
-	unsigned long		util_cfs;
-	unsigned long		util_dl;
 	unsigned long		bw_dl;
-	unsigned long		util_rt;
-	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -182,38 +177,31 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util, irq, max;
 
-	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->util_cfs = cpu_util_cfs(rq);
-	sg_cpu->util_dl  = cpu_util_dl(rq);
-	sg_cpu->bw_dl    = cpu_bw_dl(rq);
-	sg_cpu->util_rt  = cpu_util_rt(rq);
-	sg_cpu->util_irq = cpu_util_irq(rq);
-}
-
-static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
-{
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util, max = sg_cpu->max;
+	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
 	if (rt_rq_is_runnable(&rq->rt))
-		return sg_cpu->max;
+		return max;
+
+	irq = cpu_util_irq(rq);
 
-	if (unlikely(sg_cpu->util_irq >= max))
+	if (unlikely(irq >= max))
 		return max;
 
 	/* Sum rq utilization */
-	util = sg_cpu->util_cfs;
-	util += sg_cpu->util_rt;
+	util = cpu_util_cfs(rq);
+	util += cpu_util_rt(rq);
 
 	/*
 	 * Interrupt time is not seen by RQS utilization so we can compare
 	 * them with the CPU capacity
 	 */
-	if ((util + sg_cpu->util_dl) >= max)
+	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
 	/*
@@ -231,11 +219,11 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 */
 
 	/* Weight RQS utilization to normal context window */
-	util *= (max - sg_cpu->util_irq);
+	util *= (max - irq);
 	util /= max;
 
 	/* Add interrupt utilization */
-	util += sg_cpu->util_irq;
+	util += irq;
 
 	/* Add DL bandwidth requirement */
 	util += sg_cpu->bw_dl;
@@ -418,9 +406,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	sugov_get_util(sg_cpu);
+	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	util = sugov_aggregate_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time, &util, &max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
@@ -459,9 +446,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 
-		sugov_get_util(j_sg_cpu);
+		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		j_util = sugov_aggregate_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
 
 		if (j_util * max > j_max * util) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b2833e2b4b6a..061d51fb5b44 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2226,7 +2226,7 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
-	return rq->avg_rt.util_avg;
+	return READ_ONCE(rq->avg_rt.util_avg);
 }
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
