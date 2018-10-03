Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE571C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B3A205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpqlgojz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B3A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJCM1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44690 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJCM1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so1008056pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=brENiSq0BigeT7B6M0CDwm+7yKs7N4uNWByk5vyJaVs=;
        b=Vpqlgojzqb3g5S/k9ADiWTu/aXYZ/iMEVjdC5aDrY1c/mtfiuyt+LtigtVdF9Puka1
         U5LqUu6jfhF8qKEglmR8P2CtHYCXMOvaLj/flWSy/5g9ouVkWZ4A4Pp5P+lWhRWVsabB
         pR3mnCM3434RxRe7dRcJnrf5YLs5WuDZIXOb5ximQ0SPGqIMYePLV9oNAZe7nfCQh2pb
         aDeiupzJXC2m08qMkJcfX6epZu6dGRmBKGR+x4+NdNBx8oRAFdRnJmUqrlT8llW1zvGN
         8iHbtT+e8EpJqklWkIKTzTaxtk5Ipsi/AuVlfj8lXUCZTrm5DaAbtA+9lNQuJM7f7lcm
         9LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=brENiSq0BigeT7B6M0CDwm+7yKs7N4uNWByk5vyJaVs=;
        b=FXKSK1LBdd3siKppDlGu53o7E3vcxhqq0FBK6FK0fahoSJCSc2uGDy44CgblULVPCc
         HAFmUu5eJSKRCcyjwQiv30bnquc92eW/eiy9IcqOp7V84a9nEE/373e/+eYDVF6QyfiG
         aTj1+w9k/ioJHMBQv+zMF470Ode+7Ywqm8hXwX4tBqZ6LgzKuWFGgYkJ6MdeKgsOsX2f
         ld3oBh1HGucZvvmsN8+Z0fVYRQoXbvYkOw642cFth+tyaCSztG8mvdMlbXHEMoK40OPq
         CJ37FEMnn4Tak69w43tTQxH4OzbPHxBv8UFfEQbbN1XQpRU0qnsAh7znbLDV3fWmQLgc
         9Hag==
X-Gm-Message-State: ABuFfojRdjWYlZ/gowpJTIC9R4ldO52R0S+s0IY2WTBwiXKoEMvBo9+I
        mfUHsZrWR+RGo9zWSBj3HO4=
X-Google-Smtp-Source: ACcGV63dA5v0NHZlRYgSrMvqPzLPsfphom1Q+5bo2AFvmgOsJl4w0bpXeyTMYaZ1s1u+EQwm44TYSw==
X-Received: by 2002:a62:3402:: with SMTP id b2-v6mr10716216pfa.65.1538545220109;
        Tue, 02 Oct 2018 22:40:20 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id s85-v6sm866730pfi.15.2018.10.02.22.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:19 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 893071643D1; Tue,  2 Oct 2018 22:40:18 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH 16/16] KVM: arm/arm64: vgic: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:39:02 -0700
Message-Id: <20181003053902.6910-17-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: <kvmarm@lists.cs.columbia.edu>
---
 virt/kvm/arm/vgic/vgic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 7cfdfbc910e0..50e25438fb3c 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -196,7 +196,7 @@ void vgic_irq_set_phys_active(struct vgic_irq *irq, bool active)
  */
 static struct kvm_vcpu *vgic_target_oracle(struct vgic_irq *irq)
 {
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	lockdep_assert_held(&irq->irq_lock);
 
 	/* If the interrupt is active, it must stay on the current vcpu */
 	if (irq->active)
@@ -273,7 +273,7 @@ static void vgic_sort_ap_list(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	lockdep_assert_held(&vgic_cpu->ap_list_lock);
 
 	list_sort(NULL, &vgic_cpu->ap_list_head, vgic_irq_cmp);
 }
@@ -311,7 +311,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
 {
 	struct kvm_vcpu *vcpu;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	lockdep_assert_held(&irq->irq_lock);
 
 retry:
 	vcpu = vgic_target_oracle(irq);
@@ -702,7 +702,7 @@ static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
 static inline void vgic_populate_lr(struct kvm_vcpu *vcpu,
 				    struct vgic_irq *irq, int lr)
 {
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&irq->irq_lock));
+	lockdep_assert_held(&irq->irq_lock);
 
 	if (kvm_vgic_global_state.type == VGIC_V2)
 		vgic_v2_populate_lr(vcpu, irq, lr);
@@ -736,7 +736,7 @@ static int compute_ap_list_depth(struct kvm_vcpu *vcpu,
 
 	*multi_sgi = false;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	lockdep_assert_held(&vgic_cpu->ap_list_lock);
 
 	list_for_each_entry(irq, &vgic_cpu->ap_list_head, ap_list) {
 		int w;
@@ -761,7 +761,7 @@ static void vgic_flush_lr_state(struct kvm_vcpu *vcpu)
 	bool multi_sgi;
 	u8 prio = 0xff;
 
-	DEBUG_SPINLOCK_BUG_ON(!spin_is_locked(&vgic_cpu->ap_list_lock));
+	lockdep_assert_held(&vgic_cpu->ap_list_lock);
 
 	count = compute_ap_list_depth(vcpu, &multi_sgi);
 	if (count > kvm_vgic_global_state.nr_lr || multi_sgi)
-- 
2.19.0

