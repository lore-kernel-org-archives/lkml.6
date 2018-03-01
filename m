Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909311-2-14631263180997853747
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
    t=1519909310; b=L0eFcC97YZ/pFWoxVH1MoavPFbP9I8F5Cf75KK8TFBHw74R
    bS4TRbSfVbDcoguJdUSuOMo0POmvNwJOdFHEtk3UGsNQo29mRN+R979wnenrg6VY
    uoZ7Z0OSNsKBsda4CNCF/glinu1+RvyDIX2O7u5Qpk+RmmEe571DJXBTQe8K0KlP
    k11Opi40nd9VDtkTWcaXmtZlnGMSpVGRQXAHeh4d+2GI4yhx/DOtdxiRhoUpvc3P
    SVYl3VpO4moESrGEMU9cASDasm5neIpFXsD14wzI303o4/CAQJIhIp/6jrvTuA5Y
    WsSfBrjjcHX/y0yovKYll7ww6aL1mguIHT+Je3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909310;
    bh=7qDP6b/nHj7r0IkKyyPP7XAky1eZBzSNc9JAXbaxcxI=; b=QdRMLCO2Lbff
    3eWJUkvPN1i+uvWVL74GjXzQZ1IFgS/DVin7cbJDFpzzDxzFxWtkQAtU1VMneUbZ
    qZIKcKgGN1NwDr6h7sIzCbDmgiyvGrbhXI87+xQc/0FVZwMCXxUJKiXkmDRpLuuf
    30NLqjiUxRPSqfSr2s414+dQ1abieGuAZZ0m9DPnMNIxsCyhQwKxV5QkZwDnaZ+s
    rhEh7NzXIzx0c0xfgErOEfwXBiUh6npJn+TQ/xaf7nHC5EZr0xnQ+/4WYsXPocmf
    kCRaH8nha2vBCHwPm4b03hcvMwBUYR8RpCMp/KlyvqRiQG7G+QkwXHAa/gp2vIQb
    g9Odh9hc9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GKKHh5y+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gsne0qhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GKKHh5y+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gsne0qhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030901AbeCANBW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:01:22 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34569 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030916AbeCANBU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:01:20 -0500
X-Google-Smtp-Source: AG47ELtXos/qWL77mvuurc1ghWfqy6Mef/aF46MwdM5KTWq6/wmtswv9JTCCKdIcsws4ZRyyHkNjOA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 45/45] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
Date: Thu,  1 Mar 2018 20:54:22 +0800
Message-Id: <1519908862-11425-46-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 3a0a397ff5ff upstream.

Now that we've standardised on SMCCC v1.1 to perform the branch
prediction invalidation, let's drop the previous band-aid.
If vendors haven't updated their firmware to do SMCCC 1.1, they
haven't updated PSCI either, so we don't loose anything.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/bpi.S        | 24 ------------------------
 arch/arm64/kernel/cpu_errata.c | 41 +++++++++++------------------------------
 arch/arm64/kvm/hyp/switch.c    | 14 --------------
 3 files changed, 11 insertions(+), 68 deletions(-)

diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
index c72f261..dc4eb15 100644
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -54,30 +54,6 @@ ENTRY(__bp_harden_hyp_vecs_start)
 	vectors __kvm_hyp_vector
 	.endr
 ENTRY(__bp_harden_hyp_vecs_end)
-ENTRY(__psci_hyp_bp_inval_start)
-	sub	sp, sp, #(8 * 18)
-	stp	x16, x17, [sp, #(16 * 0)]
-	stp	x14, x15, [sp, #(16 * 1)]
-	stp	x12, x13, [sp, #(16 * 2)]
-	stp	x10, x11, [sp, #(16 * 3)]
-	stp	x8, x9, [sp, #(16 * 4)]
-	stp	x6, x7, [sp, #(16 * 5)]
-	stp	x4, x5, [sp, #(16 * 6)]
-	stp	x2, x3, [sp, #(16 * 7)]
-	stp	x0, x1, [sp, #(16 * 8)]
-	mov	x0, #0x84000000
-	smc	#0
-	ldp	x16, x17, [sp, #(16 * 0)]
-	ldp	x14, x15, [sp, #(16 * 1)]
-	ldp	x12, x13, [sp, #(16 * 2)]
-	ldp	x10, x11, [sp, #(16 * 3)]
-	ldp	x8, x9, [sp, #(16 * 4)]
-	ldp	x6, x7, [sp, #(16 * 5)]
-	ldp	x4, x5, [sp, #(16 * 6)]
-	ldp	x2, x3, [sp, #(16 * 7)]
-	ldp	x0, x1, [sp, #(16 * 8)]
-	add	sp, sp, #(8 * 18)
-ENTRY(__psci_hyp_bp_inval_end)
 
 .macro smccc_workaround_1 inst
 	sub	sp, sp, #(8 * 4)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 9632319..8b74f80 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,7 +53,6 @@ static int cpu_enable_trap_ctr_access(void *__unused)
 DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
 #ifdef CONFIG_KVM
-extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
 extern char __smccc_workaround_1_smc_start[];
 extern char __smccc_workaround_1_smc_end[];
 extern char __smccc_workaround_1_hvc_start[];
@@ -100,8 +99,6 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 	spin_unlock(&bp_lock);
 }
 #else
-#define __psci_hyp_bp_inval_start		NULL
-#define __psci_hyp_bp_inval_end			NULL
 #define __smccc_workaround_1_smc_start		NULL
 #define __smccc_workaround_1_smc_end		NULL
 #define __smccc_workaround_1_hvc_start		NULL
@@ -146,24 +143,25 @@ static void call_hvc_arch_workaround_1(void)
 	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
 }
 
-static bool check_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+static int enable_smccc_arch_workaround_1(void *data)
 {
+	const struct arm64_cpu_capabilities *entry = data;
 	bp_hardening_cb_t cb;
 	void *smccc_start, *smccc_end;
 	struct arm_smccc_res res;
 
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return false;
+		return 0;
 
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return false;
+		return 0;
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if (res.a0)
-			return false;
+			return 0;
 		cb = call_hvc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_hvc_start;
 		smccc_end = __smccc_workaround_1_hvc_end;
@@ -173,35 +171,18 @@ static bool check_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *e
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if (res.a0)
-			return false;
+			return 0;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-		return false;
+		return 0;
 	}
 
 	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 
-	return true;
-}
-
-static int enable_psci_bp_hardening(void *data)
-{
-	const struct arm64_cpu_capabilities *entry = data;
-
-	if (psci_ops.get_version) {
-		if (check_smccc_arch_workaround_1(entry))
-			return 0;
-
-		install_bp_hardening_cb(entry,
-				       (bp_hardening_cb_t)psci_ops.get_version,
-				       __psci_hyp_bp_inval_start,
-				       __psci_hyp_bp_inval_end);
-	}
-
 	return 0;
 }
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
@@ -301,22 +282,22 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 #endif
 	{
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 996328e..154b471 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -311,20 +311,6 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
 
-	if (exit_code == ARM_EXCEPTION_TRAP &&
-	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
-	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32)) {
-		u32 val = vcpu_get_reg(vcpu, 0);
-
-		if (val == PSCI_0_2_FN_PSCI_VERSION) {
-			val = kvm_psci_version(vcpu, kern_hyp_va(vcpu->kvm));
-			if (unlikely(val == KVM_ARM_PSCI_0_1))
-				val = PSCI_RET_NOT_SUPPORTED;
-			vcpu_set_reg(vcpu, 0, val);
-			goto again;
-		}
-	}
-
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
 		bool valid;
-- 
2.7.4
