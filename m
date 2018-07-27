Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227F3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F5208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJS3GGlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77F5208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeG0STo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:19:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388964AbeG0STe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:19:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so5714018wro.5;
        Fri, 27 Jul 2018 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lHocE5F9VqKINpe4y/eKFDH40yjsAZXsD5Yre//2RSc=;
        b=nJS3GGlZylQECjOyGuLMLH0Ly0hS+HFTq326i/RhCOfJrCdEcQM6dDuoEY873MYS5y
         F91NPJKqXHyV7xl1dwbfV2jA2Jhc5d/H7b48GWR604U5+nVImBw+XlZfxknsO6IVTiou
         9ZfPViDbOomydZcZXkf98tcvFenWjhTtVgxf5ny959TbaXeRuvlFV26rJtJ8hpD00KNZ
         e/x2BnJfI2mrrxSVMxvSDe3Pcd7W0APbNIWZUeVUfFqaqaREA12gQkCNdVK/D8M6wAVw
         lV78+8aM+5oExJ7f+35RF6qa9OqU6XtSlG13lWS0TFIzFWiJFuHq72sPQCRsfqZgxKbv
         /5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lHocE5F9VqKINpe4y/eKFDH40yjsAZXsD5Yre//2RSc=;
        b=dimhA7C/vPcTCeO46YL6KbQy9TYp7zoP0NdT5g2kh7tuKI9xAzaWNBlwIhjm1Oxbe7
         Wb0aN8zR0T+IQW//X/dgEuKBIrWsSKtLo+YdpJrR/KPsI9E5co5K4peuJfUuWJlj89TJ
         9Rlb8C4GBWEDrF/4CYuFVGGpQOoYqWXturIr8ceeKDozftM73XJVFLCtO0OaqwaADoXo
         8JILZd7+bECq95VfYkWvlyNys19nC0Rn+e2P6k21q8RwAQXZ+r5TRIvc3lQbDpM8lmC1
         VxGNt6oI5r98Xq17SIflBeKwOLjBeBYCuOuba/JgH+TGPLAW9xHr8rMOIfFYyrT2jKCz
         Nb7A==
X-Gm-Message-State: AOUpUlH3LvTqh8v0DZcIeLQTGNYUv1NXR+E6vrAw0Mfi257Y9Cx2rH3q
        Skkpi5KaZ2zNqvf7RvdaiD4agL3B
X-Google-Smtp-Source: AAOMgpcmEVc0avgp6eOLShDJY40VpSw2n381swT60CiJ7mUudEjPMq9cSVbgQBuX91IQKXcbVlJV4w==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr5854773wro.214.1532710607562;
        Fri, 27 Jul 2018 09:56:47 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id u185-v6sm5528184wmg.25.2018.07.27.09.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:56:46 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH 3/4] x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
Date:   Fri, 27 Jul 2018 18:56:40 +0200
Message-Id: <1532710601-45449-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
References: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Add an option to specify which MMU root we want to free. This will
be used when nested and non-nested MMUs for L1 are split.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/mmu.c              | 9 +++++----
 arch/x86/kvm/vmx.c              | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7ae8ae58f3bd..7b157cd43e1f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1325,7 +1325,8 @@ static inline int __kvm_irq_line_state(unsigned long *irq_state,
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu);
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, ulong roots_to_free);
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			ulong roots_to_free);
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 			   struct x86_exception *exception);
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index b013aec73d46..1bcab6f9d1c8 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3435,11 +3435,11 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 }
 
 /* roots_to_free must be some combination of the KVM_MMU_ROOT_* flags */
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, ulong roots_to_free)
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			ulong roots_to_free)
 {
 	int i;
 	LIST_HEAD(invalid_list);
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	bool free_active_root = roots_to_free & KVM_MMU_ROOT_CURRENT;
 
 	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
@@ -4154,7 +4154,8 @@ static void __kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 			      bool skip_tlb_flush)
 {
 	if (!fast_cr3_switch(vcpu, new_cr3, new_role, skip_tlb_flush))
-		kvm_mmu_free_roots(vcpu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu,
+				   KVM_MMU_ROOT_CURRENT);
 }
 
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush)
@@ -4936,7 +4937,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
 	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3ee8137b2026..362842f9b523 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8893,7 +8893,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 			    == operand.pcid)
 				roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 
-		kvm_mmu_free_roots(vcpu, roots_to_free);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, roots_to_free);
 		/*
 		 * If neither the current cr3 nor any of the prev_roots use the
 		 * given PCID, then nothing needs to be done here because a
-- 
1.8.3.1


