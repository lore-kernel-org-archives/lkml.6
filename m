Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F1D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F1D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGQKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:04:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeGQKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:04:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9VsUN1462871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:31:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9VsRk1462868;
        Tue, 17 Jul 2018 02:31:54 -0700
Date:   Tue, 17 Jul 2018 02:31:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-7696f9910a9a40b8a952f57d3428515fabd2d889@git.kernel.org>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, stern@rowland.harvard.edu,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        j.alglave@ucl.ac.uk, dlustig@nvidia.com, hpa@zytor.com,
        mingo@kernel.org, npiggin@gmail.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, akiyks@gmail.com,
        luc.maranget@inria.fr, corbet@lwn.net
Reply-To: corbet@lwn.net, luc.maranget@inria.fr, akiyks@gmail.com,
          mingo@kernel.org, npiggin@gmail.com,
          andrea.parri@amarulasolutions.com, will.deacon@arm.com,
          hpa@zytor.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
          linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
          paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
          peterz@infradead.org, dhowells@redhat.com,
          torvalds@linux-foundation.org, tglx@linutronix.de
In-Reply-To: <20180716180605.16115-12-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-12-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/Documentation: Update wake_up() & co.
 memory-barrier guarantees
Git-Commit-ID: 7696f9910a9a40b8a952f57d3428515fabd2d889
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7696f9910a9a40b8a952f57d3428515fabd2d889
Gitweb:     https://git.kernel.org/tip/7696f9910a9a40b8a952f57d3428515fabd2d889
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 16 Jul 2018 11:06:03 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:30:34 +0200

sched/Documentation: Update wake_up() & co. memory-barrier guarantees

Both the implementation and the users' expectation [1] for the various
wakeup primitives have evolved over time, but the documentation has not
kept up with these changes: brings it into 2018.

[1] http://lkml.kernel.org/r/20180424091510.GB4064@hirez.programming.kicks-ass.net

Also applied feedback from Alan Stern.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/20180716180605.16115-12-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 43 ++++++++++++++++++++++++---------------
 include/linux/sched.h             |  4 ++--
 kernel/sched/completion.c         |  8 ++++----
 kernel/sched/core.c               | 30 +++++++++++----------------
 kernel/sched/wait.c               |  8 ++++----
 5 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a02d6bbfc9d0..0d8d7ef131e9 100644
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
index 43731fe51c97..05cd419f962d 100644
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
index e426b0cb9ac6..a1ad5b7d5521 100644
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
index 0c5ec2abdf93..a0065c84e73f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -412,8 +412,8 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
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
@@ -441,8 +441,8 @@ void wake_up_q(struct wake_q_head *head)
 		task->wake_q.next = NULL;
 
 		/*
-		 * wake_up_process() implies a wmb() to pair with the queueing
-		 * in wake_q_add() so as not to miss wakeups.
+		 * wake_up_process() executes a full barrier, which pairs with
+		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
 		wake_up_process(task);
 		put_task_struct(task);
@@ -1879,8 +1879,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  *     rq(c1)->lock (if not at the same time, then in that order).
  *  C) LOCK of the rq(c1)->lock scheduling in task
  *
- * Transitivity guarantees that B happens after A and C after B.
- * Note: we only require RCpc transitivity.
+ * Release/acquire chaining guarantees that B happens after A and C after B.
  * Note: the CPU doing B need not be c0 or c1
  *
  * Example:
@@ -1942,16 +1941,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
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
@@ -1967,6 +1959,9 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  * Atomic against schedule() which would dequeue a task, also see
  * set_current_state().
  *
+ * This function executes a full memory barrier before accessing the task
+ * state; see set_current_state().
+ *
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
@@ -2141,8 +2136,7 @@ out:
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
index a7a2aaa3026a..870f97b313e3 100644
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
