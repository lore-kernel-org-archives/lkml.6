Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633522-2-9248757623307908185
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
    t=1519633522; b=ejcKoFeZZ7T7rI+QtJJd2/ZDrhAp18mobWYZpD6A3x/F9TL
    SJyffrSnJGvjyPlaM4iYxcwQvV0oOZigbIGdP/tgwo2RBbvOrs6ZHFa+jcLDvjDo
    lxH3IToevhoXE4x6wDezfsfF4r8d0k00lE4RuuEGSdGTqf0ZJbKOgrp4gOl4KSIl
    rVtG9mPedAZpPCFiYB/VT3YGmVq1WsZ8ZEgm/XN68wweWQvfaMIf6K3q8LOMJLJ3
    yKpfJpGuAV5y8WrxN1DTA6gzPEMoXpwkPsLbnxEojmdVRgJPfPemu7tr/3eWmibv
    HpEPtJy47hpt9JkIZIHgA3J1pnskjx+cRp3bAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633522;
    bh=joq1LHzXEIs9X9WqC4BlIrH4LbSvJY9OeFalK8l0bao=; b=WPJrHN32oiV0
    wmA3QTIyEFV+/YMBh51UHfTeVdtjJeByYwr7AlQU7tbp8oM3e6+FU0iwG1R2YM31
    NxchruMXdqSZPUfhlhQ6k8jzogOdEuqOA0EgrGF8nAnL0rBjoIKUb3poHuYnF7ux
    udPuNLOf5lp4XwVUy9hzG3bW7szwcaRxPHJSHLWOR5VzIdO+lEnNDQT8RIVtBvsC
    LWuq7gcWo1r+rPsVgiy0VzeP4mpOqZxlpJMAWxpwSdDQ6ta+4miVzd1Tie6o1wtG
    dTZqPFD67U5WXNmE+bOhlF8JHO4ZCnJ9f12kOl0jCnOBtZ0CbWKGbFGMqwRMfae6
    l3QFH6ZAHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=SNpo7E61 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rCry9+MO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=SNpo7E61 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rCry9+MO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeBZIZS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:25:18 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44644 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeBZIZN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:25:13 -0500
X-Google-Smtp-Source: AH8x227jxH0P3ePqLfmTs0WV5au412fXY4j+ho+EthrZ0HY8dO+w1RRzOyqJnCyz4hEPsYMehF7OzA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE (KVM) FOR ARM),
        kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MACHINE (KVM)
        FOR ARM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 33/52] arm/arm64: KVM: Add smccc accessors to PSCI code
Date: Mon, 26 Feb 2018 16:20:07 +0800
Message-Id: <1519633227-29832-34-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 84684fecd7ea upstream.

Instead of open coding the accesses to the various registers,
let's add explicit SMCCC accessors.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	mv change from virt/kvm/arm/psci.c to arch/arm/kvm/psci.c
---
 arch/arm/kvm/psci.c | 52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 4adfa28..bc334d6 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -33,6 +33,38 @@
 
 #define AFFINITY_MASK(level)	~((0x1UL << ((level) * MPIDR_LEVEL_BITS)) - 1)
 
+static u32 smccc_get_function(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 0);
+}
+
+static unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 1);
+}
+
+static unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 2);
+}
+
+static unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 3);
+}
+
+static void smccc_set_retval(struct kvm_vcpu *vcpu,
+			     unsigned long a0,
+			     unsigned long a1,
+			     unsigned long a2,
+			     unsigned long a3)
+{
+	vcpu_set_reg(vcpu, 0, a0);
+	vcpu_set_reg(vcpu, 1, a1);
+	vcpu_set_reg(vcpu, 2, a2);
+	vcpu_set_reg(vcpu, 3, a3);
+}
+
 static unsigned long psci_affinity_mask(unsigned long affinity_level)
 {
 	if (affinity_level <= 3)
@@ -75,7 +107,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	unsigned long context_id;
 	phys_addr_t target_pc;
 
-	cpu_id = vcpu_get_reg(source_vcpu, 1) & MPIDR_HWID_BITMASK;
+	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
 		cpu_id &= ~((u32) 0);
 
@@ -94,8 +126,8 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 			return PSCI_RET_INVALID_PARAMS;
 	}
 
-	target_pc = vcpu_get_reg(source_vcpu, 2);
-	context_id = vcpu_get_reg(source_vcpu, 3);
+	target_pc = smccc_get_arg2(source_vcpu);
+	context_id = smccc_get_arg3(source_vcpu);
 
 	kvm_reset_vcpu(vcpu);
 
@@ -114,7 +146,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
-	vcpu_set_reg(vcpu, 0, context_id);
+	smccc_set_retval(vcpu, context_id, 0, 0, 0);
 	vcpu->arch.power_off = false;
 	smp_mb();		/* Make sure the above is visible */
 
@@ -134,8 +166,8 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
-	target_affinity = vcpu_get_reg(vcpu, 1);
-	lowest_affinity_level = vcpu_get_reg(vcpu, 2);
+	target_affinity = smccc_get_arg1(vcpu);
+	lowest_affinity_level = smccc_get_arg2(vcpu);
 
 	/* Determine target affinity mask */
 	target_affinity_mask = psci_affinity_mask(lowest_affinity_level);
@@ -209,7 +241,7 @@ int kvm_psci_version(struct kvm_vcpu *vcpu)
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+	u32 psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 	int ret = 1;
 
@@ -276,14 +308,14 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		break;
 	}
 
-	vcpu_set_reg(vcpu, 0, val);
+	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return ret;
 }
 
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+	u32 psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 
 	switch (psci_fn) {
@@ -301,7 +333,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 		break;
 	}
 
-	vcpu_set_reg(vcpu, 0, val);
+	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return 1;
 }
 
-- 
2.7.4
