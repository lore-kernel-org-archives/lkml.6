Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE3BECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5BE20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5BE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGTAGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:06:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGTAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:06:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNKRru2450980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:20:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNKRvj2450977;
        Thu, 19 Jul 2018 16:20:27 -0700
Date:   Thu, 19 Jul 2018 16:20:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-46eabca284f9f27fe94698a068a4a21ba93b4975@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, hpa@zytor.com, dave.hansen@intel.com,
        eduval@amazon.com, aarcange@redhat.com, dhgutteridge@sympatico.ca,
        brgerst@gmail.com, jgross@suse.com, mingo@kernel.org,
        peterz@infradead.org, David.Laight@aculab.com, luto@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, jroedel@suse.de,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        tglx@linutronix.de, jkosina@suse.cz, bp@alien8.de,
        jpoimboe@redhat.com, llong@redhat.com, boris.ostrovsky@oracle.com,
        pavel@ucw.cz
Reply-To: jpoimboe@redhat.com, bp@alien8.de, llong@redhat.com,
          boris.ostrovsky@oracle.com, pavel@ucw.cz, tglx@linutronix.de,
          dvlasenk@redhat.com, jkosina@suse.cz, peterz@infradead.org,
          mingo@kernel.org, David.Laight@aculab.com, luto@kernel.org,
          jroedel@suse.de, torvalds@linux-foundation.org,
          will.deacon@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          gregkh@linuxfoundation.org, dave.hansen@intel.com,
          eduval@amazon.com, jgross@suse.com, brgerst@gmail.com,
          aarcange@redhat.com, dhgutteridge@sympatico.ca
In-Reply-To: <1531906876-13451-5-git-send-email-joro@8bytes.org>
References: <1531906876-13451-5-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Put ESPFIX code into a macro
Git-Commit-ID: 46eabca284f9f27fe94698a068a4a21ba93b4975
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

Commit-ID:  46eabca284f9f27fe94698a068a4a21ba93b4975
Gitweb:     https://git.kernel.org/tip/46eabca284f9f27fe94698a068a4a21ba93b4975
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:41 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:36 +0200

x86/entry/32: Put ESPFIX code into a macro

This makes it easier to split up the shared iret code path.

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
Link: https://lkml.kernel.org/r/1531906876-13451-5-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 97 ++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 39f711ad0fc9..ef7d65315e8e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -221,6 +221,54 @@
 	POP_GS_EX
 .endm
 
+.macro CHECK_AND_APPLY_ESPFIX
+#ifdef CONFIG_X86_ESPFIX32
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
+
+	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
+
+	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
+	/*
+	 * Warning: PT_OLDSS(%esp) contains the wrong/random values if we
+	 * are returning to the kernel.
+	 * See comments in process.c:copy_thread() for details.
+	 */
+	movb	PT_OLDSS(%esp), %ah
+	movb	PT_CS(%esp), %al
+	andl	$(X86_EFLAGS_VM | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
+	cmpl	$((SEGMENT_LDT << 8) | USER_RPL), %eax
+	jne	.Lend_\@	# returning to user-space with LDT SS
+
+	/*
+	 * Setup and switch to ESPFIX stack
+	 *
+	 * We're returning to userspace with a 16 bit stack. The CPU will not
+	 * restore the high word of ESP for us on executing iret... This is an
+	 * "official" bug of all the x86-compatible CPUs, which we can work
+	 * around to make dosemu and wine happy. We do this by preloading the
+	 * high word of ESP with the high word of the userspace ESP while
+	 * compensating for the offset by changing to the ESPFIX segment with
+	 * a base address that matches for the difference.
+	 */
+	mov	%esp, %edx			/* load kernel esp */
+	mov	PT_OLDESP(%esp), %eax		/* load userspace esp */
+	mov	%dx, %ax			/* eax: new kernel esp */
+	sub	%eax, %edx			/* offset (low word is 0) */
+	shr	$16, %edx
+	mov	%dl, GDT_ESPFIX_SS + 4		/* bits 16..23 */
+	mov	%dh, GDT_ESPFIX_SS + 7		/* bits 24..31 */
+	pushl	$__ESPFIX_SS
+	pushl	%eax				/* new kernel esp */
+	/*
+	 * Disable interrupts, but do not irqtrace this section: we
+	 * will soon execute iret and the tracer was already set to
+	 * the irqstate after the IRET:
+	 */
+	DISABLE_INTERRUPTS(CLBR_ANY)
+	lss	(%esp), %esp			/* switch to espfix segment */
+.Lend_\@:
+#endif /* CONFIG_X86_ESPFIX32 */
+.endm
 /*
  * %eax: prev task
  * %edx: next task
@@ -547,21 +595,7 @@ ENTRY(entry_INT80_32)
 restore_all:
 	TRACE_IRQS_IRET
 .Lrestore_all_notrace:
-#ifdef CONFIG_X86_ESPFIX32
-	ALTERNATIVE	"jmp .Lrestore_nocheck", "", X86_BUG_ESPFIX
-
-	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
-	/*
-	 * Warning: PT_OLDSS(%esp) contains the wrong/random values if we
-	 * are returning to the kernel.
-	 * See comments in process.c:copy_thread() for details.
-	 */
-	movb	PT_OLDSS(%esp), %ah
-	movb	PT_CS(%esp), %al
-	andl	$(X86_EFLAGS_VM | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
-	cmpl	$((SEGMENT_LDT << 8) | USER_RPL), %eax
-	je .Lldt_ss				# returning to user-space with LDT SS
-#endif
+	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
 	RESTORE_REGS 4				# skip orig_eax/error_code
 .Lirq_return:
@@ -579,39 +613,6 @@ ENTRY(iret_exc	)
 	jmp	common_exception
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
-
-#ifdef CONFIG_X86_ESPFIX32
-.Lldt_ss:
-/*
- * Setup and switch to ESPFIX stack
- *
- * We're returning to userspace with a 16 bit stack. The CPU will not
- * restore the high word of ESP for us on executing iret... This is an
- * "official" bug of all the x86-compatible CPUs, which we can work
- * around to make dosemu and wine happy. We do this by preloading the
- * high word of ESP with the high word of the userspace ESP while
- * compensating for the offset by changing to the ESPFIX segment with
- * a base address that matches for the difference.
- */
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
-	mov	%esp, %edx			/* load kernel esp */
-	mov	PT_OLDESP(%esp), %eax		/* load userspace esp */
-	mov	%dx, %ax			/* eax: new kernel esp */
-	sub	%eax, %edx			/* offset (low word is 0) */
-	shr	$16, %edx
-	mov	%dl, GDT_ESPFIX_SS + 4		/* bits 16..23 */
-	mov	%dh, GDT_ESPFIX_SS + 7		/* bits 24..31 */
-	pushl	$__ESPFIX_SS
-	pushl	%eax				/* new kernel esp */
-	/*
-	 * Disable interrupts, but do not irqtrace this section: we
-	 * will soon execute iret and the tracer was already set to
-	 * the irqstate after the IRET:
-	 */
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	lss	(%esp), %esp			/* switch to espfix segment */
-	jmp	.Lrestore_nocheck
-#endif
 ENDPROC(entry_INT80_32)
 
 .macro FIXUP_ESPFIX_STACK
