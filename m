Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D265CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0D520883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="mzEQwtPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0D520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKITsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37859 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeKITsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so1104389lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v/k9BkQUxbARxvKyL2eneNsMx5yJhb9EYV8uPmDTfbM=;
        b=mzEQwtPSbBJybIk5vUOLeiTRtfNPrAdYMIByd5Jiwxfv1vDgBvlneM8OROxpYSKbG7
         N89Dk02kSYr15kUz5utdcilum6rYzpsTYWWSJC2Kz/VnYioBu1Kkjki+XnGPlG2kSugF
         i5oiDZQqaq5Vf0GhFOznwOMzh/xQb7+R/uiipNqebHZxqKzqHG84xz0ryloVq3z27Hgs
         od8R+U0gtrOjyuJTNDAnSC3caV6YuGxZ67UtON534cQ+3msCVrRMKNwpjXI/KOR/uRdr
         OStf3uBUa8j/g82ZmB3Mxld9X2rWvrxAMO0DQqtuoWSS0ZLtHMdREh25/+n93w+TV8oL
         mcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v/k9BkQUxbARxvKyL2eneNsMx5yJhb9EYV8uPmDTfbM=;
        b=j7b7Y9Naif9igjmaIce0JcIj2cB5RENrGP9Tes696HwdMkSsuF3fZMTpo+7UIBeWYg
         xfb6ejVitVA+7+AUzHl95mLordgn9+fFC9ZaO2EJ3Dk/9GIgif+fSWpSty/Zf3IfFpcg
         47laqUc+JYfbfAjDgJs8fI/3f517NHG9Lrala7A0kaRuB+9d4gAoOLWW0OBDH8qYG8vP
         QvZesDHee06rKXmmTeFYTZJzRctgRc2DgzWpYLOWQ4BtID55rDPho28gQzh1waccMOBB
         facmNYLXx0HADLj40aocKQObNH5NI66/L0a2WLbAQXvLhRRf3OkEWJ/1g9WuJ4x3lDWD
         c6Rg==
X-Gm-Message-State: AGRZ1gLKCCvsUjIJ18YqTJCPUwX+Y8Xfwzh5Mq5PN+7BwZMnkHs4Op7L
        6RDnmkLgvGkKUfqJMe5CDUrvOhqvYKRAEJfV
X-Google-Smtp-Source: AJdET5d7Wy33mAsMN11+P5400IttcRgdObv87+xsZ5Bq3xJqHdg+yjzFfwpYaexViGO8Mg1eU12d+A==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr5041817ljc.66.1541758092895;
        Fri, 09 Nov 2018 02:08:12 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:12 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Xunlei Pang <xlpang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, mathieu.desnoyers@efficios.com,
        jdesfossez@efficios.com, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 16/17] rtmutex: Deboost before waking up the top waiter
Date:   Fri,  9 Nov 2018 11:07:44 +0100
Message-Id: <1541758065-10952-17-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xunlei Pang <xlpang@redhat.com>

commit 2a1c6029940675abb2217b590512dbf691867ec4 upstream.

We should deboost before waking the high-priority task, such that we
don't run two tasks with the same "state" (priority, deadline,
sched_class, etc).

In order to make sure the boosting task doesn't start running between
unlock and deboost (due to 'spurious' wakeup), we move the deboost
under the wait_lock, that way its serialized against the wait loop in
__rt_mutex_slowlock().

Doing the deboost early can however lead to priority-inversion if
current would get preempted after the deboost but before waking our
high-prio task, hence we disable preemption before doing deboost, and
enabling it after the wake up is over.

This gets us the right semantic order, but most importantly however;
this change ensures pointer stability for the next patch, where we
have rt_mutex_setprio() cache a pointer to the top-most waiter task.
If we, as before this change, do the wakeup first and then deboost,
this pointer might point into thin air.

