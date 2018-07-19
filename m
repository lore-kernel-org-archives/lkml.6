Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91679ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E3E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGTAI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:08:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbeGTAI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:08:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNMWBr2451302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:22:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNMW0W2451299;
        Thu, 19 Jul 2018 16:22:32 -0700
Date:   Thu, 19 Jul 2018 16:22:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-e5862d0515ad970ccec6208ecf5bb0cffe291ea3@git.kernel.org>
Cc:     dvlasenk@redhat.com, mingo@kernel.org, will.deacon@arm.com,
        jgross@suse.com, tglx@linutronix.de, eduval@amazon.com,
        torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
        dave.hansen@intel.com, peterz@infradead.org, hpa@zytor.com,
        brgerst@gmail.com, jpoimboe@redhat.com, luto@kernel.org,
        boris.ostrovsky@oracle.com, David.Laight@aculab.com, bp@alien8.de,
        aarcange@redhat.com, llong@redhat.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jroedel@suse.de, jkosina@suse.cz, pavel@ucw.cz
Reply-To: hpa@zytor.com, peterz@infradead.org, brgerst@gmail.com,
          jpoimboe@redhat.com, eduval@amazon.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
          dave.hansen@intel.com, jgross@suse.com, dvlasenk@redhat.com,
          mingo@kernel.org, will.deacon@arm.com,
          gregkh@linuxfoundation.org, jroedel@suse.de, jkosina@suse.cz,
          pavel@ucw.cz, aarcange@redhat.com, llong@redhat.com,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          boris.ostrovsky@oracle.com, David.Laight@aculab.com,
          luto@kernel.org
In-Reply-To: <1531906876-13451-9-git-send-email-joro@8bytes.org>
References: <1531906876-13451-9-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Leave the kernel via trampoline stack
Git-Commit-ID: e5862d0515ad970ccec6208ecf5bb0cffe291ea3
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

Commit-ID:  e5862d0515ad970ccec6208ecf5bb0cffe291ea3
Gitweb:     https://git.kernel.org/tip/e5862d0515ad970ccec6208ecf5bb0cffe291ea3
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:45 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:37 +0200

x86/entry/32: Leave the kernel via trampoline stack

Switch back to the trampoline stack before returning to userspace.

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
Link: https://lkml.kernel.org/r/1531906876-13451-9-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 79 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index fea49ec345ba..a905e6215ea9 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -342,6 +342,60 @@
 .Lend_\@:
 .endm
 
+/*
+ * Switch back from the kernel stack to the entry stack.
+ *
+ * The %esp register must point to pt_regs on the task stack. It will
+ * first calculate the size of the stack-frame to copy, depending on
+ * whether we return to VM86 mode or not. With that it uses 'rep movsl'
+ * to copy the contents of the stack over to the entry stack.
+ *
+ * We must be very careful here, as we can't trust the contents of the
+ * task-stack once we switched to the entry-stack. When an NMI happens
+ * while on the entry-stack, the NMI handler will switch back to the top
+ * of the task stack, overwriting our stack-frame we are about to copy.
+ * Therefore we switch the stack only after everything is copied over.
+ */
+.macro SWITCH_TO_ENTRY_STACK
+
+	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
+
+	/* Bytes to copy */
+	movl	$PTREGS_SIZE, %ecx
+
+#ifdef CONFIG_VM86
+	testl	$(X86_EFLAGS_VM), PT_EFLAGS(%esp)
+	jz	.Lcopy_pt_regs_\@
+
+	/* Additional 4 registers to copy when returning to VM86 mode */
+	addl    $(4 * 4), %ecx
+
+.Lcopy_pt_regs_\@:
+#endif
+
+	/* Initialize source and destination for movsl */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
+	subl	%ecx, %edi
+	movl	%esp, %esi
+
+	/* Save future stack pointer in %ebx */
+	movl	%edi, %ebx
+
+	/* Copy over the stack-frame */
+	shrl	$2, %ecx
+	cld
+	rep movsl
+
+	/*
+	 * Switch to entry-stack - needs to happen after everything is
+	 * copied because the NMI handler will overwrite the task-stack
+	 * when on entry-stack
+	 */
+	movl	%ebx, %esp
+
+.Lend_\@:
+.endm
+
 /*
  * %eax: prev task
  * %edx: next task
@@ -581,25 +635,45 @@ ENTRY(entry_SYSENTER_32)
 
 /* Opportunistic SYSEXIT */
 	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
+
+	/*
+	 * Setup entry stack - we keep the pointer in %eax and do the
+	 * switch after almost all user-state is restored.
+	 */
+
+	/* Load entry stack pointer and allocate frame for eflags/eax */
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %eax
+	subl	$(2*4), %eax
+
+	/* Copy eflags and eax to entry stack */
+	movl	PT_EFLAGS(%esp), %edi
+	movl	PT_EAX(%esp), %esi
+	movl	%edi, (%eax)
+	movl	%esi, 4(%eax)
+
+	/* Restore user registers and segments */
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
 	PTGS_TO_GS
+
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
 	popl	%esi			/* pt_regs->si */
 	popl	%edi			/* pt_regs->di */
 	popl	%ebp			/* pt_regs->bp */
-	popl	%eax			/* pt_regs->ax */
+
+	/* Switch to entry stack */
+	movl	%eax, %esp
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
 	 * STI gives a one-instruction window in which we won't be interrupted,
 	 * whereas POPF does not.)
 	 */
-	addl	$PT_EFLAGS-PT_DS, %esp	/* point esp at pt_regs->flags */
 	btrl	$X86_EFLAGS_IF_BIT, (%esp)
 	popfl
+	popl	%eax
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -668,6 +742,7 @@ ENTRY(entry_INT80_32)
 
 restore_all:
 	TRACE_IRQS_IRET
+	SWITCH_TO_ENTRY_STACK
 .Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
