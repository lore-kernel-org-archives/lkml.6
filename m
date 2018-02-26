Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252317-1519633534-2-9725462499883067152
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
    t=1519633533; b=A15Ixrq72W3C3HNQWmT1q/wQ62o7GPXK0LH0D4+TGfMjsXc
    v9JFarBV6NqqBmdVdGCcF9bmR9kwaED4LnOBBl+JKXNA5cYDbsg+RrY7L58ODAWl
    PPr3Wbv1MsngjNdUezhmLd+8FntURsKy5vkfqq/9tK1DdF60f8KTzf8WKhXvBkSF
    go9FmtrjU5eu9xN9V9seM7nCPoYtA9UyElL1xDB/g6q7oLu87tW5yP14hqbP4kb/
    zijM/u6oLNaizXtNYw9Xown2avn8166qtJlhHurlmiP8OZSg8lPzB3hh0k1ou+CT
    bFOtX27CV4/VYeaTbwM0pR0SjH4yRjLn6wwI2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633533;
    bh=dkPnOZNxm9seQPfv5c9vz4+Yjf5n6fqYResagBKyW1s=; b=fKyQ3UTkEuJi
    hhhMIlGxT++EEt7o1ArMXYkTnk+TwaFD7cIPbkDBwVtnYfmuzUE+eZxUoYPLY7Ml
    2x9N++C2NdgZ9/5rgSOhmu4AMcj6OGlDgveEw3N10FO7gAstITlBY8WP4X6kIcdM
    L6un9wdkRayVfGCMB9mXnDtkhbvUK++YIyTTFueu836/YdqddbllCZ6K1KQMcoMU
    emE5cn2cQrydQa0I7Wg1ssD5FvNC4GVSm+ci8qAEH33VyAfpznHwAhc4Tvj8MQwL
    M/ZV/wMwr53VwJqRzD0EzKXs2MGZpfv08NGrWpRzCsn0SQXcfAMcDARnFlLdLhf3
    iNoYricvcw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z4Ilq6+W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yb/VR0gU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Z4Ilq6+W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yb/VR0gU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBZIZa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:25:30 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33382 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeBZIZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:25:24 -0500
X-Google-Smtp-Source: AH8x227yiyS1nksBa+1ugCGnSJ4gUilbEQ4sSMNtaCUXI4dXr3Ii/Cdg+mghcOpHL3u9EJw+7H2rHw==
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
Subject: [PATCH 34/52] arm/arm64: KVM: Implement PSCI 1.0 support
Date: Mon, 26 Feb 2018 16:20:08 +0800
Message-Id: <1519633227-29832-35-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 58e0b2239a4d upstream.

PSCI 1.0 can be trivially implemented by providing the FEATURES
call on top of PSCI 0.2 and returning 1.0 as the PSCI version.

We happily ignore everything else, as they are either optional or
are clarifications that do not require any additional change.

PSCI 1.0 is now the default until we decide to add a userspace
selection API.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	mv chagnes from virt/kvm/arm/psci.c to arch/arm/kvm/psci.c
---
 arch/arm/kvm/psci.c    | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 include/kvm/arm_psci.h |  3 +++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index bc334d6..097632c 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -233,7 +233,7 @@ static void kvm_psci_system_reset(struct kvm_vcpu *vcpu)
 int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_0_2;
+		return KVM_ARM_PSCI_LATEST;
 
 	return KVM_ARM_PSCI_0_1;
 }
@@ -312,6 +312,47 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_psci_1_0_call(struct kvm_vcpu *vcpu)
+{
+	u32 psci_fn = smccc_get_function(vcpu);
+	u32 feature;
+	unsigned long val;
+	int ret = 1;
+
+	switch(psci_fn) {
+	case PSCI_0_2_FN_PSCI_VERSION:
+		val = KVM_ARM_PSCI_1_0;
+		break;
+	case PSCI_1_0_FN_PSCI_FEATURES:
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case PSCI_0_2_FN_PSCI_VERSION:
+		case PSCI_0_2_FN_CPU_SUSPEND:
+		case PSCI_0_2_FN64_CPU_SUSPEND:
+		case PSCI_0_2_FN_CPU_OFF:
+		case PSCI_0_2_FN_CPU_ON:
+		case PSCI_0_2_FN64_CPU_ON:
+		case PSCI_0_2_FN_AFFINITY_INFO:
+		case PSCI_0_2_FN64_AFFINITY_INFO:
+		case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+		case PSCI_0_2_FN_SYSTEM_OFF:
+		case PSCI_0_2_FN_SYSTEM_RESET:
+		case PSCI_1_0_FN_PSCI_FEATURES:
+			val = 0;
+			break;
+		default:
+			val = PSCI_RET_NOT_SUPPORTED;
+			break;
+		}
+		break;
+	default:
+		return kvm_psci_0_2_call(vcpu);
+	}
+
+	smccc_set_retval(vcpu, val, 0, 0, 0);
+	return ret;
+}
+
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -354,6 +395,8 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
+	case KVM_ARM_PSCI_1_0:
+		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
 		return kvm_psci_0_2_call(vcpu);
 	case KVM_ARM_PSCI_0_1:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 5659343..3236043 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -22,6 +22,9 @@
 
 #define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
 #define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
+#define KVM_ARM_PSCI_1_0	PSCI_VERSION(1, 0)
+
+#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
 int kvm_psci_call(struct kvm_vcpu *vcpu);
-- 
2.7.4
