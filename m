Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ABFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA00F222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="OWPUqTmx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wFbCS/8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393604AbfBOWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:52 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60895 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730460AbfBOWJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 915703058;
        Fri, 15 Feb 2019 17:09:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=b+4owQ22jMmEa
        JxbgoKlHw/S+Iw79LgMeB8j4fvm/+w=; b=OWPUqTmxFQ5a9WHvCV1c3pv0rgwda
        k7X4RrLTo8a67TLIxEEOXgzVmuUQAeKpIbuLSeCJWTt7fawFGN748dglDo/WsoVB
        m6HBkUfqG/wZaiklaIKbOpY+TXEvIQN08fxDq9Hyl40n4JQGSH+mtk9p0fkxnRtU
        Ct1vjYMgrkVbnujGF15r67EXGd7CDwLHqcq7qswpkEsM3QMn58L36/mwZmLoTzm6
        bt3CoGkY4uun6L5roNEGmwc4XmUe2omNRQp6XN0u/MPxkH0ihYI2lC7Vb+B/vBsq
        s4UbfX8JO1IMxwS3lpioxA1p8BVDtaifeAZyFX+OMrvQMq6OFiLLOTDew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=b+4owQ22jMmEaJxbgoKlHw/S+Iw79LgMeB8j4fvm/+w=; b=wFbCS/8Q
        dQ65SYdwaciXiZ4GIs+iLogpwaw48RgAcLS2b+twa65UCcamgOHSqP8QKd07sRTt
        xzuD1xMpUddn4yuxZF+ax/mfTPsjNs5lphxbyUN28ViJ6ydGVdGmB6e3Hy8WOv00
        KUe66i1ihWtA2z1fzi3VEelkgFGimuNdpcogFedTF/0QoMMokMUPYsxzuVVZ0luW
        VL9x6oEBY1MwyhPAn2oF62dAxS1+8stPYogU9TMlZZJ+ipmojV97RZ8qbYkix7NQ
        9ivTYwGmuoMu7XnZ4QsU5Yv9T8gfrfkEW/q6QvUG6xRU5iKm19krNdrfbGXEnihK
        73G9qZfSRIgopQ==
X-ME-Sender: <xms:pjhnXM3x5xZ2-9goOkWq3MVoGv7W23GcM69UQcGuJNpZ56scWKCUwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:pzhnXBwvlhNqQpSJdUyYUYxYg-ailZHWlRZgVfjtTjP3fE8nw-REEw>
    <xmx:pzhnXBWYlWjmwsyvUv-PfPviTkHG3H3J3CxmRIyYe93e8siKGgud9Q>
    <xmx:pzhnXL1xgQFOrOG3D4FK5l5m028DxuvsPSOdnYdGUiomW_vG5aawUg>
    <xmx:pzhnXKosD7tx--Bp2thzLiva4qVYzY2oAIaUKpbeUUXCSg7PpzQ-IA>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83858E46AD;
        Fri, 15 Feb 2019 17:09:41 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 30/31] mm: mem_defrag: thp: PMD THP and PUD THP in-place promotion support.
Date:   Fri, 15 Feb 2019 14:08:55 -0800
Message-Id: <20190215220856.29749-31-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215220856.29749-1-zi.yan@sent.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

