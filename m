Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA60C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D281621763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqHe8mDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281621763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbeHCPxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:53:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33342 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeHCPxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:53:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3308928pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OPQwdkXqDlJWFQwM8PJrKFSYX6aJHA1emkWP9neFEcg=;
        b=cqHe8mDNvNRM4rqyTE4fY+zvYmCxeu6hch6FR0yfbBWD5dF1WVjPr+kA52003fg3AJ
         RJI9h33DY5vhkLu2J7Aw37ssxXLFZUWfuF90VDV2kbx28StEBIFynCID+RIckcb+Q8Wq
         ebNNZQoFe20gjXUVVG3SyMvCbOlx/NILcX+EmemxOvj82dZbNB+pcxbV10wJJoubJ0vo
         VYqbKoRY7jN8gzbhcMAiWnR8jWcBLzGqnf4vnnucTl86Nis8oaJW93TFBmoaKaxOMpM3
         TvxXcsSH0O5fMwBS0OsNjDbVdIGBhttdjjjt2+HJkKIn8exLx/Wu9ppOLtqB1E5PVTyl
         XxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OPQwdkXqDlJWFQwM8PJrKFSYX6aJHA1emkWP9neFEcg=;
        b=dfghN+Q/jT1Ok5AZmZQiHjFwwfFJ8kx7IzZNzULfFhNj2IxtO/MAf4a+I/QKcneA26
         wkRyOUn4ZEJ4CkWJQ+pt6BYqCEbfERsLdFOCAqKwOZ3pSXa9Rb7rHh5iOyBofYBbouWb
         mmCZH2nCldCVHHyOKdnruZSY3Rc46r+znu+k2D/bqyg9781iaqnscKtKyGXSZWR5zvwZ
         Gf0lqp3VJuBiCNykEOTGn/+r8qPVEZYAtiv14enTq1uWveGL4OdAUpbnyn2E68+kIab6
         pr7fR5+11YLYSdrzMf9TgNlgl6rVPX8tX68INg62jOdrzdgRClD0e9Cs7ZgwZy1PKJz3
         Wu4w==
X-Gm-Message-State: AOUpUlFqP19JFY1arWZKPHqsOC8KZ7xAvZVPlfN+HZudF8vsZI2fXW22
        jtdWmkDb6lc0A7s0jKaIVSI=
X-Google-Smtp-Source: AAOMgpfsXbrBD/0IKAQ5gTIeIxIW4Z34msz8guaCp1MASNSDSQPTg+HI+wGSMLMNzV1EdmBjNdONWg==
X-Received: by 2002:a63:f344:: with SMTP id t4-v6mr3899062pgj.428.1533304643814;
        Fri, 03 Aug 2018 06:57:23 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id p5-v6sm6755173pfn.57.2018.08.03.06.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 06:57:23 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jia He <hejianet@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH 2/2] KVM: arm/arm64: vgic: no need to call spin_lock_irqsave/restore when irq is disabled
Date:   Fri,  3 Aug 2018 21:57:04 +0800
Message-Id: <1533304624-43250-2-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533304624-43250-1-git-send-email-jia.he@hxt-semitech.com>
References: <1533304624-43250-1-git-send-email-jia.he@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because kvm_vgic_sync_hwstate currently is definitly in the context
which irq is disabled (local_irq_disable/enable). There is no need to
call spin_lock_irqsave/restore in vgic_fold_lr_state and vgic_prune_ap_list

This patch replace them with the spin_lock/unlock no irq version

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 virt/kvm/arm/vgic/vgic-v2.c |  7 ++++---
 virt/kvm/arm/vgic/vgic-v3.c |  7 ++++---
 virt/kvm/arm/vgic/vgic.c    | 13 +++++++------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index a5f2e44..487f5f2 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -62,7 +62,8 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_v2_cpu_if *cpuif = &vgic_cpu->vgic_v2;
 	int lr;
-	unsigned long flags;
+
+	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 	cpuif->vgic_hcr &= ~GICH_HCR_UIE;
 
@@ -83,7 +84,7 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 
 		irq = vgic_get_irq(vcpu->kvm, vcpu, intid);
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		spin_lock(&irq->irq_lock);
 
 		/* Always preserve the active bit */
 		irq->active = !!(val & GICH_LR_ACTIVE_BIT);
@@ -126,7 +127,7 @@ void vgic_v2_fold_lr_state(struct kvm_vcpu *vcpu)
 				vgic_irq_set_phys_active(irq, false);
 		}
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		spin_unlock(&irq->irq_lock);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index cdce653..b66b513 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -46,7 +46,8 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 	struct vgic_v3_cpu_if *cpuif = &vgic_cpu->vgic_v3;
 	u32 model = vcpu->kvm->arch.vgic.vgic_model;
 	int lr;
-	unsigned long flags;
+
+	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 	cpuif->vgic_hcr &= ~ICH_HCR_UIE;
 
@@ -75,7 +76,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 		if (!irq)	/* An LPI could have been unmapped. */
 			continue;
 
-		spin_lock_irqsave(&irq->irq_lock, flags);
+		spin_lock(&irq->irq_lock);
 
 		/* Always preserve the active bit */
 		irq->active = !!(val & ICH_LR_ACTIVE_BIT);
@@ -118,7 +119,7 @@ void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu)
 				vgic_irq_set_phys_active(irq, false);
 		}
 
-		spin_unlock_irqrestore(&irq->irq_lock, flags);
+		spin_unlock(&irq->irq_lock);
 		vgic_put_irq(vcpu->kvm, irq);
 	}
 
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index c22cea6..7cfdfbc 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -593,10 +593,11 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_irq *irq, *tmp;
-	unsigned long flags;
+
+	DEBUG_SPINLOCK_BUG_ON(!irqs_disabled());
 
 retry:
-	spin_lock_irqsave(&vgic_cpu->ap_list_lock, flags);
+	spin_lock(&vgic_cpu->ap_list_lock);
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
@@ -637,7 +638,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		/* This interrupt looks like it has to be migrated. */
 
 		spin_unlock(&irq->irq_lock);
-		spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+		spin_unlock(&vgic_cpu->ap_list_lock);
 
 		/*
 		 * Ensure locking order by always locking the smallest
@@ -651,7 +652,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 			vcpuB = vcpu;
 		}
 
-		spin_lock_irqsave(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+		spin_lock(&vcpuA->arch.vgic_cpu.ap_list_lock);
 		spin_lock_nested(&vcpuB->arch.vgic_cpu.ap_list_lock,
 				 SINGLE_DEPTH_NESTING);
 		spin_lock(&irq->irq_lock);
@@ -676,7 +677,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 
 		spin_unlock(&irq->irq_lock);
 		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
-		spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+		spin_unlock(&vcpuA->arch.vgic_cpu.ap_list_lock);
 
 		if (target_vcpu_needs_kick) {
 			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
@@ -686,7 +687,7 @@ static void vgic_prune_ap_list(struct kvm_vcpu *vcpu)
 		goto retry;
 	}
 
-	spin_unlock_irqrestore(&vgic_cpu->ap_list_lock, flags);
+	spin_unlock(&vgic_cpu->ap_list_lock);
 }
 
 static inline void vgic_fold_lr_state(struct kvm_vcpu *vcpu)
-- 
1.8.3.1

