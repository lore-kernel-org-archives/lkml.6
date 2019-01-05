Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA00C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E42063F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFZu1cWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAEIBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:01:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EBqkxOFYhNdX5XYn7b07CtnfZUk/3dBB1w4bbLbpAc0=; b=WFZu1cWm+kvP+ksWgdufmu2sIa
        R7oqWA5vt87pear/pSKSNabwH13qq67s7Fe171oGSsjLRuDLUvyei0cyADlgvxgYQS9T0AZaAEjOD
        qYQXQlMKcd7Qet4HiwkO6Fw+G85+g0bpmGIk/dP07haN9kA984UFPIy7ErOofzDo+GuAUodOCwnOv
        I8/2Z7zzypKzY4MIxTmvRhhKgAI6zmaWE4qW0j+k7cU++fke6gLcLtoV5PQ/mhwrmqVl2KP8HFl2V
        I1x8h1+aXW+jIwAFiHZ5g3RyipBAGcAN99efK8s+ZpHpW+OcTVcdfZAu6Od6zqOUavi2I33q/Bst9
        PdjPkplQ==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfgtP-0000J4-Ax; Sat, 05 Jan 2019 08:01:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     thellstrom@vmware.com
Cc:     linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/vmwgfx: remove CONFIG_X86 ifdefs
Date:   Sat,  5 Jan 2019 09:01:05 +0100
Message-Id: <20190105080108.14837-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105080108.14837-1-hch@lst.de>
References: <20190105080108.14837-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver depends on CONFIG_X86 so these are dead code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 25afb1d594e3..69e325b2d954 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -565,7 +565,6 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_alloc_coherent] = "Using coherent TTM pages.",
 		[vmw_dma_map_populate] = "Keeping DMA mappings.",
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
-#ifdef CONFIG_X86
 	const struct dma_map_ops *dma_ops = get_dma_ops(dev_priv->dev->dev);
 
 #ifdef CONFIG_INTEL_IOMMU
@@ -607,11 +606,6 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 	if (dev_priv->map_mode == vmw_dma_alloc_coherent)
 		return -EINVAL;
 #endif
-
-#else /* CONFIG_X86 */
-	dev_priv->map_mode = vmw_dma_map_populate;
-#endif /* CONFIG_X86 */
-
 	DRM_INFO("DMA map mode: %s\n", names[dev_priv->map_mode]);
 
 	return 0;
-- 
2.20.1

