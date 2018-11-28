Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DE0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483120873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aikvz4gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2483120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeK1PiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:38:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32901 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1PiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:38:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so8914347pgu.0;
        Tue, 27 Nov 2018 20:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKMQWWfUHZZOA8Vzj6/uHTz4rgCPTS/PQKfPLKAd68k=;
        b=Aikvz4gZIOSGLjoKRlkArv9rJlKlnMWzRKpjyaJOYGn438UAppm4ZTIkPsieyPJs/J
         mWB0BLnXPbOKwT6K3OWVec63a2jFEREcsrmlukroyuJE8EsQqQ7eirtWLtzBoGaol3RH
         MNSkBtvVQZOdW8A/38TlTcACZJU1iV8zL6axmc/KPlD04/yc11BA7XBxi7Auw/41HXBI
         vw2kVx0oaGdLbmLHnzMxAMaeU5+LB43vOdMwOrXhtxTjfHpDwuO6EaVE1rWe+OZSqqSd
         4gKnnWissIS5rT+slIROQ5Ya0Vjni/K0oEnMVwxer4sjJQh5JpGUqoiwUycXSIdYTi29
         lcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKMQWWfUHZZOA8Vzj6/uHTz4rgCPTS/PQKfPLKAd68k=;
        b=BZpjK+/dN63QA87irnwM/IR+DFMyMNEAZIG28UES1DGY45ru2+n8tNMJSshqD5iKbt
         3exSVhYXKjHYIpcSYbWeTXXe6845ksV7ZZpCGDbadpwuCGJg/+ErSiFKHrh3a4P97jmP
         BrqinmZywNbZLYdHdsZDgYfb4yWGH8W7t7nY9TsciOSmwpcPUc/ineuE6Xxh7OPGQkrf
         0yJDkk/uLxdXVQg7NCMIZ9xzJd50DLWJHBUVbXDt3BG4bCdTHD1aIU7zPN6ymXedGl/U
         zDHTpOonzhLSfp8Q2SIM0jNZV5plYd+AWIOtCjQ0FTHu9eSWLMeM8I4NrD2lW7n06hAx
         /03Q==
X-Gm-Message-State: AA+aEWYXrGHhwfFaEXxlThOX4wrEfLjnebznsOjY2FdDPS2XAQTTHKT1
        rDsYAc8N89p1gkaho5gDNRR3+4E7lKA=
X-Google-Smtp-Source: AFSGD/V+/SqdeXkkcw3/hIVS3ALxB9OUqaIJsoKIXJ23hshuqHsH02bGsjXbkm6ujP9vOguuqYgnYQ==
X-Received: by 2002:a63:f811:: with SMTP id n17mr32690225pgh.23.1543379873586;
        Tue, 27 Nov 2018 20:37:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v2sm6387369pgs.0.2018.11.27.20.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 20:37:52 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] reset: imx7: Add plubming to support multiple IP variants
Date:   Tue, 27 Nov 2018 20:37:36 -0800
Message-Id: <20181128043738.12714-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128043738.12714-1-andrew.smirnov@gmail.com>
References: <20181128043738.12714-1-andrew.smirnov@gmail.com>
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
 drivers/reset/reset-imx7.c | 62 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 77911fa8f31d..cfbb6346a72e 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -17,14 +17,29 @@
 
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
+struct imx7_src;
+
+struct imx7_src_variant {
+	const struct imx7_src_signal *signals;
+	unsigned int signals_num;
+	unsigned int (*prepare)(struct imx7_src *imx7src, unsigned long id,
+				bool assert);
+};
+
 struct imx7_src {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
+	struct imx7_src_variant *variant;
 };
 
 enum imx7_src_registers {
@@ -39,10 +54,6 @@ enum imx7_src_registers {
 	SRC_DDRC_RCR		= 0x1000,
 };
 
-struct imx7_src_signal {
-	unsigned int offset, bit;
-};
-
 static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_A7_CORE_POR_RESET0] = { SRC_A7RCR0, BIT(0) },
 	[IMX7_RESET_A7_CORE_POR_RESET1] = { SRC_A7RCR0, BIT(1) },
@@ -72,17 +83,11 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
-static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+static unsigned int
+imx7_src_prepare(struct imx7_src *imx7src, unsigned long id, bool assert)
 {
-	return container_of(rcdev, struct imx7_src, rcdev);
-}
-
-static int imx7_reset_set(struct reset_controller_dev *rcdev,
-			  unsigned long id, bool assert)
-{
-	struct imx7_src *imx7src = to_imx7_src(rcdev);
-	const struct imx7_src_signal *signal = &imx7_src_signals[id];
-	unsigned int value = assert ? signal->bit : 0;
+	const unsigned int bit = imx7src->variant->signals[id].bit;
+	unsigned int value = assert ? bit : 0;
 
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
@@ -95,10 +100,32 @@ static int imx7_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX7_RESET_PCIE_CTRL_APPS_EN:
-		value = (assert) ? 0 : signal->bit;
+		value = assert ? 0 : bit;
 		break;
 	}
 
+	return value;
+}
+
+static const struct imx7_src_variant variant_imx7 = {
+	.signals = imx7_src_signals,
+	.signals_num = ARRAY_SIZE(imx7_src_signals),
+	.prepare = imx7_src_prepare,
+};
+
+static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct imx7_src, rcdev);
+}
+
+static int imx7_reset_set(struct reset_controller_dev *rcdev,
+			  unsigned long id, bool assert)
+{
+	struct imx7_src *imx7src = to_imx7_src(rcdev);
+	const struct imx7_src_variant *variant = imx7src->variant;
+	const struct imx7_src_signal *signal = &variant->signals[id];
+	const unsigned int value = variant->prepare(imx7src, id, assert);
+
 	return regmap_update_bits(imx7src->regmap,
 				  signal->offset, signal->bit, value);
 }
@@ -130,6 +157,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	if (!imx7src)
 		return -ENOMEM;
 
+	imx7src->variant = of_device_get_match_data(dev);
 	imx7src->regmap = syscon_node_to_regmap(dev->of_node);
 	if (IS_ERR(imx7src->regmap)) {
 		dev_err(dev, "Unable to get imx7-src regmap");
@@ -138,7 +166,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 	regmap_attach_dev(dev, imx7src->regmap, &config);
 
 	imx7src->rcdev.owner     = THIS_MODULE;
-	imx7src->rcdev.nr_resets = IMX7_RESET_NUM;
+	imx7src->rcdev.nr_resets = imx7src->variant->signals_num;
 	imx7src->rcdev.ops       = &imx7_reset_ops;
 	imx7src->rcdev.of_node   = dev->of_node;
 
@@ -146,7 +174,7 @@ static int imx7_reset_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx7_reset_dt_ids[] = {
-	{ .compatible = "fsl,imx7d-src", },
+	{ .compatible = "fsl,imx7d-src", .data = &variant_imx7 },
 	{ /* sentinel */ },
 };
 
-- 
2.19.1

