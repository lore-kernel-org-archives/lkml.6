Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981528-2-3805316072982886280
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
    1523981527; b=D1iOdtWkLm36BqS5yvxfCYg7IgpiHoRmKTxHUr/phEizyuMAzU
    Jbm0z3j+HsjPdp1oGXSypya4CU1VQn1R5kWJG9OagxBkQ/qYN4zV6EX89K8fWBEn
    MGgt7XEB6jdSWkrv1jaAQKANGhv9Ipo0rNghUah2RO50XolwYteqB/7w9AqlmlY6
    MpDN0SxiyHebLGjzs59LfXYMTiKHKO05FXYnLiQv5/U1X0kD8ti6HO1M3ECcphRo
    RdUWj3LmD+VZAyBHRysW+YLppEFrRjeUqDM3yIPUGkWeVbqJM1W4ZP3WTgCIZLEv
    +RRKYPjcU1K8YJ+3/H439VtUNVbCeiCoj5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981527; bh=tAKmfAZ5PaeEC/b4HdqOwvrDo/rgpv
    UJek2kHSOV8z0=; b=UqR8NVyna5652XK5MwCrqclyQC60vU0EFxCt0QVdnHoSQM
    C/tWVQBIc9FFSZ0u00LNgjwXM213K9UzIFhbrJXDNo5/CW5+wyw1lm5Zk9yuNCd1
    9TTgmi1et9tMUPWgG7SgGQnjb71ZdXB56guzmd+VglvyvfS3i8tjewIuasyERuqy
    PWDaPb7VhIm8qyb/rRExNxJuWQzqlRc83pQggH0rrAa/C29qWtqnUyijAR7eKIX1
    w+b35V0VwDGEFVYLrjJGym2jWAVd1su0BNwRZCndXHnSvR3et8+OB5ToF6Til6SD
    94GgtmTgjjzkU04jNfeKwvWbLIRTYkO6u4u7bX+g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfBT4ZlhS44Adk28Yq4k7uSKLKmyuhvBm5wSjjQ/dShcgufl1IMjPmx5eN9m6bVVQ6btPBUxAHs6kMLcgj2FBo0KddN24ZDK5h3jTEd0w8fkQULYFTYIo
    DVm4kisNqHlPjGLJwgLMMJ3t5lJ8cbSGUt7EoZMbQCXzNajj90wI9vL2yrR7lKaoF+8U3ZfVo83rkefg8vVfqgWx5jPDvC8N4Dyntpn4blJCA2RHxYgzXOvi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=mDV3o1hIAAAA:8 a=ETDoKjPJt9Y2aqgU8O8A:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_FVE-zBwftR9WsbkzFJk:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeDQQLw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:11:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755343AbeDQQLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:11:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 40/66] arm/arm64: KVM: Advertise SMCCC v1.1
Date: Tue, 17 Apr 2018 17:59:13 +0200
Message-Id: <20180417155647.609261405@linuxfoundation.org>
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

commit 09e6be12effdb33bf7210c8867bbd213b66a499e upstream.

The new SMC Calling Convention (v1.1) allows for a reduced overhead
when calling into the firmware, and provides a new feature discovery
mechanism.

Make it visible to KVM guests.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/handle_exit.c   |    2 +-
 arch/arm/kvm/psci.c          |   24 +++++++++++++++++++++++-
 arch/arm64/kvm/handle_exit.c |    2 +-
 include/kvm/arm_psci.h       |    2 +-
 include/linux/arm-smccc.h    |   13 +++++++++++++
 5 files changed, 39 insertions(+), 4 deletions(-)

--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -36,7 +36,7 @@ static int handle_hvc(struct kvm_vcpu *v
 		      kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/preempt.h>
 #include <linux/kvm_host.h>
 #include <linux/wait.h>
@@ -337,6 +338,7 @@ static int kvm_psci_1_0_call(struct kvm_
 		case PSCI_0_2_FN_SYSTEM_OFF:
 		case PSCI_0_2_FN_SYSTEM_RESET:
 		case PSCI_1_0_FN_PSCI_FEATURES:
+		case ARM_SMCCC_VERSION_FUNC_ID:
 			val = 0;
 			break;
 		default:
@@ -391,7 +393,7 @@ static int kvm_psci_0_1_call(struct kvm_
  * Errors:
  * -EINVAL: Unrecognized PSCI function
  */
-int kvm_psci_call(struct kvm_vcpu *vcpu)
+static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
 	case KVM_ARM_PSCI_1_0:
@@ -404,3 +406,23 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
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
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -45,7 +45,7 @@ static int handle_hvc(struct kvm_vcpu *v
 			    kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -27,6 +27,6 @@
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
-int kvm_psci_call(struct kvm_vcpu *vcpu);
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
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
