Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E371C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B665425C47
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="sqgk6u7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B665425C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbeFYPQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:16:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34624 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934808AbeFYPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id b20-v6so3009450qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zmIepUaxsY1+MKu+MGlwTIYfz/KcjqoIjcd/jTREdEM=;
        b=sqgk6u7eDv32XHNoqYQXieaGR72oE0ffT4TIuCryjFoqcggsMiRp2Xw03MZvJZ0RTc
         l+QRRpQWr4PPCWy91QZGgSu9QH3f7KLSAjlpd9fuzIyL/WdLPUwAjIQHr1RxnxayjTv1
         YD+f+fNzwrp6Lia/ov18q8Bsj4HDiyE2fwIjq93jtj65B0fi9f4d+ykeHW/2fgmpjnps
         Uj9AVPN8p2ciXM5HpG2ZJF0TZsgvvMf/Fmr3AKcBN4FJ7oWqnoLbuaLnbBUEoM+INwom
         lOhhJxhWSsqtj/wfsFH43psXujjYv4x3dxEFVDVdtJ2fIHHWZ/kqN2udgCP27Uh/vRS9
         G3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zmIepUaxsY1+MKu+MGlwTIYfz/KcjqoIjcd/jTREdEM=;
        b=eI0cxc9865ULy8tcXj/T+GDf+NUxnV5TWy2SCPBRU3fWJhapgnmP98RJ+LYLal4wpi
         RpuO5oHs44Yog0i7xcsUF4Au8gJbmMz11exTlt7QIARXBZoiMSgqGsXYMXkaNNy66G5Y
         wqe755al6RBdQvZCMcMvV2RUb/sjdn5mSTxhYrDtwZmqU/4zt8RXW1lb5Gy/u1OV/jqX
         lBTFK+I2Ew2/6YrlSpyzy69LINnEjLZRv4tjRwdk+n0cDCbbqTNXI/0+Okkt7A15fsD8
         r6WmIAjrhRnlE/8D3L1PVBXvpx4NdwzW2yvSI+KbeJo8VhRBfRS6RjeezEh8454B0q9S
         2caA==
X-Gm-Message-State: APt69E2M+TZUNu8nib5+c2fWjW/8acedabXKoQsClgvOCTIFuAR2SxUH
        sxvgkNydL5iWyPOxkIQM1GpeGQ==
X-Google-Smtp-Source: AAOMgpcizJqKefYj/ZQqVjqUGoy3K0ZpqqbM8yW34rGsoA3saRwbSXgfe3jJTKi1aN519w6aK2nfPw==
X-Received: by 2002:aed:37c2:: with SMTP id j60-v6mr11330759qtb.417.1529939574713;
        Mon, 25 Jun 2018 08:12:54 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g57-v6sm12526565qte.52.2018.06.25.08.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 06/15] blkcg: add generic throttling mechanism
Date:   Mon, 25 Jun 2018 11:12:34 -0400
Message-Id: <20180625151243.2132-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Since IO can be issued from literally anywhere it's almost impossible to
do throttling without having some sort of adverse effect somewhere else
in the system because of locking or other dependencies.  The best way to
solve this is to do the throttling when we know we aren't holding any
other kernel resources.  Do this by tracking throttling in a per-blkg
basis, and if we require throttling flag the task that it needs to check
before it returns to user space and possibly sleep there.

This is to address the case where a process is doing work that is
generating IO that can't be throttled, whether that is directly with a
lot of REQ_META IO, or indirectly by allocating so much memory that it
is swamping the disk with REQ_SWAP.  We can't use task_add_work as we
don't want to induce a memory allocation in the IO path, so simply
saving the request queue in the task and flagging it to do the
notify_resume thing achieves the same result without the overhead of a
memory allocation.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c          | 220 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h  |  99 ++++++++++++++++++++
 include/linux/cgroup-defs.h |   3 +
 include/linux/sched.h       |   8 ++
 include/linux/tracehook.h   |   2 +
 5 files changed, 332 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b3460f623fca..fd614c31ccd2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -27,6 +27,7 @@
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/blk-cgroup.h>
+#include <linux/tracehook.h>
 #include "blk.h"
 
 #define MAX_KEY_LEN 100
@@ -999,6 +1000,14 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		if (!blkcg_debug_stats)
 			goto next;
 
+		if (atomic_read(&blkg->use_delay)) {
+			has_stats = true;
+			off += scnprintf(buf+off, size-off,
+					 " use_delay=%d delay_nsec=%llu",
+					 atomic_read(&blkg->use_delay),
+					(unsigned long long)atomic64_read(&blkg->delay_nsec));
+		}
+
 		mutex_lock(&blkcg_pol_mutex);
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
@@ -1328,6 +1337,13 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
 	mutex_unlock(&blkcg_pol_mutex);
 }
 
