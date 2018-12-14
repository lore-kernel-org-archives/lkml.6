Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78942C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40D1208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeLNWMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:12:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730909AbeLNWMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:12:01 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MeknF-1h6Rg20aGL-00amXY; Fri, 14 Dec 2018 23:11:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        dou_liyang@163.com, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] sched/pelt: Fix warning and clean up IRQ PELT config
Date:   Fri, 14 Dec 2018 23:10:06 +0100
Message-Id: <20181214221023.3878670-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214221023.3878670-1-arnd@arndb.de>
References: <20181214221023.3878670-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:57FGmNaiHLQwFjePeSA3gvj7+nUCyrD3AuRVyPYLmqzk3gaOp/t
 /AB9s5LN/3QCiofnr46yXNd5asuNSH04HyqdG/MLjNm70I1nQ5YOgfMViHAXSX2VUqUMWO8
 mrlf+kZlrfbRc4g1IwA0LzyJuNdYaskhc+Je3ATGR+L4plbbotN43Gm6hKQhbvt5zVSR9Lz
 lW5Sgzu3pa7nFUso31Zkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ab0W2afYI7E=:s57k89YB+OxybK5HdB+e4Y
 ejdT0dtNrsNufjnbBCPYRdxBZZKub7bEk71id8CYbDIFFkQxEqJOaVKrIsgoGn6q+EgmvAyJI
 EB5c+I+LA1+JYKfeF5hNDjHthV7+uEpm2KkHFKU4sKupfpIpE4fQ2CgPSAaP9awDSe7yMTn/P
 rKLNOe5HzukJ5HvnB7aGOXEa4nDmPgFLqP/663k+DrD3pxRdAVsHnbDd7bs0RNxQCt9judD5/
 Cy3Tw32LhEksoB+pnhs4+wSlwO0FJa9aMdn7uczE582MnjEY0P5ucPS0SSeSX2s3VpdbHB4RP
 SqWXlD9b3sRdl/WetwK7TvQto7Y4vuuPmf/qviVUcQz6gVxL1qwMGq40zGzlltDFUjGPX8AEq
 rUqCKS3hiOcVJUesvrtWcxTmwn3AD4wdizlIfk4pnvosxqayUDz9T44GzqTdM3x09mpXfskJR
 mcBnJUmF73HQWutKihKt7RN9YIR/P1S7MHmDVSfWUVUuxxtJQ6p6jCAoMDYjUAh3zndGq0aWa
 zNLLLRj6qN6OK8IsO91yxrXL9O86YfINzeLYP6ueillCPdc7ByS5rrndZR6tbQhSo78/9ulqL
 mFFDJ/54crvkvobNOQqHjA2zADcZC6Hzi1HNLgPBosuRvYW33p3CM3Az5/IJQ14OtiUpdfVIs
 qzCINEwtCU58PHQVbB1nwb5Xy9e8BHPM+lg/tcJuHvKSpgr+bk5+/0s9RgJNSSJdKm/7mKG8k
 5qdIa+2y27LjhamsB7a5+eHhPdy2h20i6PTeig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

Commit 11d4afd4ff667f9b6178ee8c142c36cb78bd84db upstream.

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
index 2beda4b726e2..13ddfa46d741 100644
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
index 1162552dc3cc..eabbf6b10b44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7361,7 +7361,7 @@ static inline bool others_have_blocked(struct rq *rq)
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
index 6c25bbe87bd3..b63172288f7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -859,8 +859,7 @@ struct rq {
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-#define HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
 	u64			idle_stamp;
@@ -2215,7 +2214,7 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 }
 #endif
 
-#ifdef HAVE_SCHED_AVG_IRQ
+#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
-- 
2.20.0

