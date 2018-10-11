Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A183C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0C32087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0C32087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeJKQHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:07:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49209 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeJKQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:07:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9B8eN7S1824193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Oct 2018 01:40:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9B8eM051824190;
        Thu, 11 Oct 2018 01:40:22 -0700
Date:   Thu, 11 Oct 2018 01:40:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-0c373344b5c1eaa9e186368a32a169a2802be3ca@git.kernel.org>
Cc:     mingo@kernel.org, john.garry@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        hofrat@osadl.org, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, hofrat@osadl.org,
          torvalds@linux-foundation.org, john.garry@huawei.com,
          tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/completions/Documentation: Clean up the
 document some more
Git-Commit-ID: 0c373344b5c1eaa9e186368a32a169a2802be3ca
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

Commit-ID:  0c373344b5c1eaa9e186368a32a169a2802be3ca
Gitweb:     https://git.kernel.org/tip/0c373344b5c1eaa9e186368a32a169a2802be3ca
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Thu, 11 Oct 2018 10:36:23 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 11 Oct 2018 10:36:23 +0200

sched/completions/Documentation: Clean up the document some more

Refresh the document:

 - Remove unnecessary liguistic complexity and improve the clarity of the text

 - Improve the explanations all around

 - Remove unnecessary and stale version info

 - Fix whitespace noise

 - Make pseudo-code match kernel style

 - Fix minor syntax errors in pseudo-code

 - Use consistent denotation

 - Mark multi-CPU sequences more explicitly

 - Unbreak line breaks

 - Use quotes to refer to 'struct completion'

 - Use 'IRQ context' and 'IRQs' consistently

 - Improve grammar

 - etc.

Cc: John Garry <john.garry@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/1539183392-239389-1-git-send-email-john.garry@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/completion.txt | 233 ++++++++++++++++++---------------
 1 file changed, 125 insertions(+), 108 deletions(-)

diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.txt
index 108bd0f264b3..91a11a668354 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.txt
@@ -1,146 +1,161 @@
-completions - wait for completion handling
-==========================================
-
-This document was originally written based on 3.18.0 (linux-next)
+Completions - "wait for completion" barrier APIs
+================================================
 
 Introduction:
 -------------
 
-If you have one or more threads of execution that must wait for some process
+If you have one or more threads that must wait for some kernel activity
 to have reached a point or a specific state, completions can provide a
 race-free solution to this problem. Semantically they are somewhat like a
-pthread_barrier and have similar use-cases.
+pthread_barrier() and have similar use-cases.
 
 Completions are a code synchronization mechanism which is preferable to any
-misuse of locks. Any time you think of using yield() or some quirky
-msleep(1) loop to allow something else to proceed, you probably want to
-look into using one of the wait_for_completion*() calls instead. The
-advantage of using completions is clear intent of the code, but also more
-efficient code as both threads can continue until the result is actually
-needed.
-
-Completions are built on top of the generic event infrastructure in Linux,
-with the event reduced to a simple flag (appropriately called "done") in
-struct completion that tells the waiting threads of execution if they
-can continue safely.
-
-As completions are scheduling related, the code is found in
+misuse of locks/semaphores and busy-loops. Any time you think of using
+yield() or some quirky msleep(1) loop to allow something else to proceed,
+you probably want to look into using one of the wait_for_completion*()
+calls and complete() instead.
+
+The advantage of using completions is that they have a well defined, focused
+purpose which makes it very easy to see the intent of the code, but they
+also result in more efficient code as all threads can continue execution
+until the result is actually needed, and both the waiting and the signalling
+is highly efficient using low level scheduler sleep/wakeup facilities.
+
+Completions are built on top of the waitqueue and wakeup infrastructure of
+the Linux scheduler. The event the threads on the waitqueue are waiting for
+is reduced to a simple flag in 'struct completion', appropriately called "done".
+
+As completions are scheduling related, the code can be found in
 kernel/sched/completion.c.
 
 
 Usage:
 ------
 
