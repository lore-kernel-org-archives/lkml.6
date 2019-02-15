Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1146C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAF221B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSFRfMX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbfBOUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:06:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36488 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:06:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so5336573pfa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xR2fAcbi08dJ1U/q08SNwZuhqDiyYfroDhLUIQLycmU=;
        b=sSFRfMX5pHy8lQqR5+7wWeOu9clS8G+KXgTTjB/hX91WV87ucUcXB3Z0iwe+rEQz4r
         GRG1rWJ2ftPMedVWN+l98HsVTvCswdJrCOlmlNZGONziiL6fnl2/7CzKO9fyPZWGFzbg
         10/3IN8hxfxoHhZ45A74+tMTKh566TXJJi7k+Yph19ZIxC42AOUfH8ym7XTQSF2V/XCw
         MyVv38WqGjgLvMxRaYXKnhsp7r+dyHWdL49OBhBMM316UXygD85Ct/98Y6Wlsx9D5b4W
         STIza1HMWg3653CPXJa1KdpsHQRN5rlQcQ12v8+C/rorqRRY9vtxn2eQxZtUj39ck8IY
         CNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xR2fAcbi08dJ1U/q08SNwZuhqDiyYfroDhLUIQLycmU=;
        b=ZhWldP6/YuuFXUHeuZruxJRVxlaO/mxmkB3e54+GXac+yvpyypHismAFs8Z0nfJS6t
         VUF9fzV7To707mFIddIprelsI1LKwrJccIdqiU2J5W8oUyviJYiGm6okrIvL/4XjoFrU
         byjrtlk5uiOh6lPmFwtBztewMIS7p6SXaX7cfBiHYPrZoFcfCqGX7JNJbfJkWA58jgpx
         pdtX0ili2FcwDpGqtGpeSLRDUdOuZB2PXmt3S5FM7I444MX4fh08RdE+44p9b7hdLDi5
         Bv3GASmJ6S66/p4Ng+L8WIe8em2KREgLiRhCSBgO4rA+d5nLLO+zPXo3FjO9BxlmeQmU
         WrAA==
X-Gm-Message-State: AHQUAua46x4v6oyPL0v3l8KA5d+U+tb762EP2ITQwIXcYJtzfALvs8mE
        lNJoJxjPeQoB5wCmXp1I2JU=
X-Google-Smtp-Source: AHgI3IbOg3MVioZJIrFIxxCPUl6uiwNkGVRjoab0+9Ti9aHeSH42Rpsm7wEQd2dFJHxAQVOlb70xMg==
X-Received: by 2002:a62:4641:: with SMTP id t62mr11334933pfa.141.1550261200747;
        Fri, 15 Feb 2019 12:06:40 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y72sm8094932pfa.98.2019.02.15.12.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 12:06:40 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH] dma-contiguous: do not allocate a single page from CMA area
Date:   Fri, 15 Feb 2019 12:06:35 -0800
Message-Id: <20190215200635.20733-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to always allocate one single page from CMA area.
Since the CMA area has a limited predefined size of space, it may
run out of space in heavy use cases, where there might be quite a
lot CMA pages being allocated for single pages.

However, there is also a concern that a device might care where a
page comes from -- it might expect the page from CMA area and act
differently if the page doesn't.

This patch tries to skip of one-page size allocations and returns
NULL so as to let callers allocate normal pages unless the device
has its own CMA area. This would save resources from the CMA area
for more CMA allocations. And it'd also reduce CMA fragmentations
resulted from trivial allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..09074bd04793 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,16 +186,32 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one. Requires architecture specific dev_get_cma_area() helper
- * function.
+ * global one.
+ *
+ * However, it skips one-page size of allocations from the global area.
+ * As the addresses within one page are always contiguous, so there is
+ * no need to waste CMA pages for that kind; it also helps reduce the
+ * fragmentations in the CMA area. So a caller should be the rebounder
+ * in such case to allocate a normal page upon NULL return value.
+ *
+ * Requires architecture specific dev_get_cma_area() helper function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
+	struct cma *cma;
+
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > 1)
+		cma = dma_contiguous_default_area;
+	else
+		return NULL;
+
+	return cma_alloc(cma, count, align, no_warn);
 }
 
 /**
-- 
2.17.1

