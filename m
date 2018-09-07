Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F73C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE2420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="RuJo35E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE2420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeIGT7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:59:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55154 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIGT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:59:15 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so21022121ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ut/bcOdIGvabsbXUYma4OFkSWGoq2SRJgTZSExhK3CQ=;
        b=RuJo35E1UZtGbkknDABHjaYyKqr7gqUQuEB5Ft1l0SWl93eqPqw1dCmYifqxZueDN+
         p01LVk+WKr5MEgMzhQpGG8+cR+HWdzNUTOcXNcKuRvNSuaNnEIf+Dd4QN04IDVxXvbUV
         wg+gyKVqPQTMKmnCqbOJokCGemGxgCSlrMDYcef1Rc0DGTTqTdmzlO7LqXLOyE+1eq+Z
         RPoibe+Lj3tavWqtHkYpuw2JSNvoAvzNDdHM0VWX5gv6ySWHU5KWAACCNmxlkUuz58DH
         vu81UNVDXqZ/DbDZYl+JlrfG+n3kPrT4j+YRUP7NL3grA6cddRxfFkuRGISWB9FzaWw4
         5Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ut/bcOdIGvabsbXUYma4OFkSWGoq2SRJgTZSExhK3CQ=;
        b=ABz+VJPAiu/fZDlg1SV5eDVuVYffwn4MsFTtDFb+dw+nb5G5Ud2tgQiIQy9WIisLGp
         HeDhpH5Gnhr8w9FvCf/XIIsKXak80PDtXxNM/ITHDVtJCzjKgRzVeqnvUWkvRw/F4Qcj
         eWSJFaudvZt/T2knJNRsPfrWZG0G4G5NKofmyA/kyZ2KB05WaqdgzfxC8ROmUThKjtfl
         ddwCY8ryvJiDzYPxDga3JMzZAbowFiiggmV3+CalPqKZ8CKEJockfDsEMX0RMst9TiRv
         /g9m9VfeLTadlx3qwcGUffRtFL48NaOo7BCIGZNlbofxsKfQfiKfiQxq+oCx2nz1w1qR
         /8sg==
X-Gm-Message-State: APzg51BbsFaqaDK4E9kuWcDI8d80XSWGkZg7gJX8okhVX8q/o7AnokrF
        FlLHufIoRcbbnRnUYrvfr5hshvay2w4=
X-Google-Smtp-Source: ANB0Vdaj4XehKT9+Q1d4O4jEeiAxJHUSY7h6yw8TE2cKDXhcR2JUFQXM9KfrmX3rZTeZVX3pYk0RJg==
X-Received: by 2002:a02:6f1a:: with SMTP id x26-v6mr7494949jab.131.1536333472081;
        Fri, 07 Sep 2018 08:17:52 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id e15-v6sm2321513ioh.18.2018.09.07.08.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:17:51 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: abx80x: add basic watchdog support
Date:   Fri,  7 Sep 2018 09:17:43 -0600
Message-Id: <20180907151744.32634-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The abx804 and abx805 chips have support for a simple watchdog
function that can trigger an external reset.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/rtc/Kconfig      |  11 +++
 drivers/rtc/rtc-abx80x.c | 160 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 159 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7d7be60a2413..4771e3a89721 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -195,6 +195,17 @@ config RTC_DRV_ABX80X
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-abx80x.
 
+config RTC_DRV_ABX80X_WDT
+	bool "Abracon ABx80x Watchdog"
+	default y
+	depends on RTC_DRV_ABX80X
+	help
+	  If you say yes here you get watchdog support for Abracon ABX804 and ABX805
+	  clock chips. This watchdog supports timeouts up to 31 seconds with 1 second
+	  granularity.
+
+          This watchdog device is part of the rtc-abx80x module.
+
 config RTC_DRV_AC100
 	tristate "X-Powers AC100"
 	depends on MFD_AC100
diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2cefa67a1132..fa558939e944 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
+#include <linux/watchdog.h>
 
 #define ABX8XX_REG_HTH		0x00
 #define ABX8XX_REG_SC		0x01
@@ -37,6 +38,7 @@
 
 #define ABX8XX_REG_STATUS	0x0f
 #define ABX8XX_STATUS_AF	BIT(2)
+#define ABX8XX_STATUS_WDT	BIT(6)
 
 #define ABX8XX_REG_CTRL1	0x10
 #define ABX8XX_CTRL_WRITE	BIT(0)
@@ -61,6 +63,14 @@
 #define ABX8XX_OSS_OF		BIT(1)
 #define ABX8XX_OSS_OMODE	BIT(4)
 
+#define ABX8XX_REG_WDT		0x1b
+#define ABX8XX_WDT_WDS		BIT(7)
+#define ABX8XX_WDT_BMB_MASK	0x7c
+#define ABX8XX_WDT_BMB_SHIFT	2
+#define ABX8XX_WDT_MAX_TIME	(ABX8XX_WDT_BMB_MASK >> ABX8XX_WDT_BMB_SHIFT)
+#define ABX8XX_WDT_WRB_MASK	0x03
+#define ABX8XX_WDT_WRB_1HZ	0x02
+
 #define ABX8XX_REG_CFG_KEY	0x1f
 #define ABX8XX_CFG_KEY_OSC	0xa1
 #define ABX8XX_CFG_KEY_MISC	0x9d
