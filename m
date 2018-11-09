Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDCC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009E820883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="CBzyzSVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009E820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeKITrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:47:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37826 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeKITrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:47:51 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so914987lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qv1gJptpDadZ7xmFGWambplvl4vFsB88kJL0ym+PObY=;
        b=CBzyzSVbSRQt4tmbJxUg5TUxNIKIo0u5cosWt/d6OhNGb8DmD2UZ42Eq53Ypz1FEAn
         hBm/ab+Cf5xO1u1rOcd2B6HP9FQqUJ5ofCj49Oflfx/6D6h9WHsbcBe10kW+2pVRFEJL
         sbYK4H+7MO9jUZPSAukK6u0T23JDi2FKLmvIMCaZ6eBZTuneAteOsyATAYTO/VQREWpT
         NzZVQvg3hPyFbmBDtD/+kNEpwLvd5A6A5T9l3MkPyjMAJoDQLLeT9bQJA5ZcmF/3v58G
         UYgdow9T7/NUbefnfKerL1rNi6n30/Xyk7/MRhc0yvY5Tq5MKhpTJRA0/aKWGSvMkNZC
         M1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qv1gJptpDadZ7xmFGWambplvl4vFsB88kJL0ym+PObY=;
        b=MXO65+95Zq7qA7a/8Nna/s7gHMOCskzqMcAmd9KO1EyIpxPL06xWxQczsAYMd6rrT2
         TqM/XTaauPkazt+0h4GWOhjsSFgS3tvg+ZIWSeFkCh9s0zjuR53rpEmPq/0OIWxQKYII
         M0mvSnoK3G5Qd5OnZu1NvHvpIQFWjGpmmw1KkJbTHmVpNpFjAbaUUoYYKp1/51x2N5fK
         gCn9mHKLGIdP2ibf/1r5Yby/aFOrHxrCBLGjQDSom27CvW8vy5fJGGsWv+ZIqJs+RtGR
         koal52KoA8BXZW1wkcQ0sVQWjEPPTXWlzgtWf0CiXV0dNUkGWS9mgHmBxW16HW5F6D6M
         GefA==
X-Gm-Message-State: AGRZ1gIKoCDpV1uoplalgBHdTmz2YYDAPDeeou022rV2GMRPyvfA2Xof
        Lz0D7rzBH4vs4ELDffc9aJRX7ziueucBgdy2
X-Google-Smtp-Source: AJdET5fSgPNqh4tJXIwdR/HTGQXuhQLITFxjzhvoGWX7XNrPfTEaCztuvQXr3gJLfSOID3nijqX7gA==
X-Received: by 2002:a19:d295:: with SMTP id j143mr4904496lfg.50.1541758075867;
        Fri, 09 Nov 2018 02:07:55 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:07:55 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, xlpang@redhat.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jdesfossez@efficios.com,
        dvhart@infradead.org, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 03/17] futex: Remove rt_mutex_deadlock_account_*()
Date:   Fri,  9 Nov 2018 11:07:31 +0100
Message-Id: <1541758065-10952-4-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

commit fffa954fb528963c2fb7b0c0084eb77e2be7ab52 upstream

These are unused and clutter up the code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: xlpang@redhat.com
Cc: rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: dvhart@infradead.org
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170322104151.652692478@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Conflicts:
	kernel/locking/rtmutex.c (WAKE_Q)
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/locking/rtmutex-debug.c |  9 --------
 kernel/locking/rtmutex-debug.h |  3 ---
 kernel/locking/rtmutex.c       | 47 ++++++++++++++++--------------------------
 kernel/locking/rtmutex.h       |  2 --
 4 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 62b6cee..0613c4b 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -173,12 +173,3 @@ void debug_rt_mutex_init(struct rt_mutex *lock, const char *name)
 	lock->name = name;
 }
 
-void
-rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task)
-{
-}
-
-void rt_mutex_deadlock_account_unlock(struct task_struct *task)
-{
-}
-
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index d0519c3..b585af9 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -9,9 +9,6 @@
  * This file contains macros used solely by rtmutex.c. Debug version.
  */
 
-extern void
-rt_mutex_deadlock_account_lock(struct rt_mutex *lock, struct task_struct *task);
-extern void rt_mutex_deadlock_account_unlock(struct task_struct *task);
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b066724d..6cf9dab7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -937,8 +937,6 @@ takeit:
 	 */
 	rt_mutex_set_owner(lock, task);
 
-	rt_mutex_deadlock_account_lock(lock, task);
-
 	return 1;
 }
 
@@ -1331,8 +1329,6 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 
 	debug_rt_mutex_unlock(lock);
 
-	rt_mutex_deadlock_account_unlock(current);
-
 	/*
 	 * We must be careful here if the fast path is enabled. If we
 	 * have no waiters queued we cannot set owner to NULL here
@@ -1398,11 +1394,10 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 				struct hrtimer_sleeper *timeout,
 				enum rtmutex_chainwalk chwalk))
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-	} else
-		return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
+
+	return slowfn(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
 }
 
 static inline int
@@ -1414,21 +1409,19 @@ rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
 				      enum rtmutex_chainwalk chwalk))
 {
 	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
-	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-	} else
-		return slowfn(lock, state, timeout, chwalk);
+
+	return slowfn(lock, state, timeout, chwalk);
 }
 
 static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current))) {
-		rt_mutex_deadlock_account_lock(lock, current);
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 1;
-	}
+
 	return slowfn(lock);
 }
 
@@ -1438,19 +1431,18 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 				   struct wake_q_head *wqh))
 {
 	WAKE_Q(wake_q);
+	bool deboost;
 
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
-		rt_mutex_deadlock_account_unlock(current);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
 
-	} else {
-		bool deboost = slowfn(lock, &wake_q);
+	deboost = slowfn(lock, &wake_q);
 
-		wake_up_q(&wake_q);
+	wake_up_q(&wake_q);
 
-		/* Undo pi boosting if necessary: */
-		if (deboost)
-			rt_mutex_adjust_prio(current);
-	}
+	/* Undo pi boosting if necessary: */
+	if (deboost)
+		rt_mutex_adjust_prio(current);
 }
 
 /**
@@ -1561,10 +1553,9 @@ EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 bool __sched rt_mutex_futex_unlock(struct rt_mutex *lock,
 				   struct wake_q_head *wqh)
 {
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL))) {
-		rt_mutex_deadlock_account_unlock(current);
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
 		return false;
-	}
+
 	return rt_mutex_slowunlock(lock, wqh);
 }
 
@@ -1622,7 +1613,6 @@ void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 	__rt_mutex_init(lock, NULL);
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
-	rt_mutex_deadlock_account_lock(lock, proxy_owner);
 }
 
 /**
@@ -1638,7 +1628,6 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 {
 	debug_rt_mutex_proxy_unlock(lock);
 	rt_mutex_set_owner(lock, NULL);
-	rt_mutex_deadlock_account_unlock(proxy_owner);
 }
 
 /**
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index c406058..6607802 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -11,8 +11,6 @@
  */
 
 #define rt_mutex_deadlock_check(l)			(0)
-#define rt_mutex_deadlock_account_lock(m, t)		do { } while (0)
-#define rt_mutex_deadlock_account_unlock(l)		do { } while (0)
 #define debug_rt_mutex_init_waiter(w)			do { } while (0)
 #define debug_rt_mutex_free_waiter(w)			do { } while (0)
 #define debug_rt_mutex_lock(l)				do { } while (0)
-- 
2.7.4

