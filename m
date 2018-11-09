Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="mqIphMY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6100B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeKITrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38497 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeKITrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so914561lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2ovCvAiidixzsjlJ/YT0DnGQQ1sOa2LFt5NCj59pJY=;
        b=mqIphMY8YFvEwGyyOegkalieRkQAiAyDY5Ifk1G/FiHHylo6ZcLJYsio199kUaHlnT
         Q1vkr74AjVarPdID7zVu5jH1j9+p23JgCNYD+W7s6WizKb36AERPKdAUPdgyN3oi8qjT
         Uj4+b9J3cZnhGHA2TIZkZy808lbyHXWRbP4sZ4z0JXZrN8NW8+1KjABzA5KFe6n9Kn2C
         6QblKfr5TBRMNQUpXIhfnMAA95khR0oOXywO1tZdW81NRci/Y+FJo1GhkgfapnOjuuQ0
         gR35N6X83XTkEZb2Yu3E9M6rSWNMMdm0pyw2725sXvYrg7HWTZQ7dM3o1Dz02iAdtBLr
         IXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2ovCvAiidixzsjlJ/YT0DnGQQ1sOa2LFt5NCj59pJY=;
        b=BV2yT85nTdci2IkBpPEFFxWEqsZLFFVE6m8nYe6oAj52ZwJCVIw2TOmbhnBfZtpX8e
         rXeov8jN9feVUa+adFSJevcN9MP4jCyLYLmsDadU1LHfOLTztYhP9rF0MJsNe4a5uwJm
         M6+tXBaJIw3lyNbk7JcDUlMcAHqYjR2r0FPNIBHuc/MwTeRd+o/Oe/UnTsEPaRI/yEFr
         ZIdLQI/I7/qAdFHnZOhrO5+FbSjOkRJy6Xa0M0JNGlw6FamF/wsMa+QSoAy0T5I5EPDq
         baU+qJAlpy1uKNLbb5K78KysMQTIfbmnH6L8q+OfPVjDxnNUKJqztf2RwCKpyzGymdGF
         8rtA==
X-Gm-Message-State: AGRZ1gIHv0Lut6y9bZVWFroeA1rhVkSQ6YxXxMrU/7gqvqh0UwuEYtI9
        gkU47+8vPQ6vZlx3XTZOl0SnkMpJFig3eKW/
X-Google-Smtp-Source: AJdET5ezBHtKmMiGJJcaoe71zEn/i9h4B9Kb5H7ERxZjhqGGUfSnIlyn4UUpKY2z38oux+qsQkHVSA==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr5050090lfg.36.1541758077081;
        Fri, 09 Nov 2018 02:07:57 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:56 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 04/17] rtmutex: Make wait_lock irq safe
Date:   Fri,  9 Nov 2018 11:07:32 +0100
Message-Id: <1541758065-10952-5-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit b4abf91047cf054f203dcfac97e1038388826937 upstream.

Sasha reported a lockdep splat about a potential deadlock between RCU boosting
rtmutex and the posix timer it_lock.

CPU0					CPU1

rtmutex_lock(&rcu->rt_mutex)
  spin_lock(&rcu->rt_mutex.wait_lock)
					local_irq_disable()
					spin_lock(&timer->it_lock)
					spin_lock(&rcu->mutex.wait_lock)
--> Interrupt
    spin_lock(&timer->it_lock)

This is caused by the following code sequence on CPU1

     rcu_read_lock()
     x = lookup();
     if (x)
         spin_lock_irqsave(&x->it_lock);
     rcu_read_unlock();
     return x;

We could fix that in the posix timer code by keeping rcu read locked across
the spinlocked and irq disabled section, but the above sequence is common and
there is no reason not to support it.

Taking rt_mutex.wait_lock irq safe prevents the deadlock.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Tested-by:Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c           |  18 +++----
 kernel/locking/rtmutex.c | 135 +++++++++++++++++++++++++----------------------
 2 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 9e92f12..0f44952 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1307,7 +1307,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 	if (pi_state->owner != current)
 		return -EINVAL;
 
