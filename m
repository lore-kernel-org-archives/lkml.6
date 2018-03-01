Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909657-2-7574210879818187497
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
    t=1519909656; b=ey5TXpMt6JLFhBJmX2wclMqtA6mhRBf4wp8GKfAwwXHiYHE
    Yd+YNU34t1U7MH2Rzjh6C46+xP+7vPmqrAHUh8gbzvw9Lz7ekLabnueb3OVJfFzZ
    E3APgmpeyXWNwFBEvwN6p0hhf5c/JoIICFRJjvUE4oimYJ+ey0Up0wYo0VY/AmrF
    GWFzwty4MrovxlTKRih3t5hpPJpww3uR//lcXBoZ9O60Iq1hU59shqoZmMCxukZU
    +yfa2Aw5OwCe3FqggrHPyBW90aTfBKqP17LtXCf4Y9H6d11fXRmwNKmLRFNeIm3u
    Yc0Vq8vahy0+OGpJOpFv/MlA8wFxr1PoJOv3vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909656;
    bh=1Y8BanaJo1dWq0GIhEtFd/7ONzz9WFIJLPbGyXUfe10=; b=DQub+NPuxOlo
    WcgtwTba5ouNwAwL3ErtyI2OpRJOyMroq7/wF4dFIbFsbbVQ7yEvfI7w0mjjlr9v
    emzLgkaBpeSfKtXJKItbGpaR3DZ720Cu4J5nVtzlR1AFgN1CwgWpm2xzbL8NBR4w
    OALHTg1T7N+4Shn5EmCf6ZYLHpR4ZpKPTnRP7s7rVx0yz8JcEc1oX/2Qzzaic0AY
    jVT2sn06CckJZFLIbphpAJPoKbILOFk0geh62fB13QdvnSjkbbW8wZwbeldc9kv4
    DMwwextyH3zuVMF1zUGn9u7ZfbbuVHpzlPXbSCvjRBatPacOra4j4b0nz0s5HG73
    knlPmY0b/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=iJNPwsm5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uO91VVQW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=iJNPwsm5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uO91VVQW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030682AbeCAM4J (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:09 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42909 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030665AbeCAM4G (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:56:06 -0500
X-Google-Smtp-Source: AG47ELtpnk8hGxP/r+HQz2e2EjehCzRyzTu8UM/97+Ty8p0xlcfIy22al/Dld5PxSSGWEJZIOreyhA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 07/45] arm64: Factor out TTBR0_EL1 post-update workaround into a specific asm macro
Date: Thu,  1 Mar 2018 20:53:44 +0800
Message-Id: <1519908862-11425-8-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
