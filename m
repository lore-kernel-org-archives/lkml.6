Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeBBIlB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:41:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750795AbeBBIkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:40:52 -0500
Date: Thu, 1 Feb 2018 15:09:41 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the
 tool name
Reply-To: paulmck@linux.vnet.ibm.com
References: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
 <Pine.LNX.4.44L0.1802011026250.1677-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802011026250.1677-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020208-0040-0000-0000-000003ED9032
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008461; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983875; UDB=6.00499021; IPR=6.00763153;
 BA=6.00005808; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019331; XFM=3.00000015;
 UTC=2018-02-02 08:40:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020208-0041-0000-0000-000007E2FEFF
Message-Id: <20180201230941.GT3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 10:26:50AM -0500, Alan Stern wrote:
> On Thu, 1 Feb 2018, Andrea Parri wrote:
> 
> > Ingo pointed out that:
> > 
> >   "The "memory model" name is overly generic, ambiguous and somewhat
> >    misleading, as we usually mean the virtual memory layout/model
> >    when we say "memory model". GCC too uses it in that sense [...]"
> > 
> > Make it clearer that, in the context of tools/memory-model/, the term
> > "memory-model" is used as shorthand for "memory consistency model" by
> > calling out this convention in tools/memory-model/README.
> > 
> > Stick to the full name in sources' headers and for the subsystem name.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> 
> For both patches:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you all -- I have queued this and pushed it to my RCU tree on
branch lkmm.  I did reword the commit log a bit, please see below and
please let me know if any of my rewordings need halp.

Andrea, when you resend your second patch, could you please add Alan's
Acked-by?

							Thanx, Paul

------------------------------------------------------------------------

commit de175b697f71b8e3e6d980b7186b909fee0c4378
Author: Andrea Parri <parri.andrea@gmail.com>
Date:   Thu Feb 1 13:03:29 2018 +0100

    tools/memory-model: Clarify the origin/scope of the tool name
    
    Ingo pointed out that:
    
      "The "memory model" name is overly generic, ambiguous and somewhat
       misleading, as we usually mean the virtual memory layout/model
       when we say "memory model". GCC too uses it in that sense [...]"
    
    Make it clearer that tools/memory-model/ uses the term "memory model"
    is used as shorthand for "memory consistency model" by calling out this
    convention in tools/memory-model/README.
    
    Stick to the original "memory model" term in sources' headers and for
    the subsystem name.
    
    Suggested-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Acked-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

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
