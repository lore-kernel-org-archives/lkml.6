Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEB320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJVbo1mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEB320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeLFSj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:39:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36539 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbeLFSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:39:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so567386plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sjptjlxh1owWZKhohVrkOEeOt6dJ2dnRERAUBGGJRzo=;
        b=XJVbo1mVNUPsRUa49x9iPWHWzpgb6rsqCpilpKc5Erku9gr23F/8jGJclplfZqouIu
         9W2iKcRBb+uYGakLbYF26F0BYeTb0IZw6x1uOISBC4U34diG7gWmvVXPxYEYd4ehI42R
         sPavmw6/0rbWcUBjbdDwcAtBRyw67HR9rhg7saq9lfh9GWMOQwbTD8w9JB5e/ynwaCfp
         /1gI0Vlri11+t5gHus826QWCn4A/XQPpqrjX/cDcakpAVOcdMg53iKxcbyMiF5Sn+nO1
         U9r7/tfyqR0qNIOw1/H2SB2ZTMP/8OHu1FrDQjrGvr6bgHN06ozJo7a9GQ81GrHSsQkK
         Cbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sjptjlxh1owWZKhohVrkOEeOt6dJ2dnRERAUBGGJRzo=;
        b=pMHYXIzSAdVOXm8e00xvWUQxIUgKxwLZq3emi8C7pyncLnR7QSFvrs5NYzyCli0eKV
         hdBe0Ui7Oyi6Nv5mMUmQyQuGE26MIM97Y+D5WNXllVNVd740PkiHPhu79QrKgaxfdqqJ
         Bqsm2nyspDk3fDEYLkiWa3yDweDYg+bdsB71r1bNFUQdlwgcL0IfbLr+SGtEfsVtT0Zh
         A6rInE5HDpt+Bui2RrZZIjxKz4Sxgc16GqKpBDAeKcv5/zrKVHwg7gWbz+sTfRICIBPc
         Bi3SdOThsoIsyXFT5S/KYNOOfuDgwsI6SHNltRFBeaxjWQQnZwjqCimw10taGfbJ1+5q
         8WyA==
X-Gm-Message-State: AA+aEWZ5o6ZyQdkGWU3dR2Q+TdyiAVJ8AY5nII159FBsB2Irx0r4Kxkn
        muiHsiHF9UocQy5Fmz6DtOU=
X-Google-Smtp-Source: AFSGD/VNnI3Z5UaH7h9TyFGXwiDnq2+6sodXbwQm7ri9n8PQRYJ402gtVTtYmhUEYvPgUZVzoKVTsQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr28602536plb.166.1544121596529;
        Thu, 06 Dec 2018 10:39:56 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id 4sm3051359pfq.10.2018.12.06.10.39.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:39:55 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:13:43 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181206184343.GA30569@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/iommu/dma-iommu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..a2c65e2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_insert_range(vma, vma->vm_start,
+				pages + vma->vm_pgoff, count);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

