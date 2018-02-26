Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519633851-2-1311211931597027451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633850; b=V2e+H7+zLf0uuHxfxv4/pOgBt8k2QLTLdlIQlY1exvAxwOk
    zKeELlFNxkujUEyXbyc5ndT3YqZbsF6kkTyhz7XWU5zYNXlrvmqMMtGMSguMoc18
    m6lO1OGtDVkNxvuDuBVeJ6DxJ681yuifKbWC18Actbep00ZU4HBG5zztHCbbsUqc
    +sCNQ88b6Cc5BNYBBdZOF6+23gAwBp5lixBgfG+0yr6NAKc7amAD4Gh1bfzfiRSr
    PPYXJD3U6qyz+UfTsJgluIBp9qcSX256mfq9siFAVHHX+3Uyx3FghL9CVNCp9Vbz
    UmmKuB3qnjhQZc/ONmYr3wbQokareM8XXQY4EMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633850;
    bh=ccWpB6B5MEm475gq8sjuImnJLMpKY94QLsRYdXyhfpw=; b=GPd3/ZYNs6qo
    BH2DOiW8miVRvrXqEqog/CWFOaIRe8DRDG1/YRkBodkZu8Jnt0p1v0YRrbwI/2f+
    WjnPBXNG+t6nV0LE0SJvwPFLGv76+lm3jM0lNTLbcB2vIxAirRTJzVKIG4nPcvCV
    g2pNt+qWDRY7FDw0nGnvCMLlToxvvrJwHDHib/cc/pHCG9H8tsw0DrgRZWmjfJO4
    OLcTU7cDSgBV0rl7YNCU95gh9OqTWYxjx02oGC/65TyBDnc2we/2LtOXwoGrfgt/
    w/bCRRxJlgTmnyJOPenp1N/YAFxiuzjtSVGAOF1KLbJxf4pq5VOQUAR8+mzE/ioC
    64j3TBVguA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GMSh1cUz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GtEgNDAx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GMSh1cUz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GtEgNDAx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeBZIZt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:25:49 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40124 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeBZIZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:25:44 -0500
X-Google-Smtp-Source: AG47ELui7C09Q6V4JPFdQRZwnJne7JL+Ej1ZEMKk9SFOx4Um2rssVJCuo50pUHmJp+i3yFNk+3atyA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 36/52] arm64: KVM: Make PSCI_VERSION a fast path
Date: Mon, 26 Feb 2018 16:20:10 +0800
Message-Id: <1519633227-29832-37-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 90348689d500 upstream.

For those CPUs that require PSCI to perform a BP invalidation,
going all the way to the PSCI code for not much is a waste of
precious cycles. Let's terminate that call as early as possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index cf6d962..3eab6ac 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/jump_label.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
@@ -308,6 +309,18 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
 
+	if (exit_code == ARM_EXCEPTION_TRAP &&
+	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
+	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32) &&
+	    vcpu_get_reg(vcpu, 0) == PSCI_0_2_FN_PSCI_VERSION) {
+		u64 val = PSCI_RET_NOT_SUPPORTED;
+		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+			val = 2;
+
+		vcpu_set_reg(vcpu, 0, val);
+		goto again;
+	}
+
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
 		bool valid;
-- 
2.7.4
