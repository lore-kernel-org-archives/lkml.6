Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB0C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57715217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwN2kjzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAVCLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:11:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39922 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfAVCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:11:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so10966010pfc.6;
        Mon, 21 Jan 2019 18:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnZUx9XxqHMk3snYHuOBwaNuTfH4gj67xCuvojOFsmM=;
        b=YwN2kjzm1F3DrbKw8EOucGGzxpFsixUiz2rWuDsGln7h6FnSGb3LmEfR2Iy55qmyAE
         U2Zdvro9gXXKMOg5qU6KzYiRIshLUZHFdcJiBRPX3DTdQSxYVKkOcsa5sfYV0TaBo9w3
         KsGpfhQyvuoCi4ZZXimzN7iBEL31yLfGgZRTe+5hYRSQc0kiFK0xuBZtzUnGLshui8J1
         vee7wPWaZj03US8Ue8VbownCvowg6aHTZCd0SJANwPvDAYAk79APnPx1ZbNmIOconG16
         0J89WMQGRfss9x6MqjCNVErbj0BwJAvVwNcxhc4WQcKWMbIqtDXidcLjaZ5WNV8u51y7
         ykGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnZUx9XxqHMk3snYHuOBwaNuTfH4gj67xCuvojOFsmM=;
        b=G4XU4hfwe/jusYFOeMdiTmdPM0f2SkkPJ108ApE2kHEsiu4kRppPre7n+gDLKHpcXQ
         M2615Iutg51YkYbUY0qHzaT9XRESQ8/0m2hqM+zJIAi1rUa4sAIut22waWCqJaI1VIAp
         7ZCl0WNcEsmTFQkJLuaOyUzBRyp1x/71l1YH+lw5sCQsRIji5gD9IUgVD8R2P1bRRyRf
         cFZCC09ASIsXsgiadwPftA5lxamPJW2sqPjOu5zZspgRTDxpv7sWP42rrlrvIS7q9jBV
         AjWZvdPfWZ1cmnd+hQ5ELXQXK56egrEIQVVzv/9rWSG9rTCzIZrFLwGjzEXt8bzXK5IW
         EhzA==
X-Gm-Message-State: AJcUukfTzvaRwXaKnt8g+4WyKlvCaRAPLTl+Uj22H5upSKzSbTPSdpl7
        CdGEd74Qo10oWO8mtga7Q5U=
X-Google-Smtp-Source: ALg8bN58U0fAmlsCx0QNK24woKhwYnCON78wVHE0oOQhqizrGw/ZzWAMmmjouGua/ETzSB6W0EiElA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr29947169pgh.220.1548123065130;
        Mon, 21 Jan 2019 18:11:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c7sm19907267pfh.18.2019.01.21.18.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:11:04 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] reset: imx7: Add plubming to support multiple IP variants
Date:   Mon, 21 Jan 2019 18:10:41 -0800
Message-Id: <20190122021043.25449-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122021043.25449-1-andrew.smirnov@gmail.com>
References: <20190122021043.25449-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable supporting i.MX8MQ with this driver, convert it to
expect variant specific bits to be passed via driver data.

Cc: p.zabel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/reset/reset-imx7.c | 50 +++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..cb6e3bc4acc1 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -17,14 +17,26 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <dt-bindings/reset/imx7-reset.h>
 
+struct imx7_src_signal {
+	unsigned int offset, bit;
+};
+
+struct imx7_src_variant {
+	const struct imx7_src_signal *signals;
+	unsigned int signals_num;
+	struct reset_control_ops ops;
+};
+
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	const struct imx7_src_signal *signals;
 };
 
 enum imx7_src_registers {
@@ -39,9 +51,14 @@ enum imx7_src_registers {
 	SRC_DDRC_RCR		= 0x1000,
 };
 
-struct imx7_src_signal {
-	unsigned int offset, bit;
-};
+static int imx7_reset_update(struct imx7_src *imx7src,
+			     unsigned long id, unsigned int value)
+{
+	const struct imx7_src_signal *signal = &imx7src->signals[id];
+
+	return regmap_update_bits(imx7src->regmap,
+				  signal->offset, signal->bit, value);
+}
 
 static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
@@ -81,8 +98,8 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 			  unsigned long id, bool assert)
 {
 	struct imx7_src *imx7src = to_imx7_src(rcdev);
-	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = assert ? signal->bit : 0;
+	const unsigned int bit = imx7src->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
@@ -95,12 +112,11 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
-		value = (assert) ? 0 : signal->bit;
+		value = assert ? 0 : bit;
 		break;
 	}
 
-	return regmap_update_bits(imx7src->regmap,
-				  signal->offset, signal->bit, value);
+	return imx7_reset_update(imx7src, id, value);
 }
 
 static int imx7_reset_assert(struct reset_controller_dev *rcdev,
@@ -115,9 +131,13 @@ static int imx7_reset_deassert(struct reset_controller_dev *rcdev,
 	return imx7_reset_set(rcdev, id, false);
 }
 
-static const struct reset_control_ops imx7_reset_ops = {
-	.assert		= imx7_reset_assert,
-	.deassert	= imx7_reset_deassert,
+static const struct imx7_src_variant variant_imx7 = {
+	.signals = imx7_src_signals,
+	.signals_num = ARRAY_SIZE(imx7_src_signals),
+	.ops = {
+		.assert   = imx7_reset_assert,
+		.deassert = imx7_reset_deassert,
+	},
 };
 
 static int imx7_reset_probe(struct platform_device *pdev)
@@ -125,11 +145,13 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	struct imx7_src *imx7src;
 	struct device *dev = &pdev->dev;
 	struct regmap_config config = { .name = "src" };
+	const struct imx7_src_variant *variant = of_device_get_match_data(dev);
 
 	imx7src = devm_kzalloc(dev, sizeof(*imx7src), GFP_KERNEL);
 	if (!imx7src)
 		return -ENOMEM;
 
+	imx7src->signals = variant->signals;
 	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(imx7src->regmap)) {
 		dev_err(dev, "Unable to get imx7-src regmap");
@@ -138,15 +160,15 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	regmap_attach_dev(dev, imx7src->regmap, &config);
 
 	imx7src->rcdev.owner     = THIS_MODULE;
-	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
-	imx7src->rcdev.ops       = &imx7_reset_ops;
+	imx7src->rcdev.nr_resets = variant->signals_num;
+	imx7src->rcdev.ops       = &variant->ops;
 	imx7src->rcdev.of_node   = dev->of_node;
 
 	return devm_reset_controller_register(dev, &imx7src->rcdev);
 }
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-src", },
+	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ /* sentinel */ },
 };
 
-- 
2.20.1

