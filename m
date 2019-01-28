Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5DF2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jazvh5Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfA1REk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:04:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39455 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfA1QNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so14487412wmi.4;
        Mon, 28 Jan 2019 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vJbqda7iNfsdkEaTDsRhUcFyf2+2O1DQ8LxmuJuzHg=;
        b=Jazvh5Y1f/v+gpqvtOuhcL1/QBuu/0j8BV1WPiW0NrcRiW501QqH0Vgz/LbbNuiV24
         QSLGOEOdO93sDGidWhZPN4lsNH/O5b5oOvfXnyRA7ppSsVoi59Da+aZIldkKW0gBz6er
         6DC317YbKWSxeZDsrrVLBJkNpA7gEH0rf2HnW8ONXrlXFTsIOqhJxgjWat9ap1HAzc9R
         Nxz06V9deFhQb10Slo+7BuklQzFFOBIf7l4l7CuvEl5y2bPGTic15obdtkd7q/8c3xBP
         4yRI9CE7i994rLVBvUn9K22Qem5VLfv4wMk2ndlVo52/IQoKcl7sKQcVwyL8eC+C4pnb
         cWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7vJbqda7iNfsdkEaTDsRhUcFyf2+2O1DQ8LxmuJuzHg=;
        b=YEK8DigFuK4OulzlVMXflAhBB69SBG8SLnaNz4PzzUaJQjuwt6vFzC8Leska0sfmxj
         Wh+yThvnI3W1mNiK2af4A60jfHzsKXvGIdNEm/8z2A0Umxbqjld/OA3Ig1/72QHl6C8s
         pS69oWS210rtvM9P5SKg9Os+5G5+T4B6kdxe4hvA8HX/m5v/h8aVkmOtkWExn9xxcmBd
         nhzuE+YtDKI2BR3+FjZcMbdSpbmPeC8/Wnxtq0ucYEj6pQyVuhiu2FNakDPX4jBgSEb8
         ljoXQHtEDK2nvC9vvZwGiZOt1EK2YxTTwUHw3hKm3ch44ozla1FFmNkJh2BV3217FtD1
         6zgw==
X-Gm-Message-State: AJcUukcko0V6d8QPdc+7/i7WUdi+bO2BBG8GKnGVV0lcsNdgUbWKLShk
        JqTgABu0kpP14x5FP1N9uoc=
X-Google-Smtp-Source: ALg8bN478f2KbrS5TRr8sDSZd97jwRteH3GPk+QMkUpMj7yWe4T3az5DbCqidcDK6sQ/jRpAuE8BMw==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr17616880wmi.24.1548692027665;
        Mon, 28 Jan 2019 08:13:47 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:47 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 02/11] net: lora: sx130x: add loading of tx lut from DT
Date:   Mon, 28 Jan 2019 16:12:56 +0000
Message-Id: <20190128161306.27805-3-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The AGC software requires loading of a power lookup table on initialisation
prior to transmission.
The fields required are digital, pa, dac, and mixer gain. These values are
typically hardware specific and calibrated for a particular power output at
the card rf port.
The format of the DT binding is <power(s8) dig(u8) pa(u8) dac(u8) mix(u8)>
a valid entry is 5 bytes, a valid table is up to 16 entries.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx130x.c | 29 +++++++++++++++++++++++++++++
 drivers/net/lora/sx130x.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 3174fc695d54..70cfb4532b51 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -51,6 +51,14 @@ static const struct reg_field sx130x_regmap_fields[] = {
 		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
 };
 
+struct sx130x_tx_gain_lut {
+	s8 power;	/* dBm measured at board connector */
+	u8 dig_gain;
+	u8 pa_gain;
+	u8 dac_gain;
+	u8 mix_gain;
+};
+
 struct sx130x_priv {
 	struct lora_dev_priv	lora;
 	struct device		*dev;
@@ -59,6 +67,8 @@ struct sx130x_priv {
 	struct regmap_field	*regmap_fields[ARRAY_SIZE(sx130x_regmap_fields)];
 	struct mutex		io_lock;
 	void			*drvdata;
+	struct sx130x_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
+	u8 tx_gain_lut_size;
 };
 
 struct regmap *sx130x_get_regmap(struct device *dev)
@@ -589,6 +599,7 @@ int sx130x_early_probe(struct regmap *regmap, struct gpio_desc *rst)
 	struct device *dev = regmap_get_device(regmap);
 	struct net_device *netdev;
 	struct sx130x_priv *priv;
+	const u8 *power_lut;
 	int ret;
 	int i;
 
@@ -620,6 +631,24 @@ int sx130x_early_probe(struct regmap *regmap, struct gpio_desc *rst)
 			return ret;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_OF)) {
+		power_lut = of_get_property(dev->of_node, "power-lut", &ret);
+		if (power_lut && (ret % 5)) {
+			dev_err(dev, "Invalid power table\n");
+			return -EINVAL;
+		} else if (power_lut) {
+			priv->tx_gain_lut_size = ret / 5;
+			for (i = 0; i < priv->tx_gain_lut_size; i++) {
+				priv->tx_gain_lut[i].power = *(power_lut++);
+				priv->tx_gain_lut[i].dig_gain = *(power_lut++);
+				priv->tx_gain_lut[i].pa_gain = *(power_lut++) & 0x03;
+				priv->tx_gain_lut[i].dac_gain = *(power_lut++) & 0x03;
+				priv->tx_gain_lut[i].mix_gain = *(power_lut++) & 0x0F;
+			}
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sx130x_early_probe);
diff --git a/drivers/net/lora/sx130x.h b/drivers/net/lora/sx130x.h
index abab2ee42512..6330777f4eac 100644
--- a/drivers/net/lora/sx130x.h
+++ b/drivers/net/lora/sx130x.h
@@ -18,6 +18,8 @@
 #define SX1301_MCU_AGC_FW_VERSION 4
 #define SX1301_MCU_AGC_CAL_FW_VERSION 2
 
+#define SX1301_TX_GAIN_LUT_MAX 16
+
 /* Page independent */
 #define SX1301_PAGE     0x00
 #define SX1301_VER      0x01
-- 
2.17.1

