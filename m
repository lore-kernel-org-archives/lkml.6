Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1CE2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PznYXpvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfBVPIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:08:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36172 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBVPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:08:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so1264520pgr.3;
        Fri, 22 Feb 2019 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVxlZFChzcu/dkacrPFuzjRF0sXgSsUwCMtQVWsGYlg=;
        b=PznYXpvGCO68k9QVt3qis5juY+CVNNbXgnIeN6SY6IngMsoddi2kJvgtRpLBVYQIcr
         yEs6InKfbX0bIp5BRpb+NdWEnDsyOFx7HW6yz4zCE5NXgGgGq8Nlfdj7/vs5yhalazeG
         MUUypP+hRSGub06ruY2RwkeWbikEbD9YP/B2qM7THMpZgZhvuMYCW0kpw2njdzJbS5/G
         LhWR6rSOnY+YHr3jJrMmvpkpe4M89V4O1HWnIzOyp3NVWrLxsZu16RctGRxjx7gbU2un
         FmJM9sXAgWlrIZ24M4uWnLvWSHR3psnH9YfpWyHn3agthzF34qcQ4u1iYA0DJH1fH20/
         vKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVxlZFChzcu/dkacrPFuzjRF0sXgSsUwCMtQVWsGYlg=;
        b=VDLgWQM+JTHAA6wsVJjgXKO5RhTB7va4BQYa+9bxEcgBoXNf08zw+vSCZOq8pmWUn4
         gtvuHnAW0Nf/7rLGhTmwLdyRb1jdwSj2ErhBesbBF5kXuv9q0HFsCbzZSgHRJC/iF6eO
         78bEe+46oiC90rmzf8jRIJ2gG1sGrHORx83qK+ldNb/yDkVidm9LS8StsU8AdzzwW/7U
         eF9ztvaHtRteTpONxSgg+2T4JkovAOT/RSzAKNaHNEu7EU3AdeqvNYRSSxpc+5lOLSAU
         McmrJjyEyf9S2UI9wwr6r8Szpeasz/FGLUj1GzN8HN3gstraviJNuOu6UGXHKeN8ghd+
         owZg==
X-Gm-Message-State: AHQUAubudbeTrBprxrxSBbFAjnMIuqDVqzkUac/tAigEK7bhEuAGVcCU
        SdUuZVQr70y+bB+dB8Q1YDo=
X-Google-Smtp-Source: AHgI3IY/RLgYg9eGFQxBXd6FiXsKe9UxiF+9IQzvCsmFdyZA6oCgbCV2Hm8Ti21beg+rhsZQbs7vfg==
X-Received: by 2002:a62:ab04:: with SMTP id p4mr4681564pff.142.1550848086797;
        Fri, 22 Feb 2019 07:08:06 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:08:06 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH V3 10/10] KVM/MMU: Add last_level flag in the struct mmu_spte_page
Date:   Fri, 22 Feb 2019 23:06:37 +0800
Message-Id: <20190222150637.2337-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

When build tlb range flush list, just add leaf node into flush list in order
to avoid overlap of address range in the list. If parent node and leaf node
are added into flush list, parent node's address range will cover leaf node's.
Otherwise, not all leaf nodes of the parent are actually allocated when flush
tlb. The side affect is that flush list would be overflow and go back to
non-range tlb flush if redundant address ranges was too many. This patch is
to add last_level flag in the struct kvm_mmu_page and set the flag to be true
in the set_spte() and clear the flag when the child node is allocated.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
	- Always set last_level flag to be true in the set_spte().
	- Clear last_level flag when assign child node.
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e8bd78940c4..1a0a381c442d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -327,6 +327,7 @@ struct kvm_mmu_page {
 	struct hlist_node hash_link;
 	bool unsync;
 	bool mmio_cached;
+	bool last_level;
 
 	/*
 	 * The following two entries are used to key the shadow page in the
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 2e13aac28293..f5a33cf71d73 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2754,6 +2754,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 */
 	if (kvm_available_flush_tlb_with_range()) {
 		list_for_each_entry(sp, invalid_list, link)
+			if (sp->last_level)
 				hlist_add_head(&sp->flush_link, &flush_list);
 
 		kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
@@ -2956,6 +2957,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	if (level > PT_PAGE_TABLE_LEVEL)
 		spte |= PT_PAGE_SIZE_MASK;
+
 	if (tdp_enabled)
 		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
 			kvm_is_mmio_pfn(pfn));
@@ -3010,6 +3012,8 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	if (speculative)
 		spte = mark_spte_for_access_track(spte);
 
+	sp->last_level = true;
+
 set_pte:
 	if (mmu_spte_update(sptep, spte))
 		ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
@@ -3200,6 +3204,10 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 					      iterator.level - 1, 1, ACC_ALL);
 
 			link_shadow_page(vcpu, iterator.sptep, sp);
+
+			sp = page_header(__pa(iterator.sptep));
+			if (sp->last_level)
+				sp->last_level = false;
 		}
 	}
 	return emulate;
-- 
2.14.4