-	raw_spin_lock(&pi_state->pi_mutex.wait_lock);
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
 
 	/*
@@ -1343,22 +1343,22 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_q *top_waiter
 			ret = -EINVAL;
 	}
 	if (ret) {
-		raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		return ret;
 	}
 
-	raw_spin_lock_irq(&pi_state->owner->pi_lock);
+	raw_spin_lock(&pi_state->owner->pi_lock);
 	WARN_ON(list_empty(&pi_state->list));
 	list_del_init(&pi_state->list);
-	raw_spin_unlock_irq(&pi_state->owner->pi_lock);
+	raw_spin_unlock(&pi_state->owner->pi_lock);
 
-	raw_spin_lock_irq(&new_owner->pi_lock);
+	raw_spin_lock(&new_owner->pi_lock);
 	WARN_ON(!list_empty(&pi_state->list));
 	list_add(&pi_state->list, &new_owner->pi_state_list);
 	pi_state->owner = new_owner;
-	raw_spin_unlock_irq(&new_owner->pi_lock);
+	raw_spin_unlock(&new_owner->pi_lock);
 
-	raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
 	deboost = rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
 
@@ -2269,11 +2269,11 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 		 * we returned due to timeout or signal without taking the
 		 * rt_mutex. Too late.
 		 */
-		raw_spin_lock(&q->pi_state->pi_mutex.wait_lock);
+		raw_spin_lock_irq(&q->pi_state->pi_mutex.wait_lock);
 		owner = rt_mutex_owner(&q->pi_state->pi_mutex);
 		if (!owner)
 			owner = rt_mutex_next_owner(&q->pi_state->pi_mutex);
-		raw_spin_unlock(&q->pi_state->pi_mutex.wait_lock);
+		raw_spin_unlock_irq(&q->pi_state->pi_mutex.wait_lock);
 		ret = fixup_pi_state_owner(uaddr, q, owner);
 		goto out;
 	}
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6cf9dab7..b8d08c7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -163,13 +163,14 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
+static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+					unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 
 	clear_rt_mutex_waiters(lock);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	/*
 	 * If a new waiter comes in between the unlock and the cmpxchg
 	 * we have two situations:
@@ -211,11 +212,12 @@ static inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_lock.
  */
-static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock)
+static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+					unsigned long flags)
 	__releases(lock->wait_lock)
 {
 	lock->owner = NULL;
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	return true;
 }
 #endif
@@ -497,7 +499,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	int ret = 0, depth = 0;
 	struct rt_mutex *lock;
 	bool detect_deadlock;
-	unsigned long flags;
 	bool requeue = true;
 
 	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);
@@ -540,7 +541,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	/*
 	 * [1] Task cannot go away as we did a get_task() before !
 	 */
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock_irq(&task->pi_lock);
 
 	/*
 	 * [2] Get the waiter on which @task is blocked on.
@@ -624,7 +625,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * operations.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock_irq(&task->pi_lock);
 		cpu_relax();
 		goto retry;
 	}
@@ -655,7 +656,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		/*
 		 * No requeue[7] here. Just release @task [8]
 		 */
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		raw_spin_unlock(&task->pi_lock);
 		put_task_struct(task);
 
 		/*
@@ -663,14 +664,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * If there is no owner of the lock, end of chain.
 		 */
 		if (!rt_mutex_owner(lock)) {
-			raw_spin_unlock(&lock->wait_lock);
+			raw_spin_unlock_irq(&lock->wait_lock);
 			return 0;
 		}
 
 		/* [10] Grab the next task, i.e. owner of @lock */
 		task = rt_mutex_owner(lock);
 		get_task_struct(task);
-		raw_spin_lock_irqsave(&task->pi_lock, flags);
+		raw_spin_lock(&task->pi_lock);
 
 		/*
 		 * No requeue [11] here. We just do deadlock detection.
@@ -685,8 +686,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		top_waiter = rt_mutex_top_waiter(lock);
 
 		/* [13] Drop locks */
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&task->pi_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 
 		/* If owner is not blocked, end of chain. */
 		if (!next_lock)
