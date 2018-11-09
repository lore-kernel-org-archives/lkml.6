Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111DCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="N1gAtgOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A2E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeKITsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38508 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbeKITsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so914902lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESRDNGG5rHe6B1+JK3513LPxadxkE9PyzVQyEQUbrg8=;
        b=N1gAtgOuMum1935ZucduXxAAvsz5mp+FYliFf5TGQcK/H115dZnwvjm7AmxsZHbpR2
         6x+2xxewIo51YDYkLsQIX84lcQRCiLBRVx0hHhP3UXdoDQ9GO8rmfa5aXE+w6/NNYVL9
         e2JkslT9TXfJI89eAZ0xlZhTXiNUUqM6eOqcC3pPzVSBkCUR87fjnzkm+T62FonVWRTo
         AjZUzbNvJAeTOVEB9LcnKpXYA/p1IXaTPmMmVWBifpEUks8V37KvhW3HUpg68q7gsvjC
         4BJIo6/KB+CFS6VqqqH+IzRFzRUd5cJ8fpdXP8snOOboRFINIkumCKdPFUD7lHGj3Uuo
         YRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESRDNGG5rHe6B1+JK3513LPxadxkE9PyzVQyEQUbrg8=;
        b=fJ6iSEFhUVUtRh0KD17SFxsl4gHGX3RynsFB8TMfE5g9wDNOWcI0giZKKNy0B+8QKB
         cxUhKfueMz2d0oqMDTYnM+nL/NJSOLYAy2HaNGWoFgzs6H4Qczsi32SGugfs/Z8RQSAk
         ZYPD54GxES6skBky8A+TbGG/WPIm2bHYMZI0gG+BRSnWE3dwlibfH5EY4JVSwWVWvcTL
         Vt8MPCbZgfpKB8P6Fae0rxPTSkiKy44JmBc+3s/dD2kFnKyIdACZGVHTctQgwX8enrPz
         mBPCdNbpJjtu0iWwag0yQG2mcmAMd0EiAtFUCf5XYnT+B5uoVEWjfC8TOHXXjXNMSs7B
         dsag==
X-Gm-Message-State: AGRZ1gIB7vUdcv4N1ZRkD30AOHPCpuQVPl8tPOAu4tNMzG8evqzbf8eA
        wW+h8ibYCYsEXaseaA1VcQRtkIVC/dS4pIq7
X-Google-Smtp-Source: AJdET5cZVQkIsTeW3B74Gw1C+2Xnvth41brf21NujoxaUZD8WsMMSD4ZRY/EEJJW30MSgOwCEcOGig==
X-Received: by 2002:a19:48d0:: with SMTP id v199mr5107634lfa.104.1541758087916;
        Fri, 09 Nov 2018 02:08:07 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:07 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 12/17] futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()
Date:   Fri,  9 Nov 2018 11:07:40 +0100
Message-Id: <1541758065-10952-13-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit 38d589f2fd08f1296aea3ce62bebd185125c6d81 upstream.

With the ultimate goal of keeping rt_mutex wait_list and futex_q waiters
consistent it's necessary to split 'rt_mutex_futex_lock()' into finer
parts, such that only the actual blocking can be done without hb->lock
held.

Split split_mutex_finish_proxy_lock() into two parts, one that does the
blocking and one that does remove_waiter() when the lock acquire failed.

When the rtmutex was acquired successfully the waiter can be removed in the
acquisiton path safely, since there is no concurrency on the lock owner.

This means that, except for futex_lock_pi(), all wait_list modifications
are done with both hb->lock and wait_lock held.

[bigeasy@linutronix.de: fix for futex_requeue_pi_signal_restart]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104152.001659630@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  |  7 ++++--
 kernel/locking/rtmutex.c        | 52 +++++++++++++++++++++++++++++++++++------
 kernel/locking/rtmutex_common.h |  8 ++++---
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 4d70fd7..dce3250 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3045,10 +3045,13 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		WARN_ON(!q.pi_state);
 		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_finish_proxy_lock(pi_mutex, to, &rt_waiter);
-		debug_rt_mutex_free_waiter(&rt_waiter);
+		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
 
 		spin_lock(q.lock_ptr);
+		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
+			ret = 0;
+
+		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
 		 * haven't already.
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8778ac3..78ecea6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1743,21 +1743,23 @@ struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
 }
 
 /**
- * rt_mutex_finish_proxy_lock() - Complete lock acquisition
+ * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Complete the lock acquisition started our behalf by another thread.
+ * Wait for the the lock acquisition started on our behalf by
+ * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
+ * rt_mutex_cleanup_proxy_lock().
  *
  * Returns:
  *  0 - success
  * <0 - error, one of -EINTR, -ETIMEDOUT
  *
- * Special API call for PI-futex requeue support
+ * Special API call for PI-futex support
  */
-int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
+int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *to,
 			       struct rt_mutex_waiter *waiter)
 {
@@ -1770,9 +1772,6 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 	/* sleep on the mutex */
 	ret = __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
 
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-
 	/*
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
@@ -1783,3 +1782,42 @@ int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
 
 	return ret;
 }
+
+/**
+ * rt_mutex_cleanup_proxy_lock() - Cleanup failed lock acquisition
+ * @lock:		the rt_mutex we were woken on
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ *
+ * Attempt to clean up after a failed rt_mutex_wait_proxy_lock().
+ *
+ * Unless we acquired the lock; we're still enqueued on the wait-list and can
+ * in fact still be granted ownership until we're removed. Therefore we can
+ * find we are in fact the owner and must disregard the
+ * rt_mutex_wait_proxy_lock() failure.
+ *
+ * Returns:
+ *  true  - did the cleanup, we done.
+ *  false - we acquired the lock after rt_mutex_wait_proxy_lock() returned,
+ *          caller should disregards its return value.
+ *
+ * Special API call for PI-futex support
+ */
+bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter)
+{
+	bool cleanup = false;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	/*
+	 * Unless we're the owner; we're still enqueued on the wait_list.
+	 * So check if we became owner, if not, take us off the wait_list.
+	 */
+	if (rt_mutex_owner(lock) != current) {
+		remove_waiter(lock, waiter);
+		fixup_rt_mutex_waiters(lock);
+		cleanup = true;
+	}
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return cleanup;
+}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index d16de236..fedd5ab 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -107,9 +107,11 @@ extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
-extern int rt_mutex_finish_proxy_lock(struct rt_mutex *lock,
-				      struct hrtimer_sleeper *to,
-				      struct rt_mutex_waiter *waiter);
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
+			       struct hrtimer_sleeper *to,
+			       struct rt_mutex_waiter *waiter);
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
+				 struct rt_mutex_waiter *waiter);
 
 extern int rt_mutex_timed_futex_lock(struct rt_mutex *l, struct hrtimer_sleeper *to);
 extern int rt_mutex_futex_trylock(struct rt_mutex *l);
-- 
2.7.4

