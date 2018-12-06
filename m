Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10781C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFC720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpWEhwSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFC720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeLFNWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:22:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42909 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbeLFNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:22:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so163889plp.9;
        Thu, 06 Dec 2018 05:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7wJrNLh7b9Kd4SriInF8r4G9i9Dx2Oc7R9d0sGuuCyk=;
        b=BpWEhwSrGQIzwdd2nJOroIZ8jrNcA2e97/TsljMoQ0q5x2ka34srFoJ5siBfmD06yV
         /q/m6W2wZOVS7/Duk6yKbsg6D/TrZPiq1F/wgidy+KIMsYR95Tvx+ugPml/kbbp+EWrI
         GQ4j9Y4iDW6KoWH5cD1lNaDAfN13fMTZiG2simrlqEPrqGrC0SKFQuzsV+MLJE/O195F
         lrSW/fJplell0VpZc/AgyYq2gTs7n4rdofjRK3tHTjbYRv5d78qGFurY/cDMSU2zD2so
         bZBsKJOBQmWuecPWlw+0AChokyB4VwyhAOLGEpt++2RF4raSq4QHeySfHM8KGF7ZH/HL
         FQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7wJrNLh7b9Kd4SriInF8r4G9i9Dx2Oc7R9d0sGuuCyk=;
        b=WfcanKzk1Woir511i7RAGItlgD07RBTqb846HleLgTr759jCBsD4tfrB6v26g9G2DP
         k5f2etaS1ICLRFrpT9QiCF/GBSs6IStpzlaCgcPrq1L5BdoYKI941f8z4yNeXhpM7sIw
         aF5/jjI2EX48upDoBlHPOOqVXluy0qLdWI9PmAetrq4Ai4MBS6DJOQGOcEh53+XdhB2Y
         TggW2L+vQJ/8NVAxS5vNi4rmlQuL0GIaNdUvfMBzlM05VvwGLhOWuggxiHL6Kg0bWmBV
         MEF/PDMpfFYeJeFY0FIa83/YNtbncl/I/VYIILEXW9WC5ruW95gIDgRrM3h3SdALpxY2
         UpNA==
X-Gm-Message-State: AA+aEWbY2JAk4jlsPyzvOQg8B8IA4x4Z8QLmaZbGxVeJEE1JE+YiPi9H
        ilvVLGasypMuLkGsQ/D285c=
X-Google-Smtp-Source: AFSGD/Ua/7/KRXozbL463rjBpxtbtx/wHbXTVeIBAw41IrMQTdAxwXDkNyEwHC+R/vOWP0iaP9fPww==
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr16631840plb.311.1544102526106;
        Thu, 06 Dec 2018 05:22:06 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:22:05 -0800 (PST)
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
Subject: [Resend PATCH V5 5/10] KVM/MMU: Add tlb flush with range helper function
Date:   Thu,  6 Dec 2018 21:21:08 +0800
Message-Id: <20181206132113.2691-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback and flush tlb directly in kvm_mmu_zap_collapsible_spte().
kvm_mmu_zap_collapsible_spte() returns flush request to the
slot_handle_leaf() and the latter does flush on demand. When
range flush is available, make kvm_mmu_zap_collapsible_spte()
to flush tlb with range directly to avoid returning range back
to slot_handle_leaf().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since V4:
       Remove flush list interface and flush tlb directly in
       kvm_mmu_zap_collapsible_spte().
Change since V3:
       Remove code of updating "tlbs_dirty"
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7c03c0f35444..74df957f2f81 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,6 +264,35 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
+
+static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
+{
+	int ret = -ENOTSUPP;
+
+	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
+		ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+
+	if (ret)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn = start_gfn;
+	range.pages = pages;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) != mmio_value);
@@ -5671,7 +5700,13 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 			!kvm_is_reserved_pfn(pfn) &&
 			PageTransCompoundMap(pfn_to_page(pfn))) {
 			pte_list_remove(rmap_head, sptep);
-			need_tlb_flush = 1;
+
+			if (kvm_available_flush_tlb_with_range())
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+					KVM_PAGES_PER_HPAGE(sp->role.level));
+			else
+				need_tlb_flush = 1;
+
 			goto restart;
 		}
 	}
-- 
2.14.4

