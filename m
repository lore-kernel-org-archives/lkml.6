Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AE520B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5qA9/C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AE520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeGPMlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:41:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43485 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeGPMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:41:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20-v6so4246810edt.10;
        Mon, 16 Jul 2018 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1xGpXsZnyXKNa4qD3COWe2VNaMWgEEqrfIVtGIiXdMI=;
        b=b5qA9/C/pGAncw6rBHFVEU3KgaMH0WbbPKAXy94als1N99lijgSuPm0MS7IRrgtPLd
         yOE2E3tlWxcmzgYVSsWRO2IdcdqpPfzD/bioNXJ9XnyWaeSQtrtXw35Qeceu9HI7Cydb
         6HL+m6MzKCvLjzu1cgX/gzgi/Tzap9G/OqDt85Tz9WXTteIl64gQAUCNC31WCn9RqNfP
         mUVNA4EjhFRMQ78TC8Uw2ESY1deSlHc2qi6up/ByJhV/alE0YFvqxdFhG/n0y71GtU4z
         hxFcB4TEVoaJcakCkExZYyWtR6tbD8Qw1bG5RuIeagAowyBS/GNRE/enK8AChqKgne54
         NBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1xGpXsZnyXKNa4qD3COWe2VNaMWgEEqrfIVtGIiXdMI=;
        b=RowfFPJ/Nsu+Rpm8uy+kPUU2A0DPCXdgFKysz6SzA8jCEkNuZPCrmfNkidNCAw+EAq
         cYGLCqiyjuAS7LNVCRaLJPtahORrc2KT3qrNPs4IwYMEtP+5ZRN4o+79aNL+6OF+yjUP
         IIo58CuEgHVlFHZGysJDKP1482bwQVx0ypYV1mytiJpk3H/FWxyPtiUVJgtpxXn1nt0x
         GlLsJ1HQQHKVJ4yOKteCweWMyot0uAxvjIsCogszH668IyPRhKqTcvYrURsm32yaWF7i
         dm9SoG4JYhO58//fGxvsGw+J+CCIlcnUWKinS2WcxOo7cVSz5LdhFgFrXkPYmrs8d9yt
         +wzg==
X-Gm-Message-State: AOUpUlGrXxt4Ft/W5Cx3E4mvYVYssFCm0pKeYmRAXq3oghSOIbPskG5V
        Oem8FP5QmTWLlgxqJ17CoV99woQ6hKA=
X-Google-Smtp-Source: AAOMgpeo8gadKrFXM5ywzRDR7/y57dNG3N4I4fxj8KuLEcf/uZCZGOYm0m2Ut57eK/NojjRUFkpSsw==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr16995203ede.213.1531743244244;
        Mon, 16 Jul 2018 05:14:04 -0700 (PDT)
Received: from localhost.localdomain ([156.212.29.248])
        by smtp.gmail.com with ESMTPSA id m4-v6sm10494329edr.15.2018.07.16.05.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:14:03 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
Subject: [RFC] kvm: Adding skelaton for Memory ROE
Date:   Mon, 16 Jul 2018 14:12:18 +0200
Message-Id: <20180716121218.30295-1-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first patch, an attempt to implement Memory ROE discussed by me
earlier as a way to prevent Rootkits. I have already explained in details
in this thread:
https://www.mail-archive.com/kernelnewbies@kernelnewbies.org/msg18826.html
So I think there is no need for saying the exact same thing again.
The problem is that the code isn't working and I can't figure out why

I tried implementing the protection to follow similar behavior to that
of KVM_MEM_READONLY but to be on page (SPTE) level
The current problem I am facing is that when handling the hypercall
vcpu->mode turns to be OUTSIDE_GUEST_MODE but KVM_REQ_TLB_FLUSH doesn't
seem to be handled correctly. KVM documentation promised that when VCPU is
not in GUEST_MODE VCPU are handled asap and kvm_vcpu_kick(vcpu); will
even force that, but it doesn't seem to be the case for me. This is the
kind of logging I am getting:

