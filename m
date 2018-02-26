Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633827-2-4290839628356868269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633826; b=YXpymaBI1hgq3Vo3vLUX1yUP2Yq1eZzTJImLbPmeMkJl9MP
    9od1F8Ld55kTkd8SHC22xmilfLt/7MI+Fuia4zvKLINXGIvZ+m8eitJlu24qa/ZE
    Aro1KtjidxPpFHa6maEQzMXrUjrpiewda06JrNC/ZNp1GFQfLYsZoKBexFXaGY4I
    VfrBBL9xcBVUa6F6pVAYoLkz/qeQMWiMK4VseXUbsZZyJymVk4WCtPQm8mBL3HpR
    KV7j8fDNl1BVvdWApSMtnhtlxpm/4IfcVA/HJW8ScY/GDuoy2ejDS89qmqfR5nsR
    cGzt3SZo8crcIWZes4etxmZcrQ64AwXAzGrKahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633826;
    bh=Jl8J60UuHWw6QycIueIONGAI64GFje0f/SkXAPYopdo=; b=WfmjwqTsXG7H
    VrA/R4GYWO1JGGJgM+XWyw+yUr/k+JzkwKfGxZfQf+AX5gmW9fQ5HHczZIIBJmOG
    nNzgRJQQ4c6+3c4jZ7rpP5yCJOw7TxMxO/13ti9fZK2xEAAX5DOV1JT6ericwHq6
    JwjTiALKpjoWUeyTp2/ozLV/LuW9IzXmjS1mf93WNtjalkTJuI+sMz/DyZH0i2Ni
    5GUeL4blTGnPtKlzbZDXPmY0DrCdbeGDqCTdFt+bxknQ3nNlTxFXdpu2tBDhMYZT
    KYfIt3AVp4Bof7TXQXYHgackxi6h4/VHt2L2Ca9xG3k27L9j3kZm73Ow3S+CSWQ/
    BEAMLMk4jg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CYKbZ8pn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJwS5WA2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=CYKbZ8pn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OJwS5WA2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeBZI0V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:26:21 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34254 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeBZI0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:26:14 -0500
X-Google-Smtp-Source: AH8x2273gMUXq20mOOl9grct66Q97irrmCFSN9HTm4/26X8xfX5s382LxInmDUcSkxqPUNergVxd5Q==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 39/52] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date: Mon, 26 Feb 2018 16:20:13 +0800
Message-Id: <1519633227-29832-40-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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
