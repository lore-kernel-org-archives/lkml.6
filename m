Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE999C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0D22084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsvM0uu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390152AbfAKPHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:07:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44162 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391836AbfAKPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:07:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so7056885pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5lu9A1QSpPTMUXYRUbEIMz+FrtlaKDaua7/G7w3FZL8=;
        b=QsvM0uu4icAZvextylbdiwQF+jVmwkwcRTFbwvekeKAkggRQtNuG1yoUKv9QGnngR+
         DK2boV+OXN4GEhRdq8EaSr0OONaDWE88K/OJ5VAxGivZoh+YGndf9KfrXkwvF6gnVkQX
         nTyB6idbYpK55CJm0E7qRJQSDcfPgFFxJTFLEELimduks6bbI/fiwhEUg+VQq+4UbKEO
         /5m8X2KXTUvmdgd9pkhtAPR9EFxD7sLEnYFjQO13ov5Khi9lOk2hF31OiH2YFVU1fvkc
         ti6rmIsEVP1wp/8gEx/yh8Oebts9hgzlTUAdFMrdOT/2E8srkxPSJ70jx7N4ou8HhnWV
         uW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5lu9A1QSpPTMUXYRUbEIMz+FrtlaKDaua7/G7w3FZL8=;
        b=r37z/6i4yiNFzv9xYE0iLS/ZHWxf98NTgnGPIID7Ji6PgxufLmSPtj7NM7RMkvnNZ3
         qQE2Fmao0vVIV0aYCbiBek7cCPmMMNaSdG0ChDX5vQ2JCa/xPf84fg8FVlN4DbRemN4k
         RJvCad7tNKcAYw5FU7aTeql+HQ6G639+IefGM4ZHqAP+o2d8CE09+i7jB3nAVlJLJGYT
         4XbzIBWkjKbGjxH3LPKn8Irs1kdrxPxO9XzOvlUQevzzDl7XEv2DjC/ayGPZP3acN+24
         +91PQMQXsXDquyV0gB1L/zTU61raPgTIgv38RybZoIwthRyNsqe7IFeE5Y19cN+nb0wU
         fmVg==
X-Gm-Message-State: AJcUukepGOFzkUa4zgB4YFaQh41bIcvdyDXy/uRnHZFI6lT8e/gquJFQ
        UMn0XLJQ8PYGHZjsFooI//c=
X-Google-Smtp-Source: ALg8bN6KjwykscB3sBkV9lO0D9hkHDIbI6Lk2JEn0IITS33oEFeAQ1Opc96e0VUEvQ74PX81me3O3Q==
X-Received: by 2002:a62:1043:: with SMTP id y64mr15144503pfi.78.1547219230435;
        Fri, 11 Jan 2019 07:07:10 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id b202sm150546595pfb.88.2019.01.11.07.07.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:07:09 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:41:11 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20190111151110.GA2798@jordon-HP-15-Notebook-PC>
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
---
 drivers/iommu/dma-iommu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..802de67 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -622,17 +622,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	int ret = -ENXIO;
-
-	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
-		if (ret)
-			break;
-		uaddr += PAGE_SIZE;
-	}
-	return ret;
+	return vm_insert_range(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