@@ -707,7 +708,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	rt_mutex_enqueue(lock, waiter);
 
 	/* [8] Release the task */
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
 	/*
@@ -725,14 +726,14 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
 			wake_up_process(rt_mutex_top_waiter(lock)->task);
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
 
 	/* [10] Grab the next task, i.e. the owner of @lock */
 	task = rt_mutex_owner(lock);
 	get_task_struct(task);
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 
 	/* [11] requeue the pi waiters if necessary */
 	if (waiter == rt_mutex_top_waiter(lock)) {
@@ -786,8 +787,8 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	top_waiter = rt_mutex_top_waiter(lock);
 
 	/* [13] Drop the locks */
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&task->pi_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	/*
 	 * Make the actual exit decisions [12], based on the stored
@@ -810,7 +811,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 	goto again;
 
  out_unlock_pi:
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock_irq(&task->pi_lock);
  out_put_task:
 	put_task_struct(task);
 
@@ -820,7 +821,7 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 /*
  * Try to take an rt-mutex
  *
- * Must be called with lock->wait_lock held.
+ * Must be called with lock->wait_lock held and interrupts disabled
  *
  * @lock:   The lock to be acquired.
  * @task:   The task which wants to acquire the lock
@@ -830,8 +831,6 @@ static int rt_mutex_adjust_prio_chain(struct task_struct *task,
 static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 				struct rt_mutex_waiter *waiter)
 {
-	unsigned long flags;
-
 	/*
 	 * Before testing whether we can acquire @lock, we set the
 	 * RT_MUTEX_HAS_WAITERS bit in @lock->owner. This forces all
@@ -916,7 +915,7 @@ static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	 * case, but conditionals are more expensive than a redundant
 	 * store.
 	 */
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 	task->pi_blocked_on = NULL;
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
@@ -925,7 +924,7 @@ static int try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
 	 */
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(task, rt_mutex_top_waiter(lock));
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 
 takeit:
 	/* We got the lock. */
@@ -945,7 +944,7 @@ takeit:
  *
  * Prepare waiter and propagate pi chain
  *
- * This must be called with lock->wait_lock held.
+ * This must be called with lock->wait_lock held and interrupts disabled
  */
 static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 				   struct rt_mutex_waiter *waiter,
@@ -956,7 +955,6 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	struct rt_mutex_waiter *top_waiter = waiter;
 	struct rt_mutex *next_lock;
 	int chain_walk = 0, res;
-	unsigned long flags;
 
 	/*
 	 * Early deadlock detection. We really don't want the task to
@@ -970,7 +968,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	if (owner == task)
 		return -EDEADLK;
 
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
+	raw_spin_lock(&task->pi_lock);
 	__rt_mutex_adjust_prio(task);
 	waiter->task = task;
 	waiter->lock = lock;
@@ -983,12 +981,12 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 
 	task->pi_blocked_on = waiter;
 
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+	raw_spin_unlock(&task->pi_lock);
 
 	if (!owner)
 		return 0;
 
-	raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock(&owner->pi_lock);
 	if (waiter == rt_mutex_top_waiter(lock)) {
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
@@ -1003,7 +1001,7 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
 
-	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
+	raw_spin_unlock(&owner->pi_lock);
 	/*
 	 * Even if full deadlock detection is on, if the owner is not
 	 * blocked itself, we can avoid finding this out in the chain
@@ -1019,12 +1017,12 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	 */
 	get_task_struct(owner);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	res = rt_mutex_adjust_prio_chain(owner, chwalk, lock,
 					 next_lock, waiter, task);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	return res;
 }
@@ -1033,15 +1031,14 @@ static int task_blocks_on_rt_mutex(struct rt_mutex *lock,
  * Remove the top waiter from the current tasks pi waiter tree and
  * queue it up.
  *
- * Called with lock->wait_lock held.
+ * Called with lock->wait_lock held and interrupts disabled.
  */
 static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 				    struct rt_mutex *lock)
 {
 	struct rt_mutex_waiter *waiter;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
 
@@ -1063,7 +1060,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 */
 	lock->owner = (void *) RT_MUTEX_HAS_WAITERS;
 
-	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	raw_spin_unlock(&current->pi_lock);
 
 	wake_q_add(wake_q, waiter->task);
 }