[peterz: Changelog + patch munging]
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170323150216.110065320@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 kernel/futex.c                  |  5 +---
 kernel/locking/rtmutex.c        | 59 ++++++++++++++++++++++-------------------
 kernel/locking/rtmutex_common.h |  2 +-
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index afb02a7..63fa840 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1457,10 +1457,7 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 
-	if (deboost) {
-		wake_up_q(&wake_q);
-		rt_mutex_adjust_prio(current);
-	}
+	rt_mutex_postunlock(&wake_q, deboost);
 
 	return ret;
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b061a79..c01d7f4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -371,24 +371,6 @@ static void __rt_mutex_adjust_prio(struct task_struct *task)
 }
 
 /*
- * Adjust task priority (undo boosting). Called from the exit path of
- * rt_mutex_slowunlock() and rt_mutex_slowlock().
- *
- * (Note: We do this outside of the protection of lock->wait_lock to
- * allow the lock to be taken while or before we readjust the priority
- * of task. We do not use the spin_xx_mutex() variants here as we are
- * outside of the debug path.)
- */
-void rt_mutex_adjust_prio(struct task_struct *task)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
-	__rt_mutex_adjust_prio(task);
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-}
-
-/*
  * Deadlock detection is conditional:
  *
  * If CONFIG_DEBUG_RT_MUTEXES=n, deadlock detection is only conducted
@@ -1049,6 +1031,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 * lock->wait_lock.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
+	__rt_mutex_adjust_prio(current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1391,6 +1374,16 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	mark_wakeup_next_waiter(wake_q, lock);
 
+	/*
+	 * We should deboost before waking the top waiter task such that
+	 * we don't run two tasks with the 'same' priority. This however
+	 * can lead to prio-inversion if we would get preempted after
+	 * the deboost but before waking our high-prio task, hence the
+	 * preempt_disable before unlock. Pairs with preempt_enable() in
+	 * rt_mutex_postunlock();
+	 */
+	preempt_disable();
+
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 
 	/* check PI boosting */
@@ -1440,6 +1433,18 @@ rt_mutex_fasttrylock(struct rt_mutex *lock,
 	return slowfn(lock);
 }
 
+/*
+ * Undo pi boosting (if necessary) and wake top waiter.
+ */
+void rt_mutex_postunlock(struct wake_q_head *wake_q, bool deboost)
+{
+	wake_up_q(wake_q);
+
+	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	if (deboost)
+		preempt_enable();
+}
+
 static inline void
 rt_mutex_fastunlock(struct rt_mutex *lock,
 		    bool (*slowfn)(struct rt_mutex *lock,
@@ -1453,11 +1458,7 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 
 	deboost = slowfn(lock, &wake_q);
 
-	wake_up_q(&wake_q);
-
-	/* Undo pi boosting if necessary: */
-	if (deboost)
-		rt_mutex_adjust_prio(current);
+	rt_mutex_postunlock(&wake_q, deboost);
 }
 
 /**
@@ -1570,6 +1571,13 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 	}
 
 	mark_wakeup_next_waiter(wake_q, lock);
+	/*
+	 * We've already deboosted, retain preempt_disabled when dropping
+	 * the wait_lock to avoid inversion until the wakeup. Matched
+	 * by rt_mutex_postunlock();
+	 */
+	preempt_disable();
+
 	return true; /* deboost and wakeups */
 }
 
@@ -1582,10 +1590,7 @@ void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
 	deboost = __rt_mutex_futex_unlock(lock, &wake_q);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
-	if (deboost) {
-		wake_up_q(&wake_q);
-		rt_mutex_adjust_prio(current);
-	}
+	rt_mutex_postunlock(&wake_q, deboost);
 }
 
 /**
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 25ccf71..6f07357 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -122,7 +122,7 @@ extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
 				 struct wake_q_head *wqh);
 
-extern void rt_mutex_adjust_prio(struct task_struct *task);
+extern void rt_mutex_postunlock(struct wake_q_head *wake_q, bool deboost);
 
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 # include "rtmutex-debug.h"
-- 
2.7.4

