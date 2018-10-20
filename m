Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91717C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3391B21746
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvGpFGla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3391B21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJUGfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41151 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJUGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so13106433wrr.8;
        Sat, 20 Oct 2018 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oMeRV5A7WDQaaL2fpv9x+GSsG+GWxl+T/DjHh5n82iQ=;
        b=kvGpFGlaKSTeGOmHIAL4L1eM3qb4+ls/S37jPmBv+9K6Ksrm28wfcxlcolRXhOGkEm
         97aq5JTjTjsrg+9w7LniY83jOYMzaeF97QkcSKcB9ZH0O+h8zjqelwVq0gQ7muIayRiL
         w7jH58/ugQ2Kl3BY6gy4QCikUyeGeuJFv0BeZyG6HtsXnJrp2X73UGHRhcs06s+4We7j
         5rQCC1EEMRwJ06z8szpWssjbyl72N6BGpZinZz08X+CHOBMbAAxuJvTfycZXDGUbN0Ef
         /e96Mh8aOsb7W+x8mGDOn0kBw1pqelMafH5ax0+lkjZcWJ1MddApLnBbfUGMjE3XRhS1
         jLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oMeRV5A7WDQaaL2fpv9x+GSsG+GWxl+T/DjHh5n82iQ=;
        b=JSIi4jgmfNVOdX18JJeA18KySUDsKD/bK5Yv1GbPV+ZsFJgOhmvgpQopo1Pf/JD6o7
         WpDAL30yUiQ+C4t07zc9VkL4R82fPD8Z0LulDIBRneeKoxjTXVz1a+pRzlvAiW+gm5N+
         RFMDPKHf/f0OQR7lKtd+envqRrmn7iwZPTvIrFlhKoa37WZguHR3GXK/fy6DPtl2CzaV
         EFsgDENLmUqqi+zLaEB+97SLGxv8/+xRkoMkuHQGEl6WaTIwmJT4wyFSOOFJUfuO16Uq
         BPQjqaOmWQ7T7ud2HSmnVyqqEirmZGKrW6xQ8qkQsezgUZZnfUAG5U2dagwXbgxFSCnG
         2OeQ==
X-Gm-Message-State: ABuFfoiOmVjwgJVsBu/NMQM3igHsnY6xh3tc7uxpZj6U6DtLyCdM0Zg7
        OqGt9MamfJMTZodvmxpoB9Q=
X-Google-Smtp-Source: ACcGV61WHSatlg2SUUzUXYTjE4TP4WJyczmqiSQ2uZPClVqmAAUlI7+2hVXppct2Xnz4Om/ZlfpW/A==
X-Received: by 2002:adf:8547:: with SMTP id 65-v6mr39806669wrh.69.1540074192129;
        Sat, 20 Oct 2018 15:23:12 -0700 (PDT)
Received: from localhost.localdomain ([156.213.155.51])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5013746wmo.38.2018.10.20.15.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 15:23:11 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, Ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V4 4/5] KVM: X86: Adding support for byte granular memory ROE
Date:   Sun, 21 Oct 2018 00:21:26 +0200
Message-Id: <20181020222127.6368-5-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
References: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents and implements ROE_MPROTECT_CHUNK, a part of ROE
hypercall designed to protect regions of a memory page with byte
granularity. This feature provides a key primitive to protect against
attacks involving pages remapping. However this attack  will be
addressed in future patches.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 Documentation/virtual/kvm/hypercalls.txt |   9 ++
 arch/x86/kvm/mmu.c                       |   6 +-
 arch/x86/kvm/x86.c                       | 156 +++++++++++++++++++++--
 include/linux/kvm_host.h                 |  26 ++++
 include/uapi/linux/kvm_para.h            |   1 +
 virt/kvm/kvm_main.c                      |  88 +++++++++++--
 6 files changed, 266 insertions(+), 20 deletions(-)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index 8af64d826f03..8708d69a7725 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -164,6 +164,15 @@ This configuration lets a guest kernel have part of its read/write memory
 converted into read-only.  This action is irreversible.
 Upon successful run, the number of pages protected is returned.
 
