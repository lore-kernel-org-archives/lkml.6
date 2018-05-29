Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeE2MUe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:20:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36440 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933730AbeE2MUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:20:32 -0400
X-Google-Smtp-Source: ADUXVKJl3pL4pxERqULcCNMUNDfZ4fESZjenSPVvc4JRKu8i/h4OTqojwMGh+fP7g1bVOUcIAsg1Qw==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] tools/memory-model: Rename litmus tests to comply to norm7
Date: Tue, 29 May 2018 14:20:13 +0200
Message-Id: <1527596413-11501-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

norm7 produces the 'normalized' name of a litmus test,  when the test
can be generated from a single cycle that passes through each process
exactly once. The commit renames such tests in order to comply to the
naming scheme implemented by this tool.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
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
---
 tools/memory-model/Documentation/recipes.txt       |  8 ++--
 tools/memory-model/README                          | 20 +++++-----
 .../IRIW+fencembonceonces+OnceOnce.litmus          | 45 ++++++++++++++++++++++
 .../litmus-tests/IRIW+mbonceonces+OnceOnce.litmus  | 45 ----------------------
 .../litmus-tests/LB+ctrlonceonce+mbonceonce.litmus | 34 ----------------
 .../LB+fencembonceonce+ctrlonceonce.litmus         | 34 ++++++++++++++++
 .../MP+fencewmbonceonce+fencermbonceonce.litmus    | 30 +++++++++++++++
 .../litmus-tests/MP+wmbonceonce+rmbonceonce.litmus | 30 ---------------
 .../litmus-tests/R+fencembonceonces.litmus         | 30 +++++++++++++++
 .../memory-model/litmus-tests/R+mbonceonces.litmus | 30 ---------------
 tools/memory-model/litmus-tests/README             | 16 ++++----
 .../S+fencewmbonceonce+poacquireonce.litmus        | 27 +++++++++++++
 .../S+wmbonceonce+poacquireonce.litmus             | 27 -------------
 .../litmus-tests/SB+fencembonceonces.litmus        | 32 +++++++++++++++
 .../litmus-tests/SB+mbonceonces.litmus             | 32 ---------------
 .../WRC+pooncerelease+fencermbonceonce+Once.litmus | 38 ++++++++++++++++++
 .../WRC+pooncerelease+rmbonceonce+Once.litmus      | 38 ------------------
 ...release+poacquirerelease+fencembonceonce.litmus | 42 ++++++++++++++++++++
 ...ooncerelease+poacquirerelease+mbonceonce.litmus | 42 --------------------
 19 files changed, 300 insertions(+), 300 deletions(-)
 create mode 100644 tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
 delete mode 100644 tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
 delete mode 100644 tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
 delete mode 100644 tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/R+fencembonceonces.litmus
 delete mode 100644 tools/memory-model/litmus-tests/R+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
 delete mode 100644 tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
 create mode 100644 tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
 delete mode 100644 tools/memory-model/litmus-tests/SB+mbonceonces.litmus
 create mode 100644 tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
 delete mode 100644 tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
 create mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
 delete mode 100644 tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index ee4309a87fc45..a40802fa1099e 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -126,7 +126,7 @@ However, it is not necessarily the case that accesses ordered by
 locking will be seen as ordered by CPUs not holding that lock.
 Consider this example:
 
