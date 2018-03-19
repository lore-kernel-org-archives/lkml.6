Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484316-2-11982124054777102780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484315; b=KsEB5x64a/48Ihc3rvDY9B5n0T3CE/XCrGGUnuijYcgYaRa
    1PUtFG3gw+mBViZz/qnsns3cCZTgIDsNDZxrUbVJ5sKS13/lK680toM6i67VA2zB
    0n7O3wVj97Z4j7pKauD2S0tkdzNy1/ev+Dyr3iBNjw4DpR1zwaNHG/Ou/u8Myd3V
    SSS35qpEKZeo1gGCTnYYYid1SmgVcOtGofY1CHodyOLoMf4rNvH/enpE9oJ7A/7z
    vFdvsbFITGqPXrNE2yewbZjsCw4+9foDuQRVn6K7Icax7G4vMMezQcKMjv2NTjtN
    3O1M+K3bhA6/2kIJpl6boeq/hhUz5ZeH9OfRvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484315; bh=if93LpOC1ucLCR6DwYuFDdrrfl
    w8RnpV5FYJgu9lIWk=; b=oPO6zA11i11BFlSlq3CWhQeouKqv2pzVbQPdu0k5c5
    pd/BWno743D+bdVtQHoiXUC3z3To4Qd2AkytDdgjZYtVTmh8J642V8oiL/4ejAJ3
    zjlMcBH19ik5EWLCinEJvtE7rpc7Rni/OI4/SoAKC1H367Ajiubt5R6nZh9GFlAe
    w4ATWKNDLDP/FKR6n87aoUtE1a1d0nUWBs6smxPVs9Z828vc01eF3vjk+nsVZf3G
    5lJC48a4SqLJF/moPnHUBYxZAJFjcQ9K+nChHOJvr5YvZCjl2836m0r3sJEes2Fi
    3/T/75TM/AgrmEncf1pE7mGO2NOvyinNww/G+PUWQEcA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheduieenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegheduieenucevlhhushhtvghrufhiiigvpeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970167AbeCSSbv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:31:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970196AbeCSSbq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:31:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Dall <cdall@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.15 22/52] KVM: arm/arm64: Reset mapped IRQs on VM reset
Date: Mon, 19 Mar 2018 19:08:20 +0100
Message-Id: <20180319180736.337229056@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <cdall@kernel.org>

commit 413aa807ae39fed7e387c175d2d0ae9fcf6c0c9d upstream.

We currently don't allow resetting mapped IRQs from userspace, because
their state is controlled by the hardware.  But we do need to reset the
state when the VM is reset, so we provide a function for the 'owner' of
the mapped interrupt to reset the interrupt state.

Currently only the timer uses mapped interrupts, so we call this
function from the timer reset logic.

Cc: stable@vger.kernel.org
Fixes: 4c60e360d6df ("KVM: arm/arm64: Provide a get_input_level for the arch timer")
Signed-off-by: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/kvm/arm_vgic.h    |    1 +
 virt/kvm/arm/arch_timer.c |    4 ++++
 virt/kvm/arm/vgic/vgic.c  |   26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -349,6 +349,7 @@ void kvm_vgic_put(struct kvm_vcpu *vcpu)
 bool kvm_vcpu_has_pending_irqs(struct kvm_vcpu *vcpu);
 void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu);
 void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu);
+void kvm_vgic_reset_mapped_irq(struct kvm_vcpu *vcpu, u32 vintid);
 
 void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg);
 
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -589,6 +589,7 @@ void kvm_timer_sync_hwstate(struct kvm_v
 
 int kvm_timer_vcpu_reset(struct kvm_vcpu *vcpu)
 {
+	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
@@ -602,6 +603,9 @@ int kvm_timer_vcpu_reset(struct kvm_vcpu
 	ptimer->cnt_ctl = 0;
 	kvm_timer_update_state(vcpu);
 
+	if (timer->enabled && irqchip_in_kernel(vcpu->kvm))
+		kvm_vgic_reset_mapped_irq(vcpu, vtimer->irq.irq);
+
 	return 0;
 }
 
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -460,6 +460,32 @@ int kvm_vgic_map_phys_irq(struct kvm_vcp
 	return ret;
 }
 
+/**
+ * kvm_vgic_reset_mapped_irq - Reset a mapped IRQ
+ * @vcpu: The VCPU pointer
+ * @vintid: The INTID of the interrupt
+ *
+ * Reset the active and pending states of a mapped interrupt.  Kernel
+ * subsystems injecting mapped interrupts should reset their interrupt lines
+ * when we are doing a reset of the VM.
+ */
+void kvm_vgic_reset_mapped_irq(struct kvm_vcpu *vcpu, u32 vintid)
+{
+	struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, vintid);
+	unsigned long flags;
+
+	if (!irq->hw)
+		goto out;
+
+	spin_lock_irqsave(&irq->irq_lock, flags);
+	irq->active = false;
+	irq->pending_latch = false;
+	irq->line_level = false;
+	spin_unlock_irqrestore(&irq->irq_lock, flags);
+out:
+	vgic_put_irq(vcpu->kvm, irq);
+}
+
 int kvm_vgic_unmap_phys_irq(struct kvm_vcpu *vcpu, unsigned int vintid)
 {
 	struct vgic_irq *irq;
