Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeBSPGV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:06:21 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:59412 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeBSPGT (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 19 Feb 2018 10:06:19 -0500
Message-Id: <5A8AF5F602000078001A9230@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 19 Feb 2018 08:06:14 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64/realmode: add instruction suffix
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream gas in the
future (mine does already). Add the single missing suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/realmode/rm/trampoline_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.16-rc2/arch/x86/realmode/rm/trampoline_64.S
+++ 4.16-rc2-x86_64-realmode-insn-suffix/arch/x86/realmode/rm/trampoline_64.S
@@ -102,7 +102,7 @@ ENTRY(startup_32)
 	 * don't we'll eventually crash trying to execute encrypted
 	 * instructions.
 	 */
-	bt	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
+	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
 	movl	$MSR_K8_SYSCFG, %ecx
 	rdmsr
