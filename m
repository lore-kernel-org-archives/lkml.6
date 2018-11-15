Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B395EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4CF2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCfJfGGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4CF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbeKPBva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:51:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37915 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:51:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so9664823plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=pCfJfGGRC2UtHAm9HA9aL0m7FenKYdHmKJW2cNiCT4fbUX8KyYAZol4NGubhwf4ix2
         JcfsHY3HzR+LD2Gb35qfzVgY1IXhMHnzM33c4dii6hjPbeplvdrBBjf/idYXgOa4HeF4
         YqSlCdyPQleDOp9Ofz01vlgd2gfpDL0AyrbT2kWZkpPS2R8a+EQgE0qAz3f8ONGz2wIA
         cW5Mm2FkhkWKiXO2vC9eyC8WDTsRmUeEmiaMGbYoGFmo2djVIibp1dvUH2JzxD51uN50
         IxGo0q4UVc0QPq9Uc2pBekL4kOycmBRKdiAhHeUHyXMzaxqZqXdWAFSq0E2f664geFlm
         qyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=R8HLEXUPEPf38/Tgku+OS34oLfjgVht2/SkY06bcW0urXhRxmlZ3VZaqDfyGsCbhfW
         d5BbnJR+rQy7lNkh4qPIwvSXLvI1nUSXlGfhRkdnlh/fkbdNpU1l0mYhb6DCCtg0pDh9
         ZThF31+dkwfbQvonsO7WC6tQybSnjAGpVVi7TC+kcZIpAiyxitmnlKRd4Xc6KeqG0mGW
         /nCAPi3b77EXTddcSY3AcXzLf3AWQ87THAh1EkYUf5u/urjqnAcAdcjq2o0v5CIk0eT/
         AD/IjkdJOY8mXKy47F8PM7jhEr+Z1DOp+3xJ8c5A4F7T3Sf4OEexcuqmMCx9kc5wEFxz
         lm2w==
X-Gm-Message-State: AGRZ1gI9x6LXmUHSoCIqaOuFbnH2+mOKgBk4VXRFxRzM9RKB1sdUWyYt
        EWWCph4Pvm8KPUWdqEmtCX8=
X-Google-Smtp-Source: AJdET5f1R8LoBMhkPMKCZQSqkbiD6+/xv1S3DM7BTCxxtIUioUmrA+uSzrT7vwaK3JvVIPNypMhWlQ==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr6507758plr.122.1542296589903;
        Thu, 15 Nov 2018 07:43:09 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id 4sm25997357pfq.10.2018.11.15.07.43.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:43:08 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:16:46 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
Message-ID: <20181115154645.GA27912@jordon-HP-15-Notebook-PC>
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
 arch/arm/mm/dma-mapping.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48..4eec323 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
+	unsigned long page_count = vma_pages(vma);
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (off >= nr_pages || page_count > nr_pages - off)
 		return -ENXIO;
 
 	pages += off;
+	err = vm_insert_range(vma, vma->vm_start, pages, page_count);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