PMD THPs will get PMD page table entry promotion as well.
PUD THPs only gets PUD page table entry promotion when the toggle is
on, which is off by default. Since 1GB THP performs not so good due to
shortage of 1GB TLB entries.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/mem_defrag.c | 79 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/mm/mem_defrag.c b/mm/mem_defrag.c
index 4d458b125c95..d7a579924d12 100644
--- a/mm/mem_defrag.c
+++ b/mm/mem_defrag.c
@@ -56,6 +56,7 @@ struct defrag_result_stats {
 	unsigned long dst_non_lru_failed;
 	unsigned long dst_non_moveable_failed;
 	unsigned long not_defrag_vpn;
+	unsigned int aligned_max_order;
 };
 
 enum {
@@ -689,6 +690,10 @@ int defrag_address_range(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		page_size = get_contig_page_size(scan_page);
 
+		if (compound_order(compound_head(scan_page)) == HPAGE_PUD_ORDER) {
+			defrag_stats->aligned_max_order = HPAGE_PUD_ORDER;
+			goto quit_defrag;
+		}
 		/* PTE-mapped THP not allowed  */
 		if ((scan_page == compound_head(scan_page)) &&
 			PageTransHuge(scan_page) && !PageHuge(scan_page))
@@ -714,6 +719,8 @@ int defrag_address_range(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* already in the contiguous pos  */
 		if (page_dist == (long long)(scan_page - anchor_page)) {
 			defrag_stats->aligned += (page_size/PAGE_SIZE);
+			defrag_stats->aligned_max_order = max(defrag_stats->aligned_max_order,
+				compound_order(scan_page));
 			continue;
 		} else { /* migrate pages according to the anchor pages in the vma.  */
 			struct page *dest_page = anchor_page + page_dist;
@@ -901,6 +908,10 @@ int defrag_address_range(struct mm_struct *mm, struct vm_area_struct *vma,
 			} else { /* exchange  */
 				int err = -EBUSY;
 
+				if (compound_order(compound_head(dest_page)) == HPAGE_PUD_ORDER) {
+					defrag_stats->aligned_max_order = HPAGE_PUD_ORDER;
+					goto quit_defrag;
+				}
 				/* PTE-mapped THP not allowed  */
 				if ((dest_page == compound_head(dest_page)) &&
 					PageTransHuge(dest_page) && !PageHuge(dest_page))
@@ -1486,10 +1497,13 @@ static int kmem_defragd_scan_mm(struct defrag_scan_control *sc)
 				up_read(&vma->vm_mm->mmap_sem);
 			} else if (sc->action == MEM_DEFRAG_DO_DEFRAG) {
 				/* go to nearest 1GB aligned address  */
+				unsigned long defrag_begin = *scan_address;
 				unsigned long defrag_end = min_t(unsigned long,
 							(*scan_address + HPAGE_PUD_SIZE) & HPAGE_PUD_MASK,
 							vend);
 				int defrag_result;
+				int nr_fails_in_1gb_range = 0;
+				int skip_promotion = 0;
 
 				anchor_node = get_anchor_page_node_from_vma(vma, *scan_address);
 
@@ -1583,14 +1597,47 @@ static int kmem_defragd_scan_mm(struct defrag_scan_control *sc)
 					 * skip the page which cannot be defragged and restart
 					 * from the next page
 					 */
-					if (defrag_stats.not_defrag_vpn &&
-						defrag_stats.not_defrag_vpn < defrag_sub_chunk_end) {
+					if (defrag_stats.not_defrag_vpn) {
 						VM_BUG_ON(defrag_sub_chunk_end != defrag_end &&
 							defrag_stats.not_defrag_vpn > defrag_sub_chunk_end);
-
-						*scan_address = defrag_stats.not_defrag_vpn;
-						defrag_stats.not_defrag_vpn = 0;
-						goto continue_defrag;
+						find_anchor_pages_in_vma(mm, vma, defrag_stats.not_defrag_vpn);
+
+						nr_fails_in_1gb_range += 1;
+						if (defrag_stats.not_defrag_vpn < defrag_sub_chunk_end) {
+							/* reset and continue  */
+							*scan_address = defrag_stats.not_defrag_vpn;
+							defrag_stats.not_defrag_vpn = 0;
+							goto continue_defrag;
+						}
+					} else {
+						/* defrag works for the whole chunk,
+						 * promote to THP in place
+						 */
+						if (!defrag_result &&
+							/* skip existing THPs */
+							defrag_stats.aligned_max_order < HPAGE_PMD_ORDER &&
+							!(*scan_address & (HPAGE_PMD_SIZE-1)) &&
+							!(defrag_sub_chunk_end & (HPAGE_PMD_SIZE-1))) {
+							int ret = 0;
+							/* find a range to promote pmd */
+							down_write(&mm->mmap_sem);
+							ret = promote_huge_page_address(vma, *scan_address);
+							if (!ret) {
+								/*
+								 * promote to 2MB THP successful, but it is
+								 * still PTE pointed
+								 */
+								/* promote PTE-mapped THP to PMD-mapped */
+								promote_huge_pmd_address(vma, *scan_address);
+							}
+							up_write(&mm->mmap_sem);
+						}
+						/* skip PUD pages */
+						if (defrag_stats.aligned_max_order == HPAGE_PUD_ORDER) {
+							*scan_address = defrag_end;
+							skip_promotion = 1;
+							continue;
+						}
 					}
 
 					/* Done with current 2MB chunk */
@@ -1606,6 +1653,26 @@ static int kmem_defragd_scan_mm(struct defrag_scan_control *sc)
 					}
 				}
 
+				/* defrag works for the whole chunk, promote to PUD THP in place */
+				if (!nr_fails_in_1gb_range &&
+					!skip_promotion && /* avoid existing THP */
+					!(defrag_begin & (HPAGE_PUD_SIZE-1)) &&
+					!(defrag_end & (HPAGE_PUD_SIZE-1))) {
+					int ret = 0;
+					/* find a range to promote pud */
+					down_write(&mm->mmap_sem);
+					ret = promote_huge_pud_page_address(vma, defrag_begin);
+					if (!ret) {
+						/*
+						 * promote to 1GB THP successful, but it is
+						 * still PMD pointed
+						 */
+						/* promote PMD-mapped THP to PUD-mapped */
+						if (mem_defrag_promote_1gb_thp)
+							promote_huge_pud_address(vma, defrag_begin);
+					}
+					up_write(&mm->mmap_sem);
+				}
 			}
 		}
 done_one_vma:
-- 
2.20.1

