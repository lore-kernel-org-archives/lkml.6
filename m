Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41424C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61982086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgZwsjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJMAAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:00:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41295 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeJMAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:00:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so14061526wru.8;
        Fri, 12 Oct 2018 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w12L7T6g553XEV/giTLwwktg3hGh8fmkUvYnpNP+utI=;
        b=NGgZwsjNnI8T7BA+qTgHU90f7mKDw/kRKL95eonQRn+zm1wcmsLAytkfGLp783Hkng
         L5utnftQQIf7EQovlSsxIlOyj8ee375pW+qS7SmLXlv3YL5aBdc0X8KDPwvEyG4ibRXk
         L2RVPTJ0xxydMW1mJOEcp+9ySG80TvbcApBc5/fW5PRdQgONjuQVMuCFZ+4cHsVBQxYj
         RrA2M+wAPpiGPkeuCDyeb7h30F0h2dykW+TWsytyB0DEQvyzLDJ2mYuH7+NJkDt5k2Se
         yk9dUErtAtd2w7bTiPN8LxLPm3g4BOLgjebvkmktTYBl1PqbxQpqgOH/eH6rJNYZtkvS
         9zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=w12L7T6g553XEV/giTLwwktg3hGh8fmkUvYnpNP+utI=;
        b=bNSEGdfAMJMTfsAyFpCMQ2O8TFjZPlQu0NZMxCSNYf3UuMW7bcWzxGl0dKO8yuLEXC
         TP32vHf+4yYew8QYgnHHsSlKR+9adVcZaYOCeS8RwntwWlfg41I0Q6dms+WFHNSirrkk
         pHuJpOV+cFDuMQuTSbt5dbBvk34kZtcSb5qIER0X5uEXJRX58343kQmKlOorUgHBG+FO
         z7B9rxarR8EtBGbpIGfffXiINa+tMeQqn2vpJrPiN/ZpDfRScg6KrQ8389g3wHQDRyuc
         qzmYI0vYMsm0pOsP8dNk3omjC/G6zKZTiMKofd8VyUd/q6khKZTWpUK/lmWcoYQUs8LU
         efkw==
X-Gm-Message-State: ABuFfohG+g81R3GBK92dcQFCfZOBdMgIv3268+JHO+EXNXxngjm4Xa/T
        7kGqZDblOAfPfr0mtZP+Rm0=
X-Google-Smtp-Source: ACcGV60eGPqo1wshNB7bxWHSGY1WYpkIhXZgveS4toq6VgN+whw6Aa9Xaps/gGJke+pbfLtbeaN8fQ==
X-Received: by 2002:adf:e403:: with SMTP id g3-v6mr5613288wrm.96.1539361615641;
        Fri, 12 Oct 2018 09:26:55 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1736842wmd.9.2018.10.12.09.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 09:26:54 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to register as a clk provider
Date:   Fri, 12 Oct 2018 17:26:06 +0100
Message-Id: <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The 32M is run from the radio, before we just enabled it based on
the radio number but now we can use the clk framework to request the
clk is started when we need it.

The 32M clock produced from the radio is really a gated version of
tcxo which is a fixed clock provided by hardware, and isn't captured
in this patch.

The sx1301 brings the clock up prior to calibration once the radios
have probed themselves.

A sample dts showing the clk link:
	sx1301: sx1301@0 {
		...
                clocks = <&radio1 0>;
                clock-names = "clk32m";

                radio-spi {
                        radio0: radio-a@0 {
                                ...
                        };

                        radio1: radio-b@1 {
                                #clock-cells = <0>;
                                clock-output-names = "clk32m";
                        };
                };
	};

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx125x.c | 112 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/net/lora/sx1301.c |  13 ++++++
 drivers/net/lora/sx1301.h |   2 +
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index 36b61b1..b7ca782 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -9,6 +9,8 @@
  * Copyright (c) 2013 Semtech-Cycleo
  */
 
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -42,10 +44,16 @@ static const struct reg_field sx125x_regmap_fields[] = {
 };
 
 struct sx125x_priv {
+	struct clk		*clkout;
+	struct clk_hw		clkout_hw;
+
+	struct device		*dev;
 	struct regmap		*regmap;
 	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
 };
 
+#define to_clkout(_hw) container_of(_hw, struct sx125x_priv, clkout_hw)
+
 static struct regmap_config __maybe_unused sx125x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -64,6 +72,96 @@ static int sx125x_field_write(struct sx125x_priv *priv,
 	return regmap_field_write(priv->regmap_fields[field_id], val);
 }
 
