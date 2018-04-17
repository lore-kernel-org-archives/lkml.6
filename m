Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981536-2-16068214302619121352
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981535; b=pDOvWxYU+pO1QavJ7Lf2HHuVvZM2egd8HLJ8WQa9XFr4GZ6A8L
    q7Y4ja/AdoOKxdQayOa24woP1uv4rZE+f5xkTFEgt1aqX0XobcVcluROWN9XsXlI
    88tejwfjMivWshuxA/tBITyEJFr4y+QkFUUTadz/FYYom87aCRYRIK/gTLNrOPPt
    hUc/8NUy65zvgT8ijFHDc8Wq0fkTW1lyd3KEDcnuptZP6VtV7p6t4fI8FtmGc6wJ
    k+K6Bv90cFmTvWJRX7MbVu+5fr9F/cFKvRK07aqeh01MXJjuWZeFb5DhpmDPNyDv
    QLlDbaOK7fhtGwOm0x3yhnwws3cR/tgw0k1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981535; bh=+dI7jd8AbVxYdTswR5TeNL+7sJ3E1R
    WS5ffUoDTVgTk=; b=TTm+g73kCNcCb8vYmMgrA6IfPiyUY+FRm7IQz3nEtKr0cJ
    GHgg1OFbr6WfYPZLWVMMq+7t5cUeXjldsQB3Njoj+SkG3mBzTYoWu9fsrwSh0aPp
    iExanUe2oBugqIceE2PFXAxfQPUoUgs6ykxgzn5404j11+Q6wWXTFr2LqQlROGay
    6w52h8wJddewxAhbhZg/k/yeGGXr8Xkk+rb3+G1VK7JPUdCgpHm6zLu+53JbxUi5
    OIB3wYjV5vgMHRHk0emSqzByAwVPPaZnINCLEbZCPBYAf+qFwNo/33ROKWw4U0AB
    ukyN++KmYnuxIwJdQFldPNuZWoSlNUyJWXJFCWvQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKSEPjllj2t5jblJLCNLh6evJ2HKjyAIfqNjHXHZCfMt9llaV5OEcYE56U7GrGtwwynF2o0XD/lXS/7AqvE7Bd60JA1pWw9QUwQv6FGC0UNHzz5/VoPy
    jwZjprfE3FYXIHOrwmlxT6cLLiXwjZrAAj6WabjD8WpCsLULTwDPesdpspr4taEblRlkqFHvfgCjWxO+oWLHYYBgZ4OyoUYMBhtDDPIE7DH+NUJo1e/7Whre
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=T4H4mvtYfByIvJVseSAA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbeDQQLG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:11:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755971AbeDQQLE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:11:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 38/66] arm/arm64: KVM: Add smccc accessors to PSCI code
Date: Tue, 17 Apr 2018 17:59:11 +0200
Message-Id: <20180417155647.522384101@linuxfoundation.org>
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

commit 84684fecd7ea381824a96634a027b7719587fb77 upstream.

Instead of open coding the accesses to the various registers,
let's add explicit SMCCC accessors.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/psci.c |   52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -32,6 +32,38 @@
 
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
@@ -74,7 +106,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	unsigned long context_id;
 	phys_addr_t target_pc;
 
-	cpu_id = vcpu_get_reg(source_vcpu, 1) & MPIDR_HWID_BITMASK;
+	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
 		cpu_id &= ~((u32) 0);
 
@@ -93,8 +125,8 @@ static unsigned long kvm_psci_vcpu_on(st
 			return PSCI_RET_INVALID_PARAMS;
 	}
 
-	target_pc = vcpu_get_reg(source_vcpu, 2);
-	context_id = vcpu_get_reg(source_vcpu, 3);
+	target_pc = smccc_get_arg2(source_vcpu);
+	context_id = smccc_get_arg3(source_vcpu);
 
 	kvm_reset_vcpu(vcpu);
 
@@ -113,7 +145,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
-	vcpu_set_reg(vcpu, 0, context_id);
+	smccc_set_retval(vcpu, context_id, 0, 0, 0);
 	vcpu->arch.power_off = false;
 	smp_mb();		/* Make sure the above is visible */
 
@@ -133,8 +165,8 @@ static unsigned long kvm_psci_vcpu_affin
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
-	target_affinity = vcpu_get_reg(vcpu, 1);
-	lowest_affinity_level = vcpu_get_reg(vcpu, 2);
+	target_affinity = smccc_get_arg1(vcpu);
+	lowest_affinity_level = smccc_get_arg2(vcpu);
 
 	/* Determine target affinity mask */
 	target_affinity_mask = psci_affinity_mask(lowest_affinity_level);
@@ -208,7 +240,7 @@ int kvm_psci_version(struct kvm_vcpu *vc
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+	unsigned long psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 	int ret = 1;
 
@@ -275,14 +307,14 @@ static int kvm_psci_0_2_call(struct kvm_
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
+	unsigned long psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 
 	switch (psci_fn) {
@@ -300,7 +332,7 @@ static int kvm_psci_0_1_call(struct kvm_
 		break;
 	}
 
-	vcpu_set_reg(vcpu, 0, val);
+	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return 1;
 }
 
