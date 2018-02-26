Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633574-2-15011847082783666667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633573; b=X0jnIdZlaZk2trj6TI3yvfVueykpOMLWG2/fR95mheJXzUj
    6I96yFjcmWsuBMArTXXEzv2wXR+P0b9jp+n0QKIU0YQkIAi6HGppvR1i+R35/s7z
    /VFzEaHBh3N98crRTVyIKh9cIWkYqmCkQ2LA0kIgfR1ocVFXIUhSpXN4nqcspfcG
    HaqT+Y+TRZsy2pcMhveNtj6P8TESrQ4xjNcZcgxOQkjGqppi3825kYJc7qMtB0Uo
    TXG8YyFBcE5L/ygfVQnLdhoL/LskNu9OIQGkqyvzeCa+9QdB33GjC/QRzJ/aIfgY
    ehZY8kNeC78WULB4cnW0VnGChKZU0lHgnKzk41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633573;
    bh=45rSmjFMKcw3BvYABEBt7fYl55v7nB64zwwP7vtw3XM=; b=V9XzGmgMjwZx
    upehBUC1bsl/WOpoRnggl0n/SI+IsBg0R9zXVsmJfm1/1A5f2THEM7NLH878WbAw
    alshl/XT3gD6k5ONchJZ6RTsJPAWr31kq6led2kl5GI1fmtiSwv7teamPz740qb+
    MR2PgIWmcoTfc9rYvYRmSbe6awTDNoRhpKYFlpSG8mEYKJH7A8HFTIY/P+nHWQY2
    1k3vf9CGBAuIA1YsdrDM4vmb6vqOKQrfmqPxDt2SFbGqZy13+duzeNgsQ3Q8kHYp
    ERn8WF+KLAzKg1hyedg85nVZifbChIitx8xtPjCiLacdHmSXO8m4NAH6tl6hGQwd
    uy0RxYgE1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Qy/nBnHn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kyXzMTX5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Qy/nBnHn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kyXzMTX5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeBZI0K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:26:10 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33450 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeBZI0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:26:04 -0500
X-Google-Smtp-Source: AG47ELseHGqMyD7vV/Vr3UgNtMkuvkh/7NjUzfORNlqdjPG/LMbozRlOC97SSH+kcHOQBbk5IlKK6A==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE (KVM) FOR ARM),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE (KVM)
        FOR ARM),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 38/52] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Mon, 26 Feb 2018 16:20:12 +0800
Message-Id: <1519633227-29832-39-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6167ec5c9145 upstream.

A new feature of SMCCC 1.1 is that it offers firmware-based CPU
workarounds. In particular, SMCCC_ARCH_WORKAROUND_1 provides
BP hardening for CVE-2017-5715.

If the host has some mitigation for this issue, report that
we deal with it using SMCCC_ARCH_WORKAROUND_1, as we apply the
host workaround on every guest exit.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	no sve support in arch/arm64/include/asm/kvm_host.h
	mv changes from virt/kvm/arm/psci.c to arch/arm/kvm/psci.c
	using cpus_have_cap instead of cpus_have_const_cap
---
 arch/arm/include/asm/kvm_host.h   | 6 ++++++
 arch/arm/kvm/psci.c               | 9 ++++++++-
 arch/arm64/include/asm/kvm_host.h | 6 ++++++
 include/linux/arm-smccc.h         | 5 +++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index d5423ab..9fe1043 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -318,4 +318,10 @@ static inline int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 	return -ENXIO;
 }
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return false;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 396eb5d..a825638 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -404,13 +404,20 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
 	u32 val = PSCI_RET_NOT_SUPPORTED;
+	u32 feature;
 
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		/* Nothing supported yet */
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case ARM_SMCCC_ARCH_WORKAROUND_1:
+			if (kvm_arm_harden_branch_predictor())
+				val = 0;
+			break;
+		}
 		break;
 	default:
 		return kvm_psci_call(vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e505038..7f5244a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -393,4 +393,10 @@ static inline void __cpu_init_stage2(void)
 		  "PARange is %d bits, unsupported configuration!", parange);
 }
 
+
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	return cpus_have_cap(ARM64_HARDEN_BRANCH_PREDICTOR);
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index dc68aa5..e1ef944 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -73,6 +73,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_1					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x8000)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
-- 
2.7.4
