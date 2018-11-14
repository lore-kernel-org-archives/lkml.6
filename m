Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CDF22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taFjDK0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CDF22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbeKOI2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:28:14 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52597 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKOI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:28:13 -0500
Received: by mail-vk1-f201.google.com with SMTP id c1so2856912vkf.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TjNbpFDEmROOYDgX+JBtXjmBSAKa/KDKnxWS9mQYdnM=;
        b=taFjDK0teNWIgkT/L+183FUK7Rjv5BiYjc2vj9n0IhdJavI+1kbRzaJU2Yiiu0h737
         Wh0YUHhy9yDVHl+9c4GqoLinKZL/hiYqZIJgsfeS1QhSZjd36eM3bD78H/Q8sGHJ+vLm
         I7/MEgB1fNMShiA10dPq+M3pt1sOc2JWuVUnU9G7dxuXUvzheuRMYLSs/jlRC6c7hyFE
         APQR91LYXzb4ENO5mM4jbgKl9V7Yus/mOvA2PBY5nGoYkqPxnKIh+QLY4Uv0+ZDJUDRJ
         lfa4l23S3nN7B/tI6vj3q9nyARf3QBI5df/wHX2XKckqMBtglSEKQIibBZ0wwNQznCwd
         GYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TjNbpFDEmROOYDgX+JBtXjmBSAKa/KDKnxWS9mQYdnM=;
        b=H4jOxolonF69tywY7CuhDYSDUo5RqvRWohTBpuKA3DYPBiePqU9pWazUfcxL6omiEp
         Bht3cWEcVDjAIImqHUM3thazzOjfDaV0mdgePsux6EseLWWlyqBPRBJnD4pIzCE96e1q
         n5LF0EaE2mzEo+EIfFwRmhDcDvqRG28guUcFNAaGhsYmweEeoMAzsnRoTZ9dNQUwNcEB
         iWvvrY2oRL1RWc3AXyY7OWxCE1nBRvOUFwof6KV+Lb+iu79V4vuzfuW5sTu716xMz8Yf
         5LpL/eMkqAk6VjXy4yp+DyK/Ythmrgwwl8gtdf34lCBKymN6HNjlYokXGH96ASHDUk9J
         FT3A==
X-Gm-Message-State: AGRZ1gLmFrK5wAwwXL17TAEeOfX7SS+VjC4DUlU2RMbpWIsM3znZFZC8
        GNlbo9bJZGCTV5nozqXHwmiqueaZ
X-Google-Smtp-Source: AJdET5fxjUluLcn0PMYFFDQMUPhJJ6f6///VYVv7kfdG0gbmeQPMhsaCe6AtiBa2pml32koG0VHN598e
X-Received: by 2002:ab0:72d6:: with SMTP id g22mr3170146uap.14.1542232387447;
 Wed, 14 Nov 2018 13:53:07 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:51:54 -0500
In-Reply-To: <20181114215155.259978-1-brho@google.com>
Message-Id: <20181114215155.259978-3-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com> <20181114215155.259978-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH v2 2/3] kvm: Use huge pages for DAX-backed files
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows KVM to map DAX-backed files made of huge pages with
huge mappings in the EPT/TDP.

DAX pages are not PageTransCompound.  The existing check is trying to
determine if the mapping for the pfn is a huge mapping or not.  For
non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
For DAX, we can check the page table itself.

Note that KVM already faulted in the page (or huge page) in the host's
page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.

Signed-off-by: Barret Rhoden <brho@google.com>
---
- removed map_shift local variable

 arch/x86/kvm/mmu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572f2305..6914989d1e3d 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3152,6 +3152,35 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return -EFAULT;
 }
 
+static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	unsigned long hva;
+
+	if (!is_zone_device_page(page))
+		return PageTransCompoundMap(page);
+
+	/*
+	 * DAX pages do not use compound pages.  The page should have already
+	 * been mapped into the host-side page table during try_async_pf(), so
+	 * we can check the page tables directly.
+	 */
+	hva = gfn_to_hva(kvm, gfn);
+	if (kvm_is_error_hva(hva))
+		return false;
+
+	/*
+	 * Our caller grabbed the KVM mmu_lock with a successful
+	 * mmu_notifier_retry, so we're safe to walk the page table.
+	 */
+	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
+	case PMD_SHIFT:
+	case PUD_SIZE:
+		return true;
+	}
+	return false;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 					gfn_t *gfnp, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3168,7 +3197,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
@@ -5678,7 +5707,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 */
 		if (sp->role.direct &&
 			!kvm_is_reserved_pfn(pfn) &&
-			PageTransCompoundMap(pfn_to_page(pfn))) {
+			pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
 			pte_list_remove(rmap_head, sptep);
 			need_tlb_flush = 1;
 			goto restart;
-- 
2.19.1.1215.g8438c0b245-goog

