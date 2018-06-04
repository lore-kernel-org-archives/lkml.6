Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127571-2-11779983465711656508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127571; b=iZ3vjpSuRdZ8p0wR1tqhKraH9UCtZE1PG+YQiD4+pjz9EvCSds
    7XDr8KvFqFsl9DdxVHeMJwopoI4PvGyGOY6ZCnQaRZI1b2Gy2D2T565I9rPRTBGD
    KxawgkrstoVIH46ffcbRR3Uc+t92cnLJ+z3R4lq39Vio269Vypd0sJ5xLesx6Vcz
    vYJ//TgOlqwxYZ5CUMbMfyBeBh1aVLTea/CrA5HGJBpNQg1ttpr800s4Ewd4Loim
    C28gmR6I+DOzhFVH1PteFrMKDRQgCKesOXlu+wEskC7ZxvE/gkeEEGsybGngiTEN
    fum3EV45URk5sznAdvSIAP8HJ5uZd+jAom9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127571;
    bh=f8bS7xbYiT6dPh3SiE/VPCVzjAvnT0FQUwIQgIL83uE=; b=mPykr1US8pwS
    OZ3ZUZfA86usWPC8kR5oz3maFeWQq9CqsbTs/VmeDIeDqYLVpqxMockgqiZ4gEsp
    j9aw4EMG+henMyQjlr6uPhs8e0p4XTbZFYFeNLmsex4l7HaOQrj6R3te2LnErg44
    t/n7qYsplBmOv737O7ZYfynZ33tZdosKSJ2UViXb8akU53MMkgsFbwMGo62rqsox
    tq1PDzEetsrjOOYF6BV5mietKdVYPVUQ82sYkq28v/ohWFaTSAsMVyD1D/Ch7crz
    hy3IE3GuEceq8b/wdBC7+yakeQr6qMR9pec941R0Pq6tnv1CrzKs76WSveSuKdLh
    eHwbUppv1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MvUsSP0C header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MvUsSP0C header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN6irkbtjvxMEFXq/JSDOeLtE8YTfIIarRaDWQ8o3Yxl6STPnzaP+AtkFzUzPXmWdWtEi/qkoSSOeOGhk68nxGCGSHZdTWSpe0M+z2KWKmKAsT997WOX
    dGFpwZOqxUaOfxE+GLp3Fg98C6RLTxzFEShvdBzKrdxGrFHSgAR+l9qPfJpfJzRHft+icKzHjlr29jcLvSqHHRT7y+6NcALGWz3TFD5UwUEK2aCXZC+vYPxd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=XWeSUzrNnRpZnOfkSNwA:9
    a=V0ZhZUxM9IFzm0lw:21 a=AFQ-xZWUaP0qNnFF:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFDPws (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFDPwr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:52:47 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [RFC PATCH -tip v5 08/27] ia64: kprobes: Remove jprobe implementation
Date: Tue,  5 Jun 2018 00:52:23 +0900
Message-Id: <152812754313.10068.18139644090022750444.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/ia64.

Note that since ia64 jprobes code a bit different
from other arch, this keeps __IA64_BREAK_JPROBE
for checking break_handler. It will be removed
with break_handler() call afterwards.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/kprobes.h |    2 -
 arch/ia64/kernel/Makefile       |    2 -
 arch/ia64/kernel/jprobes.S      |   90 ---------------------------------------
 arch/ia64/kernel/kprobes.c      |   70 ------------------------------
 4 files changed, 1 insertion(+), 163 deletions(-)
 delete mode 100644 arch/ia64/kernel/jprobes.S

diff --git a/arch/ia64/include/asm/kprobes.h b/arch/ia64/include/asm/kprobes.h
index 0302b3664789..580356a2eea6 100644
--- a/arch/ia64/include/asm/kprobes.h
+++ b/arch/ia64/include/asm/kprobes.h
@@ -82,8 +82,6 @@ struct prev_kprobe {
 #define ARCH_PREV_KPROBE_SZ 2
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
-	struct pt_regs jprobe_saved_regs;
-	unsigned long jprobes_saved_stacked_regs[MAX_PARAM_RSE_SIZE];
 	unsigned long *bsp;
 	unsigned long cfm;
 	atomic_t prev_kprobe_index;
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 498f3da3f225..d0c0ccdd656a 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_PERFMON)		+= perfmon_default_smpl.o
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
diff --git a/arch/ia64/kernel/jprobes.S b/arch/ia64/kernel/jprobes.S
deleted file mode 100644
index f69389c7be1d..000000000000
--- a/arch/ia64/kernel/jprobes.S
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * Jprobe specific operations
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- * Copyright (C) Intel Corporation, 2005
- *
- * 2005-May     Rusty Lynch <rusty.lynch@intel.com> and Anil S Keshavamurthy
- *              <anil.s.keshavamurthy@intel.com> initial implementation
- *
- * Jprobes (a.k.a. "jump probes" which is built on-top of kprobes) allow a
- * probe to be inserted into the beginning of a function call.  The fundamental
- * difference between a jprobe and a kprobe is the jprobe handler is executed
- * in the same context as the target function, while the kprobe handlers
- * are executed in interrupt context.
- *
- * For jprobes we initially gain control by placing a break point in the
- * first instruction of the targeted function.  When we catch that specific
- * break, we:
- *        * set the return address to our jprobe_inst_return() function
- *        * jump to the jprobe handler function
- *
- * Since we fixed up the return address, the jprobe handler will return to our
- * jprobe_inst_return() function, giving us control again.  At this point we
- * are back in the parents frame marker, so we do yet another call to our
- * jprobe_break() function to fix up the frame marker as it would normally
- * exist in the target function.
- *
- * Our jprobe_return function then transfers control back to kprobes.c by
- * executing a break instruction using one of our reserved numbers.  When we
- * catch that break in kprobes.c, we continue like we do for a normal kprobe
- * by single stepping the emulated instruction, and then returning execution
- * to the correct location.
- */
-#include <asm/asmmacro.h>
-#include <asm/break.h>
-
-	/*
-	 * void jprobe_break(void)
-	 */
-	.section .kprobes.text, "ax"
-ENTRY(jprobe_break)
-	break.m __IA64_BREAK_JPROBE
-END(jprobe_break)
-
-	/*
-	 * void jprobe_inst_return(void)
-	 */
-GLOBAL_ENTRY(jprobe_inst_return)
-	br.call.sptk.many b0=jprobe_break
-END(jprobe_inst_return)
-
-GLOBAL_ENTRY(invalidate_stacked_regs)
-	movl r16=invalidate_restore_cfm
-	;;
-	mov b6=r16
-	;;
-	br.ret.sptk.many b6
-	;;
-invalidate_restore_cfm:
-	mov r16=ar.rsc
-	;;
-	mov ar.rsc=r0
-	;;
-	loadrs
-	;;
-	mov ar.rsc=r16
-	;;
-	br.cond.sptk.many rp
-END(invalidate_stacked_regs)
-
-GLOBAL_ENTRY(flush_register_stack)
-	// flush dirty regs to backing store (must be first in insn group)
-	flushrs
-	;;
-	br.ret.sptk.many rp
-END(flush_register_stack)
-
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index f5f3a5e6fcd1..823e4bd03a18 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -35,8 +35,6 @@
 #include <asm/sections.h>
 #include <asm/exception.h>
 
-extern void jprobe_inst_return(void);
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -1040,74 +1038,6 @@ unsigned long arch_deref_entry_point(void *entry)
 	return ((struct fnptr *)entry)->ip;
 }
 
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	unsigned long addr = arch_deref_entry_point(jp->entry);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	struct param_bsp_cfm pa;
-	int bytes;
-
-	/*
-	 * Callee owns the argument space and could overwrite it, eg
-	 * tail call optimization. So to be absolutely safe
-	 * we save the argument space before transferring the control
-	 * to instrumented jprobe function which runs in
-	 * the process context
-	 */
-	pa.ip = regs->cr_iip;
-	unw_init_running(ia64_get_bsp_cfm, &pa);
-	bytes = (char *)ia64_rse_skip_regs(pa.bsp, pa.cfm & 0x3f)
-				- (char *)pa.bsp;
-	memcpy( kcb->jprobes_saved_stacked_regs,
-		pa.bsp,
-		bytes );
-	kcb->bsp = pa.bsp;
-	kcb->cfm = pa.cfm;
-
-	/* save architectural state */
-	kcb->jprobe_saved_regs = *regs;
-
-	/* after rfi, execute the jprobe instrumented function */
-	regs->cr_iip = addr & ~0xFULL;
-	ia64_psr(regs)->ri = addr & 0xf;
-	regs->r1 = ((struct fnptr *)(jp->entry))->gp;
-
-	/*
-	 * fix the return address to our jprobe_inst_return() function
-	 * in the jprobes.S file
-	 */
-	regs->b0 = ((struct fnptr *)(jprobe_inst_return))->ip;
-
-	return 1;
-}
-
-/* ia64 does not need this */
-void __kprobes jprobe_return(void)
-{
-}
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	int bytes;
-
-	/* restoring architectural state */
-	*regs = kcb->jprobe_saved_regs;
-
-	/* restoring the original argument space */
-	flush_register_stack();
-	bytes = (char *)ia64_rse_skip_regs(kcb->bsp, kcb->cfm & 0x3f)
-				- (char *)kcb->bsp;
-	memcpy( kcb->bsp,
-		kcb->jprobes_saved_stacked_regs,
-		bytes );
-	invalidate_stacked_regs();
-
-	preempt_enable_no_resched();
-	return 1;
-}
-
 static struct kprobe trampoline_p = {
 	.pre_handler = trampoline_probe_handler
 };
