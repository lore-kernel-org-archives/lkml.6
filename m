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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A20C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D208222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="i82NFi9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a41IDbu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393520AbfBOWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:09:41 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35133 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393469AbfBOWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:09:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B6AA9310A;
        Fri, 15 Feb 2019 17:09:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Feb 2019 17:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=EYbvEGR5T55O/
        whT3ormGMsc4OjejtdS/ncHWvxXxkQ=; b=i82NFi9clRWllhWB+1WAQDVTJSxf2
        jkZ+OZAH1x/MG1hPo+I91aXGzCqHNZqN/VbppOW4xJYXO4kNZfKmmcVg6gK/K8YM
        fsd2Eew3vCg8A5AxWQpjCGI2G22ajdn05x7sotOilp56JcFmTWtM+rDWjnCxsOPI
        mAtnifkzdIbVhOTNOBOTM3e5rOLAJ7g4zykkGNg9Jc/UYSG2BhMq+n106msRfV9i
        ZIOVP1PIZVEnuj/NwEZFV6XpzaSW5WDH0RdHpc9iAvwRaGnPCWbLkcLWsFtSNqsx
        eToUv6aDMEdcKSq6T89UMR1bm4VTPcZRPoce57vAp475TeBacI19f1Jgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=EYbvEGR5T55O/whT3ormGMsc4OjejtdS/ncHWvxXxkQ=; b=a41IDbu3
        5RvxGLl/hTeM1wR3EQ9zuSaqUa3N/oLwo1XIObh6/XEIjeq8g8IFvjLlyqals5Sa
        ckfgVcYysYgWcyp/M++lW2PcvAXKaTHPKVEXYvTEfcmnPU+87hMTXTzkacOFTebi
        /gmTBScgG9ZTVAaKE29y1CX+rg4dwjekj0vLs9uuO9kfeDV7ASd2gy0n4azIeLKc
        A1jGIaQFVmk1iXi20m5uRATMbjTLmL1KM0qVAaaMS0Oj3X0Q3K6r2hzrPJv9p7aJ
        KfP5r7sSURNfkcQrpyxop7Y8d5r2tjMu/jLM9DS64ZFD23CsgRYFGOkZQYY6WVfp
        hjV+pVn0qBJ72g==
X-ME-Sender: <xms:nThnXH9mjHl8YGa-yOYXgO5plywmTDc7i6epfRjTNv7g2vNE_1KtZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtjedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkf
    fojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghnuceoiihirdihrghn
    sehsvghnthdrtghomheqnecukfhppedvudeirddvvdekrdduuddvrddvvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomhenucevlhhushhtvghr
    ufhiiigvpedvvd
X-ME-Proxy: <xmx:nThnXDEVJkV_hM72tcbdo7pebFQDt3G71YnQf5AieEy3_bMYDDoAzg>
    <xmx:nThnXHl4RnGCNoatF2ox2lA-MQsC-CYCjghd6Dd0XFsRWvtj2CisxA>
    <xmx:nThnXErGKbXI2wgyjb0Tbyxn4yOi3cX8Xo9klJhvCqKimZB29XSoFQ>
    <xmx:nThnXFpbYtB2yNpp-J_95fonAyrP1QR-t7LcPkvxhkP_oycOH45zBg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5B2AE4511;
        Fri, 15 Feb 2019 17:09:31 -0500 (EST)
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
Subject: [RFC PATCH 23/31] mm: support 1GB THP pagemap support.
Date:   Fri, 15 Feb 2019 14:08:48 -0800
Message-Id: <20190215220856.29749-24-zi.yan@sent.com>
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

Print page flags properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f0ec9edab2f3..ccf8ce760283 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1373,6 +1373,45 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	return err;
 }
 
+static int pagemap_pud_range(pud_t *pudp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	int err = 0;
+	u64 flags = 0, frame = 0;
+	pud_t pud = *pudp;
+	struct page *page = NULL;
+
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
+
+	if (pud_present(pud)) {
+		page = pud_page(pud);
+
+		flags |= PM_PRESENT;
+		if (pud_soft_dirty(pud))
+			flags |= PM_SOFT_DIRTY;
+		if (pm->show_pfn)
+			frame = pud_pfn(pud) +
+				((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	}
+
+	if (page && page_mapcount(page) == 1)
+		flags |= PM_MMAP_EXCLUSIVE;
+
+	for (; addr != end; addr += PAGE_SIZE) {
+		pagemap_entry_t pme = make_pme(frame, flags);
+
+		err = add_to_pagemap(addr, &pme, pm);
+		if (err)
+			break;
+		if (pm->show_pfn && (flags & PM_PRESENT))
+			frame++;
+	}
+	return err;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
 static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
@@ -1479,6 +1518,9 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	if (!pm.buffer)
 		goto out_mm;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	pagemap_walk.pud_entry = pagemap_pud_range;
+#endif
 	pagemap_walk.pmd_entry = pagemap_pmd_range;
 	pagemap_walk.pte_hole = pagemap_pte_hole;
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.20.1

