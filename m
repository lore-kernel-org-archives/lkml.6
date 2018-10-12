Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4182075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYGLTF06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4182075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeJMAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:00:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37575 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeJMAAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:00:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id y11-v6so14067994wrd.4;
        Fri, 12 Oct 2018 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wWtu2dMp8UhwRbU3BwxSI2ynqCJj/uyJ/bC0hrHmYd4=;
        b=uYGLTF06V16IxrpB9a6SmyEad5qA6BmGLIWclTHvAprwtNAnR2PWMy8h5qUdLyOHNu
         T/VCQanlyTWpW1f6+hphzjp/FHqA7ULogm9BCIdujstG98Pjm/pRmUdSjfyeZJmw1WsM
         ZCOmXxVTON29efKbk9yGBahwwMMaMQdvQzEQuYFW/Q9+BcAbyK/22Yqi3UbxDA1O55ut
         Wi6jwNerPWTNt1S+HCUPkSE1TTI54Cj8g+7hCkgBKNtzVu7ghUrsF2vjxTOcmHVnKusj
         gOayEC5g0l2Dk7JI3UaqfVDB+dpHKOQEy+Kl9vPZhjpBb0zydL+n6+SaOlGqQfky7NqK
         SzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=wWtu2dMp8UhwRbU3BwxSI2ynqCJj/uyJ/bC0hrHmYd4=;
        b=Zj4cLLKrKCRSFj8CqtI7xylexjy3bV40kzM8zsFCCAjKdy4ThnwamqIDJyGEAgT55z
         LyatHSIOkHtS8QgVEPmfcygtdOYd91psxjHiz0xFxlVCkJVR/rbyrHw+/O0dDaLL0ve+
         TGxGs8r6fXzKlc2LM4LZsUmRwr0QWXihOBagTtqRqDfPHpWQttoyeVf0Zctl4TjPCYNp
         ZWoabGtstlXRh9qhvBgRgXsQXmh325Jmmrc13L3KA9O1eHe8wZuQRdQNc/s/DWS+KS9S
         qWfFwIxQKUkzpZjquKO+J4R8DtQgAtADh2IBbGOgZc0J2bjbDLBjnyMFY0k+vuAiUGwf
         sx8Q==
X-Gm-Message-State: ABuFfogOMt0Vf/8npkUVY5DsVTzrEj8sWmHW9kX9aBRGPhjjxe4L7gE6
        w9lNQMRm5ITJJL+Vx4Lej+4=
X-Google-Smtp-Source: ACcGV63KlATn71/5w4Jx+FJEajc9HpYakzvYxor9tbQZwdhzTaQ1snvrILH6aX1cWyqoKFk0UUkxOQ==
X-Received: by 2002:a5d:5649:: with SMTP id j9-v6mr5540943wrw.41.1539361612168;
        Fri, 12 Oct 2018 09:26:52 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1736842wmd.9.2018.10.12.09.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 09:26:51 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 lora-next 3/5] net: lora: sx1301: convert to using regmap fields for bit ops
Date:   Fri, 12 Oct 2018 17:26:04 +0100
Message-Id: <1539361567-3602-4-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

We convert to using regmap fields to allow bit access to the registers
where regmap handles the read update write.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx1301.c | 234 +++++++++++++---------------------------------
 drivers/net/lora/sx1301.h |  46 +++++++++
 2 files changed, 110 insertions(+), 170 deletions(-)

diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 9c85fe7..339f8d9 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -24,27 +24,6 @@
 
 #include "sx1301.h"
 
