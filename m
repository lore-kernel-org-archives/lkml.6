Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB252C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD46222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbigDwG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbfBMN6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:58:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39945 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbfBMN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:58:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj4so1199408plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=pbigDwG3xTm4YxvGqJgLG5mkUt5O5OB6iH/4JOZPoXunwWHE5QfP4W9AElQvSudJa3
         oftivCtQcvYNS8YSZXakLgY/n/6uMXhgwbuZgbrYOMW2A6d9qxKamu6y4VDWZG9hKIXJ
         Ozs0l8wXg2IVBGQ5Lx1acSQcHqvuaQpFa+H5Y1d0IpRM9leug/xYa7/aLNdDjG8Ibi0w
         4YGogL/vRIFJoYsg51t1pmC4flEIvAwvnxiLzYGzdVd4eEsIiXYF+OFdhEXjta13phln
         wgXDc3SFMpLh8t92NQ4l/buWitqvWvWgjk6iHFgB8KwSjqoqS1sBA9XRvXu1Nzpx0Uuh
         rkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cNyFM0J2DfW9voxw9FzV7E7Y/LrzsWkGDKLqwe0d5pk=;
        b=E//Ud6Z1DZNvdATKTtL2Y/CooqA8udszITDd4cYzzln94pXxIDTyN1UGIvricHoE3P
         d/9O2vPH1QHJLvVxe3Wk27sESDJNWS65p9situAJfc2uQtC36GSnSvHUevuw6dTb5Ekl
         ASDgYqxZwQF3kdRDVuUS9Qf4GoSmpLwjHOYHZ5gIFd4HyVgoTH+Sw9tkfUnGa0dY4Vep
         gvQoetbWTCK0Uf/lNzR4BAq2rfMAMCn9wkUQgYB7BYein1qv8bKOGHxXDALdERiZulQ1
         7PDFtdAbI+1zteiyE0u5LWrWH1DDJjntGNNUEt+E3KRO1BeRvErpRAfPXk9MD5wq+MPr
         dZjA==
X-Gm-Message-State: AHQUAuaY9wzTM0Z8IcvT1w4msp06ND+u8I0mHNA9UE25leLzYgN0jxZj
        TblCPZIoxxup5AmahXKb7ik=
X-Google-Smtp-Source: AHgI3IabBr7i0UINT5tZChzG9mkUSIkz97ziRf+i4G4ZGRQ2Pfd1KkCHgUpEt1D+OFFkb4bWmp/4Cw==
X-Received: by 2002:a17:902:20e2:: with SMTP id v31mr640198plg.307.1550066318585;
        Wed, 13 Feb 2019 05:58:38 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id f67sm30721286pfc.141.2019.02.13.05.58.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 05:58:37 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:32:56 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/9] arm: mm: dma-mapping: Convert to use vm_map_pages()
Message-ID: <20190213140256.GA21977@jordon-HP-15-Notebook-PC>
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

