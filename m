Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C01C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B682148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Aw+hUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfA1QOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:14:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45682 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbfA1QNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so18654622wrr.12;
        Mon, 28 Jan 2019 08:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qitsf1i7oCTC9R2MN+j37S7wP/F6/6ncV7JvZFtiRs0=;
        b=S6Aw+hUOZLuh2alGmqkgc/KZ3j8Iij+2tYUSbQeu8EzCpnVrE6UFxP4+S1WdF4bi+t
         7xa4jV6LlJGti+0qQlzDsJe88HUCcCb2eMxZ9TWHeMwOOP8GN/VXH+FjGbuOCQq1k7JW
         s5YoWvuaAMFhrZOCna91FlgSltEUkWVtFCVSLx72H76ApO3QlubsxgsCu8euB2jyiMwt
         fGULyzPH/Rk4JqSAwbcx2VMasLAAKJsTpwavSoHE0fJZAAJJjb9oox7bRdohkXuB9OXQ
         aoZ+fq9oNhBJGOUwRFrqqrw84l7JPaPNMs1pmCpYsMNZI3i6/NA3CgKihd+P6bC6SNRO
         RgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qitsf1i7oCTC9R2MN+j37S7wP/F6/6ncV7JvZFtiRs0=;
        b=AAodz/oPOvx17JClHncp8wswHvihOd6oWvq/ebwby/f+dkiHl7wT/MMNeu38A8dwmY
         REvq47pPfC9cgyqZ06RIrEQxYdd4kJTYAVOhqEd1Hkz9xrEoWyXKB8x5+iHRpzb8QCxf
         lvCv9HFZnUhnom26g4qBMaSEinlztYADu1Bb+WQmSuPbjV2Akyi/eMDWhJ76jm0QhhrR
         JBpKdcxOltiwqnte+/wq1n2wptQ4Wcbz2AwPmM5y9rSYpmz53EUcfj+a3QWk6OHBGJTe
         Q1Qmnv0ywPJpO5HZ3BwDp84V64k2AyGemmpuDAhJ4EenJzcHu33hLxWVdkZ56uE17Ca6
         x0IA==
X-Gm-Message-State: AJcUukfYpNk6IF+XAVfxXZtL9JiT3ijNthMzk2U0KYPD+Au9u11EQmjs
        TARNilciuH/7pbTP/oD7Ay8=
X-Google-Smtp-Source: ALg8bN4pkUWDKjLT1mdZs6vD7FCNGq34AHvvCev201NtMwmoc7ynEWJDztO1JRXaR+jIDyZFNga7DQ==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr22154860wrg.183.1548692031264;
        Mon, 28 Jan 2019 08:13:51 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:50 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 05/11] net: lora: sx130x: initialise AGC
Date:   Mon, 28 Jan 2019 16:12:59 +0000
Message-Id: <20190128161306.27805-6-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

Initialisation of the AGC firmware requires a couple of steps to be
completed;
- Loading a TX LUT
- Loading the two MSBs for the radio tx synthesizer frequencies,
  (Always 3 if f > 768 for SX1257 and SX1258 or f > 384 for SX1255)
- Loading a firmware option
- Finish initialisation by writing intended value of the radio select
  register.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx130x.c | 110 ++++++++++++++++++++++++++++++++++++++
 drivers/net/lora/sx130x.h |   7 +++
 2 files changed, 117 insertions(+)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 818a1c9192b3..18acfc8e934d 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -537,6 +537,111 @@ static int sx130x_load_all_firmware(struct sx130x_priv *priv)
 	return 0;
 }
 
