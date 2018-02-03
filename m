Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeBCPKy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:10:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:54809 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbeBCPKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:10:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,455,1511856000";
   d="scan'208";a="171407468"
Date: Sat, 3 Feb 2018 23:10:44 +0800
From: kbuild test robot <lkp@intel.com>
To: sean.wang@mediatek.com
Cc: kbuild-all@01.org, vinod.koul@intel.com, dan.j.williams@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: [RFC PATCH] dmaengine: mediatek: mtk_hsdma_find_active_desc() can be
 static
Message-ID: <20180203151044.GA44748@lkp-hsx03>
References: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 73006a033ef0 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mtk-hsdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index cd3af5c..c1523b4 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -643,8 +643,8 @@ static irqreturn_t mtk_hsdma_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-struct virt_dma_desc *mtk_hsdma_find_active_desc(struct dma_chan *c,
-						 dma_cookie_t cookie)
+static struct virt_dma_desc *mtk_hsdma_find_active_desc(struct dma_chan *c,
+							dma_cookie_t cookie)
 {
 	struct mtk_hsdma_vchan *hvc = to_hsdma_vchan(c);
 	struct virt_dma_desc *vd;
