Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18C6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B709A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dek+9745";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aDmiYCUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B709A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeJZBO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:14:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJZBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:14:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9015961306; Thu, 25 Oct 2018 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540485653;
        bh=OTNdK285lgIDwS88sqezi5aipcK7AMhAthv46ueeTyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dek+9745a+FEm5UUDtJNW3neZ3/dA7PvXGEo4JTdNe7rBF1fSA+xAFoidQt8C1XjR
         NXptsjj77sJGDknCKWjKf7cyarKQ1U9Q9zojPI6t+jMHlPm1+uDnwDk3VeheUI+5bQ
         ysI2yWetyB9PLs5T/BMqDSvknK1+8JyVlpp5z0R0=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35C6D611F1;
        Thu, 25 Oct 2018 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540485652;
        bh=OTNdK285lgIDwS88sqezi5aipcK7AMhAthv46ueeTyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDmiYCUxYxprMvaSuVoOvK0ioWIvpG3c3jbrUsvi+W09/EowtF3/zY2I+aaGR6dyN
         ThzEmF8gB4DocoBmTQsZRByAbwz3vEBCFMieofhvKWTdIde27WMcoJfQZXdVpfoXU7
         j0TL1uK73Tjv1rVMPdKw5lpdHxDg6KH2EdC1GOUg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35C6D611F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH 2/2] spi: spi-geni-qcom: Simplify probe function
Date:   Thu, 25 Oct 2018 22:10:29 +0530
Message-Id: <1540485629-5970-3-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange existing APIs in probe function to
avoid using goto and remove redundant variables.

Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 drivers/spi/spi-geni-qcom.c | 49 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d1830fb..fdb7cb88 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

