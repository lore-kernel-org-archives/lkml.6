Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA459C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B97B20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="oZHFny5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B97B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLGMtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34945 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLGMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:48:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so4407358wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaEl9B+1fs5S3TQoH2KhHb3ZJ2VSYAnXotEb17ocZSY=;
        b=oZHFny5AgpoiZULh1yYM+egFIww1rygmpHkoXI+D0CcLC2JwJTaDD8Kt15Wxc3Hnc5
         akZDh9gmX8HWr85IUpkbDooPXlwkP0hliQVSWKyYuMlmn5jDu0hInPl2V8VHVbSZWB39
         YnIw+jyhFH6WfdspwyrTw/U3Iav5Y2Wp/BwzuP7oWdeUjX5IbE0M9a5dk7Oi86vehHAe
         WYxDMiflh3aHfmTHQhE0yvJixTt/u3MWRSc+U7py4TcLr3Yn7mDAIzkl4vl16+/uY8BV
         JP0ffub73j1l5ae3m+UgILHO+Ydwtk1uLI78OnYw1G2yp2ul8UFIt/E0s/+SBnrO6hye
         H9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaEl9B+1fs5S3TQoH2KhHb3ZJ2VSYAnXotEb17ocZSY=;
        b=dIFSxDs4IAQL2Y+F9lqIJBanixnVRvAbLTbZ+LmU8KXQwpqikfisqbF5oXOCdCCLom
         e/VwOg36DOTMkvo1Gz4yHdDCWT8i4rei4h47wFd4l0x4YJTgxg7poz7teA5q2mQnr6nv
         z/Iqw1U4nkhRoLC7m7liWLLLyJUOUZ/7bg3lA1wSAkWNTngjl4tf8yeUTIInj8Sf+gzY
         HsV3aH74RuvJnlbj2hXY05Uwr2gVrg6Gnpd30Qte5Wh1JhQsgETg1qzp9LkNH/h82cO0
         Uj7ksk/pfCS9VOUaGRSAQ85nI/gMOrueEOz4DGGY+crtYFvAar0E0l7zwuVNBLEaqhv+
         KmFg==
X-Gm-Message-State: AA+aEWY7Q/TFiiKfiotnFby97zmoheBzrnPw3V5rsXRKZUtELvKQEl3n
        Vk033iRE3nwsoNzgQM4wiVlczQ==
X-Google-Smtp-Source: AFSGD/V8u7Pc6TiTxTpXvK0xrD0lAvavKdeiWpCwIDXtVBtXh5+16jKAxEgR3z+pm3Jyx+3tIxjTLA==
X-Received: by 2002:a1c:848c:: with SMTP id g134mr1965101wmd.93.1544186937074;
        Fri, 07 Dec 2018 04:48:57 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:48:56 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH 02/10] KVM: X86: Add arbitrary data pointer in kvm memslot iterator functions
Date:   Fri,  7 Dec 2018 14:47:55 +0200
Message-Id: <20181207124803.10828-3-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help sharing data into the slot_level_handler callback. In my
case I need to a share a counter for the pages traversed to use it in some
bitmap. Being able to send arbitrary memory pointer into the
slot_level_handler callback made it easy.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 arch/x86/kvm/mmu.c | 65 ++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 7c03c0f354..b67d743c33 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1492,7 +1492,7 @@ static bool spte_write_protect(u64 *sptep, bool pt_protect)
 
 static bool __rmap_write_protect(struct kvm *kvm,
 				 struct kvm_rmap_head *rmap_head,
-				 bool pt_protect)
+				 bool pt_protect, void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1531,7 +1531,8 @@ static bool wrprot_ad_disabled_spte(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1557,7 +1558,8 @@ static bool spte_set_dirty(u64 *sptep)
 	return mmu_spte_update(sptep, spte);
 }
 
-static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1589,7 +1591,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		__rmap_write_protect(kvm, rmap_head, false, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1615,7 +1617,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_clear_dirty(kvm, rmap_head);
+		__rmap_clear_dirty(kvm, rmap_head, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1668,7 +1670,8 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 
 	for (i = PT_PAGE_TABLE_LEVEL; i <= PT_MAX_HUGEPAGE_LEVEL; ++i) {
 		rmap_head = __gfn_to_rmap(gfn, i, slot);
-		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
+		write_protected |= __rmap_write_protect(kvm, rmap_head, true,
+				NULL);
 	}
 
 	return write_protected;
@@ -1682,7 +1685,8 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn);
 }
 
-static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1702,7 +1706,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			   struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			   unsigned long data)
 {
-	return kvm_zap_rmapp(kvm, rmap_head);
+	return kvm_zap_rmapp(kvm, rmap_head, NULL);
 }
 
 static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -5514,13 +5518,15 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 }
 
 /* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
+typedef bool (*slot_level_handler) (struct kvm *kvm,
+		struct kvm_rmap_head *rmap_head, void *data);
 
 /* The caller should hold mmu-lock before calling this function. */
 static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
-			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
+			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb,
+			void *data)
 {
 	struct slot_rmap_walk_iterator iterator;
 	bool flush = false;
@@ -5528,7 +5534,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, data);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5550,36 +5556,36 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
-		  bool lock_flush_tlb)
+		  bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level_range(kvm, memslot, fn, start_level,
 			end_level, memslot->base_gfn,
 			memslot->base_gfn + memslot->npages - 1,
-			lock_flush_tlb);
+			lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
-		      slot_level_handler fn, bool lock_flush_tlb)
+		      slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
-				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
+				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
-			slot_level_handler fn, bool lock_flush_tlb)
+			slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL + 1,
-				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
+				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
-		 slot_level_handler fn, bool lock_flush_tlb)
+		 slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
-				 PT_PAGE_TABLE_LEVEL, lock_flush_tlb);
+				 PT_PAGE_TABLE_LEVEL, lock_flush_tlb, data);
 }
 
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
@@ -5601,7 +5607,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+						start, end - 1, true, NULL);
 		}
 	}
 
@@ -5609,9 +5615,10 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 }
 
 static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head)
+				    struct kvm_rmap_head *rmap_head,
+				    void *data)
 {
-	return __rmap_write_protect(kvm, rmap_head, false);
+	return __rmap_write_protect(kvm, rmap_head, false, data);
 }
 
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
@@ -5621,7 +5628,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
-				      false);
+				      false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/*
@@ -5647,7 +5654,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -5685,7 +5693,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+			 kvm_mmu_zap_collapsible_spte, true, NULL);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -5695,7 +5703,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
+	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -5718,7 +5726,7 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
-					false);
+					false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/* see kvm_mmu_slot_remove_write_access */
@@ -5735,7 +5743,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
+	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false,
+			NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
-- 
2.19.2