[3556.312299] kvm_mmu_slot_apply_flags: visited
[3556.312301] kvm_mmu_slot_apply_write_access: Flush = false
[3557.034243] gfn_is_readonly: test_bit = 0
[3557.034251] gfn_is_readonly: test_bit = 0
[3557.034254] gfn_is_readonly: test_bit = 0
[3557.034463] Hypercall received, page address 0x0
[3557.034466] gfn_is_readonly: test_bit = 0
[3557.034469] kvm_mroe: flush state = Done
[3557.034472] kvm_mroe: cpu mode = OUTSIDE_GUEST_MODE
[3557.034475] Setting page number 0 in slot number 0
[3557.034480] slot_rmap_apply_protection: The 0th page is readonly, Flush = True
[3557.034483] kvm_mmu_slot_apply_write_access: Flush = true
[3557.034486] kvm_mroe: cpu mode = OUTSIDE_GUEST_MODE
[3557.034488] kvm_mroe: cpu mode = OUTSIDE_GUEST_MODE
[3557.034490] kvm_mroe: flush state = Waiting

For some reason kvm_vcpu_kick() didn't force the KVM_REQ_TLB_FLUSH to
kick into the virtual cpu (I am talking about the last 2 lines).

I am aware that there is still alot missing (like dealing with malicious
guest remappings) and the code quality sucks, but any ideas about what I
could be doing wrong (or ideas in general) would be apprciated. I am
already planning to do everything cleanly once it works.

Thansk.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 arch/x86/include/asm/kvm_host.h |   7 ++-
 arch/x86/kvm/Kconfig            |   7 +++
 arch/x86/kvm/mmu.c              | 127 +++++++++++++++++++++++++++-------------
 arch/x86/kvm/x86.c              |  83 ++++++++++++++++++++++++--
 include/linux/kvm_host.h        |  17 ++++++
 include/uapi/linux/kvm_para.h   |   4 +-
 virt/kvm/kvm_main.c             |  36 +++++++++---
 7 files changed, 226 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..c66e9245f750 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -235,7 +235,10 @@ struct kvm_mmu_memory_cache {
 	int nobjs;
 	void *objects[KVM_NR_MEM_OBJS];
 };
