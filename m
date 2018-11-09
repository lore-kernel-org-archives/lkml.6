Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC2520840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="d19S664P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC2520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeKITr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36743 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeKITrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id h192so919172lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RWYXZ+qCwseLGfdahDSJq7TSLgi4WwETtN7iQmpjqa0=;
        b=d19S664PZJzsWkf6zxiuygffZnzv+9AEyeAULO/hkLETNreUAVjk3KIq1OOC3HFvBy
         G+JWlx/valPOsU8vO+S+4jehjM2l13VAGa0NI4t2oE4y/vsirOyvJTpQW1AQw5UU5TyY
         0RY6PXvXHpBvme1K1v1PBzWazo+zzBugJytsTgcJYqPi7JLoR6bBN9MIafD9698a9WeF
         Y9pHRsbNYzDXfMx610mRsKINCRYShGJu+u3942jCou+c1Up8Fs9WtiqTtC3dguhj6YUz
         JZxVab1fR5p6hzzzo+K/aTJxEz/d+Ae/jOj6h7/yUlfUcco2VYEXpARFHuNYbXPSig1W
         9ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RWYXZ+qCwseLGfdahDSJq7TSLgi4WwETtN7iQmpjqa0=;
        b=jljMGr5f+zGTZQl+noBs0Defg3sJgKojVVl/BV/T6jEw5PdEEZujtusNsQKAhOy6bc
         8TEFXLylyWaMD9V4pRVx6bg9MmHS/fAP4YIMTNPV9WZOt19mxW7+ikJY2UIi9r/2KSKU
         hLu4qqU+U19opxZNOtkoxtjOtbT8bH+KkjxV3moizLp7Hw3SuBVi6rPlBazD6U//N9nV
         rZ5kbULn7I55yWdm6G8M+Z7KBMH+pXzqYiyaoFuIYzzjpVaVf04didIA9dQSuCz9rNAf
         I3eRcNzEzHuIwQUi+GsS5kkkRP6x6FV/BN1mWeKVO52AKTtdhI4Ep4UhomYKJQ6O5K1L
         7F6A==
X-Gm-Message-State: AGRZ1gL3J9/oNlmSUEs28IZ99FeOL2/DETNURGTeGqTKyiMJkvfaU/bK
        P0ldKw9n4gIxV3YH6g6jin2OGg2aQyvl4WmL
X-Google-Smtp-Source: AJdET5cIVIIqO+c3LXNr3MBatNGedmr+bs40dpu/Mu0MlL/SpCbL/UFvJAP3dzNo7Q/luB3iiyXHqQ==
X-Received: by 2002:a19:2203:: with SMTP id i3mr5317600lfi.2.1541758080472;
        Fri, 09 Nov 2018 02:08:00 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:59 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 06/17] futex: Change locking rules
Date:   Fri,  9 Nov 2018 11:07:34 +0100
Message-Id: <1541758065-10952-7-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 734009e96d1983ad739e5b656e03430b3660c913 upstream.

Currently futex-pi relies on hb->lock to serialize everything. But hb->lock
creates another set of problems, especially priority inversions on RT where
hb->lock becomes a rt_mutex itself.

The rt_mutex::wait_lock is the most obvious protection for keeping the
futex user space value and the kernel internal pi_state in sync.

Rework and document the locking so rt_mutex::wait_lock is held accross all
operations which modify the user space value and the pi state.

This allows to invoke rt_mutex_unlock() (including deboost) without holding
hb->lock as a next step.

Nothing yet relies on the new locking rules.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.751993333@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c | 165 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 132 insertions(+), 33 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e1200b9..52e3678 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -967,6 +967,39 @@ void exit_pi_state_list(struct task_struct *curr)
  *
  * [10] There is no transient state which leaves owner and user space
  *	TID out of sync.
+ *
+ *
+ * Serialization and lifetime rules:
+ *
+ * hb->lock:
+ *
+ *	hb -> futex_q, relation
+ *	futex_q -> pi_state, relation
+ *
+ *	(cannot be raw because hb can contain arbitrary amount
+ *	 of futex_q's)
+ *
+ * pi_mutex->wait_lock:
+ *
+ *	{uval, pi_state}
+ *
+ *	(and pi_mutex 'obviously')
+ *
+ * p->pi_lock:
+ *
+ *	p->pi_state_list -> pi_state->list, relation
+ *
+ * pi_state->refcount:
+ *
+ *	pi_state lifetime
+ *
+ *
+ * Lock order:
+ *
+ *   hb->lock
+ *     pi_mutex->wait_lock
+ *       p->pi_lock
+ *
  */
 
 /*
@@ -974,10 +1007,12 @@ void exit_pi_state_list(struct task_struct *curr)
  * the pi_state against the user space value. If correct, attach to
  * it.
  */
-static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
+static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
+			      struct futex_pi_state *pi_state,
 			      struct futex_pi_state **ps)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
