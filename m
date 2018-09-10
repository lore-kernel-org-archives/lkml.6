Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D648C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3640020855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="detksjsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3640020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sweptlaser.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIKCdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:33:36 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45844 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeIKCdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:33:35 -0400
Received: by mail-io0-f195.google.com with SMTP id e12-v6so1898816iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p/YCCUj556IEYCbXa9GPHpGuHvo/AoBIzM3sGHhK1I8=;
        b=detksjsYrERXOIyI6i1uQV7joYwKdjX3Ak96HyYifCI54zQvk5Akl2bDOWJoeIWmws
         7NzJTRuempjhbqGDr86s43+YwhK+0Eq6knd3QT2NCSle8YHzQMvz+1AWsWoxA9Q9JrYw
         yxWjqhSfDXAzEn1SCF1Dw2N0GIZFRZw357tdBOdCuPX48UDUUhvHeJzdchhYmjmMdDqE
         dUpPMdafRRB5pXcMRdfeVTXGAKBgJ5E9p0Y47cP/Jmoj8uTyb7SC8uENJMLEyJqVq4/p
         r/R87T7R1zwyNCTgkQ2xq0p+7jep+AK+TSadkz8SMzDST19UWxG+fX+4V/6iWr92beNM
         wDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p/YCCUj556IEYCbXa9GPHpGuHvo/AoBIzM3sGHhK1I8=;
        b=Fma7R+8kD9hywC6oLvMTeXilevQL3brWAOFvLB6Dw74tJNC8Xftzcg+SiwQU9JOlTT
         oZId71ErhNWvOeUXAYlXbvs7udSCKL02oeDJXazwmUTBrczx8P/Q8WvTWLipRKjf6hfv
         s9W1ZfVi4aRT7C5Uwli9FfJqK6LroTURNderHp0FoYTDZ+eaBnyfXh5ZnyIY8aDosIFX
         AG8hwZ1rq2hVXm5wh0k5SWl4ESzaigRDk30Co3L9wcK9LpIa6z4qfxrsKLpK/tb7iZd9
         QTzLacvq4QUbPPU1b7pQrqBAM8jGvDDrhlsjqUAmq6Ur/vn2NlZp0H4Dq5+Hff06Gg1I
         V1dA==
X-Gm-Message-State: APzg51DtlnsrLjbcZeZb0U0rP8fzl8qGuPvHdKYTvCPYlxC1Sd7W0LcE
        tzk2iE02PSG57kGlKf/xtKU5nA==
X-Google-Smtp-Source: ANB0VdYDZuMR5bDZfTWwFsdJTAd/reWwEWRn26Uag8v5TBWdEDlQwjoM5/72LmRRVfJXfzdWnZxylQ==
X-Received: by 2002:a6b:d611:: with SMTP id w17-v6mr19199370ioa.216.1536615453762;
        Mon, 10 Sep 2018 14:37:33 -0700 (PDT)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id q68-v6sm7377952itb.23.2018.09.10.14.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:37:33 -0700 (PDT)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: abx80x: use a 'priv' struct for client data
Date:   Mon, 10 Sep 2018 15:36:53 -0600
Message-Id: <20180910213654.26059-2-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910213654.26059-1-jgebben@sweptlaser.com>
References: <20180910213654.26059-1-jgebben@sweptlaser.com>
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