-
+struct kvm_write_access_data {
+	int i;
+	struct kvm_memory_slot *memslot;
+};
 /*
  * the pages used as guest page table on soft mmu are tracked by
  * kvm_memory_slot.arch.gfn_track which is 16 bits, so the role bits used
@@ -1130,7 +1133,7 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
 		u64 acc_track_mask, u64 me_mask);
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
-void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
+void kvm_mmu_slot_apply_write_access(struct kvm *kvm,
 				      struct kvm_memory_slot *memslot);
 void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 92fd433c50b9..8ae822a8dc7a 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -96,6 +96,13 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config KVM_MROE
+	bool "Hypercall Memory Read-Only Enforcement"
+	depends on KVM && X86
+	help
+	This option add KVM_HC_HMROE hypercall to kvm which as hardening
+	mechanism to protect memory pages from being edited.
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source drivers/vhost/Kconfig
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690d8b95..946545b8b8cb 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -70,7 +70,7 @@ enum {
 #undef MMU_DEBUG
 
 #ifdef MMU_DEBUG
-static bool dbg = 0;
+static bool dbg = 1;
 module_param(dbg, bool, 0644);
 
 #define pgprintk(x...) do { if (dbg) printk(x); } while (0)
@@ -1402,7 +1402,6 @@ static void drop_large_spte(struct kvm_vcpu *vcpu, u64 *sptep)
 static bool spte_write_protect(u64 *sptep, bool pt_protect)
 {
 	u64 spte = *sptep;
-
 	if (!is_writable_pte(spte) &&
 	      !(pt_protect && spte_can_locklessly_be_made_writable(spte)))
 		return false;
@@ -1418,15 +1417,23 @@ static bool spte_write_protect(u64 *sptep, bool pt_protect)
 
 static bool __rmap_write_protect(struct kvm *kvm,
 				 struct kvm_rmap_head *rmap_head,
-				 bool pt_protect)
+				 bool pt_protect,
+				 struct kvm_write_access_data *d)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
 	bool flush = false;
-
-	for_each_rmap_spte(rmap_head, &iter, sptep)
-		flush |= spte_write_protect(sptep, pt_protect);
-
+	if (d == NULL) {
+		for_each_rmap_spte(rmap_head, &iter, sptep) {
+			flush |= spte_write_protect(sptep,
+				!test_bit(d->i, d->memslot->mroe_bitmap)
+				&& pt_protect);
+			d->i++;
+		}
+	} else {
+		for_each_rmap_spte(rmap_head, &iter, sptep)
+			flush |= spte_write_protect(sptep, pt_protect);
+	}
 	return flush;
 }
 
@@ -1457,7 +1464,8 @@ static bool wrprot_ad_disabled_spte(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1483,7 +1491,8 @@ static bool spte_set_dirty(u64 *sptep)
 	return mmu_spte_update(sptep, spte);
 }
 
-static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1515,7 +1524,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		__rmap_write_protect(kvm, rmap_head, false, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1541,7 +1550,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_clear_dirty(kvm, rmap_head);
+		__rmap_clear_dirty(kvm, rmap_head, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1591,10 +1600,14 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 	struct kvm_rmap_head *rmap_head;
 	int i;
 	bool write_protected = false;
-
+	struct kvm_write_access_data data = {
+		.i = 0,
+		.memslot = slot,
+	};
 	for (i = PT_PAGE_TABLE_LEVEL; i <= PT_MAX_HUGEPAGE_LEVEL; ++i) {
 		rmap_head = __gfn_to_rmap(gfn, i, slot);
-		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
+		write_protected |= __rmap_write_protect(kvm, rmap_head, true,
+				&data);
 	}
 
 	return write_protected;
@@ -1608,7 +1621,8 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn);
 }
 
-static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1628,7 +1642,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			   struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			   unsigned long data)
 {
-	return kvm_zap_rmapp(kvm, rmap_head);
+	return kvm_zap_rmapp(kvm, rmap_head, NULL);
 }
 
 static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -5086,13 +5100,15 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
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
@@ -5100,7 +5116,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, data);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5122,36 +5138,36 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
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
@@ -5173,7 +5189,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+						start, end - 1, true, NULL);
 		}
 	}
 
@@ -5181,23 +5197,52 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 }
 
 static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head)
+				    struct kvm_rmap_head *rmap_head,
+				    void *data)
 {
-	return __rmap_write_protect(kvm, rmap_head, false);
+	return __rmap_write_protect(kvm, rmap_head, false,
+			(struct kvm_write_access_data *)data);
 }
 
-void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
+static bool slot_rmap_apply_protection(struct kvm *kvm,
+				      struct kvm_rmap_head *rmap_head,
+				      void *data)
+{
+	struct kvm_write_access_data *d = (struct kvm_write_access_data *) data;
+	unsigned long *protection = d->memslot->mroe_bitmap;
+	bool prot_mask = d->memslot->flags & KVM_MEM_READONLY;
+	u64 *sptep;
+	struct rmap_iterator iter;
+	bool flush = false;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
+		flush |= spte_write_protect(sptep,
+				!(test_bit(d->i, protection) || prot_mask));
+		if (test_bit(d->i, protection)) {
+			pr_info("%s: The %dth page is readonly, Flush = %s\n",
+				 __func__, d->i, flush?"True" : "False");
+		}
+		d->i++;
+	}
+	return flush;
+}
+
+void kvm_mmu_slot_apply_write_access(struct kvm *kvm,
 				      struct kvm_memory_slot *memslot)
 {
 	bool flush;
-
+	struct kvm_write_access_data data = {
+		.i = 0,
+		.memslot = memslot,
+	};
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
-				      false);
+	flush = slot_handle_all_level(kvm, memslot, slot_rmap_apply_protection,
+				      false, &data);
+	pr_info("%s: Flush = %s\n", __func__, flush ? "true":"false");
 	spin_unlock(&kvm->mmu_lock);
 
 	/*
-	 * kvm_mmu_slot_remove_write_access() and kvm_vm_ioctl_get_dirty_log()
+	 * kvm_mmu_slot_apply_write_access() and kvm_vm_ioctl_get_dirty_log()
 	 * which do tlb flush out of mmu-lock should be serialized by
 	 * kvm->slots_lock otherwise tlb flush would be missed.
 	 */
@@ -5219,7 +5264,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -5257,7 +5303,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+			 kvm_mmu_zap_collapsible_spte, true, NULL);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -5267,7 +5313,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
+	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -5290,10 +5336,10 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
-					false);
+					false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
-	/* see kvm_mmu_slot_remove_write_access */
+	/* see kvm_mmu_slot_apply_write_access */
 	lockdep_assert_held(&kvm->slots_lock);
 
 	if (flush)
@@ -5307,7 +5353,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
+	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false,
+			NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa70205a..96e967199fda 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -55,7 +55,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/mem_encrypt.h>
-
+#include <linux/mempolicy.h>
 #include <trace/events/kvm.h>
 
 #include <asm/debugreg.h>
@@ -4177,7 +4177,7 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
 
 	/*
 	 * All the TLBs can be flushed out of mmu lock, see the comments in
-	 * kvm_mmu_slot_remove_write_access().
+	 * kvm_mmu_slot_apply_write_access().
 	 */
 	lockdep_assert_held(&kvm->slots_lock);
 	if (is_dirty)