-#define REG_PAGE_RESET_SOFT_RESET	BIT(7)
-
-#define REG_16_GLOBAL_EN		BIT(3)
-
-#define REG_17_CLK32M_EN		BIT(0)
-
-#define REG_0_105_FORCE_HOST_RADIO_CTRL		BIT(1)
-#define REG_0_105_FORCE_HOST_FE_CTRL		BIT(2)
-#define REG_0_105_FORCE_DEC_FILTER_GAIN		BIT(3)
-
-#define REG_0_MCU_RST_0			BIT(0)
-#define REG_0_MCU_RST_1			BIT(1)
-#define REG_0_MCU_SELECT_MUX_0		BIT(2)
-#define REG_0_MCU_SELECT_MUX_1		BIT(3)
-
-#define REG_2_43_RADIO_A_EN		BIT(0)
-#define REG_2_43_RADIO_B_EN		BIT(1)
-#define REG_2_43_RADIO_RST		BIT(2)
-
-#define REG_EMERGENCY_FORCE_HOST_CTRL	BIT(0)
-
 static const struct regmap_range_cfg sx1301_regmap_ranges[] = {
 	{
 		.name = "Pages",
@@ -74,9 +53,10 @@ static struct regmap_config sx1301_regmap_config = {
 	.max_register = SX1301_MAX_REGISTER,
 };
 
-static int sx1301_soft_reset(struct sx1301_priv *priv)
+static int sx1301_field_write(struct sx1301_priv *priv,
+		enum sx1301_fields field_id, u8 val)
 {
-	return regmap_write(priv->regmap, SX1301_PAGE, REG_PAGE_RESET_SOFT_RESET);
+	return regmap_field_write(priv->regmap_fields[field_id], val);
 }
 
 static int sx1301_agc_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *val)
@@ -120,7 +100,7 @@ static int sx1301_arb_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *
 static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct firmware *fw)
 {
 	u8 *buf;
-	u8 rst, select_mux;
+	enum sx1301_fields rst, select_mux;
 	unsigned int val;
 	int ret;
 
@@ -131,29 +111,26 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct
 
 	switch (mcu) {
 	case 0:
-		rst = REG_0_MCU_RST_0;
-		select_mux = REG_0_MCU_SELECT_MUX_0;
+		rst = F_MCU_RST_0;
+		select_mux = F_MCU_SELECT_MUX_0;
 		break;
 	case 1:
-		rst = REG_0_MCU_RST_1;
-		select_mux = REG_0_MCU_SELECT_MUX_1;
+		rst = F_MCU_RST_1;
+		select_mux = F_MCU_SELECT_MUX_1;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_MCU_CTRL, &val);
+	ret = sx1301_field_write(priv, rst, 1);
 	if (ret) {
-		dev_err(priv->dev, "MCU read failed\n");
+		dev_err(priv->dev, "MCU reset failed\n");
 		return ret;
 	}
 
-	val |= rst;
-	val &= ~select_mux;
-
-	ret = regmap_write(priv->regmap, SX1301_MCU_CTRL, val);
+	ret = sx1301_field_write(priv, select_mux, 0);
 	if (ret) {
-		dev_err(priv->dev, "MCU reset / select mux write failed\n");
+		dev_err(priv->dev, "MCU RAM select mux failed\n");
 		return ret;
 	}
 
@@ -194,17 +171,9 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct
 
 	kfree(buf);
 
-	ret = regmap_read(priv->regmap, SX1301_MCU_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "MCU read (1) failed\n");
-		return ret;
-	}
-
-	val |= select_mux;
-
-	ret = regmap_write(priv->regmap, SX1301_MCU_CTRL, val);
+	ret = sx1301_field_write(priv, select_mux, 1);
 	if (ret) {
-		dev_err(priv->dev, "MCU reset / select mux write (1) failed\n");
+		dev_err(priv->dev, "MCU RAM release mux failed\n");
 		return ret;
 	}
 
@@ -230,17 +199,9 @@ static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_FORCE_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "0|105 read failed\n");
-		return ret;
-	}
-
-	val &= ~REG_0_105_FORCE_HOST_RADIO_CTRL;
-
-	ret = regmap_write(priv->regmap, SX1301_FORCE_CTRL, val);
+	ret = sx1301_field_write(priv, F_FORCE_HOST_RADIO_CTRL, 0);
 	if (ret) {
-		dev_err(priv->dev, "0|105 write failed\n");
+		dev_err(priv->dev, "force host control failed\n");
 		return ret;
 	}
 
@@ -254,17 +215,9 @@ static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_MCU_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "MCU read (0) failed\n");
-		return ret;
-	}
-
-	val &= ~REG_0_MCU_RST_1;
-
-	ret = regmap_write(priv->regmap, SX1301_MCU_CTRL, val);
+	ret = sx1301_field_write(priv, F_MCU_RST_1, 0);
 	if (ret) {
-		dev_err(priv->dev, "MCU write (0) failed\n");
+		dev_err(priv->dev, "MCU 1 reset failed\n");
 		return ret;
 	}
 
