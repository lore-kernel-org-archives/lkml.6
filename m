Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09737C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA820823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIIIcONz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBFSQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:16:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33636 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:16:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so3265704pgu.0;
        Wed, 06 Feb 2019 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jmt6oMl/yboxAgqebvRA5d+I41RmYF7lgYGreW5B5Oo=;
        b=gIIIcONz0pXMzK1gpELQxXgCi8bCfj6r3aHz5c4OKH6FMzZZiAFwEkGJ90f3A2MOVv
         fRDYTTu8eYxuyee80XeOq2d4Euc4MHzBdN3QRm7mGUefUfbxId1bi6T+Pqzv+EdbanhY
         SntPiA0+a2ta51p/ZjK57p7dbis3rdlDswEhg3OnPFwKD1WdrDq6s8shI3foqxq1BNJZ
         yq1CUfWH+wJyE5KJ9Gz3xX0N2bb+scLk73ikDaktcWzHX3zrjd9UOVQkcrux4ff0QwVU
         KhP7DYEKCyK5jpvqCC8VjQYSxCbdhLlDatbuD7IGeydHfxwd4+9SyYU9khsqUzB23Xel
         bLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jmt6oMl/yboxAgqebvRA5d+I41RmYF7lgYGreW5B5Oo=;
        b=HWHeSlD+bRrqz9pxH8zs4BPVKMRGiyiItwL4qVRoU1ARneS9ATpZ5x91Nk/co4wjKG
         di9oGbC/65CHQsHc/4ASL73QX/eJSCWxZ5KTzm0Fw7H0OK4/X+tsGfsxg8mUAtZL40Ag
         tDVVhRSAPHo1jiPwWhTBUupeuTS9jsjCy0OQR9tG4+dfqSc34IOJujEvaFS++zsmv+ka
         hnhrUEhgQIk7zIs+qH8xFxPH0iSVOc26WG7XiSv+6haF3q/qeHLfgUM4YBLZ8/htHwDW
         /nrbNudBuoFM9vIuI5U+JX0ZgjLP5ScNal7DJLaNeXTmMREI1Q6Ce9ifZyxCO308zFi4
         Sp/g==
X-Gm-Message-State: AHQUAuYXBw9ZTDHYXL8uwNXf8g0ZEJZuylI9zUnzA6wffv4c9SBH7/Fl
        LjCQT03LaDfSYqsykJriunrtE7V8
X-Google-Smtp-Source: AHgI3IY4HBrSQJs0ZrjM1+PaWlRlKLoFb/SwIyoG3xTfnRJWOv0DWFXPAwC3cQ0LfMN4WOUG4Hxm8A==
X-Received: by 2002:a63:4187:: with SMTP id o129mr10140345pga.370.1549476979054;
        Wed, 06 Feb 2019 10:16:19 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b10sm9590763pfj.183.2019.02.06.10.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:16:18 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:16:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Andi Shyti <andi@etezian.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tm2-touchkey - acknowledge that setting brightness is
 a blocking call
Message-ID: <20190206181616.GA204279@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to access I2C bus when switching brightness, and that may block,
therefore we have to set stmfts_brightness_set() as LED's
brightness_set_blocking() method.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 7dbef96559d2..d4455f3a5cf1 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -78,7 +78,7 @@ static struct touchkey_variant aries_touchkey_variant = {
 	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
-static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
+static int tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 					    enum led_brightness brightness)
 {
 	struct tm2_touchkey_data *touchkey =
@@ -97,9 +97,8 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 	if (!touchkey->variant->fixed_regulator)
 		regulator_set_voltage(touchkey->vdd, volt, volt);
 
-	if (touchkey->variant->no_reg)
-		i2c_smbus_write_byte(touchkey->client, data);
-	else
+	return touchkey->variant->no_reg ?
+		i2c_smbus_write_byte(touchkey->client, data) :
 		i2c_smbus_write_byte_data(touchkey->client,
 					  touchkey->variant->base_reg, data);
 }
@@ -270,7 +269,8 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
 	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
-	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
+	touchkey->led_dev.brightness_set_blocking =
+					tm2_touchkey_led_brightness_set;
 
 	error = devm_led_classdev_register(&client->dev, &touchkey->led_dev);
 	if (error) {
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
