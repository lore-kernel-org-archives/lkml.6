Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE767C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFEF2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8J8YEaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfBOCjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:39:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41718 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBOCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:39:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so4053768pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=C8J8YEaP1sXar/+zW0yONM/GThKVOZP43UoKx+bsMs0rR+kOwbwuiT2BIDoESBLxKN
         X6AH8lyLqHVlJ3S1+7SjnEjca5R1G8T4RFnjNToQO6v4YNaQSQSNkLbvxe90zZykLVDi
         54ov/SHMO/cZOMqPEs91uSOr6MV9wmu9R1mZMEKYCox3q1ABu4U+roRJf/5xpBsTlTDO
         KAmeeosjCfbEhSgpHYgu6X3qTk/lRll1yN/eR/pYc5h5Gznm4xGDGVTvZ1VW0BjA2yKi
         9shB5cJBIHEFyFW2Gn9ppb3AKrv2U+8H26GIKZ1mUlV4K3ypWZYz6UbQihzp+r6bWUJk
         St0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=OPh5n4C5/nLc9E3E4gjJ7IJ2nYuDbfq1RrZS0t/7c+pDi+lKbQz9sKfDVWIwAcMZK3
         ZrlZaT/pEU3tTSwjiNktsEO6Ke4AnfMTuvafKNsX6lkLqKga+WSsrSxH2BM8jZRI6cgB
         qnnrDQfjmq4xp15IJRkvukI2lE4SXCbCWFrl4sVhoSJteCU9K56kWOQ7ou3GYTUjaKed
         MJ6GYeIc04rtZhPAazakX8xD3PGi4ni0YQ7DWg5ohfPihU9aS5QfRWJHF9k1exotSCf4
         qmoxnQKOK9St5qwbCfhIq1OTLJiKc5unatWTCuvRnjcOcILHdk5P6PT5f9vCmWRBswV3
         qCsg==
X-Gm-Message-State: AHQUAubXjBSKjut0Th8oUQL5UoigWj7mxCNLo/DT3bo9C60io3GLoMM9
        /GF2QiBbg1CTWBocv+zl6AthpwwR
X-Google-Smtp-Source: AHgI3IYPDJcfAJcux7am1/kgkI8RGRJz/Eho2e26RlxYpln5H5W4x8B/Nfk9OSESdiI7mMZpfEdzLw==
X-Received: by 2002:a63:4b12:: with SMTP id y18mr3125993pga.340.1550198349469;
        Thu, 14 Feb 2019 18:39:09 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id t3sm4758131pga.31.2019.02.14.18.39.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:39:08 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:13:29 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/9] arm: mm: dma-mapping: Convert to use vm_map_pages()
Message-ID: <20190215024329.GA26372@jordon-HP-15-Notebook-PC>
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
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..de7c76e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1575,31 +1575,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
+	err = vm_map_pages(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

