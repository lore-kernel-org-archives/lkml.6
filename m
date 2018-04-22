Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeDVJOU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:14:20 -0400
Received: from sauhun.de ([88.99.104.3]:37550 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbeDVJOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dmaengine: at_hdmac: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:09 +0200
Message-Id: <20180422091415.7587-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/at_hdmac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a861b5b4d443..75f38d19fcbe 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2041,8 +2041,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
 
 static int at_dma_prepare(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atdma->dma_common.channels,
@@ -2076,8 +2075,7 @@ static void atc_suspend_cyclic(struct at_dma_chan *atchan)
 
 static int at_dma_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	/* preserve data */
@@ -2118,8 +2116,7 @@ static void atc_resume_cyclic(struct at_dma_chan *atchan)
 
 static int at_dma_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct at_dma *atdma = platform_get_drvdata(pdev);
+	struct at_dma *atdma = dev_get_drvdata(dev);
 	struct dma_chan *chan, *_chan;
 
 	/* bring back DMA controller */
-- 
2.11.0
