Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F104C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DACB21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2KO5MMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbeLXNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:17:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35646 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbeLXNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:17:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so5596983pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MMGJzHhmNthI9sRZkbXZ1iYyH2jshJ0o/VQkgO88tcs=;
        b=i2KO5MMxJo3/5LWrPLeNLGeva3Ne1DqGYNQmkVfffqJy/7Blwc1ZQTxF5q7/4cdbVK
         vIexInnWRoT/V11j7MMRf8p2pNk7N6+FKaVdWJPsVT0PJ7MRGJWCmKDRYYVgzm9PVFZR
         7Kz4JADaRzoTvV+K+ajZHPtgb0txgVU5jA3CliuIeqyf9MC+6XxOOcepTV0uLQH9GDeU
         B5bw7Mj0iLy6LrkPqE9j4pev1wfm6d67jrKNbReUFngf1M0upuqrGUYdICcRDO0tsAEw
         f+JmsDBaFgTBiSI+JannbW3PzQBDJacAB8VRitF1ub03PgJ8p0gttKrXb8wKIRMKAK35
         /Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MMGJzHhmNthI9sRZkbXZ1iYyH2jshJ0o/VQkgO88tcs=;
        b=SQbbtGfJtUPYX/Qh6qODbCGsbrCQ/i5SSCBukcktt/uony4f0dcE6+WbunzCjlg6Ne
         wlvIsb1TYFL2ShQykYAB68ofrEapkKGaLnRJBi0OV1PaE5bSd9c+spItNdpP/snx4Wnl
         EYq3qyo13p6tGGAbRDsm9Ahf8GGkcntm8YyuiPwNjOcmPEX+YpoLrZfjc94ZNeaaUw0v
         MKa0TwIm+gV13jeaDOuLD65Bxwa3RRQ9LyubIRLmE/vwHCbA4IpeebHCVdcoVjZ88gt2
         oBQQeRJXwu7ZaopkGJ2boTMBuzxAyEQfYzxJr+tfInjC1gWhXn6mdJA0ZEVA4r/kZz41
         1AyQ==
X-Gm-Message-State: AA+aEWbCjZdkdNjO1P1TpcA1iXYeFJ7+XGOt63tgYuCwrQFIZF5bE55r
        I9I0FYv8dd78C7agAqdAk8A=
X-Google-Smtp-Source: AFSGD/UmasEKtYGJVvYE7ECLRPqA3+g1rUsYqcP4hh5vWWnPBQkurqM+K4wJcBIT4twxElNbufrYjA==
X-Received: by 2002:a62:e0d8:: with SMTP id d85mr12901342pfm.214.1545657466691;
        Mon, 24 Dec 2018 05:17:46 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id c23sm39254231pfi.83.2018.12.24.05.17.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:17:45 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:51:42 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181224132142.GA22070@jordon-HP-15-Notebook-PC>
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
 arch/arm/mm/dma-mapping.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 661fe48..63467b6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,11 +1582,12 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
 	unsigned long usize = vma->vm_end - vma->vm_start;
+	unsigned long page_count = vma_pages(vma);
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
@@ -1595,18 +1596,11 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
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

