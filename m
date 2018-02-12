Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933874AbeBLKUg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:20:36 -0500
Received: from [198.137.202.136] ([198.137.202.136]:33217 "EHLO
        terminus.zytor.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932868AbeBLKUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:20:35 -0500
Date: Mon, 12 Feb 2018 02:18:55 -0800
From: tip-bot for Dominik Brodowski <tipbot@zytor.com>
Message-ID: <tip-5a10e729bc0aa9420a23a70b169eadd229c27bc1@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dvlasenk@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, jpoimboe@redhat.com, hpa@zytor.com,
        brgerst@gmail.com, linux@dominikbrodowski.net, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de
Reply-To: dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, luto@kernel.org, jpoimboe@redhat.com,
        hpa@zytor.com, brgerst@gmail.com, linux@dominikbrodowski.net,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bp@alien8.de
In-Reply-To: <20180211104949.12992-8-linux@dominikbrodowski.net>
References: <20180211104949.12992-8-linux@dominikbrodowski.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS
 properly
Git-Commit-ID: 5a10e729bc0aa9420a23a70b169eadd229c27bc1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5a10e729bc0aa9420a23a70b169eadd229c27bc1
Gitweb:     https://git.kernel.org/tip/5a10e729bc0aa9420a23a70b169eadd229c27bc1
Author:     Dominik Brodowski <linux@dominikbrodowski.net>
AuthorDate: Sun, 11 Feb 2018 11:49:48 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Feb 2018 08:06:37 +0100

x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly

... same as the other macros in arch/x86/entry/calling.h

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-8-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/calling.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 5967501..6985440 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -131,9 +131,9 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
-	.endm
+.endm
 
-	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
@@ -163,7 +163,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 	.macro icebp
 	.byte 0xf1
-	.endm
+.endm
 
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
