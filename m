Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909428-2-14809013930240399010
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
    t=1519909427; b=hX3wB5TdxvJr+28QdIdqhLh50hGvPmW12fZ8M6RQr04+z0B
    h2581HMqrqUt3pleYGdhBDDUfAd4fAViNFGZQ7Ejuiv4WqdpEt+ulr1BWFitMjJZ
    Zg3wirv6RNAhHJF5NewISX74OMneEEEGxPoRxFe54qUi5zBGKk/3rh33s8Z++VGE
    bnZwzIKbcfe7AmqkmzPPWgydpEfyzV9hkuUDKs05g8EFB0Hh0xpfZ8z8xRqcB9Ui
    gZYwyqjZ3WAY1vnAxVRYmt+zK3sWBCn6dQFY79FDo4h7E1TyMx0xEqYK9lmAdUjk
    7mVjurTJw5i3vOTpLi11vopA3l7Bpjr/2qrbxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909427;
    bh=Uco9yRsCAyX2xrhlinZnEESkEh5h0LM+vQPWF5wB2iw=; b=EoTmNxYeUl9e
    WDBoB3xN+BNqCmd5Ekutx78m4cwjBl5dhgnn+/ElwmntCbclUJun9MRK15UJvb/z
    C7XtXIIrQSGQO/TdkUUOmtBf+fUuFd2zWi1mmF7Q69uIzdzVVoHVTcHFPzStgrWQ
    aJYSRqPqHghGEST+R6VlvX0nMiaNf4SZnkPd/0fYrvPA5H9IlTnGkwBFUrf2vWGa
    j86DJNhSKvnoeR6W4RwYjc7il8hPfHyw4vFWrYlQA6JjH2uajRzxbWgLY209kWJM
    wEgfv8IF1Cdg4SGZwldkCQTRiPpmnwzdmzy5RxfKecMdbV2PdGehqPLMsznNHSBd
    /5kkJ+2EOg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JrrO13SK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RE4/xpCg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JrrO13SK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RE4/xpCg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031032AbeCAM7r (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:59:47 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44171 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031015AbeCAM7n (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:43 -0500
X-Google-Smtp-Source: AG47ELtgfWbT6DAQoasmhgNMA4nzzDjk3XBP0b2caTBqmd+4qLYlglVuGhGjSnIeGCN9gxJmjDgOdQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 32/45] arm/arm64: KVM: Add PSCI_VERSION helper
Date: Thu,  1 Mar 2018 20:54:09 +0800
Message-Id: <1519908862-11425-33-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit d0a144f12a7c upstream.

As we're about to trigger a PSCI version explosion, it doesn't
hurt to introduce a PSCI_VERSION helper that is going to be
used everywhere.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/kvm/psci.c       | 2 +-
 include/kvm/arm_psci.h    | 6 ++++--
 include/uapi/linux/psci.h | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 18f9e9d..4adfa28 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -219,7 +219,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 		 * Bits[31:16] = Major Version = 0
 		 * Bits[15:0] = Minor Version = 2
 		 */
-		val = 2;
+		val = KVM_ARM_PSCI_0_2;
 		break;
 	case PSCI_0_2_FN_CPU_SUSPEND:
 	case PSCI_0_2_FN64_CPU_SUSPEND:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 2042bb9..5659343 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,8 +18,10 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
-#define KVM_ARM_PSCI_0_1	1
-#define KVM_ARM_PSCI_0_2	2
+#include <uapi/linux/psci.h>
+
+#define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
+#define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
 int kvm_psci_call(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 3d7a0fc..39930ca 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -87,6 +87,9 @@
 		(((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
 #define PSCI_VERSION_MINOR(ver)			\
 		((ver) & PSCI_VERSION_MINOR_MASK)
+#define PSCI_VERSION(maj, min)						\
+	((((maj) << PSCI_VERSION_MAJOR_SHIFT) & PSCI_VERSION_MAJOR_MASK) | \
+	 ((min) & PSCI_VERSION_MINOR_MASK))
 
 /* PSCI features decoding (>=1.0) */
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT	1
-- 
2.7.4
