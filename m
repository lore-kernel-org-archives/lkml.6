Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20CDC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C05208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt12wWw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C05208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFTIg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:36:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32878 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeFTIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:36:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so3694290lfy.0;
        Wed, 20 Jun 2018 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIO26ZkyXLNrCqxuAoYh7QrVWEeXJ2Z46Hhm0rThDCI=;
        b=Qt12wWw5wmSUF63iB3YH7S95XVD85W9/+u1ePUgPAdO8reJeA9kldhAx7FxMxbnNzC
         j7n0u38uBdzOTJmvzKFQ2OmyzKy3+2lJcr9RAI44r3HcYjwBKimzzMbvMtxiZvaqB0Qn
         O+pP32mzkUg8wNkXRHgl3xDfGk0mlKwIFzoHCRnMtaVEBbQUkdSQpeAfWtdr1SDQrNCs
         hyFdeiHQQmesPVULX2Ajcf2/IYekHOgUqsGRJnqye1EvHlHOvzJi/aOrH2pZD93tCJ2s
         Sib0Raqm4PMS+AHDzNytVAtF87PBvr0bng+9lP36vBDvvtaUeQ81zexHStT4Xr/o4xWt
         /MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sIO26ZkyXLNrCqxuAoYh7QrVWEeXJ2Z46Hhm0rThDCI=;
        b=B5QjMyt4zF7z6938ZCa1Cs8qyVLhN/3IfTFFLUsm9g6qJHHc2SC6OZri8kT7heNDe9
         kEQ2OyYrM/knobgODhBcOzZXXLTuKQQeO5YRh2vwDjMPdqb76QzYxBCu55/82rJLkCpP
         tdKa6YDNQ01RXJeoeJaKPGPNwmwT1aCU/fjX4dlbIc3pXVstjPDxvhMSyppn5NVMtvoa
         umGSGcPefPqemouM2yzhtK/Ar6TfdHAARPoulN3E+Mabz7HSrb4jHrAXkH+KhI9zpLsm
         MUx1qLxSHGFaq+75O6mVfjqkhQlT0Hc7+vy3bIdZVYewmvZ3TdhjTaYSV2M+QSmcX8ee
         pF1A==
X-Gm-Message-State: APt69E2OElEqKEEWUIAYG3n/VSAD1OjTz5XTXM06KNvquZTNtyvI9LYs
        SMxYQvFMlpbGupAJkDE6cD0NA8eq
X-Google-Smtp-Source: ADUXVKLqNI7cKlP9zOHXstaBFrD5Y28zaFvZjKG2Hg7TxN2iCBWPF2x1cxNcW5A+/L4heStrMq2pSg==
X-Received: by 2002:a19:6450:: with SMTP id b16-v6mr12815855lfj.46.1529480103709;
        Wed, 20 Jun 2018 00:35:03 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id d19-v6sm283366lfc.65.2018.06.20.00.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:03 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 08/12] spi: spi-fsl-dspi: Add support for XSPI mode registers
Date:   Wed, 20 Jun 2018 09:34:38 +0200
Message-Id: <20180620073442.20913-9-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This prepares for adding support for extended SPI mode (XSPI), by extending
the regmap with the extra SREX and CTAREx registers.

An additional register map is made for allowing 16 bit access to CMD and TX
FIFO of the PUSHR register separately, which is also needed for XSPI mode
support.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 63 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d83d3496d538..3e9dd645ee54 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -108,11 +108,21 @@
 #define SPI_RXFR2		0x84
 #define SPI_RXFR3		0x88
 
+#define SPI_CTARE(x)		(0x11c + (((x) & 0x3) * 4))
+#define SPI_CTARE_FMSZE(x)	(((x) & 0x1) << 16)
+#define SPI_CTARE_DTCP(x)	((x) & 0x7ff)
+
+#define SPI_SREX		0x13c
+
 #define SPI_FRAME_BITS(bits)	SPI_CTAR_FMSZ((bits) - 1)
 #define SPI_FRAME_BITS_MASK	SPI_CTAR_FMSZ(0xf)
 #define SPI_FRAME_BITS_16	SPI_CTAR_FMSZ(0xf)
 #define SPI_FRAME_BITS_8	SPI_CTAR_FMSZ(0x7)
 
