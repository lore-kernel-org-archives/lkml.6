Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058AC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BAA20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="f8fVgX7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BAA20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeKITsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44193 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeKITsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so1075623lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1VPo3IJRtNG1CUf1OLI6N1VCfwzzhW+LvqOeNMOYDXE=;
        b=f8fVgX7/cb7ZJRFg1Lv83FqmNVwOF7sIO5UNZLQOaKQ9MnY6S+psICFW6FrGF+uWbZ
         WPIW2Tqowo8pj+msGIdqh2vUheavydxZXkAsAAUUZFAsgVcgT5/wQfpU4+1438wmvINk
         w+CfAR1zDKIgNjYrolk8JEOCC/sBcvMPsMak8ezBM04EjpU2IiFIxEjXr0bV2C70Rpmu
         Nbv4RFWwsjTxn/xdIpDVFIrwhmcZFjKk/9hrB1oRMX9Gulevq4E0+t249V0+XvgxIMJr
         GNzFp9kuG8P817l8YM6uPl29jpcxfwmlYfmdJ0jvnb0f3WbL7ZfswUx05h+5O24f1Q67
         Mwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1VPo3IJRtNG1CUf1OLI6N1VCfwzzhW+LvqOeNMOYDXE=;
        b=WSv8hLO0oP9/Sj5bJO8ZlmIbbke+BDYPvwq/jfbEK1z/gnSuZkG2R/pEbQSrxQ6jg6
         SJHNE0kBo28b8oLJ1aHNj+Di3tLY6ak9vqZ6ppejbIxzAwytSkxV7RYVPSOTnCL2i9BZ
         CwnzDgIP4xLBJ9R4tPL537a/jojV3cpf0bITJCLD/eLYM05FNioac8/MJE3ooWPbYrx8
         d5ukMIA4gjJAF+qTUuoqye3Z+Xr4hXe8dHSqU2Y4OB/N4Jzcmek/LRD9MYRS4hMsabZA
         tjdJvUm+WIvghdFXkKfDDwBzke8bjZLJ17U/tMpfMY3IW3KjduDD3w7MV5kEtbFokj0X
         TBYg==
X-Gm-Message-State: AGRZ1gIwo0PO9uNM18oxEYiKqp2/EwHme/5ZWkko5jO3EcM0u+FIaB1a
        Bv1rfZ6Daf+Z7nJnJx0S6pbk4ah7btSVTloA
X-Google-Smtp-Source: AJdET5c0CDzYUnVcQPU8wQA7G7NOaByMI4Dl5YxytwfX93neqDVsx80Wo6v7HB2covZ5MmkJ65jy3g==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr4879026ljh.137.1541758091578;
        Fri, 09 Nov 2018 02:08:11 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:10 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 15/17] futex: Drop hb->lock before enqueueing on the rtmutex
Date:   Fri,  9 Nov 2018 11:07:43 +0100
Message-Id: <1541758065-10952-16-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 56222b212e8edb1cf51f5dd73ff645809b082b40 upstream.

When PREEMPT_RT_FULL does the spinlock -> rt_mutex substitution the PI
chain code will (falsely) report a deadlock and BUG.

The problem is that it hold hb->lock (now an rt_mutex) while doing
task_blocks_on_rt_mutex on the futex's pi_state::rtmutex. This, when
interleaved just right with futex_unlock_pi() leads it to believe to see an
AB-BA deadlock.

  Task1 (holds rt_mutex,	Task2 (does FUTEX_LOCK_PI)
         does FUTEX_UNLOCK_PI)

				lock hb->lock
				lock rt_mutex (as per start_proxy)
  lock hb->lock

Which is a trivial AB-BA.

It is not an actual deadlock, because it won't be holding hb->lock by the
time it actually blocks on the rt_mutex, but the chainwalk code doesn't
know that and it would be a nightmare to handle this gracefully.

To avoid this problem, do the same as in futex_unlock_pi() and drop
hb->lock after acquiring wait_lock. This still fully serializes against
futex_unlock_pi(), since adding to the wait_list does the very same lock
dance, and removing it holds both locks.

