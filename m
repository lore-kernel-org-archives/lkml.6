Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB09C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8B52084D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R15kZP4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8B52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeGCOyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:54:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40892 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbeGCOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:54:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so2615965wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hucCf1D4eCiXY27B47L7elX17yrxxPa6MXmh2Uukqf4=;
        b=R15kZP4qBjsVUkQR//dYFW8bOM/uarUgctKJjZHW9w9Zv2b13pjVZQ52iSzqs/4ZDa
         Qx24T9JgCugBHqPPlorn8VtoqSj5InzrHTlESThikhLGxYgxYvH49ilhAPnzIMqwgPGy
         NQkLk3gOVUZBh7k4g5NKxFflt1ITWyg20GktU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hucCf1D4eCiXY27B47L7elX17yrxxPa6MXmh2Uukqf4=;
        b=r3akKx/dtk8DTfTSiL+XDWXX/A5oHVkg+uRpPi5b1x1oNYdc9raWJAJtmpfeHXFeKB
         rwa3Ok7OCEGvTf4OudUzhQaZCeWhWB4dpzOycv8360+yofphJCeXF6Zpi9MW34FmvbHl
         KcEJT2IPxvqFYmpklQCYJIlD+XbQ0knMxgWf51ebiTcdvOzvJyF6Yr1QU5PRno2EyeGN
         7RXrMXvQMn4UKt3Tfj0kDgnscyB9rKSrZ0aGL/xIvHoLQfyJzlito1lv0oevSpUQnPHl
         YWiAala0TJvGWriHek8zW4EYS9FZ6MhbsxNOPESgTx6wLCxGKgThtkUDZTIWAatwSU6h
         qNYA==
X-Gm-Message-State: APt69E0NZRMa+Ml/CQwXz1NbVW6cAbEEtDzjefMTG2FPf6ZCl91MQpiB
        subcPiyphbO2FuJocBx+5RQkyqAj
X-Google-Smtp-Source: AAOMgpcGIjEhtsXCWacHj1ZXtSl4fEQ/cyTXFfh4jvUucEq7PbthvN32BZhMj5a9lxmVr+uXQttFVQ==
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr8631908wmd.142.1530629652488;
        Tue, 03 Jul 2018 07:54:12 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id i4-v6sm2709132wmf.4.2018.07.03.07.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 07:54:11 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH v3 2/3] locking: Clarify requirements for smp_mb__after_spinlock()
Date:   Tue,  3 Jul 2018 16:53:59 +0200
Message-Id: <1530629639-27767-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 11 interpretations of the requirements described in the header
comment for smp_mb__after_spinlock(): one for each LKMM maintainer, and
one currently encoded in the Cat file. Stick to the latter (until a more
satisfactory solution is available).

This also reworks some snippets related to the barrier to illustrate the
requirements and to link them to the idioms which are relied upon at its
call sites.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
---
Changes since v2:
  - restore note about RCsc lock (Peter Zijlstra)
  - add Peter's Acked-by: tag

Changes since v1:
  - rework the snippets (Peter Zijlstra)
  - style fixes (Alan Stern and Matthew Wilcox)
  - add Boqun's Suggested-by: tag

 include/linux/spinlock.h | 53 ++++++++++++++++++++++++++++++++----------------
 kernel/sched/core.c      | 41 +++++++++++++++++++------------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a464358384..d70a06ff2bdd2 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -114,29 +114,48 @@ do {								\
 #endif /*arch_spin_is_contended*/
 
 /*
- * This barrier must provide two things:
+ * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
+ * between program-order earlier lock acquisitions and program-order later
+ * memory accesses.
  *
- *   - it must guarantee a STORE before the spin_lock() is ordered against a
- *     LOAD after it, see the comments at its two usage sites.
+ * This guarantees that the following two properties hold:
  *
- *   - it must ensure the critical section is RCsc.
+ *   1) Given the snippet:
  *
- * The latter is important for cases where we observe values written by other
- * CPUs in spin-loops, without barriers, while being subject to scheduling.
+ *	  { X = 0;  Y = 0; }
  *
- * CPU0			CPU1			CPU2
+ *	  CPU0				CPU1
  *
- *			for (;;) {
- *			  if (READ_ONCE(X))
- *			    break;
- *			}
- * X=1
- *			<sched-out>
- *						<sched-in>
- *						r = X;
+ *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
+ *	  spin_lock(S);			smp_mb();
+ *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
+ *	  r0 = READ_ONCE(Y);
+ *	  spin_unlock(S);
  *
- * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
- * we get migrated and CPU2 sees X==0.
+ *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
+ *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
+ *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
+ *      try_to_wake_up().
+ *
+ *   2) Given the snippet:
+ *
+ *  { X = 0;  Y = 0; }
+ *
+ *  CPU0		CPU1				CPU2
+ *
+ *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
+ *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
+ *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
+ *			WRITE_ONCE(Y, 1);
+ *			spin_unlock(S);
+ *
+ *      it is forbidden that CPU0's critical section executes before CPU1's
+ *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
+ *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
+ *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
+ *      snippets but "projected" onto two CPUs.
+ *
+ * Property (2) upgrades the lock to an RCsc lock.
  *
  * Since most load-store architectures implement ACQUIRE with an smp_mb() after
  * the LL/SC loop, they need no further barriers. Similarly all our TSO
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da8f12119a127..ec9ef0aec71ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
 	 * in smp_cond_load_acquire() below.
 	 *
-	 * sched_ttwu_pending()                 try_to_wake_up()
-	 *   [S] p->on_rq = 1;                  [L] P->state
-	 *       UNLOCK rq->lock  -----.
-	 *                              \
-	 *				 +---   RMB
-	 * schedule()                   /
-	 *       LOCK rq->lock    -----'
-	 *       UNLOCK rq->lock
+	 * sched_ttwu_pending()			try_to_wake_up()
+	 *   STORE p->on_rq = 1			  LOAD p->state
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   UNLOCK rq->lock
 	 *
 	 * [task p]
-	 *   [S] p->state = UNINTERRUPTIBLE     [L] p->on_rq
+	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
 	 *
-	 * Pairs with the UNLOCK+LOCK on rq->lock from the
-	 * last wakeup of our task and the schedule that got our task
-	 * current.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * One must be running (->on_cpu == 1) in order to remove oneself
 	 * from the runqueue.
 	 *
-	 *  [S] ->on_cpu = 1;	[L] ->on_rq
-	 *      UNLOCK rq->lock
-	 *			RMB
-	 *      LOCK   rq->lock
-	 *  [S] ->on_rq = 0;    [L] ->on_cpu
+	 * __schedule() (switch to task 'p')	try_to_wake_up()
+	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (put 'p' to sleep)
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
 	 *
-	 * Pairs with the full barrier implied in the UNLOCK+LOCK on rq->lock
-	 * from the consecutive calls to schedule(); the first switching to our
-	 * task, the second putting it to sleep.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 
-- 
2.7.4

