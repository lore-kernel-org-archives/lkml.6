Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933408AbeBUKk4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:40:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53021 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeBUKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:40:54 -0500
Date: Wed, 21 Feb 2018 02:39:24 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-48d44d4e8a583c66d9f376e18c1a1fcc445f4b64@git.kernel.org>
Cc: mingo@kernel.org, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, stern@rowland.harvard.edu,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, parri.andrea@gmail.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        stern@rowland.harvard.edu, torvalds@linux-foundation.org,
        parri.andrea@gmail.com, will.deacon@arm.com
In-Reply-To: <1519169112-20593-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-1-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Clarify the origin/scope of
 the tool name
Git-Commit-ID: 48d44d4e8a583c66d9f376e18c1a1fcc445f4b64
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

Commit-ID:  48d44d4e8a583c66d9f376e18c1a1fcc445f4b64
Gitweb:     https://git.kernel.org/tip/48d44d4e8a583c66d9f376e18c1a1fcc445f4b64
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Tue, 20 Feb 2018 15:25:01 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:12 +0100

tools/memory-model: Clarify the origin/scope of the tool name

Ingo pointed out that:

  "The "memory model" name is overly generic, ambiguous and somewhat
   misleading, as we usually mean the virtual memory layout/model
   when we say "memory model". GCC too uses it in that sense [...]"

Make it clear that tools/memory-model/ uses the term "memory model" as
shorthand for "memory consistency model" by calling out this convention
in tools/memory-model/README.

Stick to the original "memory model" term in sources' headers and for
the subsystem name.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: nborisov@suse.com
Cc: npiggin@gmail.com
Link: http://lkml.kernel.org/r/1519169112-20593-1-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/MAINTAINERS       |  2 +-
 tools/memory-model/README            | 14 +++++++-------
 tools/memory-model/linux-kernel.bell |  2 +-
 tools/memory-model/linux-kernel.cat  |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
index 711cbe7..db3bd3f 100644
--- a/tools/memory-model/MAINTAINERS
+++ b/tools/memory-model/MAINTAINERS
@@ -1,4 +1,4 @@
-LINUX KERNEL MEMORY MODEL
+LINUX KERNEL MEMORY CONSISTENCY MODEL
 M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will.deacon@arm.com>
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 43ba494..91414a4 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -1,15 +1,15 @@
-			=========================
-			LINUX KERNEL MEMORY MODEL
-			=========================
+		=====================================
+		LINUX KERNEL MEMORY CONSISTENCY MODEL
+		=====================================
 
 ============
 INTRODUCTION
 ============
 
-This directory contains the memory model of the Linux kernel, written
-in the "cat" language and executable by the (externally provided)
-"herd7" simulator, which exhaustively explores the state space of
-small litmus tests.
+This directory contains the memory consistency model (memory model, for
+short) of the Linux kernel, written in the "cat" language and executable
+by the externally provided "herd7" simulator, which exhaustively explores
+the state space of small litmus tests.
 
 In addition, the "klitmus7" tool (also externally provided) may be used
 to convert a litmus test to a Linux kernel module, which in turn allows
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 5711250..b984bbd 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -11,7 +11,7 @@
  * which is to appear in ASPLOS 2018.
  *)
 
-"Linux kernel memory model"
+"Linux-kernel memory consistency model"
 
 enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
 		'release (*smp_store_release*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 15b7a5d..babe2b3 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -11,7 +11,7 @@
  * which is to appear in ASPLOS 2018.
  *)
 
-"Linux kernel memory model"
+"Linux-kernel memory consistency model"
 
 (*
  * File "lock.cat" handles locks and is experimental.
