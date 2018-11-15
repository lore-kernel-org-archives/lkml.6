Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF829C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845152146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDL1jXOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845152146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbeKPByh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:54:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35411 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:54:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so9886589pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=d6oJZE/ChJaKaKxciGARJsnaQLdSQV2i4WCXLXIWfrQ=;
        b=KDL1jXOipi5AI9hqqrIXJb54kJnJcGHPZq2inivM6wT37owA8faKfCyFnyplVYZnJ2
         WcPQLs0t0fomnazLFjvCVMXSXW45w7kASTC0eaHU48sGeSCZda4SHSCs4KipKTwwLWPe
         86twXHz84aj/2VhHhjQXF5DLGpALUGDrIDAg798dFy/qS+XgbKCzqsdtUiM5jiSJB9TJ
         twfempieOEafBe8eLr2HyUh5+PRkuIsAp1eXaRnou8Lnt6zxuZObdya1V+OnOGPFeErR
         J/rmbflib7zF+roU53lBFqGQ2+A5vh0ko6q+0MkuD6c86cLmAfT2/efpTLbzC1uR2+Gt
         JzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d6oJZE/ChJaKaKxciGARJsnaQLdSQV2i4WCXLXIWfrQ=;
        b=REmsqwV3496iNTNVZqN5+uPfYaZc9R0PeuL74DvQcNZhBN5rqNE9BzxpY/V0JqmwY/
         DK3s/Ud9hFo/UfLq510X0tgI/IDl7N/kY8soqR64/Xcgn0AADwin6OFgA0V7+pUH/ezp
         2AEEshXwn/mlGLtw2uMwg2Grfv8x0VQYcGdpEA3ylytvDLacIO14kOxAXUjjnALkQa66
         qd79xPwv2rjZ/xBmdwUlSjpAVy4MsQh/kbj7n1IuyI1tgOJW5x6KbEiygBLRlbj26Du/
         tUhB6D7Is7tU5sGRfLFTlSVjlLw3ZrknenFXLYbVcHjBExrYitEs6SDSodKIr1DPPJ26
         1xDg==
X-Gm-Message-State: AGRZ1gK31MZNjZX+xazvmAmRbiQ7f9oiT4J463grMB860MmsTo93xED7
        cbhtA3/hNigXsPxq0KEYhzc=
X-Google-Smtp-Source: AJdET5ePnd6LsBs3MvsWmND5rouZNtcp/4maXAw3ddO5kkpXTes4M9S1/JU9EhJVlMxVKMlrn5+f7g==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr6356647pgl.127.1542296776069;
        Thu, 15 Nov 2018 07:46:16 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id p5-v6sm29750372pfb.109.2018.11.15.07.46.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:46:14 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:19:50 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181115154950.GA27985@jordon-HP-15-Notebook-PC>
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
 drivers/iommu/dma-iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..69c66b1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -622,17 +622,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
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
+	return vm_insert_range(vma, vma->vm_start, pages, count);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

