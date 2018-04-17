Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981560-4-12427618603198825734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981560; b=PbPt7xRohRSXgzdvuKQwcqi2td3jd0uUNLDPeG+Y362nUXsV3Y
    Gu4E6NYpTVMDH1VvYbniv+U2ZVY6Q9jMMVqwWMAk7R0gHY2Mp0oQn59gzsNEdkzB
    3Ej6DnOS6azYpx9vo1/sMTy+AXEmJpqhIARACKu0MvkEjU18krO95pDniq+TBwYM
    49RgHRybkAkGJciz3B/2TFldSfkOohaw9TtMLtAJ8MK3jmmv3mtuZ1cCkdLRSBik
    I7p4NhoHFdTvWO33fegbsbkqfnGt8GfRXFUtBh38svGSACCkgmTjFIlMpdX8yTmc
    Rgy/rAB81BcJNGFTiS/aBTkAbPr4+qd1cgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981560; bh=faFrD4ub1WtVBZQdhZt+2Ib48MtqK4
    Imhgoy0ItBHKo=; b=cy6xO7wCHHA3ff/r1JX8k0YFVqcEjWRN3CJ8xwplB6u+92
    0JPKyZXAhXpGi6MtvO2fFEACVCXn+bHbfGw/brgxK7RDGiU+m2C8p70fe2d9m+MK
    tspdyRNWJ28eyytqnGSRgwrCk/mzJA5mo7fOqWny9LxyJj1SI1ozQ0b8k29kRGC0
    6D+7IA8iixZ4WL5+G1ROrFLaoT5+XqgWlF9mjGQGDM45yODA2mIsD9MzEwK8Eu3Q
    C9J/wBRwvA/wKPTLf+Cae+OXGUITyqgTL6Cr3s7PKdCAfNxFhd8ttKV0ckJkcnMT
    5uB7EltycAcJIu68A0uJbGqquCDE0Raq0YRwc8JQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBF7EWOW7qFVvKQn31OKE5xi/nY5grXTBF9iHeF8MbKrh5Hk+Vws8Hz32gD55cDWhnvr+gVsBDlOjBQa2AS426e2Xi9E0uOBsLJ11n9xQe0iJ3qgNSDA
    3lXI8nozZZNG7DrXv7UiSbh0/egg+Uvbjb/xkFhJWiryHTqihfiqEn9j9Gqhl2UsEDrSutjvyYXVuvxuAmBlW/hjo8sr4WhWQS6eebzDIX+JpYmNha3K01Rz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8
    a=MaSup40oq-sYfJouEPcA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeDQQLD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:11:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755944AbeDQQLB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:11:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 37/66] arm/arm64: KVM: Add PSCI_VERSION helper
Date: Tue, 17 Apr 2018 17:59:10 +0200
Message-Id: <20180417155647.481213836@linuxfoundation.org>
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

commit d0a144f12a7ca8368933eae6583c096c363ec506 upstream.

As we're about to trigger a PSCI version explosion, it doesn't
hurt to introduce a PSCI_VERSION helper that is going to be
used everywhere.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/psci.c       |    4 +---
 include/kvm/arm_psci.h    |    6 ++++--
 include/uapi/linux/psci.h |    3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -25,8 +25,6 @@
 
 #include <kvm/arm_psci.h>
 
-#include <uapi/linux/psci.h>
-
 /*
  * This is an implementation of the Power State Coordination Interface
  * as described in ARM document number ARM DEN 0022A.
@@ -220,7 +218,7 @@ static int kvm_psci_0_2_call(struct kvm_
 		 * Bits[31:16] = Major Version = 0
 		 * Bits[15:0] = Minor Version = 2
 		 */
-		val = 2;
+		val = KVM_ARM_PSCI_0_2;
 		break;
 	case PSCI_0_2_FN_CPU_SUSPEND:
 	case PSCI_0_2_FN64_CPU_SUSPEND:
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