-	/* See Z6.0+pooncelock+pooncelock+pombonce.litmus. */
+	/* See Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus. */
 	void CPU0(void)
 	{
 		spin_lock(&mylock);
@@ -292,7 +292,7 @@ and to use smp_load_acquire() instead of smp_rmb().  However, the older
 smp_wmb() and smp_rmb() APIs are still heavily used, so it is important
 to understand their use cases.  The general approach is shown below:
 
-	/* See MP+wmbonceonce+rmbonceonce.litmus. */
+	/* See MP+fencewmbonceonce+fencermbonceonce.litmus. */
 	void CPU0(void)
 	{
 		WRITE_ONCE(x, 1);
@@ -360,7 +360,7 @@ can be seen in the LB+poonceonces.litmus litmus test.
 One way of avoiding the counter-intuitive outcome is through the use of a
 control dependency paired with a full memory barrier:
 
-	/* See LB+ctrlonceonce+mbonceonce.litmus. */
+	/* See LB+fencembonceonce+ctrlonceonce.litmus. */
 	void CPU0(void)
 	{
 		r0 = READ_ONCE(x);
@@ -476,7 +476,7 @@ that one CPU first stores to one variable and then loads from a second,
 while another CPU stores to the second variable and then loads from the
 first.  Preserving order requires nothing less than full barriers:
 
-	/* See SB+mbonceonces.litmus. */
+	/* See SB+fencembonceonces.litmus. */
 	void CPU0(void)
 	{
 		WRITE_ONCE(x, 1);
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 734f7feaa5dc5..ee987ce20aaec 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -35,13 +35,13 @@ BASIC USAGE: HERD7
 The memory model is used, in conjunction with "herd7", to exhaustively
 explore the state space of small litmus tests.
 
-For example, to run SB+mbonceonces.litmus against the memory model:
+For example, to run SB+fencembonceonces.litmus against the memory model:
 
-  $ herd7 -conf linux-kernel.cfg litmus-tests/SB+mbonceonces.litmus
+  $ herd7 -conf linux-kernel.cfg litmus-tests/SB+fencembonceonces.litmus
 
 Here is the corresponding output:
 
-  Test SB+mbonceonces Allowed
+  Test SB+fencembonceonces Allowed
   States 3
   0:r0=0; 1:r0=1;
   0:r0=1; 1:r0=0;
@@ -50,8 +50,8 @@ Here is the corresponding output:
   Witnesses
   Positive: 0 Negative: 3
   Condition exists (0:r0=0 /\ 1:r0=0)
-  Observation SB+mbonceonces Never 0 3
-  Time SB+mbonceonces 0.01
+  Observation SB+fencembonceonces Never 0 3
+  Time SB+fencembonceonces 0.01
   Hash=d66d99523e2cac6b06e66f4c995ebb48
 
 The "Positive: 0 Negative: 3" and the "Never 0 3" each indicate that
@@ -67,16 +67,16 @@ BASIC USAGE: KLITMUS7
 The "klitmus7" tool converts a litmus test into a Linux kernel module,
 which may then be loaded and run.
 
-For example, to run SB+mbonceonces.litmus against hardware:
+For example, to run SB+fencembonceonces.litmus against hardware:
 
   $ mkdir mymodules
-  $ klitmus7 -o mymodules litmus-tests/SB+mbonceonces.litmus
+  $ klitmus7 -o mymodules litmus-tests/SB+fencembonceonces.litmus
   $ cd mymodules ; make
   $ sudo sh run.sh
 
 The corresponding output includes:
 
-  Test SB+mbonceonces Allowed
+  Test SB+fencembonceonces Allowed
   Histogram (3 states)
   644580  :>0:r0=1; 1:r0=0;
   644328  :>0:r0=0; 1:r0=1;
@@ -86,8 +86,8 @@ The corresponding output includes:
   Positive: 0, Negative: 2000000
   Condition exists (0:r0=0 /\ 1:r0=0) is NOT validated
   Hash=d66d99523e2cac6b06e66f4c995ebb48
-  Observation SB+mbonceonces Never 0 2000000
-  Time SB+mbonceonces 0.16
+  Observation SB+fencembonceonces Never 0 2000000
+  Time SB+fencembonceonces 0.16
 
 The "Positive: 0 Negative: 2000000" and the "Never 0 2000000" indicate
 that during two million trials, the state specified in this litmus
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
new file mode 100644
index 0000000000000..e729d2776e89a
--- /dev/null
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -0,0 +1,45 @@
+C IRIW+fencembonceonces+OnceOnce
+
+(*
+ * Result: Never
+ *
+ * Test of independent reads from independent writes with smp_mb()
+ * between each pairs of reads.  In other words, is smp_mb() sufficient to
+ * cause two different reading processes to agree on the order of a pair
+ * of writes, where each write is to a different variable by a different
+ * process?  This litmus test exercises LKMM's "propagation" rule.
+ *)
+
+{}
+
+P0(int *x)
+{
+	WRITE_ONCE(*x, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	smp_mb();
+	r1 = READ_ONCE(*y);
+}
+
+P2(int *y)
+{
+	WRITE_ONCE(*y, 1);
+}
+
+P3(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*y);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r0=1 /\ 1:r1=0 /\ 3:r0=1 /\ 3:r1=0)
diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
deleted file mode 100644
index 98a3716efa37e..0000000000000
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ /dev/null
@@ -1,45 +0,0 @@
-C IRIW+mbonceonces+OnceOnce
-
-(*
- * Result: Never
- *
- * Test of independent reads from independent writes with smp_mb()
- * between each pairs of reads.  In other words, is smp_mb() sufficient to
- * cause two different reading processes to agree on the order of a pair
- * of writes, where each write is to a different variable by a different
- * process?  This litmus test exercises LKMM's "propagation" rule.
- *)
-
-{}
-
-P0(int *x)
-{
-	WRITE_ONCE(*x, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-	int r1;
-
-	r0 = READ_ONCE(*x);
-	smp_mb();
-	r1 = READ_ONCE(*y);
-}
-
-P2(int *y)
-{
-	WRITE_ONCE(*y, 1);
-}
-
-P3(int *x, int *y)
-{
-	int r0;
-	int r1;
-
-	r0 = READ_ONCE(*y);
-	smp_mb();
-	r1 = READ_ONCE(*x);
-}
-
-exists (1:r0=1 /\ 1:r1=0 /\ 3:r0=1 /\ 3:r1=0)
diff --git a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
deleted file mode 100644
index de6708229dd11..0000000000000
--- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
+++ /dev/null
@@ -1,34 +0,0 @@
-C LB+ctrlonceonce+mbonceonce
-
-(*
- * Result: Never
- *
- * This litmus test demonstrates that lightweight ordering suffices for
- * the load-buffering pattern, in other words, preventing all processes
- * reading from the preceding process's write.  In this example, the
- * combination of a control dependency and a full memory barrier are enough
- * to do the trick.  (But the full memory barrier could be replaced with
- * another control dependency and order would still be maintained.)
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	int r0;
-
-	r0 = READ_ONCE(*x);
-	if (r0)
-		WRITE_ONCE(*y, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-
-	r0 = READ_ONCE(*y);
-	smp_mb();
-	WRITE_ONCE(*x, 1);
-}
-
-exists (0:r0=1 /\ 1:r0=1)
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
new file mode 100644
index 0000000000000..4727f5aaf03b0
--- /dev/null
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -0,0 +1,34 @@
+C LB+fencembonceonce+ctrlonceonce
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that lightweight ordering suffices for
+ * the load-buffering pattern, in other words, preventing all processes
+ * reading from the preceding process's write.  In this example, the
+ * combination of a control dependency and a full memory barrier are enough
+ * to do the trick.  (But the full memory barrier could be replaced with
+ * another control dependency and order would still be maintained.)
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r0;
+
+	r0 = READ_ONCE(*x);
+	if (r0)
+		WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	r0 = READ_ONCE(*y);
+	smp_mb();
+	WRITE_ONCE(*x, 1);
+}
+
+exists (0:r0=1 /\ 1:r0=1)
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
new file mode 100644
index 0000000000000..a273da9faa6d3
--- /dev/null
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -0,0 +1,30 @@
+C MP+fencewmbonceonce+fencermbonceonce
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that smp_wmb() and smp_rmb() provide
+ * sufficient ordering for the message-passing pattern.  However, it
+ * is usually better to use smp_store_release() and smp_load_acquire().
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	WRITE_ONCE(*x, 1);
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*y);
+	smp_rmb();
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
deleted file mode 100644
index c078f38ff27ac..0000000000000
--- a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
+++ /dev/null
@@ -1,30 +0,0 @@
-C MP+wmbonceonce+rmbonceonce
-
-(*
- * Result: Never
- *
- * This litmus test demonstrates that smp_wmb() and smp_rmb() provide
- * sufficient ordering for the message-passing pattern.  However, it
- * is usually better to use smp_store_release() and smp_load_acquire().
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	WRITE_ONCE(*x, 1);
-	smp_wmb();
-	WRITE_ONCE(*y, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-	int r1;
-
-	r0 = READ_ONCE(*y);
-	smp_rmb();
-	r1 = READ_ONCE(*x);
-}
-
-exists (1:r0=1 /\ 1:r1=0)
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
new file mode 100644
index 0000000000000..222a0b850b4a5
--- /dev/null
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -0,0 +1,30 @@
+C R+fencembonceonces
+
+(*
+ * Result: Never
+ *
+ * This is the fully ordered (via smp_mb()) version of one of the classic
+ * counterintuitive litmus tests that illustrates the effects of store
+ * propagation delays.  Note that weakening either of the barriers would
+ * cause the resulting test to be allowed.
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	WRITE_ONCE(*y, 2);
+	smp_mb();
+	r0 = READ_ONCE(*x);
+}
+
+exists (y=2 /\ 1:r0=0)
diff --git a/tools/memory-model/litmus-tests/R+mbonceonces.litmus b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
deleted file mode 100644
index a0e884ad21321..0000000000000
--- a/tools/memory-model/litmus-tests/R+mbonceonces.litmus
+++ /dev/null
@@ -1,30 +0,0 @@
-C R+mbonceonces
-
-(*
- * Result: Never
- *
- * This is the fully ordered (via smp_mb()) version of one of the classic
- * counterintuitive litmus tests that illustrates the effects of store
- * propagation delays.  Note that weakening either of the barriers would
- * cause the resulting test to be allowed.
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	WRITE_ONCE(*x, 1);
-	smp_mb();
-	WRITE_ONCE(*y, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-
-	WRITE_ONCE(*y, 2);
-	smp_mb();
-	r0 = READ_ONCE(*x);
-}
-
-exists (y=2 /\ 1:r0=0)
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 9c0ea65c53621..a41b027234286 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -20,7 +20,7 @@ CoWW+poonceonce.litmus
 	Test of write-write coherence, that is, whether or not two
 	successive writes to the same variable are ordered.
 
-IRIW+mbonceonces+OnceOnce.litmus
+IRIW+fencembonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with smp_mb()
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
@@ -49,7 +49,7 @@ ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
 	Can a release-acquire chain order a prior store against
 	a later load?
 
-LB+ctrlonceonce+mbonceonce.litmus
+LB+fencembonceonce+ctrlonceonce.litmus
 	Does a control dependency and an smp_mb() suffice for the
 	load-buffering litmus test, where each process reads from one
 	of two variables then writes to the other?
@@ -90,14 +90,14 @@ MP+porevlocks.litmus
 	As below, but with the first access of the writer process
 	and the second access of reader process protected by a lock.
 
-MP+wmbonceonce+rmbonceonce.litmus
+MP+fencewmbonceonce+fencermbonceonce.litmus
 	Does a smp_wmb() (between the stores) and an smp_rmb() (between
 	the loads) suffice for the message-passing litmus test, where one
 	process writes data and then a flag, and the other process reads
 	the flag and then the data.  (This is similar to the ISA2 tests,
 	but with two processes instead of three.)
 
-R+mbonceonces.litmus
+R+fencembonceonces.litmus
 	This is the fully ordered (via smp_mb()) version of one of
 	the classic counterintuitive litmus tests that illustrates the
 	effects of store propagation delays.
@@ -105,7 +105,7 @@ R+mbonceonces.litmus
 R+poonceonces.litmus
 	As above, but without the smp_mb() invocations.
 
-SB+mbonceonces.litmus
+SB+fencembonceonces.litmus
 	This is the fully ordered (again, via smp_mb() version of store
 	buffering, which forms the core of Dekker's mutual-exclusion
 	algorithm.
@@ -125,12 +125,12 @@ SB+rfionceonce-poonceonces.litmus
 S+poonceonces.litmus
 	As below, but without the smp_wmb() and acquire load.
 
-S+wmbonceonce+poacquireonce.litmus
+S+fencewmbonceonce+poacquireonce.litmus
 	Can a smp_wmb(), instead of a release, and an acquire order
 	a prior store against a subsequent store?
 
 WRC+poonceonces+Once.litmus
-WRC+pooncerelease+rmbonceonce+Once.litmus
+WRC+pooncerelease+fencermbonceonce+Once.litmus
 	These two are members of an extension of the MP litmus-test
 	class in which the first write is moved to a separate process.
 	The second is forbidden because smp_store_release() is
@@ -145,7 +145,7 @@ Z6.0+pooncelock+poonceLock+pombonce.litmus
 	As above, but with smp_mb__after_spinlock() immediately
 	following the spin_lock().
 
-Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
+Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
 	Is the ordering provided by a release-acquire chain sufficient
 	to make ordering apparent to accesses by a process that does
 	not participate in that release-acquire chain?
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
new file mode 100644
index 0000000000000..18479823cd6cc
--- /dev/null
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -0,0 +1,27 @@
+C S+fencewmbonceonce+poacquireonce
+
+(*
+ * Result: Never
+ *
+ * Can a smp_wmb(), instead of a release, and an acquire order a prior
+ * store against a subsequent store?
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	WRITE_ONCE(*x, 2);
+	smp_wmb();
+	WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	r0 = smp_load_acquire(y);
+	WRITE_ONCE(*x, 1);
+}
+
+exists (x=2 /\ 1:r0=1)
diff --git a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
deleted file mode 100644
index c53350205d282..0000000000000
--- a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
+++ /dev/null
@@ -1,27 +0,0 @@
-C S+wmbonceonce+poacquireonce
-
-(*
- * Result: Never
- *
- * Can a smp_wmb(), instead of a release, and an acquire order a prior
- * store against a subsequent store?
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	WRITE_ONCE(*x, 2);
-	smp_wmb();
-	WRITE_ONCE(*y, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-
-	r0 = smp_load_acquire(y);
-	WRITE_ONCE(*x, 1);
-}
-
-exists (x=2 /\ 1:r0=1)
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
new file mode 100644
index 0000000000000..ed5fff18d2232
--- /dev/null
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -0,0 +1,32 @@
+C SB+fencembonceonces
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that full memory barriers suffice to
+ * order the store-buffering pattern, where each process writes to the
+ * variable that the preceding process reads.  (Locking and RCU can also
+ * suffice, but not much else.)
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	int r0;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	r0 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	WRITE_ONCE(*y, 1);
+	smp_mb();
+	r0 = READ_ONCE(*x);
+}
+
+exists (0:r0=0 /\ 1:r0=0)
diff --git a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
deleted file mode 100644
index 74b874ffa8dad..0000000000000
--- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
+++ /dev/null
@@ -1,32 +0,0 @@
-C SB+mbonceonces
-
-(*
- * Result: Never
- *
- * This litmus test demonstrates that full memory barriers suffice to
- * order the store-buffering pattern, where each process writes to the
- * variable that the preceding process reads.  (Locking and RCU can also
- * suffice, but not much else.)
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	int r0;
-
-	WRITE_ONCE(*x, 1);
-	smp_mb();
-	r0 = READ_ONCE(*y);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-
-	WRITE_ONCE(*y, 1);
-	smp_mb();
-	r0 = READ_ONCE(*x);
-}
-
-exists (0:r0=0 /\ 1:r0=0)
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
new file mode 100644
index 0000000000000..e9947250d7de6
--- /dev/null
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -0,0 +1,38 @@
+C WRC+pooncerelease+fencermbonceonce+Once
+
+(*
+ * Result: Never
+ *
+ * This litmus test is an extension of the message-passing pattern, where
+ * the first write is moved to a separate process.  Because it features
+ * a release and a read memory barrier, it should be forbidden.  More
+ * specifically, this litmus test is forbidden because smp_store_release()
+ * is A-cumulative in LKMM.
+ *)
+
+{}
+
+P0(int *x)
+{
+	WRITE_ONCE(*x, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+
+	r0 = READ_ONCE(*x);
+	smp_store_release(y, 1);
+}
+
+P2(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*y);
+	smp_rmb();
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
deleted file mode 100644
index ad3448b941e68..0000000000000
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ /dev/null
@@ -1,38 +0,0 @@
-C WRC+pooncerelease+rmbonceonce+Once
-
-(*
- * Result: Never
- *
- * This litmus test is an extension of the message-passing pattern, where
- * the first write is moved to a separate process.  Because it features
- * a release and a read memory barrier, it should be forbidden.  More
- * specifically, this litmus test is forbidden because smp_store_release()
- * is A-cumulative in LKMM.
- *)
-
-{}
-
-P0(int *x)
-{
-	WRITE_ONCE(*x, 1);
-}
-
-P1(int *x, int *y)
-{
-	int r0;
-
-	r0 = READ_ONCE(*x);
-	smp_store_release(y, 1);
-}
-
-P2(int *x, int *y)
-{
-	int r0;
-	int r1;
-
-	r0 = READ_ONCE(*y);
-	smp_rmb();
-	r1 = READ_ONCE(*x);
-}
-
-exists (1:r0=1 /\ 2:r0=1 /\ 2:r1=0)
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
new file mode 100644
index 0000000000000..88e70b87a683e
--- /dev/null
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -0,0 +1,42 @@
+C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
+
+(*
+ * Result: Sometimes
+ *
+ * This litmus test shows that a release-acquire chain, while sufficient
+ * when there is but one non-reads-from (AKA non-rf) link, does not suffice
+ * if there is more than one.  Of the three processes, only P1() reads from
+ * P0's write, which means that there are two non-rf links: P1() to P2()
+ * is a write-to-write link (AKA a "coherence" or just "co" link) and P2()
+ * to P0() is a read-to-write link (AKA a "from-reads" or just "fr" link).
+ * When there are two or more non-rf links, you typically will need one
+ * full barrier for each non-rf link.  (Exceptions include some cases
+ * involving locking.)
+ *)
+
+{}
+
+P0(int *x, int *y)
+{
+	WRITE_ONCE(*x, 1);
+	smp_store_release(y, 1);
+}
+
+P1(int *y, int *z)
+{
+	int r0;
+
+	r0 = smp_load_acquire(y);
+	smp_store_release(z, 1);
+}
+
+P2(int *x, int *z)
+{
+	int r1;
+
+	WRITE_ONCE(*z, 2);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r0=1 /\ z=2 /\ 2:r1=0)
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
deleted file mode 100644
index a20fc3fafb536..0000000000000
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
+++ /dev/null
@@ -1,42 +0,0 @@
-C Z6.0+pooncerelease+poacquirerelease+mbonceonce
-
-(*
- * Result: Sometimes
- *
- * This litmus test shows that a release-acquire chain, while sufficient
- * when there is but one non-reads-from (AKA non-rf) link, does not suffice
- * if there is more than one.  Of the three processes, only P1() reads from
- * P0's write, which means that there are two non-rf links: P1() to P2()
- * is a write-to-write link (AKA a "coherence" or just "co" link) and P2()
- * to P0() is a read-to-write link (AKA a "from-reads" or just "fr" link).
- * When there are two or more non-rf links, you typically will need one
- * full barrier for each non-rf link.  (Exceptions include some cases
- * involving locking.)
- *)
-
-{}
-
-P0(int *x, int *y)
-{
-	WRITE_ONCE(*x, 1);
-	smp_store_release(y, 1);
-}
-
-P1(int *y, int *z)
-{
-	int r0;
-
-	r0 = smp_load_acquire(y);
-	smp_store_release(z, 1);
-}
-
-P2(int *x, int *z)
-{
-	int r1;
-
-	WRITE_ONCE(*z, 2);
-	smp_mb();
-	r1 = READ_ONCE(*x);
-}
-
-exists (1:r0=1 /\ z=2 /\ 2:r1=0)
-- 
2.7.4
