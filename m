Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978FC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64CA2192B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxA/F5Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBIRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:21:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36385 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfBIRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:21:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so405766pfa.3;
        Sat, 09 Feb 2019 09:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mwDTNGZBhxQ6pmkfNmueqYAGkhHuOxQ7llCcvtvJDgA=;
        b=AxA/F5RsnSb+IUXGqnQfREOSFUZOQFU0xyBxpv7XGhccdPoJD/pInTAno9K82Taqra
         b54Z/CHfaAA8M18OYXlK16bZf4KptO2V51yAoeUh6xJRiDTxx7eKo4rJtr4NVCiKwYZR
         1xBv2ooepU7scNRJmjgnfotzhF26TxCYYB3n2RisBkTuBUB2+7oVQ/s5wc63ldTiI26J
         TuNT4HGh7lnb8LC3Yq2STZ6wINLqRy96yG1xbiktpiXTH1/ciYYx3hjVvQsVmCpWjlvt
         0KaJJSDmtgzVxHGTfQ4qzg/eayfVl0uhD4tzv2tn9uIGuMa9bZjXofbUVQEF1bg2tBne
         rDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mwDTNGZBhxQ6pmkfNmueqYAGkhHuOxQ7llCcvtvJDgA=;
        b=t0rVxUhuvjCZR8A5wjMwMBq/itWJopgRplIQlHawrLmmBwJ2QX/FRPu/3yXNyxfpoI
         jlqJl87A49wcaVd2ya18qCCMIoA0w5D2XKsvISqVWXsw19YClZLt72BIYrf6zspdArF3
         6SeN4JWY13NZfG5ClPOnCC5P6TcySKtJNfloQX5hytMWX8LbCiPmlTO4RuMDqKXaPXO6
         UbVsWEYHflf+OB7QZnOc5lMSxkkhNB0ivzABHUZn4E6H/zBe/reWyQ9fIb2R5hjfnkQ5
         K71m/GbUcQdm+HibFuDg6U1xq4crbCbv72LD5YXbu+bCvoCW7/RczE4v34YoNTWntUfA
         cWxg==
X-Gm-Message-State: AHQUAuaRqQIAR6mcLKaEnOtYa0ClVP7Pn6d2183412r+sZyTn5ArC9YO
        +kwIQxNNz3QN7Y0Y5Yo0IrVIhUz6
X-Google-Smtp-Source: AHgI3IbrUG4iYtnsbYS+egBMTekbkfDn22n6XmJ2fRwnqTNjCNgVC0ZazceggBOYE+L9fI8Bq9vGGg==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr25962218pgo.221.1549732860339;
        Sat, 09 Feb 2019 09:21:00 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l2sm8023591pgn.52.2019.02.09.09.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:20:59 -0800 (PST)
