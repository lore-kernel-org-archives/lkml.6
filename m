Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2175FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFF620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RvkyWlgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFF620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeG3Mjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:39:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53746 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeG3Mjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=a/EEvf6AtsUTJdJOf2CLzWGd3mFTCoPdeGTEUZ3Ltus=; b=RvkyWlgc60td
        v7YuHiXnCkgUbXnPSW00QclZsB5FZEu622xz8gU9hraPYTWV2AM1hTEGjR00RdXRoT6k30QhqIxyM
        BBWfgy9qgPsaY/eMotInd64E6GvcQExGrqcBhH/h3tfZB0WP1uJ5yhu+glU731jJgd5mV2FYlEu52
        ea3qc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5z3-00055K-Vv; Mon, 30 Jul 2018 11:05:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD0D91124216; Mon, 30 Jul 2018 12:05:01 +0100 (BST)
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
Subject: Applied "spi: dw-mmio: add MSCC Ocelot support" to the spi tree
In-Reply-To:  <20180727195358.23336-4-alexandre.belloni@bootlin.com>
Message-Id: <20180730110501.AD0D91124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 12:05:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw-mmio: add MSCC Ocelot support

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

From c2c25cc397026ec705e050248539df400d2563f8 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 27 Jul 2018 21:53:56 +0200
Subject: [PATCH] spi: dw-mmio: add MSCC Ocelot support

Because the SPI controller deasserts the chip select when the TX fifo is
empty (which may happen in the middle of a transfer), the CS should be
handled by linux. Unfortunately, some or all of the first four chip
selects are not muxable as GPIOs, depending on the SoC.

There is a way to bitbang those pins by using the SPI boot controller so
use it to set the chip selects.

At init time, it is also necessary to give control of the SPI interface to
the Designware IP.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 90 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index d25cc4037e23..e80f60ed6fdf 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -15,11 +15,13 @@
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 
 #include "spi-dw.h"
 
@@ -28,10 +30,90 @@
 struct dw_spi_mmio {
 	struct dw_spi  dws;
 	struct clk     *clk;
+	void           *priv;
 };
 
+#define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
+#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
+#define OCELOT_IF_SI_OWNER_OFFSET		4
+#define MSCC_IF_SI_OWNER_SISL			0
+#define MSCC_IF_SI_OWNER_SIBM			1
+#define MSCC_IF_SI_OWNER_SIMC			2
+
+#define MSCC_SPI_MST_SW_MODE			0x14
+#define MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE	BIT(13)
+#define MSCC_SPI_MST_SW_MODE_SW_SPI_CS(x)	(x << 5)
+
+struct dw_spi_mscc {
+	struct regmap       *syscon;
+	void __iomem        *spi_mst;
+};
+
+/*
+ * The Designware SPI controller (referred to as master in the documentation)
+ * automatically deasserts chip select when the tx fifo is empty. The chip
+ * selects then needs to be either driven as GPIOs or, for the first 4 using the
+ * the SPI boot controller registers. the final chip select is an OR gate
+ * between the Designware SPI controller and the SPI boot controller.
+ */
+static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
+	u32 cs = spi->chip_select;
+
+	if (cs < 4) {
+		u32 sw_mode = MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE;
+
+		if (!enable)
+			sw_mode |= MSCC_SPI_MST_SW_MODE_SW_SPI_CS(BIT(cs));
+
+		writel(sw_mode, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
+	}
+
+	dw_spi_set_cs(spi, enable);
+}
+
+static int dw_spi_mscc_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	struct dw_spi_mscc *dwsmscc;
+	struct resource *res;
+
+	dwsmscc = devm_kzalloc(&pdev->dev, sizeof(*dwsmscc), GFP_KERNEL);
+	if (!dwsmscc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dwsmscc->spi_mst = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dwsmscc->spi_mst)) {
+		dev_err(&pdev->dev, "SPI_MST region map failed\n");
+		return PTR_ERR(dwsmscc->spi_mst);
+	}
+
+	dwsmscc->syscon = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
+	if (IS_ERR(dwsmscc->syscon))
+		return PTR_ERR(dwsmscc->syscon);
+
+	/* Deassert all CS */
+	writel(0, dwsmscc->spi_mst + MSCC_SPI_MST_SW_MODE);
+
+	/* Select the owner of the SI interface */
+	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+			   OCELOT_IF_SI_OWNER_MASK,
+			   MSCC_IF_SI_OWNER_SIMC << OCELOT_IF_SI_OWNER_OFFSET);
+
+	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
+	dwsmmio->priv = dwsmscc;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
+	int (*init_func)(struct platform_device *pdev,
+			 struct dw_spi_mmio *dwsmmio);
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
 	struct resource *mem;
@@ -99,6 +181,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
+	init_func = device_get_match_data(&pdev->dev);
+	if (init_func) {
+		ret = init_func(pdev, dwsmmio);
+		if (ret)
+			goto out;
+	}
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
@@ -123,6 +212,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
+	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.18.0

