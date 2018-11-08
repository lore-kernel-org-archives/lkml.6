Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076A3ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DCE2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSRs6ysz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DCE2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeKIAXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:23:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbeKIAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:23:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so7070137pgp.7;
        Thu, 08 Nov 2018 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j64bsuj3x4K+30VilhvqfE2jLibklRus8fQn4GALxqw=;
        b=kSRs6yszY4IfNoC8OPqCy4ksjyyfO8vPsN92AYgcgXtqlwYrp7W9CsBb2pFWYCOWYT
         hzLAcMLmlTe+72KX5oE2NnIPaiws0ZyzwJ1rivC0GnmGbAZX9qFQcKu7IRKTTa5fcNt7
         AntjL+6k2KUftFi1oRrs1ffyS4sDX3FeUL6voPxTS87oBXQHQsw9+BohJqmSGOD0u38j
         wxTVXVp6bSM0RFLXlLNxSCfv+y2byQousc+mACuHCor4/2CnpmJGhCYH2YpOgjKjrhJ5
         W3G1FjZFxRVZeNqXFC1H1e5VsjKK0ew0oJJ2igzrk6MVip4mlHEpR0D+IwRk8W/isF9o
         qR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j64bsuj3x4K+30VilhvqfE2jLibklRus8fQn4GALxqw=;
        b=hpsq9bE20VGHBYJpVn5CX5lpZ6OHGaRbtNviFzPvdObCaVGbRPzNQcAiTtbg30hlXU
         f+MBqKL5YqLjxOSvDgP1WzMBGhK8rPyBkWF9SxJniwCAXCslemv4JbYGz9Aif1wL0tgo
         xancFXy6ArewRXGQ2fqhi3Y97u2N2a1wGZ7byssPpqmSgMPXu3+NV+JYYIRFTNYb9W9W
         1X/4dBuPZJF3uxT8gSjGUvCEtoJCFRDQKmrEjpTDXX8gj7lEGsn5GT/bLCXiN4cXe1II
         pMRA4X2ACD3bWG6SpJzs4ahoG/k51morud79S/SQEtQvERbhBME8U1iTy8SjPCkv6Kvn
         kHwg==
X-Gm-Message-State: AGRZ1gLtVty/RkYLzzmQe/E3wBH0zBfEleS2e3np0E2MHRQ+5LI263qU
        VnaIpETasxv/E51gf1zPNlQ=
X-Google-Smtp-Source: AJdET5f41UCbLn034dxs1ngicJBuoodp6p58X0q0RKH54NooSvsVOJCzcR34aj+o0PpgSKVU2xXoug==
X-Received: by 2002:a63:1766:: with SMTP id 38mr2232968pgx.299.1541688442907;
        Thu, 08 Nov 2018 06:47:22 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:22 -0800 (PST)
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
Date:   Thu,  8 Nov 2018 22:46:34 +0800
Message-Id: <20181108144639.11206-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
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
index cf5f572f2305..c1d383532066 100644
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
@@ -5680,7 +5709,13 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
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

