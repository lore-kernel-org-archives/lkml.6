Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeBAMER (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:04:17 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46338 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeBAMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:04:16 -0500
X-Google-Smtp-Source: AH8x227z+xhLCtIAV1VR87V7mfjch09slW7qsmVp8AqQzkZbNqNeMcNHftykgTkim7poJhV5KzxesA==
From: Andrea Parri <parri.andrea@gmail.com>
To: stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the tool name
Date: Thu,  1 Feb 2018 13:03:29 +0100
Message-Id: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo pointed out that:

  "The "memory model" name is overly generic, ambiguous and somewhat
   misleading, as we usually mean the virtual memory layout/model
   when we say "memory model". GCC too uses it in that sense [...]"

Make it clearer that, in the context of tools/memory-model/, the term
"memory-model" is used as shorthand for "memory consistency model" by
calling out this convention in tools/memory-model/README.

Stick to the full name in sources' headers and for the subsystem name.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/memory-model/MAINTAINERS       |  2 +-
 tools/memory-model/README            | 14 +++++++-------
 tools/memory-model/linux-kernel.bell |  2 +-
 tools/memory-model/linux-kernel.cat  |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
index 711cbe72d6066..db3bd3fc0435b 100644
--- a/tools/memory-model/MAINTAINERS
+++ b/tools/memory-model/MAINTAINERS
@@ -1,4 +1,4 @@
-LINUX KERNEL MEMORY MODEL
+LINUX KERNEL MEMORY CONSISTENCY MODEL
 M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will.deacon@arm.com>
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 43ba49492111c..91414a49fac53 100644
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
index 57112505f5e03..b984bbda01a5c 100644
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
index 15b7a5dd8a9af..babe2b3b0bb32 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -11,7 +11,7 @@
  * which is to appear in ASPLOS 2018.
  *)
 
-"Linux kernel memory model"
+"Linux-kernel memory consistency model"
 
 (*
  * File "lock.cat" handles locks and is experimental.
-- 
2.7.4