Date:   Sat, 9 Feb 2019 09:20:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: qt2160 - switch to using brightness_set_blocking()
Message-ID: <20190209172058.GA24435@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work items.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/qt2160.c | 69 +++++++++++++--------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 43b86482dda0..d466bc07aebb 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -58,10 +58,9 @@ static unsigned char qt2160_key2code[] = {
 struct qt2160_led {
 	struct qt2160_data *qt2160;
 	struct led_classdev cdev;
-	struct work_struct work;
 	char name[32];
 	int id;
-	enum led_brightness new_brightness;
+	enum led_brightness brightness;
 };
 #endif
 
@@ -74,7 +73,6 @@ struct qt2160_data {
 	u16 key_matrix;
 #ifdef CONFIG_LEDS_CLASS
 	struct qt2160_led leds[QT2160_NUM_LEDS_X];
-	struct mutex led_lock;
 #endif
 };
 
@@ -83,46 +81,39 @@ static int qt2160_write(struct i2c_client *client, u8 reg, u8 data);
 
 #ifdef CONFIG_LEDS_CLASS
 
-static void qt2160_led_work(struct work_struct *work)
+static int qt2160_led_set(struct led_classdev *cdev,
+			  enum led_brightness value)
 {
-	struct qt2160_led *led = container_of(work, struct qt2160_led, work);
+	struct qt2160_led *led = container_of(cdev, struct qt2160_led, cdev);
 	struct qt2160_data *qt2160 = led->qt2160;
 	struct i2c_client *client = qt2160->client;
-	int value = led->new_brightness;
 	u32 drive, pwmen;
 
-	mutex_lock(&qt2160->led_lock);
-
-	drive = qt2160_read(client, QT2160_CMD_DRIVE_X);
-	pwmen = qt2160_read(client, QT2160_CMD_PWMEN_X);
-	if (value != LED_OFF) {
-		drive |= (1 << led->id);
-		pwmen |= (1 << led->id);
-
-	} else {
-		drive &= ~(1 << led->id);
-		pwmen &= ~(1 << led->id);
-	}
-	qt2160_write(client, QT2160_CMD_DRIVE_X, drive);
-	qt2160_write(client, QT2160_CMD_PWMEN_X, pwmen);
+	if (value != led->brightness) {
+		drive = qt2160_read(client, QT2160_CMD_DRIVE_X);
+		pwmen = qt2160_read(client, QT2160_CMD_PWMEN_X);
+		if (value != LED_OFF) {
+			drive |= BIT(led->id);
+			pwmen |= BIT(led->id);
 
-	/*
-	 * Changing this register will change the brightness
-	 * of every LED in the qt2160. It's a HW limitation.
-	 */
-	if (value != LED_OFF)
-		qt2160_write(client, QT2160_CMD_PWM_DUTY, value);
+		} else {
+			drive &= ~BIT(led->id);
+			pwmen &= ~BIT(led->id);
+		}
+		qt2160_write(client, QT2160_CMD_DRIVE_X, drive);
+		qt2160_write(client, QT2160_CMD_PWMEN_X, pwmen);
 
-	mutex_unlock(&qt2160->led_lock);
-}
+		/*
+		 * Changing this register will change the brightness
+		 * of every LED in the qt2160. It's a HW limitation.
+		 */
+		if (value != LED_OFF)
+			qt2160_write(client, QT2160_CMD_PWM_DUTY, value);
 
-static void qt2160_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
-{
-	struct qt2160_led *led = container_of(cdev, struct qt2160_led, cdev);
+		led->brightness = value;
+	}
 
-	led->new_brightness = value;
-	schedule_work(&led->work);
+	return 0;
 }
 
 #endif /* CONFIG_LEDS_CLASS */
@@ -293,20 +284,16 @@ static int qt2160_register_leds(struct qt2160_data *qt2160)
 	int ret;
 	int i;
 
-	mutex_init(&qt2160->led_lock);
-
 	for (i = 0; i < QT2160_NUM_LEDS_X; i++) {
 		struct qt2160_led *led = &qt2160->leds[i];
 
 		snprintf(led->name, sizeof(led->name), "qt2160:x%d", i);
 		led->cdev.name = led->name;
-		led->cdev.brightness_set = qt2160_led_set;
+		led->cdev.brightness_set_blocking = qt2160_led_set;
 		led->cdev.brightness = LED_OFF;
 		led->id = i;
 		led->qt2160 = qt2160;
 
-		INIT_WORK(&led->work, qt2160_led_work);
-
 		ret = led_classdev_register(&client->dev, &led->cdev);
 		if (ret < 0)
 			return ret;
@@ -324,10 +311,8 @@ static void qt2160_unregister_leds(struct qt2160_data *qt2160)
 {
 	int i;
 
-	for (i = 0; i < QT2160_NUM_LEDS_X; i++) {
+	for (i = 0; i < QT2160_NUM_LEDS_X; i++)
 		led_classdev_unregister(&qt2160->leds[i].cdev);
-		cancel_work_sync(&qt2160->leds[i].work);
-	}
 }
 
 #else
-- 
2.20.1.791.gb4d0f1c61a-goog


-- 
Dmitry
