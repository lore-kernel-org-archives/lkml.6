Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBIOWF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:22:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752305AbeBIOWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:22:01 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/lkmm 01/10] tools/memory-model: Clarify the origin/scope of the tool name
Date: Fri,  9 Feb 2018 06:20:22 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180209141832.GA17505@linux.vnet.ibm.com>
References: <20180209141832.GA17505@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020914-0040-0000-0000-000003F13109
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008504; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000250; SDB=6.00987227; UDB=6.00501083; IPR=6.00766586;
 BA=6.00005821; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019457; XFM=3.00000015;
 UTC=2018-02-09 14:21:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020914-0041-0000-0000-000007E6A66A
Message-Id: <1518186031-17997-1-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

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
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/MAINTAINERS       |  2 +-
 tools/memory-model/README            | 14 +++++++-------
 tools/memory-model/linux-kernel.bell |  2 +-
 tools/memory-model/linux-kernel.cat  |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
index 711cbe72d606..db3bd3fc0435 100644
--- a/tools/memory-model/MAINTAINERS
+++ b/tools/memory-model/MAINTAINERS
@@ -1,4 +1,4 @@
-LINUX KERNEL MEMORY MODEL
+LINUX KERNEL MEMORY CONSISTENCY MODEL
 M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will.deacon@arm.com>
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 43ba49492111..91414a49fac5 100644
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
index 57112505f5e0..b984bbda01a5 100644
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
index 15b7a5dd8a9a..babe2b3b0bb3 100644
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
2.5.2
