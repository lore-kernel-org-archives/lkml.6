Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E7BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1643B2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="evQM7WvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeLOPSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:18:36 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36193 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOPSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:18:32 -0500
Received: by mail-yw1-f67.google.com with SMTP id i73so2370851ywg.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 07:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duKzC7XIbmzTlndaKTXS3J2cZIplwvKfqW+lEcLnAYs=;
        b=evQM7WvDHyHl5fGSTI8wfMF0MVUtL2cz6E7uBIpl/mRLocsnoZoNG/BWNFKcMelVse
         pCSXMYRL00wTxKRlXOXxw8dYrzCRO/Kk9mCH3H1UJmvVXNzdFIxLWUpcBTtsnU8dbLTC
         DUwgmHRuqA0HB5CAJXV3yzHkMkzWRL1ecxcV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duKzC7XIbmzTlndaKTXS3J2cZIplwvKfqW+lEcLnAYs=;
        b=hv/a3EQyFP5JgBLGv3wWxuw1hMiPwuEMPiU7ctHZQGiOdRRlT+9SQgBt4XuC2ukf1t
         jAN7RqlOYWI7PNZ7ljRWnJgGx77ngSSdgliWzxawc7ka1N6f8MCm9DVXcy7Hii7cpMZN
         qAWVh1aY+2HxcVyk0QkNJt3lqpOXkO3gKMW6JfF0ZrJgDz7hec2BzR+81KiCSMD1QPII
         Z7oWBmO4I1vREHekvc0fijfykxi02+NdXEMT0DqJ/9VYXorbi2G6pMH1/tbv0KcD4BYb
         UaG0FbI2b1MGcRLoEx4s71EGiITRMsMlCUGc/bGZfXyUiAWdMoPhj/CENwo9XgHy+kXh
         J4DQ==
X-Gm-Message-State: AA+aEWY1K4OTvREiU4qu3D/Dc5N/dnvpVq57GHRD6Gxe1x21JS0tucJs
        eD8rYTCViLIMEdiT/qd5rQxpVw==
X-Google-Smtp-Source: AFSGD/Wi6tAd7HmjDwzb6rDJzvGE0fYLx4X4BSO1sbNxUJUmMsC65tNTm0UHMPKsvuNGTTEIO4Yqkg==
X-Received: by 2002:a81:37c3:: with SMTP id e186mr7399784ywa.506.1544887111397;
        Sat, 15 Dec 2018 07:18:31 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id x203sm2855664ywd.41.2018.12.15.07.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:18:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/4] Input: goodix - Add AVDD28-supply regulator support
Date:   Sat, 15 Dec 2018 20:48:00 +0530
Message-Id: <20181215151802.18592-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers have AVDD28 pin connected to voltage
regulator which may not be turned on by default, like for GT5663.

Add support for such ctp used boards by adding voltage regulator
handling code to goodix ctp driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..7371f6946098 100644
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
@@ -47,6 +48,7 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *avdd28;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
+	if (IS_ERR(ts->avdd28)) {
+		error = PTR_ERR(ts->avdd28);
+		if (error != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to get AVDD28 regulator: %d\n", error);
+		return error;
+	}
+
+	/* power the controller */
+	error = regulator_enable(ts->avdd28);
+	if (error) {
+		dev_err(&client->dev, "Controller fail to enable AVDD28\n");
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
@@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
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
+	regulator_disable(ts->avdd28);
+	return error;
 }
 
 static int goodix_ts_remove(struct i2c_client *client)
 {
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 
+	regulator_disable(ts->avdd28);
 	if (ts->gpiod_int && ts->gpiod_rst)
 		wait_for_completion(&ts->firmware_loading_complete);
 
-- 
2.18.0.321.gffc6fa0e3

