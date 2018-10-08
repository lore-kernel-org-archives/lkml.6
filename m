Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B145C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776420858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="g/aEk5dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E776420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJIGtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:49:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=O2Jy8Nd4FKDBtX1yPNmNwzXLBDo9g0tIq/y3Bcr5Dg0=; b=g/aEk5dYuog9
        EdVgufLJJYROGaQgTYcbnG1RIEQnu4dwAW7kFQ3NLUhfUJAHjorOVtq4P5bt3o1uxa8x6gCAILgjN
        EGQjeWQHQf7c7AWuW5i4rSDO/LG+Ucigx2o2kwiMPrak/wiuAU05sLPyHuNqctRBx1OhxXVSQcxIE
        Q0jUE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9f36-0003Ol-LY; Mon, 08 Oct 2018 23:34:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EE62F440078; Tue,  9 Oct 2018 00:34:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}" to the spi tree
In-Reply-To:  <20181008180846.14119-1-natechancellor@gmail.com>
Message-Id: <20181008233451.EE62F440078@finisterre.ee.mobilebroadband>
Date:   Tue,  9 Oct 2018 00:34:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a1108c7b2efb892350ba6a0e932dfd45622f4e2b Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 8 Oct 2018 11:08:47 -0700
Subject: [PATCH] spi: spi-ep93xx: Use dma_data_direction for
 ep93xx_spi_dma_{finish,prepare}

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expect an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Convert the driver to
use dma_data_direction for these two functions.

There are two places that strictly require an enum of type
dma_transfer_direction: the direction member in struct dma_slave_config
and the direction parameter in dmaengine_prep_slave_sg. To avoid using
an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
to safely map between the two types because they are not 1 to 1 in
meaning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ep93xx.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..79fc3940245a 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
 	return -EINPROGRESS;
 }
 
+static enum dma_transfer_direction
+ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return DMA_MEM_TO_DEV;
+	case DMA_FROM_DEVICE:
+		return DMA_DEV_TO_MEM;
+	default:
+		return DMA_TRANS_NONE;
+	}
+}
+
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  */
 static struct dma_async_tx_descriptor *
 ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+		       enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = dir;
+	conf.direction = ep93xx_dma_data_to_trans_dir(dir);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
@@ -343,7 +356,8 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
-	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
+	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, conf.direction,
+				      DMA_CTRL_ACK);
 	if (!txd) {
 		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
@@ -360,13 +374,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * unmapped.
  */
 static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+				  enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		sgt = &espi->rx_sgt;
 	} else {
@@ -381,8 +395,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 {
 	struct spi_master *master = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 
 	spi_finalize_current_transfer(master);
 }
@@ -392,15 +406,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}
-- 
2.19.0

