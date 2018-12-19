Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA6218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd/5I+wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeLSP4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37166 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeLSP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so19609785wrt.4;
        Wed, 19 Dec 2018 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i25TBhQL7o6CHJnnqUQpts9IplaeJoYk7okEUv8SLCY=;
        b=cd/5I+wvqr4dRJG8VPC/swkl7I15HMcU7aC7EHf51CGe6xhnShdzhGUCp7d3vxDjJK
         AEpnk8ff7bElUFzsO0z4sQhWHCcxdWUnC/DwfWqkx1ZvP3/Sx5SRVi0oqNUXg7+8Ffae
         3itgb8oOqv3qAPSUU0U4BG5lun+hwaITnhTx4OxHlGwBUxO11bEnbDTgGj5kq/O6PJZg
         389Ljn8JTCWhQ+mOpyj7IJoESv5ZBeqIDGcAB6+yfsGHjuKl49yXx8OObnWolzI3XjAm
         l0sr9W4NHhG6WUSCoWLaASjblV2zMMcSaNNxhw4LejCYJEOIsPyc8Z+5euEfD2ivs4CM
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=i25TBhQL7o6CHJnnqUQpts9IplaeJoYk7okEUv8SLCY=;
        b=FuxIYVykxn8D6gB/xCmSs7bEOyZ4e/TCgKuIV+bLnVy68QaZjm2TiCmUys7TVAtFSO
         nNm7AQhPKcLtJPAu+JtEXbJLo7/NUXGsnouIMCGb8bGn/Kryz1vWXa2uVaoqqdsFaF2a
         H5VFswFVJnVIhgCbLAVtih4Mu3IX33GZVUQQrW7KIpL6BcO01BvvDug5QpffKrFHS6qD
         lf+c/Usqn8UMwBlvGHf9wzejHDeDyKVa00h18JWua3n2J4dF4c0OOPYQOvILWMVF+Wk7
         DCwt2og4FNuTBUCOqR0Vc/xK2HjtCBsyEtXzgPH404/wXmxPWiZHEC2rhl54uKnL1fMJ
         mWyA==
X-Gm-Message-State: AA+aEWYgLVU3CFQnqzMoydg8KTtJ6tlaBzPCAcuzonC2XKlYDY4d5kPS
        BzkJwJkWjj4c4f82twGZg94=
X-Google-Smtp-Source: AFSGD/XJldM8wQzQKmgztzLgvYW6XD6F6f9rBcFdXRm/4FebNLhJ0nN7qoNCfqSk2sluqmiPwI2/mQ==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr19569977wrv.88.1545234986687;
        Wed, 19 Dec 2018 07:56:26 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id c9sm6836099wmh.27.2018.12.19.07.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:56:25 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     starnight@g.ncu.edu.tw, jiri@resnulli.us, afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC lora-next 1/4] net: lora: sx125x sx1301: correct style warnings
Date:   Wed, 19 Dec 2018 15:56:13 +0000
Message-Id: <20181219155616.9547-2-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155616.9547-1-ben.whitten@lairdtech.com>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch highlights some style issues which need to be addressed.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx125x.c | 20 +++++++++------
 drivers/net/lora/sx1301.c | 52 ++++++++++++++++++++++-----------------
 drivers/net/lora/sx1301.h |  7 +++---
 3 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index b7ca782b9386..1a941f663c52 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -49,7 +49,7 @@ struct sx125x_priv {
 
 	struct device		*dev;
 	struct regmap		*regmap;
-	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
+	struct regmap_field *regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
 };
 
 #define to_clkout(_hw) container_of(_hw, struct sx125x_priv, clkout_hw)
@@ -67,13 +67,13 @@ static struct regmap_config __maybe_unused sx125x_regmap_config = {
 };
 
 static int sx125x_field_write(struct sx125x_priv *priv,
-		enum sx125x_fields field_id, u8 val)
+			      enum sx125x_fields field_id, u8 val)
 {
 	return regmap_field_write(priv->regmap_fields[field_id], val);
 }
 
 static int sx125x_field_read(struct sx125x_priv *priv,
-		enum sx125x_fields field_id, unsigned int *val)
+			     enum sx125x_fields field_id, unsigned int *val)
 {
 	return regmap_field_read(priv->regmap_fields[field_id], val);
 }
