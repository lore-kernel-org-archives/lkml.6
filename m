Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF371ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9978120856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9978120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbeGTAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:25:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeGTAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:25:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNcqBO2454662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:38:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNcqim2454659;
        Thu, 19 Jul 2018 16:38:52 -0700
Date:   Thu, 19 Jul 2018 16:38:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-97193702c6d353e12aefc0fb2f73a98ca421cd56@git.kernel.org>
Cc:     dvlasenk@redhat.com, boris.ostrovsky@oracle.com,
        David.Laight@aculab.com, llong@redhat.com, luto@kernel.org,
        hpa@zytor.com, jroedel@suse.de, peterz@infradead.org, pavel@ucw.cz,
        eduval@amazon.com, aarcange@redhat.com, jpoimboe@redhat.com,
        jgross@suse.com, mingo@kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, brgerst@gmail.com,
        dhgutteridge@sympatico.ca, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, dave.hansen@intel.com, jkosina@suse.cz,
        tglx@linutronix.de, gregkh@linuxfoundation.org
Reply-To: aarcange@redhat.com, jpoimboe@redhat.com, eduval@amazon.com,
          pavel@ucw.cz, hpa@zytor.com, peterz@infradead.org,
          jroedel@suse.de, David.Laight@aculab.com, luto@kernel.org,
          llong@redhat.com, boris.ostrovsky@oracle.com,
          dvlasenk@redhat.com, jkosina@suse.cz, dave.hansen@intel.com,
          will.deacon@arm.com, gregkh@linuxfoundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          dhgutteridge@sympatico.ca, brgerst@gmail.com, bp@alien8.de,
          mingo@kernel.org, jgross@suse.com, torvalds@linux-foundation.org
In-Reply-To: <1531906876-13451-40-git-send-email-joro@8bytes.org>
References: <1531906876-13451-40-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Add debug code to check entry/exit CR3
Git-Commit-ID: 97193702c6d353e12aefc0fb2f73a98ca421cd56
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

Commit-ID:  97193702c6d353e12aefc0fb2f73a98ca421cd56
Gitweb:     https://git.kernel.org/tip/97193702c6d353e12aefc0fb2f73a98ca421cd56
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:16 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:49 +0200

x86/entry/32: Add debug code to check entry/exit CR3

Add code to check whether the kernel is entered and left with the correct
CR3 and make it depend on CONFIG_DEBUG_ENTRY.  This is needed because there
is no NX protection of user-addresses in the kernel-CR3 on x86-32 and that
type of bug would not be detected otherwise.

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
Link: https://lkml.kernel.org/r/1531906876-13451-40-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b1541c74c71a..010cdb41e3c7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -166,6 +166,24 @@
 .Lend_\@:
 .endm
 
+.macro BUG_IF_WRONG_CR3 no_user_check=0
+#ifdef CONFIG_DEBUG_ENTRY
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+	.if \no_user_check == 0
+	/* coming from usermode? */
+	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	jz	.Lend_\@
+	.endif
+	/* On user-cr3? */
+	movl	%cr3, %eax
+	testl	$PTI_SWITCH_MASK, %eax
+	jnz	.Lend_\@
+	/* From userspace with kernel cr3 - BUG */
+	ud2
+.Lend_\@:
+#endif
+.endm
+
 /*
  * Switch to kernel cr3 if not already loaded and return current cr3 in
  * \scratch_reg
@@ -213,6 +231,8 @@
 .macro SAVE_ALL_NMI cr3_reg:req
 	SAVE_ALL
 
+	BUG_IF_WRONG_CR3
+
 	/*
 	 * Now switch the CR3 when PTI is enabled.
 	 *
@@ -224,6 +244,7 @@
 
 .Lend_\@:
 .endm
+
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
  * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
@@ -287,6 +308,8 @@
 
 .Lswitched_\@:
 
+	BUG_IF_WRONG_CR3
+
 	RESTORE_REGS pop=\pop
 .endm
 
@@ -357,6 +380,8 @@
 
 	ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
 
+	BUG_IF_WRONG_CR3
+
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 
 	/*
@@ -799,6 +824,7 @@ ENTRY(entry_SYSENTER_32)
 	 */
 	pushfl
 	pushl	%eax
+	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 	popl	%eax
 	popfl
@@ -893,6 +919,7 @@ ENTRY(entry_SYSENTER_32)
 	 * whereas POPF does not.)
 	 */
 	btrl	$X86_EFLAGS_IF_BIT, (%esp)
+	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
 
@@ -970,6 +997,8 @@ restore_all:
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 
+	BUG_IF_WRONG_CR3
+
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
 .Lirq_return:
@@ -983,6 +1012,7 @@ restore_all:
 restore_all_kernel:
 	TRACE_IRQS_IRET
 	PARANOID_EXIT_TO_KERNEL_MODE
+	BUG_IF_WRONG_CR3
 	RESTORE_REGS 4
 	jmp	.Lirq_return
 
@@ -990,6 +1020,19 @@ restore_all_kernel:
 ENTRY(iret_exc	)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
+
+#ifdef CONFIG_DEBUG_ENTRY
+	/*
+	 * The stack-frame here is the one that iret faulted on, so its a
+	 * return-to-user frame. We are on kernel-cr3 because we come here from
+	 * the fixup code. This confuses the CR3 checker, so switch to user-cr3
+	 * as the checker expects it.
+	 */
+	pushl	%eax
+	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	popl	%eax
+#endif
+
 	jmp	common_exception
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
