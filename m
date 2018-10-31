Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A06820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5ULCEvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A06820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeKAFDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:03:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39447 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeKAFDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:03:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so7181506pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7+NYEItMFF2B/vnWQb1yg/cRHALq9+mk2HSUjZYLHEc=;
        b=u5ULCEvWmUGSqdb2Wv0/7hS+LWAlG+COS38c4XwpFFSmnigmoJEATCVu5LJ0eI2Neh
         l3grYDh1VeSW9yUxmq5rmfAvHGeOWmc/6/hlSec5oLZiceBUtb09t+C5vQAGxVRqY6Yu
         ZLkek4l1G1yF7JD+Iqx0BvxnBTBQjOVclvNhmWf9+XyS582GQexlSgZXma+B2YNhDv/X
         7kujOMKoJVlee7qWZod00qoJwQT436UXmksvKjTMWAROwLBGYypWOh/2QWBjCN38tlO1
         Oj+5NTVhFfmJgDe0DKgI3KcnzbqqiPJRokDm9uNTItR+qVscFik31OcvoSpOvUBDOAtp
         wazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+NYEItMFF2B/vnWQb1yg/cRHALq9+mk2HSUjZYLHEc=;
        b=mvg6oKIZ3bV24Z5FCaDmqi+NK9TR7MWi5zWpXNlL4LsmIspj9yn0R2xwl7ey5ZnGyZ
         fLf/8hHkIYcuWhipQdHcqXB6IctCM/Ig0bUYaHxMq0vqBjLR8R2emi3sa3g5PQ2LGS52
         WXzfNS8oeJQro3lSWl0ff84XOvbqXWcM/J6+1h9s6qgqCEnBBdSxCJDDod+jeJO0Bz5l
         fIzjshui2JyktzAdXzOBYyCzrBOW8uwE17Yl/N8CMbfVmyjEicdSkeOvwsZ6240RbT3S
         uU+40GfAmMUKvwSb+VGlBYuObOCV4Ohu4CbxO9/o6o/f8zO22ZejLDDWrPXsiZHjC1E6
         aLkQ==
X-Gm-Message-State: AGRZ1gKAhJcYzvSGs79ws+UxNZaiD27/bI8akZZIt8+IJi5KzEp2ccei
        Vh6IxkybE+LnvolBoWCYG77u1R02
X-Google-Smtp-Source: AJdET5eMlPF8bBHeTAFZKZeZ4XwjKc2lmeD3+njU++6L+HXEbITVmGKXaR52o1M3aNzBc5NFi3Uo7Q==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6-v6mr4823499plq.31.1541016246711;
        Wed, 31 Oct 2018 13:04:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u9-v6sm3360345pfm.175.2018.10.31.13.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:04:06 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: [PATCH RFC] dma-direct: do not allocate a single page from CMA area
Date:   Wed, 31 Oct 2018 13:03:55 -0700
Message-Id: <20181031200355.19945-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addresses within a single page are always contiguous, so it's
not so necessary to allocate one single page from CMA area. Since
the CMA area has a limited predefined size of space, it might run
out of space in some heavy use case, where there might be quite a
lot CMA pages being allocated for single pages.

This patch tries to skip CMA allocations of single pages and lets
them go through normal page allocations. This would save resource
in the CMA area for further more CMA allocations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/direct.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab5a5e9..14c5d49eded2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -120,8 +120,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 			&phys_mask);
 again:
-	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp)) {
+	/*
+	 * CMA can be used only in the context which permits sleeping.
+	 * Since addresses within one PAGE are always contiguous, skip
+	 * CMA allocation for a single page to save CMA reserved space
+	 */
+	if (gfpflags_allow_blocking(gfp) && count > 1) {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-- 
2.17.1