+static int sx130x_load_tx_gain_lut(struct sx130x_priv *priv)
+{
+	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	struct sx130x_tx_gain_lut *lut = priv->tx_gain_lut;
+	unsigned int status, val;
+	int ret, i;
+
+	for (i = 0; i < priv->tx_gain_lut_size; i++) {
+		val = lut->pa_gain << SX1301_PA_GAIN_OFFSET;
+		val |= lut->dac_gain << SX1301_DAC_GAIN_OFFSET;
+		val |= lut->mix_gain;
+
+		netdev_info(netdev, "AGC LUT entry %d dBm: 0x%02x\n", lut->power, val);
+		ret = sx130x_agc_transaction(priv, val, &status);
+		if (ret) {
+			netdev_err(netdev, "AGC LUT load failed\n");
+			return ret;
+		}
+		if (status != (SX1301_AGC_STATUS_SUCCESS | i)) {
+			netdev_err(netdev, "AGC firmware LUT init error: 0x%02x", status);
+			return -ENXIO;
+		}
+		lut++;
+	}
+
+	/* Abort the transaction if there are less then 16 entries */
+	if (priv->tx_gain_lut_size < SX1301_TX_GAIN_LUT_MAX) {
+		ret = sx130x_agc_transaction(priv, SX1301_AGC_CMD_ABORT, &status);
+		if (ret) {
+			netdev_err(netdev, "AGC LUT abort failed\n");
+			return ret;
+		}
+		if (status != SX1301_AGC_STATUS_SUCCESS) {
+			netdev_err(netdev, "AGC firmware LUT abort error: 0x%02x", status);
+			return -ENXIO;
+		}
+	}
+
+	return ret;
+};
+
+static int sx130x_agc_init(struct sx130x_priv *priv)
+{
+	struct net_device *netdev = dev_get_drvdata(priv->dev);
+	unsigned int tx_msb;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, SX1301_AGCSTS, &val);
+	if (ret) {
+		netdev_err(netdev, "AGC status read failed\n");
+		return ret;
+	}
+	if (val != SX1301_AGC_STATUS_READY) {
+		netdev_err(netdev, "AGC firmware init failure: 0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	ret = sx130x_load_tx_gain_lut(priv);
+	if (ret)
+		return ret;
+
+	/*
+	 * Load Tx freq MSBs
+	 * Always 3 if f > 768 for SX1257 and SX1258 or f > 384 for SX1255
+	 */
+	tx_msb = 3; /* TODO detect radio type */
+
+	ret = sx130x_agc_transaction(priv, tx_msb, &val);
+	if (ret) {
+		netdev_err(netdev, "AGC Tx MSBs load failed\n");
+		return ret;
+	}
+	if (val != (SX1301_AGC_STATUS_SUCCESS | tx_msb)) {
+		netdev_err(netdev, "AGC firmware Tx MSBs error: 0x%02x", val);
+		return -ENXIO;
+	}
+
+	/* Load chan_select firmware option */
+	ret = sx130x_agc_transaction(priv, 0, &val);
+	if (ret) {
+		netdev_err(netdev, "AGC chan select failed\n");
+		return ret;
+	}
+	if (val != (SX1301_AGC_STATUS_SUCCESS | 0)) {
+		netdev_err(netdev, "AGC firmware chan select error: 0x%02x", val);
+		return -ENXIO;
+	}
+
+	/* End AGC firmware init and check status */
+	/* TODO load the intended value of radio_select here
+	 * LORA IF mapping to radio A/B (per bit, 0=A, 1=B) */
+	ret = sx130x_agc_transaction(priv, 0, &val);
+	if (ret) {
+		netdev_err(netdev, "AGC radio select failed\n");
+		return ret;
+	}
+	if (val != SX1301_AGC_STATUS_INITIALISED) {
+		netdev_err(netdev, "AGC firmware init error: 0x%02x", val);
+		return -ENXIO;
+	}
+
+	return ret;
+}
+
 static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	if (skb->protocol != htons(ETH_P_LORA)) {
@@ -589,6 +694,11 @@ static int sx130x_loradev_open(struct net_device *netdev)
 	if (ret)
 		goto err_firmware;
 
+	usleep_range(1000, 2000);
+	ret = sx130x_agc_init(priv);
+	if (ret)
+		goto err_firmware;
+
 	ret = open_loradev(netdev);
 	if (ret)
 		goto err_open;
diff --git a/drivers/net/lora/sx130x.h b/drivers/net/lora/sx130x.h
index 69bb9cbd1aba..2878dd3cc547 100644
--- a/drivers/net/lora/sx130x.h
+++ b/drivers/net/lora/sx130x.h
@@ -19,8 +19,15 @@
 #define SX1301_MCU_AGC_CAL_FW_VERSION 2
 
 #define SX1301_AGC_CMD_WAIT 16
+#define SX1301_AGC_CMD_ABORT 17
+
+#define SX1301_AGC_STATUS_READY 0x10
+#define SX1301_AGC_STATUS_SUCCESS 0x30
+#define SX1301_AGC_STATUS_INITIALISED 0x40
 
 #define SX1301_TX_GAIN_LUT_MAX 16
+#define SX1301_PA_GAIN_OFFSET 6
+#define SX1301_DAC_GAIN_OFFSET 4
 
 /* Page independent */
 #define SX1301_PAGE     0x00
-- 
2.17.1

