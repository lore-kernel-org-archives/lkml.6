Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149EC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7MVZcmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbeLQCix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:38:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeLQCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:38:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so4149243pga.1;
        Sun, 16 Dec 2018 18:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
        b=o7MVZcmK6/qVajV3whHRlwxEsGSJ0GbZl1JJYGbURqkT/qji3x8UdETBtI6n6rSuUr
         T/uzBYZfk8dJqUCfFDaAcS75oNakc/2GABUbGSvtOXTeTLMFS7WV5aZ7U9GrPXUlS4A5
         fWxijv1srVUR6OuU2WVTCsPYQLegVBAP/VVjLqCm0AhqOG4xlUrZlB9AErOv4hQAyjy6
         1xNNqJdt8rkFZGs62hSx5kwyn2GqN6pqKd7TDppVqGwI1Pt2ZYdgpJfjpFguLs3wzdxs
         VdblS2kFBA/wkFlFbUWPiUqwVnDQOzVDpHesDSxzXUQbITAkEuO6dclipieRoaQmVxDQ
         VTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nS8g9CvGS33gTXh86smptBvZsHuEs2BP+CgzydNvE9M=;
        b=Z/DxHsOHcNCr17xk4T1rIM2gmey4BQqj483fQn8rSmEga/gcoeVIt6agyInTygA6lY
         YEKkCpfuV+m1lUuc+6ANTkOfucuP9pPjnNHkvhPsamcDVrzUA3eqCnE2rpGAiSu83nLv
         09cRUTiOdYOQRJefUc6iuuQ287X09nleYaisAZAyYXRACiMo6V31jd2XmHtICRWBY0v6
         OPqHuYXsG/APHQH4i0iq0EBjfz3tEL5NCovZ+v1Fapb/+UYivs6aa1zXrw6KMttNPjPI
         jUIRIv0LkhPLwmvsGMwg1NTwO4Zw223Xj88BNr84UyoJLRhQsoCcGwgzw9qer66BtRcV
         i6XQ==
X-Gm-Message-State: AA+aEWZ65Egc9f+svJrnF8gsc/ZwKaXc6kCb9dIdZ/LgSUIcyXGF3Izn
        rJ8dsh9/XEh1rSp4T5ni2K/FzTSU
X-Google-Smtp-Source: AFSGD/VYJ3WZkw0gF3Q5fDERLIrFBpizsTq1T4nFno6+pxR1OytVRHLPTdPvbSHl6up/XIF/ujxiwQ==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr11512280pfp.117.1545014331325;
        Sun, 16 Dec 2018 18:38:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id b26sm23129781pfe.91.2018.12.16.18.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 18:38:50 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] reset: imx7: Add plubming to support multiple IP variants
Date:   Sun, 16 Dec 2018 18:38:25 -0800
Message-Id: <20181217023827.7947-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217023827.7947-1-andrew.smirnov@gmail.com>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
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
index 77911fa8f31d..3a36d5863891 100644
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
+	const struct imx7_src_variant *variant;
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

