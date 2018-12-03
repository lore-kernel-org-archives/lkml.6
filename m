Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEEC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCC82081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+JsJRLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCC82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLCXu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:50:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46753 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:50:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so6445339pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uwrfYo1uyTQr1sWQ/8x1R/k/a8VXLrhkMIWp7pl0lzM=;
        b=S+JsJRLkg/UYG0sqxbL8JOi5dhctVrU/AmABeyLqV9JqYlcPzL4jHXPPsw6Vh37lVM
         FYj2ddKY6ceX1GiALfHcIMu6fsnp5xhSQL56QbZou63bbSMAZl5jmuSWPpjhFV1lgzdv
         qiHuscC6mAbIlWWlEqy1bbq7uheZY0Hfzn1yoH1dsa8rfVW3ucujLmx4ryQLSUAL7JGX
         sDZU+wqdMfiT5H04y+PCfmw527g5NBu/orhqI2Ey8VdVvamu17r/iC9kfFzvOsWyBuzp
         zcc9qmTQWDLPk+1yduuVl4Ea9R9HTXA+0XdKXPHe992ggTSJJn1hdlULz1Iki1kb3NJE
         zArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uwrfYo1uyTQr1sWQ/8x1R/k/a8VXLrhkMIWp7pl0lzM=;
        b=Suyce33u3dSLuewNn8sV5GKxebK7QmC4M2dQGnRHGnVLcsPLwROiDMymS3zuqRgqGx
         a1LrZ/t3KoxjfeN+yav/2KA3R6odDA8lLNhxtXX0/g0EXsNWgQiOpLuR/lH7a0rFmW9g
         fXyjo8jPKW1lApzPAgWbiKFmkZDP64DVBJ//ha5mhfh7QRgm+IvOD82dQwiaVIuNHPSp
         kOi7bYf8sOOrthI+8wa0z9Tu07V51DRH0l/ESSOosCo7yiqngoZG9DlHAjggl1r6NwXC
         riBAWn79wcHI2j0smg8vJWyJzu3wxNdHl3JxM0pcr79t7M/T5MzeLtbsCrDnjBiVIFvb
         73Nw==
X-Gm-Message-State: AA+aEWbwpoQrBj+vgvdzJYNUpxRPjJ57Rs+VcXiRQIPGQWSInw79gfCN
        O6J0fmLeT7nLIMQxel2q75hPJg==
X-Google-Smtp-Source: AFSGD/VERmNWPY1lAwWtRULCDPswdikZkXnH2A/R3ckL49Ibxbvn58AdSrmV59u4cT+isamCiRHKOQ==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr14744413pgl.274.1543881026116;
        Mon, 03 Dec 2018 15:50:26 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b185sm26558821pga.85.2018.12.03.15.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:50:25 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:50:24 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
cc:     ying.huang@intel.com, Michal Hocko <mhocko@suse.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: [patch 1/2 for-4.20] mm, thp: restore node-local hugepage
 allocations
In-Reply-To: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1812031545560.161134@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a full revert of ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for
MADV_HUGEPAGE mappings") and a partial revert of 89c83fb539f9 ("mm, thp:
consolidate THP gfp handling into alloc_hugepage_direct_gfpmask").

By not setting __GFP_THISNODE, applications can allocate remote hugepages
when the local node is fragmented or low on memory when either the thp
defrag setting is "always" or the vma has been madvised with
MADV_HUGEPAGE.

Remote access to hugepages often has much higher latency than local pages
of the native page size.  On Haswell, ac5b2c18911f was shown to have a
13.9% access regression after this commit for binaries that remap their
text segment to be backed by transparent hugepages.

The intent of ac5b2c18911f is to address an issue where a local node is
low on memory or fragmented such that a hugepage cannot be allocated.  In
every scenario where this was described as a fix, there is abundant and
unfragmented remote memory available to allocate from, even with a greater
access latency.

If remote memory is also low or fragmented, not setting __GFP_THISNODE was
also measured on Haswell to have a 40% regression in allocation latency.

Restore __GFP_THISNODE for thp allocations.

Fixes: ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings")
Fixes: 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask")

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/mempolicy.h |  2 --
 mm/huge_memory.c          | 42 +++++++++++++++------------------------
 mm/mempolicy.c            |  7 ++++---
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -139,8 +139,6 @@ struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr);
-struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
-						unsigned long addr);
 bool vma_policy_mof(struct vm_area_struct *vma);
 
 extern void numa_default_policy(void);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -632,37 +632,27 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
 {
 	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
-	gfp_t this_node = 0;
-
-#ifdef CONFIG_NUMA
-	struct mempolicy *pol;
-	/*
-	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
-	 * specified, to express a general desire to stay on the current
-	 * node for optimistic allocation attempts. If the defrag mode
-	 * and/or madvise hint requires the direct reclaim then we prefer
-	 * to fallback to other node rather than node reclaim because that
-	 * can lead to excessive reclaim even though there is free memory
-	 * on other nodes. We expect that NUMA preferences are specified
-	 * by memory policies.
-	 */
-	pol = get_vma_policy(vma, addr);
-	if (pol->mode != MPOL_BIND)
-		this_node = __GFP_THISNODE;
-	mpol_cond_put(pol);
-#endif
+	const gfp_t gfp_mask = GFP_TRANSHUGE_LIGHT | __GFP_THISNODE;
 
+	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE | (vma_madvised ? 0 : __GFP_NORETRY);
+		return GFP_TRANSHUGE | __GFP_THISNODE |
+		       (vma_madvised ? 0 : __GFP_NORETRY);
+
+	/* Kick kcompactd and fail quickly */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM | this_node;
+		return gfp_mask | __GFP_KSWAPD_RECLAIM;
+
+	/* Synchronous compaction if madvised, otherwise kick kcompactd */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     __GFP_KSWAPD_RECLAIM | this_node);
+		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM :
+						  __GFP_KSWAPD_RECLAIM);
+
+	/* Only do synchronous compaction if madvised */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags))
-		return GFP_TRANSHUGE_LIGHT | (vma_madvised ? __GFP_DIRECT_RECLAIM :
-							     this_node);
-	return GFP_TRANSHUGE_LIGHT | this_node;
+		return gfp_mask | (vma_madvised ? __GFP_DIRECT_RECLAIM : 0);
+
+	return gfp_mask;
 }
 
 /* Caller must hold page table lock. */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1116,8 +1116,9 @@ static struct page *new_page(struct page *page, unsigned long start)
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-		thp = alloc_pages_vma(GFP_TRANSHUGE, HPAGE_PMD_ORDER, vma,
-				address, numa_node_id());
+		thp = alloc_pages_vma(GFP_TRANSHUGE | __GFP_THISNODE,
+				      HPAGE_PMD_ORDER, vma, address,
+				      numa_node_id());
 		if (!thp)
 			return NULL;
 		prep_transhuge_page(thp);
@@ -1662,7 +1663,7 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * freeing by another task.  It is the caller's responsibility to free the
  * extra reference for shared policies.
  */
-struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
+static struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 						unsigned long addr)
 {
 	struct mempolicy *pol = __get_vma_policy(vma, addr);