@@ -149,8 +149,12 @@ static int sx125x_register_clock_provider(struct sx125x_priv *priv)
 	init.num_parents = 1;
 	priv->clkout_hw.init = &init;
 
-	of_property_read_string_index(dev->of_node, "clock-output-names", 0,
-			&init.name);
+	ret = of_property_read_string_index(dev->of_node, "clock-output-names",
+					    0, &init.name);
+	if (ret) {
+		dev_err(dev, "unable to find output name\n");
+		return ret;
+	}
 
 	priv->clkout = devm_clk_register(dev, &priv->clkout_hw);
 	if (IS_ERR(priv->clkout)) {
@@ -158,7 +162,7 @@ static int sx125x_register_clock_provider(struct sx125x_priv *priv)
 		return PTR_ERR(priv->clkout);
 	}
 	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
-			&priv->clkout_hw);
+				     &priv->clkout_hw);
 	return ret;
 }
 
@@ -180,8 +184,8 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 		const struct reg_field *reg_fields = sx125x_regmap_fields;
 
 		priv->regmap_fields[i] = devm_regmap_field_alloc(dev,
-				priv->regmap,
-				reg_fields[i]);
+								 priv->regmap,
+								 reg_fields[i]);
 		if (IS_ERR(priv->regmap_fields[i])) {
 			ret = PTR_ERR(priv->regmap_fields[i]);
 			dev_err(dev, "Cannot allocate regmap field: %d\n", ret);
diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 23cbddc364e5..e75df93b96d8 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Semtech SX1301 LoRa concentrator
+/* Semtech SX1301 LoRa concentrator
  *
  * Copyright (c) 2018 Andreas Färber
  * Copyright (c) 2018 Ben Whitten
@@ -55,12 +54,13 @@ static struct regmap_config sx1301_regmap_config = {
 };
 
 static int sx1301_field_write(struct sx1301_priv *priv,
-		enum sx1301_fields field_id, u8 val)
+			      enum sx1301_fields field_id, u8 val)
 {
 	return regmap_field_write(priv->regmap_fields[field_id], val);
 }
 
-static int sx1301_agc_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *val)
+static int sx1301_agc_ram_read(struct sx1301_priv *priv, u8 addr,
+			       unsigned int *val)
 {
 	int ret;
 
@@ -79,7 +79,8 @@ static int sx1301_agc_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *
 	return 0;
 }
 
-static int sx1301_arb_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *val)
+static int sx1301_arb_ram_read(struct sx1301_priv *priv, u8 addr,
+			       unsigned int *val)
 {
 	int ret;
 
@@ -98,7 +99,8 @@ static int sx1301_arb_ram_read(struct sx1301_priv *priv, u8 addr, unsigned int *
 	return 0;
 }
 
-static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct firmware *fw)
+static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu,
+				const struct firmware *fw)
 {
 	u8 *buf;
 	enum sx1301_fields rst, select_mux;
@@ -165,7 +167,8 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu, const struct
 	}
 
 	if (memcmp(fw->data, buf, fw->size)) {
-		dev_err(priv->dev, "MCU prom data read does not match data written\n");
+		dev_err(priv->dev,
+			"MCU prom data read does not match data written\n");
 		kfree(buf);
 		return -ENXIO;
 	}
@@ -228,11 +231,12 @@ static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	dev_info(priv->dev, "AGC calibration firmware version %u\n", (unsigned)val);
+	dev_info(priv->dev, "AGC calibration firmware version %u\n", val);
 
 	if (val != SX1301_MCU_AGC_CAL_FW_VERSION) {
-		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
-				SX1301_MCU_AGC_CAL_FW_VERSION);
+		dev_err(priv->dev,
+			"unexpected firmware version, expecting %u\n",
+			SX1301_MCU_AGC_CAL_FW_VERSION);
 		return -ENXIO;
 	}
 
@@ -257,7 +261,7 @@ static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	dev_info(priv->dev, "AGC status: %02x\n", (unsigned)val);
+	dev_info(priv->dev, "AGC status: %02x\n", val);
 	if ((val & (BIT(7) | BIT(0))) != (BIT(7) | BIT(0))) {
 		dev_err(priv->dev, "AGC calibration failed\n");
 		return -ENXIO;
@@ -328,11 +332,12 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	dev_info(priv->dev, "AGC firmware version %u\n", (unsigned)val);
+	dev_info(priv->dev, "AGC firmware version %u\n", val);
 
 	if (val != SX1301_MCU_AGC_FW_VERSION) {
-		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
-				SX1301_MCU_AGC_FW_VERSION);
+		dev_err(priv->dev,
+			"unexpected firmware version, expecting %u\n",
+			SX1301_MCU_AGC_FW_VERSION);
 		return -ENXIO;
 	}
 
@@ -342,18 +347,20 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
 		return ret;
 	}
 
-	dev_info(priv->dev, "ARB firmware version %u\n", (unsigned)val);
+	dev_info(priv->dev, "ARB firmware version %u\n", val);
 
 	if (val != SX1301_MCU_ARB_FW_VERSION) {
-		dev_err(priv->dev, "unexpected firmware version, expecting %u\n",
-				SX1301_MCU_ARB_FW_VERSION);
+		dev_err(priv->dev,
+			"unexpected firmware version, expecting %u\n",
+			SX1301_MCU_ARB_FW_VERSION);
 		return -ENXIO;
 	}
 
 	return 0;
 }
 
-static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
+					     struct net_device *netdev)
 {
 	if (skb->protocol != htons(ETH_P_LORA)) {
 		kfree_skb(skb);
@@ -489,11 +496,12 @@ static int sx1301_probe(struct spi_device *spi)
 		const struct reg_field *reg_fields = sx1301_regmap_fields;
 
 		priv->regmap_fields[i] = devm_regmap_field_alloc(&spi->dev,
-				priv->regmap,
-				reg_fields[i]);
+								 priv->regmap,
+								 reg_fields[i]);
 		if (IS_ERR(priv->regmap_fields[i])) {
 			ret = PTR_ERR(priv->regmap_fields[i]);
-			dev_err(&spi->dev, "Cannot allocate regmap field: %d\n", ret);
+			dev_err(&spi->dev,
+				"Cannot allocate regmap field: %d\n", ret);
 			return ret;
 		}
 	}
@@ -553,7 +561,7 @@ static int sx1301_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	msleep(5);
+	usleep_range(5000, 6000);
 
 	ret = sx1301_field_write(priv, F_RADIO_RST, 0);
 	if (ret) {
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index a1a2e388207e..dd2b7da94fcc 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Semtech SX1301 LoRa concentrator
+/* Semtech SX1301 LoRa concentrator
  *
  * Copyright (c) 2018   Ben Whitten
  * Copyright (c) 2018 Andreas Färber
@@ -34,7 +33,7 @@
 
 #define SX1301_VIRT_BASE    0x100
 #define SX1301_PAGE_LEN     0x80
-#define SX1301_PAGE_BASE(n) (SX1301_VIRT_BASE + (SX1301_PAGE_LEN * n))
+#define SX1301_PAGE_BASE(n) (SX1301_VIRT_BASE + (SX1301_PAGE_LEN * (n)))
 
 /* Page 0 */
 #define SX1301_CHRS         (SX1301_PAGE_BASE(0) + 0x23)
@@ -112,7 +111,7 @@ struct sx1301_priv {
 	struct clk		*clk32m;
 	struct gpio_desc *rst_gpio;
 	struct regmap		*regmap;
-	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
+	struct regmap_field *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
 };
 
 int __init sx130x_radio_init(void);
-- 
2.17.1

