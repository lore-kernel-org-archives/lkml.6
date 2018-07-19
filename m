Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2315ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B38A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B38A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGTAKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:10:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeGTAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:10:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNO8RR2453017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:24:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNO7MI2453014;
        Thu, 19 Jul 2018 16:24:07 -0700
Date:   Thu, 19 Jul 2018 16:24:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-929b44eb5739bf11d4a9bce85d7346bd955fc24d@git.kernel.org>
Cc:     David.Laight@aculab.com, jroedel@suse.de, jpoimboe@redhat.com,
        jkosina@suse.cz, luto@kernel.org, pavel@ucw.cz, mingo@kernel.org,
        bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        boris.ostrovsky@oracle.com, brgerst@gmail.com, dvlasenk@redhat.com,
        tglx@linutronix.de, aarcange@redhat.com, eduval@amazon.com,
        peterz@infradead.org, dhgutteridge@sympatico.ca,
        gregkh@linuxfoundation.org, will.deacon@arm.com, llong@redhat.com,
        dave.hansen@intel.com, jgross@suse.com,
        torvalds@linux-foundation.org
Reply-To: eduval@amazon.com, peterz@infradead.org, aarcange@redhat.com,
          gregkh@linuxfoundation.org, will.deacon@arm.com,
          llong@redhat.com, dave.hansen@intel.com, jgross@suse.com,
          torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
          jpoimboe@redhat.com, jkosina@suse.cz, luto@kernel.org,
          David.Laight@aculab.com, jroedel@suse.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
          dvlasenk@redhat.com, brgerst@gmail.com, tglx@linutronix.de,
          mingo@kernel.org, pavel@ucw.cz, bp@alien8.de
In-Reply-To: <1531906876-13451-12-git-send-email-joro@8bytes.org>
References: <1531906876-13451-12-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Simplify debug entry point
Git-Commit-ID: 929b44eb5739bf11d4a9bce85d7346bd955fc24d
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

Commit-ID:  929b44eb5739bf11d4a9bce85d7346bd955fc24d
Gitweb:     https://git.kernel.org/tip/929b44eb5739bf11d4a9bce85d7346bd955fc24d
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:48 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:39 +0200

x86/entry/32: Simplify debug entry point

The common exception entry code now handles the entry-from-sysenter stack
situation and makes sure to leave with the same stack as it entered the
kernel.

So there is no need anymore for the special handling in the debug entry
code.

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
Link: https://lkml.kernel.org/r/1531906876-13451-12-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9d6eceba0461..dbf7d619dcd6 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1226,41 +1226,12 @@ END(common_exception)
 
 ENTRY(debug)
 	/*
-	 * #DB can happen at the first instruction of
-	 * entry_SYSENTER_32 or in Xen's SYSENTER prologue.  If this
-	 * happens, then we will be running on a very small stack.  We
-	 * need to detect this condition and switch to the thread
-	 * stack before calling any C code at all.
-	 *
-	 * If you edit this code, keep in mind that NMIs can happen in here.
+	 * Entry from sysenter is now handled in common_exception
 	 */
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
-
-	SAVE_ALL
-	ENCODE_FRAME_POINTER
-	xorl	%edx, %edx			# error code 0
-	movl	%esp, %eax			# pt_regs pointer
-
-	/* Are we currently on the SYSENTER stack? */
-	movl	PER_CPU_VAR(cpu_entry_area), %ecx
-	addl	$CPU_ENTRY_AREA_entry_stack + SIZEOF_entry_stack, %ecx
-	subl	%eax, %ecx	/* ecx = (end of entry_stack) - esp */
-	cmpl	$SIZEOF_entry_stack, %ecx
-	jb	.Ldebug_from_sysenter_stack
-
-	TRACE_IRQS_OFF
-	call	do_debug
-	jmp	ret_from_exception
-
-.Ldebug_from_sysenter_stack:
-	/* We're on the SYSENTER stack.  Switch off. */
-	movl	%esp, %ebx
-	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
-	TRACE_IRQS_OFF
-	call	do_debug
-	movl	%ebx, %esp
-	jmp	ret_from_exception
+	pushl	$do_debug
+	jmp	common_exception
 END(debug)
 
 /*
