Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD85C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austad-us.20150623.gappssmtp.com header.i=@austad-us.20150623.gappssmtp.com header.b="CPbk4oBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=austad.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeKITsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:48:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35815 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeKITsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:48:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so1107338ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austad-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmmuPjVQCC39uva7CSEb9/qlbaw2LWTYmELO63IrntI=;
        b=CPbk4oBC1hC52OtOUBeNEkWD6BWers5crLA4E+dOHgux+nFgnUwCcTFsk/THOKWm+5
         iDoabCUc75XSoxnYqX/qAY9cSEDoJL5UD7DSq30w62b/N2+TfbdRUMBIbZXH0mJhsdiA
         dgdGdZimISwMW0GCX90Fus1iKFDVe5HROplnYC0rdqaUyCmg2z0lzxoJCI+PD82pjP4I
         Bm+Y0VCBhkO0hjT/uFDX/DK27v4yU5KQ3XDBuGonGoYUOCMNNUE98bzCMuQ1SLSoJlgs
         jg4eE5ybrCMfs8ZGS0b/I1kne0OD2aiY30sGD1uDOE7rlZ8wHKrfiNSHiqz73a9myUKY
         dQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmmuPjVQCC39uva7CSEb9/qlbaw2LWTYmELO63IrntI=;
        b=lZJrdgnIjPsQu5o5rLOvAuHsc/DwoT3KZt+O+EHXa4zGJ2Xpe+SHsf6ZpFvzPy/mwp
         tCL5dPD0PmtU/x1oRkwVTDilGVLPp5QSCKS2xg0ZCFAcqVQGly/brI834Vlq+RNmxOrk
         W/CiUQhw24tZXo72Yz4w+PlUrQTsi5Au/TVYU8k8hV6m2n4pUsXyPyMkZAIQociWMxsk
         /rSvnfvINAba9gAl95G2wVAw/UDpH6fMzoCGsscMEu36zRiszVXIKkDw3Pi5XptgKyd/
         RfY8EsbWR04cekYhnKJoaBEDQEcMacZa4wYT0DLsTBIkO9CWEusWwa3iwg7g1aaEJiVX
         mqbg==
X-Gm-Message-State: AGRZ1gJx5GCbE+jUzlR9a0cjVrfJCfE4t5vcMESCrRfmiA2gFaaQ7KQt
        bcuHw6bV2rLRv/pOV0nc0Bs3P7Jz5CUzxDCs
X-Google-Smtp-Source: AJdET5cH5IpfQJtqG6I4aObDjyDGGpGfmulBgi/ycnqIjr5ZEeCLfzvBOguPt+YdhOO4dvyLiKw5Lw==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr5141391lja.58.1541758094160;
        Fri, 09 Nov 2018 02:08:14 -0800 (PST)
Received: from sisyphus.home.austad.us (11.92-220-88.customer.lyse.net. [92.220.88.11])
        by smtp.gmail.com with ESMTPSA id u65sm1265576lff.54.2018.11.09.02.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 02:08:13 -0800 (PST)
From:   Henrik Austad <henrik@austad.us>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
        Xunlei Pang <xlpang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@arm.com,
        bigeasy@linutronix.de, mathieu.desnoyers@efficios.com,
        jdesfossez@efficios.com, bristot@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 17/17] sched/rtmutex/deadline: Fix a PI crash for deadline tasks
Date:   Fri,  9 Nov 2018 11:07:45 +0100
Message-Id: <1541758065-10952-18-git-send-email-henrik@austad.us>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541758065-10952-1-git-send-email-henrik@austad.us>
References: <1541758065-10952-1-git-send-email-henrik@austad.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xunlei Pang <xlpang@redhat.com>

commit e96a7705e7d3fef96aec9b590c63b2f6f7d2ba22 upstream.