@@ -80,20 +90,27 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
 struct abx80x_cap {
 	u16 pn;
 	bool has_tc;
+	bool has_wdog;
 };
 
 static struct abx80x_cap abx80x_caps[] = {
 	[AB0801] = {.pn = 0x0801},
 	[AB0803] = {.pn = 0x0803},
-	[AB0804] = {.pn = 0x0804, .has_tc = true},
-	[AB0805] = {.pn = 0x0805, .has_tc = true},
+	[AB0804] = {.pn = 0x0804, .has_tc = true, .has_wdog = true},
+	[AB0805] = {.pn = 0x0805, .has_tc = true, .has_wdog = true},
 	[AB1801] = {.pn = 0x1801},
 	[AB1803] = {.pn = 0x1803},
-	[AB1804] = {.pn = 0x1804, .has_tc = true},
-	[AB1805] = {.pn = 0x1805, .has_tc = true},
+	[AB1804] = {.pn = 0x1804, .has_tc = true, .has_wdog = true},
+	[AB1805] = {.pn = 0x1805, .has_tc = true, .has_wdog = true},
 	[ABX80X] = {.pn = 0}
 };
 
+struct abx80x_priv {
+	struct rtc_device *rtc;
+	struct i2c_client *client;
+	struct watchdog_device wdog;
+};
+
 static int abx80x_is_rc_mode(struct i2c_client *client)
 {
 	int flags = 0;
@@ -218,7 +235,8 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
-	struct rtc_device *rtc = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct rtc_device *rtc = priv->rtc;
 	int status;
 
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
@@ -228,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	if (status & ABX8XX_STATUS_AF)
 		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
 
+	/*
+	 * It is unclear if we'll get an interrupt before the external
+	 * reset kicks in.
+	 */
+	if (status & ABX8XX_STATUS_WDT)
+		dev_err(&client->dev, "watchdog timeout interrupt!\n");
+
 	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
 
 	return IRQ_HANDLED;
@@ -529,11 +554,110 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
 	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
 }
 
+#ifdef CONFIG_RTC_DRV_ABX80X_WDT
+
+static inline u8 timeout_bits(unsigned int timeout)
+{
+	return ((timeout << ABX8XX_WDT_BMB_SHIFT) & ABX8XX_WDT_BMB_MASK) |
+		 ABX8XX_WDT_WRB_1HZ;
+}
+
+static int __abx80x_wdog_set_timeout(struct watchdog_device *wdog,
+				    unsigned int timeout)
+{
+	struct abx80x_priv *priv = watchdog_get_drvdata(wdog);
+	u8 val = ABX8XX_WDT_WDS | timeout_bits(timeout);
+
+	/*
+	 * Writing any timeout to the WDT register resets the watchdog timer.
+	 * Writing 0 disables it.
+	 */
+	return i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_WDT, val);
+}
+
+static int abx80x_wdog_set_timeout(struct watchdog_device *wdog,
+				unsigned int new_timeout)
+{
+	int err = __abx80x_wdog_set_timeout(wdog, new_timeout);
+
+	if (err)
+		return err;
+
+	wdog->timeout = new_timeout;
+	return 0;
+}
+
+static int abx80x_wdog_ping(struct watchdog_device *wdog)
+{
+	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
+}
+
+static int abx80x_wdog_start(struct watchdog_device *wdog)
+{
+	int err = __abx80x_wdog_set_timeout(wdog, wdog->timeout);
+
+	if (err)
+		return err;
+
+	set_bit(WDOG_HW_RUNNING, &wdog->status);
+	return 0;
+}
+
+static int abx80x_wdog_stop(struct watchdog_device *wdog)
+{
+	int err = __abx80x_wdog_set_timeout(wdog, 0);
+
+	if (err)
+		return err;
+
+	clear_bit(WDOG_HW_RUNNING, &wdog->status);
+	return 0;
+}
+
+static const struct watchdog_info abx80x_wdog_info = {
+	.identity = "abx80x watchdog",
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
+};
+
+static const struct watchdog_ops abx80x_wdog_ops = {
+	.owner = THIS_MODULE,
+	.start = abx80x_wdog_start,
+	.stop = abx80x_wdog_stop,
+	.ping = abx80x_wdog_ping,
+	.set_timeout = abx80x_wdog_set_timeout,
+};
+
+static int abx80x_setup_watchdog(struct abx80x_priv *priv)
+{
+	int err;
+
+	priv->wdog.ops = &abx80x_wdog_ops;
+	priv->wdog.info = &abx80x_wdog_info;
+	priv->wdog.min_timeout = 1;
+	priv->wdog.max_timeout = ABX8XX_WDT_MAX_TIME;
+
+	err = devm_watchdog_register_device(&priv->client->dev,
+					    &priv->wdog);
+	if (err)
+		return err;
+
+	watchdog_set_drvdata(&priv->wdog, priv);
+	watchdog_init_timeout(&priv->wdog, ABX8XX_WDT_MAX_TIME,
+			      &priv->client->dev);
+	return 0;
+}
+#else
+static int abx80x_setup_watchdog(struct abx80x_priv *priv)
+{
+	return 0;
+}
+#endif
+
 static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
-	struct rtc_device *rtc;
+	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
 	char buf[7];
 	unsigned int part = id->driver_data;
@@ -610,13 +734,25 @@ static int abx80x_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	priv = devm_kzalloc(&client->dev, sizeof(struct abx80x_priv),
+			    GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	priv->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(priv->rtc))
+		return PTR_ERR(priv->rtc);
 
-	rtc->ops = &abx80x_rtc_ops;
+	priv->rtc->ops = &abx80x_rtc_ops;
+	priv->client = client;
 
-	i2c_set_clientdata(client, rtc);
+	i2c_set_clientdata(client, priv);
+
+	if (abx80x_caps[part].has_wdog) {
+		err = abx80x_setup_watchdog(priv);
+		if (err)
+			return err;
+	}
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
@@ -649,7 +785,7 @@ static int abx80x_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = rtc_register_device(rtc);
+	err = rtc_register_device(priv->rtc);
 
 	return err;
 }
-- 
2.17.1