@@ -6669,7 +6669,74 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 	return ret;
 }
 #endif
+#ifdef CONFIG_KVM_MROE
+static int roe_protect_frame(struct kvm *kvm, gpa_t gpa)
+{
+	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+
+	slot = gfn_to_memslot(kvm, gfn);
+	//XXX do some error checking dude.
+	if (gfn > slot->base_gfn + slot->npages) {
+		//XXX use a better language
+		pr_err("You have an overflow\n");
+		return -1;
+	}
+	pr_info("Setting page number %lld in slot number %d\n",
+		gfn - slot->base_gfn, slot->id);
+	// something is wrong with the locking here
+	// you should lock the area before writing the bit
+	set_bit(gfn - slot->base_gfn, slot->mroe_bitmap);
+	kvm_mmu_slot_apply_write_access(kvm, slot);
+	return 0;
+}
+void debug_cpu_mode(struct kvm_vcpu *vcpu)
+{
+	char *mode = "Unknown";
+
+	if (vcpu->mode == OUTSIDE_GUEST_MODE)
+		mode = "OUTSIDE_GUEST_MODE";
+	else if (vcpu->mode == IN_GUEST_MODE)
+		mode = "IN_GUEST_MODE";
+	else if (vcpu->mode == EXITING_GUEST_MODE)
+		mode = "EXITING_GUEST_MODE";
+	else if (vcpu->mode == READING_SHADOW_PAGE_TABLES)
+		mode = "READING_SHADOW_PAGE_TABLES";
+	pr_info("kvm_mroe: cpu mode = %s\n", mode);
+}
+static int kvm_mroe(struct kvm_vcpu *vcpu, u64 gva)
+{
+	struct kvm *kvm = vcpu->kvm;
+	gpa_t gpa;
+	u64 hva;
+	int ret;
 
+	//XXX check that the hypercall is done from kernel mode
+	if (gva & ~PAGE_MASK)
+		return -EINVAL;
+	gpa = kvm_mmu_gva_to_gpa_system(vcpu, gva, NULL);
+	hva = gfn_to_hva(kvm, gpa >> PAGE_SHIFT);
+	//XXX This doesn't work but it will be ok to check that we can access
+	// the address and make sure that the mapping makes sense
+	if (!access_ok(VERIFY_WRITE, hva, PAGE_SIZE)) {
+		pr_info("Duplicate request\n");
+		return -KVM_EROEDUPLICATR;
+	}
+	pr_info("%s: flush state = %s\n", __func__,
+			kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu) ? "Waiting" :
+								     "Done");
+	debug_cpu_mode(vcpu);
+	ret = roe_protect_frame(vcpu->kvm, gpa);
+	debug_cpu_mode(vcpu);
+	kvm_vcpu_kick(vcpu);
+	debug_cpu_mode(vcpu);
+	pr_info("%s: flush state = %s\n", __func__,
+			kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu) ? "Waiting" :
+								     "Done");
+
+	return ret;
+}
+#endif
 /*
  * kvm_pv_kick_cpu_op:  Kick a vcpu.
  *
@@ -6737,6 +6804,12 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_CLOCK_PAIRING:
 		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
 		break;
+#endif
+#ifdef CONFIG_KVM_MROE
+	case KVM_HC_HMROE:
+		pr_info("Hypercall received, page address 0x%lx\n", a0);
+		ret = kvm_mroe(vcpu, a0);
+		break;
 #endif
 	default:
 		ret = -KVM_ENOSYS;
@@ -8971,8 +9044,10 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
 				     struct kvm_memory_slot *new)
 {
 	/* Still write protect RO slot */
+	pr_info("%s: visited\n", __func__);
+	kvm_mmu_slot_apply_write_access(kvm, new);
+	return;
 	if (new->flags & KVM_MEM_READONLY) {
-		kvm_mmu_slot_remove_write_access(kvm, new);
 		return;
 	}
 
@@ -9010,7 +9085,7 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
 		if (kvm_x86_ops->slot_enable_log_dirty)
 			kvm_x86_ops->slot_enable_log_dirty(kvm, new);
 		else
