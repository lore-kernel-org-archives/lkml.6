Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412BDECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EDD20840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EDD20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeGOX7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:59:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54559 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:59:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNYAeb922192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:34:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNYAum922189;
        Sun, 15 Jul 2018 16:34:10 -0700
Date:   Sun, 15 Jul 2018 16:34:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-45f5519ec55e75af3565dd737586d3b041834f71@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
          vincent.guittot@linaro.org
In-Reply-To: <20180705123617.GM2458@hirez.programming.kicks-ass.net>
References: <20180705123617.GM2458@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Clarify sugov_get_util()
Git-Commit-ID: 45f5519ec55e75af3565dd737586d3b041834f71
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

Commit-ID:  45f5519ec55e75af3565dd737586d3b041834f71
Gitweb:     https://git.kernel.org/tip/45f5519ec55e75af3565dd737586d3b041834f71
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 5 Jul 2018 14:36:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:16:29 +0200

sched/cpufreq: Clarify sugov_get_util()

Add a few comments to (hopefully) clarifying some of the magic in
sugov_get_util().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
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
Link: http://lkml.kernel.org/r/20180705123617.GM2458@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 75 +++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c9622b3f183d..97dcd4472a0e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -177,6 +177,26 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
@@ -188,47 +208,60 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	if (rt_rq_is_runnable(&rq->rt))
 		return max;
 
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
 	irq = cpu_util_irq(rq);
-
 	if (unlikely(irq >= max))
 		return max;
 
-	/* Sum rq utilization */
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 */
 	util = cpu_util_cfs(rq);
 	util += cpu_util_rt(rq);
 
 	/*
-	 * Interrupt time is not seen by RQS utilization so we can compare
-	 * them with the CPU capacity
+	 * We do not make cpu_util_dl() a permanent part of this sum because we
+	 * want to use cpu_bw_dl() later on, but we need to check if the
+	 * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
+	 * f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
 	 */
 	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
 	/*
-	 * As there is still idle time on the CPU, we need to compute the
-	 * utilization level of the CPU.
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
 	 *
+	 *              1 - irq
+	 *   U' = irq + ------- * U
+	 *                max
+	 */
+	util *= (max - irq);
+	util /= max;
+	util += irq;
+
+	/*
 	 * Bandwidth required by DEADLINE must always be granted while, for
 	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
 	 * to gracefully reduce the frequency when no tasks show up for longer
 	 * periods of time.
 	 *
-	 * Ideally we would like to set util_dl as min/guaranteed freq and
-	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
-	 * ready for such an interface. So, we only do the latter for now.
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
 	 */
-
-	/* Weight RQS utilization to normal context window */
-	util *= (max - irq);
-	util /= max;
-
-	/* Add interrupt utilization */
-	util += irq;
-
-	/* Add DL bandwidth requirement */
-	util += sg_cpu->bw_dl;
-
-	return min(max, util);
+	return min(max, util + sg_cpu->bw_dl);
 }
 
 /**