+Usage 3:
+     a0: ROE_MPROTECT_CHUNK	(requires version >= 2)
+     a1: Start address aligned to page boundary.
+     a2: Number of bytes to be protected.
+This configuration lets a guest kernel have part of its read/write memory
+converted into read-only with bytes granularity. ROE_MPROTECT_CHUNK is
+relatively slow compared to ROE_MPROTECT. This action is irreversible.
+Upon successful run, the number of pages protected is returned.
+
 Error codes:
 	-KVM_ENOSYS: system call being triggered from ring 3 or it is not
 	implemented.
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c54aa5287e14..c3d681bfa105 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1507,9 +1507,11 @@ static bool __rmap_write_protect_roe(struct kvm *kvm,
 	struct rmap_iterator iter;
 	bool prot;
 	bool flush = false;
-
+	void *full_bmp =  d->memslot->roe_bitmap;
+	void *part_bmp = d->memslot->partial_roe_bitmap;
 	for_each_rmap_spte(rmap_head, &iter, sptep) {
-		prot = !test_bit(d->i, d->memslot->roe_bitmap) && pt_protect;
+		prot = !(test_bit(d->i, full_bmp) || test_bit(d->i, part_bmp));
+		prot = prot && pt_protect;
 		flush |= spte_write_protect(sptep, prot);
 		d->i++;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 70f2b42a2f91..0c767ddd26a2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6800,17 +6800,23 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 
 #ifdef CONFIG_KVM_ROE
 static void kvm_roe_protect_slot(struct kvm *kvm, struct kvm_memory_slot *slot,
-				gfn_t gfn, u64 npages)
+				gfn_t gfn, u64 npages, bool partial)
 {
 	int i;
+	void *bitmap;
 
+	if (partial)
+		bitmap = slot->partial_roe_bitmap;
+	else
+		bitmap = slot->roe_bitmap;
 	for (i = gfn - slot->base_gfn; i < gfn + npages - slot->base_gfn; i++)
-		set_bit(i, slot->roe_bitmap);
+		set_bit(i, bitmap);
 	kvm_mmu_slot_apply_write_access(kvm, slot);
 	kvm_arch_flush_shadow_memslot(kvm, slot);
 }
 
-static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
+static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages,
+				bool partial)
 {
 	struct kvm_memory_slot *slot;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
@@ -6826,12 +6832,12 @@ static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
 		if (gfn + npages > slot->base_gfn + slot->npages) {
 			u64 _npages = slot->base_gfn + slot->npages - gfn;
 
-			kvm_roe_protect_slot(kvm, slot, gfn, _npages);
+			kvm_roe_protect_slot(kvm, slot, gfn, _npages, partial);
 			gfn += _npages;
 			count += _npages;
 			npages -= _npages;
 		} else {
-			kvm_roe_protect_slot(kvm, slot, gfn, npages);
+			kvm_roe_protect_slot(kvm, slot, gfn, npages, partial);
 			count += npages;
 			npages = 0;
 		}
@@ -6841,12 +6847,13 @@ static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
 	return count;
 }
 
