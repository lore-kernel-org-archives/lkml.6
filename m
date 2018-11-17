Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D615E20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHtzQs2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D615E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeKQVOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:14:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33110 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeKQVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:14:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so27325434wrr.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pKbvBWfHFvjJKzeOPV5U0u8y+E58jxx3hZqtIY2M0s0=;
        b=MHtzQs2cyOuOF7GbmQ5olbpX1b9n0Qi28mUhCNkTgGxivT+cyv3i4L86bnhhl9KpkL
         tJepAXuH64J0P9pHLNP16FtAAK90SiHjqQ1Zig8oaENEi3YzbyCvXjmOy0tfFigEcxIW
         G8yPoEToOJjYEVLiFhMMItfd8aKXzgUu1qkJsv3TnrMeqA5CrUxj1wAHScc/tDvkjuE/
         7p/lqhXK3Zt0n4aAEZ+8aiH4y223IsJMRJnW8YcVZSnn0Pow77V4L/WCNIhBF8k+Dkp6
         zzT3mSlx9XhiTU5hhxNaTMVHnAHZHjHLwuut8AH4DxUjRkKRS2Hb5GI+enY9nZoiFudO
         2VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=pKbvBWfHFvjJKzeOPV5U0u8y+E58jxx3hZqtIY2M0s0=;
        b=d92+kuEO96tUOkIJG3exvmcwHFy/2iSqcuyD+/Y/2FZwiDkoDAM8vyzhkOGf/CJXl8
         tHO5qcw9QTUysj3clxCcxvpPHhaQbBsLxAXGEN+fnuBBeSWQaaoIDQJlEe8voaBTsiSj
         s7ZMz1jYBE4ZFaq1Tp0FJDGOsEyZWX2gIuu+rpIkFQQahRn1KRnH5pKB8FsvdT0hoLAN
         qKq/KMrIgBanaq7ub5vTVpF0R0wsx6Belfk8sT5lsIGIijMvo6nxoE7J+oCZ7j6LBsWt
         EP+nsyTp7TF6G+yonzipyptCdEepDIY2H8VdkHNxv7KUKaWerwUJtZHTEGMDNfubOhlP
         yNPA==
X-Gm-Message-State: AGRZ1gK3Yi5kR4daqcCieOTrJqJbTtzconar1/+YwsRoBqgtHmVxVkQZ
        rXsOTgiJmvsCtqQjz3Xma5w=
X-Google-Smtp-Source: AJdET5cJgl+vpxsK/ujl2TT+wmxPX60yjzujuArLJqtnPpuZJnm3Vw+G9sDgelyUuDQEn4I2FIS+tg==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr12648941wrn.257.1542452280770;
        Sat, 17 Nov 2018 02:58:00 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 78-v6sm13905638wma.30.2018.11.17.02.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 02:58:00 -0800 (PST)
Date:   Sat, 17 Nov 2018 11:57:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20181117105757.GA40115@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: c469933e772132aad040bd6a2adc8edf9ad6f825 sched/fair: Fix cpu_util_wake() for 'execl' type workloads

Fix an exec() related scalability/performance regression, which was 
caused by incorrectly calculating load and migrating tasks on exec() when 
they shouldn't be.

 Thanks,

	Ingo

------------------>
Patrick Bellasi (1):
      sched/fair: Fix cpu_util_wake() for 'execl' type workloads


 kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3648d0300fdf..ac855b2f4774 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5674,11 +5674,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return target;
 }
 
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
+static unsigned long cpu_util_without(int cpu, struct task_struct *p);
 
