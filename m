Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EB320880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="LIDOxq4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EB320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeIKW3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:29:06 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34778 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeIKW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:29:04 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so4245184iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/YCCUj556IEYCbXa9GPHpGuHvo/AoBIzM3sGHhK1I8=;
        b=LIDOxq4J9vshXRiLTG1uMplYZg/hrmLrvRolfT0lpytZB9rJMBAAnUktas+i7ldg92
         Z3ygnX9DHsRYQXLoILwHjtAVEqgZtHPtiCjD7X3TlHToKH2gMtFuwj7sYxv01u40Fr+v
         lvZhHi+ryWTwNwxGWM/OotOUa5eQo5ihZvpVaQF8jYuYXq6G5a9uUZrfnswV3pfrJcco
         KrV/uoHtZchSI3+YphDQR9OSPXbPaz5BcXTyBuCJ9jM3OMa6G/02vxkRD7Xcj7in3/iz
         Tf0hfQ+v65a9hg4hI/GoB1RLQPwQmFQDwjapoKb+ov8P6ypf7nwRfQSiV+WA4RdeHbMg
         7nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/YCCUj556IEYCbXa9GPHpGuHvo/AoBIzM3sGHhK1I8=;
        b=Iyq0wDDGWv4wlCuUXbKpRaz6H5DdDVyW7apYGHFBNdoSTHUr2ytiNu43MjgDgM7XDs
         Nnhsw4s6uxwtOAnVc5rstSEX0AuQPbTQhPlfUMw4TjIeOKBtQRxtNMGRcnW9wcyktpHj
         ydvNf3KFR/nqf04hXSsuE/K9tiFa0TwnJVY5nuJtPalzhL65n3JJTJ9QEmD53U6jVY3M
         uraJHAFVHUJVsS3fqNcq26YtH6D8SvFwNkgLItbhdat/7jbEZxHbZfg2DUeMTJFhUN0J
         jQcdvIW0y3BX/w/QrqqoobtcOuUqa7velE9a9LLwdmhOtwL5CDm8aV36dRT+b7dJPg2o
         DSAg==
X-Gm-Message-State: APzg51BBnhdkivkLaDWP+VcvSVc7ispFu2D99/bUdt5Oyx/NiC1vlTan
        7A4bQjsl1EPcSR82+1bBW9s7rzTSP7w=
X-Google-Smtp-Source: ANB0VdZ9lM6xL4/QEd4l4vw9hVwhcvqhM3K6X2rlx1BEoX0Ny4G2jMToOAOdKhGRe8I9GVlSgxHiQQ==
X-Received: by 2002:a6b:3a55:: with SMTP id h82-v6mr22005653ioa.76.1536686924536;
        Tue, 11 Sep 2018 10:28:44 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id g198-v6sm5050261itg.4.2018.09.11.10.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 10:28:43 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: abx80x: use a 'priv' struct for client data
Date:   Tue, 11 Sep 2018 11:28:25 -0600
Message-Id: <20180911172826.7195-2-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911172826.7195-1-jgebben@sweptlaser.com>
References: <20180911172826.7195-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow additional data to be tracked, for future
improvements.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/rtc/rtc-abx80x.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2cefa67a1132..9d49054a0a4a 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -94,6 +94,11 @@ static struct abx80x_cap abx80x_caps[] = {
 	[ABX80X] = {.pn = 0}
 };
 
+struct abx80x_priv {
+	struct rtc_device *rtc;
+	struct i2c_client *client;
+};
+
 static int abx80x_is_rc_mode(struct i2c_client *client)
 {
 	int flags = 0;
@@ -218,7 +223,8 @@ static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static irqreturn_t abx80x_handle_irq(int irq, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
-	struct rtc_device *rtc = i2c_get_clientdata(client);
+	struct abx80x_priv *priv = i2c_get_clientdata(client);
+	struct rtc_device *rtc = priv->rtc;
 	int status;
 
 	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
@@ -533,7 +539,7 @@ static int abx80x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
-	struct rtc_device *rtc;
+	struct abx80x_priv *priv;
 	int i, data, err, trickle_cfg = -EINVAL;
 	char buf[7];
 	unsigned int part = id->driver_data;
@@ -610,13 +616,18 @@ static int abx80x_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	rtc = devm_rtc_allocate_device(&client->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
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
 
 	if (client->irq > 0) {
 		dev_info(&client->dev, "IRQ %d supplied\n", client->irq);
@@ -649,7 +660,7 @@ static int abx80x_probe(struct i2c_client *client,
 		return err;
 	}
 
-	err = rtc_register_device(rtc);
+	err = rtc_register_device(priv->rtc);
 
 	return err;
 }
-- 
2.17.1

