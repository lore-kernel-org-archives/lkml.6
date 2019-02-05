Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C3EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA91217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlHBqHVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfBEWqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:46:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfBEWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:46:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so2039525pga.9;
        Tue, 05 Feb 2019 14:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jRDQ/aLoIGh88IfIgvJ03yd3KvjZCVSHSLlPHAPEuPU=;
        b=dlHBqHVabjvyoKHaOiZy7gjFOGWIOHAnA6QWWg73PQM1jEjFm31o9hE9RRIrdRPdXO
         O8sTn5kd3yhltidqiOYT3RYNQ6O791KubGbe+DRRPKtItHD5uyLqawNtyd3uV9e1e2MF
         k+4aqVGLeF1kUlYlcp4pVkePLApYMNeH5tHiyuGA8PJH3W8W+QGZ/w+qTdRKbpkt+Znz
         iUWRtgy+TL4a4fvB6m6wJ6jEWbvqTAWtqfur3Yd+yYkl91W7R12U8Kx34a9n0ITBWfjc
         Lnyvl6SRdythX1FJf50oVIE5o4DGrMZfz9gG07SSvya5eY4OUvuBZvokX4I88zzWLtag
         3y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jRDQ/aLoIGh88IfIgvJ03yd3KvjZCVSHSLlPHAPEuPU=;
        b=Hvc5BDSu3Y2gL1DoyYCfx9fBB12UxmokSCnGUTzsfjxponh6Vk5kdIvQp4uQZP95jc
         1V8lWNxjPPZyrVGotvLgbXqYSUSSsyysRPhyffL0+YLh9Rnzh1PTvBZ3XgZhINDm01X7
         h/HrOfIUPfrTvs8yOyz++SZs7unsZwOARKAdwLIU8zMXi8IvJ/WWjJLBaEyNFNzCOJAX
         FzA/tOi5ER4V5Gl+jJJP4KSUOZwzVqDLIB4lr834/J95nvs2Adi2onjvYwyTvIlJyO80
         XpJuOW0eL/i4uft4mTVm3lDh8NSKgVjHPo83ktQpKJ5lKsC8PDFpSGfcW9O+uI7fOMNA
         zCAQ==
X-Gm-Message-State: AHQUAuYx4SIwOQWcgoeb5mrB3qiQNSK+ALP8MJi0lEbwQPCWZ08ZtXJU
        oCzZUFl7zsLVgEQsYTA7hk81/4SJ
X-Google-Smtp-Source: AHgI3IZlzjIxyJ0/6tuR/+SZSnWmH1xuLiCYRaCVxxFhFx6taOpNCgc9/px4otJPdxAXlfcpDaYb9Q==
X-Received: by 2002:a63:cc41:: with SMTP id q1mr6727447pgi.323.1549406805199;
        Tue, 05 Feb 2019 14:46:45 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b4sm5052375pgq.57.2019.02.05.14.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 14:46:44 -0800 (PST)
Date:   Tue, 5 Feb 2019 14:46:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Andi Shyti <andi@etezian.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: stmfts - acknowledge that setting brightness is a
 blocking call
Message-ID: <20190205224642.GA182156@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to turn regulators on and off when switching brightness, and
that may block, therefore we have to set stmfts_brightness_set() as
LED's brightness_set_blocking() method.

Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmfts.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 704e99046916..b6f95f20f924 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -106,27 +106,29 @@ struct stmfts_data {
 	bool running;
 };
 
-static void stmfts_brightness_set(struct led_classdev *led_cdev,
+static int stmfts_brightness_set(struct led_classdev *led_cdev,
 					enum led_brightness value)
 {
 	struct stmfts_data *sdata = container_of(led_cdev,
 					struct stmfts_data, led_cdev);
 	int err;
 
-	if (value == sdata->led_status || !sdata->ledvdd)
-		return;
-
-	if (!value) {
-		regulator_disable(sdata->ledvdd);
-	} else {
-		err = regulator_enable(sdata->ledvdd);
-		if (err)
-			dev_warn(&sdata->client->dev,
-				 "failed to disable ledvdd regulator: %d\n",
-				 err);
+	if (value != sdata->led_status && sdata->ledvdd) {
+		if (!value) {
+			regulator_disable(sdata->ledvdd);
+		} else {
+			err = regulator_enable(sdata->ledvdd);
+			if (err) {
+				dev_warn(&sdata->client->dev,
+					 "failed to disable ledvdd regulator: %d\n",
+					 err);
+				return err;
+			}
+		}
+		sdata->led_status = value;
 	}
 
-	sdata->led_status = value;
+	return 0;
 }
 
 static enum led_brightness stmfts_brightness_get(struct led_classdev *led_cdev)
@@ -608,7 +610,7 @@ static int stmfts_enable_led(struct stmfts_data *sdata)
 	sdata->led_cdev.name = STMFTS_DEV_NAME;
 	sdata->led_cdev.max_brightness = LED_ON;
 	sdata->led_cdev.brightness = LED_OFF;
-	sdata->led_cdev.brightness_set = stmfts_brightness_set;
+	sdata->led_cdev.brightness_set_blocking = stmfts_brightness_set;
 	sdata->led_cdev.brightness_get = stmfts_brightness_get;
 
 	err = devm_led_classdev_register(&sdata->client->dev, &sdata->led_cdev);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
