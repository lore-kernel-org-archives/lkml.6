Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD67FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EBC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RYhdJbGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EBC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeG3Mji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:39:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeG3Mjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eoR9AQuJFEjHcvuuXc9lVWxS5L9Ipym75vEM457e9d0=; b=RYhdJbGYGVmp
        0sUh3zyGrHeKvX9/Cc1++6Fnl1rLDEWccaCWn9EjgzbghcwVWzWCsx/GaJwvDd1VpRMX/n4MsvQWL
        QtC+0GF2kV5KHq2NfPB72uTGxFuUQTjWoZOK4xkgFI8FoR3HLueequgvoFiucyZSV4vrittAmMKxx
        hZG/o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5z8-00055W-Jm; Mon, 30 Jul 2018 11:05:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5931F1124216; Mon, 30 Jul 2018 12:05:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw: export dw_spi_set_cs" to the spi tree
In-Reply-To:  <20180727195358.23336-2-alexandre.belloni@bootlin.com>
Message-Id: <20180730110506.5931F1124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 12:05:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: export dw_spi_set_cs

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

From c79bdbb490a1d05c6169cbffd37c19f5aa96587a Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 27 Jul 2018 21:53:54 +0200
Subject: [PATCH] spi: dw: export dw_spi_set_cs

Export dw_spi_set_cs so it can be used from the various IP integration
modules.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0d8ccb8be5ec..683a4f137a25 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static void dw_spi_set_cs(struct spi_device *spi, bool enable)
+void dw_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
@@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 }
+EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
 /* Return the max entries we can fill into tx fifo */
 static inline u32 tx_max(struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 446013022849..0168b08364d5 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -245,6 +245,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
+extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
 extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
-- 
2.18.0

