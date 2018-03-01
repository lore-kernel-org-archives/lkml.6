Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909342-2-12650158750499098508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909341; b=pUWp4uJqXyCShJDsOLZeXIrY4a4EfcYlrNjppAXJ4JC/UjN
    E7D2UEqFKdR4SkWgDfT23oVX6mJlO5515j75Hd7bGyK+Y6HDHuXXGiADn/HUCRVw
    iYIk3BVsHv9enSy1sG9FJc+KS2ngFj5tcor/O8/DGpyt8GCxRxlKX2XePMC1uvzD
    nyUI7FemQXDhxrhDgskgA3AVzF3oqtOpHKa6KT4NoTIoFqjOj/anw+7d2S+NS109
    DycqV1FhsYgaZ7UZrqollZYzVf6F9QYHbxPsdpZO/7+GG0P7a/Uu2ud3GNB1ascI
    CZ/GJO7w0lJlxUrqvigV1DHblfeG53vUrsU0dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909341;
    bh=Jl8J60UuHWw6QycIueIONGAI64GFje0f/SkXAPYopdo=; b=KSVf5oeg7256
    8Hjlg14V6zX1TPRcNtgKhol/3JuTvtUKzG4pioSF5y9Qu2zvyX948EOU+cK5ymeS
    h4b3VdtJYabMLB5m+dzCEOgzNOwULz9XV1Hu4V++cfbcNLMLUEqztSLQBwxHQ4wa
    EZ6M9bhTrnlIK54WMFkRKVQ9oYFk6A18hgYVaZdDWzvOAy2h1CzKQKYr1nqOsQdZ
    S2WRxgG9fzSGrlc88gnEICwfsYbmzaItPH5dyiFbI0DDpn36gkfpYrEEloyPLP0S
    HT/HM9QrhlYchJOWqTpODC6yWWvW7oZOXq12yjgogG2tMhAn7GR5JVfOcBdMX3gi
    ufHv9B4+ng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gD/uH45g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CX5leYoB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gD/uH45g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CX5leYoB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031125AbeCANAi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:00:38 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33877 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030872AbeCANAf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:00:35 -0500
X-Google-Smtp-Source: AG47ELtS8FjouI8EH3/kb1o1Sfvd/osyFgXqGmtvWQKB5ZGqm4bL0ym578GrYRSG054K81mIMEljFw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 39/45] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date: Thu,  1 Mar 2018 20:54:16 +0800
Message-Id: <1519908862-11425-40-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit f72af90c3783 upstream.

We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
So let's intercept it as early as we can by testing for the
function call number as soon as we've identified a HVC call
coming from the guest.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kvm/hyp/hyp-entry.S | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 4e92399..4e9d50c 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 
 #include <asm/alternative.h>
@@ -79,10 +80,11 @@ alternative_endif
 	lsr	x0, x1, #ESR_ELx_EC_SHIFT
 
 	cmp	x0, #ESR_ELx_EC_HVC64
+	ccmp	x0, #ESR_ELx_EC_HVC32, #4, ne
 	b.ne	el1_trap
 
-	mrs	x1, vttbr_el2		// If vttbr is valid, the 64bit guest
-	cbnz	x1, el1_trap		// called HVC
+	mrs	x1, vttbr_el2		// If vttbr is valid, the guest
+	cbnz	x1, el1_hvc_guest	// called HVC
 
 	/* Here, we're pretty sure the host called HVC. */
 	ldp	x0, x1, [sp], #16
@@ -101,6 +103,20 @@ alternative_endif
 
 2:	eret
 
+el1_hvc_guest:
+	/*
+	 * Fastest possible path for ARM_SMCCC_ARCH_WORKAROUND_1.
+	 * The workaround has already been applied on the host,
+	 * so let's quickly get back to the guest. We don't bother
+	 * restoring x1, as it can be clobbered anyway.
+	 */
+	ldr	x1, [sp]				// Guest's x0
+	eor	w1, w1, #ARM_SMCCC_ARCH_WORKAROUND_1
+	cbnz	w1, el1_trap
+	mov	x0, x1
+	add	sp, sp, #16
+	eret
+
 el1_trap:
 	/*
 	 * x0: ESR_EC
-- 
2.7.4