+static void blkcg_exit(struct task_struct *tsk)
+{
+	if (tsk->throttle_queue)
+		blk_put_queue(tsk->throttle_queue);
+	tsk->throttle_queue = NULL;
+}
+
 struct cgroup_subsys io_cgrp_subsys = {
 	.css_alloc = blkcg_css_alloc,
 	.css_offline = blkcg_css_offline,
@@ -1337,6 +1353,7 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
 	.legacy_name = "blkio",
+	.exit = blkcg_exit,
 #ifdef CONFIG_MEMCG
 	/*
 	 * This ensures that, if available, memcg is automatically enabled
@@ -1588,5 +1605,208 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
+/*
+ * Scale the accumulated delay based on how long it has been since we updated
+ * the delay.  We only call this when we are adding delay, in case it's been a
+ * while since we added delay, and when we are checking to see if we need to
+ * delay a task, to account for any delays that may have occurred.
+ */
+static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
+{
+	u64 old = atomic64_read(&blkg->delay_start);
+
+	/*
+	 * We only want to scale down every second.  The idea here is that we
+	 * want to delay people for min(delay_nsec, NSEC_PER_SEC) in a certain
+	 * time window.  We only want to throttle tasks for recent delay that
+	 * has occurred, in 1 second time windows since that's the maximum
+	 * things can be throttled.  We save the current delay window in
+	 * blkg->last_delay so we know what amount is still left to be charged
+	 * to the blkg from this point onward.  blkg->last_use keeps track of
+	 * the use_delay counter.  The idea is if we're unthrottling the blkg we
+	 * are ok with whatever is happening now, and we can take away more of
+	 * the accumulated delay as we've already throttled enough that
+	 * everybody is happy with their IO latencies.
+	 */
+	if (time_before64(old + NSEC_PER_SEC, now) &&
+	    atomic64_cmpxchg(&blkg->delay_start, old, now) == old) {
+		u64 cur = atomic64_read(&blkg->delay_nsec);
+		u64 sub = min_t(u64, blkg->last_delay, now - old);
+		int cur_use = atomic_read(&blkg->use_delay);
+
+		/*
+		 * We've been unthrottled, subtract a larger chunk of our
+		 * accumulated delay.
+		 */
+		if (cur_use < blkg->last_use)
+			sub = max_t(u64, sub, blkg->last_delay >> 1);
+
+		/*
+		 * This shouldn't happen, but handle it anyway.  Our delay_nsec
+		 * should only ever be growing except here where we subtract out
+		 * min(last_delay, 1 second), but lord knows bugs happen and I'd
+		 * rather not end up with negative numbers.
+		 */
+		if (unlikely(cur < sub)) {
+			atomic64_set(&blkg->delay_nsec, 0);
+			blkg->last_delay = 0;
+		} else {
+			atomic64_sub(sub, &blkg->delay_nsec);
+			blkg->last_delay = cur - sub;
+		}
+		blkg->last_use = cur_use;
+	}
+}
+
+/*
+ * This is called when we want to actually walk up the hierarchy and check to
+ * see if we need to throttle, and then actually throttle if there is some
+ * accumulated delay.  This should only be called upon return to user space so
+ * we're not holding some lock that would induce a priority inversion.
+ */
+static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
+{
+	u64 now = ktime_to_ns(ktime_get());
+	u64 exp;
+	u64 delay_nsec = 0;
+	int tok;
+
+	while (blkg->parent) {
+		if (atomic_read(&blkg->use_delay)) {
+			blkcg_scale_delay(blkg, now);
+			delay_nsec = max_t(u64, delay_nsec,
+					   atomic64_read(&blkg->delay_nsec));
+		}
+		blkg = blkg->parent;
+	}
+
+	if (!delay_nsec)
+		return;
+
+	/*
+	 * Let's not sleep for all eternity if we've amassed a huge delay.
+	 * Swapping or metadata IO can accumulate 10's of seconds worth of
+	 * delay, and we want userspace to be able to do _something_ so cap the
+	 * delays at 1 second.  If there's 10's of seconds worth of delay then
+	 * the tasks will be delayed for 1 second for every syscall.
+	 */
+	delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
+
+	/*
+	 * TODO: the use_memdelay flag is going to be for the upcoming psi stuff
+	 * that hasn't landed upstream yet.  Once that stuff is in place we need
+	 * to do a psi_memstall_enter/leave if memdelay is set.
+	 */
+
+	exp = ktime_add_ns(now, delay_nsec);
+	tok = io_schedule_prepare();
+	do {
+		__set_current_state(TASK_KILLABLE);
+		if (!schedule_hrtimeout(&exp, HRTIMER_MODE_ABS))
+			break;
+	} while (!fatal_signal_pending(current));
+	io_schedule_finish(tok);
+}
+
+/**
+ * blkcg_maybe_throttle_current - throttle the current task if it has been marked
+ *
+ * This is only called if we've been marked with set_notify_resume().  Obviously
+ * we can be set_notify_resume() for reasons other than blkcg throttling, so we
+ * check to see if current->throttle_queue is set and if not this doesn't do
+ * anything.  This should only ever be called by the resume code, it's not meant
+ * to be called by people willy-nilly as it will actually do the work to
+ * throttle the task if it is setup for throttling.
+ */
+void blkcg_maybe_throttle_current(void)
+{
+	struct request_queue *q = current->throttle_queue;
+	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
+	struct blkcg_gq *blkg;
+	bool use_memdelay = current->use_memdelay;
+
+	if (!q)
+		return;
+
+	current->throttle_queue = NULL;
+	current->use_memdelay = false;
+
+	rcu_read_lock();
+	css = kthread_blkcg();
+	if (css)
+		blkcg = css_to_blkcg(css);
+	else
+		blkcg = css_to_blkcg(task_css(current, io_cgrp_id));
+
+	if (!blkcg)
+		goto out;
+	blkg = blkg_lookup(blkcg, q);
+	if (!blkg)
+		goto out;
+	blkg = blkg_try_get(blkg);
+	if (!blkg)
+		goto out;
+	rcu_read_unlock();
+	blk_put_queue(q);
+
+	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
+	blkg_put(blkg);
+	return;
+out:
+	rcu_read_unlock();
+	blk_put_queue(q);
+}
+EXPORT_SYMBOL_GPL(blkcg_maybe_throttle_current);
+
+/**
+ * blkcg_schedule_throttle - this task needs to check for throttling
+ * @q - the request queue IO was submitted on
+ * @use_memdelay - do we charge this to memory delay for PSI
+ *
+ * This is called by the IO controller when we know there's delay accumulated
+ * for the blkg for this task.  We do not pass the blkg because there are places
+ * we call this that may not have that information, the swapping code for
+ * instance will only have a request_queue at that point.  This set's the
+ * notify_resume for the task to check and see if it requires throttling before
+ * returning to user space.
+ *
+ * We will only schedule once per syscall.  You can call this over and over
+ * again and it will only do the check once upon return to user space, and only
+ * throttle once.  If the task needs to be throttled again it'll need to be
+ * re-set at the next time we see the task.
+ */
+void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
+{
+	if (unlikely(current->flags & PF_KTHREAD))
+		return;
+
+	if (!blk_get_queue(q))
+		return;
+
+	if (current->throttle_queue)
+		blk_put_queue(current->throttle_queue);
+	current->throttle_queue = q;
+	if (use_memdelay)
+		current->use_memdelay = use_memdelay;
+	set_notify_resume(current);
+}
+EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
+
+/**
+ * blkcg_add_delay - add delay to this blkg
+ * @now - the current time in nanoseconds
+ * @delta - how many nanoseconds of delay to add
+ *
+ * Charge @delta to the blkg's current delay accumulation.  This is used to
+ * throttle tasks if an IO controller thinks we need more throttling.
+ */
+void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
+{
+	blkcg_scale_delay(blkg, now);
+	atomic64_add(delta, &blkg->delay_nsec);
+}
+EXPORT_SYMBOL_GPL(blkcg_add_delay);
+
 module_param(blkcg_debug_stats, bool, 0644);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a8f9ba8f33a4..1e67dea7e418 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -136,6 +136,12 @@ struct blkcg_gq {
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
 
 	struct rcu_head			rcu_head;
+
+	atomic_t			use_delay;
+	atomic64_t			delay_nsec;
+	atomic64_t			delay_start;
+	u64				last_delay;
+	int				last_use;
 };
 
 typedef struct blkcg_policy_data *(blkcg_pol_alloc_cpd_fn)(gfp_t gfp);
@@ -241,6 +247,26 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+static inline bool blk_cgroup_congested(void)
+{
+	struct cgroup_subsys_state *css;
+	bool ret = false;
+
+	rcu_read_lock();
+	css = kthread_blkcg();
+	if (!css)
+		css = task_css(current, io_cgrp_id);
+	while (css) {
+		if (atomic_read(&css->cgroup->congestion_count)) {
+			ret = true;
+			break;
+		}
+		css = css->parent;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
  * @return: true if this bio needs to be submitted with the root blkg context.
@@ -374,6 +400,21 @@ static inline void blkg_get(struct blkcg_gq *blkg)
 	atomic_inc(&blkg->refcnt);
 }
 
+/**
+ * blkg_try_get - try and get a blkg reference
+ * @blkg: blkg to get
+ *
+ * This is for use when doing an RCU lookup of the blkg.  We may be in the midst
+ * of freeing this blkg, so we can only use it if the refcnt is not zero.
+ */
+static inline struct blkcg_gq *blkg_try_get(struct blkcg_gq *blkg)
+{
+	if (atomic_inc_not_zero(&blkg->refcnt))
+		return blkg;
+	return NULL;
+}
+
+
 void __blkg_release_rcu(struct rcu_head *rcu);
 
 /**
@@ -734,6 +775,59 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	return !throtl;
 }
 
+static inline void blkcg_use_delay(struct blkcg_gq *blkg)
+{
+	if (atomic_add_return(1, &blkg->use_delay) == 1)
+		atomic_inc(&blkg->blkcg->css.cgroup->congestion_count);
+}
+
+static inline int blkcg_unuse_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+
+	if (old == 0)
+		return 0;
+
+	/*
+	 * We do this song and dance because we can race with somebody else
+	 * adding or removing delay.  If we just did an atomic_dec we'd end up
+	 * negative and we'd already be in trouble.  We need to subtract 1 and
+	 * then check to see if we were the last delay so we can drop the
+	 * congestion count on the cgroup.
+	 */
+	while (old) {
+		int cur = atomic_cmpxchg(&blkg->use_delay, old, old - 1);
+		if (cur == old)
+			break;
+		old = cur;
+	}
+
+	if (old == 0)
+		return 0;
+	if (old == 1)
+		atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+	return 1;
+}
+
+static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
+{
+	int old = atomic_read(&blkg->use_delay);
+	if (!old)
+		return;
+	/* We only want 1 person clearing the congestion count for this blkg. */
+	while (old) {
+		int cur = atomic_cmpxchg(&blkg->use_delay, old, 0);
+		if (cur == old) {
+			atomic_dec(&blkg->blkcg->css.cgroup->congestion_count);
+			break;
+		}
+		old = cur;
+	}
+}
+
+void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
+void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
+void blkcg_maybe_throttle_current(void);
 #else	/* CONFIG_BLK_CGROUP */
 
 struct blkcg {
@@ -753,8 +847,12 @@ struct blkcg_policy {
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
 
+static inline void blkcg_maybe_throttle_current(void) { }
+
 #ifdef CONFIG_BLOCK
 
+static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
+
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_drain_queue(struct request_queue *q) { }
@@ -783,6 +881,7 @@ static inline struct request_list *blk_rq_rl(struct request *rq) { return &rq->q
 
 static inline bool blkcg_bio_issue_check(struct request_queue *q,
 					 struct bio *bio) { return true; }
+static inline bool blk_cgroup_congested(void) { return false; }
 
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index dc5b70449dc6..b3ab17d53f3d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -427,6 +427,9 @@ struct cgroup {
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
 
+	/* If there is block congestion on this cgroup. */
+	atomic_t congestion_count;
+
 	/* ids of the ancestors at each level including self */
 	int ancestor_ids[];
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..6fe0d3c1409b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -693,6 +693,10 @@ struct task_struct {
 	/* disallow userland-initiated cgroup migration */
 	unsigned			no_cgroup_migration:1;
 #endif
+#ifdef CONFIG_BLK_CGROUP
+	/* to be used once the psi infrastructure lands upstream. */
+	unsigned			use_memdelay:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
@@ -1099,6 +1103,10 @@ struct task_struct {
 	unsigned int			memcg_nr_pages_over_high;
 #endif
 
+#ifdef CONFIG_BLK_CGROUP
+	struct request_queue		*throttle_queue;
+#endif
+
 #ifdef CONFIG_UPROBES
 	struct uprobe_task		*utask;
 #endif
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 26c152122a42..4e24930306b9 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -51,6 +51,7 @@
 #include <linux/security.h>
 #include <linux/task_work.h>
 #include <linux/memcontrol.h>
+#include <linux/blk-cgroup.h>
 struct linux_binprm;
 
 /*
@@ -191,6 +192,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 		task_work_run();
 
 	mem_cgroup_handle_over_high();
+	blkcg_maybe_throttle_current();
 }
 
 #endif	/* <linux/tracehook.h> */
-- 
2.14.3

