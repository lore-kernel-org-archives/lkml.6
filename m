Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790624-2-938785087928675721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790623; b=lmVG33QNDE+ciQPO8LAa5LzznN50MheKbk1ptL1Poebl0hB
    YS/GyXzixe5IdNn0DySQhVHShi2cVr8OXvp66LO6JnoFhiaZ0LEOAeO9ai6Y7KBz
    8LkXlSHY4m9tMFQvMg1r8cK/QqNw239M6mVh+Uz1GL5yB8TZABmOUH7WlLrMbbLl
    kxR5pxPvCxypbsS1uvzBuGyWJICkjQPiy8jzSIFOr2WQ7U2JD4ZvkrSSfJx7M62K
    jPY6TWuIZ5x/zliz5/LcWg5PTbq7xW87yxe9S3OFWalyNFfTWw1MFuF/hJC45eH5
    bKQ1NpICktq0Ne0EosV9OHwvWZirJMHvtng535A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790623;
    bh=3EefTrlVGpCtN2KCozRnf/Q739j84WLPOQ3GnGLPWwc=; b=T45TlXzxzcc+
    oXLITwxevTje7eglHipDSnWEuARd/dXuC7PPkmJNIgC3NzW/l1d/m0AV8MXqhn3D
    XqycAHi1+LV2ZTh3tWy4H/1mGnNwxwZ5VdT06rbch5+KOddPJeYli74ndGIwMYAn
    NrBph/1QDUJivIP4qpl5ec4cNLhzIOJZclfTh7q+cKCI0Ux6UNv4/BPcuzaWI4VX
    8SP2zdfC4toTtLNJhb31Le7gFIfkPi6/dPiBushweX54u4Piy9GrK92X6wwxSKwm
    5HndANqADvPcmxrsZJ29Qdjk2GtfMPCrNu0mSB7hq+/D11v/4zDfrctx4cyZinIr
    TCxfui9fVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=I5i7fWK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bQK7K41W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=I5i7fWK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bQK7K41W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeB1D7E (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:04 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37162 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeB1D7C (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:02 -0500
X-Google-Smtp-Source: AG47ELvLCJAXe4ltlS2QX/wSfaM8zGnK8Ma3IjTADbId4S/uiOQHVMd0p1Hb7Jah7W1/7shfiJlEgw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 12/29] arm64: entry: Hook up entry trampoline to exception vectors
Date: Wed, 28 Feb 2018 11:56:34 +0800
Message-Id: <1519790211-16582-13-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 4bf3286d29f3 upstream.

Hook up the entry trampoline to our exception vectors so that all
exceptions from and returns to EL0 go via the trampoline, which swizzles
the vector base register accordingly. Transitioning to and from the
kernel clobbers x30, so we use tpidrro_el0 and far_el1 as scratch
registers for native tasks.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/entry.S | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7b1be51..eccb6d8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -72,10 +72,26 @@
 
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	.if	\el == 0
+	.if	\regsize == 64
+	mrs	x30, tpidrro_el0
+	msr	tpidrro_el0, xzr
+	.else
+	mov	x30, xzr
+	.endif
+	.endif
+#endif
+
 	sub	sp, sp, #S_FRAME_SIZE
 	b	el\()\el\()_\label
 	.endm
 
+	.macro tramp_alias, dst, sym
+	mov_q	\dst, TRAMP_VALIAS
+	add	\dst, \dst, #(\sym - .entry.tramp.text)
+	.endm
+
 	.macro	kernel_entry, el, regsize = 64
 	.if	\regsize == 32
 	mov	w0, w0				// zero upper 32 bits of x0
@@ -157,18 +173,20 @@
 	ct_user_enter
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
+	tst	x22, #PSR_MODE32_BIT		// native task?
+	b.eq	3f
+
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
-	tbz	x22, #4, 1f
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 	mrs	x29, contextidr_el1
 	msr	contextidr_el1, x29
 #else
 	msr contextidr_el1, xzr
 #endif
-1:
 alternative_else_nop_endif
 #endif
+3:
 	.endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
@@ -189,7 +207,22 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
-	eret					// return to kernel
+
+#ifndef CONFIG_UNMAP_KERNEL_AT_EL0
+	eret
+#else
+	.if	\el == 0
+	bne	4f
+	msr	far_el1, x30
+	tramp_alias	x30, tramp_exit_native
+	br	x30
+4:
+	tramp_alias	x30, tramp_exit_compat
+	br	x30
+	.else
+	eret
+	.endif
+#endif
 	.endm
 
 	.macro	get_thread_info, rd
-- 
2.7.4
