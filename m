Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0207AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E7D2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E66PxSJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E7D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbeLBGWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:22:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40572 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:22:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so4277362pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sjptjlxh1owWZKhohVrkOEeOt6dJ2dnRERAUBGGJRzo=;
        b=E66PxSJOATRlRyxk80lKrd/PPERGyhxxszoqxynYdKqGN1haLtgsOzfQHtEPslbiXw
         zHl6PkrOjijeS+cspvZr3/fA8QDseQINb50rdwUAuvynH0g6GT4769OS/CfE70NJPBaG
         nBA+3dbYlNmgu2fEtkS1MVZoHusgbAM5dFPoy5sB/YutBrMjHmJcJefDPs1l5UFK7dS9
         jBjnbTK13hVAtILMaN0Pwp045AxBkzPu91quj8BNW9kETTmtvOAplbxqaTZM6hzwBATp
         dsB91BjVz8U5yyOYWalhuzheuQNNkg2AbUO7ufjZj78Mo3bk32QN+p1Ysv8QnAW2gSBR
         NpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sjptjlxh1owWZKhohVrkOEeOt6dJ2dnRERAUBGGJRzo=;
        b=XAeGfr6UyA5t33wG1sLiyyhC3vc6znHHmQE+wnuYIT4Kw6aNxAwgebjznPjwJ4f29V
         pT16ikhC5f8agN9i091EfkzyDc+VszkQhhnMgLQTn0vqAd2eWzeNe5aYxszALkQOAoLx
         Anj6hC+zdPz5+6sv1t68huZmBxW6ue4NUQgkxdWIKpJqHzYnipU5FNBLikX/TVpzDKJs
         j7XLFnbdE7hC8sXfYq1tRTZMnMusXg10mluKmTTSK07PCQe4pklm5cy0vWDU+CkzrpKw
         M2dLIRGyaQnFYxZ5JxUZH4pC/UFuQMjO8FAwI53p3OQHyor77ECgh/SQGLcXo48dbe9J
         xPVQ==
X-Gm-Message-State: AA+aEWYbqqEYWzDLRTmuIblGd19zQMicRuF7f0zVdVoSoirO6l5av3xR
        WqvHHmXi+JurIZaK40civ8pIffNo
X-Google-Smtp-Source: AFSGD/V4MrGOvLQK8YAEdmVrkPOOILIeEIqHAzxQJv0N2ksWP4eVZ+yeiaMJNltR2QCz0j3pP/BOVQ==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr9746466pgb.242.1543731728624;
        Sat, 01 Dec 2018 22:22:08 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id a9sm9909585pgq.20.2018.12.01.22.22.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:22:07 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:55:53 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181202062552.GA3203@jordon-HP-15-Notebook-PC>
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

