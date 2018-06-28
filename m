Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA9C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232B627239
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PTqUcCcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232B627239
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbeF1KoF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:44:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38481 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbeF1KoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:44:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so5008261wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+o2dgLDFB/+vYRLevrlZcG2GNnMvg47JziItGrbXb8Q=;
        b=PTqUcCcK1wBagpht4Uh1zOUA+bn7Ua/WMm98q5eVhQNamb5AYbYeeGfj3c0orILOxI
         O2z0UT/F567orrnpMwizUkxsZOjmuinegnjW227cj0GeLULkIN8PYrmhtXX2TxdQjhwm
         aP+zOUCrBmMQMzYrm0O0jUILxVJSWnQwVQnHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+o2dgLDFB/+vYRLevrlZcG2GNnMvg47JziItGrbXb8Q=;
        b=cGjS/1jZ3v3Fkk/oDn3XO42fBX2Psz5WWV7cDjxN2vNwquE+oCVH8i0KQ1UEOvi4IC
         GXqmYErkcGSP2xHvDKcWFP4feG26VsqC79hlDEpJNRpd6/8BBG8JrHWtMRtqJGGSKmTY
         BK09ew5Mq240YsuZKCCQxPSbiJXMp+zIaJV2wChjSHVYVFYvOg65/wE9T0E2QY5yOfAW
         Vb4PClEEtEaW/tPU8u+5wtzSFgzbAGQYrjp2MfeCdSJ3Ow/VCAPnTzQrXJmDK+JftLrF
         5UA+1tvE4I86Zxse+ls7B6qSa4+drDOZd17HjOE2slF6yMGqTTpaxhEA7CPAnv4t4tI8
         hIjg==
X-Gm-Message-State: APt69E0XDiEkIze1ORUaErYyqOhNuP0hWvvIfls64U7/+y00C9UlMUVG
        +GjHrelilPAS1ZlRstwci/Uka3vd
X-Google-Smtp-Source: AAOMgpezTE+mWDuYjmOKAIu37g2LwFCmHNJpkQa6AUuL0vQC/OSOI20YpyUMRB4KCfpVWArN8xwZ4w==
X-Received: by 2002:adf:a35b:: with SMTP id d27-v6mr7832253wrb.189.1530182640978;
        Thu, 28 Jun 2018 03:44:00 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 14-v6sm9257298wmh.8.2018.06.28.03.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 03:44:00 -0700 (PDT)
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
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 3/3] doc: Update wake_up() & co. memory-barrier guarantees
Date:   Thu, 28 Jun 2018 12:41:20 +0200
Message-Id: <1530182480-13205-4-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the implementation and the users' expectation [1] for the various
wakeup primitives have evolved over time, but the documentation has not
kept up with these changes: brings it into 2018.

[1] http://lkml.kernel.org/r/20180424091510.GB4064@hirez.programming.kicks-ass.net

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
[ aparri: Apply feedback from Alan Stern. ]
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
---
 Documentation/memory-barriers.txt | 43 ++++++++++++++++++++++++---------------
 include/linux/sched.h             |  4 ++--
 kernel/sched/completion.c         |  8 ++++----
 kernel/sched/core.c               | 30 +++++++++++----------------
 kernel/sched/wait.c               |  8 ++++----
 5 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a02d6bbfc9d0a..0d8d7ef131e9a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2179,32 +2179,41 @@ or:
 	event_indicated = 1;
 	wake_up_process(event_daemon);
 
-A write memory barrier is implied by wake_up() and co.  if and only if they
-wake something up.  The barrier occurs before the task state is cleared, and so
-sits between the STORE to indicate the event and the STORE to set TASK_RUNNING:
+A general memory barrier is executed by wake_up() if it wakes something up.
+If it doesn't wake anything up then a memory barrier may or may not be
+executed; you must not rely on it.  The barrier occurs before the task state
+is accessed, in particular, it sits between the STORE to indicate the event
+and the STORE to set TASK_RUNNING:
 
-	CPU 1				CPU 2
+	CPU 1 (Sleeper)			CPU 2 (Waker)
 	===============================	===============================
 	set_current_state();		STORE event_indicated
 	  smp_store_mb();		wake_up();
-	    STORE current->state	  <write barrier>
-	    <general barrier>		  STORE current->state
-	LOAD event_indicated
+	    STORE current->state	  ...
+	    <general barrier>		  <general barrier>
+	LOAD event_indicated		  if ((LOAD task->state) & TASK_NORMAL)
+					    STORE task->state
 
-To repeat, this write memory barrier is present if and only if something
-is actually awakened.  To see this, consider the following sequence of
-events, where X and Y are both initially zero:
+where "task" is the thread being woken up and it equals CPU 1's "current".
+
+To repeat, a general memory barrier is guaranteed to be executed by wake_up()
+if something is actually awakened, but otherwise there is no such guarantee.
+To see this, consider the following sequence of events, where X and Y are both
+initially zero:
 
 	CPU 1				CPU 2
 	===============================	===============================
-	X = 1;				STORE event_indicated
+	X = 1;				Y = 1;
 	smp_mb();			wake_up();
-	Y = 1;				wait_event(wq, Y == 1);
-	wake_up();			  load from Y sees 1, no memory barrier
-					load from X might see 0
+	LOAD Y				LOAD X
+
+If a wakeup does occur, one (at least) of the two loads must see 1.  If, on
+the other hand, a wakeup does not occur, both loads might see 0.
 
