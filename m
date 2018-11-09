Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB90C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7243120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="XkmO9a+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7243120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeKITsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:46 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41167 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeKITsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so899393lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/xZwX59VgwfchdlkFQv6tw6l5QOBNTlmMwrv8ZRfk14=;
        b=XkmO9a+2e8j70DjlPMziN0kN0K7aWFlruQMnr/IILGQnBCkgDupMftRGLBBWN1Ja7S
         6i1u/TvZos24HDdhsGZWJVXLy5zvHvFwcgMDjQbZMA8k43fTmhjq7SSbqjAbd0Ln9ii0
         kTvn8HKCbjl5bs3QdxpEBlhXKCCfpWIiCNcM1YKPVXM0H6ScjeFZ45wVRcbjAagX9JAi
         sqHFeqiMm7wWpc6XxWBu2YM6SCOrQ4xvZtmiucGucGi+fHgtzrgUVHsgJR7eMescOcGT
         8EzAC3bHB04nEPk1/IcE+yqmO8D/4FH08KNNuGHnWvBMZoKPMPodwSd5Wnkqhes1MsJa
         /jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xZwX59VgwfchdlkFQv6tw6l5QOBNTlmMwrv8ZRfk14=;
        b=HOhjXXDvSW3wB8hVn05R0mWbANmIuoGSiCuPmqa9D6UpsdInOP2RupfPrj85kzcsfx
         CufN9KbNVr38xFtclLvOWXM4Rxm+2mQyCrBrz+1p1op2rYyoIe3jh1tlTDyAg9IGLCvX
         jFhtHCbkodHWusPovAjFkKeMhiW3vBsWjXRtfzCfxYKrs2/EGM7DeTgKeCeAZrVG3zsV
         0YdltLd2Ueg2s8SEOwzChEVWGBbU63+5iFRJzxkCjqgcx/JbQO6+1LZgMMdyUe2Xdwx8
         7EcV4bYAO4FUwkAyp7MzdSq0ZgVBKZ4bp7SzEu1O6DBZZlmPK5Axy9Kwg3awdGOdP0NP
         Cu1Q==
X-Gm-Message-State: AGRZ1gLA/+3x7xrP3C7w1YiTiA3aOdxIUUqoKoViHUjScnj56+5GKoC2
        o8hpB+ogTNqeJh1gMYuEVbV9wjQvtUAP2sFZ
X-Google-Smtp-Source: AJdET5fn7yimLwJPm02h/AkzH2QWsI8aTaFMdS1kBttc+q0jLWNreFtj3jsT71Os0fW5dskAoNnjKQ==
X-Received: by 2002:a19:a086:: with SMTP id j128mr4628222lfe.93.1541758085458;
        Fri, 09 Nov 2018 02:08:05 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:04 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 10/17] futex: Pull rt_mutex_futex_unlock() out from under hb->lock
Date:   Fri,  9 Nov 2018 11:07:38 +0100
Message-Id: <1541758065-10952-11-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 16ffa12d742534d4ff73e8b3a4e81c1de39196f0 upstream.

There's a number of 'interesting' problems, all caused by holding
hb->lock while doing the rt_mutex_unlock() equivalient.

Notably:

 - a PI inversion on hb->lock; and,

 - a SCHED_DEADLINE crash because of pointer instability.

The previous changes:

 - changed the locking rules to cover {uval,pi_state} with wait_lock.

 - allow to do rt_mutex_futex_unlock() without dropping wait_lock; which in
   turn allows to rely on wait_lock atomicity completely.

 - simplified the waiter conundrum.

It's now sufficient to hold rtmutex::wait_lock and a reference on the
pi_state to protect the state consistency, so hb->lock can be dropped
before calling rt_mutex_futex_unlock().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.900002056@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Conflicts:
	kernel/futex.c
Tested-by:Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 154 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 100 insertions(+), 54 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 09f698a..7054ca3 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -918,10 +918,12 @@ void exit_pi_state_list(struct task_struct *curr)
 		pi_state->owner = NULL;
 		raw_spin_unlock_irq(&curr->pi_lock);
 
-		rt_mutex_futex_unlock(&pi_state->pi_mutex);
-
+		get_pi_state(pi_state);
 		spin_unlock(&hb->lock);
 
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
@@ -1034,6 +1036,11 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	 * has dropped the hb->lock in between queue_me() and unqueue_me_pi(),
 	 * which in turn means that futex_lock_pi() still has a reference on
 	 * our pi_state.
