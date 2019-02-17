Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D8D21B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gozDVM2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfBQJO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:14:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42504 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbfBQJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:14:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so1232193pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MaBbem7EOSDQZkBwVKyj6IqtqFXAHgbLHZFaAWD/vYo=;
        b=gozDVM2k3uvO0y910fROCg6L+V9pCNwENWT7ssgaB160Mk8hnaeQMLQkNSat4gr0z7
         Flx6C1R1Gdmf1JUBxrFoePo2qIIjrU1XiblFpbwvGygyHf1Qkl02D1ZM2UzkOUY6Xx/C
         H6eM9Xs/2zCv4XYj9UUSKSOKuoTU2AJNAzdgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MaBbem7EOSDQZkBwVKyj6IqtqFXAHgbLHZFaAWD/vYo=;
        b=CBOEZKrYi3xOrJfIDvMNyxHh2VYkhvisbnezJs9Pz6KLQeydyTAqi2in687fCewOfF
         rIgpDpKXQW5pQR1kdzH+dqHNaqKWUQL+GHGcw07zyq7xCREpEWPX9rhbWwX0/zA4ebaI
         90x92+sKRL2hrOQnJjssoZv64tzTOojMFjl6PwoX6IsMEhyFxMS9Rd1mldPlmOO76xFU
         JukFvLzNJ2g4+aXIKzzHf/YcifaPcVRnIa3hpTg+/KmHiHIGHdSpNcwQbWW8UyMkPNab
         bp3dx0EyEP0Wtfz1/31FcektLvCMksnjne61WHUOI7WGG+1QaFiFBVlW9kMd9xaxksJG
         59kw==
X-Gm-Message-State: AHQUAuZ5eQG6GaLWR8lLnT0JoQbUzmm5sEvPHr6VyGOCOOquTDZbmFmo
        iLniboabqV+sQm0gHhKVIRCoPA==
X-Google-Smtp-Source: AHgI3Ib+MJilqFAW+bHbGfaSFOgT7JpxVSPX1Wvu7wQrD3mnJjmWTCyaS87aL1YKirwkNPhc4DXIbg==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr11314658pfh.21.1550394894955;
        Sun, 17 Feb 2019 01:14:54 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm5565924pfa.75.2019.02.17.01.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 01:14:54 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 2/4] Input: goodix - Add regulators support
Date:   Sun, 17 Feb 2019 14:44:34 +0530
Message-Id: <20190217091436.3702-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Support them via regulator bulk calls.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..294456a53fe0 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -40,6 +41,15 @@ struct goodix_chip_data {
 	int (*check_config)(struct goodix_ts_data *, const struct firmware *);
 };
 
+static const char * const goodix_supply_names[] = {
+	"AVDD28",
+	"AVDD22",
+	"DVDD12",
+	"VDDIO",
+};
+
+#define GOODIX_NUM_SUPPLIES	ARRAY_SIZE(goodix_supply_names)
+
 struct goodix_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
@@ -47,6 +57,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator_bulk_data supplies[GOODIX_NUM_SUPPLIES];
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -761,11 +772,18 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	complete_all(&ts->firmware_loading_complete);
 }
 
+static void goodix_disable_regulator(void *arg)
+{
+	struct goodix_ts_data *ts = arg;
+
+	regulator_bulk_disable(GOODIX_NUM_SUPPLIES, ts->supplies);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
 	struct goodix_ts_data *ts;
-	int error;
+	int error, i;
 
 	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
 
@@ -786,25 +804,49 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	for (i = 0; i < GOODIX_NUM_SUPPLIES; i++)
+		ts->supplies[i].supply = goodix_supply_names[i];
+
+	error = devm_regulator_bulk_get(&client->dev, GOODIX_NUM_SUPPLIES,
+					ts->supplies);
+	if (error) {
+		dev_err(&client->dev, "Failed to get regulators (ret=%d)\n",
+			error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&client->dev,
+					 goodix_disable_regulator, ts);
+	if (error)
+		return error;
+
+	/* power the controller */
+	error = regulator_bulk_enable(GOODIX_NUM_SUPPLIES, ts->supplies);
+	if (error) {
+		dev_err(&client->dev, "Failed to enable regulators (ret=%d)\n",
+			error);
+		return error;
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
 		if (error) {
 			dev_err(&client->dev, "Controller reset failed.\n");
-			return error;
+			goto error;
 		}
 	}
 
 	error = goodix_i2c_test(client);
 	if (error) {
 		dev_err(&client->dev, "I2C communication failure: %d\n", error);
-		return error;
+		goto error;
 	}
 
 	error = goodix_read_version(ts);
 	if (error) {
 		dev_err(&client->dev, "Read version failed.\n");
-		return error;
+		goto error;
 	}
 
 	ts->chip = goodix_get_chip_data(ts->id);
@@ -823,17 +865,21 @@ static int goodix_ts_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"Failed to invoke firmware loader: %d\n",
 				error);
-			return error;
+			goto error;
 		}
 
 		return 0;
 	} else {
 		error = goodix_configure_dev(ts);
 		if (error)
-			return error;
+			goto error;
 	}
 
 	return 0;
+
+error:
+	regulator_bulk_disable(GOODIX_NUM_SUPPLIES, ts->supplies);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
-- 
2.18.0.321.gffc6fa0e3