Aside of solving the RT problem this makes the lock and unlock mechanism
symetric and reduces the hb->lock held time.

Reported-and-tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104152.161341537@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  | 30 +++++++++++++++++--------
 kernel/locking/rtmutex.c        | 49 +++++++++++++++++++++++------------------
 kernel/locking/rtmutex_common.h |  3 +++
 3 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 14d270e..afb02a7 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2667,20 +2667,33 @@ retry_private:
 		goto no_block;
 	}
 
+	rt_mutex_init_waiter(&rt_waiter);
+
 	/*
-	 * We must add ourselves to the rt_mutex waitlist while holding hb->lock
-	 * such that the hb and rt_mutex wait lists match.
+	 * On PREEMPT_RT_FULL, when hb->lock becomes an rt_mutex, we must not
+	 * hold it while doing rt_mutex_start_proxy(), because then it will
+	 * include hb->lock in the blocking chain, even through we'll not in
+	 * fact hold it while blocking. This will lead it to report -EDEADLK
+	 * and BUG when futex_unlock_pi() interleaves with this.
+	 *
+	 * Therefore acquire wait_lock while holding hb->lock, but drop the
+	 * latter before calling rt_mutex_start_proxy_lock(). This still fully
+	 * serializes against futex_unlock_pi() as that does the exact same
+	 * lock handoff sequence.
 	 */
-	rt_mutex_init_waiter(&rt_waiter);
-	ret = rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
+	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
+	spin_unlock(q.lock_ptr);
+	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
+	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+
 	if (ret) {
 		if (ret == 1)
 			ret = 0;
 
+		spin_lock(q.lock_ptr);
 		goto no_block;
 	}
 
-	spin_unlock(q.lock_ptr);
 
 	if (unlikely(to))
 		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
@@ -2693,6 +2706,9 @@ retry_private:
 	 * first acquire the hb->lock before removing the lock from the
 	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
 	 * wait lists consistent.
+	 *
+	 * In particular; it is important that futex_unlock_pi() can not
+	 * observe this inconsistency.
 	 */
 	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter))
 		ret = 0;
@@ -2804,10 +2820,6 @@ retry:
 
 		get_pi_state(pi_state);
 		/*
-		 * Since modifying the wait_list is done while holding both
-		 * hb->lock and wait_lock, holding either is sufficient to
-		 * observe it.
-		 *
 		 * By taking wait_lock while still holding hb->lock, we ensure
 		 * there is no point where we hold neither; and therefore
 		 * wake_futex_pi() must observe a state consistent with what we
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3025f61..b061a79 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1659,31 +1659,14 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
-/**
- * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
- * @lock:		the rt_mutex to take
- * @waiter:		the pre-initialized rt_mutex_waiter
- * @task:		the task to prepare
- *
- * Returns:
- *  0 - task blocked on lock
- *  1 - acquired the lock for task, caller should wake it up
- * <0 - error
- *
- * Special API call for FUTEX_REQUEUE_PI support.
- */
-int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
 			      struct task_struct *task)
 {
 	int ret;
 
-	raw_spin_lock_irq(&lock->wait_lock);
-
-	if (try_to_take_rt_mutex(lock, task, NULL)) {
-		raw_spin_unlock_irq(&lock->wait_lock);
+	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
-	}
 
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task,
@@ -1702,14 +1685,38 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	if (unlikely(ret))
 		remove_waiter(lock, waiter);
 
-	raw_spin_unlock_irq(&lock->wait_lock);
-
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
 }
 
 /**
+ * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for FUTEX_REQUEUE_PI support.
+ */
+int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+			      struct rt_mutex_waiter *waiter,
+			      struct task_struct *task)
+{
+	int ret;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return ret;
+}
+
+/**
  * rt_mutex_next_owner - return the next owner of the lock
  *
  * @lock: the rt lock query
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 4fe3f32..25ccf71 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -104,6 +104,9 @@ extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 extern void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 				  struct task_struct *proxy_owner);
 extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
+extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
+				     struct rt_mutex_waiter *waiter,
+				     struct task_struct *task);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-- 
2.7.4