+	 *
+	 * The waiter holding a reference on @pi_state also protects against
+	 * the unlocked put_pi_state() in futex_unlock_pi(), futex_lock_pi()
+	 * and futex_wait_requeue_pi() as it cannot go to 0 and consequently
+	 * free pi_state before we can take a reference ourselves.
 	 */
 	WARN_ON(!atomic_read(&pi_state->refcount));
 
@@ -1377,48 +1384,40 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	smp_store_release(&q->lock_ptr, NULL);
 }
 
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter,
-			 struct futex_hash_bucket *hb)
+/*
+ * Caller must hold a reference on @pi_state.
+ */
+static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
-	struct task_struct *new_owner;
-	struct futex_pi_state *pi_state = top_waiter->pi_state;
 	u32 uninitialized_var(curval), newval;
+	struct task_struct *new_owner;
+	bool deboost = false;
 	WAKE_Q(wake_q);
-	bool deboost;
 	int ret = 0;
 
-	if (!pi_state)
-		return -EINVAL;
-
-	/*
-	 * If current does not own the pi_state then the futex is
-	 * inconsistent and user space fiddled with the futex value.
-	 */
-	if (pi_state->owner != current)
-		return -EINVAL;
-
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
-
-	/*
-	 * When we interleave with futex_lock_pi() where it does
-	 * rt_mutex_timed_futex_lock(), we might observe @this futex_q waiter,
-	 * but the rt_mutex's wait_list can be empty (either still, or again,
-	 * depending on which side we land).
-	 *
-	 * When this happens, give up our locks and try again, giving the
-	 * futex_lock_pi() instance time to complete, either by waiting on the
-	 * rtmutex or removing itself from the futex queue.
-	 */
 	if (!new_owner) {
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		return -EAGAIN;
+		/*
+		 * Since we held neither hb->lock nor wait_lock when coming
+		 * into this function, we could have raced with futex_lock_pi()
+		 * such that we might observe @this futex_q waiter, but the
+		 * rt_mutex's wait_list can be empty (either still, or again,
+		 * depending on which side we land).
+		 *
+		 * When this happens, give up our locks and try again, giving
+		 * the futex_lock_pi() instance time to complete, either by
+		 * waiting on the rtmutex or removing itself from the futex
+		 * queue.
+		 */
+		ret = -EAGAIN;
+		goto out_unlock;
 	}
 
 	/*
-	 * We pass it to the next owner. The WAITERS bit is always
-	 * kept enabled while there is PI state around. We cleanup the
-	 * owner died bit, because we are the owner.
+	 * We pass it to the next owner. The WAITERS bit is always kept
+	 * enabled while there is PI state around. We cleanup the owner
+	 * died bit, because we are the owner.
 	 */
 	newval = FUTEX_WAITERS | task_pid_vnr(new_owner);
 
@@ -1441,10 +1440,8 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 			ret = -EINVAL;
 	}
 
-	if (ret) {
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		return ret;
-	}
+	if (ret)
+		goto out_unlock;
 
 	raw_spin_lock(&pi_state->owner->pi_lock);
 	WARN_ON(list_empty(&pi_state->list));
@@ -1462,15 +1459,15 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 	 */
 	deboost = __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
 
+out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-	spin_unlock(&hb->lock);
 
 	if (deboost) {
 		wake_up_q(&wake_q);
 		rt_mutex_adjust_prio(current);
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
@@ -2245,7 +2242,8 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	/*
 	 * We are here either because we stole the rtmutex from the
 	 * previous highest priority waiter or we are the highest priority
-	 * waiter but failed to get the rtmutex the first time.
+	 * waiter but have failed to get the rtmutex the first time.
+	 *
 	 * We have to replace the newowner TID in the user space variable.
 	 * This must be atomic as we have to preserve the owner died bit here.
 	 *
@@ -2262,7 +2260,7 @@ retry:
 	if (get_futex_value_locked(&uval, uaddr))
 		goto handle_fault;
 
-	while (1) {
+	for (;;) {
 		newval = (uval & FUTEX_OWNER_DIED) | newtid;
 
 		if (cmpxchg_futex_value_locked(&curval, uaddr, uval, newval))
@@ -2358,6 +2356,10 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		/*
 		 * Got the lock. We might not be the anticipated owner if we
 		 * did a lock-steal - fix up the PI-state in that case:
+		 *
+		 * We can safely read pi_state->owner without holding wait_lock
+		 * because we now own the rt_mutex, only the owner will attempt
+		 * to change it.
 		 */
 		if (q->pi_state->owner != current)
 			ret = fixup_pi_state_owner(uaddr, q, current);
@@ -2597,6 +2599,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 			 ktime_t *time, int trylock)
 {
 	struct hrtimer_sleeper timeout, *to = NULL;
+	struct futex_pi_state *pi_state = NULL;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -2683,12 +2686,19 @@ retry_private:
 	 * If fixup_owner() faulted and was unable to handle the fault, unlock
 	 * it and return the fault to userspace.
 	 */
-	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current))
-		rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
+	if (ret && (rt_mutex_owner(&q.pi_state->pi_mutex) == current)) {
+		pi_state = q.pi_state;
+		get_pi_state(pi_state);
+	}
 
 	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
 
