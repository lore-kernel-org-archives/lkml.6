Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2EE2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIYVKC31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBKWrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:47:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34069 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfBKWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:47:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so271351plz.1;
        Mon, 11 Feb 2019 14:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bCZCLtVssEnG38hPPdrJGVHjNG+RThW87Il1S53QctI=;
        b=sIYVKC31+V1BuTEvECF3eYJXTdV5P5JyJJE1eCnKznJAmZtqKxsRs4aQEvRQuRLYhJ
         Ehg5thX9qIbdjI3ara8qSKO7h6HnJVvGKNce5xjcZog8Wx6gezVLQ1aBVB6EixrpJ6DF
         qssZ52Htr8GNhNbMCv40qJbJ79L2KHDBvRR0xOnlgBXVEE/Be8HAFaxbZRuEtN1nXieI
         7/h5IZ9mXT66hyFdiDOZRSsCtk5yHB1uYoSr+pv5krO1Stux1vMDvvYYUn5ct9Fuh/36
         Zr+0OESobI9KJq39gqAUKOEU7FM3BiHTUnEHDREASrQtmP7lJF4DiAzJLBWtbkFFam0k
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bCZCLtVssEnG38hPPdrJGVHjNG+RThW87Il1S53QctI=;
        b=aKFkRbxw0KRtBPoKRhGZCG8awC2qp6dLRPBjw8NPWd7kSeS7kD0VmS3H5C4/WIWAsq
         OhdRrSL8aPQLvp/NNa7IJVJnLut4bKNcDYirK/6sAW07bYXIUBjltzACmHGLKP5VguMj
         K5BhnUfVw5LJAtIO1K2G1+XAwwobrJn1+3UMZntmDN50bExSKCZvE5ChIPOMv7qFjMDf
         DRcALw0onFQZ699v0/YnuCXGYKyx7NbMCtukT/dfdNN87j7z8Algn5Nb0fJcqQK+o0vI
         ZLFeFzTx/wlKRDMrU8u9OLmKXI2wxojaABnG7ACdOTJrSeA18vEqJO+XNqfEh0qS2sWs
         Y3Kg==
X-Gm-Message-State: AHQUAub0b14wK7lHQCPLP1vZhUjZhd8d46Bd1ARmkPoXIK41uJct/42Y
        KUC0nV/sX/eSZdrGvUjKGjUy/ZSg
X-Google-Smtp-Source: AHgI3IYbSejZZ+wtJ2Kj+PK80wkaJfoA9c61mO4KtnyE2eZyhR+f3phOqKAI4qqp2lPu7KwyuU3jCg==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr647152plu.127.1549925251793;
        Mon, 11 Feb 2019 14:47:31 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u70sm19477291pfa.176.2019.02.11.14.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:47:31 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:47:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: apanel - switch to using brightness_set_blocking()
Message-ID: <20190211224729.GA199018@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work item. As a bonus, we are no longer
forgetting to cancel it when we unbind the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
v2: get rid of led_bits member (Sven)

 drivers/input/misc/apanel.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 094bddf56755..c1e66f45d552 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/input-polldev.h>
 #include <linux/i2c.h>
-#include <linux/workqueue.h>
 #include <linux/leds.h>
 
 #define APANEL_NAME	"Fujitsu Application Panel"
@@ -59,8 +58,6 @@ struct apanel {
 	struct i2c_client *client;
 	unsigned short keymap[MAX_PANEL_KEYS];
 	u16    nkeys;
-	u16    led_bits;
-	struct work_struct led_work;
 	struct led_classdev mail_led;
 };
 
@@ -109,25 +106,13 @@ static void apanel_poll(struct input_polled_dev *ipdev)
 			report_key(idev, ap->keymap[i]);
 }
 
-/* Track state changes of LED */
-static void led_update(struct work_struct *work)
-{
-	struct apanel *ap = container_of(work, struct apanel, led_work);
-
-	i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
-}
-
-static void mail_led_set(struct led_classdev *led,
+static int mail_led_set(struct led_classdev *led,
 			 enum led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
+	u16 led_bits = value != LED_OFF ? 0x8000 : 0x0000;
 
-	if (value != LED_OFF)
-		ap->led_bits |= 0x8000;
-	else
-		ap->led_bits &= ~0x8000;
-
-	schedule_work(&ap->led_work);
+	return i2c_smbus_write_word_data(ap->client, 0x10, led_bits);
 }
 
 static int apanel_remove(struct i2c_client *client)
@@ -179,7 +164,7 @@ static struct apanel apanel = {
 	},
 	.mail_led = {
 		.name = "mail:blue",
-		.brightness_set = mail_led_set,
+		.brightness_set_blocking = mail_led_set,
 	},
 };
 
@@ -235,7 +220,6 @@ static int apanel_probe(struct i2c_client *client,
 	if (err)
 		goto out3;
 
-	INIT_WORK(&ap->led_work, led_update);
 	if (device_chip[APANEL_DEV_LED] != CHIP_NONE) {
 		err = led_classdev_register(&client->dev, &ap->mail_led);
 		if (err)
-- 
2.20.1.791.gb4d0f1c61a-goog


-- 
Dmitry
