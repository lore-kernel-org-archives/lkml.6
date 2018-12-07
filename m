Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588ABC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27C320868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="FwfVLIQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27C320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLGMt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39152 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeLGMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so3688183wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFm+9E+UnB+5zHhGwZfdy/tJxE4uPkVq9Z/8MO+Mr58=;
        b=FwfVLIQQj0GF3CAqCXbKWEKmffl7UehYfQxgkJmqqIeOEMZnIL2lTmLpSehraeOPkn
         jLUMn8ojs1tW+kYoMcu2py14aDoh19c/AflVATtWvCu1X/ylYl1Muyyhj9KRLj31ierE
         dcKwaVc4NQ0QjjTBR7dqcbE5+wR4PF8d9fvDZSb4syO2apCJMWo4NrSQMYxMiX6ZBscO
         1l479oWr3lgfbAYBlHveTaYKQHfF5MQI0xK4MSeNV7D5x7fha4w5N2G0fB9Yyc4slN6g
         VnlLB9dUqH/+qVtT0XTBIxHJSjRW/E2dgjzLE3xfMRDTwFuMRWm1gL+MGIRc4n/Cnt99
         GAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFm+9E+UnB+5zHhGwZfdy/tJxE4uPkVq9Z/8MO+Mr58=;
        b=nIjay+CK952Ok0PU4GmIBGNLgdEQCQzSi8haKshHCt/aA0lO++/6RjnP0nUozE4f7P
         kct9g77c5TECldFjQf1vIJ9kbJNKLfBN/uIKS8OU25jbEVIIMbl5Y9zPZNKCFzg/+rxw
         ptgBCW4jN/+qRHJREkfSC4SD91cgxijSZ0cFm/GdvgiIVaxZiYTq50zRSynOXip6W+j0
         QLWMGlaqhW7ZhVkD4xlFhM2hdft162Y9ERnngCjFfy6BerleB7orF7nogA3L+PcUu+ha
         SIxalSHt24P4m7i49oM1Q79fRX5GnudqtX6qGeNseDU1WSZAiL3kk0vvhwaXCCoJFyF4
         qXFQ==
X-Gm-Message-State: AA+aEWZqtIFVh0BpRy2CDLz8TfK/wK+BUEUWiJlc4l3aBnD9e+L5Mw62
        LPoB5UVHKZsFyQqfTqPHbdIpag==
X-Google-Smtp-Source: AFSGD/XIA0BX2iWpbj3OnFH5xrSCmKZF/cfizoy9v5Cm7239Sd3d8i8mSY3VapkbXWtW9CxE2JdpCQ==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr1638802wrw.150.1544186962697;
        Fri, 07 Dec 2018 04:49:22 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:22 -0800 (PST)
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
Subject: [PATCH 07/10] KVM: Add support for byte granular memory ROE
Date:   Fri,  7 Dec 2018 14:48:00 +0200
Message-Id: <20181207124803.10828-8-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents and implements ROE_MPROTECT_CHUNK, a part of ROE
hypercall designed to protect regions of a memory page with byte
granularity. This feature provides a key primitive to protect against
attacks involving pages remapping.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 include/linux/kvm_host.h      |  24 ++++
 include/uapi/linux/kvm_para.h |   1 +
 virt/kvm/kvm_main.c           |  24 +++-
 virt/kvm/roe.c                | 212 ++++++++++++++++++++++++++++++++--
 virt/kvm/roe_generic.h        |   6 +
 5 files changed, 253 insertions(+), 14 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0baea5afcd..159bef3450 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -294,10 +294,34 @@ static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
  */
 #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
 
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
+
 struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
 	unsigned long *roe_bitmap;