-There are three parts to using completions, the initialization of the
-struct completion, the waiting part through a call to one of the variants of
-wait_for_completion() and the signaling side through a call to complete()
-or complete_all(). Further there are some helper functions for checking the
-state of completions.
+There are three main parts to using completions:
+
+ - the initialization of the 'struct completion' synchronization object
+ - the waiting part through a call to one of the variants of wait_for_completion(),
+ - the signaling side through a call to complete() or complete_all().
+
+There are also some helper functions for checking the state of completions.
+Note that while initialization must happen first, the waiting and signaling
+part can happen in any order. I.e. it's entirely normal for a thread
+to have marked a completion as 'done' before another thread checks whether
+it has to wait for it.
 
-To use completions one needs to include <linux/completion.h> and
-create a variable of type struct completion. The structure used for
-handling of completions is:
+To use completions you need to #include <linux/completion.h> and
+create a static or dynamic variable of type 'struct completion',
+which has only two fields:
 
 	struct completion {
 		unsigned int done;
 		wait_queue_head_t wait;
 	};
 
-providing the wait queue to place tasks on for waiting and the flag for
-indicating the state of affairs.
+This provides the ->wait waitqueue to place tasks on for waiting (if any), and
+the ->done completion flag for indicating whether it's completed or not.
 
-Completions should be named to convey the intent of the waiter. A good
-example is:
+Completions should be named to refer to the event that is being synchronized on.
+A good example is:
 
 	wait_for_completion(&early_console_added);
 
 	complete(&early_console_added);
 
-Good naming (as always) helps code readability.
+Good, intuitive naming (as always) helps code readability. Naming a completion
+'complete' is not helpful unless the purpose is super obvious...
 
 
 Initializing completions:
 -------------------------
 
-Initialization of dynamically allocated completions, often embedded in
-other structures, is done with:
+Initialization of dynamically allocated completion objects, often embedded in
+other structures, is done via a call to init_completion():
 
-	void init_completion(&done);
+	init_completion(&dynamic_object->done);
 
-Initialization is accomplished by initializing the wait queue and setting
-the default state to "not available", that is, "done" is set to 0.
+In this call we initialize the waitqueue and set ->done to 0, i.e. "not completed"
+or "not done".
 
 The re-initialization function, reinit_completion(), simply resets the
-done element to "not available", thus again to 0, without touching the
-wait queue. Calling init_completion() twice on the same completion object is
+->done field to 0 ("not done"), without touching the waitqueue.
+Callers of this function must make sure that there are no racy
+wait_for_completion() calls going on in parallel.
+
+Calling init_completion() on the same completion object twice is
 most likely a bug as it re-initializes the queue to an empty queue and
-enqueued tasks could get "lost" - use reinit_completion() in that case.
+enqueued tasks could get "lost" - use reinit_completion() in that case,
+but be aware of other races.
 
-For static declaration and initialization, macros are available. These are:
+For static declaration and initialization, macros are available.
 
-	static DECLARE_COMPLETION(setup_done)
+For static (or global) declarations in file scope you can use DECLARE_COMPLETION():
 
-used for static declarations in file scope. Within functions the static
-initialization should always use:
+	static DECLARE_COMPLETION(setup_done);
+	DECLARE_COMPLETION(setup_done);
 
-	DECLARE_COMPLETION_ONSTACK(setup_done)
+Note that in this case the completion is boot time (or module load time)
+initialized to 'not done' and doesn't require an init_completion() call.
 
-suitable for automatic/local variables on the stack and will make lockdep
-happy. Note also that one needs to make *sure* the completion passed to
-work threads remains in-scope, and no references remain to on-stack data
-when the initiating function returns.
+When a completion is declared as a local variable within a function,
+then the initialization should always use:
 
-Using on-stack completions for code that calls any of the _timeout or
-_interruptible/_killable variants is not advisable as they will require
-additional synchronization to prevent the on-stack completion object in
-the timeout/signal cases from going out of scope. Consider using dynamically
-allocated completions when intending to use the _interruptible/_killable
-or _timeout variants of wait_for_completion().
+	DECLARE_COMPLETION_ONSTACK(setup_done)
+
+A simple DECLARE_COMPLETION() on the stack makes lockdep unhappy.
 
+Note that when using completion objects as local variables you must be
+aware of the short life time of the function stack: the function must
+not return to a calling context until all activities (such as waiting
+threads) have ceased and the completion is ... completely unused.
 
 Waiting for completions:
 ------------------------
 
