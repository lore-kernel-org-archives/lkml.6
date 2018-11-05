Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3374FC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE920825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PfAzt8/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DE920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeKEVXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:23:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeKEVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nXSRv8x5bNPPK9GWrikJWsKHaKaxYbqnOozf/4jj5I8=; b=PfAzt8/tkCNq
        ySe/mHnAmMVfXdQytRjd5HvmOqgenZqyD9nlEIRUuNL5WoMTT8MtdyoOcB73j0k23rJ+CLz4YRiVk
        vgiUNmGMz6GcwbxXzir6ZP43r5EwDs1ZOGuuwMlekNjluaSRRqRXVMEQN3Am3DInW1przdJSLx7ML
        JRbEU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdbf-0008Km-9z; Mon, 05 Nov 2018 12:03:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0C2521124D98; Mon,  5 Nov 2018 12:03:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, swboyd@chromium.org,
        dianders@chromium.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-geni-qcom: Simplify probe function" to the spi tree
In-Reply-To:  <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
Message-Id: <20181105120347.0C2521124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 12:03:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: Simplify probe function

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

From 6a34e285de9afc4441ee81ce76865acd30ed9263 Mon Sep 17 00:00:00 2001
From: Alok Chauhan <alokc@codeaurora.org>
Date: Thu, 25 Oct 2018 22:10:29 +0530
Subject: [PATCH] spi: spi-geni-qcom: Simplify probe function

Re-arrange existing APIs in probe function to
avoid using goto and remove redundant variables.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d1830fbf2fc6..fdb7cb88fb56 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -535,11 +535,30 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 static int spi_geni_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
 	struct spi_master *spi;
 	struct spi_geni_master *mas;
 	struct resource *res;
-	struct geni_se *se;
+	void __iomem *base;
+	struct clk *clk;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+		return irq;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, "se");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
+						PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
 
 	spi = spi_alloc_master(&pdev->dev, sizeof(*mas));
 	if (!spi)
@@ -547,27 +566,15 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
+	mas->irq = irq;
 	mas->dev = &pdev->dev;
 	mas->se.dev = &pdev->dev;
 	mas->se.wrapper = dev_get_drvdata(pdev->dev.parent);
-	se = &mas->se;
+	mas->se.base = base;
+	mas->se.clk = clk;
 
 	spi->bus_num = -1;
 	spi->dev.of_node = pdev->dev.of_node;
-	mas->se.clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(mas->se.clk)) {
-		ret = PTR_ERR(mas->se.clk);
-		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
-		goto spi_geni_probe_err;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	se->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(se->base)) {
-		ret = PTR_ERR(se->base);
-		goto spi_geni_probe_err;
-	}
-
 	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
@@ -586,13 +593,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
 
-	mas->irq = platform_get_irq(pdev, 0);
-	if (mas->irq < 0) {
-		ret = mas->irq;
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
-		goto spi_geni_probe_runtime_disable;
-	}
-
 	ret = request_irq(mas->irq, geni_spi_isr,
 			IRQF_TRIGGER_HIGH, "spi_geni", spi);
 	if (ret)
@@ -607,7 +607,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_probe_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
-spi_geni_probe_err:
 	spi_master_put(spi);
 	return ret;
 }
-- 
2.19.0.rc2

