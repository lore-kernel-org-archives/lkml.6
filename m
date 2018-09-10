Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62DC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1F020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="qAWCKU6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1F020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeIKCdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:33:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51825 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeIKCdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:33:37 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so31598819itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9gKSg4YHZY2mpJ6+lpceFTME0EGpvAjMsehyx8jBQk=;
        b=qAWCKU6/ynMUFmZBf2mfAUXGRUeqo0A/WM4wbeVIjmYOizc13Hsmv0sO0ZSXdLy4EQ
         AXDKROSrqHYTgqnh5blxnS0hn16+pjo9I+VDjCllHhhmJi/ogr04Kbf0rXNl4S8m6wsL
         LSW5kA0PSWKsR2J4vuonqILHDSKRdXq7eMD3vGatAr7JTXz7U35NCu2Xn6AhOpc+Pi1o
         xbHcLrfWtfaKfVUYWT00WhVs5sUYaCFM449HlO/gzPGSY2eKdbld98Xiww+tvl61bwnb
         aD47A1nLW9bkdZdsGGWwkp2oUuAI3a2rWq1z3bhMVSRJ+wkl1uUu56RXfagla/PCpnJ9
         ozlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9gKSg4YHZY2mpJ6+lpceFTME0EGpvAjMsehyx8jBQk=;
        b=T4ZWpufaE9xamDa73lZfracLbdiyg7L5uPRYAetUrJl2ZyZqj7q99Xfx3CnBzcENJL
         5wsN9uVH9toWY5Md8rUWiZkp/8kGc0u6EfrU9SYj/h0x+poWicFyIYCXxr3+GlUkFfJk
         S7b4/gvuI12CfuZ+Qva4aDIqJAnhxHqKjAEthOM8cjNyZsSELPZ+OvimzWn+weHWWzW4
         ksIrQ4sRlImiwsPSkp5TQLGx76oHpzFDFgPcBEddwsO8muN19ttTZDX19onBgz5Vo06M
         +0/agCQMlRR3CrSSJhY8s2ODsFO7NS/am0Y7spvhIZGOlZYlHTD6wpzZun8ajM/55MaH
         gDZA==
X-Gm-Message-State: APzg51BZ3atVGYEHIjeqH8I+Wss+RJyVbK1YV7Mca40aDRGHb6ZcLROK
        Vx3UWqHpNGoPSYCq7+niHwBPmw==
X-Google-Smtp-Source: ANB0Vda8DJU4Gvj0xeQvjxR8q68PN5tJjszVBW+Bv7fEsWQlC22LYL+5D6kENtyCVm8dkfQZ9KiSbg==
X-Received: by 2002:a24:918d:: with SMTP id i135-v6mr18187501ite.98.1536615454659;
        Mon, 10 Sep 2018 14:37:34 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id q68-v6sm7377952itb.23.2018.09.10.14.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:37:34 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Date:   Mon, 10 Sep 2018 15:36:54 -0600
Message-Id: <20180910213654.26059-3-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910213654.26059-1-jgebben@sweptlaser.com>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The abx804 and abx805 chips have support for a simple watchdog
function that can trigger an external reset.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/rtc/rtc-abx80x.c | 132 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9d49054a0a4a..e1ec4cce093a 100644
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
@@ -80,23 +90,25 @@ enum abx80x_chip {AB0801, AB0803, AB0804, AB0805,
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
 
 struct abx80x_priv {
 	struct rtc_device *rtc;
 	struct i2c_client *client;
+	struct watchdog_device wdog;
 };
 
 static int abx80x_is_rc_mode(struct i2c_client *client)
@@ -234,6 +246,13 @@ static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 	if (status & ABX8XX_STATUS_AF)
 		rtc_update_irq(rtc, 1, RTC_AF | RTC_IRQF);
 
+	/*
+	 * It is unclear if we'll get an interrupt before the external
+	 * reset kicks in.
+	 */
+	if (status & ABX8XX_STATUS_WDT)
+		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
+
 	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS, 0);
 
 	return IRQ_HANDLED;
@@ -535,6 +554,105 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
 	sysfs_remove_group(&dev->kobj, &rtc_calib_attr_group);
 }
 
+#ifdef CONFIG_WATCHDOG
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
@@ -629,6 +747,12 @@ static int abx80x_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, priv);
 
+	if (abx80x_caps[part].has_wdog) {
+		err = abx80x_setup_watchdog(priv);
+		if (err)
+			return err;
+	}
+
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
 		err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-- 
2.17.1

