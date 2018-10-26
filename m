Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD1C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962702085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+ed2gle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962702085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJZXyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:54:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJZXyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:54:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so1749575wrw.3;
        Fri, 26 Oct 2018 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=u0utimejmt+Ta9isXHRp3i30yKOoE3711/Qpeu76SjE=;
        b=r+ed2glezGIhnBrUFOmBVGd3+ajN1kor1Tz4sdScjuAXJJhYzd0KzEPzIfI0feW9IA
         9hVk+4kT3R4ZZn9JY8WokxEwKG8mVoRjp3/2cfWkV6KE3/OOkpfS9r2cjYY2JthN7h2K
         Vo9+ua1AS7GOaMAOop5iNWJiHp31E6xFX7KknF4PyY+wq8xaScbSPcxTLqIv6FvOZ9cP
         8ptsRvlloJrwj5RY+F7EyemP3lFyA+anhc1pF9SL3qVGS/C3DexilawUlmlN9VBpj98Q
         Ocj3Gu/QzpSOY9Et+DfCs5r1v1/AmnoiqlIiTFx+gywZ7hjsUbQ7SBnO62xFWjsrSLMI
         vDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=u0utimejmt+Ta9isXHRp3i30yKOoE3711/Qpeu76SjE=;
        b=BbnlBwSdWZFDtlMLD2CnWJ5a3n+S3JC7G2caMKshVleDU8uqKUajr4QKXGmXcfBLEO
         f2hlZRWMDY0j2cuWCYwbqY3xBqSeNCqDiHqJ5BbHyWoqg5jDw5KQ5W4iE55YxldPJP87
         PsSgGfYkiRu29BNd4vX8eeD5D6zVOFt3I+cc1MOvtsyrtbLxQCIBtVbfOunHo9CbuoaV
         dSrx9X0QdY5HoR0rxk7kAtDcqUiXrEBSK+2jqjvLkNYYYNPgGVLyZGP/hEkBwJq4kgWC
         mFvraUKgpR+BkUwJwvYidcQrXV9EGKbnB7RIs1YuLZoZWNNNPr2buOK8zhcZwMTw9kQG
         bEZg==
X-Gm-Message-State: AGRZ1gJYqHu4B8+aoxj/yQ3ktdDtO3x2AxUXAVouTVY54IE6VhxTC509
        xkVX9vFJfrdJc6sx/GewV4o=
X-Google-Smtp-Source: AJdET5c54qvpFOXMuims1xLvxiRGxRly8XJguwMf/+jAG4GJapBxKlKcGBN5HBBGr69Hoq5h6eH04Q==
X-Received: by 2002:a5d:438e:: with SMTP id i14-v6mr6557199wrq.156.1540567011855;
        Fri, 26 Oct 2018 08:16:51 -0700 (PDT)
Received: from localhost.localdomain ([156.213.138.111])
        by smtp.gmail.com with ESMTPSA id p7-v6sm10127257wrt.10.2018.10.26.08.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:16:51 -0700 (PDT)
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
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V5 2/5] KVM: X86: Adding arbitrary data pointer in kvm memslot iterator functions
Date:   Fri, 26 Oct 2018 17:12:20 +0200
Message-Id: <20181026151223.16810-3-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
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
index 4cf43ce42959..c4512a47dd16 100644
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
@@ -5532,13 +5536,15 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
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
@@ -5546,7 +5552,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, data);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5568,36 +5574,36 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
@@ -5619,7 +5625,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+						start, end - 1, true, NULL);
 		}
 	}
 
@@ -5627,9 +5633,10 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
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
@@ -5639,7 +5646,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
-				      false);
+				      false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/*
@@ -5665,7 +5672,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -5703,7 +5711,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+			 kvm_mmu_zap_collapsible_spte, true, NULL);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -5713,7 +5721,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
+	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -5736,7 +5744,7 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
-					false);
+					false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/* see kvm_mmu_slot_remove_write_access */
@@ -5753,7 +5761,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
+	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false,
+			NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
-- 
2.18.1

