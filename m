Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1FC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154CB21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XntCQ/Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154CB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJMAfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:35:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cwFxwjGVfqnXgGTBrHnPTcFRf85mG1qUALrOP7Yg5ls=; b=XntCQ/UsU4G1
        yaQsyvBOqiI/Gs0L7aAD657/vwq+y93B4tjt9zLMxxRgp+VZYfOQ1jTu4tjTeZfqbsRD1YpMTfSEe
        cEa3IMWc46tnDC47kKDpcM6n26/QMKmg1AMQv/upEinTHoHgoDyINaCYMjWqRjrp4gmg8+Tzx7ud5
        VsM0U=;
Received: from [91.126.136.150] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gB0oe-0006ed-PT; Fri, 12 Oct 2018 17:01:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4B40D440078; Fri, 12 Oct 2018 19:01:32 +0200 (CEST)
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: imx: move wml setting to later than setup_transfer" to the spi tree
In-Reply-To:  <1539196453-8704-2-git-send-email-yibin.gong@nxp.com>
Message-Id: <20181012170132.4B40D440078@finisterre.ee.mobilebroadband>
Date:   Fri, 12 Oct 2018 19:01:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: imx: move wml setting to later than setup_transfer

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

From 987a2dfe3f0485a82d87106e7e1c43f35c1d3b09 Mon Sep 17 00:00:00 2001
From: Robin Gong <yibin.gong@nxp.com>
Date: Wed, 10 Oct 2018 10:32:42 +0000
Subject: [PATCH] spi: imx: move wml setting to later than setup_transfer

Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Move wml setting for DMA
to the later place, thus, the next patch could get the right last sg
length for wml setting. This patch is a preparation one, no any
function change involved.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 08dd3a31a3e5..e861157e3459 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -63,6 +63,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
@@ -583,6 +584,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
 
+	return 0;
+}
+
+static void mx51_setup_wml(struct spi_imx_data *spi_imx)
+{
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
@@ -593,8 +599,6 @@ static int mx51_ecspi_config(struct spi_device *spi)
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
-
-	return 0;
 }
 
 static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
@@ -931,6 +935,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.trigger = mx51_ecspi_trigger,
 	.rx_available = mx51_ecspi_rx_available,
 	.reset = mx51_ecspi_reset,
+	.setup_wml = mx51_setup_wml,
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.dynamic_burst = true,
@@ -1138,7 +1143,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
-	int ret;
 
 	if (!t)
 		return 0;
@@ -1179,12 +1183,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = 0;
 
-	if (spi_imx->usedma) {
-		ret = spi_imx_dma_configure(spi->master);
-		if (ret)
-			return ret;
-	}
-
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
 		spi_imx->tx = mx53_ecspi_tx_slave;
@@ -1289,6 +1287,13 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master = spi_imx->bitbang.master;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	int ret;
+
+	ret = spi_imx_dma_configure(master);
+	if (ret)
+		return ret;
+
+	spi_imx->devtype_data->setup_wml(spi_imx);
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
-- 
2.19.0

