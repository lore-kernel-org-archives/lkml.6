Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7290AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBFE20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBFE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeLKPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:37:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:37:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFbFsG4043231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:37:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFbFSN4043228;
        Tue, 11 Dec 2018 07:37:15 -0800
Date:   Tue, 11 Dec 2018 07:37:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-630246a06ae2a7a12d1fce85f1e5681032982791@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, quentin.perret@arm.com, valentin.schneider@arm.com,
        efault@gmx.de
Reply-To: efault@gmx.de, valentin.schneider@arm.com,
          quentin.perret@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org
In-Reply-To: <20181203095628.11858-12-quentin.perret@arm.com>
References: <20181203095628.11858-12-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Clean-up update_sg_lb_stats parameters
Git-Commit-ID: 630246a06ae2a7a12d1fce85f1e5681032982791
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

Commit-ID:  630246a06ae2a7a12d1fce85f1e5681032982791
Gitweb:     https://git.kernel.org/tip/630246a06ae2a7a12d1fce85f1e5681032982791
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:24 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:01 +0100

sched/fair: Clean-up update_sg_lb_stats parameters

In preparation for the introduction of a new root domain flag which can
be set during load balance (the 'overutilized' flag), clean-up the set
of parameters passed to update_sg_lb_stats(). More specifically, the
'local_group' and 'local_idx' parameters can be removed since they can
easily be reconstructed from within the function.

While at it, transform the 'overload' parameter into a flag stored in
the 'sg_status' parameter hence facilitating the definition of new flags
when needed.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-12-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 27 +++++++++++----------------
 kernel/sched/sched.h |  3 +++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a31a6d325901..e04f29098ec7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7905,16 +7905,16 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
  * @group: sched_group whose statistics are to be updated.
- * @load_idx: Load index of sched_domain of this_cpu for load calc.
- * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate pullable load (e.g. >1 runnable task).
+ * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
-			struct sched_group *group, int load_idx,
-			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+				      struct sched_group *group,
+				      struct sg_lb_stats *sgs,
+				      int *sg_status)
 {
+	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	int load_idx = get_sd_load_idx(env->sd, env->idle);
 	unsigned long load;
 	int i, nr_running;
 
@@ -7938,7 +7938,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*sg_status |= SG_OVERLOAD;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -7954,7 +7954,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
-			*overload = 1;
+			*sg_status |= SG_OVERLOAD;
 		}
 	}
 
@@ -8099,17 +8099,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx;
-	bool overload = false;
 	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	int sg_status = 0;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
 		env->flags |= LBF_NOHZ_STATS;
 #endif
 
-	load_idx = get_sd_load_idx(env->sd, env->idle);
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8124,8 +8121,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+		update_sg_lb_stats(env, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
@@ -8175,8 +8171,7 @@ next_group:
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != overload)
-			WRITE_ONCE(env->dst_rq->rd->overload, overload);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 	}
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2b3cf356e958..d4d984846924 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -716,6 +716,9 @@ struct perf_domain {
 	struct rcu_head rcu;
 };
 
+/* Scheduling group status flags */
+#define SG_OVERLOAD		0x1 /* More than one runnable task on a CPU. */
+
 /*
  * We add the notion of a root-domain which will be used to define per-domain
  * variables. Each exclusive cpuset essentially defines an island domain by
