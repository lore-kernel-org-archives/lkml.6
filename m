Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C39C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B3421872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIGZ66sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfADIyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:54:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47003 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfADIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:54:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so17983620pfe.13;
        Fri, 04 Jan 2019 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
        b=uIGZ66sWc3MSyPixVlFIwqq9X9Xawe/7lcCM/24F9OUU1MhgIXXEp+AbmzflEK13nM
         2o+Z7uoAl1u/wmPUG3KdiBwSgFXXPl4EIy5LvDsMJPUd2xQxtWZR+TAhyRkwglbNz5am
         o/KasvYoE5o7W/xDHeUq9nW1U+hq6D2rEmY+fBsBoq/f34Ew+f9isuerC2+UXmqf/7xW
         VEHXij5Tmwcu8CH5Sve62zd3WlvJk2e1xqpMBDePH5ZEkitNlq/TWfWZEQBZXcHzrVop
         sJBt1UN3Ju9tBhxkEk4LYvpZdCJEK2L7xGpWi4h9Qu/xiaccyXt/cvhCySXdqM36T05O
         eX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DbPYODlBh2cswgOkm5n3Xtx1VG29YKWZuHO2kRQx3jE=;
        b=l8s7Cj5BLYVnFE6FhK2apEawje3HBY9Vd8LC98DlyZndxVR8+3tPGbBgW8/0CRu6QC
         PK4rA+uj2qp9BISciFoQ+Far1e/GPgpDz7hZJDuI4to4vH5zPHkEJvIF2YQIKuuOwLUk
         el8wWhAFhLViNiwV4nXtQ/P9VofXNREN9sKQTRQ8kj6+6xkQZx7FOyxsYyJ9LcBOepAF
         sEBlzuqHbSRD6XarZQPE7Mb+DXUIhPuVC0+E9MAmaKWFQ13xt+xe3cnOqaBXQkoFKMxS
         ufDciJq5tzG1I7uXQacySLxEYJ92WczZG2Nyb5B3CmdK2hXktjdmS/5PduqS7dUCHBpF
         c0YA==
X-Gm-Message-State: AA+aEWZPD7o3G44AzcB2cWnlHRV8ZWqraoCbnUi+lq/70phv1Wkkfc0D
        xMFLIa0KkninVv4KSCoUp4c=
X-Google-Smtp-Source: ALg8bN4wIfpC3j2afh4wGFjYegQADeZ0K/ccHcj0qIsaA3H5W5N7IpT4CBOOzO8AUje2LUSMO2pDwg==
X-Received: by 2002:a62:1992:: with SMTP id 140mr51523150pfz.33.1546592089991;
        Fri, 04 Jan 2019 00:54:49 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:49 -0800 (PST)
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
Subject: [PATCH 4/11] KVM/MMU: Introduce tlb flush with range list
Date:   Fri,  4 Jan 2019 16:53:58 +0800
Message-Id: <20190104085405.40356-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/mmu.c              | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 78d2a6714c3b..22dbaa8fba32 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -316,6 +316,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct list_head flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 
@@ -443,6 +449,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct list_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 068694fa2371..d3272c5066ea 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,17 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2708,6 +2719,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2733,17 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->sptep && is_last_spte(*sp->sptep,
+			    sp->role.level))
+				list_add(&sp->flush_link, &flush_list);
+
+		if (!list_empty(&flush_list))
+			kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4

