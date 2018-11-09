Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F168C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A5B20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="NEuFGrh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5B20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeKITsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41171 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeKITsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so899544lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AD5XjKjxWGlyUHwlu+fRTBWfygiWxeGxqr0kIfHqNTY=;
        b=NEuFGrh/MfW4BDf1ZePQgYjP2CDsKcoDY1VgFk/0x9pnwy6O8wYAFywYNNPJMKMUHb
         8f/aepm85Gzal6TExQyM0I+nBMxShV0TGNE21Wm++U+4yobJm1mfNNhcw03TB7K8O+vt
         aQpk4+YsiSYQJgdSC0sQfSbmXPBmkhwZL4FEvwOH+KVrewq/qe6GsZz7O05gvxJ5H4om
         eRTKVe3kIoy1QvY4z6md0/hwm6KpUUBynLu1xsueUYDIrIbqst3Bow4SXS9UzY/6CT6R
         xqbAQcViOOGfxECAJxAF1oZEKSp0lNmg2sNfKtCR5kqEKgOwhRk74hhcw9yUV5SLSBV9
         xq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AD5XjKjxWGlyUHwlu+fRTBWfygiWxeGxqr0kIfHqNTY=;
        b=uhESoVeLkCFmVabrH+f6ZXhOjX+6yxPgqu1rcurPOGcMzVoKg2ngMoNzIATaCf7+zx
         UnRVWsyeBVaNRTAfmJL+DpLg/HVU6R6n966SgHDG/P7H11kyYdZ+2oN9Qz5TdWD5vIwt
         i4cna3BBES1wqUSAHerbzO+zR06/wTvvgA7IMv9iEZHPBw7cH33hbfGNFnGcXjhvVpti
         hHN8cBv6TACCJV/zu2Tyos7xkiUQVCGLQeDDFqhaYEGaYF575UFr5knN3wu6V7VoY6Vi
         zJMu8ck9CxjgMWtNPyPdrb29lQ+ewDVm1PgWBPYJH2QEJh1rMUcSWDUrybfz9Y6pN8me
         JPGw==
X-Gm-Message-State: AGRZ1gIy+ILrozBJvUHTcWRGWeJuUu3/bI82PY/zAyuEfagbB1oTDuJh
        0w9mP65jo3aLq7vBz5BUsDvmoblqI7heqywq
X-Google-Smtp-Source: AJdET5fuq6lK8spJiJhFmFn7JMGGOzZSapwJrB2L+WtGN5fcgHMx/vtr8VMzSPipK5A1nRaBU5dZXQ==
X-Received: by 2002:a19:5394:: with SMTP id h20mr5087696lfl.75.1541758089123;
        Fri, 09 Nov 2018 02:08:09 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:08 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 13/17] futex: Rework futex_lock_pi() to use rt_mutex_*_proxy_lock()
Date:   Fri,  9 Nov 2018 11:07:41 +0100
Message-Id: <1541758065-10952-14-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit cfafcd117da0216520568c195cb2f6cd1980c4bb upstream.

By changing futex_lock_pi() to use rt_mutex_*_proxy_lock() all wait_list
modifications are done under both hb->lock and wait_lock.

This closes the obvious interleave pattern between futex_lock_pi() and
futex_unlock_pi(), but not entirely so. See below:

Before:

futex_lock_pi()			futex_unlock_pi()
  unlock hb->lock

				  lock hb->lock
				  unlock hb->lock

				  lock rt_mutex->wait_lock
				  unlock rt_mutex_wait_lock
				    -EAGAIN

  lock rt_mutex->wait_lock
  list_add
  unlock rt_mutex->wait_lock

  schedule()

  lock rt_mutex->wait_lock
  list_del
  unlock rt_mutex->wait_lock

				  <idem>
				    -EAGAIN

  lock hb->lock

After:

futex_lock_pi()			futex_unlock_pi()

  lock hb->lock
  lock rt_mutex->wait_lock
  list_add
  unlock rt_mutex->wait_lock
  unlock hb->lock

  schedule()
				  lock hb->lock
				  unlock hb->lock
  lock hb->lock
  lock rt_mutex->wait_lock
  list_del
  unlock rt_mutex->wait_lock

				  lock rt_mutex->wait_lock
				  unlock rt_mutex_wait_lock
				    -EAGAIN

  unlock hb->lock

