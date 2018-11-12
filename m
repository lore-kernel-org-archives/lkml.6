Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44700C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461821780
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1461821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbeKLP4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:56:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38173 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:56:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC64Ts93548559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:04:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC64T5B3548556;
        Sun, 11 Nov 2018 22:04:29 -0800
Date:   Sun, 11 Nov 2018 22:04:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-1da1843f9f0334e2428308945d396ffecc2acfe1@git.kernel.org>
Cc:     vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, daniel.lezcano@linaro.org, hpa@zytor.com
Reply-To: hpa@zytor.com, daniel.lezcano@linaro.org, peterz@infradead.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, vincent.guittot@linaro.org,
          viresh.kumar@linaro.org, mingo@kernel.org
In-Reply-To: <ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org>
References: <ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Create task_has_idle_policy() helper
Git-Commit-ID: 1da1843f9f0334e2428308945d396ffecc2acfe1
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

Commit-ID:  1da1843f9f0334e2428308945d396ffecc2acfe1
Gitweb:     https://git.kernel.org/tip/1da1843f9f0334e2428308945d396ffecc2acfe1
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Mon, 5 Nov 2018 16:51:55 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 06:17:52 +0100

sched/core: Create task_has_idle_policy() helper

We already have task_has_rt_policy() and task_has_dl_policy() helpers,
create task_has_idle_policy() as well and update sched core to start
using it.

While at it, use task_has_dl_policy() at one more place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/debug.c |  2 +-
 kernel/sched/fair.c  | 10 +++++-----
 kernel/sched/sched.h |  5 +++++
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02a20ef196a6..5afb868f7339 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -697,7 +697,7 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	/*
 	 * SCHED_IDLE tasks get minimal weight:
 	 */
-	if (idle_policy(p->policy)) {
+	if (task_has_idle_policy(p)) {
 		load->weight = scale_load(WEIGHT_IDLEPRIO);
 		load->inv_weight = WMULT_IDLEPRIO;
 		p->se.runnable_weight = load->weight;
@@ -4199,7 +4199,7 @@ recheck:
 		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
 		 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
 		 */
-		if (idle_policy(p->policy) && !idle_policy(policy)) {
+		if (task_has_idle_policy(p) && !idle_policy(policy)) {
 			if (!can_nice(p, task_nice(p)))
 				return -EPERM;
 		}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 6383aa6a60ca..02bd5f969b21 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -974,7 +974,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	if (p->policy == SCHED_DEADLINE) {
+	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2cac9a469df4..d1f91e6efe51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6529,7 +6529,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 
 static void set_last_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
+	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
 	for_each_sched_entity(se) {
@@ -6541,7 +6541,7 @@ static void set_last_buddy(struct sched_entity *se)
 
 static void set_next_buddy(struct sched_entity *se)
 {
-	if (entity_is_task(se) && unlikely(task_of(se)->policy == SCHED_IDLE))
+	if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(se))))
 		return;
 
 	for_each_sched_entity(se) {
@@ -6599,8 +6599,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(curr->policy == SCHED_IDLE) &&
-	    likely(p->policy != SCHED_IDLE))
+	if (unlikely(task_has_idle_policy(curr)) &&
+	    likely(!task_has_idle_policy(p)))
 		goto preempt;
 
 	/*
@@ -7021,7 +7021,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (p->sched_class != &fair_sched_class)
 		return 0;
 
-	if (unlikely(p->policy == SCHED_IDLE))
+	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577fc9aa8..b7a3147874e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -176,6 +176,11 @@ static inline bool valid_policy(int policy)
 		rt_policy(policy) || dl_policy(policy);
 }
 
+static inline int task_has_idle_policy(struct task_struct *p)
+{
+	return idle_policy(p->policy);
+}
+
 static inline int task_has_rt_policy(struct task_struct *p)
 {
 	return rt_policy(p->policy);
