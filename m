Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21930ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA896208E3
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+8Z7CBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA896208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbeKEC17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:27:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53806 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeKEC17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:27:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so6051457wmh.3;
        Sun, 04 Nov 2018 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kF/k/zyomP4gQjXdIQh9uoVods1BUkDTWlT2w7Wn68I=;
        b=h+8Z7CBiV3f7/NJVCc32ju1C//FkAH7hE5PMK1WiNeHtwILGseoOfZEIVRsZtle5xe
         J4X4+RpM8edBNYMmWBF+M5EfANupcrCs0KM/eDYHVCQEPmCMwXxrzkHjAb9e5ToOEqJ0
         05OxTIl8q3K1wfCXG8gV45hIK57U+rlHIfRv2IXW7aSYlS0oDFWtzXLBgEVzVt9zp5IZ
         IMZlcVpTguWJcZLfuQu/+Ds04RZo0hPNup16IzDjg9O/1NRfhSj+7uy3eeZaYo2pXU2H
         1X9uWAaMv2TXmaZix4QHaA4YBmpwbLHZEH/8XM73OGFqy8uM/Tj8V2HbvJaBd9SBlIY8
         QJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=kF/k/zyomP4gQjXdIQh9uoVods1BUkDTWlT2w7Wn68I=;
        b=nk5YmUkmCmJ/gQ6QL8UOAE3XvWkBM5sO8FJWwjg8ofPv0xTX0DuhqaN8DYmPTuOND/
         BBSbLvJkV2iJhLiIvmC/9IjSBgY4Q28QJkXSONblNve9bWca8VfwS71BZVBmvYM2RZiv
         Bo6ZJ2xa8lImHMvl8rfPGjhQIXj63eio592jRlLakh0JhCbx0uHrmvKD+W5PSb5oIK6l
         Q0Bp40kDTyL1drij1wWzzNNCYslZ6wN7fv/SweXuEXhiVbGUwyCDwshUeeQtc8pCZCqf
         Opa/iTBIvgGrAL07YDvLH50wcJnmz8kDOvaPPAxTWoRvAU7GTjOqEayzPwYiO/Ysis9S
         yZ8Q==
X-Gm-Message-State: AGRZ1gLHjS9A5mijZ2NN6yFHqn+qQNPc00eSwuUN+tveABgA3zQELFtz
        yarTpCE72oG0R5HWRSXwQ/Y=
X-Google-Smtp-Source: AJdET5dn8W58UZjiu5B6U/gD6+wtoGe3weaBazrQSNxA26X9fX0DFXNIlnjrWkEIiYvhsFyTrq+9nw==
X-Received: by 2002:a1c:f417:: with SMTP id z23-v6mr3830121wma.80.1541351537715;
        Sun, 04 Nov 2018 09:12:17 -0800 (PST)
Received: from localhost.localdomain ([41.35.162.9])
        by smtp.gmail.com with ESMTPSA id r2-v6sm23707749wrq.1.2018.11.04.09.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:12:16 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        "Ahmed Lotfy igor . stoppa @ gmail . com" <A7med.lotfey@gmail.com>
Subject: [PATCH V6 2/8] KVM: X86: Add arbitrary data pointer in kvm memslot iterator functions
Date:   Sun,  4 Nov 2018 19:11:18 +0200
Message-Id: <20181104171124.5717-3-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help sharing data into the slot_level_handler callback. In my
case I need to a share a counter for the pages traversed to use it in some
bitmap. Being able to send arbitrary memory pointer into the
slot_level_handler callback made it easy.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 arch/x86/kvm/mmu.c | 65 ++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572f2305..c54ec914935b 100644
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
@@ -5523,13 +5527,15 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
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
@@ -5537,7 +5543,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, data);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5559,36 +5565,36 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
@@ -5610,7 +5616,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+						start, end - 1, true, NULL);
 		}
 	}
 
@@ -5618,9 +5624,10 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
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
@@ -5630,7 +5637,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
-				      false);
+				      false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/*
@@ -5656,7 +5663,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -5694,7 +5702,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+			 kvm_mmu_zap_collapsible_spte, true, NULL);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -5704,7 +5712,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
+	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -5727,7 +5735,7 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
-					false);
+					false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/* see kvm_mmu_slot_remove_write_access */
@@ -5744,7 +5752,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
+	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false,
+			NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
-- 
2.18.1