-In contrast, if a wakeup does occur, CPU 2's load from X would be guaranteed
-to see 1.
+wake_up_process() always executes a general memory barrier.  The barrier again
+occurs before the task state is accessed.  In particular, if the wake_up() in
+the previous snippet were replaced by a call to wake_up_process() then one of
+the two loads would be guaranteed to see 1.
 
 The available waker functions include:
 
@@ -2224,6 +2233,8 @@ The available waker functions include:
 	wake_up_poll();
 	wake_up_process();
 
+In terms of memory ordering, these functions all provide the same guarantees of
+a wake_up() (or stronger).
 
 [!] Note that the memory barriers implied by the sleeper and the waker do _not_
 order multiple stores before the wake-up with respect to loads of those stored
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a279..ddfdeb632f748 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -167,8 +167,8 @@ struct task_group;
  *   need_sleep = false;
  *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
  *
- * Where wake_up_state() (and all other wakeup primitives) imply enough
- * barriers to order the store of the variable against wakeup.
+ * where wake_up_state() executes a full memory barrier before accessing the
+ * task state.
  *
  * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
  * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index e426b0cb9ac63..a1ad5b7d5521b 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -22,8 +22,8 @@
  *
  * See also complete_all(), wait_for_completion() and related routines.
  *
- * It may be assumed that this function implies a write memory barrier before
- * changing the task state if and only if any tasks are woken up.
+ * If this function wakes up a task, it executes a full memory barrier before
+ * accessing the task state.
  */
 void complete(struct completion *x)
 {
@@ -44,8 +44,8 @@ EXPORT_SYMBOL(complete);
  *
  * This will wake up all threads waiting on this particular completion event.
  *
- * It may be assumed that this function implies a write memory barrier before
- * changing the task state if and only if any tasks are woken up.
+ * If this function wakes up a task, it executes a full memory barrier before
+ * accessing the task state.
  *
  * Since complete_all() sets the completion of @x permanently to done
  * to allow multiple waiters to finish, a call to reinit_completion()
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfd49a932bdb6..3579fc45fbeb8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -413,8 +413,8 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * its already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
-	 * This cmpxchg() implies a full barrier, which pairs with the write
-	 * barrier implied by the wakeup in wake_up_q().
+	 * This cmpxchg() executes a full barrier, which pairs with the full
+	 * barrier executed by the wakeup in wake_up_q().
 	 */
 	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
 		return;
@@ -442,8 +442,8 @@ void wake_up_q(struct wake_q_head *head)
 		task->wake_q.next = NULL;
 
 		/*
-		 * wake_up_process() implies a wmb() to pair with the queueing
-		 * in wake_q_add() so as not to miss wakeups.
+		 * wake_up_process() executes a full barrier, which pairs with
+		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
 		wake_up_process(task);
 		put_task_struct(task);
@@ -1880,8 +1880,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  *     rq(c1)->lock (if not at the same time, then in that order).
  *  C) LOCK of the rq(c1)->lock scheduling in task
  *
- * Transitivity guarantees that B happens after A and C after B.
- * Note: we only require RCpc transitivity.
+ * Release/acquire chaining guarantees that B happens after A and C after B.
  * Note: the CPU doing B need not be c0 or c1
  *
  * Example:
@@ -1943,16 +1942,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  *   UNLOCK rq(0)->lock
  *
  *
- * However; for wakeups there is a second guarantee we must provide, namely we
- * must observe the state that lead to our wakeup. That is, not only must our
- * task observe its own prior state, it must also observe the stores prior to
- * its wakeup.
- *
- * This means that any means of doing remote wakeups must order the CPU doing
- * the wakeup against the CPU the task is going to end up running on. This,
- * however, is already required for the regular Program-Order guarantee above,
- * since the waking CPU is the one issueing the ACQUIRE (smp_cond_load_acquire).
- *
+ * However, for wakeups there is a second guarantee we must provide, namely we
+ * must ensure that CONDITION=1 done by the caller can not be reordered with
+ * accesses to the task state; see try_to_wake_up() and set_current_state().
  */
 
 /**
@@ -1968,6 +1960,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * Atomic against schedule() which would dequeue a task, also see
  * set_current_state().
  *
+ * This function executes a full memory barrier before accessing the task
+ * state; see set_current_state().
+ *
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
@@ -2141,8 +2136,7 @@ static void try_to_wake_up_local(struct task_struct *p, struct rq_flags *rf)
  *
  * Return: 1 if the process was woken up, 0 if it was already running.
  *
- * It may be assumed that this function implies a write memory barrier before
- * changing the task state if and only if any tasks are woken up.
+ * This function executes a full memory barrier before accessing the task state.
  */
 int wake_up_process(struct task_struct *p)
 {
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index a7a2aaa3026a6..870f97b313e38 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -134,8 +134,8 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
  * @nr_exclusive: how many wake-one or wake-many threads to wake up
  * @key: is directly passed to the wakeup function
  *
- * It may be assumed that this function implies a write memory barrier before
- * changing the task state if and only if any tasks are woken up.
+ * If this function wakes up a task, it executes a full memory barrier before
+ * accessing the task state.
  */
 void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 			int nr_exclusive, void *key)
@@ -180,8 +180,8 @@ EXPORT_SYMBOL_GPL(__wake_up_locked_key_bookmark);
  *
  * On UP it can prevent extra preemption.
  *
- * It may be assumed that this function implies a write memory barrier before
- * changing the task state if and only if any tasks are woken up.
+ * If this function wakes up a task, it executes a full memory barrier before
+ * accessing the task state.
  */
 void __wake_up_sync_key(struct wait_queue_head *wq_head, unsigned int mode,
 			int nr_exclusive, void *key)
-- 
2.7.4