-For a thread of execution to wait for some concurrent work to finish, it
-calls wait_for_completion() on the initialized completion structure.
+For a thread to wait for some concurrent activity to finish, it
+calls wait_for_completion() on the initialized completion structure:
+
+	void wait_for_completion(struct completion *done)
+
 A typical usage scenario is:
 
+	CPU#1					CPU#2
+
 	struct completion setup_done;
+
 	init_completion(&setup_done);
-	initialize_work(...,&setup_done,...)
+	initialize_work(...,&setup_done,...);
 
-	/* run non-dependent code */              /* do setup */
+	/* run non-dependent code */		/* do setup */
 
-	wait_for_completion(&setup_done);         complete(setup_done)
+	wait_for_completion(&setup_done);	complete(setup_done);
 
-This is not implying any temporal order on wait_for_completion() and the
-call to complete() - if the call to complete() happened before the call
+This is not implying any particular order between wait_for_completion() and
+the call to complete() - if the call to complete() happened before the call
 to wait_for_completion() then the waiting side simply will continue
 immediately as all dependencies are satisfied; if not, it will block until
 completion is signaled by complete().
 
 Note that wait_for_completion() is calling spin_lock_irq()/spin_unlock_irq(),
 so it can only be called safely when you know that interrupts are enabled.
-Calling it from hard-irq or irqs-off atomic contexts will result in
-hard-to-detect spurious enabling of interrupts.
-
-wait_for_completion():
-
-	void wait_for_completion(struct completion *done):
+Calling it from IRQs-off atomic contexts will result in hard-to-detect
+spurious enabling of interrupts.
 
 The default behavior is to wait without a timeout and to mark the task as
 uninterruptible. wait_for_completion() and its variants are only safe
 in process context (as they can sleep) but not in atomic context,
-interrupt context, with disabled irqs, or preemption is disabled - see also
+interrupt context, with disabled IRQs, or preemption is disabled - see also
 try_wait_for_completion() below for handling completion in atomic/interrupt
 context.
 
 As all variants of wait_for_completion() can (obviously) block for a long
-time, you probably don't want to call this with held mutexes.
+time depending on the nature of the activity they are waiting for, so in
+most cases you probably don't want to call this with held mutexes.
 
 
-Variants available:
--------------------
+wait_for_completion*() variants available:
+------------------------------------------
 
 The below variants all return status and this status should be checked in
 most(/all) cases - in cases where the status is deliberately not checked you
@@ -148,51 +163,53 @@ probably want to make a note explaining this (e.g. see
 arch/arm/kernel/smp.c:__cpu_up()).
 
 A common problem that occurs is to have unclean assignment of return types,
-so care should be taken with assigning return-values to variables of proper
-type. Checking for the specific meaning of return values also has been found
-to be quite inaccurate e.g. constructs like
-if (!wait_for_completion_interruptible_timeout(...)) would execute the same
-code path for successful completion and for the interrupted case - which is
-probably not what you want.
+so take care to assign return-values to variables of the proper type.
+
+Checking for the specific meaning of return values also has been found
+to be quite inaccurate, e.g. constructs like:
+
+	if (!wait_for_completion_interruptible_timeout(...))
+
+... would execute the same code path for successful completion and for the
+interrupted case - which is probably not what you want.
 
 	int wait_for_completion_interruptible(struct completion *done)
 
-This function marks the task TASK_INTERRUPTIBLE. If a signal was received
-while waiting it will return -ERESTARTSYS; 0 otherwise.
+This function marks the task TASK_INTERRUPTIBLE while it is waiting.
+If a signal was received while waiting it will return -ERESTARTSYS; 0 otherwise.
 
-	unsigned long wait_for_completion_timeout(struct completion *done,
-		unsigned long timeout)
+	unsigned long wait_for_completion_timeout(struct completion *done, unsigned long timeout)
 
 The task is marked as TASK_UNINTERRUPTIBLE and will wait at most 'timeout'
-(in jiffies). If timeout occurs it returns 0 else the remaining time in
-jiffies (but at least 1). Timeouts are preferably calculated with
-msecs_to_jiffies() or usecs_to_jiffies(). If the returned timeout value is
-deliberately ignored a comment should probably explain why (e.g. see
-drivers/mfd/wm8350-core.c wm8350_read_auxadc())
+jiffies. If a timeout occurs it returns 0, else the remaining time in
+jiffies (but at least 1).
+
+Timeouts are preferably calculated with msecs_to_jiffies() or usecs_to_jiffies(),
+to make the code largely HZ-invariant.
+
+If the returned timeout value is deliberately ignored a comment should probably explain
+why (e.g. see drivers/mfd/wm8350-core.c wm8350_read_auxadc()).
 
