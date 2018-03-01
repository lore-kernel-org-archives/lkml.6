Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909367-2-13827767529521474401
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
    t=1519909366; b=A4pSceSsxKXtFoAVzVXuDIAj/u3y/TJr0pbzaCMNgMIjUG9
    wc2GAW0V8d4ClePCdCTrC0oKyT1N/GfbkDFXEXEbc2rODD+FTUTX4PzMdy6imheK
    uZvimvdWB5QBBm/Vb6vb5uhutQetYPM2IT9Lx4bRL79JJ1jnGu1VMLXSB43lpyA5
    KqA03FCXH5nbhU4Fu+9IIirBvWAS7cwwR3iyZlve73JG8pqqmCQzlVFBCUK4cshY
    U0i8yZifn0R6tZ91MO67WqKDCnmrNkVdB3T+B0y3W9TJuyEdKZUevWSSFUCWepTH
    fuce8F776i6uf17tFO/JmnGrKv7gWnRv+Kf0uLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909366;
    bh=ccWpB6B5MEm475gq8sjuImnJLMpKY94QLsRYdXyhfpw=; b=X1Egxldnniso
    iIqw2BrbYa9Ljfmqy6SrsVJrbG8zwz1xVTFJOwZsVzKFowOhV6B5rvyEh+Gb5TaQ
    gRCb0bjj9MgnNi/htAfQpAltSvyCPrB70pzm+gAZ/nUXyZ/WMIIYCTV5Q/alupAA
    v2F+8nD0WRNOt2d1MChAv7nz6YNQowBDip+oraBswamOQOZ/7U3aXQChkFqIv7Hw
    MoYke0N+ogeqff0y3nWtOvAQwrttzoKNf5eocgMgVs3Sq+GKwCXZxeme6Vm1fB41
    9gYcGHUFgu6I3rogx+Fay7kKoJhpbgqrIas1tcy5cGmIPKov5GcWrgM++T0S/gY9
    UoidUeX/0g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=eBmCz7H/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SWDOasCE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=eBmCz7H/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SWDOasCE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030902AbeCANAR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:00:17 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34490 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031079AbeCANAO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:00:14 -0500
X-Google-Smtp-Source: AG47ELuwXmdc1w573zhtJw92ULLeXSeXk/R1elcK1LZOdUCfepOZL9hv+KRfBaW511IX3E/UZgI/bQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 36/45] arm64: KVM: Make PSCI_VERSION a fast path
Date: Thu,  1 Mar 2018 20:54:13 +0800
Message-Id: <1519908862-11425-37-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