+	int ret, uval2;
 
 	/*
 	 * Userspace might have messed up non-PI and PI futexes [3]
@@ -985,9 +1020,34 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 	if (unlikely(!pi_state))
 		return -EINVAL;
 
+	/*
+	 * We get here with hb->lock held, and having found a
+	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
+	 * has dropped the hb->lock in between queue_me() and unqueue_me_pi(),
+	 * which in turn means that futex_lock_pi() still has a reference on
+	 * our pi_state.
+	 */
 	WARN_ON(!atomic_read(&pi_state->refcount));
 
 	/*
+	 * Now that we have a pi_state, we can acquire wait_lock
+	 * and do the state validation.
+	 */
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	/*
+	 * Since {uval, pi_state} is serialized by wait_lock, and our current
+	 * uval was read without holding it, it can have changed. Verify it
+	 * still is what we expect it to be, otherwise retry the entire
+	 * operation.
+	 */
+	if (get_futex_value_locked(&uval2, uaddr))
+		goto out_efault;
+
+	if (uval != uval2)
+		goto out_eagain;
+
+	/*
 	 * Handle the owner died case:
 	 */
 	if (uval & FUTEX_OWNER_DIED) {
@@ -1002,11 +1062,11 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 			 * is not 0. Inconsistent state. [5]
 			 */
 			if (pid)
-				return -EINVAL;
+				goto out_einval;
 			/*
 			 * Take a ref on the state and return success. [4]
 			 */
-			goto out_state;
+			goto out_attach;
 		}
 
 		/*
@@ -1018,14 +1078,14 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 		 * Take a ref on the state and return success. [6]
 		 */
 		if (!pid)
-			goto out_state;
+			goto out_attach;
 	} else {
 		/*
 		 * If the owner died bit is not set, then the pi_state
 		 * must have an owner. [7]
 		 */
 		if (!pi_state->owner)
-			return -EINVAL;
+			goto out_einval;
 	}
 
 	/*
@@ -1034,11 +1094,29 @@ static int attach_to_pi_state(u32 uval, struct futex_pi_state *pi_state,
 	 * user space TID. [9/10]
 	 */
 	if (pid != task_pid_vnr(pi_state->owner))
-		return -EINVAL;
-out_state:
+		goto out_einval;
+
+out_attach:
 	atomic_inc(&pi_state->refcount);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	*ps = pi_state;
 	return 0;
+
+out_einval:
+	ret = -EINVAL;
+	goto out_error;
+
+out_eagain:
+	ret = -EAGAIN;
+	goto out_error;
+
+out_efault:
+	ret = -EFAULT;
+	goto out_error;
+
+out_error:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
 }
 
 /*
@@ -1089,6 +1167,9 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 
 	/*
 	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
 	 */
 	pi_state = alloc_pi_state();
 
@@ -1113,7 +1194,8 @@ static int attach_to_pi_owner(u32 uval, union futex_key *key,
 	return 0;
 }
 
