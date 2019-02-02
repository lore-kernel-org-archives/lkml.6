Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD5C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E002075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mETogsVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfBBBju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBBBjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3740103pgc.12;
        Fri, 01 Feb 2019 17:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0G5pUHhnRBECCI0xPIkQW74M8CRHN4x4Ep3m3tfVSg=;
        b=mETogsVpxhVfhsOmA0sb7uEV04lG52SniOT1AfmMw+0E+0y28BA+Nm2A13q1U/AIBf
         Rr21t1bTIOof/r1LaemaW+I+UzY6O/fgq9Iarhivf5oKCqcoaucWRahA0uGqb5l9h9FX
         gSrimShMJDyZd3Bx4H+UrqD4Ul2hZs53V++PPb+imTnEhAKo/FNhdQkxCDf8vO2nlswN
         CQMUIDmcqqsWZS+v7Jig+7d3Jhaq6JSuG5d5OEeyYSNC3G3eXaMQ4D8qslLyAB4+aV6V
         zvdT2zXWWPwfEY4BQMcJHh9qanl0OJiySvAfhPD21IlmfxwFy2DVfQKuWHZ8PzCF4/S6
         +LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0G5pUHhnRBECCI0xPIkQW74M8CRHN4x4Ep3m3tfVSg=;
        b=YVheg6Lxq+1wrMV2/MZ+c0iFLB9pv4WYTenXskEpZNlNDwkjQuk5je8nkDH+RcSwcm
         iX2PW/QZHXenUkHojqRDj7HV3r1G+STz8bsucBrtJl1WOmt4nCZkWHbiyB9/cDkXRJhe
         eluFadd9RZZXTuLLJQiQb6wFg+FpjzDBOjRqQrowGqhTsEw+Ho77Xka7szd2DVT5vn3a
         J/h1Pp4kXnpjr69jgCyFzjE7LIrOSX2uW2F442WYw5wgQrSdh55elXpA35KFUTYRQrw1
         cO7WV1JcsnagpE6kweBriyhvQnsLHyOd8Xk3bBwX1SYTPOEW96o/tdSz4zyXZ/m2wZG7
         SKkg==
X-Gm-Message-State: AHQUAuYSVA3q0cMywZ4xkJCds4oH1I1KUD90WUc6j1rSvymW0OyxdcTu
        U6wF0CIwjy4xQylHbYn/xBk=
X-Google-Smtp-Source: AHgI3Iavh6/FqGMJR291IjbA0/Gk6zaWfaqjhYnIWMWgId13SG1KABXFEz08oX/WVS+zNawI0z8Azg==
X-Received: by 2002:a62:e012:: with SMTP id f18mr9115403pfh.119.1549071588175;
        Fri, 01 Feb 2019 17:39:48 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:47 -0800 (PST)
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
Subject: [PATCH V2 8/10] KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
Date:   Sat,  2 Feb 2019 09:38:24 +0800
Message-Id: <20190202013825.51261-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to use tlb range flush to flush memslot's in the
kvm_vm_ioctl_get/clear_dirty_log() instead of flushing tlbs
of entire ept page table when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c |  8 +-------
 arch/x86/kvm/mmu.h |  7 +++++++
 arch/x86/kvm/x86.c | 16 ++++++++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 6b5e9bed6665..63b3e36530e3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,12 +264,6 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
-
-static inline bool kvm_available_flush_tlb_with_range(void)
-{
-	return kvm_x86_ops->tlb_remote_flush_with_range;
-}
-
 static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range)
 {
@@ -282,7 +276,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 }
 
-static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 		u64 start_gfn, u64 pages)
 {
 	struct kvm_tlb_range range;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index c7b333147c4a..dddab78d8ed8 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -63,6 +63,13 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
+void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+				u64 start_gfn, u64 pages);
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
 
 static inline unsigned int kvm_mmu_available_pages(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d32b8f5728d..0f70e07abfa1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4445,9 +4445,13 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
@@ -4472,9 +4476,13 @@ int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm, struct kvm_clear_dirty_log *lo
 	 * kvm_mmu_slot_remove_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+	if (flush) {
+		struct kvm_memory_slot *memslot = kvm_get_memslot(kvm,
+				log->slot);
 
+		kvm_flush_remote_tlbs_with_address(kvm, memslot->base_gfn,
+				memslot->npages);
+	}
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
-- 
2.14.4

