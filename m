Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9054C46469
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0C0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0C0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeIMU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:27:25 -0400
Received: from sauhun.de ([88.99.104.3]:38904 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeIMU1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:27:23 -0400
Received: from localhost (p54B3335A.dip0.t-ipconnect.de [84.179.51.90])
        by pokefinder.org (Postfix) with ESMTPSA id EB10D2CF60B;
        Thu, 13 Sep 2018 17:17:24 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling dma_ops when detaching from IOMMU
Date:   Thu, 13 Sep 2018 17:17:14 +0200
Message-Id: <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment because we don't set the pointer to NULL anymore.
Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.

Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 66566472c153..e3b04786838f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2287,7 +2287,7 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  * @dev: valid struct device pointer
  *
  * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
+ * This overwrites the dma_ops pointer with appropriate non-IOMMU ops.
  */
 void arm_iommu_detach_device(struct device *dev)
 {
-- 
2.18.0

