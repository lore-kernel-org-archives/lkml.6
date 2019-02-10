Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B917C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED2421773
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549788928;
	bh=xIMpThsoPtKUA+Px+69gvMMpCaBjWXHmfXuC1zypmfY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wT8ysXNLLwl40fgIi6uT5y+iB53BE0GgVgovBDyh63ZcDbSHqV2VWlZKS1yphSFJH
	 KPGR9YA1Au1VL2hv1k7ihWQO2fFTqKEAcZbRYcAjHHvoZRQb+uy6NFfqefo1Kidfbt
	 gJWje1vZtF95H1/ST5zpAKSaJdCJlNqzORMLlWnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfBJIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 03:53:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55967 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfBJIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 03:53:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so11342393wmh.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 00:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Wy+ws6+s1sjezkwAQD23IzWRDzxVlbzI43QLx9wrQVM=;
        b=uNwKfXb8ozmw53Q9TsxNfjGnkcxa+63q12fCAkKzXZxqjbAyNI/mAy2VUSBnv03IoG
         PcC9lC6jfhtwicASm9gvzNHxyzIAaKkoPWDLtUoJEC3Wx5a4WDORF4+kGMZw+Xn1LJRE
         cnesN6IQFVlSk4sYUx5o7s9PQmQU6BuD80lLomr4TRZXn0JYmstDklKGFZBTtmXdPh2s
         w0zaDdUHtJCryfL3TEFKAnrttmLK0eBWcbygXXpS63+xsAFEp/km2AKix1kfzd+hiuuY
         HLKRk67eUwZcZHtJXCMJK+JK0skyjjot1YS9HNX2C3plwb5dNS/55lXp4JU3+/vjEPir
         XVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Wy+ws6+s1sjezkwAQD23IzWRDzxVlbzI43QLx9wrQVM=;
        b=PVZP2/1RwwEXzIRhH5d3NUaOfR1FFR8eHth1qvU1Nt2il+QBPLCyul89SM9bRurYyX
         bqT+bMSVIjxm2AWRjbU7DJyrlE2MtmGqoic96xFNYkU6b0gBx1dhE5LSZJdFjVA8iCvQ
         vy09GOH8/JLSSFemmDlazO/PJv8U9RtWBj1Wyk0jqj4lQW3QDE71cdqhuJABM/ZY1iP4
         jjBB4BkqkFnIffQDrwDu7GSyC326OyAe19lnm1n/d0riMO/rON5Eoq9l/K/NHd1gJB8I
         wF74cnohVhf+Bpp+C0FtiVkwNsqIB34F7HzYODlX9EujBNELXa3cKX4g6G2FtgKvYVOO
         jMDA==
X-Gm-Message-State: AHQUAubWN6sCgon1IbJ7atjM5qyOH+TVoLXKluBQlLRIY0w6lfk71HJw
        nShRDyY4aol4A6hbLd+b3yM=
X-Google-Smtp-Source: AHgI3IY3cRFGMb7zPydRw6Ayrh5FHFOP/gsbFyx2oMcr4DXItPlQ9rSeBCbMqWtqOZT0COuXMLtBKw==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr22288960wrr.313.1549788814735;
        Sun, 10 Feb 2019 00:53:34 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b13sm13089016wmj.42.2019.02.10.00.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 00:53:33 -0800 (PST)
Date:   Sun, 10 Feb 2019 09:53:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] locking fixes
Message-ID: <20190210085331.GA55723@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: 1a1fb985f2e2b85ec0d3dc2e519ee48389ec2434 futex: Handle early deadlock return correctly

An rtmutex (PI-futex) deadlock scenario fix, plus a locking documentation 
fix.

 Thanks,

	Ingo

------------------>
Davidlohr Bueso (1):
      futex: Fix barrier comment

Thomas Gleixner (1):
      futex: Handle early deadlock return correctly


 kernel/futex.c           | 32 ++++++++++++++++++++------------
 kernel/locking/rtmutex.c | 37 ++++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index fdd312da0992..a0514e01c3eb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2221,11 +2221,11 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	 * decrement the counter at queue_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
-	hb_waiters_inc(hb);
+	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
 
 	q->lock_ptr = &hb->lock;
 
-	spin_lock(&hb->lock); /* implies smp_mb(); (A) */
+	spin_lock(&hb->lock);
 	return hb;
 }
 
@@ -2861,35 +2861,39 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * and BUG when futex_unlock_pi() interleaves with this.
 	 *
 	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling rt_mutex_start_proxy_lock(). This still fully
-	 * serializes against futex_unlock_pi() as that does the exact same
-	 * lock handoff sequence.
+	 * latter before calling __rt_mutex_start_proxy_lock(). This
+	 * interleaves with futex_unlock_pi() -- which does a similar lock
+	 * handoff -- such that the latter can observe the futex_q::pi_state
+	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
 	spin_unlock(q.lock_ptr);
+	/*
+	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+	 * it sees the futex_q::pi_state.
+	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
 
 	if (ret) {
 		if (ret == 1)
 			ret = 0;
-
-		spin_lock(q.lock_ptr);
-		goto no_block;
+		goto cleanup;
 	}
 
-
 	if (unlikely(to))
 		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
 
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
+cleanup:
 	spin_lock(q.lock_ptr);
 	/*
-	 * If we failed to acquire the lock (signal/timeout), we must
+	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
-	 * wait lists consistent.
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
+	 * lists consistent.
 	 *
 	 * In particular; it is important that futex_unlock_pi() can not
 	 * observe this inconsistency.
@@ -3013,6 +3017,10 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * there is no point where we hold neither; and therefore
 		 * wake_futex_pi() must observe a state consistent with what we
 		 * observed.
+		 *
+		 * In particular; this forces __rt_mutex_start_proxy() to
+		 * complete such that we're guaranteed to observe the
+		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 581edcc63c26..978d63a8261c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1726,12 +1726,33 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
+/**
+ * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: does _NOT_ remove the @waiter on failure; must either call
+ * rt_mutex_wait_proxy_lock() or rt_mutex_cleanup_proxy_lock() after this.
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for PI-futex support.
+ */
 int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
 			      struct task_struct *task)
 {
 	int ret;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
@@ -1749,9 +1770,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -1763,12 +1781,18 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
  *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: unlike __rt_mutex_start_proxy_lock this _DOES_ remove the @waiter
+ * on failure.
+ *
  * Returns:
  *  0 - task blocked on lock
  *  1 - acquired the lock for task, caller should wake it up
  * <0 - error
  *
- * Special API call for FUTEX_REQUEUE_PI support.
+ * Special API call for PI-futex support.
  */
 int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
@@ -1778,6 +1802,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	if (unlikely(ret))
+		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
@@ -1845,7 +1871,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
  * @lock:		the rt_mutex we were woken on
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Attempt to clean up after a failed rt_mutex_wait_proxy_lock().
+ * Attempt to clean up after a failed __rt_mutex_start_proxy_lock() or
+ * rt_mutex_wait_proxy_lock().
  *
  * Unless we acquired the lock; we're still enqueued on the wait-list and can
  * in fact still be granted ownership until we're removed. Therefore we can