+/* Register offsets for regmap_pushr */
+#define PUSHR_CMD		0x0
+#define PUSHR_TX		0x2
+
 #define SPI_CS_INIT		0x01
 #define SPI_CS_ASSERT		0x02
 #define SPI_CS_DROP		0x04
@@ -133,6 +143,7 @@ enum dspi_trans_mode {
 struct fsl_dspi_devtype_data {
 	enum dspi_trans_mode trans_mode;
 	u8 max_clock_factor;
+	bool xspi_mode;
 };
 
 static const struct fsl_dspi_devtype_data vf610_data = {
@@ -143,6 +154,7 @@ static const struct fsl_dspi_devtype_data vf610_data = {
 static const struct fsl_dspi_devtype_data ls1021a_v1_data = {
 	.trans_mode = DSPI_TCFQ_MODE,
 	.max_clock_factor = 8,
+	.xspi_mode = true,
 };
 
 static const struct fsl_dspi_devtype_data ls2085a_data = {
@@ -177,6 +189,7 @@ struct fsl_dspi {
 	struct platform_device	*pdev;
 
 	struct regmap		*regmap;
+	struct regmap		*regmap_pushr;
 	int			irq;
 	struct clk		*clk;
 
@@ -876,6 +889,35 @@ static const struct regmap_config dspi_regmap_config = {
 	.volatile_table = &dspi_volatile_table,
 };
 
+static const struct regmap_range dspi_xspi_volatile_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_TCR),
+	regmap_reg_range(SPI_SR, SPI_SR),
+	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_xspi_volatile_table = {
+	.yes_ranges     = dspi_xspi_volatile_ranges,
+	.n_yes_ranges   = ARRAY_SIZE(dspi_xspi_volatile_ranges),
+};
+
+static const struct regmap_config dspi_xspi_regmap_config[] = {
+	{
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = 0x13c,
+		.volatile_table = &dspi_xspi_volatile_table,
+	},
+	{
+		.name = "pushr",
+		.reg_bits = 16,
+		.val_bits = 16,
+		.reg_stride = 2,
+		.max_register = 0x2,
+	},
+};
+
 static void dspi_init(struct fsl_dspi *dspi)
 {
 	regmap_write(dspi->regmap, SPI_MCR, SPI_MCR_MASTER | SPI_MCR_PCSIS);
@@ -888,6 +930,7 @@ static int dspi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct fsl_dspi *dspi;
 	struct resource *res;
+	const struct regmap_config *regmap_config;
 	void __iomem *base;
 	struct fsl_dspi_platform_data *pdata;
 	int ret = 0, cs_num, bus_num;
@@ -946,8 +989,11 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	dspi->regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
-						&dspi_regmap_config);
+	if (dspi->devtype_data->xspi_mode)
+		regmap_config = &dspi_xspi_regmap_config[0];
+	else
+		regmap_config = &dspi_regmap_config;
+	dspi->regmap = devm_regmap_init_mmio(&pdev->dev, base, regmap_config);
 	if (IS_ERR(dspi->regmap)) {
 		dev_err(&pdev->dev, "failed to init regmap: %ld\n",
 				PTR_ERR(dspi->regmap));
@@ -955,6 +1001,19 @@ static int dspi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
+	if (dspi->devtype_data->xspi_mode) {
+		dspi->regmap_pushr = devm_regmap_init_mmio(
+			&pdev->dev, base + SPI_PUSHR,
+			&dspi_xspi_regmap_config[1]);
+		if (IS_ERR(dspi->regmap_pushr)) {
+			dev_err(&pdev->dev,
+				"failed to init pushr regmap: %ld\n",
+				PTR_ERR(dspi->regmap_pushr));
+			ret = PTR_ERR(dspi->regmap);
+			goto out_master_put;
+		}
+	}
+
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
-- 
2.17.1

