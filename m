Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BDC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830222087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="OfA3G7ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830222087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIKW3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:29:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37536 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeIKW3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:29:07 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so2589936itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IBFOnR0DcWOXzA6mr94JtkFvvU6IkJIdr+f4e1kKDTs=;
        b=OfA3G7ZDLRHA01OPaDMEuVxzBRQS8NGUhjVHq7+Wr6Q2z1yyLBwCQrrxXHj0MPWxNd
         IpeAsTbgZNDh/DVflgVlcNw5vUSrpzWAwji7o7gYYzOrBaXPbam0tU9OU1S6UyCkxakq
         hceV5A5AjRa0GLYzOibEHI/Di2zgQAV8BOSsJ+UxBIPnh4I0JTlbyecA6klh/tAWybMs
         2+YKP/bYaMv3ejUdsrB4MnmaJvQfAnO001PrDFe7rNobZl4dQZVSGc4fGqWO0n7txuVX
         Fk23cryBZqnmjCJOhoj5vBLrLe/ybwC//gfggNx9KqUOiGDyP73+KKolk6Tl6qhQ+rtG
         7pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IBFOnR0DcWOXzA6mr94JtkFvvU6IkJIdr+f4e1kKDTs=;
        b=o1QFwz5oWpG5iMcqg9FVqhbx2Rhv96OcPotibIE3vRMOWE0vM/1XfFRbAKFlA4AFYk
         8NdxB9drTyoTfE5x3vm5G/NXXeb5P3ufDGGW1QfNc794HF9yi9rmUoJC6bJ5mQJTeka4
         0pzn0WjUUgN6LasEMJbsLSnKVl4rlYKp7iSnjYEm77XKwzXaHLAnRj/ZPtiBuOHE7s3k
         kdBMj0PJDuN1BTqzp6sscFk2yIsKwdXwj7E5iyz3OlioK1KlGLbQsvHxn8aAXDcWayu+
         WzGQoyc27WSxJQuVG7Q8QASdFZ0p00s/xL5g666US5VR9aSXPZ9toU8piZR36KcsaagQ
         AcNg==
X-Gm-Message-State: APzg51CeuPzUeNKlLjU1/cHY0TLqvuaqO/mRRas3jljYxHRkOFYeEjcl
        DWB5ikCcYyBU0G9PYFGwG1JTiA==
X-Google-Smtp-Source: ANB0VdYVvyBf2Q+4eDr8aFCtXTANLLhRIBA/l8v83psWsijC7nWy2/bhjzv99GfJkNrr7P7RaKxsug==
X-Received: by 2002:a24:1049:: with SMTP id 70-v6mr2373408ity.115.1536686926447;
        Tue, 11 Sep 2018 10:28:46 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id g198-v6sm5050261itg.4.2018.09.11.10.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:28:45 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: abx80x: add basic watchdog support
Date:   Tue, 11 Sep 2018 11:28:26 -0600
Message-Id: <20180911172826.7195-3-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911172826.7195-1-jgebben@sweptlaser.com>
References: <20180911172826.7195-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The abx804 and abx805 chips have support for a simple watchdog
function that can trigger an external reset.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/rtc/Kconfig      |   1 +
 drivers/rtc/rtc-abx80x.c | 116 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7d7be60a2413..bcb0e9eda781 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -187,6 +187,7 @@ config RTC_DRV_ABB5ZES3
 
 config RTC_DRV_ABX80X
 	tristate "Abracon ABx80x"
+	select WATCHDOG_CORE if WATCHDOG
 	help
 	  If you say yes here you get support for Abracon AB080X and AB180X
 	  families of ultra-low-power  battery- and capacitor-backed real-time
diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 9d49054a0a4a..d8e94edcb0ba 100644
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
@@ -535,6 +554,89 @@ static void rtc_calib_remove_sysfs_group(void *_dev)
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
+				     unsigned int timeout)
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
+				   unsigned int new_timeout)
+{
+	int err = 0;
+
+	if (watchdog_hw_running(wdog))
+		err = __abx80x_wdog_set_timeout(wdog, new_timeout);
+
+	if (err == 0)
+		wdog->timeout = new_timeout;
+
+	return err;
+}
+
+static int abx80x_wdog_ping(struct watchdog_device *wdog)
+{
+	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
+}
+
+static int abx80x_wdog_start(struct watchdog_device *wdog)
+{
+	return __abx80x_wdog_set_timeout(wdog, wdog->timeout);
+}
+
+static int abx80x_wdog_stop(struct watchdog_device *wdog)
+{
+	return __abx80x_wdog_set_timeout(wdog, 0);
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
+	priv->wdog.parent = &priv->client->dev;
+	priv->wdog.ops = &abx80x_wdog_ops;
+	priv->wdog.info = &abx80x_wdog_info;
+	priv->wdog.min_timeout = 1;
+	priv->wdog.max_timeout = ABX8XX_WDT_MAX_TIME;
+	priv->wdog.timeout = ABX8XX_WDT_MAX_TIME;
+
+	watchdog_set_drvdata(&priv->wdog, priv);
+
+	return devm_watchdog_register_device(&priv->client->dev, &priv->wdog);
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
@@ -629,6 +731,12 @@ static int abx80x_probe(struct i2c_client *client,
 
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

