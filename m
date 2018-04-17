Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981377-2-6984263215390430143
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981376; b=CDFIKeWmHOfe9UR0lwF7abhLhzNfmBdZMyvTiz/MPnpCt5Xg6o
    umTM9Zw15BPlHzVU8DCaL4vE7mgotAjOwZ5qGrH31nNPXCiN4fYCX4ycBhdQthA+
    vg+xUxdqSme/RSRXRbTqIOYYX6/vqMLO8Wt4ShTvzPHMhU6Vi8+MEGwnLBU1VTbY
    KGa70aj+ViVKq08TYuhNVAbNWwowhF/NKISV/9no6HcYSbw3NA0UzoBOeCPoy+Rn
    2Wu1FnAu89wEsv1R9K3c/qWGfa7RIdUi2RhU7UDsX/0vWG+HbxIOjrQV5voySqCb
    zAfXvHK7807y7Deb/SyvMVcUzS6RB85+QEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981376; bh=TNyMyYp34HLCRyPrz433DnT/l6IcHq
    Sy79usn6YXCM8=; b=YXNKD5yHtTGZynuQ7nSD1UKciBXUybpErx8WM2S8O1/86q
    pwBvAWPLseyMJ1srUrOWjSbDqk43Te1nYeLiC4Ev1ZWP2+aPTtwJkneeqDSrPHDH
    A7vc4bp+VCDP5pVhYjFq0U28g0M5EX0xRFx2XVamhtN4BjQFmq42xp7UB6udOwrb
    +f0BoNFePBtzmvBuvAugx8cufGG+tTwQpXDq9D2/U/8Z+AURcfDx17hS6pNZF8gp
    SIjjENJeHlREYdoj6OMU6REdlh4HCoo5G+wcsHulV8hs8jH2IPfKnloTHHw4bmFz
    PoNcVREg2iDpMNulxojN5jYfpXqF5cNQC7BQW8xw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfP2i8q+oh69OqSGJx34EzI/kYQjuNHFovdqszN62gU2FnmM8e5HivxVaYCYBTEHHNtapTpbGHX1Co9b7ZRSPSIt5bDHxSIcUqhuiDCBlmmCszlyk1iCu
    TIqdibRUnYGQZfOV7yIZjkBbXKsmopVcExZoHxgcWZDgMP0d8TQZ1lwP4HrsQj+3I9IaOPCLDXd3qt2TsocIxD6ba/YlHgDqhFGJXl35n+wM9F79Mtxzb6n8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=njmoMKXfCdIciTVzAGEA:9
    a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeDQQJc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:09:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeDQQJb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:09:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 41/66] arm64: KVM: Make PSCI_VERSION a fast path
Date: Tue, 17 Apr 2018 17:59:14 +0200
Message-Id: <20180417155647.652315522@linuxfoundation.org>
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

commit 90348689d500410ca7a55624c667f956771dce7f upstream.

For those CPUs that require PSCI to perform a BP invalidation,
going all the way to the PSCI code for not much is a waste of
precious cycles. Let's terminate that call as early as possible.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/switch.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/jump_label.h>
+#include <uapi/linux/psci.h>
 
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
@@ -308,6 +309,18 @@ again:
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
 
+	if (exit_code == ARM_EXCEPTION_TRAP &&
+	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
+	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32) &&
+	    vcpu_get_reg(vcpu, 0) == PSCI_0_2_FN_PSCI_VERSION) {
+		u64 val = PSCI_RET_NOT_SUPPORTED;
+		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+			val = 2;
+
+		vcpu_set_reg(vcpu, 0, val);
+		goto again;
+	}
+
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
 		bool valid;
