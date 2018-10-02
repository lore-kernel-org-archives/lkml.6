Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C97C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB45320645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB45320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJBQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:49:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:49:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A6KEK1915644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:06:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A6Kwb1915641;
        Tue, 2 Oct 2018 03:06:20 -0700
Date:   Tue, 2 Oct 2018 03:06:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-11d4afd4ff667f9b6178ee8c142c36cb78bd84db@git.kernel.org>
Cc:     mingo@kernel.org, miguel.ojeda.sandonis@gmail.com,
        peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@redhat.com, vincent.guittot@linaro.org,
        douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org
Reply-To: douly.fnst@cn.fujitsu.com, torvalds@linux-foundation.org,
          hpa@zytor.com, vincent.guittot@linaro.org, mingo@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, peterz@infradead.org,
          miguel.ojeda.sandonis@gmail.com
In-Reply-To: <1537867062-27285-1-git-send-email-vincent.guittot@linaro.org>
References: <1537867062-27285-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/pelt: Fix warning and clean up IRQ PELT
 config
Git-Commit-ID: 11d4afd4ff667f9b6178ee8c142c36cb78bd84db
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

Commit-ID:  11d4afd4ff667f9b6178ee8c142c36cb78bd84db
Gitweb:     https://git.kernel.org/tip/11d4afd4ff667f9b6178ee8c142c36cb78bd84db
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 25 Sep 2018 11:17:42 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:45:00 +0200

sched/pelt: Fix warning and clean up IRQ PELT config

Create a config for enabling irq load tracking in the scheduler.
irq load tracking is useful only when irq or paravirtual time is
accounted but it's only possible with SMP for now.

Also use __maybe_unused to remove the compilation warning in
update_rq_clock_task() that has been introduced by:

  2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")

Suggested-by: Ingo Molnar <mingo@redhat.com>
Reported-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: dou_liyang@163.com
Fixes: 2e62c4743adc ("sched/fair: Remove #ifdefs from scale_rt_capacity()")
Link: http://lkml.kernel.org/r/1537867062-27285-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 init/Kconfig         | 5 +++++
 kernel/sched/core.c  | 7 +++----
 kernel/sched/fair.c  | 2 +-
 kernel/sched/pelt.c  | 2 +-
 kernel/sched/pelt.h  | 2 +-
 kernel/sched/sched.h | 5 ++---
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2f1cba..317d5ccb5191 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -415,6 +415,11 @@ config IRQ_TIME_ACCOUNTING
 
 	  If in doubt, say N here.
 
+config HAVE_SCHED_AVG_IRQ
+	def_bool y
+	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
+	depends on SMP
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	depends on MULTIUSER
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3ba5ec5..f2caf1bae4a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -135,9 +135,8 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
  * In theory, the compile should just see 0 here, and optimize out the call
  * to sched_rt_avg_update. But I don't trust it...
  */
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	s64 steal = 0, irq_delta = 0;
-#endif
+	s64 __maybe_unused steal = 0, irq_delta = 0;
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	irq_delta = irq_time_read(cpu_of(rq)) - rq->prev_irq_time;
 
@@ -177,7 +176,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d92ed2eca8b..d59307ecd67d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7317,7 +7317,7 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
 #endif
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0c5419..48a126486435 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -358,7 +358,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
  *
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index d2894db28955..7e56b489ff32 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,7 +6,7 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
 #else
 static inline int
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 632804fa0b12..798b1afd5092 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -862,8 +862,7 @@ struct rq {
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-#define HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
 	u64			idle_stamp;
@@ -2223,7 +2222,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 }
 #endif
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
