Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AF5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FFC20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FFC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeGTALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:11:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGTALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:11:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNOeb22453053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:24:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNOexv2453050;
        Thu, 19 Jul 2018 16:24:40 -0700
Date:   Thu, 19 Jul 2018 16:24:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-e464fb9f241ddf46815b31ca594af96f2699a78e@git.kernel.org>
Cc:     tglx@linutronix.de, eduval@amazon.com, bp@alien8.de,
        torvalds@linux-foundation.org, aarcange@redhat.com,
        jkosina@suse.cz, pavel@ucw.cz, David.Laight@aculab.com,
        mingo@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        luto@kernel.org, jgross@suse.com, dvlasenk@redhat.com,
        hpa@zytor.com, dhgutteridge@sympatico.ca, peterz@infradead.org,
        jroedel@suse.de, dave.hansen@intel.com, boris.ostrovsky@oracle.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, llong@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, bp@alien8.de, eduval@amazon.com,
          tglx@linutronix.de, brgerst@gmail.com, jpoimboe@redhat.com,
          luto@kernel.org, aarcange@redhat.com, mingo@kernel.org,
          David.Laight@aculab.com, jkosina@suse.cz, pavel@ucw.cz,
          jroedel@suse.de, peterz@infradead.org, dhgutteridge@sympatico.ca,
          dvlasenk@redhat.com, jgross@suse.com, hpa@zytor.com,
          gregkh@linuxfoundation.org, llong@redhat.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          will.deacon@arm.com, boris.ostrovsky@oracle.com
In-Reply-To: <1531906876-13451-13-git-send-email-joro@8bytes.org>
References: <1531906876-13451-13-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Add PTI cr3 switch to non-NMI
 entry/exit points
Git-Commit-ID: e464fb9f241ddf46815b31ca594af96f2699a78e
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

Commit-ID:  e464fb9f241ddf46815b31ca594af96f2699a78e
Gitweb:     https://git.kernel.org/tip/e464fb9f241ddf46815b31ca594af96f2699a78e
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:39 +0200

x86/entry/32: Add PTI cr3 switch to non-NMI entry/exit points

Add unconditional cr3 switches between user and kernel cr3 to all non-NMI
entry and exit points.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-13-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 86 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index dbf7d619dcd6..60b28dfa00dc 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -77,6 +77,8 @@
 #endif
 .endm
 
+#define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
+
 /*
  * User gs save/restore
  *
@@ -154,6 +156,33 @@
 
 #endif /* CONFIG_X86_32_LAZY_GS */
 
+/* Unconditionally switch to user cr3 */
+.macro SWITCH_TO_USER_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	movl	%cr3, \scratch_reg
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+	movl	\scratch_reg, %cr3
+.Lend_\@:
+.endm
+
+/*
+ * Switch to kernel cr3 if not already loaded and return current cr3 in
+ * \scratch_reg
+ */
+.macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	movl	%cr3, \scratch_reg
+	/* Test if we are already on kernel CR3 */
+	testl	$PTI_SWITCH_MASK, \scratch_reg
+	jz	.Lend_\@
+	andl	$(~PTI_SWITCH_MASK), \scratch_reg
+	movl	\scratch_reg, %cr3
+	/* Return original CR3 in \scratch_reg */
+	orl	$PTI_SWITCH_MASK, \scratch_reg
+.Lend_\@:
+.endm
+
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
 	cld
 	PUSH_GS
@@ -283,7 +312,6 @@
 #endif /* CONFIG_X86_ESPFIX32 */
 .endm
 
-
 /*
  * Called with pt_regs fully populated and kernel segments loaded,
  * so we can access PER_CPU and use the integer registers.
@@ -296,11 +324,19 @@
  */
 
 #define CS_FROM_ENTRY_STACK	(1 << 31)
+#define CS_FROM_USER_CR3	(1 << 30)
 
 .macro SWITCH_TO_KERNEL_STACK
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+
+	/*
+	 * %eax now contains the entry cr3 and we carry it forward in
+	 * that register for the time this macro runs
+	 */
+
 	/* Are we on the entry stack? Bail out if not! */
 	movl	PER_CPU_VAR(cpu_entry_area), %ecx
 	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
@@ -370,7 +406,8 @@
 	 * but switch back to the entry-stack again when we approach
 	 * iret and return to the interrupted code-path. This usually
 	 * happens when we hit an exception while restoring user-space
-	 * segment registers on the way back to user-space.
+	 * segment registers on the way back to user-space or when the
+	 * sysenter handler runs with eflags.tf set.
 	 *
 	 * When we switch to the task-stack here, we can't trust the
 	 * contents of the entry-stack anymore, as the exception handler
@@ -387,6 +424,7 @@
 	 *
 	 * %esi: Entry-Stack pointer (same as %esp)
 	 * %edi: Top of the task stack
+	 * %eax: CR3 on kernel entry
 	 */
 
 	/* Calculate number of bytes on the entry stack in %ecx */
@@ -402,6 +440,14 @@
 	/* Mark stackframe as coming from entry stack */
 	orl	$CS_FROM_ENTRY_STACK, PT_CS(%esp)
 
+	/*
+	 * Test the cr3 used to enter the kernel and add a marker
+	 * so that we can switch back to it before iret.
+	 */
+	testl	$PTI_SWITCH_MASK, %eax
+	jz	.Lcopy_pt_regs_\@
+	orl	$CS_FROM_USER_CR3, PT_CS(%esp)
+
 	/*
 	 * %esi and %edi are unchanged, %ecx contains the number of
 	 * bytes to copy. The code at .Lcopy_pt_regs_\@ will allocate
@@ -468,7 +514,7 @@
 
 /*
  * This macro handles the case when we return to kernel-mode on the iret
- * path and have to switch back to the entry stack.
+ * path and have to switch back to the entry stack and/or user-cr3
  *
  * See the comments below the .Lentry_from_kernel_\@ label in the
  * SWITCH_TO_KERNEL_STACK macro for more details.
@@ -514,6 +560,18 @@
 	/* Safe to switch to entry-stack now */
 	movl	%ebx, %esp
 
+	/*
+	 * We came from entry-stack and need to check if we also need to
+	 * switch back to user cr3.
+	 */
+	testl	$CS_FROM_USER_CR3, PT_CS(%esp)
+	jz	.Lend_\@
+
+	/* Clear marker from stack-frame */
+	andl	$(~CS_FROM_USER_CR3), PT_CS(%esp)
+
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 .Lend_\@:
 .endm
 /*
@@ -707,7 +765,20 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
+	/*
+	 * On entry-stack with all userspace-regs live - save and
+	 * restore eflags and %eax to use it as scratch-reg for the cr3
+	 * switch.
+	 */
+	pushfl
+	pushl	%eax
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
+	popl	%eax
+	popfl
+
+	/* Stack empty again, switch to task stack */
 	movl	TSS_entry2task_stack(%esp), %esp
+
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
@@ -786,6 +857,9 @@ ENTRY(entry_SYSENTER_32)
 	/* Switch to entry stack */
 	movl	%eax, %esp
 
+	/* Now ready to switch the cr3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
@@ -866,7 +940,11 @@ restore_all:
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
-	RESTORE_REGS 4				# skip orig_eax/error_code
+	/* Switch back to user CR3 */
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+
+	/* Restore user state */
+	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
