Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633563-2-7403465717318058053
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
    t=1519633562; b=u1t93fUSvJrmeABOEFEZcmpWHr0qgi2N6AM+27h+0XV49Km
    MoO8tTxXw4gjLSuK7+iqChQsB/aaNVnmoGdXZJDVJ9d1YZOMP15eUSdA/dy+s0h6
    9Evj+a+cg82M/nFn3ZJDZo38Wwc77lIitQrC4uOQUccWTenxHDLbl0S2oNSPB+0v
    jHg35mu1DfUa/JTkSTK3/YETbt/rh0CFe7t95JSBXindnJL3cmkYrwLPu24RnTup
    IKjHBnSjB4UVMGvk29FEBLmtKqYqbh9wIFc+gq/meRs06NUILuHZmXw7jFHX/mva
    U/R5n4ofMwm0mZi0+m7TG+NA5nRQq6DKU5515Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633562;
    bh=1RaPKZO6eEZg+WHRSpnHizT0jS04yyLzTCiVvYJ2E2U=; b=mu4NpV4XmwL8
    Q5aylRBOxzwC0DbY8A2Yd/2c5M4iTzcIr/ztE6r8WSX2lMcZJnrnaq1wHWv4bZeL
    s5fCo0Aze8XiUeWL7cpPt/7KyNfY98zn9IKDCwmk1yD7BKqJ+iaZ346zeY/cEkD2
    OxVkAG85LkMKyfed2A3oWRX6NUbjHTOak7bufGNVBqFGIfc7WUAPXrpyG+ZSlUbX
    htzEnfucegAf0aQjd5MGMvCJj+paetdxRHbmJ32HJJ0KwwxAJWuUffioAMMtZoce
    7b4UHGWQJfgQ7h1Q1krbHqfidQySAJ9q92wOwtDT0ukEF0wfh2E26hL42Rqfd9DZ
    s1/LjsanGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=enGsPUns x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rw3wt6LJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=enGsPUns x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rw3wt6LJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeBZIZ6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:25:58 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40131 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeBZIZy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:25:54 -0500
X-Google-Smtp-Source: AH8x2261ip32ESoaUUJMgG2qXq37FfCK0Frp+J0W6ow2faItx/vDYgVb4W74DrqCiqMh/Z0I2NowYw==
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
Subject: [PATCH 37/52] arm/arm64: KVM: Turn kvm_psci_version into a static inline
Date: Mon, 26 Feb 2018 16:20:11 +0800
Message-Id: <1519633227-29832-38-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit a4097b351118 upstream.

We're about to need kvm_psci_version in HYP too. So let's turn it
into a static inline, and pass the kvm structure as a second
parameter (so that HYP can do a kern_hyp_va on it).

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	mv changes from virt/kvm/arm/psci.c to arch/arm/kvm/psci.c
---
 arch/arm/kvm/psci.c         | 12 ++----------
 arch/arm64/kvm/hyp/switch.c | 20 ++++++++++++--------
 include/kvm/arm_psci.h      | 21 ++++++++++++++++++++-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 7b44253..396eb5d 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -121,7 +121,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
 	if (!vcpu->arch.power_off) {
-		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
 			return PSCI_RET_INVALID_PARAMS;
@@ -231,14 +231,6 @@ static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
 	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
 }
 
-int kvm_psci_version(struct kvm_vcpu *vcpu)
-{
-	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_LATEST;
-
-	return KVM_ARM_PSCI_0_1;
-}
-
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -396,7 +388,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
  */
 static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_psci_version(vcpu)) {
+	switch (kvm_psci_version(vcpu, vcpu->kvm)) {
 	case KVM_ARM_PSCI_1_0:
 		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 3eab6ac..996328e 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -19,6 +19,8 @@
 #include <linux/jump_label.h>
 #include <uapi/linux/psci.h>
 
+#include <kvm/arm_psci.h>
+
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
@@ -311,14 +313,16 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	if (exit_code == ARM_EXCEPTION_TRAP &&
 	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
-	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32) &&
-	    vcpu_get_reg(vcpu, 0) == PSCI_0_2_FN_PSCI_VERSION) {
-		u64 val = PSCI_RET_NOT_SUPPORTED;
-		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-			val = 2;
-
-		vcpu_set_reg(vcpu, 0, val);
-		goto again;
+	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32)) {
+		u32 val = vcpu_get_reg(vcpu, 0);
+
+		if (val == PSCI_0_2_FN_PSCI_VERSION) {
+			val = kvm_psci_version(vcpu, kern_hyp_va(vcpu->kvm));
+			if (unlikely(val == KVM_ARM_PSCI_0_1))
+				val = PSCI_RET_NOT_SUPPORTED;
+			vcpu_set_reg(vcpu, 0, val);
+			goto again;
+		}
 	}
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index ed1dd80..e518e4e 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,6 +18,7 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
+#include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
 #define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
@@ -26,7 +27,25 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
-int kvm_psci_version(struct kvm_vcpu *vcpu);
+/*
+ * We need the KVM pointer independently from the vcpu as we can call
+ * this from HYP, and need to apply kern_hyp_va on it...
+ */
+static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	/*
+	 * Our PSCI implementation stays the same across versions from
+	 * v0.2 onward, only adding the few mandatory functions (such
+	 * as FEATURES with 1.0) that are required by newer
+	 * revisions. It is thus safe to return the latest.
+	 */
+	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+		return KVM_ARM_PSCI_LATEST;
+
+	return KVM_ARM_PSCI_0_1;
+}
+
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
-- 
2.7.4
