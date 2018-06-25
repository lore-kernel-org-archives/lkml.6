Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B5EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFEC25688
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LO8QwOae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFEC25688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeFYJSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:18:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41529 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754512AbeFYJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:18:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so12851193wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7tPyHUo7/A+x7WNLYUt9Vthfz8tIecsz30yc0IG6qUI=;
        b=LO8QwOaejJFPrgrArzHbaO8dpRloov+scjsWTuBEZ0S+yg3LHs1ygfyQp/o4+RksCv
         tbTrtrCCOqiRms60N7Afo5P2CBBIgJwf4z/KqTKbNbEZnwAl2zuS9kkz9okaNzXlXOq7
         FkFnzdJMbEv3N4vIXvgUZlCpTJjcIpOxSAkdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7tPyHUo7/A+x7WNLYUt9Vthfz8tIecsz30yc0IG6qUI=;
        b=EVQG/MOTSpBZXGBiVplzmlo+5SJS4uqjasqVXPxOOg06e4FEWxRQYTnXaZgodFDodk
         f3b/7i62IPch+OL1GZdBcX/J96p/LZW+rUF7mgmOD5Fp+wqQYpYL4Am4BMr47gj6qjrP
         usVqGnQYgnFgzL5SwdzU7tAzRs5Zx0uihr752bEqC+hXg6XiTd7tHKdBTY0+ycaA8BVW
         dhZPV9KE+Mrgm0Yuiaq8Os3SJqmLJwhGpiURPEwC+jDsUzOIpEp5PNK4YLgjN/U8rKm+
         W1tvE0cSbt4dvlYX+RG5LK+TYnmCkIEMfYNZie4nLtumI4RU7/VRU2Cbzis7q1kkPWN6
         +J2Q==
X-Gm-Message-State: APt69E1x88N84HY3AlsbhVlE9he4eCTTB+NJQ6TquCwfvo/veqE23HoI
        yo6cJNtiKjNJIiC7akhFR/a9A2CU
X-Google-Smtp-Source: AAOMgpemv6MmQoGgcMME4vVxfRrKUoFI7bbhbKKmswTvdKEQrLDy+i2QutGtfYNnLD4DoC9+V4P0+A==
X-Received: by 2002:a5d:45cb:: with SMTP id b11-v6mr9473060wrs.106.1529918287619;
        Mon, 25 Jun 2018 02:18:07 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id x11-v6sm13688123wrl.80.2018.06.25.02.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Jun 2018 02:18:06 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Date:   Mon, 25 Jun 2018 11:17:38 +0200
Message-Id: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/memory-barriers.txt | 43 ++++++++++++++++++++++++---------------
 kernel/sched/completion.c         |  8 ++++----
 kernel/sched/core.c               | 11 +++++-----
 kernel/sched/wait.c               | 24 ++++++++++------------
 4 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a02d6bbfc9d0a..bf58fa1671b62 100644
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
+is accessed, in part., it sits between the STORE to indicate the event and
+the STORE to set TASK_RUNNING:
 
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
+where "task" is the thread being woken up and it equals CPU 1's current.
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
index bfd49a932bdb6..4718da10ccb6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -413,8 +413,8 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * its already queued (either by us or someone else) and will get the
 	 * wakeup due to that.
 	 *
-	 * This cmpxchg() implies a full barrier, which pairs with the write
-	 * barrier implied by the wakeup in wake_up_q().
+	 * This cmpxchg() executes a full barrier, which pairs with the full
+	 * barrier executed in the wakeup in wake_up_q().
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
@@ -2141,8 +2141,7 @@ static void try_to_wake_up_local(struct task_struct *p, struct rq_flags *rf)
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
index 928be527477eb..eaafc58543592 100644
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
@@ -408,19 +408,23 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 {
 	set_current_state(mode); /* A */
 	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
+	 * The above executes an smp_mb(), which matches with the smp_wmb() from
 	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
 	 * also observe all state before the wakeup.
+	 *
+	 * XXX: Specify memory accesses and communication relations.
 	 */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout = schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
 
 	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
+	 * The below executes an smp_mb(), it too pairs with the smp_wmb() from
 	 * woken_wake_function() such that we must either observe the wait
 	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
 	 * an event.
+	 *
+	 * XXX: Specify memory accesses and communication relations.
 	 */
 	smp_store_mb(wq_entry->flags, wq_entry->flags & ~WQ_FLAG_WOKEN); /* B */
 
@@ -430,13 +434,7 @@ EXPORT_SYMBOL(wait_woken);
 
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
 {
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with smp_store_mb() in wait_woken().
-	 */
+	/* Pairs with the smp_store_mb() from wait_woken(). */
 	smp_wmb(); /* C */
 	wq_entry->flags |= WQ_FLAG_WOKEN;
 
-- 
2.7.4