-static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
+static int lookup_pi_state(u32 __user *uaddr, u32 uval,
+			   struct futex_hash_bucket *hb,
 			   union futex_key *key, struct futex_pi_state **ps)
 {
 	struct futex_q *top_waiter = futex_top_waiter(hb, key);
@@ -1123,7 +1205,7 @@ static int lookup_pi_state(u32 uval, struct futex_hash_bucket *hb,
 	 * attach to the pi_state when the validation succeeds.
 	 */
 	if (top_waiter)
-		return attach_to_pi_state(uval, top_waiter->pi_state, ps);
+		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
 
 	/*
 	 * We are the first waiter - try to look up the owner based on
@@ -1142,7 +1224,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 	if (unlikely(cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)))
 		return -EFAULT;
 
-	/*If user space value changed, let the caller retry */
+	/* If user space value changed, let the caller retry */
 	return curval != uval ? -EAGAIN : 0;
 }
 
@@ -1198,7 +1280,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 	 */
 	top_waiter = futex_top_waiter(hb, key);
 	if (top_waiter)
-		return attach_to_pi_state(uval, top_waiter->pi_state, ps);
+		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
 
 	/*
 	 * No waiter and user TID is 0. We are here because the
@@ -1330,6 +1412,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 
 	if (cmpxchg_futex_value_locked(&curval, uaddr, uval, newval)) {
 		ret = -EFAULT;
+
 	} else if (curval != uval) {
 		/*
 		 * If a unconditional UNLOCK_PI operation (user space did not
@@ -1342,6 +1425,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 		else
 			ret = -EINVAL;
 	}
+
 	if (ret) {
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		return ret;
@@ -1856,7 +1940,7 @@ retry_private:
 			 * rereading and handing potential crap to
 			 * lookup_pi_state.
 			 */
-			ret = lookup_pi_state(ret, hb2, &key2, &pi_state);
+			ret = lookup_pi_state(uaddr2, ret, hb2, &key2, &pi_state);
 		}
 
 		switch (ret) {
@@ -2128,10 +2212,13 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 {
 	u32 newtid = task_pid_vnr(newowner) | FUTEX_WAITERS;
 	struct futex_pi_state *pi_state = q->pi_state;
-	struct task_struct *oldowner = pi_state->owner;
 	u32 uval, uninitialized_var(curval), newval;
+	struct task_struct *oldowner;
 	int ret;
 
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+
+	oldowner = pi_state->owner;
 	/* Owner died? */
 	if (!pi_state->owner)
 		newtid |= FUTEX_OWNER_DIED;
@@ -2147,11 +2234,10 @@ static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * because we can fault here. Imagine swapped out pages or a fork
 	 * that marked all the anonymous memory readonly for cow.
 	 *
-	 * Modifying pi_state _before_ the user space value would
-	 * leave the pi_state in an inconsistent state when we fault
-	 * here, because we need to drop the hash bucket lock to
-	 * handle the fault. This might be observed in the PID check
-	 * in lookup_pi_state.
+	 * Modifying pi_state _before_ the user space value would leave the
+	 * pi_state in an inconsistent state when we fault here, because we
+	 * need to drop the locks to handle the fault. This might be observed
+	 * in the PID check in lookup_pi_state.
 	 */
 retry:
 	if (get_futex_value_locked(&uval, uaddr))
@@ -2172,47 +2258,60 @@ retry:
 	 * itself.
 	 */
 	if (pi_state->owner != NULL) {
-		raw_spin_lock_irq(&pi_state->owner->pi_lock);
+		raw_spin_lock(&pi_state->owner->pi_lock);
 		WARN_ON(list_empty(&pi_state->list));
 		list_del_init(&pi_state->list);
-		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+		raw_spin_unlock(&pi_state->owner->pi_lock);
 	}
 
 	pi_state->owner = newowner;
 
-	raw_spin_lock_irq(&newowner->pi_lock);
+	raw_spin_lock(&newowner->pi_lock);
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &newowner->pi_state_list);
-	raw_spin_unlock_irq(&newowner->pi_lock);
+	raw_spin_unlock(&newowner->pi_lock);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+
 	return 0;
 
 	/*
-	 * To handle the page fault we need to drop the hash bucket
-	 * lock here. That gives the other task (either the highest priority
-	 * waiter itself or the task which stole the rtmutex) the
-	 * chance to try the fixup of the pi_state. So once we are
-	 * back from handling the fault we need to check the pi_state
-	 * after reacquiring the hash bucket lock and before trying to
-	 * do another fixup. When the fixup has been done already we
-	 * simply return.
+	 * To handle the page fault we need to drop the locks here. That gives
+	 * the other task (either the highest priority waiter itself or the
+	 * task which stole the rtmutex) the chance to try the fixup of the
+	 * pi_state. So once we are back from handling the fault we need to
+	 * check the pi_state after reacquiring the locks and before trying to
+	 * do another fixup. When the fixup has been done already we simply
+	 * return.
+	 *
+	 * Note: we hold both hb->lock and pi_mutex->wait_lock. We can safely
+	 * drop hb->lock since the caller owns the hb -> futex_q relation.
+	 * Dropping the pi_mutex->wait_lock requires the state revalidate.
 	 */
 handle_fault:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 	spin_unlock(q->lock_ptr);
 
 	ret = fault_in_user_writeable(uaddr);
 
 	spin_lock(q->lock_ptr);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
 	 * Check if someone else fixed it for us:
 	 */
-	if (pi_state->owner != oldowner)
-		return 0;
+	if (pi_state->owner != oldowner) {
+		ret = 0;
+		goto out_unlock;
+	}
 
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	goto retry;
+
+out_unlock:
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+	return ret;
 }
 
 static long futex_wait_restart(struct restart_block *restart);
-- 
2.7.4

