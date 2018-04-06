Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021699-2-2744767225967081370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021699; b=XnvCZKy6VVUyzBofNdFvCgTqxgv0w8yOPUnLkVKIe/x15kYF2+
    JqV2Bc+OVBqopvEGL7hpDV+KiNvIibuf4nNrZPkzYReorGvCozGDOu/xGU0zem90
    7kluvJriJSK0b7UbNtOw1F0tfcVKAjyVNpmQoCL845ft0GejJnWwCGg7SQY/8KiA
    REHSx5QoUowG+PgSJIOxoM+GpHJj/XbGrayOfg8ZhwqAJi1mQSc2xdevmV0mziZM
    qTuTaD5oCZl4nEtwjNChRh+7ArA5F/QQEhOqT4w8MllhsJMcPmG51mZgGx89jNam
    +jrpfrK9PhXCcjPgMzL3Y+jeMMUyx9H+S/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021699; bh=h4x0jl+KW5fV+pSvcD3AZ0eFghVJL4
    f52rKjljU3q/w=; b=PcjPAYS0Y5f4OrhfjPXm/d6lMhWcg/Rwprg4u9bsNnhzLW
    znQ0B1samV83h4HBLrupIy3R6wynyy4E0vYPQ5AsUAFRP0lscDD29OtJBfUOxgLG
    vvl86ZJu6OXhrFZ6xFJSIRLZrsE4vSppnLGI1Gdp2QC/ALQfpXA/O0LeFTfVAmbs
    2i3YcO373c5Qq/vwRmUA96mD3lEIh6NiU+r81J7FXhmTNXy+mZSEFy2vnXCxk3vx
    I54Iw1k2GqarUAdu7PtexPySDHqID/bvk0JO25SvRgOKuj16ZH6KSAb35BJX/1vX
    GHtZpYaozOyOS2S111d2NJHyK0cgPuIZMU9LJn6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3nZxtnYMtJ9UZpaB2OUlwTytj06A1Gj2iIDMFjhJAxrP6ihZZUENtwVuo0JEYC4YlHWBcGY/18TxR6EV7T5HpbHyk7Qw526f1XUyaxYIYdzkN4IVYt
    GKqEL1j9xMJ7jT+LSV/Uewj4z/bCk4ILl0qUrUPbtG+81SXj2xmI3MLMfq7KNLffI2UG24SKkkMdQhBzyssPh0mok5nN+wWm1eCh7I2Ads4+2uUd9sxPWc/Q
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
    a=ag1SF4gXAAAA:8 a=Yb0x02fTALkCl_x14e4A:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755925AbeDFNey (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:34:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeDFNeu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:34:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 055/102] arm64: factor out entry stack manipulation
Date: Fri,  6 Apr 2018 15:23:36 +0200
Message-Id: <20180406084339.366053303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   51 +++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

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
-
-	ventry	el1_sync			// Synchronous EL1h
-	ventry	el1_irq				// IRQ EL1h
-	ventry	el1_fiq_invalid			// FIQ EL1h
-	ventry	el1_error_invalid		// Error EL1h
-
-	ventry	el0_sync			// Synchronous 64-bit EL0
-	ventry	el0_irq				// IRQ 64-bit EL0
-	ventry	el0_fiq_invalid			// FIQ 64-bit EL0
-	ventry	el0_error_invalid		// Error 64-bit EL0
+	kernel_ventry	el1_sync_invalid		// Synchronous EL1t
+	kernel_ventry	el1_irq_invalid			// IRQ EL1t
+	kernel_ventry	el1_fiq_invalid			// FIQ EL1t
+	kernel_ventry	el1_error_invalid		// Error EL1t
+
+	kernel_ventry	el1_sync			// Synchronous EL1h
+	kernel_ventry	el1_irq				// IRQ EL1h
+	kernel_ventry	el1_fiq_invalid			// FIQ EL1h
+	kernel_ventry	el1_error_invalid		// Error EL1h
+
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
 
