Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B829EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790C720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHERq8Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790C720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeKJGVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:21:46 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47984 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbeKJGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:21:46 -0500
Received: by mail-qk1-f202.google.com with SMTP id f81-v6so5898260qkb.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fRNmz9gb6VrAwP0ad3suXpCd45/0Nzbx55I8Ob0Nxw8=;
        b=lHERq8Q4HYqaAxGtbFCNPXNjW/o1OBADouxj8g1FuxzZEueE/zn25nbHwssVZKcRXG
         6in38OCNmSPHkwrlLMmZ7KPYCQzv5PF5b/5fVyQyPWOm1AmcfC9vyl9B84T8qrWcRyGx
         rWcomYRaHpJbbDn5GcKH54UwEMPYm2jTOIOoY5MkflAJv+Y8A3WuHbpPqigTK53wK+9X
         qWApRbCyNX+1F9am8vCrTSM22C4LklypAScWEKX0NkqbT8kxmO/gFh0Z91D1HO83XQgd
         gKdWYYRDdTugkpaPxi9VubaNIfdDbdiq2uleU3bzzB39RwmZ69nr8VsSMos+QHwPHTYp
         F6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fRNmz9gb6VrAwP0ad3suXpCd45/0Nzbx55I8Ob0Nxw8=;
        b=eXMGBsSnRjE2IgFGKKMleR6cx3UWwsvuDr2qzDiHgyhEjYOTP1WZJPo+s85Bo0peYD
         KJseUsoqTwfsce33jMCo4IswireKPxzPAgx9M0Kj8GNWDPS7sKUXsrGY3rkd9Tc3em9B
         4xty/ue+dqy/HEVC8TwnFSZqs81neGrNeNCXTuKe3jlsY/yQZO18WrnVazXh3H3naMzV
         1Gt9Ijl2KojHP2RWXkpT3o9gwjB05W3fJcRmOrYgh5QqRwG+ztbHuRY8D2QjAHMWVFc4
         4nbxm3hL5l6v4jMCQ8r5Rih+gXZgOMf6mSTh7AqDxYs9t9HB5w1vKjJdoPQPo0Q4Fq3W
         LFJA==
X-Gm-Message-State: AGRZ1gK13LlwhkfRz3fbVIqWtUHtQy9ATpCUmqPPQHAUf5JDZR33DBuQ
        JL3MYlTOz3Ke90uDNNVYmsSdyhGg
X-Google-Smtp-Source: AJdET5c72sXqRFS23DYfcp7KtuzEUK5qHEqYsH1dZDbfT6cQJniU25zASApUpTizlH/1a4frDMn1gl7p
X-Received: by 2002:ac8:fe6:: with SMTP id f35mr4922088qtk.5.1541795972066;
 Fri, 09 Nov 2018 12:39:32 -0800 (PST)
Date:   Fri,  9 Nov 2018 15:39:21 -0500
In-Reply-To: <20181109203921.178363-1-brho@google.com>
Message-Id: <20181109203921.178363-3-brho@google.com>
Mime-Version: 1.0
References: <20181109203921.178363-1-brho@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
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
page table, and we hold the KVM mmu spinlock (grabbed before checking
the mmu seq).

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/kvm/mmu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572f2305..2df8c459dc6a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3152,6 +3152,36 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return -EFAULT;
 }
 
+static bool pfn_is_huge_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	unsigned long hva, map_shift;
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
+	map_shift = dev_pagemap_mapping_shift(hva, current->mm);
+	switch (map_shift) {
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
@@ -3168,7 +3198,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    pfn_is_huge_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
@@ -5678,7 +5708,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 		 */
 		if (sp->role.direct &&
 			!kvm_is_reserved_pfn(pfn) &&
-			PageTransCompoundMap(pfn_to_page(pfn))) {
+			pfn_is_huge_mapped(kvm, sp->gfn, pfn)) {
 			pte_list_remove(rmap_head, sptep);
 			need_tlb_flush = 1;
 			goto restart;
-- 
2.19.1.930.g4563a0d9d0-goog

