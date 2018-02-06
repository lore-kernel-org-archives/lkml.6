Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-991961-1517918764-2-16017382361567868147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517918764; b=h7qiAHg9zKmKyqhWcTGbCY3bfJ30kCIydGvpeNiQbccC543
    3MLXVKCHeJ7tGV2nutQXMPiZrE5oyp9O5tnCPPMIjq11H1frgv6hAH+JcPF2aNsv
    21CeccSSbvikRrfowpJxZTf79Y5vuQA+zpkw1XtKP8Fpfv2Z2k+V9Xd9d3mZeW4H
    YZhVwhImnuFJF+7KipFrTWWIo+QozWdEgqwnYE0SOONeyJVTt81HYrB6doDIaB9l
    j9sp/wL1qABFWeaM81pXql0ehVX4GFaf6TbrPHwtVSXicYfpZNt0cub86MJGsRmE
    PkZtHaDxCVqMByDT3kzPj/MnZP8DUBrKvq/OG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=
    arctest; t=1517918764; bh=Wasfs2ETUShvj6UCDjqp9X0RD9O75cug17v1If
    VUZRY=; b=IgV3IFFjcho0AF8PSfUI2tsGxfv9S9zx0JXFnrbF/X8o6LiuCDbYro
    dYgdS1KEscwfylpRgI+nCe+H8BMSg+w7M1ZwwX8Mk2+xLvZJMyL+yvn0p+59x0DX
    AuIsuuCqHLRDaUKgykuEjZcaTFKnr0ODcHmFREcwZveXPiDzxkam2BPtuYgRT6Kp
    Rw89VTHpSHI+0K0PtydT04D0VoiHXXcnq3lzDLSugyesL3NYZIcuA1cPoIbuP+AF
    m6zemjvxslayNf9Z/LMSr9BCYfJFN8ppZok3xisN6UDCeRfyGYeowcBGzPXo23fW
    MKhdvPJmxETi/Xu+lI+H+WgXzl0zaVpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeBFMGB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 07:06:01 -0500
Received: from terminus.zytor.com ([65.50.211.136]:49769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeBFMF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 07:05:58 -0500
Date: Tue, 6 Feb 2018 04:00:07 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-3ac6d8c787b835b997eb23e43e09aa0895ef7d58@git.kernel.org>
Cc: torvalds@linux-foundation.org, bp@alien8.de, brgerst@gmail.com,
        stable@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
        mingo@kernel.org, dvlasenk@redhat.com, peterz@infradead.org,
        luto@kernel.org, tglx@linutronix.de
Reply-To: bp@alien8.de, torvalds@linux-foundation.org, brgerst@gmail.com,
          stable@vger.kernel.org, dan.j.williams@intel.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
          mingo@kernel.org, dvlasenk@redhat.com, peterz@infradead.org,
          luto@kernel.org, tglx@linutronix.de
In-Reply-To: <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Clear registers for
 exceptions/interrupts, to reduce speculation attack surface
Git-Commit-ID: 3ac6d8c787b835b997eb23e43e09aa0895ef7d58
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  3ac6d8c787b835b997eb23e43e09aa0895ef7d58
Gitweb:     https://git.kernel.org/tip/3ac6d8c787b835b997eb23e43e09aa0895ef7d58
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 5 Feb 2018 17:18:11 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 11:47:44 +0100

x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface

Clear the 'extra' registers on entering the 64-bit kernel for exceptions
and interrupts. The common registers are not cleared since they are
likely clobbered well before they can be exploited in a speculative
execution attack.

Originally-From: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151787989146.7847.15749181712358213254.stgit@dwillia2-desk3.amr.corp.intel.com
[ Made small improvements to the changelog and the code comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h  | 19 +++++++++++++++++++
 arch/x86/entry/entry_64.S |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 3f48f69..f4b129d 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -147,6 +147,25 @@ For 32-bit we have the following conventions - kernel is built with
 	UNWIND_HINT_REGS offset=\offset
 	.endm
 
+	/*
+	 * Sanitize registers of values that a speculation attack
+	 * might otherwise want to exploit. The lower registers are
+	 * likely clobbered well before they could be put to use in
+	 * a speculative execution gadget:
+	 */
+	.macro CLEAR_REGS_NOSPEC
+	xorl %ebp, %ebp
+	xorl %ebx, %ebx
+	xorq %r8, %r8
+	xorq %r9, %r9
+	xorq %r10, %r10
+	xorq %r11, %r11
+	xorq %r12, %r12
+	xorq %r13, %r13
+	xorq %r14, %r14
+	xorq %r15, %r15
+	.endm
+
 	.macro POP_EXTRA_REGS
 	popq %r15
 	popq %r14
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 065a71b..9e48002 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,6 +575,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
@@ -1133,6 +1134,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
@@ -1178,6 +1180,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
@@ -1230,8 +1233,8 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER 8
-	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1428,6 +1431,7 @@ ENTRY(nmi)
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
+	CLEAR_REGS_NOSPEC
 	ENCODE_FRAME_POINTER
 
 	/*