-			kvm_mmu_slot_remove_write_access(kvm, new);
+			kvm_mmu_slot_apply_write_access(kvm, new);
 	} else {
 		if (kvm_x86_ops->slot_disable_log_dirty)
 			kvm_x86_ops->slot_disable_log_dirty(kvm, new);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4ee7bc548a83..1ca6db7b8931 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/hashtable.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -297,6 +298,9 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
 struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
+#ifdef CONFIG_KVM_MROE
+	unsigned long *mroe_bitmap;
+#endif
 	unsigned long *dirty_bitmap;
 	struct kvm_arch_memory_slot arch;
 	unsigned long userspace_addr;
@@ -387,6 +391,13 @@ struct kvm_memslots {
 	int used_slots;
 };
 
+#ifdef CONFIG_KVM_MROE
+struct roe_page {
+	void *page_start;
+	struct hlist_node hash_list;
+};
+#endif
+
 struct kvm {
 	spinlock_t mmu_lock;
 	struct mutex slots_lock;
@@ -440,6 +451,12 @@ struct kvm {
 	unsigned long mmu_notifier_seq;
 	long mmu_notifier_count;
 #endif
+
+#ifdef CONFIG_KVM_MROE
+	//TODO tune hash size;
+	#define KVM_MROE_HASH_SIZE 8
+	DECLARE_HASHTABLE(roe_pages, KVM_MROE_HASH_SIZE);
+#endif
 	long tlbs_dirty;
 	struct list_head devices;
 	struct dentry *debugfs_dentry;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index dcf629dd2889..2be960477649 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -17,6 +17,8 @@
 #define KVM_EPERM		EPERM
 #define KVM_EOPNOTSUPP		95
 
+#define KVM_EROEDUPLICATR	1
+
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
 #define KVM_HC_FEATURES			3
@@ -26,7 +28,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
-
+#define KVM_HC_HMROE			10
 /*
  * hypercalls use architecture specific
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507faab5..ca1b95a16a8b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -634,7 +634,6 @@ static struct kvm *kvm_create_vm(unsigned long type)
 	mutex_init(&kvm->slots_lock);
 	refcount_set(&kvm->users_count, 1);
 	INIT_LIST_HEAD(&kvm->devices);
-
 	r = kvm_arch_init_vm(kvm, type);
 	if (r)
 		goto out_err_no_disable;
@@ -794,6 +793,17 @@ static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
 	return 0;
 }
 
+static int kvm_init_mroe_bitmap(struct kvm_memory_slot *slot)
+{
+#ifdef CONFIG_KVM_MROE
+	slot->mroe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
+			sizeof(unsigned long), GFP_KERNEL);
+	if (!slot->mroe_bitmap)
+		return -ENOMEM;
+#endif
+	return 0;
+}
+
 /*
  * Insert memslot and re-sort memslots based on their GFN,
  * so binary search could be used to lookup GFN.
@@ -1011,7 +1021,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
-
+	if (kvm_init_mroe_bitmap(&new) < 0)
+		goto out_free;
 	slots = kvzalloc(sizeof(struct kvm_memslots), GFP_KERNEL);
 	if (!slots)
 		goto out_free;
@@ -1263,16 +1274,25 @@ static bool memslot_is_readonly(struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_READONLY;
 }
-
+static bool gfn_is_readonly(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+#ifdef CONFIG_KVM_MROE
+	pr_info("%s: test_bit = %d", __func__,
+			test_bit(gfn - slot->base_gfn, slot->mroe_bitmap));
+	///dump_stack();
+	return test_bit(gfn - slot->base_gfn, slot->mroe_bitmap) ||
+		memslot_is_readonly(slot);
+#else
+	return memslot_is_readonly(slot);
+#endif
+}
 static unsigned long __gfn_to_hva_many(struct kvm_memory_slot *slot, gfn_t gfn,
 				       gfn_t *nr_pages, bool write)
 {
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
 		return KVM_HVA_ERR_BAD;
-
-	if (memslot_is_readonly(slot) && write)
+	if (gfn_is_readonly(slot, gfn) && write)
 		return KVM_HVA_ERR_RO_BAD;
-
 	if (nr_pages)
 		*nr_pages = slot->npages - (gfn - slot->base_gfn);
 
@@ -1314,7 +1334,7 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
 	unsigned long hva = __gfn_to_hva_many(slot, gfn, NULL, false);
 
 	if (!kvm_is_error_hva(hva) && writable)
-		*writable = !memslot_is_readonly(slot);
+		*writable = !gfn_is_readonly(slot, gfn);
 
 	return hva;
 }
@@ -1554,7 +1574,7 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
 	}
 
 	/* Do not map writable pfn in the readonly memslot. */
-	if (writable && memslot_is_readonly(slot)) {
+	if (writable && gfn_is_readonly(slot, gfn)) {
 		*writable = false;
 		writable = NULL;
 	}
-- 
2.16.4