@@ -282,34 +235,18 @@ static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 		return -ENXIO;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_EMERGENCY_FORCE_HOST_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "emergency force read failed\n");
-		return ret;
-	}
-
-	val &= ~REG_EMERGENCY_FORCE_HOST_CTRL;
-
-	ret = regmap_write(priv->regmap, SX1301_EMERGENCY_FORCE_HOST_CTRL, val);
+	ret = sx1301_field_write(priv, F_EMERGENCY_FORCE_HOST_CTRL, 0);
 	if (ret) {
-		dev_err(priv->dev, "emergency force write failed\n");
+		dev_err(priv->dev, "emergency force failed\n");
 		return ret;
 	}
 
 	dev_err(priv->dev, "starting calibration...\n");
 	msleep(2300);
 
-	ret = regmap_read(priv->regmap, SX1301_EMERGENCY_FORCE_HOST_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "emergency force read (1) failed\n");
-		return ret;
-	}
-
-	val |= REG_EMERGENCY_FORCE_HOST_CTRL;
-
-	ret = regmap_write(priv->regmap, SX1301_EMERGENCY_FORCE_HOST_CTRL, val);
+	ret = sx1301_field_write(priv, F_EMERGENCY_FORCE_HOST_CTRL, 1);
 	if (ret) {
-		dev_err(priv->dev, "emergency force write (1) failed\n");
+		dev_err(priv->dev, "emergency force release failed\n");
 		return ret;
 	}
 
@@ -356,19 +293,15 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(priv->regmap, SX1301_FORCE_CTRL, &val);
-	if (ret) {
-		dev_err(priv->dev, "0|105 read failed\n");
+	ret = sx1301_field_write(priv, F_FORCE_HOST_RADIO_CTRL, 0);
+	if (ret)
 		return ret;
-	}
-
-	val &= ~(REG_0_105_FORCE_HOST_RADIO_CTRL | REG_0_105_FORCE_HOST_FE_CTRL | REG_0_105_FORCE_DEC_FILTER_GAIN);
-
-	ret = regmap_write(priv->regmap, SX1301_FORCE_CTRL, val);
-	if (ret) {
-		dev_err(priv->dev, "0|105 write failed\n");
+	ret = sx1301_field_write(priv, F_FORCE_HOST_FE_CTRL, 0);
+	if (ret)
+		return ret;
+	ret = sx1301_field_write(priv, F_FORCE_DEC_FILTER_GAIN, 0);
+	if (ret)
 		return ret;
-	}
 
 	ret = regmap_write(priv->regmap, SX1301_CHRS, 0);
 	if (ret) {
@@ -376,17 +309,15 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_MCU_CTRL, &val);
+	ret = sx1301_field_write(priv, F_MCU_RST_0, 0);
 	if (ret) {
-		dev_err(priv->dev, "MCU read (0) failed\n");
+		dev_err(priv->dev, "MCU 0 release failed\n");
 		return ret;
 	}
 
-	val &= ~(REG_0_MCU_RST_1 | REG_0_MCU_RST_0);
-
-	ret = regmap_write(priv->regmap, SX1301_MCU_CTRL, val);
+	ret = sx1301_field_write(priv, F_MCU_RST_1, 0);
 	if (ret) {
-		dev_err(priv->dev, "MCU write (0) failed\n");
+		dev_err(priv->dev, "MCU 1 release failed\n");
 		return ret;
 	}
 
@@ -438,7 +369,6 @@ static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_dev
 static int sx130x_loradev_open(struct net_device *netdev)
 {
 	struct sx1301_priv *priv = netdev_priv(netdev);
-	unsigned int val;
 	int ret;
 
 	netdev_dbg(netdev, "%s", __func__);
@@ -448,31 +378,15 @@ static int sx130x_loradev_open(struct net_device *netdev)
 		return -ENXIO;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_GEN, &val);
