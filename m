Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4165C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7021783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDI8mY+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbeLQUST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:18:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33954 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbeLQUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:18:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so6662535plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sUyJE5XZI7PFTFAoMHl2QCf6i1YL7AfLuhA9/P6Ludc=;
        b=oDI8mY+6/0wwXEtDv6zcp3R2be1Zb57Xo3+v9BgCECtnF3xZe4e8/tCJOt9WNsnuNx
         dqVRMZuoCSfpN+GFfo5EpPACd5VV2asAKw/G+JnlkZozp2FqwUiuz2MyMTA/bpiNA8FP
         /uhScwqU9of7msQcUs0RSLMfAcjhdw226Pxn8s0V8n4CjppbpLxwAuvntwSiFxpLjbA2
         pcmRRP643OFxHfwdNeVffdCCBG6XaRBWXxcCjvuidnKsuqLa7j9RmI8ohICniP6TJhDI
         FERVM7BvY/lViYwRv5CDf8ZBTyVQPoRRuNdXThd00kyj137d+EIDPGbH7zTF1fUS1n7B
         6yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sUyJE5XZI7PFTFAoMHl2QCf6i1YL7AfLuhA9/P6Ludc=;
        b=Hs3WxBmQFDdufDH6Nbcl19UyqWoG7i2cREWn0Ua6xV6qOMC0ooF30HmPRRNs5llBcA
         BumqznSE82ZVtQ/urlX842Bu1sD+S4gt2EU8lD7gSUENYnpWDLZmIAA7N+lSdlVEbejD
         2lvNBAmwf0AwoKVgoMULJb/iWm3q0NGwj10KRKc59U2Us7edQPBxsJ9rV05AYWsEgQE4
         n5psxi+SZxTe9lm1hBHo49ekaqNL6X4oHAazFA/NWh7LrnDGfcHBZZXcb+BtkVyB/B/U
         dvRcqfp10YlBlT/AjLXv0qTkXiKIzRYcv8zELP2+KxjKV7Bp/eYhcGKyAf4fxhHM8aiW
         vMuA==
X-Gm-Message-State: AA+aEWZqgxmKs5n7H2LCJRMgk7b/FyTvb2Ze5v4or93hrD/G7BMlIBJD
        kJEAfOj8LmoMxGGF+CBwtxE=
X-Google-Smtp-Source: AFSGD/XTMTjOndtTsiXcrd9fAIUCns/BphtM6xp91sNWu1YXSRoFffBVluebJhG/DoyPebkudZUydA==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr13818009plq.84.1545077897631;
        Mon, 17 Dec 2018 12:18:17 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id m19sm35920803pgn.35.2018.12.17.12.18.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:18:16 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:52:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181217202209.GA8859@jordon-HP-15-Notebook-PC>
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
index 661fe48..7cbcde5 100644
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
+	if (off >= nr_pages)
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

