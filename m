Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeBZLL2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:11:28 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:41400 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeBZLLY (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 26 Feb 2018 06:11:24 -0500
Message-Id: <5A93F96902000078001ABAC8@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 26 Feb 2018 04:11:21 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64/entry: add instruction suffix
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
 arch/x86/entry/entry_64.S     |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.16-rc3/arch/x86/entry/entry_64.S
+++ 4.16-rc3-x86-insn-suffixes/arch/x86/entry/entry_64.S
@@ -55,7 +55,7 @@ END(native_usergs_sysret64)
 
 .macro TRACE_IRQS_FLAGS flags:req
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bt	$9, \flags		/* interrupts off? */
+	btl	$9, \flags		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON
 1:
