Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790340-2-7161099603484247276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790340; b=BqgvNUKXGQtkC4LCbbpFTLdsGs3mLyfXAAh2W9XX6yyhy+l
    ipTT3HTltDe/JJqIV3P4mS2GAvOFh7D3WONvlMu2Z0ER/HM9oZiFjpdZ/E02wYWX
    luOARbvrG6tNOspxpO7b/hKyOYO4QKRrXeosS0v0SMDfa8s8Ji2aQsPZarZJMjzw
    isF7Y6Y4mp/PWvq/D83+FLKRv4xl1XCAnTUGa+SCcIMxZMQRG1GAmgcip2e77oJN
    FIR5LKDmfAKCwIPE3eisdQAca8Ugxf27Vs7uU4PJ8Upqc8M0wOh7SpAkWv4yGpET
    hWOxeehasACjTNJuDdLBGM7PN5no7q8zq9G1Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790340;
    bh=GyALvW8YeD+0MJZ/yzzKdZ537ez2Q1z5R4zg8/QPH8A=; b=WPJgWeolQ+5/
    /MExY6WqJXWtby24nsX0xdaOIVwipMrxWryVTBRRFcwVxoln+pcfiC7zNOtWRJ43
    CMuR1o9mrDKLufRyEZJmlcvzTCp7WL0mewQrDSY5ADzqa4A82oFH1MVe6mwG9O0P
    /VCxX6ZNld8pbnA7s5AK0oIdqHd5uUkeU26lRZ4Ckh0GGwGE+9owQHaLCmwSaK/C
    T2slJUor0FN0l6A1CAqsLM/BOlYjH0KO+9AaLW4eK5JEJIAm6dKzmq73J5QRqeQo
    Z7V8BEjPKekII2TQDrAYoVHSQ3mYC5LHYIv2GZA+cB9hoXybmQDiQvfIV53EvNcr
    2+i7vnRsfA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DdvPmhiC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPk4YmWz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DdvPmhiC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPk4YmWz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeB1D64 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:56 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40598 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbeB1D6z (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:55 -0500
X-Google-Smtp-Source: AH8x226G4tHD/kAA0X1641MuVoz7Nn7dz5UI4/0Gvyj/nIz3MPPrqBXfxQbVdIOVXLP6Dp+4oHVlTg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 11/29] arm64: entry: Explicitly pass exception level to kernel_ventry macro
Date: Wed, 28 Feb 2018 11:56:33 +0800
Message-Id: <1519790211-16582-12-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 5b1f7fe41909 upstream.

We will need to treat exceptions from EL0 differently in kernel_ventry,
so rework the macro to take the exception level as an argument and
construct the branch target using that.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no vmap_stack in arch/arm64/kernel/entry.S
---
 arch/arm64/kernel/entry.S | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f0c6b37..7b1be51 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -70,10 +70,10 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro kernel_ventry	label
+	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
-	b	\label
+	b	el\()\el\()_\label
 	.endm
 
 	.macro	kernel_entry, el, regsize = 64
@@ -264,31 +264,31 @@ tsk	.req	x28		// current thread_info
 
 	.align	11
 ENTRY(vectors)
-	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
-	kernel_ventry	el1_irq_invalid			// IRQ EL1t
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
-	kernel_ventry	el1_error_invalid		// Error EL1t
+	kernel_ventry	1, sync_invalid			// Synchronous EL1t
+	kernel_ventry	1, irq_invalid			// IRQ EL1t
+	kernel_ventry	1, fiq_invalid			// FIQ EL1t
+	kernel_ventry	1, error_invalid		// Error EL1t
 
-	kernel_ventry	el1_sync			// Synchronous EL1h
-	kernel_ventry	el1_irq				// IRQ EL1h
-	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
-	kernel_ventry	el1_error			// Error EL1h
+	kernel_ventry	1, sync				// Synchronous EL1h
+	kernel_ventry	1, irq				// IRQ EL1h
+	kernel_ventry	1, fiq_invalid			// FIQ EL1h
+	kernel_ventry	1, error			// Error EL1h
 
-	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
-	kernel_ventry	el0_irq				// IRQ 64-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	kernel_ventry	el0_error			// Error 64-bit EL0
+	kernel_ventry	0, sync				// Synchronous 64-bit EL0
+	kernel_ventry	0, irq				// IRQ 64-bit EL0
+	kernel_ventry	0, fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	0, error			// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
-	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	kernel_ventry	el0_error_compat		// Error 32-bit EL0
+	kernel_ventry	0, sync_compat, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_compat, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid_compat, 32	// FIQ 32-bit EL0
+	kernel_ventry	0, error_compat, 32		// Error 32-bit EL0
 #else
-	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
-	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
-	kernel_ventry	el0_fiq_invalid			// FIQ 32-bit EL0
-	kernel_ventry	el0_error_invalid		// Error 32-bit EL0
+	kernel_ventry	0, sync_invalid, 32		// Synchronous 32-bit EL0
+	kernel_ventry	0, irq_invalid, 32		// IRQ 32-bit EL0
+	kernel_ventry	0, fiq_invalid, 32		// FIQ 32-bit EL0
+	kernel_ventry	0, error_invalid, 32		// Error 32-bit EL0
 #endif
 END(vectors)
 
-- 
2.7.4
