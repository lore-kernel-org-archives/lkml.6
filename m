Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84770C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB0E2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490980;
	bh=VrBRcdgfM9hJijfIzhXNGKH0pF0bQwIdl2SjHBlBle0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2ZN297qFpaKbpZJ8EAsOne86RwS3OO1fs2Q49GddY+3XcTPXNVYBWGR7f1J+Ebzyd
	 QPrpQPDykujF+/RCWVlFExi0hHpGhIy0N/Ee1b2FwPCMWiwoX41UoaKWWry1wW8uFq
	 YaxtiVIV6AA3txi6FZNIjgzCqDSvTbalCG6OY/r0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB0E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeLKBQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeLKBQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cD5zjDyUXieUheO20Ld7DzUYylufB0J98rDcc7p8iKY=; b=viTIUDSjStCV
        iADBiRW6cW+QisYn92ynDeBklA0dqrCBgdoRcYSyPlSzC8v8hQWZ9v+9G5fdNRlDw2FwYDEiGTDWl
        JowytMnbcKNSuC5pZM2o5ohkQIFPwtvMsnwG+uPdpwdy6DL7ITxOYDdoKaCeZntmHQtceArci3gPv
        LaS/I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeg-0000Ln-5l; Tue, 11 Dec 2018 01:16:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DB1AB11254C7; Tue, 11 Dec 2018 01:16:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "gpio: devres: Handle nonexclusive GPIOs" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011609.DB1AB11254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   gpio: devres: Handle nonexclusive GPIOs

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From cb28ee388e465a956b05ada682f9ef90e776a9b7 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:45 +0100
Subject: [PATCH] gpio: devres: Handle nonexclusive GPIOs

When we get a nonexeclusive GPIO descriptor using managed
resources, we should only add it to the list of managed
resources once: on the first user. Augment the
devm_gpiod_get_index() and devm_gpiod_get_from_of_node()
calls to account for this by checking if the descriptor
is already resource managed before we proceed to allocate
a new resource management struct.

Fixes: b0ce7b29bfcd ("regulator/gpio: Allow nonexclusive GPIO access")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib-devres.c | 50 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 01959369360b..f9591b5c9748 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -98,15 +98,28 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 	struct gpio_desc **dr;
 	struct gpio_desc *desc;
 
+	desc = gpiod_get_index(dev, con_id, idx, flags);
+	if (IS_ERR(desc))
+		return desc;
+
+	/*
+	 * For non-exclusive GPIO descriptors, check if this descriptor is
+	 * already under resource management by this device.
+	 */
+	if (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
+		struct devres *dres;
+
+		dres = devres_find(dev, devm_gpiod_release,
+				   devm_gpiod_match, &desc);
+		if (dres)
+			return desc;
+	}
+
 	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
 			  GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		gpiod_put(desc);
 		return ERR_PTR(-ENOMEM);
-
-	desc = gpiod_get_index(dev, con_id, idx, flags);
-	if (IS_ERR(desc)) {
-		devres_free(dr);
-		return desc;
 	}
 
 	*dr = desc;
@@ -140,15 +153,28 @@ struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 	struct gpio_desc **dr;
 	struct gpio_desc *desc;
 
+	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
+	if (IS_ERR(desc))
+		return desc;
+
+	/*
+	 * For non-exclusive GPIO descriptors, check if this descriptor is
+	 * already under resource management by this device.
+	 */
+	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
+		struct devres *dres;
+
+		dres = devres_find(dev, devm_gpiod_release,
+				   devm_gpiod_match, &desc);
+		if (dres)
+			return desc;
+	}
+
 	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
 			  GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		gpiod_put(desc);
 		return ERR_PTR(-ENOMEM);
-
-	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
-	if (IS_ERR(desc)) {
-		devres_free(dr);
-		return desc;
 	}
 
 	*dr = desc;
-- 
2.19.0.rc2

