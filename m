Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69871C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D362082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXJkdVYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D362082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJ3F5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:57:48 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35574 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeJ3F5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:57:48 -0400
Received: by mail-qt1-f202.google.com with SMTP id d12-v6so11320164qtj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tHymFGFRgVecm8/hoaasAtMklgjSpPGwZy4Dhx4CQcI=;
        b=rXJkdVYNjvko/d7tCVV2PxcDPmKk+SpDHkVgbqGPSfPe4lCb7GdU1I+PIBxqYhYE/N
         pI35/TZxJt+sXjtQV2ayaXnoWjftMhBgdEFtgQih2Sle5IgviCAOUkS5mebxdjGa0LB/
         BCSLh/dkp1WPiFahTr9V3nJn2/qL4ltwqdiXFqlkf89tGrJkTsLkTHJ7gdweOMb/e+W/
         K085WARc05xFKvaL4KsYRbwULTXorIRDQDdJ1HSJ1Ii2sYA48mq4Y6RZe/BSNyN/Ah6a
         +gb20+2VtVF8kZH0u6+OsKB2Yn4cgZnLkfdmRnBX4qlygk5i8K7bEcqiFUXgBKqt5UgZ
         uXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tHymFGFRgVecm8/hoaasAtMklgjSpPGwZy4Dhx4CQcI=;
        b=s/oR1baWfla6V8ti9jUMe1d5ToL6ZtajZVhXaxklztNakP6LTEsiWOagEEh+/F91dD
         u8TphtEiAjclfrkJlM5PftrmDCFNPqhikosLLsuva9E6aUvqOvK3j/BERvOg0DDQa3AY
         DcLkFAlodohnUWhTG4zBi+7mp9Rxc+FDDiNTa7/B8iEPjpz1JmDOfTIBcVHJVzilWepn
         Eu3Ir7mDxGkXZArcsOVeUp5zl/cywvCjreEukEDM3IweukB6o8fxwhYfdgM80ZuTEssH
         Af3FdxZoYtmqYhlg8aLx1lAsikhFG9NzAyugbe7xKIWNVV0iI9K3+Vf1LE37Qf2QmSgC
         SGUQ==
X-Gm-Message-State: AGRZ1gLPcwVf/JtkAss7HJjlIRnVUw+kmmH3nqTIiQ2m8VWWlMLOsJ/Z
        oXLF3pwNg2+MDldgkEcUmIGSIUEk
X-Google-Smtp-Source: AJdET5cHjhBYlNA4W6lTtgTUjgW3mOR/w6u3S+SVErmPmREKZEMGprwHc/6C+UrEkkyQuMM7U/65BQPN
X-Received: by 2002:ac8:4108:: with SMTP id q8-v6mr11520qtl.17.1540847242527;
 Mon, 29 Oct 2018 14:07:22 -0700 (PDT)
Date:   Mon, 29 Oct 2018 17:07:16 -0400
Message-Id: <20181029210716.212159-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC PATCH] kvm: Use huge pages for DAX-backed files
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

For DAX, we can check the page table itself.  Actually, we might always
be able to walk the page table, even for PageTransCompound pages, but
it's probably a little slower.

Note that KVM already faulted in the page (or huge page) in the host's
page table, and we hold the KVM mmu spinlock (grabbed before checking
the mmu seq).  Based on the other comments about not worrying about a
pmd split, we might be able to safely walk the page table without
holding the mm sem.

This patch relies on kvm_is_reserved_pfn() being false for DAX pages,
which I've hacked up for testing this code.  That change should
eventually happen:

https://lore.kernel.org/lkml/20181022084659.GA84523@tiger-server/

Another issue is that kvm_mmu_zap_collapsible_spte() also uses
PageTransCompoundMap() to detect huge pages, but we don't have a way to
get the HVA easily.  Can we just aggressively zap DAX pages there?

Alternatively, is there a better way to track at the struct page level
whether or not a page is huge-mapped?  Maybe the DAX huge pages mark
themselves as TransCompound or something similar, and we don't need to
special case DAX/ZONE_DEVICE pages.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/kvm/mmu.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572f2305..9f3e0f83a2dd 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3152,6 +3152,75 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return -EFAULT;
 }
 
+static unsigned long pgd_mapping_size(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset(mm, addr);
+	if (!pgd_present(*pgd))
+		return 0;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return 0;
+	if (p4d_huge(*p4d))
+		return P4D_SIZE;
+
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud))
+		return 0;
+	if (pud_huge(*pud))
+		return PUD_SIZE;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return 0;
+	if (pmd_huge(*pmd))
+		return PMD_SIZE;
+
+	pte = pte_offset_map(pmd, addr);
+	if (!pte_present(*pte))
+		return 0;
+	return PAGE_SIZE;
+}
+
+static bool pfn_is_pmd_mapped(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+	unsigned long hva, map_sz;
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
+	map_sz = pgd_mapping_size(current->mm, hva);
+	switch (map_sz) {
+	case PMD_SIZE:
+		return true;
+	case P4D_SIZE:
+	case PUD_SIZE:
+		printk_once(KERN_INFO "KVM THP promo found a very large page");
+		return false;
+	}
+	return false;
+}
+
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 					gfn_t *gfnp, kvm_pfn_t *pfnp,
 					int *levelp)
@@ -3168,7 +3237,7 @@ static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
 	 */
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn) &&
 	    level == PT_PAGE_TABLE_LEVEL &&
-	    PageTransCompoundMap(pfn_to_page(pfn)) &&
+	    pfn_is_pmd_mapped(vcpu->kvm, gfn, pfn) &&
 	    !mmu_gfn_lpage_is_disallowed(vcpu, gfn, PT_DIRECTORY_LEVEL)) {
 		unsigned long mask;
 		/*
-- 
2.19.1.568.g152ad8e336-goog

