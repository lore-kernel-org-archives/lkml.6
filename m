Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB4C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4k8kWqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfBVPH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36712 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfBVPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so1249273pfa.3;
        Fri, 22 Feb 2019 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LVnFcEV2pWoiwgVavI/ch+4i9GwRN+tEZyplLfQBPa0=;
        b=H4k8kWqz6jPKuEJHTcUbBZdPsfs7tkggWXoTwXqIWuFUe7Mvfo/wTTE5Q9NHeVQbml
         lPmNTT3epvU/vgMYl+q+dhH2XXEsVTY1TEhG5YjJfuocvpXijMKpMniAQ8iaHSjFh41E
         p4CHcQBGun7BJU+4tfwpT4sTLsHOi+OO0VaTMHwRRLaB5festO2s7SnHEvmCcTy1cEna
         h/vCQ3AlyYVkiYc4EEuu+rWhInE0gMhiy0O2F98YpIG16jX1n0Oxc7uVQ4d/KOr00auu
         0go0VRYZuzXd2VjCAlcGzeXsNbout+iHl2DJiVLMc9dMpVHtMNEQaL/p6zRcc798YY7Q
         06+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LVnFcEV2pWoiwgVavI/ch+4i9GwRN+tEZyplLfQBPa0=;
        b=gtOdwm1na2/wk8AlK0ktcYCFu+KqPn9b87A8RZ6mOxBV9/za0MH7yk4842PNEIueEF
         /rAvmIhWwlmg1zmDDmbiXnOIAKIl9ej2S3xDeJxuUk6Eq5tba1qvNUImqiDdaaZndrz2
         GqRST26nu2T98ru5+bqEkeLrhZdVa1bQ3CHw2wdfmqOM+2fjhmgliy5ixlNGXGSWThAZ
         fR+8vUydrV14vo4QGhfE9CFbSdmcChVHR8SNRH4nqLEmZqEcFr90j0F8u33r3ys7PF9P
         9IbGnLec4gW/ZcMtfq2gTi/jTAFzRZRsWWc9Ycebj6DH6F67izGguX/lK7nNTUVZdeYi
         hVog==
X-Gm-Message-State: AHQUAubwuIwzxkqO1p/HlU9Juz/NZfiVUMOVGat4ZZu3GanVtxMmezPu
        XPOSSLzcwIEHFoF5I3jVYe0=
X-Google-Smtp-Source: AHgI3IYqBXlJDaXSazEwDskVI0HQ/LJilvkyY1Uy/S0q2jWKhQfI+jCpqNm6a3m6w33eNLuKr3ZZLg==
X-Received: by 2002:a63:2d43:: with SMTP id t64mr4356301pgt.155.1550848077851;
        Fri, 22 Feb 2019 07:07:57 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:57 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 8/10] KVM: Add flush parameter for kvm_age_hva()
Date:   Fri, 22 Feb 2019 23:06:35 +0800
Message-Id: <20190222150637.2337-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add flush parameter for kvm_aga_hva() and move tlb
flush from kvm_mmu_notifier_clear_flush_young() to kvm_age_hva().
kvm_age_hva() can check whether tlb flush is necessary when
return value young is more than 0. Flush tlb if both conditions
are met.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/arm/include/asm/kvm_host.h     |  3 ++-
 arch/arm64/include/asm/kvm_host.h   |  3 ++-
 arch/mips/include/asm/kvm_host.h    |  3 ++-
 arch/mips/kvm/mmu.c                 | 11 +++++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           | 10 ++++++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/include/asm/kvm_host.h     |  3 ++-
 arch/x86/kvm/mmu.c                  | 10 ++++++++--
 virt/kvm/arm/mmu.c                  | 13 +++++++++++--
 virt/kvm/kvm_main.c                 |  6 ++----
 11 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ca56537b61bc..b3c6a6db8173 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -229,7 +229,8 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
 int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 7732d0ba4e60..182bbb2de60a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -361,7 +361,8 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 41204a49cf95..4eff221853d6 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -937,7 +937,8 @@ enum kvm_mips_fault_result kvm_trap_emul_gva_fault(struct kvm_vcpu *vcpu,
 int kvm_unmap_hva_range(struct kvm *kvm,
 			unsigned long start, unsigned long end);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
 /* Emulation */
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97e538a8c1be..288a22d70cf8 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -579,9 +579,16 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gfn_t gfn, gfn_t gfn_end,
 	return pte_young(*gpa_pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+	int young = handle_hva_to_gpa(kvm, start, end,
+			kvm_age_hva_handler, NULL);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 19693b8add93..c8043f1ac672 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -70,7 +70,8 @@
 
 extern int kvm_unmap_hva_range(struct kvm *kvm,
 			       unsigned long start, unsigned long end);
-extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+extern int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		       bool flush);
 extern int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 extern int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index bd1a677dd9e4..09a67ebbde8a 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -841,9 +841,15 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm->arch.kvm_ops->unmap_hva_range(kvm, start, end);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return kvm->arch.kvm_ops->age_hva(kvm, start, end);
+	int young = kvm->arch.kvm_ops->age_hva(kvm, start, end);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c3f312b2bcb3..e2f6c23ec39a 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -745,7 +745,8 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 	return 0;
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
 	/* XXX could be more clever ;) */
 	return 0;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9fc9dd0c92cb..3e8bd78940c4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1514,7 +1514,8 @@ asmlinkage void kvm_spurious_fault(void);
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end);
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_cpu_has_injectable_intr(struct kvm_vcpu *v);
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index e9a727aad603..295833dafc59 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1988,9 +1988,15 @@ static void rmap_recycle(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
 			KVM_PAGES_PER_HPAGE(sp->role.level));
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
-	return kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
+	int young = kvm_handle_hva_range(kvm, start, end, 0, kvm_age_rmapp);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e0355e0f8712..e6ccaa5d58b8 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2107,12 +2107,21 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
 		return pte_young(*pte);
 }
 
-int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
+int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end,
+		bool flush)
 {
+	int young;
+
 	if (!kvm->arch.pgd)
 		return 0;
 	trace_kvm_age_hva(start, end);
-	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+
+	young = handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
+
+	if (flush && young > 0)
+		kvm_flush_remote_tlbs(kvm);
+
+	return young;
 }
 
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 61ddc3f0425c..90ef8191cb4c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -433,9 +433,7 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 
-	young = kvm_age_hva(kvm, start, end);
-	if (young)
-		kvm_flush_remote_tlbs(kvm);
+	young = kvm_age_hva(kvm, start, end, true);
 
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -466,7 +464,7 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 	 * cadence. If we find this inaccurate, we might come up with a
 	 * more sophisticated heuristic later.
 	 */
-	young = kvm_age_hva(kvm, start, end);
+	young = kvm_age_hva(kvm, start, end, false);
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 
-- 
2.14.4

