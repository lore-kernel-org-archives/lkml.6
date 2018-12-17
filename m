Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C5D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke/LiHKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbeLQUU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:20:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36495 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeLQUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:20:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so6647187plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hyvE++JUAtEdBgl01+ceVDX4NOixn/zsoYEYg/CvJYk=;
        b=Ke/LiHKSlBGRPCDmViUv3ZjVQC7ToSk3WGpxYAQvNSOoiFY64ZvLfofYbDmlTtMW8N
         VrhFC+VAqb99DqoAqfPLnVh5Igr3jSmBuSkHuT3Y+FIP9LRFRKFFbZ3g/mOJlHgcn3Ef
         hoFG+9clCHNChY22xwtjS65BxsUZUurd6TtAJcOxCnZ91scNKXhDUncwGPzurwPgfIUs
         oVUMPh5ahPSsoR9ZMilGLyGH9/9sGQaG5pSQgYrJsBLTeGALcntN0PhoCdLOhqR0nOpj
         2XuHj6tHM8RkjMS5+iNlCqgjWZp3elAOQEJJF7S38QFA5cuAfU49Tmezda2UVJwXTxrx
         XVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hyvE++JUAtEdBgl01+ceVDX4NOixn/zsoYEYg/CvJYk=;
        b=VWvLRp8NWuJlTFv5k4zAN2RUHm6mTrQ6252zEgIj+4R6Esx2CaRx8BqeQMEllFaXVz
         JNfP6jYQohYE+jEQUA/Hb8UtQ7DgJvW7/w/B6ESbcNXSwpZz7hLwU7k0uDFSYVqGSInE
         Ts/NCCk4EIwnpPDkNGP4lvkOx1ZMWuvwuH/gKacCxST5e9oZi83qo9Nzr576HtOZtVIM
         Tre+BiT7EHBYrwlhoKe3Q1ZY/oMq9mpWRHz/RGhqYlpCajJCyWP9NlsuNdexckWllbCr
         hZJdBx9vUpf/rMZA8CMRtKCUhXVyIbUTw5Z3aQnfu0GRMgA5nbPEAgr6y6WzUB+cM7Om
         yLIA==
X-Gm-Message-State: AA+aEWa7Q/mRmFJBzZ9UcUPD5yEwHFcfQujyHj4HBteIZIiynBEyXdQz
        vzcFqtlSiZEvacVvjHfR4nc=
X-Google-Smtp-Source: AFSGD/UAm7C/DlwQy7KNbcTedSMmgshhnQHT7Gj8ZcYhxLhzLnMONLAKeJaEynXEJ23NmOWnQU4npg==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr13227751plp.19.1545078056566;
        Mon, 17 Dec 2018 12:20:56 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.98.208])
        by smtp.gmail.com with ESMTPSA id z9sm31408044pfd.99.2018.12.17.12.20.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 12:20:55 -0800 (PST)
Date:   Tue, 18 Dec 2018 01:54:48 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Message-ID: <20181217202448.GA14918@jordon-HP-15-Notebook-PC>
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
 drivers/iommu/dma-iommu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d1b0475..de7ffd8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 
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
+	return vm_insert_range(vma, vma->vm_start, pages + vma->vm_pgoff,
+				count - vma->vm_pgoff);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-- 
1.9.1

