Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633329-2-15467919481055361893
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633329; b=ocrv4MQyss9+pMsBfHyPSjijImHlSIGEzYqaYPs4c9rnI2j
    Vj35jXT0zWVK8v9bHoZ9LNJBkDAW4s2LpJiR9Jfkws/FCc3hRPJ716e4XyEIdaaK
    db2C59sJJHdhxJ5qLHlaoqLft1qvhl/dvrMMm6BFDpAaSSY42K0SKUh3xVNmH8dl
    EhRjt98CkK4V2/1i5RzZyPxkA3L627Ft6YrvKPm9FDSAm1vOGewBjEPWFCaEc6ey
    MOVkJ1Eonl07xd+psJX11Sk5k47MdrdOuaY96VYITsVX4pWKyxL2ey3vQMa3jyWl
    sCEBzq8XwM6N+461RqTLKMZzGquXPUtonaJ3Jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633329;
    bh=1Y8BanaJo1dWq0GIhEtFd/7ONzz9WFIJLPbGyXUfe10=; b=Pj42j+d5ideB
    TKup2zWguYAiUFVxU3fEGs6ILrjmJlvekQigbH2KVQI2bGnN0T/qWNOnN4SV1bAz
    DpQqKRAR/4zKjAucb1VP9xB/oQoAHmEOEVugmLbPhOpeFPMbuF7RWmbG/4Nr/Ymf
    95unKXfoYT9/cLmhtrXaaRewiOyxM2wRzw8oOLBEEAuNkAGMmw/pcIIV4vDowuZr
    qlFxZwduAoxPFth/pZhEbbFhR8GwEjv9j5BV6zwPHMfVmtPVSjyEP65sk/2hJiwV
    Ut6Wy/a3VqH5l0ixvo09fi393VcB/jUaxQMSB3GeJiu5sHtcQwp3VN6C5P510U4n
    kh69EYUOeA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=d1w8YmAm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yapdj4R5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=d1w8YmAm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yapdj4R5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeBZIWG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:22:06 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46754 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752354AbeBZIV7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:21:59 -0500
X-Google-Smtp-Source: AH8x227f4Hawo51XZ+vo1Kl/+tJlOz3vC3XcLHXJmcOrgK3H7OGj5ajydxmKlCqqDgShE9SkvNC5bQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Cc: James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/52] arm64: Factor out TTBR0_EL1 post-update workaround into a specific asm macro
Date: Mon, 26 Feb 2018 16:19:41 +0800
Message-Id: <1519633227-29832-8-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Catalin Marinas <catalin.marinas@arm.com>

commit f33bcf03e6 upstream

This patch takes the errata workaround code out of cpu_do_switch_mm into
a dedicated post_ttbr0_update_workaround macro which will be reused in a
subsequent patch.

Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 13 +++++++++++++
 arch/arm64/mm/proc.S               |  6 +-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 8760300..ab3a179 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -420,4 +420,17 @@ alternative_endif
 	movk	\reg, :abs_g0_nc:\val
 	.endm
 
+/*
+ * Errata workaround post TTBR0_EL1 update.
+ */
+	.macro	post_ttbr0_update_workaround
+#ifdef CONFIG_CAVIUM_ERRATUM_27456
+alternative_if ARM64_WORKAROUND_CAVIUM_27456
+	ic	iallu
+	dsb	nsh
+	isb
+alternative_else_nop_endif
+#endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..c2adb0c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -136,11 +136,7 @@ ENTRY(cpu_do_switch_mm)
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
-alternative_if ARM64_WORKAROUND_CAVIUM_27456
-	ic	iallu
-	dsb	nsh
-	isb
-alternative_else_nop_endif
+	post_ttbr0_update_workaround
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-- 
2.7.4
