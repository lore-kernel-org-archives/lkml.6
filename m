Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F54218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAYSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:23:26 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.80]:34888 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbfAYSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:23:26 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C750F170625
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:23:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n68Sgzbdd90onn68SgQVAJ; Fri, 25 Jan 2019 12:23:24 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41920 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn68N-001LRU-4C; Fri, 25 Jan 2019 12:23:23 -0600
Date:   Fri, 25 Jan 2019 12:23:17 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] KVM: x86: Mark expected switch fall-throughs
Message-ID: <20190125182317.GA21244@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn68N-001LRU-4C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:41920
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

arch/x86/kvm/lapic.c:1037:27: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/lapic.c:1876:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/hyperv.c:1637:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/svm.c:4396:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/mmu.c:4372:36: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/x86.c:3835:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/x86.c:7938:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/vmx/vmx.c:2015:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kvm/vmx/vmx.c:1773:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/kvm/hyperv.c  | 2 +-
 arch/x86/kvm/lapic.c   | 2 ++
 arch/x86/kvm/mmu.c     | 1 +
 arch/x86/kvm/svm.c     | 2 +-
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 arch/x86/kvm/x86.c     | 3 +++
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index c90a5352d158..9c67efec613d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1636,7 +1636,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_hvcall_signal_event(vcpu, fast, ingpa);
 		if (ret != HV_STATUS_INVALID_PORT_ID)
 			break;
-		/* maybe userspace knows this conn_id: fall through */
+		/* fall through - maybe userspace knows this conn_id. */
 	case HVCALL_POST_MESSAGE:
 		/* don't bother userspace if it has no way to handle it */
 		if (unlikely(rep || !vcpu_to_synic(vcpu)->active)) {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9f089e2e09d0..4b6c2da7265c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1035,6 +1035,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 	switch (delivery_mode) {
 	case APIC_DM_LOWEST:
 		vcpu->arch.apic_arb_prio++;
+		/* fall through */
 	case APIC_DM_FIXED:
 		if (unlikely(trig_mode && !level))
 			break;
@@ -1874,6 +1875,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
 
 	case APIC_LVT0:
 		apic_manage_nmi_watchdog(apic, val);
+		/* fall through */
 	case APIC_LVTTHMR:
 	case APIC_LVTPC:
 	case APIC_LVT1:
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..da9c42349b1f 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4371,6 +4371,7 @@ __reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 			rsvd_bits(maxphyaddr, 51);
 		rsvd_check->rsvd_bits_mask[1][4] =
 			rsvd_check->rsvd_bits_mask[0][4];
+		/* fall through */
 	case PT64_ROOT_4LEVEL:
 		rsvd_check->rsvd_bits_mask[0][3] = exb_bit_rsvd |
 			nonleaf_bit8_rsvd | rsvd_bits(7, 7) |
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a157ca5b6869..36bda524c883 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4395,7 +4395,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_APICBASE:
 		if (kvm_vcpu_apicv_active(vcpu))
 			avic_update_vapic_bar(to_svm(vcpu), data);
-		/* Follow through */
+		/* Fall through */
 	default:
 		return kvm_set_msr_common(vcpu, msr);
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f10e584..1de38062026e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1773,7 +1773,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
 			return 1;
-		/* Otherwise falls through */
+		/* Else, falls through */
 	default:
 		msr = find_msr_entry(vmx, msr_info->index);
 		if (msr) {
@@ -2014,7 +2014,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		/* Check reserved bit, higher 32 bits should be zero */
 		if ((data >> 32) != 0)
 			return 1;
-		/* Otherwise falls through */
+		/* Else, falls through */
 	default:
 		msr = find_msr_entry(vmx, msr_index);
 		if (msr) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02c8e095a239..6d514619afd3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3834,6 +3834,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	case KVM_CAP_HYPERV_SYNIC2:
 		if (cap->args[0])
 			return -EINVAL;
+		/* fall through */
+
 	case KVM_CAP_HYPERV_SYNIC:
 		if (!irqchip_in_kernel(vcpu->kvm))
 			return -EINVAL;
@@ -7937,6 +7939,7 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 		vcpu->arch.pv.pv_unhalted = false;
 		vcpu->arch.mp_state =
 			KVM_MP_STATE_RUNNABLE;
+		/* fall through */
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.apf.halted = false;
 		break;
-- 
2.20.1