-	if (ret) {
-		netdev_err(netdev, "16 read (1) failed\n");
-		return ret;
-	}
-
-	val |= REG_16_GLOBAL_EN;
-
-	ret = regmap_write(priv->regmap, SX1301_GEN, val);
-	if (ret) {
-		netdev_err(netdev, "16 write (1) failed\n");
-		return ret;
-	}
-
-	ret = regmap_read(priv->regmap, SX1301_CKEN, &val);
+	ret = sx1301_field_write(priv, F_GLOBAL_EN, 1);
 	if (ret) {
-		netdev_err(netdev, "17 read (1) failed\n");
+		dev_err(priv->dev, "enable global clocks failed\n");
 		return ret;
 	}
 
-	val |= REG_17_CLK32M_EN;
-
-	ret = regmap_write(priv->regmap, SX1301_CKEN, val);
+	ret = sx1301_field_write(priv, F_CLK32M_EN, 1);
 	if (ret) {
-		netdev_err(netdev, "17 write (1) failed\n");
+		dev_err(priv->dev, "enable 32M clock failed\n");
 		return ret;
 	}
 
@@ -519,6 +433,7 @@ static int sx1301_probe(struct spi_device *spi)
 	struct sx1301_priv *priv;
 	struct gpio_desc *rst;
 	int ret;
+	int i;
 	unsigned int ver;
 	unsigned int val;
 
@@ -557,6 +472,19 @@ static int sx1301_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(sx1301_regmap_fields); i++) {
+		const struct reg_field *reg_fields = sx1301_regmap_fields;
+
+		priv->regmap_fields[i] = devm_regmap_field_alloc(&spi->dev,
+				priv->regmap,
+				reg_fields[i]);
+		if (IS_ERR(priv->regmap_fields[i])) {
+			ret = PTR_ERR(priv->regmap_fields[i]);
+			dev_err(&spi->dev, "Cannot allocate regmap field: %d\n", ret);
+			return ret;
+		}
+	}
+
 	ret = regmap_read(priv->regmap, SX1301_VER, &ver);
 	if (ret) {
 		dev_err(&spi->dev, "version read failed\n");
@@ -574,83 +502,49 @@ static int sx1301_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = sx1301_soft_reset(priv);
+	ret = sx1301_field_write(priv, F_SOFT_RESET, 1);
 	if (ret) {
 		dev_err(&spi->dev, "soft reset failed\n");
 		return ret;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_GEN, &val);
+	ret = sx1301_field_write(priv, F_GLOBAL_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "16 read failed\n");
+		dev_err(&spi->dev, "gate global clocks failed\n");
 		return ret;
 	}
 
-	val &= ~REG_16_GLOBAL_EN;
-
-	ret = regmap_write(priv->regmap, SX1301_GEN, val);
+	ret = sx1301_field_write(priv, F_CLK32M_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "16 write failed\n");
+		dev_err(&spi->dev, "gate 32M clock failed\n");
 		return ret;
 	}
 
-	ret = regmap_read(priv->regmap, SX1301_CKEN, &val);
+	ret = sx1301_field_write(priv, F_RADIO_A_EN, 1);
 	if (ret) {
-		dev_err(&spi->dev, "17 read failed\n");
+		dev_err(&spi->dev, "radio a enable failed\n");
 		return ret;
 	}
 
-	val &= ~REG_17_CLK32M_EN;
-
-	ret = regmap_write(priv->regmap, SX1301_CKEN, val);
+	ret = sx1301_field_write(priv, F_RADIO_B_EN, 1);
 	if (ret) {
-		dev_err(&spi->dev, "17 write failed\n");
-		return ret;
-	}
-
-	ret = regmap_read(priv->regmap, SX1301_RADIO_CFG, &val);
-	if (ret) {
-		dev_err(&spi->dev, "2|43 read failed\n");
-		return ret;
-	}
-
-	val |= REG_2_43_RADIO_B_EN | REG_2_43_RADIO_A_EN;
-
-	ret = regmap_write(priv->regmap, SX1301_RADIO_CFG, val);
-	if (ret) {
-		dev_err(&spi->dev, "2|43 write failed\n");
+		dev_err(&spi->dev, "radio b enable failed\n");
 		return ret;
 	}
 
 	msleep(500);
 
