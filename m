Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBDEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9B020866
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMAauyh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9B020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeKBGjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:39:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45358 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeKBGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:39:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id v5-v6so5058596pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rjrUyw1RPZidI5kOdNW3wqYtFmnuv+jbS2ZhN+LzVYs=;
        b=SMAauyh0rPJ22d1n3OvssA1B0MyVw7I5CklMny2bZKrbrY6n8CHl0fbpGQUgJ3R8Jr
         BWEWmZ+PFBEaauFUPYzVCMbWpBls/EdBHulDhsMjmzCqMbKsFw0txBsUHl0z2j2HlJRE
         3rWgg9lyVJ7WOzHZeo/b3wFcLiEqCbRAtRIigx3NF/mLySSAfOR3rmFyT4GUKBbMa2s2
         hKec6+A6tcCiDrpgha6YC2wpJVzF08NAxzVXWawCbNQiSyub0zwnmICWM9eHMBWTw1Cx
         0Cm4OnC1Ym6gvG4WlnXz3ltZYyRnQmmaaIbuuUy8dnfEKodNZUlOBPRnB6PMTvKZ6r8Y
         tONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rjrUyw1RPZidI5kOdNW3wqYtFmnuv+jbS2ZhN+LzVYs=;
        b=HLXuK/vcB3Z8iWryzIXl9eMkgEOE/qniB+02FqvmWX12LdYkA3WS21U67NWWrib5r+
         iMZPjazHsLQVyl4EFcBcKTmij/WYGa4MxS9r2kAbwN75TvvB5cA9GLF90Zwjqf3sv8FC
         vJjI32KrN+aAXT5h+3ES31z+7eSmdCwUMe6IvB6i6BspTSNblJfTX7qe0XkYwPz4jgfs
         IcwIkts3G2Ok8awcMHh3gwjOPqEI3P5KgJBt3v4MnbmEAfpg3v5i5v3wRVZfLz3wMvAr
         Ts/1Y+2jlTxGtD5hJEdET6UR/zZYKi9o9Q3k8PUWIT70e27PMrbabnUOLe4otIOG8ipy
         G2iw==
X-Gm-Message-State: AGRZ1gJV/+0yQJ9tGXCL2lbdb7KQc31wlS9iyDJXNeSTOpzvteAaPVC0
        Abc0QS12UqmHTUB3dqfJ934=
X-Google-Smtp-Source: AJdET5cnwBC8kf8uSN3zsHk6xhJbvlRTQfA9pK/q8hsEg/I/zxMJl+kCyqvFt2iLYYSMUXlwGTXH/Q==
X-Received: by 2002:a63:1013:: with SMTP id f19-v6mr8731982pgl.38.1541108110392;
        Thu, 01 Nov 2018 14:35:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q11-v6sm9052227pgp.62.2018.11.01.14.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:35:09 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Date:   Thu,  1 Nov 2018 14:35:00 -0700
Message-Id: <20181101213500.21800-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __GFP_ZERO will be passed down to the generic page allocation
routine which zeros everything page by page. This is safe to be a
generic way but not efficient for iommu allocation that organizes
contiguous pages using scatterlist.

So this changes drops __GFP_ZERO from the flag, and adds a manual
memset after page/sg allocations, using the length of scatterlist.

My test result of a 2.5MB size allocation shows iommu_dma_alloc()
takes 46% less time, reduced from averagely 925 usec to 500 usec.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b04753b204..e48d995e65c5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -551,10 +551,13 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
+	struct scatterlist *s;
 	struct page **pages;
 	struct sg_table sgt;
 	dma_addr_t iova;
 	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
+	bool gfp_zero = false;
+	int i;
 
 	*handle = IOMMU_MAPPING_ERROR;
 
@@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
 		alloc_sizes = min_size;
 
+	/*
+	 * The generic zeroing in a length of one page size is slow,
+	 * so do it manually in a length of scatterlist size instead
+	 */
+	if (gfp & __GFP_ZERO) {
+		gfp &= ~__GFP_ZERO;
+		gfp_zero = true;
+	}
+
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
 	if (!pages)
@@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
 		goto out_free_iova;
 
+	if (gfp_zero) {
+		/* Now zero all the pages in the scatterlist */
+		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
+			memset(sg_virt(s), 0, s->length);
+	}
+
 	if (!(prot & IOMMU_CACHE)) {
 		struct sg_mapping_iter miter;
 		/*
-- 
2.17.1

