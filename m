Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03B22192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZi03g5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfBOCms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:42:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43200 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfBOCmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:42:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so4172904plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=JZi03g5m8SqN4fzXTLvaMrZBoX3tseOnsMCKC/62M1fb+WcWoioZRu2l43B9pfFRQ2
         WXlq2oi4wn0yLXfiWFYswzWzIwq4w5bg5KUOQqXwHgWQAE+lk6jNrBiI49ibZOXzAjYB
         S8xwAOlxwx6HrAa45AL9/1l+BkEjI1D/wYBYF5rR1UnrnGZzphD/5/CSGuRCJ64MvEcH
         DReeXATf/+Jz4/zN0EJD+9cfFSCrLW6CKrkgZOu8eMnbvIrFvUZ+1Plc5qyMCcYCp2YU
         2sV0wsN2fmCXsUVqfPMdD0e6g3l2vcbQyVMaPVeMlRxx/bfrmGunMWVPf8F0LURXsG/d
         FuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=l8bpY4Xk+dN10EnJyyclEhHDYk8qSO+X5n7QDQ0zaM9Fioe5wloawLIvGLMW5Oqt6Z
         do+vZZLpvZhyPtTZ9+PberIlCQt7XQcuG0m5uD3+yCWOLXs77QmmHRM8V5FYjKLa6Adu
         JYlvgn+yW3nK1XHqrBTPbVxXhvWc+XQxyBDr6/HAxBwJMkgKRXbLLF+cANGJfNjveV4E
         EczcRgbGq5xFr+RZ1zUl6to9YIp0TgVNIZJ0lIt+WjUsNRgAF2YkEHNUKLUpv/dBRsvB
         gqF/6LDrpLkP0d/J3l6+3vwm5qJDDAOg7S+HxnZnJCJHIpsrovSihet8AJgiQ9LcZQFX
         3k0g==
X-Gm-Message-State: AHQUAuYFJfu6FdFc8sYfW7f9iup4fEKQIa9X20eWDJxyguGA+huwseWv
        Vz4aIF+nR6U78yam/NxYbzQ=
X-Google-Smtp-Source: AHgI3IbXbVi4CkMxM7o0ba7dPvq9bi9XCTF85E7sfNodnY+9YIlbe7/Qi7XYnRlOQPjwRJgGuWuFBg==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr7737899pls.156.1550198562436;
        Thu, 14 Feb 2019 18:42:42 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id z62sm8961035pfi.4.2019.02.14.18.42.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:42:41 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:17:02 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 6/9] iommu/dma-iommu.c: Convert to use vm_map_pages()
Message-ID: <20190215024702.GA26442@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/iommu/dma-iommu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..bacebff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -620,17 +620,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
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
+	return vm_map_pages(vma, pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

