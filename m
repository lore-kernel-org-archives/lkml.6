Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB70C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9CC2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSgjerC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfAaDEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:04:48 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbfAaDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:04:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so782025pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9UKheLNLSM7085+hYajJxzL+Wpldb3TOma8RXX0hjL4=;
        b=tSgjerC4dK44S06W0OSTr53cNg28+6cUTE4HzPUKTdkevWVpDJ97JFTp+cPosrPNEV
         D8rphH0u8PJiDjdQsW2TNjafYIBoOsL1lTpSoOkAZyJOLs4Vo+jTdmYEwU7Jl7hXgk8u
         bhAoeiu1BDGFLMWPAWbdszIxVsMvwVSrmn9/NbkQyumWfBx94sOwPfkrdncoz+vMpmLN
         GvJIbeBoL5m3lTrGsdAHY7E5Ffo5FQtSCX5JwL9a+t7uCBTkj1fO/HsLuTpU2zXaDEU3
         Ob05VCxwKCGE7QtPagY4Sd1s9LT8xNY41xJLt1okURF5K+hRbPJY9tnqbjP0VDuMbxqy
         h/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9UKheLNLSM7085+hYajJxzL+Wpldb3TOma8RXX0hjL4=;
        b=VFzEyDC9YVQHs8erKH/zvRa21Y+8oAtk5N/n4m/lwvI+1RZSjGWDdAfo+Tqyqq4Qfy
         A7xqOOQGvmpz78ZKCvuiQ0j/1aLgGJq/O4IWvCbu/arJYDSTa2QtRBziv9c6sDgwFIEm
         tTM45mr8nIzROW3PhQgCj/mfH+tr9yYOmoeY7Cz85IpxnPSBvij2ncMoPlC5PldrrcbJ
         heebQUoWry1uMix4G4rxHJP7AJsci2eBlqjkycrcx5sMIpD81epfo6Z55qu5qy6JwLgZ
         fhRuve1IxhrF3J1Hq53JslsQ4dzmnT+o/R0JFwqsuXq5tvHREhUndUqLnODcdzGkKUG/
         7Ewg==
X-Gm-Message-State: AJcUukcBbjHWRsjBvx8QhebJC/KRmRgBkEW92RcHYckT64cR1X59lbSM
        UFXk5qHmYGdAZFot2wnE8LI=
X-Google-Smtp-Source: ALg8bN4FchuqbyYG65Y851K8FAAMbykpYxvta9bA6d520FyHakM49c32bL40WPlrtGU5T7jPX/J4QA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr30429168pgh.129.1548903887364;
        Wed, 30 Jan 2019 19:04:47 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id o13sm4055072pfk.57.2019.01.30.19.04.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:04:46 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:39:00 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20190131030900.GA2284@jordon-HP-15-Notebook-PC>
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
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922..915f701 100644
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
+	err = vm_insert_range(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