+	unsigned long *partial_roe_bitmap;
+	struct list_head *prot_list;
 	unsigned long *dirty_bitmap;
 	struct kvm_arch_memory_slot arch;
 	unsigned long userspace_addr;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index e6004e0750..4a84f974bc 100644
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
index 814ee0fd35..0d129b05d5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1279,18 +1279,19 @@ static bool memslot_is_readonly(struct kvm_memory_slot *slot)
 
 static bool gfn_is_readonly(struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	return gfn_is_full_roe(slot, gfn) || memslot_is_readonly(slot);
+	return gfn_is_full_roe(slot, gfn) ||
+	       gfn_is_partial_roe(slot, gfn) ||
+	       memslot_is_readonly(slot);
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
 
@@ -1852,14 +1853,29 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
+static u64 roe_gfn_to_hva(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
+		int len)
+{
+	u64 addr;
 
+	if (!slot)
+		return KVM_HVA_ERR_RO_BAD;
+	if (kvm_roe_check_range(slot, gfn, offset, len))
+		return KVM_HVA_ERR_RO_BAD;
+	if (memslot_is_readonly(slot))
+		return KVM_HVA_ERR_RO_BAD;
+	if (gfn_is_full_roe(slot, gfn))
+		return KVM_HVA_ERR_RO_BAD;
+	addr = __gfn_to_hva_many(slot, gfn, NULL, false);
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
diff --git a/virt/kvm/roe.c b/virt/kvm/roe.c
index 3f6eb6ede2..dfb1de314c 100644
--- a/virt/kvm/roe.c
+++ b/virt/kvm/roe.c
@@ -11,34 +11,89 @@
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
 #include <kvm/roe.h>
+#include "roe_generic.h"
 
 int kvm_roe_init(struct kvm_memory_slot *slot)
 {
 	slot->roe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
 			sizeof(unsigned long), GFP_KERNEL);
 	if (!slot->roe_bitmap)
-		return -ENOMEM;
+		goto fail1;
+	slot->partial_roe_bitmap = kvzalloc(BITS_TO_LONGS(slot->npages) *
+			sizeof(unsigned long), GFP_KERNEL);
+	if (!slot->partial_roe_bitmap)
+		goto fail2;
+	slot->prot_list = kvzalloc(sizeof(struct list_head), GFP_KERNEL);
+	if (!slot->prot_list)
+		goto fail3;
+	INIT_LIST_HEAD(slot->prot_list);
 	return 0;
+fail3:
+	kvfree(slot->partial_roe_bitmap);
+fail2:
+	kvfree(slot->roe_bitmap);
+fail1:
+	return -ENOMEM;
+
+}
+
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
+
+bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
+		int len)
+{
+	gpa_t gpa = (gfn << PAGE_SHIFT) + offset;
 
+	if (!gfn_is_partial_roe(slot, gfn))
+		return false;
+	return kvm_roe_protected_range(slot, gpa, len);
 }
 
+
 void kvm_roe_free(struct kvm_memory_slot *slot)
 {
+	struct protected_chunk *pos, *n;
+	struct list_head *head = slot->prot_list;
+
 	kvfree(slot->roe_bitmap);
+	kvfree(slot->partial_roe_bitmap);
+	list_for_each_entry_safe(pos, n, head, list) {
+		list_del(&pos->list);
+		kvfree(pos);
+	}
+	kvfree(slot->prot_list);
 }
 
 static void kvm_roe_protect_slot(struct kvm *kvm, struct kvm_memory_slot *slot,
-		gfn_t gfn, u64 npages)
+		gfn_t gfn, u64 npages, bool partial)
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
 	kvm_roe_arch_commit_protection(kvm, slot);
 }
 
 
-static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
+static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages,
+		bool partial)
 {
 	struct kvm_memory_slot *slot;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
@@ -54,12 +109,12 @@ static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
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
@@ -69,12 +124,13 @@ static int __kvm_roe_protect_range(struct kvm *kvm, gpa_t gpa, u64 npages)
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
@@ -103,7 +159,7 @@ static int kvm_roe_full_protect_range(struct kvm_vcpu *vcpu, u64 gva,
 			continue;
 		if (!access_ok(VERIFY_WRITE, hva, 1 << PAGE_SHIFT))
 			continue;
-		status =  kvm_roe_protect_range(vcpu->kvm, gpa, 1);
+		status =  kvm_roe_protect_range(vcpu->kvm, gpa, 1, false);
 		if (status > 0)
 			count += status;
 	}
@@ -112,6 +168,139 @@ static int kvm_roe_full_protect_range(struct kvm_vcpu *vcpu, u64 gva,
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
+
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
+
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
+
+			prev = list_prev_entry(pos, list);
+			return kvm_roe_insert_chunk_next(&prev->list, gpa,
+					size);
+		}
+	}
+	pos = list_last_entry(head, struct protected_chunk, list);
+
+	return kvm_roe_insert_chunk_next(&pos->list, gpa, size);
+}
+
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
+
 int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3)
 {
 	int ret;
@@ -123,11 +312,14 @@ int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3)
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
diff --git a/virt/kvm/roe_generic.h b/virt/kvm/roe_generic.h
index 36e5b52c5b..ad121372f2 100644
--- a/virt/kvm/roe_generic.h
+++ b/virt/kvm/roe_generic.h
@@ -12,8 +12,14 @@
 
 void kvm_roe_free(struct kvm_memory_slot *slot);
 int kvm_roe_init(struct kvm_memory_slot *slot);
+bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
+		int len);
 static inline bool gfn_is_full_roe(struct kvm_memory_slot *slot, gfn_t gfn)
 {
 	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap);
 }
+static inline bool gfn_is_partial_roe(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return test_bit(gfn - slot->base_gfn, slot->partial_roe_bitmap);
+}
 #endif
-- 
2.19.2

