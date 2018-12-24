Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EAFC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0F21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEHFTcrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeLXNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:21:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46618 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbeLXNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:21:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5576943pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hyvE++JUAtEdBgl01+ceVDX4NOixn/zsoYEYg/CvJYk=;
        b=CEHFTcrBkyeCWeCmPrwn2688YXOdYONJIrN0FDYedH3wOLlUMBEllDzlhZcd34fVTK
         PVN/K5qsz/SDWgrxoU447eNOJ+Uwup96nxoNgOgUlQOQ13YmehCBt15uIzwDcL834WB+
         1V2D5GZRCpWh5bWe3K+7fli2aLbfN7muPdbKp+K5klF2OAEPz3Omo3WxJVWH+iE0KYW+
         WRM7Y7bB/2Q4e7scf8d2tc9sHWt7qho4T1VtjVba0K8NyB9RvGQ16XNaDLKLohjtuJ7W
         M/GFEzgPI0wWXk5qZ9aQAs0zJHqCzO/cRE/cf/TYZf3+d4QEtZJUwwgpGUr3zwext/hT
         2vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hyvE++JUAtEdBgl01+ceVDX4NOixn/zsoYEYg/CvJYk=;
        b=CHLnHy2iRjUNtNjgi6a/09KNMHnwt9w6oktX7u+yVoB6sR8qhsjZ1W1NNJl9/hm2JG
         u8QUlQDIOBKMjWZoVXhNwv3J//uVXLU06OHuOiseK3SBuktjdSCSSvPsFqXjFjDOL17B
         L67pn/mzb6paNDY6430KnEdj9jINzJayVbyFeMl3rXU57YJI1F1OSDacD3Vg32b+qSR9
         fsBJuFhPApNbdM5gDCb5pkpGU4U6XInLSfl/hoIm2paf7yndxJALoiMwrp1fpWqHnIFv
         PTDLC2uNn6dT2A/tdEy0rkf7/ucxrKPU0L/+b8OUZ++wKLRhU8W0cSztunYccND9ooW2
         7g8w==
X-Gm-Message-State: AJcUukf7th3rdd2Arzy5jZ3ijdOxPhoJ402DAczJ4x+++L0p4ySmIF2Q
        /8A6ayZuEKofXcDuSxqoSSg4b5h4
X-Google-Smtp-Source: ALg8bN7sI6Y4DpvdHRECfX2DJrfkjetdnJLz04OveHwsKqHkXorBy4SWhZzQ1kNDsKb748UfZoEkUA==
X-Received: by 2002:a63:9712:: with SMTP id n18mr12115990pge.295.1545657699357;
        Mon, 24 Dec 2018 05:21:39 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id x3sm101389647pgt.45.2018.12.24.05.21.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:21:38 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:55:31 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v5 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181224132531.GA22150@jordon-HP-15-Notebook-PC>
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
index d1b0475..de7ffd8 100644
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
+	return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff,
+				count - vma->vm_pgoff);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