-static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
+static unsigned long capacity_spare_without(int cpu, struct task_struct *p)
 {
-	return max_t(long, capacity_of(cpu) - cpu_util_wake(cpu, p), 0);
+	return max_t(long, capacity_of(cpu) - cpu_util_without(cpu, p), 0);
 }
 
 /*
@@ -5738,7 +5738,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
 
-			spare_cap = capacity_spare_wake(i, p);
+			spare_cap = capacity_spare_without(i, p);
 
 			if (spare_cap > max_spare_cap)
 				max_spare_cap = spare_cap;
@@ -5889,8 +5889,8 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 		return prev_cpu;
 
 	/*
-	 * We need task's util for capacity_spare_wake, sync it up to prev_cpu's
-	 * last_update_time.
+	 * We need task's util for capacity_spare_without, sync it up to
+	 * prev_cpu's last_update_time.
 	 */
 	if (!(sd_flag & SD_BALANCE_FORK))
 		sync_entity_load_avg(&p->se);
@@ -6216,10 +6216,19 @@ static inline unsigned long cpu_util(int cpu)
 }
 
 /*
- * cpu_util_wake: Compute CPU utilization with any contributions from
- * the waking task p removed.
+ * cpu_util_without: compute cpu utilization without any contributions from *p
+ * @cpu: the CPU which utilization is requested
+ * @p: the task which utilization should be discounted
+ *
+ * The utilization of a CPU is defined by the utilization of tasks currently
+ * enqueued on that CPU as well as tasks which are currently sleeping after an
+ * execution on that CPU.
+ *
+ * This method returns the utilization of the specified CPU by discounting the
+ * utilization of the specified task, whenever the task is currently
+ * contributing to the CPU utilization.
  */
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
+static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	struct cfs_rq *cfs_rq;
 	unsigned int util;
@@ -6231,7 +6240,7 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	cfs_rq = &cpu_rq(cpu)->cfs;
 	util = READ_ONCE(cfs_rq->avg.util_avg);
 
-	/* Discount task's blocked util from CPU's util */
+	/* Discount task's util from CPU's util */
 	util -= min_t(unsigned int, util, task_util(p));
 
 	/*
@@ -6240,14 +6249,14 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	 * a) if *p is the only task sleeping on this CPU, then:
 	 *      cpu_util (== task_util) > util_est (== 0)
 	 *    and thus we return:
-	 *      cpu_util_wake = (cpu_util - task_util) = 0
+	 *      cpu_util_without = (cpu_util - task_util) = 0
 	 *
 	 * b) if other tasks are SLEEPING on this CPU, which is now exiting
 	 *    IDLE, then:
 	 *      cpu_util >= task_util
 	 *      cpu_util > util_est (== 0)
 	 *    and thus we discount *p's blocked utilization to return:
-	 *      cpu_util_wake = (cpu_util - task_util) >= 0
+	 *      cpu_util_without = (cpu_util - task_util) >= 0
 	 *
 	 * c) if other tasks are RUNNABLE on that CPU and
 	 *      util_est > cpu_util
@@ -6260,8 +6269,33 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 	 * covered by the following code when estimated utilization is
 	 * enabled.
 	 */
-	if (sched_feat(UTIL_EST))
-		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
+	if (sched_feat(UTIL_EST)) {
+		unsigned int estimated =
+			READ_ONCE(cfs_rq->avg.util_est.enqueued);
+
+		/*
+		 * Despite the following checks we still have a small window
+		 * for a possible race, when an execl's select_task_rq_fair()
+		 * races with LB's detach_task():
+		 *
+		 *   detach_task()
+		 *     p->on_rq = TASK_ON_RQ_MIGRATING;
+		 *     ---------------------------------- A
+		 *     deactivate_task()                   \
+		 *       dequeue_task()                     + RaceTime
+		 *         util_est_dequeue()              /
+		 *     ---------------------------------- B
+		 *
+		 * The additional check on "current == p" it's required to
+		 * properly fix the execl regression and it helps in further
+		 * reducing the chances for the above race.
+		 */
+		if (unlikely(task_on_rq_queued(p) || current == p)) {
+			estimated -= min_t(unsigned int, estimated,
+					   (_task_util_est(p) | UTIL_AVG_UNCHANGED));
+		}
+		util = max(util, estimated);
+	}
 
 	/*
 	 * Utilization (estimated) can exceed the CPU capacity, thus let's