A crash happened while I was playing with deadline PI rtmutex.

    BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
    IP: [<ffffffff810eeb8f>] rt_mutex_get_top_task+0x1f/0x30
    PGD 232a75067 PUD 230947067 PMD 0
    Oops: 0000 [#1] SMP
    CPU: 1 PID: 10994 Comm: a.out Not tainted

    Call Trace:
    [<ffffffff810b658c>] enqueue_task+0x2c/0x80
    [<ffffffff810ba763>] activate_task+0x23/0x30
    [<ffffffff810d0ab5>] pull_dl_task+0x1d5/0x260
    [<ffffffff810d0be6>] pre_schedule_dl+0x16/0x20
    [<ffffffff8164e783>] __schedule+0xd3/0x900
    [<ffffffff8164efd9>] schedule+0x29/0x70
    [<ffffffff8165035b>] __rt_mutex_slowlock+0x4b/0xc0
    [<ffffffff81650501>] rt_mutex_slowlock+0xd1/0x190
    [<ffffffff810eeb33>] rt_mutex_timed_lock+0x53/0x60
    [<ffffffff810ecbfc>] futex_lock_pi.isra.18+0x28c/0x390
    [<ffffffff810ed8b0>] do_futex+0x190/0x5b0
    [<ffffffff810edd50>] SyS_futex+0x80/0x180

This is because rt_mutex_enqueue_pi() and rt_mutex_dequeue_pi()
are only protected by pi_lock when operating pi waiters, while
rt_mutex_get_top_task(), will access them with rq lock held but
not holding pi_lock.

In order to tackle it, we introduce new "pi_top_task" pointer
cached in task_struct, and add new rt_mutex_update_top_task()
to update its value, it can be called by rt_mutex_setprio()
which held both owner's pi_lock and rq lock. Thus "pi_top_task"
can be safely accessed by enqueue_task_dl() under rq lock.

Originally-From: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Xunlei Pang <xlpang@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: juri.lelli@arm.com
Cc: bigeasy@linutronix.de
Cc: mathieu.desnoyers@efficios.com
Cc: jdesfossez@efficios.com
Cc: bristot@redhat.com
Link: http://lkml.kernel.org/r/20170323150216.157682758@infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Conflicts:
	include/linux/sched.h
Tested-by:Henrik Austad <haustad@cisco.com>
---
 include/linux/init_task.h |  1 +
 include/linux/sched.h     |  2 ++
 include/linux/sched/rt.h  |  1 +
 kernel/fork.c             |  1 +
 kernel/locking/rtmutex.c  | 29 +++++++++++++++++++++--------
 kernel/sched/core.c       |  2 ++
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 1c1ff7e..a561ce0c 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -162,6 +162,7 @@ extern struct task_group root_task_group;
 #ifdef CONFIG_RT_MUTEXES
 # define INIT_RT_MUTEXES(tsk)						\
 	.pi_waiters = RB_ROOT,						\
+	.pi_top_task = NULL,						\
 	.pi_waiters_leftmost = NULL,
 #else
 # define INIT_RT_MUTEXES(tsk)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b30540d..89cd0d0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1617,6 +1617,8 @@ struct task_struct {
 	/* PI waiters blocked on a rt_mutex held by this task */
 	struct rb_root pi_waiters;
 	struct rb_node *pi_waiters_leftmost;
+	/* Updated under owner's pi_lock and rq lock */
+	struct task_struct		*pi_top_task;
 	/* Deadlock detection and priority inheritance handling */
 	struct rt_mutex_waiter *pi_blocked_on;
 #endif
diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index a30b172..60d0c47 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -19,6 +19,7 @@ static inline int rt_task(struct task_struct *p)
 extern int rt_mutex_getprio(struct task_struct *p);
 extern void rt_mutex_setprio(struct task_struct *p, int prio);
 extern int rt_mutex_get_effective_prio(struct task_struct *task, int newprio);
+extern void rt_mutex_update_top_task(struct task_struct *p);
 extern struct task_struct *rt_mutex_get_top_task(struct task_struct *task);
 extern void rt_mutex_adjust_pi(struct task_struct *p);
 static inline bool tsk_is_pi_blocked(struct task_struct *tsk)
diff --git a/kernel/fork.c b/kernel/fork.c
index dd2f79a..9376270 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1242,6 +1242,7 @@ static void rt_mutex_init_task(struct task_struct *p)
 #ifdef CONFIG_RT_MUTEXES
 	p->pi_waiters = RB_ROOT;
 	p->pi_waiters_leftmost = NULL;
+	p->pi_top_task = NULL;
 	p->pi_blocked_on = NULL;
 #endif
 }
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c01d7f4..dd3b1e9 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -321,6 +321,19 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 }
 
 /*
+ * Must hold both p->pi_lock and task_rq(p)->lock.
+ */
+void rt_mutex_update_top_task(struct task_struct *p)
+{
+	if (!task_has_pi_waiters(p)) {
+		p->pi_top_task = NULL;
+		return;
+	}
+
+	p->pi_top_task = task_top_pi_waiter(p)->task;
+}
+
+/*
  * Calculate task priority from the waiter tree priority
  *
  * Return task->normal_prio when the waiter tree is empty or when
@@ -335,12 +348,12 @@ int rt_mutex_getprio(struct task_struct *task)
 		   task->normal_prio);
 }
 
+/*
+ * Must hold either p->pi_lock or task_rq(p)->lock.
+ */
 struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
 {
-	if (likely(!task_has_pi_waiters(task)))
-		return NULL;
-
-	return task_top_pi_waiter(task)->task;
+	return task->pi_top_task;
 }
 
 /*
@@ -349,12 +362,12 @@ struct task_struct *rt_mutex_get_top_task(struct task_struct *task)
  */
 int rt_mutex_get_effective_prio(struct task_struct *task, int newprio)
 {
-	if (!task_has_pi_waiters(task))
+	struct task_struct *top_task = rt_mutex_get_top_task(task);
+
+	if (!top_task)
 		return newprio;
 
-	if (task_top_pi_waiter(task)->task->prio <= newprio)
-		return task_top_pi_waiter(task)->task->prio;
-	return newprio;
+	return min(top_task->prio, newprio);
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 65ed350..0c24d1f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3417,6 +3417,8 @@ void rt_mutex_setprio(struct task_struct *p, int prio)
 		goto out_unlock;
 	}
 
+	rt_mutex_update_top_task(p);
+
 	trace_sched_pi_setprio(p, prio);
 	oldprio = p->prio;
 	prev_class = p->sched_class;
-- 
2.7.4

