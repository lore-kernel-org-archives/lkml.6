Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909429-2-15944702391680808475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909428; b=cDZBNz2WRkbpimf7V0UY0pElEzMEWheNa3EZLF7dYwKpCZl
    QlTZ5/6a92LA7ixxD8Jcsah11FszS9JOmTWKPc+EASp3v+DTvIx9F/aAwMZE689a
    KNsWhVNRIEaOkOn5FgRrJOKDTN+pcLICIiZ6B3ULa16ewJwO6ARcRp1jbI9Yo73w
    eeDD8iIio9k22s+Jwyn+L9aVHTyFOc+++qb1OGWMppYl7Gj431dkZatlEPWkMtDO
    kRsLCQwGAR9n59+Rrh4SroBUFkD5wjedcOYCWII846WACv4aiuz+OW9wTwl3YfuL
    C7vTBjNnJ6Pqj3pYz9F+qEkaB4L1VjCscFqXLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909428;
    bh=J+5mFS5YG0Z6B4feNaUOGsgL/hJiqYMdZY2VyVL7BU0=; b=A+XMGkMS3MFo
    ZKfzsRm8Vdj8+wfIRYbJT+rZ+0FQ5nfIGOYi2yvf3xuxIKCkR9+L6TMslFHT5I+P
    Wl3dfSpNkUmlPl65CaN9NC82bk1bXxHbb94hU7XqqoPusuFy/9SYKvz3JpVb2KX5
    84A0DUrm3mrfupALgXetu+wMJ1E7mBg1x7X7PjNorpZQxr5yPoHA0h4OMwdFgSVS
    jEa0gePSDbgMG0h3kTWYlYfrXrMw2VrP6UeH9/OTVH9z4i/HCjz2V6wHmFkdDOKa
    YUoP4Ko9u4pJDtoayIt2wAlxb5uOoIprgxmbhj51dZlb7WKmXHtEkQDrqS1tCsYk
    5wD/UvAZVw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=cNliJQE+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TvDORTKO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=cNliJQE+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TvDORTKO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030783AbeCANAA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:00:00 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37032 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031054AbeCAM75 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:57 -0500
X-Google-Smtp-Source: AG47ELvKp4Clz97eme3mdjWQnxvda2WgRLRApIFE4uP/5+Rx5eBiail9K7eRDPa2cBNTS+RNp1oT7A==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 34/45] arm/arm64: KVM: Implement PSCI 1.0 support
Date: Thu,  1 Mar 2018 20:54:11 +0800
Message-Id: <1519908862-11425-35-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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
