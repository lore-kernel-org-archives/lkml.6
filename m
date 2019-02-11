Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7AA20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBKKtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:49:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfBKKtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:49:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAmt803498530
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:48:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAmtPl3498527;
        Mon, 11 Feb 2019 02:48:55 -0800
Date:   Mon, 11 Feb 2019 02:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-d0fe0b9c45c144e4ac60cf7f07f7e8ae86d3536d@git.kernel.org>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, quentin.perret@arm.com,
        morten.rasmussen@arm.com, valentin.schneider@arm.com,
        torvalds@linux-foundation.org, patrick.bellasi@arm.com
Reply-To: vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, dietmar.eggemann@arm.com, mingo@kernel.org,
          hpa@zytor.com, morten.rasmussen@arm.com, quentin.perret@arm.com,
          tglx@linutronix.de, valentin.schneider@arm.com,
          patrick.bellasi@arm.com, torvalds@linux-foundation.org
In-Reply-To: <20190122162501.12000-1-dietmar.eggemann@arm.com>
References: <20190122162501.12000-1-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Simplify post_init_entity_util_avg()
 by calling it with a task_struct pointer argument
Git-Commit-ID: d0fe0b9c45c144e4ac60cf7f07f7e8ae86d3536d
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

Commit-ID:  d0fe0b9c45c144e4ac60cf7f07f7e8ae86d3536d
Gitweb:     https://git.kernel.org/tip/d0fe0b9c45c144e4ac60cf7f07f7e8ae86d3536d
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Tue, 22 Jan 2019 16:25:01 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:14 +0100

sched/fair: Simplify post_init_entity_util_avg() by calling it with a task_struct pointer argument

Since commit:

  d03266910a53 ("sched/fair: Fix task group initialization")

the utilization of a sched entity representing a task group is no longer
initialized to any other value than 0. So post_init_entity_util_avg() is
only used for tasks, not for sched_entities.

Make this clear by calling it with a task_struct pointer argument which
also eliminates the entity_is_task(se) if condition in the fork path and
get rid of the stale comment in remove_entity_load_avg() accordingly.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20190122162501.12000-1-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 38 ++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e86e2b8f6922..6b2c055564b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2433,7 +2433,7 @@ void wake_up_new_task(struct task_struct *p)
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
-	post_init_entity_util_avg(&p->se);
+	post_init_entity_util_avg(p);
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	p->on_rq = TASK_ON_RQ_QUEUED;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 17a961522d1e..58edbbdeb661 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -759,8 +759,9 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
  * Finally, that extrapolated util_avg is clamped to the cap (util_avg_cap)
  * if util_avg > util_avg_cap.
  */
-void post_init_entity_util_avg(struct sched_entity *se)
+void post_init_entity_util_avg(struct task_struct *p)
 {
+	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
 	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
@@ -778,22 +779,19 @@ void post_init_entity_util_avg(struct sched_entity *se)
 		}
 	}
 
-	if (entity_is_task(se)) {
-		struct task_struct *p = task_of(se);
-		if (p->sched_class != &fair_sched_class) {
-			/*
-			 * For !fair tasks do:
-			 *
-			update_cfs_rq_load_avg(now, cfs_rq);
-			attach_entity_load_avg(cfs_rq, se, 0);
-			switched_from_fair(rq, p);
-			 *
-			 * such that the next switched_to_fair() has the
-			 * expected state.
-			 */
-			se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
-			return;
-		}
+	if (p->sched_class != &fair_sched_class) {
+		/*
+		 * For !fair tasks do:
+		 *
+		update_cfs_rq_load_avg(now, cfs_rq);
+		attach_entity_load_avg(cfs_rq, se, 0);
+		switched_from_fair(rq, p);
+		 *
+		 * such that the next switched_to_fair() has the
+		 * expected state.
+		 */
+		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
+		return;
 	}
 
 	attach_entity_cfs_rq(se);
@@ -803,7 +801,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 void init_entity_runnable_average(struct sched_entity *se)
 {
 }
-void post_init_entity_util_avg(struct sched_entity *se)
+void post_init_entity_util_avg(struct task_struct *p)
 {
 }
 static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
@@ -3590,10 +3588,6 @@ void remove_entity_load_avg(struct sched_entity *se)
 	 * tasks cannot exit without having gone through wake_up_new_task() ->
 	 * post_init_entity_util_avg() which will have added things to the
 	 * cfs_rq, so we can remove unconditionally.
-	 *
-	 * Similarly for groups, they will have passed through
-	 * post_init_entity_util_avg() before unregister_sched_fair_group()
-	 * calls this.
 	 */
 
 	sync_entity_load_avg(se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c688ef5012e5..71208b67e58a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1800,7 +1800,7 @@ extern void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
-extern void post_init_entity_util_avg(struct sched_entity *se);
+extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
