Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790674-2-17078233500551254341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790673; b=lncdWKwsSlq1TZJlEPhuLs5PmPflN0yAPkcwGF9oRZ/T1rQ
    Gr09vZpRMJBtgCKYfzLPNruk46sQ0coxqLrPtUuDMtsl36JUTYFxgdzqqvjFsHFg
    PkuwHtBrlPQp7vch0m/6wiKxQ7k37Df8y9R3+69rryT/1GDucB+8VS+vxCjA9yHE
    P/ghZ8uFOBLQhMis2yFgrJ0nOa6YKDgGpMh1PBLaSz09D42Z0yoq/YA+n+af1kMz
    OZQcbLuGwNJQDIflxbLVBEM3Pj2J+WpNuMOKZmYjMYEppktdCawLDeTBXKk5EekQ
    00o7/r+CKtCQ6qn7qw0bJ+jtjS8KjSqfo8XFbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790673;
    bh=BbrhBHDEMFhCrPIdPhoFv8B5sSWqD0P7v6bm6++E2JU=; b=lsTd7KlRy+HU
    HoE0ToFxZKHdQ6YMOGNyNFKgY2YUJgKmzUwlSYoCCJkj10t8+qBT1Faa6ZaouXKk
    r9qSUw53n/zfM6VbbG2b3c31R7NiY6FT2nUr1RCe7hSPyyF7MPRahQ7UEi9RrIYg
    /qO6O9trk6Vhydnwoxx69DaEZHr1S1tflGVwSuSzR2nCbpo3gXCCowoZegHd41F5
    OiL+3MFQ8bfhOniJTdERMFmDFyFuaJsktlnRs8vNgEBoLPkw8bRaUt2BV7He70g6
    jqAQVsw7mSheSvg3v/Ijof1ZfDVW2yVy3NN7FZ5J5/y8E8Z6VxtkzI3wDl5Kmy18
    gze7yFzCzg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=d6218NBb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DGvfTV26;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=d6218NBb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DGvfTV26;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeB1D6R (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39205 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeB1D6P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:15 -0500
X-Google-Smtp-Source: AG47ELuR5P4fjDeodL4dKA+aJlaN8ja5A2IVtx7/5/ksdEAqBkM4egMxgtMORREiJ3ehCn3gOyIRoQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 06/29] arm64: factor out entry stack manipulation
Date: Wed, 28 Feb 2018 11:56:28 +0800
Message-Id: <1519790211-16582-7-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mark Rutland <mark.rutland@arm.com>

commit b11e5759bfac upstream.

In subsequent patches, we will detect stack overflow in our exception
entry code, by verifying the SP after it has been decremented to make
space for the exception regs.

This verification code is small, and we can minimize its impact by
placing it directly in the vectors. To avoid redundant modification of
the SP, we also need to move the initial decrement of the SP into the
vectors.

As a preparatory step, this patch introduces kernel_ventry, which
performs this decrement, and updates the entry code accordingly.
Subsequent patches will fold SP verification into kernel_ventry.

There should be no functional change as a result of this patch.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Mark: turn into prep patch, expand commit msg]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b4c7db4..f5aa8f0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -68,8 +68,13 @@
 #define BAD_FIQ		2
 #define BAD_ERROR	3
 
-	.macro	kernel_entry, el, regsize = 64
+	.macro kernel_ventry	label
+	.align 7
 	sub	sp, sp, #S_FRAME_SIZE
+	b	\label
+	.endm
+
+	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
 	.endif
@@ -257,31 +262,31 @@ tsk	.req	x28		// current thread_info
 
 	.align	11
 ENTRY(vectors)
-	ventry	el1_sync_invalid		// Synchronous EL1t
-	ventry	el1_irq_invalid			// IRQ EL1t
-	ventry	el1_fiq_invalid			// FIQ EL1t
-	ventry	el1_error_invalid		// Error EL1t
+	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
+	kernel_ventry	el1_irq_invalid			// IRQ EL1t
+	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
+	kernel_ventry	el1_error_invalid		// Error EL1t
 
-	ventry	el1_sync			// Synchronous EL1h
-	ventry	el1_irq				// IRQ EL1h
-	ventry	el1_fiq_invalid			// FIQ EL1h
-	ventry	el1_error_invalid		// Error EL1h
+	kernel_ventry	el1_sync			// Synchronous EL1h
+	kernel_ventry	el1_irq				// IRQ EL1h
+	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
+	kernel_ventry	el1_error_invalid		// Error EL1h
 
-	ventry	el0_sync			// Synchronous 64-bit EL0
-	ventry	el0_irq				// IRQ 64-bit EL0
-	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	el0_sync			// Synchronous 64-bit EL0
+	kernel_ventry	el0_irq				// IRQ 64-bit EL0
+	kernel_ventry	el0_fiq_invalid			// FIQ 64-bit EL0
+	kernel_ventry	el0_error_invalid		// Error 64-bit EL0
 
 #ifdef CONFIG_COMPAT
-	ventry	el0_sync_compat			// Synchronous 32-bit EL0
-	ventry	el0_irq_compat			// IRQ 32-bit EL0
-	ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
-	ventry	el0_error_invalid_compat	// Error 32-bit EL0
+	kernel_ventry	el0_sync_compat			// Synchronous 32-bit EL0
+	kernel_ventry	el0_irq_compat			// IRQ 32-bit EL0
+	kernel_ventry	el0_fiq_invalid_compat		// FIQ 32-bit EL0
+	kernel_ventry	el0_error_invalid_compat	// Error 32-bit EL0
 #else
-	ventry	el0_sync_invalid		// Synchronous 32-bit EL0
-	ventry	el0_irq_invalid			// IRQ 32-bit EL0
-	ventry	el0_fiq_invalid			// FIQ 32-bit EL0
-	ventry	el0_error_invalid		// Error 32-bit EL0
+	kernel_ventry	el0_sync_invalid		// Synchronous 32-bit EL0
+	kernel_ventry	el0_irq_invalid			// IRQ 32-bit EL0
+	kernel_ventry	el0_fiq_invalid			// FIQ 32-bit EL0
+	kernel_ventry	el0_error_invalid		// Error 32-bit EL0
 #endif
 END(vectors)
 
-- 
2.7.4
