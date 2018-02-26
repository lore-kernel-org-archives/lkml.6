Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519633787-2-10867618164176303512
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
    t=1519633787; b=mR/eqAWypIOUsJnLQcPET7ToB7227RJ2qMhTtB0bhilu1XG
    y9/CbWYofzG3ci38vIgyFgZ5tWKlW8sKTNU7mn1SrJM+rbz02Ch+0VaBkbeeE6S2
    JlOKuTs/PEAexlhWXuFLAYYrnq+mqfQqeYo2StH+vC0Y7LqPsoLq0Ljmq/kFJ0KC
    VKS4HyebvFLkSE1vor2rA3Uldp789MIV9Qmra6eXhwEp+d6UE/tZP+n/fJ8l7ALh
    ifUU/CS7C67Gns9a43E+TCUX79V1bQQ1vFLXOyWZeTK0lCqGGnF7Nanz+ToBh+71
    QUnLEiBsO8PyBjJ9DGDj4mKgbnbIZzTreyMtLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633787;
    bh=FrYQc7jNWo3H77WRAN83meLx1vfqAFkomM5c8aD6cAQ=; b=s5BQQLHvqrC5
    Q4qVd3/wNyFGs+iyIvdGr2vD5bg1fhRsMpbutye2sW0VMNKSD0FBTLtA8TUVA60g
    y2ech1pqUBi7qifrixxIwBtgFo22AB2e+AutFCw8nqaB05PbA4N8nfv88/jLu20F
    +qs2k0qEYCIkh4ICxLqi5DeXW/vIYioJtGMX7+L2ovmOle4oy9WyINtLz7Xk1eOQ
    ueTZE4/EiNqITRNeK2Rw9d/PnRqTeymn/EuS2BlaMZVAUudY7e22MP1Ayv7V1mDy
    8KijYMP9lIBiDx11Rz5NgU6+0bKA/jalplvLlAbwlUUm44f4Wqw2fMcFNDJJ0mzX
    5lJuo/cK6Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=PMncHEnw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UKLCfsFR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=PMncHEnw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UKLCfsFR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBZI3n (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:29:43 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43270 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbeBZI1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:27:01 -0500
X-Google-Smtp-Source: AH8x227tUY3FQXy8Bbey6RWOuAgeXwa09wAyaeZh6+n9k1XsnSYv32UBejTnuKXFo6KIphERky9cXQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM))
Subject: [PATCH 45/52] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
Date: Mon, 26 Feb 2018 16:20:19 +0800
Message-Id: <1519633227-29832-46-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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

Conflicts:
	no falkor/thunderx2/vulcan in arch/arm64/kernel/cpu_errata.c
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