+static int sx125x_field_read(struct sx125x_priv *priv,
+		enum sx125x_fields field_id, unsigned int *val)
+{
+	return regmap_field_read(priv->regmap_fields[field_id], val);
+}
+
+static int sx125x_clkout_enable(struct clk_hw *hw)
+{
+	struct sx125x_priv *priv = to_clkout(hw);
+
+	dev_info(priv->dev, "enabling clkout\n");
+	return sx125x_field_write(priv, F_CLK_OUT, 1);
+}
+
+static void sx125x_clkout_disable(struct clk_hw *hw)
+{
+	struct sx125x_priv *priv = to_clkout(hw);
+	int ret;
+
+	dev_info(priv->dev, "disabling clkout\n");
+	ret = sx125x_field_write(priv, F_CLK_OUT, 0);
+	if (ret)
+		dev_err(priv->dev, "error disabling clkout\n");
+}
+
+static int sx125x_clkout_is_enabled(struct clk_hw *hw)
+{
+	struct sx125x_priv *priv = to_clkout(hw);
+	unsigned int enabled;
+	int ret;
+
+	ret = sx125x_field_read(priv, F_CLK_OUT, &enabled);
+	if (ret) {
+		dev_err(priv->dev, "error reading clk enable\n");
+		return 0;
+	}
+	return enabled;
+}
+
+static const struct clk_ops sx125x_clkout_ops = {
+	.enable = sx125x_clkout_enable,
+	.disable = sx125x_clkout_disable,
+	.is_enabled = sx125x_clkout_is_enabled,
+};
+
+static int sx125x_register_clock_provider(struct sx125x_priv *priv)
+{
+	struct device *dev = priv->dev;
+	struct clk_init_data init;
+	const char *parent;
+	int ret;
+
+	/* Disable CLKOUT */
+	ret = sx125x_field_write(priv, F_CLK_OUT, 0);
+	if (ret) {
+		dev_err(dev, "unable to disable clkout\n");
+		return ret;
+	}
+
+	/* Register clock provider if expected in DTB */
+	if (!of_find_property(dev->of_node, "#clock-cells", NULL))
+		return 0;
+
+	dev_info(dev, "registering clkout\n");
+
+	parent = of_clk_get_parent_name(dev->of_node, 0);
+	if (!parent) {
+		dev_err(dev, "Unable to find parent clk\n");
+		return -ENODEV;
+	}
+
+	init.ops = &sx125x_clkout_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent;
+	init.num_parents = 1;
+	priv->clkout_hw.init = &init;
+
+	of_property_read_string_index(dev->of_node, "clock-output-names", 0,
+			&init.name);
+
+	priv->clkout = devm_clk_register(dev, &priv->clkout_hw);
+	if (IS_ERR(priv->clkout)) {
+		dev_err(dev, "failed to register clkout\n");
+		return PTR_ERR(priv->clkout);
+	}
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get,
+			&priv->clkout_hw);
+	return ret;
+}
+
 static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap *regmap, unsigned int radio)
 {
 	struct sx125x_priv *priv;
@@ -76,6 +174,7 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
 	priv->regmap = regmap;
 	for (i = 0; i < ARRAY_SIZE(sx125x_regmap_fields); i++) {
 		const struct reg_field *reg_fields = sx125x_regmap_fields;
@@ -99,16 +198,13 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 		dev_info(dev, "SX125x version: %02x\n", val);
 	}
 
-	if (radio == 1) { /* HACK */
-		ret = sx125x_field_write(priv, F_CLK_OUT, 1);
-		if (ret) {
-			dev_err(dev, "enabling clock output failed\n");
-			return ret;
-		}
-
-		dev_info(dev, "enabling clock output\n");
+	ret = sx125x_register_clock_provider(priv);
+	if (ret) {
+		dev_err(dev, "failed to register clkout provider: %d\n", ret);
+		return ret;
 	}
 
+	/* TODO Only needs setting on radio on the TX path */
 	ret = sx125x_field_write(priv, F_TX_DAC_CLK_SEL, 1);
 	if (ret) {
 		dev_err(dev, "clock select failed\n");
diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
index 339f8d9..23cbddc3 100644
--- a/drivers/net/lora/sx1301.c
+++ b/drivers/net/lora/sx1301.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/lora.h>
@@ -378,6 +379,18 @@ static int sx130x_loradev_open(struct net_device *netdev)
 		return -ENXIO;
 	}
 
+	priv->clk32m = devm_clk_get(priv->dev, "clk32m");
+	if (IS_ERR(priv->clk32m)) {
+		dev_err(priv->dev, "failed to get clk32m\n");
+		return PTR_ERR(priv->clk32m);
+	}
+
+	ret = clk_prepare_enable(priv->clk32m);
+	if (ret) {
+		dev_err(priv->dev, "failed to enable clk32m: %d\n", ret);
+		return ret;
+	}
+
 	ret = sx1301_field_write(priv, F_GLOBAL_EN, 1);
 	if (ret) {
 		dev_err(priv->dev, "enable global clocks failed\n");
diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
index 0bbd948..a1a2e38 100644
--- a/drivers/net/lora/sx1301.h
+++ b/drivers/net/lora/sx1301.h
@@ -9,6 +9,7 @@
 #ifndef _SX1301_
 #define _SX1301_
 
+#include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
 #include <linux/lora/dev.h>
@@ -108,6 +109,7 @@ static const struct reg_field sx1301_regmap_fields[] = {
 struct sx1301_priv {
 	struct lora_dev_priv lora;
 	struct device		*dev;
+	struct clk		*clk32m;
 	struct gpio_desc *rst_gpio;
 	struct regmap		*regmap;
 	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
-- 
2.7.4

