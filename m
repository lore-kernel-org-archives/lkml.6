Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C440C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3402086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V77yvcqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3402086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeK2DIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:08:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38942 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeK2DI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=USn8T5DUuL0JBN1z09MrPjgcjZaOWlHTBNpQBu+adh0=; b=V77yvcqI3nz6
        Bs1KQRU5EO/+LiryrzafdrKs3TUWEP/nI690WdE4sx7xd65WL9pWHjYN4riL6nm6ARMY01lHNYw4v
        Rak6JWFlyO9DrJw5MvP78tt/i4rpJXm4/HNBunkqBG/jIQU/L+YArSAKM21M5XogqwUUPfJMKtm2C
        jDxrI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gS2La-0005xh-Hx; Wed, 28 Nov 2018 16:05:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 460C0112521B; Wed, 28 Nov 2018 16:05:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     Mark Brown <broonie@kernel.org>, richard.genoud@gmail.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.co, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: at91-usart: add power management support" to the spi tree
In-Reply-To:  <20181121112732.15690-2-radu_nicolae.pirea@upb.ro>
Message-Id: <20181128160554.460C0112521B@debutante.sirena.org.uk>
Date:   Wed, 28 Nov 2018 16:05:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: at91-usart: add power management support

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

From 96ed3ecde2c0911ffa11838050a058c2a40742f0 Mon Sep 17 00:00:00 2001
From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Date: Wed, 21 Nov 2018 13:27:30 +0200
Subject: [PATCH] spi: at91-usart: add power management support

This patch implements power management callback function for USART as
SPI driver.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..0b07c746453d 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/spi/spi.h>
 
@@ -399,6 +400,59 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
+__maybe_unused static int at91_usart_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+
+	clk_disable_unprepare(aus->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(aus->clk);
+}
+
+__maybe_unused static int at91_usart_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_controller_suspend(ctrl);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		at91_usart_spi_runtime_suspend(dev);
+
+	return 0;
+}
+
+__maybe_unused static int at91_usart_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctrl);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = at91_usart_spi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	at91_usart_spi_init(aus);
+
+	return spi_controller_resume(ctrl);
+}
+
 static int at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
@@ -409,6 +463,12 @@ static int at91_usart_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct dev_pm_ops at91_usart_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
+	SET_RUNTIME_PM_OPS(at91_usart_spi_runtime_suspend,
+			   at91_usart_spi_runtime_resume, NULL)
+};
+
 static const struct of_device_id at91_usart_spi_dt_ids[] = {
 	{ .compatible = "microchip,at91sam9g45-usart-spi"},
 	{ /* sentinel */}
@@ -419,6 +479,7 @@ MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
 static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
+		.pm = &at91_usart_spi_pm_ops,
 	},
 	.probe = at91_usart_spi_probe,
 	.remove = at91_usart_spi_remove,
-- 
2.19.0.rc2

