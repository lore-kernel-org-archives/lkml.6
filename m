Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F66C20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBs4dq/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F66C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeLBGR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:17:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34259 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:17:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so4791829pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=mBs4dq/TeqPHUFL3AVrh3JJ/g+dMhVdSUtuuYiWThyelgCPlvamNLncj9Z0m9wretJ
         dHQvALWfWyfZ+7pRKHCJ8GadHqubftSlzYY9F1kU9Q42HBarg2E2uV5mDeQzLVNSb048
         gv8GxLTCIgRIx432n2ija9tH3s8sgqauV6Ulm8WtyP7po08V3uPqb5C6Xs5u3x4KCpZC
         GAXsbgqClWr3kUjmQtErJtDmoLutvnGAy293IObP4qojbp3bkmwLacBfB9qkW4bQdN86
         hJ62U470REpyHVCTaNKFe5GJyUfNQi/0Px/7/+s0OfcUYwyXdeauPqvC1Q2BEUbrPjW7
         CDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=IaatFWFWf04VBDzD2THHd5tvaq6Ytp+orZUVNS43e+Zg/7dDGKdnLHig3akNuRrI1P
         LSXTECqhtqIamRCxgKHsTIMoM1Ut5YReA8pBCnupZppC8CSCIH3X5PrWlwRfY0uq+8Sk
         wg6Zm2ebeUotQXlcFWDn8qhieSfBVBqcLKO79hIe83hKjmgM5ra/U+nLVw1pvIAEB3HL
         6m1ZRn/vO5QC/Ip3dwyiaX5TNTrN1faTGOYxIL08Zr4/lTTVH2luhVyOGr/KJi8bPRDC
         wmh4OROjRWJ6vjoaikeS2DLxkkiupprOMX5x4c4ZmLobS/ZSVcq04TjXD1MyJs06FLqc
         9Dhw==
X-Gm-Message-State: AA+aEWY6+U1+UYzrKBzdM7xUrXzqdelRJBrBtw+3kFwAsUMff4MOetFU
        yHHFOItD48LTzEIhkr33lpo=
X-Google-Smtp-Source: AFSGD/XskkVCLMV56P5G6hSJkQEj8Bb7420tD78vrgpfyz80/Ofs70Y80gJpaUlH3MXPhcU17HkqjA==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr9785026pgv.179.1543731445240;
        Sat, 01 Dec 2018 22:17:25 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id q1sm12648437pfb.96.2018.12.01.22.17.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:17:24 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:51:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181202062109.GA3111@jordon-HP-15-Notebook-PC>
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

