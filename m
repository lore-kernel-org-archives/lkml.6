Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A24DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9022190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwi9ddgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbfBMOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:01:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbfBMOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:01:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so1183055pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=Zwi9ddgsFqc+aI6RdkAmjVmRVQY2kIKEA/goavGMF2UFBR08h4VxEcopFWUJ8ademS
         ZJOhPqL44qeZwQfJTEnpnw7+bU9w18GR7lIPaDoqZq57oox4meb6Xl74zzQ8HRGJgbov
         qInTG5TXVfyHQ4zMGO1uJ+vVConWVyQmndvdBQ+1MUmbcUjqQb5pD2dS7rqEHlwTiamY
         lH11ZOtRgcKEnG9eEW+nFs+LbEWXWyfD8JNldEEhi2Vob6oqD2b8EtFVXo+OCAXHAWRH
         MSbOIj/OUJgJkAbowIXY0GDKCpsjOzNv45CTvhRmag02UpXHiTn+BtsFC2GwTsr/2bQD
         r6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XQSNSZywn2J5tIibcMqEyCRYg0DoENdsUd09NDa1qxo=;
        b=dw7Tgm2VMTNXSnz523PP7FoMUFjpx6qrq7d959z7FR9jLKZxDUcFqcr9Fo0NPF+pnX
         16kwznLjj3UkQcNW7fUYskjL4ChJxgg7ZixMjXKMBrVDBV+0GEG9WL+piza3hECHwGcO
         yfvB1gtR4xKfp14CkhcyFA1HYqDr3UuvSev8JPoVYD5lHK0aBOP/rdjmpQR2VEW/M9b2
         mnMXVW69n4nuUTNMzJ8c65tyqWlgPGe87uW1uxIzQtLQG8ImcOxWRaWeXzFvF1bsjtzk
         A63Ewe7cP+q29CylF4wbkYm+frDc82vgXE32QgB9kZRXSAHOYP70t3dKxCRbeE/EOtdv
         mZwQ==
X-Gm-Message-State: AHQUAuaIseu7265FoiJ24vzgcx48ukKEj70ogRBM5aQYBNlRzaib1zuy
        Q2j5Xd5gCVsdvo3CSlMJ/Go=
X-Google-Smtp-Source: AHgI3IbSufXkNPVxD86rAOaQ3sWfm+MBjGYH5NlkKVhrp9RhHT/Mp9udXAimuDrAmAMeLxIHijJ1fg==
X-Received: by 2002:a63:f552:: with SMTP id e18mr588329pgk.239.1550066497651;
        Wed, 13 Feb 2019 06:01:37 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id s12sm15439846pfm.120.2019.02.13.06.01.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 06:01:36 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:35:55 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        joro@8bytes.org, linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 6/9] iommu/dma-iommu.c: Convert to use vm_map_pages()
Message-ID: <20190213140555.GA22045@jordon-HP-15-Notebook-PC>
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