+	if (pi_state) {
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+	}
+
 	goto out_put_key;
 
 out_unlock_put_key:
@@ -2751,10 +2761,36 @@ retry:
 	 */
 	top_waiter = futex_top_waiter(hb, &key);
 	if (top_waiter) {
-		ret = wake_futex_pi(uaddr, uval, top_waiter, hb);
+		struct futex_pi_state *pi_state = top_waiter->pi_state;
+
+		ret = -EINVAL;
+		if (!pi_state)
+			goto out_unlock;
+
+		/*
+		 * If current does not own the pi_state then the futex is
+		 * inconsistent and user space fiddled with the futex value.
+		 */
+		if (pi_state->owner != current)
+			goto out_unlock;
+
 		/*
-		 * In case of success wake_futex_pi dropped the hash
-		 * bucket lock.
+		 * Grab a reference on the pi_state and drop hb->lock.
+		 *
+		 * The reference ensures pi_state lives, dropping the hb->lock
+		 * is tricky.. wake_futex_pi() will take rt_mutex::wait_lock to
+		 * close the races against futex_lock_pi(), but in case of
+		 * _any_ fail we'll abort and retry the whole deal.
+		 */
+		get_pi_state(pi_state);
+		spin_unlock(&hb->lock);
+
+		ret = wake_futex_pi(uaddr, uval, pi_state);
+
+		put_pi_state(pi_state);
+
+		/*
+		 * Success, we're done! No tricky corner cases.
 		 */
 		if (!ret)
 			goto out_putkey;
@@ -2769,7 +2805,6 @@ retry:
 		 * setting the FUTEX_WAITERS bit. Try again.
 		 */
 		if (ret == -EAGAIN) {
-			spin_unlock(&hb->lock);
 			put_futex_key(&key);
 			goto retry;
 		}
@@ -2777,7 +2812,7 @@ retry:
 		 * wake_futex_pi has detected invalid state. Tell user
 		 * space.
 		 */
-		goto out_unlock;
+		goto out_putkey;
 	}
 
 	/*
@@ -2787,8 +2822,10 @@ retry:
 	 * preserve the WAITERS bit not the OWNER_DIED one. We are the
 	 * owner.
 	 */
-	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, 0))
+	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, 0)) {
+		spin_unlock(&hb->lock);
 		goto pi_faulted;
+	}
 
 	/*
 	 * If uval has changed, let user space handle it.
@@ -2802,7 +2839,6 @@ out_putkey:
 	return ret;
 
 pi_faulted:
-	spin_unlock(&hb->lock);
 	put_futex_key(&key);
 
 	ret = fault_in_user_writeable(uaddr);
@@ -2906,6 +2942,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 				 u32 __user *uaddr2)
 {
 	struct hrtimer_sleeper timeout, *to = NULL;
+	struct futex_pi_state *pi_state = NULL;
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
@@ -2990,8 +3027,10 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (q.pi_state && (q.pi_state->owner != current)) {
 			spin_lock(q.lock_ptr);
 			ret = fixup_pi_state_owner(uaddr2, &q, current);
-			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current)
-				rt_mutex_futex_unlock(&q.pi_state->pi_mutex);
+			if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
+				pi_state = q.pi_state;
+				get_pi_state(pi_state);
+			}
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
@@ -3030,13 +3069,20 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 * the fault, unlock the rt_mutex and return the fault to
 		 * userspace.
 		 */
-		if (ret && rt_mutex_owner(pi_mutex) == current)
-			rt_mutex_futex_unlock(pi_mutex);
+		if (ret && rt_mutex_owner(&q.pi_state->pi_mutex) == current) {
+			pi_state = q.pi_state;
+			get_pi_state(pi_state);
+		}
 
 		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
 	}
 
+	if (pi_state) {
+		rt_mutex_futex_unlock(&pi_state->pi_mutex);
+		put_pi_state(pi_state);
+	}
+
 	if (ret == -EINTR) {
 		/*
 		 * We've already been requeued, but cannot restart by calling
-- 
2.7.4

