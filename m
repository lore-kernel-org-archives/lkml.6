Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6E92089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFt6wOYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6E92089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeKIAX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:23:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38532 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIAX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:23:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so7254909plo.5;
        Thu, 08 Nov 2018 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThaSwZ572Bc+iDx3PSfcxd/KOVRJ23+altm/BHk2CrY=;
        b=pFt6wOYO7hPFAnTLOffrFOlVA0u9uwgSoa4LnO/ypnQrIs5QdLLOJ2EFK5GpqC7ZHr
         oFASJCHnEQFSnDdc//tjFD7o8Z0/yepO8SmJiv5iBVaKGOTVvg68BYziorwIxwHTCy36
         DQNYn5+Gs5hRG4nIK3KVofQS0zLEKWjofhgRvvxH0vxW/WErYdGOuGiz4+b9xC5+Tdcx
         aj/OPsy4Z2buCNE5sdu+7MlJSlibpTvzYi4Fpta1QUWBKKfDO2wg0iUo9PVbaUugxEwG
         EWZnn3+kWzBfOj8Fb7z+yHHVSc8DNr8sgxDXCsvNBoMgQNKLFgnXhiTddR7xkVNAHgj3
         Bh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThaSwZ572Bc+iDx3PSfcxd/KOVRJ23+altm/BHk2CrY=;
        b=WFkc7sn+y+w8XS1ewqKZdS1igOBKvFvU8eHGVHW4RTXzkRqeyR0ZP4yloN9eGjMi32
         ep6+VX9DJR4VWgYgU8Bd8EC6F7K75SMq1N0zsyJDsuiW4DvH+LnNe1yQhA3x5Fo53H5b
         fbpBlLAmq0M7b1wU471lRvfEXqnJvrNxM3KXvab3irag9PfacB1M/tGfq8D4UsqgB5oM
         0JJsM6z0zjQUWdxdeVhTl0SQI+sV2P/d1WOgFPbhyw9Tv632ZBl1D3dFmyCtszZJ2IpO
         sXXflcrZU0G2ip+RfV3w3iYFhrgBPEO8ZwFxCmcNt/XtNf277nthlK2RWSnD7A9RS09P
         JfEg==
X-Gm-Message-State: AGRZ1gJFXfuOIQc/mKFCg5x82G9QnN+fhR9r92kvtWdzuhcuzbOUvtIA
        96Foh0Kj6JloTJm5FNtN6mhNBxR5aDo=
X-Google-Smtp-Source: AJdET5fMfdtRcxNIYLHN1+UfpcsHVshw3zXsoT7PDdQhJ1jGUsIwXZt4Pg/dqL1M3iD075Fqf9AMGA==
X-Received: by 2002:a17:902:b70c:: with SMTP id d12-v6mr4900674pls.288.1541688457911;
        Thu, 08 Nov 2018 06:47:37 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:37 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 7/10] KVM: Make kvm_set_spte_hva() return int
Date:   Thu,  8 Nov 2018 22:46:36 +0800
Message-Id: <20181108144639.11206-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The patch is to make kvm_set_spte_hva() return int and caller can
check return value to determine flush tlb or not.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     | 2 +-
 arch/arm64/include/asm/kvm_host.h   | 2 +-
 arch/mips/include/asm/kvm_host.h    | 2 +-
 arch/mips/kvm/mmu.c                 | 3 ++-
 arch/powerpc/include/asm/kvm_host.h | 2 +-
 arch/powerpc/kvm/book3s.c           | 3 ++-
 arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
 arch/x86/include/asm/kvm_host.h     | 2 +-
 arch/x86/kvm/mmu.c                  | 3 ++-
 virt/kvm/arm/mmu.c                  | 6 ++++--
 10 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 5ca5d9af0c26..fb62b500e590 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -225,7 +225,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 52fbc823ff8c..b3df7b38ba7d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -360,7 +360,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2c1c53d12179..71c3f21d80d5 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -933,7 +933,7 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d8dcdb350405..97e538a8c1be 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -551,7 +551,7 @@ static int kvm_set_spte_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	       (pte_dirty(old_pte) && !pte_dirty(hva_pte));
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	int ret;
@@ -559,6 +559,7 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	ret = handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &pte);
 	if (ret)
 		kvm_mips_callbacks->flush_shadow_all(kvm);
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fac6f631ed29..ab23379c53a9 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -72,7 +72,7 @@ extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
 extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-extern void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 #define HPTEG_CACHE_NUM			(1 << 15)
 #define HPTEG_HASH_BITS_PTE		13
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index fd9893bc7aa1..437613bb609a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -850,9 +850,10 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return kvm->arch.kvm_ops->test_age_hva(kvm, hva);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm->arch.kvm_ops->set_spte_hva(kvm, hva, pte);
+	return 0;
 }
 
 void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 8f2985e46f6f..c3f312b2bcb3 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -757,10 +757,11 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 	return 0;
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	/* The page will get remapped properly on its next fault */
 	kvm_unmap_hva(kvm, hva);
+	return 0;
 }
 
 /*****************************************/
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c8a65f0a7107..1cab3c15944f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1509,7 +1509,7 @@ asmlinkage void kvm_spurious_fault(void);
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
 int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index af3e9e466014..06bfcd327ef6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1913,9 +1913,10 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm_handle_hva_range(kvm, start, end, 0, kvm_unmap_rmapp);
 }
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
+	return 0;
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48bdb1a6..b8b20c033fcf 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1849,14 +1849,14 @@ static int kvm_set_spte_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data
 }
 
 
-void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
+int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
 	unsigned long end = hva + PAGE_SIZE;
 	kvm_pfn_t pfn = pte_pfn(pte);
 	pte_t stage2_pte;
 
 	if (!kvm->arch.pgd)
-		return;
+		return 0;
 
 	trace_kvm_set_spte_hva(hva);
 
@@ -1867,6 +1867,8 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	clean_dcache_guest_page(pfn, PAGE_SIZE);
 	stage2_pte = pfn_pte(pfn, PAGE_S2);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
+
+	return 0;
 }
 
 static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
-- 
2.14.4