-static int kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
+static int kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages,
+		bool partial)
 {
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
-	r = __kvm_roe_protect_range(kvm, gpa, npages);
+	r = __kvm_roe_protect_range(kvm, gpa, npages, partial);
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
@@ -6895,7 +6902,7 @@ static int kvm_roe_full_protect_range(struct kvm_vcpu *vcpu, u64 gva,
 			continue;
 		if (!access_ok(VERIFY_WRITE, hva, 1 << PAGE_SHIFT))
 			continue;
-		status =  kvm_roe_protect_range(vcpu->kvm, gpa, 1);
+		status =  kvm_roe_protect_range(vcpu->kvm, gpa, 1, false);
 		if (status > 0)
 			count += status;
 	}
@@ -6903,7 +6910,135 @@ static int kvm_roe_full_protect_range(struct kvm_vcpu *vcpu, u64 gva,
 		return -EINVAL;
 	return count;
 }
+static int kvm_roe_insert_chunk_next(struct list_head *pos, u64 gpa, u64 size)
+{
+	struct protected_chunk *chunk;
+
+	chunk = kvzalloc(sizeof(struct protected_chunk), GFP_KERNEL);
+	chunk->gpa = gpa;
+	chunk->size = size;
+	INIT_LIST_HEAD(&chunk->list);
+	list_add(&chunk->list, pos);
+	return size;
+}
+static int kvm_roe_expand_chunk(struct protected_chunk *pos, u64 gpa, u64 size)
+{
+	u64 old_ptr = pos->gpa;
+	u64 old_size = pos->size;
+
+	if (gpa < old_ptr)
+		pos->gpa = gpa;
+	if (gpa + size > old_ptr + old_size)
+		pos->size = gpa + size - pos->gpa;
+	return size;
+}
+
+static bool kvm_roe_merge_chunks(struct protected_chunk *chunk)
+{
+	/*attempt merging 2 consecutive given the first one*/
+	struct protected_chunk *next = list_next_entry(chunk, list);
+
+	if (!kvm_roe_range_overlap(chunk, next->gpa, next->size))
+		return false;
+	kvm_roe_expand_chunk(chunk, next->gpa, next->size);
+	list_del(&next->list);
+	kvfree(next);
+	return true;
+}
+static int __kvm_roe_insert_chunk(struct kvm_memory_slot *slot, u64 gpa,
+		u64 size)
+{
+	/* kvm->slots_lock must be acquired*/
+	struct protected_chunk *pos;
+	struct list_head *head = slot->prot_list;
+
+	if (list_empty(head))
+		return kvm_roe_insert_chunk_next(head, gpa, size);
+	/*
+	 * pos here will never get deleted maybe the next one will
+	 * that is why list_for_each_entry_safe is completely unsafe
+	 */
+	list_for_each_entry(pos, head, list) {
+		if (kvm_roe_range_overlap(pos, gpa, size)) {
+			int ret = kvm_roe_expand_chunk(pos, gpa, size);
+
+			while (head != pos->list.next)
+				if (!kvm_roe_merge_chunks(pos))
+					break;
+			return ret;
+		}
+		if (pos->gpa > gpa) {
+			struct protected_chunk *prev;
 
+			prev = list_prev_entry(pos, list);
+			return kvm_roe_insert_chunk_next(&prev->list, gpa,
+					size);
+		}
+	}
+	pos = list_last_entry(head, struct protected_chunk, list);
+
+	return kvm_roe_insert_chunk_next(&pos->list, gpa, size);
+}
+static int kvm_roe_insert_chunk(struct kvm *kvm, u64 gpa, u64 size)
+{
+	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int ret;
+
+	mutex_lock(&kvm->slots_lock);
+	slot = gfn_to_memslot(kvm, gfn);
+	ret = __kvm_roe_insert_chunk(slot, gpa, size);
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
+}
+
+static int kvm_roe_partial_page_protect(struct kvm_vcpu *vcpu, u64 gva,
+		u64 size)
+{
+	gpa_t gpa = kvm_mmu_gva_to_gpa_system(vcpu, gva, NULL);
+
+	kvm_roe_protect_range(vcpu->kvm, gpa, 1, true);
+	return kvm_roe_insert_chunk(vcpu->kvm, gpa, size);
+}
+
+static int kvm_roe_partial_protect(struct kvm_vcpu *vcpu, u64 gva, u64 size)
+{
+	u64 gva_start = gva;
+	u64 gva_end = gva+size;
+	u64 gpn_start = gva_start >> PAGE_SHIFT;
+	u64 gpn_end = gva_end >> PAGE_SHIFT;
+	u64 _size;
+	int count = 0;
+	// We need to make sure that there will be no overflow or zero size
+	if (gva_end <= gva_start)
+		return -EINVAL;
+
+	// protect the partial page at the start
+	if (gpn_end > gpn_start)
+		_size = PAGE_SIZE - (gva_start & PAGE_MASK) + 1;
+	else
+		_size = size;
+	size -= _size;
+	count += kvm_roe_partial_page_protect(vcpu, gva_start, _size);
+	// full protect in the middle pages
+	if (gpn_end - gpn_start > 1) {
+		int ret;
+		u64 _gva = (gpn_start + 1) << PAGE_SHIFT;
+		u64 npages = gpn_end - gpn_start - 1;
+
+		size -= npages << PAGE_SHIFT;
+		ret = kvm_roe_full_protect_range(vcpu, _gva, npages);
+		if (ret > 0)
+			count += ret << PAGE_SHIFT;
+	}
+	// protect the partial page at the end
+	if (size != 0)
+		count += kvm_roe_partial_page_protect(vcpu,
+				gpn_end << PAGE_SHIFT, size);
+	if (count == 0)
+		return -EINVAL;
+	return count;
+}
 static int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3)
 {
 	int ret;
@@ -6915,11 +7050,14 @@ static int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3)
 		return -KVM_ENOSYS;
 	switch (a0) {
 	case ROE_VERSION:
-		ret = 1; //current version
+		ret = 2; //current version
 		break;
 	case ROE_MPROTECT:
 		ret = kvm_roe_full_protect_range(vcpu, a1, a2);
 		break;
+	case ROE_MPROTECT_CHUNK:
+		ret = kvm_roe_partial_protect(vcpu, a1, a2);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index be6885bc28bc..a6749a52386b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -294,11 +294,37 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
  */
 #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
 
+#ifdef CONFIG_KVM_ROE
+/*
+ * This structure is used to hold memory areas that are to be protected in a
+ * memory frame with mixed page permissions.
+ **/
+struct protected_chunk {
+	gpa_t gpa;
+	u64 size;
+	struct list_head list;
+};
+
+static inline bool kvm_roe_range_overlap(struct protected_chunk *chunk,
+		gpa_t gpa, int len) {
+	/*
+	 * https://stackoverflow.com/questions/325933/
+	 * determine-whether-two-date-ranges-overlap
+	 * Assuming that it works, that link ^ provides a solution that is
+	 * better than anything I would ever come up with.
+	 */
+	return (gpa <= chunk->gpa + chunk->size - 1) &&
+		(gpa + len - 1 >= chunk->gpa);
+}
+#endif
+
 struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
 #ifdef CONFIG_KVM_ROE
 	unsigned long *roe_bitmap;
+	unsigned long *partial_roe_bitmap;
+	struct list_head *prot_list;
 #endif
 	unsigned long *dirty_bitmap;
 	struct kvm_arch_memory_slot arch;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index e6004e0750fd..4a84f974bc58 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -33,6 +33,7 @@
 /* ROE Functionality parameters */
 #define ROE_VERSION			0
 #define ROE_MPROTECT			1
+#define ROE_MPROTECT_CHUNK		2
 /*
  * hypercalls use architecture specific
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 423a9c014120..d4f36faacd29 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -555,10 +555,19 @@ static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
 			      struct kvm_memory_slot *dont)
 {
 #ifdef CONFIG_KVM_ROE
-	if (!dont)
+	if (!dont) {
+		//TODO still this might leak
+		struct protected_chunk *pos, *n;
+		struct list_head *head = free->prot_list;
 		kvfree(free->roe_bitmap);
+		kvfree(free->partial_roe_bitmap);
+		list_for_each_entry_safe(pos, n, head, list) {
+			list_del(&pos->list);
+			kvfree(pos);
+		}
+		kvfree(free->prot_list);
+	}
 #endif
-
 	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
 		kvm_destroy_dirty_bitmap(free);
 
@@ -805,13 +814,22 @@ static int kvm_create_dirty_bitmap(struct kvm_memory_slot *memslot)
 	return 0;
 }
 
-static int kvm_init_roe_bitmap(struct kvm_memory_slot *slot)
+static int kvm_init_roe(struct kvm_memory_slot *slot)
 {
 #ifdef CONFIG_KVM_ROE
 	slot->roe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
 	sizeof(unsigned long), GFP_KERNEL);
 	if (!slot->roe_bitmap)
 		return -ENOMEM;
+	slot->partial_roe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
+	sizeof(unsigned long), GFP_KERNEL);
+	if (!slot->partial_roe_bitmap) {
+		kvfree(slot->roe_bitmap);
+		return -ENOMEM;
+	}
+	slot->prot_list = kvzalloc(sizeof(struct list_head), GFP_KERNEL);
+	INIT_LIST_HEAD(slot->prot_list);
+
 #endif
 	return 0;
 }
@@ -1033,7 +1051,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
-	if (kvm_init_roe_bitmap(&new) < 0)
+	if (kvm_init_roe(&new) < 0)
 		goto out_free;
 
 	slots = kvzalloc(sizeof(struct kvm_memslots), GFP_KERNEL);
@@ -1287,26 +1305,37 @@ static bool memslot_is_readonly(struct kvm_memory_slot *slot)
 {
 	return slot->flags & KVM_MEM_READONLY;
 }
+#ifdef CONFIG_KVM_ROE
+static bool gfn_is_partially_protected(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+
+	return test_bit(gfn - slot->base_gfn, slot->partial_roe_bitmap);
+}
 
+static bool gfn_is_fully_protected(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap);
+}
+#endif
 static bool gfn_is_readonly(struct kvm_memory_slot *slot, gfn_t gfn)
 {
 #ifdef CONFIG_KVM_ROE
-	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap) ||
-		memslot_is_readonly(slot);
+	return gfn_is_fully_protected(slot, gfn) ||
+	       gfn_is_partially_protected(slot, gfn) ||
+	       memslot_is_readonly(slot);
 #else
 	return memslot_is_readonly(slot);
 #endif
 }
 
+
 static unsigned long __gfn_to_hva_many(struct kvm_memory_slot *slot, gfn_t gfn,
 				       gfn_t *nr_pages, bool write)
 {
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
 		return KVM_HVA_ERR_BAD;
-
 	if (gfn_is_readonly(slot, gfn) && write)
 		return KVM_HVA_ERR_RO_BAD;
-
 	if (nr_pages)
 		*nr_pages = slot->npages - (gfn - slot->base_gfn);
 
@@ -1864,14 +1893,55 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
+#ifdef CONFIG_KVM_ROE
 
+static bool kvm_roe_protected_range(struct kvm_memory_slot *slot, gpa_t gpa,
+		int len)
+{
+	struct list_head *pos;
+	struct protected_chunk *cur_chunk;
+
+	list_for_each(pos, slot->prot_list) {
+		cur_chunk = list_entry(pos, struct protected_chunk, list);
+		if (kvm_roe_range_overlap(cur_chunk, gpa, len))
+			return true;
+	}
+	return false;
+}
+static bool kvm_roe_check_range(struct kvm_memory_slot *slot,
+		gfn_t gfn, int offset, int len)
+{
+	gpa_t gpa = (gfn << PAGE_SHIFT) + offset;
+
+	if (!gfn_is_partially_protected(slot, gfn))
+		return false;
+	return kvm_roe_protected_range(slot, gpa, len);
+}
+#endif
+static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
+		int len)
+{
+	u64 addr;
+#ifdef CONFIG_KVM_ROE
+	if (kvm_roe_check_range(slot, gfn, offset, len))
+		return KVM_HVA_ERR_RO_BAD;
+	if (memslot_is_readonly(slot))
+		return KVM_HVA_ERR_RO_BAD;
+	if (gfn_is_fully_protected(slot, gfn))
+		return KVM_HVA_ERR_RO_BAD;
+	addr = __gfn_to_hva_many(slot, gfn, NULL, false);
+#else
+	addr = gfn_to_hva_memslot(slot, gfn);
+#endif
+	return addr;
+}
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
 
-	addr = gfn_to_hva_memslot(memslot, gfn);
+	addr = roe_gfn_to_hva(memslot, gfn, offset, len);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 	r = __copy_to_user((void __user *)addr + offset, data, len);
-- 
2.18.1

