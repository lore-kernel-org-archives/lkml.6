Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981479-2-3767590307679763371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981478; b=sWsQ3yI8ET/VWWqnV4tCWcUJIz0X3XaFHHlncZmRgw/Fl36Usm
    tRE5buRpHXSOTDsfm/X3OGivUaC93U5B4sjiKn5DUjjknkB9Or4zROIkvvDlb7ca
    JBnAg64GFDXyo5YQjOcpBPGpYCYI8r0V9g4sqNE/FYKJ2mFJ3yFxqlfB/5hP5yPx
    eO3om+IMf6/EPCVyry7eXLcgth2Z2IT7ED74Svx0/hj7HN+aqJ7wvSpeBkS3Cy9/
    LQMcL2j/c4H6h6VGwrBhYpRAhHxr/LMYt9EWo6WFUs9yghawOi8GpGJtt/GyGFWA
    K6XHt1SkSNh3ETr1krNIxUyEahYlnUNOSL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981478; bh=OkYavHGbqHZYwGyzJUOW8+IlqjtGHw
    3gEXYsyd9fOJ4=; b=v02U+SNr9ZOw+Fxrga0k+1GFgh2Y2yJ9cx/9NHdIJb/UUs
    8AhrmZzxGYxXu7z/xQf2EIPX/+qTHvz/N41jW2qTzwvF61JL2vY+W/ekDwg218lS
    FKGxVVxE6/eWvBiTi/UTl/LyMlT2rLoM9uLkrd7QQG75Zrl+XHvBj2/MrzleMX8W
    UGN1+9k8aRgF07hti0AyeRnd28J1sl3hNroAzQLYj8uOgGyKduN8xyhsuw8FLR6+
    RwHPe7HG2WD1xv5UbyMwnmWo4R1j4T8FiVMS2WYfI4LMM65nHaVOF8r/p05bjt1k
    7i6RUL+xYhy/6wIdVwixGHkm11qNla9r1w7gR/0A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGgClHmt6p6SU5bJstJV2IQXjjwS68XnIsASzHcBA5wHTEtYhgxOz+sZpO5yZxm+cD8lwCxJk2W2TP33DeWYQyFuQZQc7BT5IqIn3nqsIEFfib8XocKu
    4l+mYH2RjRIVL1s0y+aTuZVgWOzNfwFFPn8TKL8maVkn7P3mc5aeJHEOVYG2qWsKwtgRRiUgDevOtkxnEc7KzKu3dNt0Gtt8PWI2j83tw7szhTSNqPa6nLNw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=MsixjDVGnuUOYMjBewwA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755971AbeDQQLK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:11:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36630 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeDQQLH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:11:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 39/66] arm/arm64: KVM: Implement PSCI 1.0 support
Date: Tue, 17 Apr 2018 17:59:12 +0200
Message-Id: <20180417155647.562185014@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit 58e0b2239a4d997094ba63986ef4de29ddc91d87 upstream.

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
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/psci.c    |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 include/kvm/arm_psci.h |    3 +++
 2 files changed, 47 insertions(+), 1 deletion(-)

--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -232,7 +232,7 @@ static void kvm_psci_system_reset(struct
 int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_0_2;
+		return KVM_ARM_PSCI_LATEST;
 
 	return KVM_ARM_PSCI_0_1;
 }
@@ -311,6 +311,47 @@ static int kvm_psci_0_2_call(struct kvm_
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
@@ -353,6 +394,8 @@ static int kvm_psci_0_1_call(struct kvm_
 int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
+	case KVM_ARM_PSCI_1_0:
+		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
 		return kvm_psci_0_2_call(vcpu);
 	case KVM_ARM_PSCI_0_1:
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
