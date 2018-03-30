Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeC3V2h (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:28:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752781AbeC3V2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:28:13 -0400
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/3] lib/Kconfig.debug: Add LOCK_DEBUGGING_SUPPORT to make it more readable
Date: Fri, 30 Mar 2018 17:27:59 -0400
Message-Id: <1522445280-7767-3-git-send-email-longman@redhat.com>
In-Reply-To: <1522445280-7767-1-git-send-email-longman@redhat.com>
References: <1522445280-7767-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 lib/Kconfig.debug | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6aad28c..0db85f5 100644
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
-- 
1.8.3.1