It does however solve the earlier starvation/live-lock scenario which got
introduced with the -EAGAIN since unlike the before scenario; where the
-EAGAIN happens while futex_unlock_pi() doesn't hold any locks; in the
after scenario it happens while futex_unlock_pi() actually holds a lock,
and then it is serialized on that lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104152.062785528@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  | 77 +++++++++++++++++++++++++++++------------
 kernel/locking/rtmutex.c        | 26 ++++----------
 kernel/locking/rtmutex_common.h |  1 -
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index dce3250..1cc40dd 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2112,20 +2112,7 @@ queue_unlock(struct futex_hash_bucket *hb)
 	hb_waiters_dec(hb);
 }
 
-/**
- * queue_me() - Enqueue the futex_q on the futex_hash_bucket
- * @q:	The futex_q to enqueue
- * @hb:	The destination hash bucket
- *
- * The hb->lock must be held by the caller, and is released here. A call to
- * queue_me() is typically paired with exactly one call to unqueue_me().  The
- * exceptions involve the PI related operations, which may use unqueue_me_pi()
- * or nothing if the unqueue is done as part of the wake process and the unqueue
- * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
- * an example).
- */
-static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
-	__releases(&hb->lock)
+static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	int prio;
 
@@ -2142,6 +2129,24 @@ static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 	plist_node_init(&q->list, prio);
 	plist_add(&q->list, &hb->chain);
 	q->task = current;
+}
+
+/**
+ * queue_me() - Enqueue the futex_q on the futex_hash_bucket
+ * @q:	The futex_q to enqueue
+ * @hb:	The destination hash bucket
+ *
+ * The hb->lock must be held by the caller, and is released here. A call to
+ * queue_me() is typically paired with exactly one call to unqueue_me().  The
+ * exceptions involve the PI related operations, which may use unqueue_me_pi()
+ * or nothing if the unqueue is done as part of the wake process and the unqueue
+ * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
+ * an example).
+ */
+static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
+	__releases(&hb->lock)
+{
+	__queue_me(q, hb);
 	spin_unlock(&hb->lock);
 }
 
@@ -2600,6 +2605,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 {
 	struct hrtimer_sleeper timeout, *to = NULL;
 	struct futex_pi_state *pi_state = NULL;
+	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
 	int res, ret;
@@ -2652,25 +2658,52 @@ retry_private:
 		}
 	}
 
+	WARN_ON(!q.pi_state);
+
 	/*
 	 * Only actually queue now that the atomic ops are done:
 	 */
-	queue_me(&q, hb);
+	__queue_me(&q, hb);
 
-	WARN_ON(!q.pi_state);
-	/*
-	 * Block on the PI mutex:
-	 */
-	if (!trylock) {
-		ret = rt_mutex_timed_futex_lock(&q.pi_state->pi_mutex, to);
-	} else {
+	if (trylock) {
 		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret = ret ? 0 : -EWOULDBLOCK;
+		goto no_block;
+	}
+
+	/*
+	 * We must add ourselves to the rt_mutex waitlist while holding hb->lock
+	 * such that the hb and rt_mutex wait lists match.
+	 */
+	rt_mutex_init_waiter(&rt_waiter);
+	ret = rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
+	if (ret) {
+		if (ret == 1)
+			ret = 0;
+
+		goto no_block;
 	}
 
+	spin_unlock(q.lock_ptr);
+
+	if (unlikely(to))
+		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
+
+	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
+
 	spin_lock(q.lock_ptr);
 	/*
+	 * If we failed to acquire the lock (signal/timeout), we must
+	 * first acquire the hb->lock before removing the lock from the
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
+	 * wait lists consistent.
+	 */
+	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
+		ret = 0;
+
+no_block:
+	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
 	 * haven't already.
 	 */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 78ecea6..3025f61 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1491,19 +1491,6 @@ int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
 
 /*
- * Futex variant with full deadlock detection.
- * Futex variants must not use the fast-path, see __rt_mutex_futex_unlock().
- */
-int __sched rt_mutex_timed_futex_lock(struct rt_mutex *lock,
-			      struct hrtimer_sleeper *timeout)
-{
-	might_sleep();
-
-	return rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE,
-				 timeout, RT_MUTEX_FULL_CHAINWALK);
-}
-
-/*
  * Futex variant, must not use fastpath.
  */
 int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
@@ -1772,12 +1759,6 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
 
-	/*
-	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
-	 * have to fix that up.
-	 */
-	fixup_rt_mutex_waiters(lock);
-
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
@@ -1817,6 +1798,13 @@ bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 		fixup_rt_mutex_waiters(lock);
 		cleanup = true;
 	}
+
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
+	 * have to fix that up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return cleanup;
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index fedd5ab..4fe3f32 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -113,7 +113,6 @@ extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
 				 struct rt_mutex_waiter *waiter);
 
-extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
 extern int rt_mutex_futex_trylock(struct rt_mutex *l);
 
 extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
-- 
2.7.4

