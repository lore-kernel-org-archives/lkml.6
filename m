Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeEOWDo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:03:44 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:49759 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeEOWDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:03:43 -0400
Date: Tue, 15 May 2018 23:03:09 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: ptrace: Make FPU context layout comments match
 reality
Message-ID: <alpine.DEB.2.00.1805141441260.10896@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526421797-321459-26066-18901-1
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193019
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct comments across ptrace(2) handlers about an FPU register context
layout discrepancy between MIPS I and later ISAs, which was fixed with
`linux-mips.org' (LMO) commit 42533948caac ("Major pile of FP emulator
changes."), the fix corrected with LMO commit 849fa7a50dff ("R3k FPU
ptrace() handling fixes."), and then broken and fixed over and over
again, until last time fixed with commit 80cbfad79096 ("MIPS: Correct
MIPS I FP context layout").

NB running the GDB test suite for the relevant ABI/ISA and watching out 
for regressions is advisable when poking around ptrace(2).

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

linux-mips-ptrace-r2300-switch-comment.diff
Index: linux/arch/mips/kernel/ptrace.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace.c	2018-05-10 21:24:39.000000000 +0100
+++ linux/arch/mips/kernel/ptrace.c	2018-05-12 13:28:01.156433000 +0100
@@ -1063,7 +1063,7 @@ long arch_ptrace(struct task_struct *chi
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
-				 * registers - unless we're using r2k_switch.S.
+				 * registers.
 				 */
 				tmp = get_fpr32(&fregs[(addr & ~1) - FPR_BASE],
 						addr & 1);
@@ -1158,7 +1158,7 @@ long arch_ptrace(struct task_struct *chi
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
-				 * registers - unless we're using r2k_switch.S.
+				 * registers.
 				 */
 				set_fpr32(&fregs[(addr & ~1) - FPR_BASE],
 					  addr & 1, data);
Index: linux-mipsswbrd038/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-mipsswbrd038.orig/arch/mips/kernel/ptrace32.c	2018-05-10 20:52:25.000000000 +0100
+++ linux-mipsswbrd038/arch/mips/kernel/ptrace32.c	2018-05-12 13:28:18.503568000 +0100
@@ -103,7 +103,7 @@ long compat_arch_ptrace(struct task_stru
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
-				 * registers - unless we're using r2k_switch.S.
+				 * registers.
 				 */
 				tmp = get_fpr32(&fregs[(addr & ~1) - FPR_BASE],
 						addr & 1);
@@ -216,7 +216,7 @@ long compat_arch_ptrace(struct task_stru
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
-				 * registers - unless we're using r2k_switch.S.
+				 * registers.
 				 */
 				set_fpr32(&fregs[(addr & ~1) - FPR_BASE],
 					  addr & 1, data);
