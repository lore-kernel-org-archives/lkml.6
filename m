Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32440C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ABE205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7aMZYhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ABE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJMWcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37322 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so7170022pgq.4;
        Sat, 13 Oct 2018 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEtGioVQnwjoy8CvMEOGuifAVgR2MythhiJN5MZX70o=;
        b=p7aMZYhWwo0/507UqW9FC6KUcsuuKvXkkEif3ZXk2oec/QIt/QroYMy7XuUZ+DlZrX
         qTDjckaxO1up1hvYEl+TJJJtgDBzL9JZ8bAlD4qVZ4jNWxnaxuQfA53x4SindwhDZWto
         +AJFI+bUBhjZlR5HWeB2BDVBt1bA2u5dZJ4dCaPvPIZYE4HRV1o6bP3CDSTRnD8VaEiQ
         tQTD9p5AsnWvRwBDS4u7aByKNwlbtNmvc3s8cI+xan2mzxuPv0kUPqv5lzrTEGnchgaO
         /uq6/VCCBsIhbupDjmtkpWe7po6q/iBoai9tIT7rWkfOcFrcTsfrtKPtIOLK5UNThsqu
         6xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEtGioVQnwjoy8CvMEOGuifAVgR2MythhiJN5MZX70o=;
        b=deLCuLVgtyMit5aL5Q4M0jNo0hDFPwHpm1WpF6ivQO/rxV4yqDlsCuqlixIyDU80S4
         l91Oy8qALyBebdREq2Tfyac/BRvNSf6T5UMSJxycSKNTwyPrGvNSLMcwDDGxPeZUMQqS
         CHG2wxnBh+JhcZ4xG1eV8Jz3O1cN+Id/gGb5vUg0mQlIOyqVvyZdWDPBZZypESI58A1L
         ryh200s6tHLiYFEDWiAJklxEP2TOcsRPh11gluqTrKkQj6oNdVYc0JHzo7K35NRN+bOw
         R34H10FyrdWOkSgNMINlNsOH9gNamWLF9jKk/Hi83C0LtIrdHJLNVdJWXk4aKxE63Hht
         V8JQ==
X-Gm-Message-State: ABuFfoh4W+ifUrl4Vlt3Dpn6Wib4wz+ffWOJjF5q48WgvvgF4EZq5Giz
        XKjiG1Nws+dVmrDywe88XQc=
X-Google-Smtp-Source: ACcGV62b2xGnF8XhJgk4wk8jovL7sAE2sxrOQ6PaGnUqb7f5lJEo26JGltHJ9tY23hFXn3ReJexGAA==
X-Received: by 2002:a63:7c5e:: with SMTP id l30-v6mr9438836pgn.45.1539442526347;
        Sat, 13 Oct 2018 07:55:26 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:25 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 11/15] KVM/MMU: Replace tlb flush function with range list flush function
Date:   Sat, 13 Oct 2018 22:54:02 +0800
Message-Id: <20181013145406.4911-12-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to use range list flush function in the
mmu_sync_children(), kvm_mmu_commit_zap_page() and
FNAME(sync_page)().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c         | 26 +++++++++++++++++++++++---
 arch/x86/kvm/paging_tmpl.h |  5 ++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 393f4048dd7a..69e4cff1115d 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1100,6 +1100,13 @@ static void update_gfn_disallow_lpage_count(struct kvm_memory_slot *slot,
 	}
 }
 
+static void kvm_mmu_queue_flush_request(struct kvm_mmu_page *sp,
+		struct list_head *flush_list)
+{
+	if (sp->sptep && is_last_spte(*sp->sptep, sp->role.level))
+		list_add(&sp->flush_link, flush_list);
+}
+
 void kvm_mmu_gfn_disallow_lpage(struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	update_gfn_disallow_lpage_count(slot, gfn, 1);
@@ -2372,12 +2379,16 @@ static void mmu_sync_children(struct kvm_vcpu *vcpu,
 
 	while (mmu_unsync_walk(parent, &pages)) {
 		bool protected = false;
+		LIST_HEAD(flush_list);
 
-		for_each_sp(pages, sp, parents, i)
+		for_each_sp(pages, sp, parents, i) {
 			protected |= rmap_write_protect(vcpu, sp->gfn);
+			kvm_mmu_queue_flush_request(sp, &flush_list);
+		}
 
 		if (protected) {
-			kvm_flush_remote_tlbs(vcpu->kvm);
+			kvm_flush_remote_tlbs_with_list(vcpu->kvm,
+					&flush_list);
 			flush = false;
 		}
 
@@ -2713,6 +2724,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	LIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2726,7 +2738,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			kvm_mmu_queue_flush_request(sp, &flush_list);
+
+		if (!list_empty(&flush_list))
+			kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 833e8855bbc9..e44737ce6bad 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -973,6 +973,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	bool host_writable;
 	gpa_t first_pte_gpa;
 	int set_spte_ret = 0;
+	LIST_HEAD(flush_list);
 
 	/* direct kvm_mmu_page can not be unsync. */
 	BUG_ON(sp->role.direct);
@@ -1033,10 +1034,12 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 					 pte_access, PT_PAGE_TABLE_LEVEL,
 					 gfn, spte_to_pfn(sp->spt[i]),
 					 true, false, host_writable);
+		if (set_spte_ret && kvm_available_flush_tlb_with_range())
+			kvm_mmu_queue_flush_request(sp, &flush_list);
 	}
 
 	if (set_spte_ret & SET_SPTE_NEED_REMOTE_TLB_FLUSH)
-		kvm_flush_remote_tlbs(vcpu->kvm);
+		kvm_flush_remote_tlbs_with_list(vcpu->kvm, &flush_list);
 
 	return nr_present;
 }
-- 
2.14.4