-	long wait_for_completion_interruptible_timeout(
-		struct completion *done, unsigned long timeout)
+	long wait_for_completion_interruptible_timeout(struct completion *done, unsigned long timeout)
 
 This function passes a timeout in jiffies and marks the task as
 TASK_INTERRUPTIBLE. If a signal was received it will return -ERESTARTSYS;
-otherwise it returns 0 if the completion timed out or the remaining time in
+otherwise it returns 0 if the completion timed out, or the remaining time in
 jiffies if completion occurred.
 
 Further variants include _killable which uses TASK_KILLABLE as the
-designated tasks state and will return -ERESTARTSYS if it is interrupted or
-else 0 if completion was achieved.  There is a _timeout variant as well:
+designated tasks state and will return -ERESTARTSYS if it is interrupted,
+or 0 if completion was achieved.  There is a _timeout variant as well:
 
 	long wait_for_completion_killable(struct completion *done)
-	long wait_for_completion_killable_timeout(struct completion *done,
-		unsigned long timeout)
+	long wait_for_completion_killable_timeout(struct completion *done, unsigned long timeout)
 
 The _io variants wait_for_completion_io() behave the same as the non-_io
-variants, except for accounting waiting time as waiting on IO, which has
-an impact on how the task is accounted in scheduling stats.
+variants, except for accounting waiting time as 'waiting on IO', which has
+an impact on how the task is accounted in scheduling/IO stats:
 
 	void wait_for_completion_io(struct completion *done)
-	unsigned long wait_for_completion_io_timeout(struct completion *done
-		unsigned long timeout)
+	unsigned long wait_for_completion_io_timeout(struct completion *done, unsigned long timeout)
 
 
 Signaling completions:
@@ -200,30 +217,30 @@ Signaling completions:
 
 A thread that wants to signal that the conditions for continuation have been
 achieved calls complete() to signal exactly one of the waiters that it can
-continue.
+continue:
 
 	void complete(struct completion *done)
 
-or calls complete_all() to signal all current and future waiters.
+... or calls complete_all() to signal all current and future waiters:
 
 	void complete_all(struct completion *done)
 
 The signaling will work as expected even if completions are signaled before
 a thread starts waiting. This is achieved by the waiter "consuming"
-(decrementing) the done element of struct completion. Waiting threads
+(decrementing) the done field of 'struct completion'. Waiting threads
 wakeup order is the same in which they were enqueued (FIFO order).
 
 If complete() is called multiple times then this will allow for that number
 of waiters to continue - each call to complete() will simply increment the
-done element. Calling complete_all() multiple times is a bug though. Both
-complete() and complete_all() can be called in hard-irq/atomic context safely.
+done field. Calling complete_all() multiple times is a bug though. Both
+complete() and complete_all() can be called in IRQ/atomic context safely.
 
-There only can be one thread calling complete() or complete_all() on a
-particular struct completion at any time - serialized through the wait
+There can only be one thread calling complete() or complete_all() on a
+particular 'struct completion' at any time - serialized through the wait
 queue spinlock. Any such concurrent calls to complete() or complete_all()
 probably are a design bug.
 
-Signaling completion from hard-irq context is fine as it will appropriately
+Signaling completion from IRQ context is fine as it will appropriately
 lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never sleep.
 
 
@@ -236,7 +253,7 @@ else it consumes one posted completion and returns true.
 
 	bool try_wait_for_completion(struct completion *done)
 
-Finally, to check the state of a completion without changing it in any way, 
+Finally, to check the state of a completion without changing it in any way,
 call completion_done(), which returns false if there are no posted
 completions that were not yet consumed by waiters (implying that there are
 waiters) and true otherwise;
@@ -244,4 +261,4 @@ waiters) and true otherwise;
 	bool completion_done(struct completion *done)
 
 Both try_wait_for_completion() and completion_done() are safe to be called in
-hard-irq or atomic context.
+IRQ or atomic context.
