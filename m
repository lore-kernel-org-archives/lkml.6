Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909375-2-4575689307443816432
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
    t=1519909375; b=sGkED7PPvaHGQe3bT1DjohoNICc1RJUsGEuGzeZY7hjarqd
    rqVJLkbSrBetm9TOWgrJFWVC6sZ9D1y/BGm8/iZ1b6EmBBXAF27ncTzTM8cg6ymA
    bOOOF3SoJjflvFufpvRL+osoOXyiPs5WnsZLE38za4McCFSe0uN498WyUPJG3ESa
    R82/WkEjLoWFYOeUh6TeF279SCSs+D13M+9APTCHCa82r+li6NxPuGKw5PLrO5BT
    XvX7ghwHwFIBRxq/8vaeb7HWE6WkvSfy7EbAk0Iis8JmxSK56dkDAeQy7Jy8b1H3
    FBdHMib1o8Y7F+cEu0fFwGnkZpxU1z7Se9aQ5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909375;
    bh=vuv71HvEZ9HnAUJTQ52hE3U6SvzV4oqNvK9jHSVsfaA=; b=q097sEHXx3gO
    aZaJrX0Jp9FI2JWj36gKo1jbUB2T4U8AseZDQm61HtjNemZj8NidZBUPeqC7vnrN
    xNNMeoQSfsV32E4jgVTLWTSQlO3lJp9M4S6Uu6+yriCsAouLErPIdb3fjN66mPa4
    JQomB+0xmCEDWBUvWhhwgdkk+/VOqJzsc4uTuRMBPb2JhF4uTEnpYB5MhZfAmg4Q
    Ec4tnSsPrUkoRDry3CnoNdbgCNcvOj8PRK0KL9RobFKUoM85t4nfd7hk4bRHdzuH
    XIzS2j8Ss4cH521KIf26eNCOMqmSIA8h07t4In9fHeqgMVAa6gYVoQJynGtqWNS1
    CB/Lubxj1g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GqeIjuNj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LzGktDeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=GqeIjuNj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LzGktDeA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030602AbeCANAJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:00:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44224 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031068AbeCANAF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:00:05 -0500
X-Google-Smtp-Source: AG47ELtgSL1sTSRJuBjBP4LdFCUZmrPYO3mW3EHExX/14b1ZDvOGzGeSzo9GLHApwXH3/j69nhGmWQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 35/45] arm/arm64: KVM: Advertise SMCCC v1.1
Date: Thu,  1 Mar 2018 20:54:12 +0800
Message-Id: <1519908862-11425-36-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 09e6be12effd upstream.

The new SMC Calling Convention (v1.1) allows for a reduced overhead
when calling into the firmware, and provides a new feature discovery
mechanism.

Make it visible to KVM guests.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/kvm/handle_exit.c   |  2 +-
 arch/arm/kvm/psci.c          | 24 +++++++++++++++++++++++-
 arch/arm64/kvm/handle_exit.c |  2 +-
 include/kvm/arm_psci.h       |  2 +-
 include/linux/arm-smccc.h    | 13 +++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 0a2b758..de1aedc 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -36,7 +36,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		      kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 097632c..7b44253 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/preempt.h>
 #include <linux/kvm_host.h>
 #include <linux/wait.h>
@@ -338,6 +339,7 @@ static int kvm_psci_1_0_call(struct kvm_vcpu *vcpu)
 		case PSCI_0_2_FN_SYSTEM_OFF:
 		case PSCI_0_2_FN_SYSTEM_RESET:
 		case PSCI_1_0_FN_PSCI_FEATURES:
+		case ARM_SMCCC_VERSION_FUNC_ID:
 			val = 0;
 			break;
 		default:
@@ -392,7 +394,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
  * Errors:
  * -EINVAL: Unrecognized PSCI function
  */
-int kvm_psci_call(struct kvm_vcpu *vcpu)
+static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
 	case KVM_ARM_PSCI_1_0:
@@ -405,3 +407,23 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	};
 }
+
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
+{
+	u32 func_id = smccc_get_function(vcpu);
+	u32 val = PSCI_RET_NOT_SUPPORTED;
+
+	switch (func_id) {
+	case ARM_SMCCC_VERSION_FUNC_ID:
+		val = ARM_SMCCC_VERSION_1_1;
+		break;
+	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
+		/* Nothing supported yet */
+		break;
+	default:
+		return kvm_psci_call(vcpu);
+	}
+
+	smccc_set_retval(vcpu, val, 0, 0, 0);
+	return 1;
+}
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 0231ebc..d4047fc 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -43,7 +43,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			    kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 3236043..ed1dd80 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -27,6 +27,6 @@
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
-int kvm_psci_call(struct kvm_vcpu *vcpu);
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 4c5bca38..dc68aa5 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -60,6 +60,19 @@
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
+#define ARM_SMCCC_VERSION_1_0		0x10000
+#define ARM_SMCCC_VERSION_1_1		0x10001
+
+#define ARM_SMCCC_VERSION_FUNC_ID					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0)
+
+#define ARM_SMCCC_ARCH_FEATURES_FUNC_ID					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 1)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
-- 
2.7.4