@@ -1071,7 +1068,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and
+ * Must be called with lock->wait_lock held and interrupts disabled. I must
  * have just failed to try_to_take_rt_mutex().
  */
 static void remove_waiter(struct rt_mutex *lock,
@@ -1080,12 +1077,11 @@ static void remove_waiter(struct rt_mutex *lock,
 	bool is_top_waiter = (waiter == rt_mutex_top_waiter(lock));
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex *next_lock;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	raw_spin_lock(&current->pi_lock);
 	rt_mutex_dequeue(lock, waiter);
 	current->pi_blocked_on = NULL;
-	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+	raw_spin_unlock(&current->pi_lock);
 
 	/*
 	 * Only update priority if the waiter was the highest priority
@@ -1094,7 +1090,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	if (!owner || !is_top_waiter)
 		return;
 
-	raw_spin_lock_irqsave(&owner->pi_lock, flags);
+	raw_spin_lock(&owner->pi_lock);
 
 	rt_mutex_dequeue_pi(owner, waiter);
 
@@ -1106,7 +1102,7 @@ static void remove_waiter(struct rt_mutex *lock,
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
 
-	raw_spin_unlock_irqrestore(&owner->pi_lock, flags);
+	raw_spin_unlock(&owner->pi_lock);
 
 	/*
 	 * Don't walk the chain, if the owner task is not blocked
@@ -1118,12 +1114,12 @@ static void remove_waiter(struct rt_mutex *lock,
 	/* gets dropped in rt_mutex_adjust_prio_chain()! */
 	get_task_struct(owner);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	rt_mutex_adjust_prio_chain(owner, RT_MUTEX_MIN_CHAINWALK, lock,
 				   next_lock, NULL, current);
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 }
 
 /*
@@ -1159,11 +1155,11 @@ void rt_mutex_adjust_pi(struct task_struct *task)
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
  * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
- * 			 or TASK_UNINTERRUPTIBLE)
+ *			 or TASK_UNINTERRUPTIBLE)
  * @timeout:		 the pre-initialized and started timer, or NULL for none
  * @waiter:		 the pre-initialized rt_mutex_waiter
  *
- * lock->wait_lock must be held by the caller.
+ * Must be called with lock->wait_lock held and interrupts disabled
  */
 static int __sched
 __rt_mutex_slowlock(struct rt_mutex *lock, int state,
@@ -1191,13 +1187,13 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 				break;
 		}
 
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(waiter);
 
 		schedule();
 
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
 	}
 
@@ -1234,17 +1230,26 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 		  enum rtmutex_chainwalk chwalk)
 {
 	struct rt_mutex_waiter waiter;
+	unsigned long flags;
 	int ret = 0;
 
 	debug_rt_mutex_init_waiter(&waiter);
 	RB_CLEAR_NODE(&waiter.pi_tree_entry);
 	RB_CLEAR_NODE(&waiter.tree_entry);
 
-	raw_spin_lock(&lock->wait_lock);
+	/*
+	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
+	 * be called in early boot if the cmpxchg() fast path is disabled
+	 * (debug, no architecture support). In this case we will acquire the
+	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
+	 * enable interrupts in that early boot case. So we need to use the
+	 * irqsave/restore variants.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		return 0;
 	}
 
@@ -1273,7 +1278,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* Remove pending timer: */
 	if (unlikely(timeout))
@@ -1289,6 +1294,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
  */
 static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 {
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -1300,10 +1306,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 		return 0;
 
 	/*
-	 * The mutex has currently no owner. Lock the wait lock and
-	 * try to acquire the lock.
+	 * The mutex has currently no owner. Lock the wait lock and try to
+	 * acquire the lock. We use irqsave here to support early boot calls.
 	 */
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	ret = try_to_take_rt_mutex(lock, current, NULL);
 
@@ -1313,7 +1319,7 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	return ret;
 }
@@ -1325,7 +1331,10 @@ static inline int rt_mutex_slowtrylock(struct rt_mutex *lock)
 static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 					struct wake_q_head *wake_q)
 {
-	raw_spin_lock(&lock->wait_lock);
+	unsigned long flags;
+
+	/* irqsave required to support early boot calls */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 
 	debug_rt_mutex_unlock(lock);
 
@@ -1362,10 +1371,10 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock) == true)
+		if (unlock_rt_mutex_safe(lock, flags) == true)
 			return false;
 		/* Relock the rtmutex and try again */
-		raw_spin_lock(&lock->wait_lock);
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
 
 	/*
@@ -1376,7 +1385,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	mark_wakeup_next_waiter(wake_q, lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* check PI boosting */
 	return true;
@@ -1649,10 +1658,10 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 {
 	int ret;
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	if (try_to_take_rt_mutex(lock, task, NULL)) {
-		raw_spin_unlock(&lock->wait_lock);
+		raw_spin_unlock_irq(&lock->wait_lock);
 		return 1;
 	}
 
@@ -1673,7 +1682,7 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (unlikely(ret))
 		remove_waiter(lock, waiter);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	debug_rt_mutex_print_deadlock(waiter);
 
@@ -1721,7 +1730,7 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 {
 	int ret;
 
-	raw_spin_lock(&lock->wait_lock);
+	raw_spin_lock_irq(&lock->wait_lock);
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -1737,7 +1746,7 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 	 */
 	fixup_rt_mutex_waiters(lock);
 
-	raw_spin_unlock(&lock->wait_lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
 }
-- 
2.7.4