-	ret = regmap_read(priv->regmap, SX1301_RADIO_CFG, &val);
+	ret = sx1301_field_write(priv, F_RADIO_RST, 1);
 	if (ret) {
-		dev_err(&spi->dev, "2|43 read failed\n");
-		return ret;
-	}
-
-	val |= REG_2_43_RADIO_RST;
-
-	ret = regmap_write(priv->regmap, SX1301_RADIO_CFG, val);
-	if (ret) {
-		dev_err(&spi->dev, "2|43 write failed\n");
+		dev_err(&spi->dev, "radio asert reset failed\n");
 		return ret;
 	}
 
 	msleep(5);
 
-	ret = regmap_read(priv->regmap, SX1301_RADIO_CFG, &val);
-	if (ret) {
-		dev_err(&spi->dev, "2|43 read failed\n");
-		return ret;
-	}
-
-	val &= ~REG_2_43_RADIO_RST;
-
-	ret = regmap_write(priv->regmap, SX1301_RADIO_CFG, val);
+	ret = sx1301_field_write(priv, F_RADIO_RST, 0);
 	if (ret) {
-		dev_err(&spi->dev, "2|43 write failed\n");
+		dev_err(&spi->dev, "radio deasert reset failed\n");
 		return ret;
 	}
 
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index e6400f8..0bbd948 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -60,11 +60,57 @@
 
 #define SX1301_MAX_REGISTER         (SX1301_PAGE_BASE(3) + 0x7F)
 
+enum sx1301_fields {
+	F_SOFT_RESET,
+	F_GLOBAL_EN,
+	F_CLK32M_EN,
+	F_RADIO_A_EN,
+	F_RADIO_B_EN,
+	F_RADIO_RST,
+
+	F_MCU_RST_0,
+	F_MCU_RST_1,
+	F_MCU_SELECT_MUX_0,
+	F_MCU_SELECT_MUX_1,
+
+	F_FORCE_HOST_RADIO_CTRL,
+	F_FORCE_HOST_FE_CTRL,
+	F_FORCE_DEC_FILTER_GAIN,
+
+	F_EMERGENCY_FORCE_HOST_CTRL,
+};
+
+static const struct reg_field sx1301_regmap_fields[] = {
+	/* PAGE */
+	[F_SOFT_RESET]          = REG_FIELD(SX1301_PAGE, 7, 7),
+	/* GEN */
+	[F_GLOBAL_EN]           = REG_FIELD(SX1301_GEN,  3, 3),
+	/* CKEN */
+	[F_CLK32M_EN]           = REG_FIELD(SX1301_CKEN, 0, 0),
+	/* RADIO_CFG */
+	[F_RADIO_A_EN]          = REG_FIELD(SX1301_RADIO_CFG, 0, 0),
+	[F_RADIO_B_EN]          = REG_FIELD(SX1301_RADIO_CFG, 1, 1),
+	[F_RADIO_RST]           = REG_FIELD(SX1301_RADIO_CFG, 2, 2),
+	/* MCU_CTRL */
+	[F_MCU_RST_0]           = REG_FIELD(SX1301_MCU_CTRL, 0, 0),
+	[F_MCU_RST_1]           = REG_FIELD(SX1301_MCU_CTRL, 1, 1),
+	[F_MCU_SELECT_MUX_0]    = REG_FIELD(SX1301_MCU_CTRL, 2, 2),
+	[F_MCU_SELECT_MUX_1]    = REG_FIELD(SX1301_MCU_CTRL, 3, 3),
+	/* FORCE_CTRL */
+	[F_FORCE_HOST_RADIO_CTRL] = REG_FIELD(SX1301_FORCE_CTRL, 1, 1),
+	[F_FORCE_HOST_FE_CTRL]    = REG_FIELD(SX1301_FORCE_CTRL, 2, 2),
+	[F_FORCE_DEC_FILTER_GAIN] = REG_FIELD(SX1301_FORCE_CTRL, 3, 3),
+	/* EMERGENCY_FORCE_HOST_CTRL */
+	[F_EMERGENCY_FORCE_HOST_CTRL] =
+		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
+};
+
 struct sx1301_priv {
 	struct lora_dev_priv lora;
 	struct device		*dev;
 	struct gpio_desc *rst_gpio;
 	struct regmap		*regmap;
+	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
 };
 
 int __init sx130x_radio_init(void);
-- 
2.7.4

