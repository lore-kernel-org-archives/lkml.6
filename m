Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeBKKuu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:50:50 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39508 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeBKKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:50:47 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
Cc: dan.j.williams@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, luto@kernel.org
Subject: [PATCH v3 7/7] x86/entry: indent PUSH_AND_CLEAR_REGS and POP_REGS properly
Date: Sun, 11 Feb 2018 11:49:48 +0100
Message-Id: <20180211104949.12992-8-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180211104949.12992-1-linux@dominikbrodowski.net>
References: <20180211104949.12992-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... same as the other macros in arch/x86/entry/calling.h

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/calling.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 59675010c9a0..6985440c68fa 100644
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
-- 
2.16.1
