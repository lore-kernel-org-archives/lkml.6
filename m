Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073FE2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbxHH+Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeLSP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:56:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52416 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbeLSP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:56:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so6581884wml.2;
        Wed, 19 Dec 2018 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIMy8SmxnypKM4KjCpJRLf3oGe6ywU5lLEfE6JwZlBc=;
        b=NbxHH+Xm7V1QSsyhxEB1bZcoE4jO9rnk0VFdCA2QUnRBp02yvDbZk1rjBO3HqEzy8b
         47yb6MgO71DCiyjWPcmfDK/C8yxb1nXUyxu9Gez+RX9L4ZF2AWvZqO5KtjauMzed+rtV
         j+nIytfcJxnyGQRDRdh9zGTcIceoi8+VBnivp638QwkwtmoJZvKYdGo/XGOIgVwJuSFO
         gp8QttOVJYQijTfT4KzuTKUmW8xuFQi6JoQWBucUT/ZiuJTvmFSkMunP4v1kFYenhwPs
         rDXTbcPIhZAYUmH0z2TCFxqoZOJXuBlzMItRYOD0NYawLBycq8KHnz1/mSrHRMzG9LwV
         zOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vIMy8SmxnypKM4KjCpJRLf3oGe6ywU5lLEfE6JwZlBc=;
        b=CLRR73YXuTMHD8/LYelSpmTj+wCVJ8tnHjULgHpDHhE6tyOwyGOJwN/wVKbRExol8E
         r/jJ3tqH1Lta+3OVdZ9vwL+Xryntfe2kVWUROvr0zKhpdo0KMlMHq/2x1z7BYSBUC4BS
         Ci94NbXx7+E1JcYBvhE+1zZAspO8QIMljPhHIMTashxWirWH2Jl2R6KOyAVSB0ha4pCv
         CtsXLMPTwn7xplgm69QMPbNDZV4jMbCOzGCv6z2lguZcKelcVKxj2hVKIBMjxjQASA9z
         qffddz5TBu3rLvERX7fYpyRaL3DHhb7IrP4BHKNzhENO5LIqdOVXArPWlYY1hWIqQsGW
         w7Ow==
X-Gm-Message-State: AA+aEWYLYMSdz+OAaloUPHJS0VDXhoZZLO9mHmfLwJTHkP/Eqr6o0QpM
        uTydpeW4roRGNaWVR3IAzhE=
X-Google-Smtp-Source: AFSGD/U6gV73ESm8MAGXew/owddgAXUJniFZuKbNkMY4kjqx0/jASl6pv/XqGXyX2PUIYU1MF70j5Q==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr8086373wmj.105.1545234988002;
        Wed, 19 Dec 2018 07:56:28 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id c9sm6836099wmh.27.2018.12.19.07.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:56:27 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     starnight@g.ncu.edu.tw, jiri@resnulli.us, afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC lora-next 2/4] net: lora: sx1301: add minimal to get AGC working prior to tx work
Date:   Wed, 19 Dec 2018 15:56:14 +0000
Message-Id: <20181219155616.9547-3-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155616.9547-1-ben.whitten@lairdtech.com>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of initialisation when opening the lora device after loading
the AGC firmware we need to satisfy its startup procedure which involves
a few steps;

Loading a 16 entry lookup table.
For this I have hard coded the laird ETSI certified table for use on the
RG186-M2 (EU) cards, this will need investigation on how other devices
load calibration data.

Selecting the correct channel to transmit on.
Currently always 0 for the reference design.

Then ending the AGC init procedure and seeing that it has come up.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 drivers/net/lora/sx1301.c | 254 +++++++++++++++++++++++++++++++++++++-
 drivers/net/lora/sx1301.h |  16 +++
 2 files changed, 268 insertions(+), 2 deletions(-)

diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index e75df93b96d8..0c7b6d0b31af 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -24,6 +24,121 @@
 
 #include "sx1301.h"
 
