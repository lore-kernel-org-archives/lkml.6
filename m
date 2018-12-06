Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA6F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQdYEmv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLFShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:37:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:37:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so591422pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=jQdYEmv/c31kkxNf63DO2hDppf2yyeLJmKw6Ll2SJ/lUFEj87Ru6+xfE3lKIfctczi
         8ZbadMqzX3u4nD/kPuuo5FTDsAsBFI8Ica4ERuDuRDBeSZYaRW+qebFFg1LWFvnsI++k
         MP6iVmmy3D44dFT9yBmdq4IPLjCpp/2yOZUh93d29NzVG2QDnxm4vPTpZo0UYpNJWOgm
         cuJ4s1duczRJmygZdRUaSnFePvExxPYFUdNMrtwXEle4l04GSONHvunsQ2k+atUkoSOP
         OUpXiJJsaBLM4RVh52ZhX9s5lYy25JjRE8z2bZKooZryBibA6lnE5g5v8EhgIFTtZHBP
         ShLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8CQaNbWYfH4rrtr7y1L1OPdwNgqhGo43ZWeJVCZSPio=;
        b=oqfUcoXb76CB7/6pKVhUFSF8uhNQ8Se7x6HjKxYPDmX0wWJtv3veqSDBYOOoGwbPEa
         f5D8UxxYmXKp0yE78rmYTJ0afy9BZGt83KuTlaeX3lhYHyh6CDYpsls/GI31yrWZZsKA
         0SE7ux5pYNthbLBweXnWk1H2UyL8B5eQ2vYb+DaSLhbK/ZspUY00JdAlciNWJYBVb/XY
         pwQT/ILRYwetlFmMVU58XgQxjgfMEEjsal5SJSm6XN7cvn2xMcYSGgojVLvYaSlldVEl
         RDHplQmsIFquxG0nmy3DLasZQMEplqL5q83rSlcYWWcY7SHVM7yxgVn1NJex2MyK4Brg
         OL1A==
X-Gm-Message-State: AA+aEWbk77lec1W7IQUzImpmfHmPaGbT+iT1pn/i8bSIJ5l3BThuPoNz
        m4Rc7Uc33YZC96/JFR3tnYg=
X-Google-Smtp-Source: AFSGD/X8vL0xWSmYdOfWCYDwSxgcM4w7QeNvIJM2oEJ88aXzCt2cszDLSX+lbehOI7LOGmWx4fpNaA==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr24796460pgc.11.1544121437220;
        Thu, 06 Dec 2018 10:37:17 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.39])
        by smtp.gmail.com with ESMTPSA id n66sm1517646pfk.19.2018.12.06.10.37.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:37:16 -0800 (PST)
Date:   Fri, 7 Dec 2018 00:11:03 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/9] arch/arm/mm/dma-mapping.c: Convert to use
 vm_insert_range
Message-ID: <20181206184103.GA25872@jordon-HP-15-Notebook-PC>
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

