Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbeCaIFV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:05:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeCaIFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:05:18 -0400
Date: Sat, 31 Mar 2018 00:59:54 -0700
From: tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-f07cbebb6daf04e5c9721e5be2737a6068c7e2a2@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, dave@stgolabs.net,
        tglx@linutronix.de, torvalds@linux-foundation.org, longman@redhat.com
Reply-To: tglx@linutronix.de, dave@stgolabs.net, torvalds@linux-foundation.org,
        longman@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, hpa@zytor.com
In-Reply-To: <1522445280-7767-3-git-send-email-longman@redhat.com>
References: <1522445280-7767-3-git-send-email-longman@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/Kconfig: Add LOCK_DEBUGGING_SUPPORT to
 make it more readable
Git-Commit-ID: f07cbebb6daf04e5c9721e5be2737a6068c7e2a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f07cbebb6daf04e5c9721e5be2737a6068c7e2a2
Gitweb:     https://git.kernel.org/tip/f07cbebb6daf04e5c9721e5be2737a6068c7e2a2
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Fri, 30 Mar 2018 17:27:59 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 07:30:50 +0200

locking/Kconfig: Add LOCK_DEBUGGING_SUPPORT to make it more readable

There are a couples of lock debugging Kconfig options that depends on
the following support options:

 - TRACE_IRQFLAGS_SUPPORT
 - STACKTRACE_SUPPORT
 - LOCKDEP_SUPPORT

That makes those lock debugging options harder to read and understand.
So a new LOCK_DEBUGGING_SUPPORT option is added that is equivalent to
the above three options together. That makes the Kconfig.debug file
more readable.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1522445280-7767-3-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/Kconfig.debug | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 88650ab5cedb..ee7ca42e737e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1034,6 +1034,11 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config LOCK_DEBUGGING_SUPPORT
+	bool
+	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	default y
+
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
@@ -1060,7 +1065,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_WW_MUTEX_SLOWPATH
 	bool "Wait/wound mutex debugging: Slowpath testing"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_LOCK_ALLOC
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
@@ -1084,7 +1089,7 @@ config DEBUG_RWSEMS
 
 config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
@@ -1099,7 +1104,7 @@ config DEBUG_LOCK_ALLOC
 
 config PROVE_LOCKING
 	bool "Lock debugging: prove locking correctness"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
@@ -1144,7 +1149,7 @@ config PROVE_LOCKING
 
 config LOCKDEP
 	bool
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
 	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !SCORE && !X86
 	select KALLSYMS
@@ -1155,7 +1160,7 @@ config LOCKDEP_SMALL
 
 config LOCK_STAT
 	bool "Lock usage statistics"
-	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