+static struct sx1301_tx_gain_lut tx_gain_lut[] = {
+	{
+		.dig_gain = 0,
+		.pa_gain = 0,
+		.dac_gain = 3,
+		.mix_gain = 8,
+		.rf_power = -3,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 0,
+		.dac_gain = 3,
+		.mix_gain = 9,
+		.rf_power = 0,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 0,
+		.dac_gain = 3,
+		.mix_gain = 12,
+		.rf_power = 3,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 0,
+		.dac_gain = 3,
+		.mix_gain = 13,
+		.rf_power = 4,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 8,
+		.rf_power = 6,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 9,
+		.rf_power = 9,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 10,
+		.rf_power = 10,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 11,
+		.rf_power = 12,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 12,
+		.rf_power = 13,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 13,
+		.rf_power = 14,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 1,
+		.dac_gain = 3,
+		.mix_gain = 15,
+		.rf_power = 16,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 2,
+		.dac_gain = 3,
+		.mix_gain = 10,
+		.rf_power = 19,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 2,
+		.dac_gain = 3,
+		.mix_gain = 11,
+		.rf_power = 21,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 2,
+		.dac_gain = 3,
+		.mix_gain = 12,
+		.rf_power = 22,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 2,
+		.dac_gain = 3,
+		.mix_gain = 13,
+		.rf_power = 24,
+	},
+	{
+		.dig_gain = 0,
+		.pa_gain = 2,
+		.dac_gain = 3,
+		.mix_gain = 14,
+		.rf_power = 25,
+	},
+};
+
 static const struct regmap_range_cfg sx1301_regmap_ranges[] = {
 	{
 		.name = "Pages",
@@ -184,6 +299,34 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu,
 	return 0;
 }
 
+static int sx1301_agc_transaction(struct sx1301_priv *priv, unsigned int val,
+				  unsigned int *status)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, SX1301_CHRS, SX1301_AGC_CMD_WAIT);
+	if (ret) {
+		dev_err(priv->dev, "AGC transaction start failed\n");
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	ret = regmap_write(priv->regmap, SX1301_CHRS, val);
+	if (ret) {
+		dev_err(priv->dev, "AGC transaction value failed\n");
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	ret = regmap_read(priv->regmap, SX1301_AGCSTS, status);
+	if (ret) {
+		dev_err(priv->dev, "AGC status read failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int sx1301_agc_calibrate(struct sx1301_priv *priv)
 {
 	const struct firmware *fw;
@@ -356,9 +499,53 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
 		return -ENXIO;
 	}
 
-	return 0;
+	return ret;
 }
 
+static int sx1301_load_tx_gain_lut(struct sx1301_priv *priv)
+{
+	struct sx1301_tx_gain_lut *lut = priv->tx_gain_lut;
+	unsigned int val, status;
+	int ret, i;
+
+	/* HACK use internal gain table in the short term */
+	lut = tx_gain_lut;
+	priv->tx_gain_lut_size = ARRAY_SIZE(tx_gain_lut);
+
+	for (i = 0; i < priv->tx_gain_lut_size; i++) {
+		val = lut->mix_gain + (lut->dac_gain << 4) +
+			(lut->pa_gain << 6);
+
+		ret = sx1301_agc_transaction(priv, val, &status);
+		if (ret) {
+			dev_err(priv->dev, "AGC LUT load failed\n");
+			return ret;
+		}
+		if (status != (0x30 + i)) {
+			dev_err(priv->dev,
+				"AGC firmware LUT init error: 0x%02X\n", val);
+			return -ENXIO;
+		}
+		lut++;
+	}
+
+	/* Abort the transaction if there are less then 16 entries */
+	if (priv->tx_gain_lut_size < SX1301_TX_GAIN_LUT_MAX) {
+		ret = sx1301_agc_transaction(priv, SX1301_AGC_CMD_ABORT, &val);
+		if (ret) {
+			dev_err(priv->dev, "AGC LUT abort failed\n");
+			return ret;
+		}
+		if (val != 0x30) {
+			dev_err(priv->dev,
+				"AGC firmware LUT abort error: 0x%02X\n", val);
+			return -ENXIO;
+		}
+	}
+
+	return ret;
+};
+
 static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
 					     struct net_device *netdev)
 {
@@ -378,6 +565,7 @@ static int sx130x_loradev_open(struct net_device *netdev)
 {
 	struct sx1301_priv *priv = netdev_priv(netdev);
 	int ret;
+	unsigned int val;
 
 	netdev_dbg(netdev, "%s", __func__);
 
@@ -416,12 +604,74 @@ static int sx130x_loradev_open(struct net_device *netdev)
 	if (ret)
 		return ret;
 
-	/* TODO */
+	/* TODO Load constant adjustments, patches */
+
+	/* TODO Frequency time drift */
+
+	/* TODO Configure lora multi demods, bitfield of active */
+
+	/* TODO Load concenrator multi channel frequencies */
+
+	/* TODO enale to correlator on enabled frequenies */
+
+	/* TODO PPMi, and modem enable */
 
 	ret = sx1301_load_all_firmware(priv);
 	if (ret)
 		return ret;
 
+	usleep_range(1000, 2000);
+
+	ret = regmap_read(priv->regmap, SX1301_AGCSTS, &val);
+	if (ret) {
+		dev_err(priv->dev, "AGC status read failed\n");
+		return ret;
+	}
+	if (val != 0x10) {
+		dev_err(priv->dev, "AGC firmware init failure: 0x%02X\n", val);
+		return -ENXIO;
+	}
+
+	ret = sx1301_load_tx_gain_lut(priv);
+	if (ret)
+		return ret;
+
+	/* Load Tx freq MSBs
+	 * Always 3 if f > 768 for SX1257 or f > 384 for SX1255
+	 */
+	ret = sx1301_agc_transaction(priv, 3, &val);
+	if (ret) {
+		dev_err(priv->dev, "AGC Tx MSBs load failed\n");
+		return ret;
+	}
+	if (val != 0x33) {
+		dev_err(priv->dev, "AGC firmware Tx MSBs error: 0x%02X\n", val);
+		return -ENXIO;
+	}
+
+	/* Load chan_select firmware option */
+	ret = sx1301_agc_transaction(priv, 0, &val);
+	if (ret) {
+		dev_err(priv->dev, "AGC chan select failed\n");
+		return ret;
+	}
+	if (val != 0x30) {
+		dev_err(priv->dev,
+			"AGC firmware chan select error: 0x%02X", val);
+		return -ENXIO;
+	}
+
+	/* End AGC firmware init and check status */
+	ret = sx1301_agc_transaction(priv, 0, &val);
+	if (ret) {
+		dev_err(priv->dev, "AGC radio select failed\n");
+		return ret;
+	}
+	if (val != 0x40) {
+		dev_err(priv->dev, "AGC firmware init error: 0x%02X", val);
+		return -ENXIO;
+	}
+
 	ret = open_loradev(netdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index dd2b7da94fcc..04c9af64c181 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -20,6 +20,11 @@
 #define SX1301_MCU_AGC_FW_VERSION 4
 #define SX1301_MCU_AGC_CAL_FW_VERSION 2
 
+#define SX1301_AGC_CMD_WAIT 16
+#define SX1301_AGC_CMD_ABORT 17
+
+#define SX1301_TX_GAIN_LUT_MAX 16
+
 /* Page independent */
 #define SX1301_PAGE     0x00
 #define SX1301_VER      0x01
@@ -105,6 +110,14 @@ static const struct reg_field sx1301_regmap_fields[] = {
 		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
 };
 
+struct sx1301_tx_gain_lut {
+	unsigned int	dig_gain;
+	unsigned int	pa_gain;
+	unsigned int	dac_gain;
+	unsigned int	mix_gain;
+	int		rf_power; /* dBm measured at board connector */
+};
+
 struct sx1301_priv {
 	struct lora_dev_priv lora;
 	struct device		*dev;
@@ -112,6 +125,9 @@ struct sx1301_priv {
 	struct gpio_desc *rst_gpio;
 	struct regmap		*regmap;
 	struct regmap_field *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
+
+	struct sx1301_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
+	u8 tx_gain_lut_size;
 };
 
 int __init sx130x_radio_init(void);
-- 
2.17.1

