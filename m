Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752A8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B842085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KqZu29VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B842085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJKWZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:25:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeJKWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HZoC+TjuukdcZdzVH0JudfJ2Hr+rjEstwT6ENcocrTM=; b=KqZu29VHF7E+
        kvogZ/guy1xfcctbGY8GtTzv5aooADC7eI0GSBhCVh4oIHNpUi+1Spx80HMF5X29ZIwSnTBgcelib
        th4PmDvrViGw3FREjhLQ1c+uh6XGVd9l7lW1Jg3MQS/BhR1zGYS/2pjdxroLTIXKLYQc9RnqO9xWw
        3UjMo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcPt-0001uO-0i; Thu, 11 Oct 2018 14:58:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BB1B411223ED; Thu, 11 Oct 2018 15:58:20 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, jonnyc@amazon.com,
        ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>, linux-spi@vger.kernel.org
Subject: Applied "dw: spi: add support for Amazon's Alpine spi controller" to the spi tree
In-Reply-To:  <1539256807-25676-2-git-send-email-talel@amazon.com>
Message-Id: <20181011145820.BB1B411223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:58:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dw: spi: add support for Amazon's Alpine spi controller

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

From f2d704794864a4bb486f2a0eaed40f25dd87303f Mon Sep 17 00:00:00 2001
From: Talel Shenhar <talel@amazon.com>
Date: Thu, 11 Oct 2018 14:20:07 +0300
Subject: [PATCH] dw: spi: add support for Amazon's Alpine spi controller

Add support for a new devicetree compatible string called
'amazon,alpine-apb-ssi', which is necessary for the Amazon Alpine spi
controller. 'amazon,alpine-dw-apb-ssi' is used in the dw spi driver if
specified in the devicetree.  Otherwise, fall back to driver default
behavior, i.e. original dw IP hw driver behavior.

Signed-off-by: Talel Shenhar <talel@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 9 +++++++++
 drivers/spi/spi-dw.c      | 6 ++++++
 drivers/spi/spi-dw.h      | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a768461614a0..3ffb6a40fe0c 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -126,6 +126,14 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 				JAGUAR2_IF_SI_OWNER_OFFSET);
 }
 
+static int dw_spi_alpine_init(struct platform_device *pdev,
+			      struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.cs_override = 1;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -230,6 +238,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
 	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
 	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
+	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 3e205ab60cd4..b705f2bdb8b9 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -144,6 +144,8 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
+	else if (dws->cs_override)
+		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
 
@@ -463,6 +465,10 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		dws->fifo_len = (fifo == 1) ? 0 : fifo;
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
 	}
+
+	/* enable HW fixup for explicit CS deselect for Amazon's alpine chip */
+	if (dws->cs_override)
+		dw_writel(dws, DW_SPI_CS_OVERRIDE, 0xF);
 }
 
 int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 0168b08364d5..c9c15881e982 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -32,6 +32,7 @@
 #define DW_SPI_IDR			0x58
 #define DW_SPI_VERSION			0x5c
 #define DW_SPI_DR			0x60
+#define DW_SPI_CS_OVERRIDE		0xf4
 
 /* Bit fields in CTRLR0 */
 #define SPI_DFS_OFFSET			0
@@ -109,6 +110,7 @@ struct dw_spi {
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
+	int			cs_override;
 	u32			reg_io_width;	/* DR I/O width in bytes */
 	u16			bus_num;
 	u16			num_cs;		/* supported slave numbers */
-- 
2.19.0.rc2

