Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA8C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E382177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V74Sk8nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfBSKQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:16:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBSKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:16:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so10024199pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dvm7bD37UxENPIb3CxBZhvUUjAINwkuHpa0t8QKOOyU=;
        b=V74Sk8nPzpRuIM9hMhWz8A6Pk+kksIHNzegNNBSqj9Xte5idsU/oowu7blb27RyBdV
         OOzPCwtX+SwTAyrNxp/GqPxoSx6ho3KGl0ROQX/ibt4Q1kyiBeOVUmXmwwH8AV9DfIJC
         IfDk9k36LN+SMrr9IIWqpMDLhqbSV/4KDTy7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dvm7bD37UxENPIb3CxBZhvUUjAINwkuHpa0t8QKOOyU=;
        b=AFB4pWreQFM5Z1VvhGYp1kolH3n4OX79ENk3YqAbmRqn2JCYKMAgdxesWrd4Rf8gFy
         x/x95NeIxNFB5FZ9dnWtZmsr/Pk+YPPNq6ASmLE/PpP5DzbXKm+7zelc50zfJC8+e4O7
         qfsocHShz5kCX8h7x9+JyBjF7pFMYQ4qAUreGj0Y6qKi+w4L2tKqxSZAYWEBSniM4xUD
         t+kkdxdNoyTBSOrJjUgBebqUUf8FD8MVoFdx28A1QyfSc+F2UtsFGXJ/GdhtPpK1qbg1
         EYAdoMjDXM+LSHpBMdkJ2bVY4w2x5Ze8jlZ6ZIkDeXD/FeH3IOs3FNu0X3N/PNnwYTIw
         RyjA==
X-Gm-Message-State: AHQUAuYqlbIENy9VYeWQlSXiFCsOku3+eWsj8PwQm4TQaRkMXzL90PXZ
        qB0z3sVQ83BxfGoMemALYRuL7w==
X-Google-Smtp-Source: AHgI3IbM9/oPdEbZ9Ab4p/1GXgJhLqPQSGkg5xrfvZ47xEe2pkHkw+lYM5n9jg7PAoCE0qXwRoCsIw==
X-Received: by 2002:a63:1c42:: with SMTP id c2mr22987546pgm.265.1550571410859;
        Tue, 19 Feb 2019 02:16:50 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g10sm21324011pgo.64.2019.02.19.02.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:16:50 -0800 (PST)
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
Subject: [PATCH v6 2/4] Input: goodix - Add regulators suppot
Date:   Tue, 19 Feb 2019 15:46:27 +0530
Message-Id: <20190219101629.15977-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix CTP controllers require AVDD28, VDDIO regulators for power-on
sequence.

The delay between these regualtor operations as per Power-on Timing
from datasheet[1] is 0 (T1 >= 0 usec).

So, enable and disable these regulators in proper order using normal
regulator functions without any delay in between.

[1] GT5663 Datasheet_English_20151106_Rev.01

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f2d9c2c41885..5f9e755c5bc7 100644
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
@@ -47,6 +48,8 @@ struct goodix_ts_data {
 	struct touchscreen_properties prop;
 	unsigned int max_touch_num;
 	unsigned int int_trigger_type;
+	struct regulator *avdd28;
+	struct regulator *vddio;
 	struct gpio_desc *gpiod_int;
 	struct gpio_desc *gpiod_rst;
 	u16 id;
@@ -531,6 +534,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 		return -EINVAL;
 	dev = &ts->client->dev;
 
+	ts->avdd28 = devm_regulator_get(dev, "AVDD28");
+	if (IS_ERR(ts->avdd28)) {
+		error = PTR_ERR(ts->avdd28);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to get AVDD28 regulator: %d\n", error);
+		return error;
+	}
+
+	ts->vddio = devm_regulator_get(dev, "VDDIO");
+	if (IS_ERR(ts->vddio)) {
+		error = PTR_ERR(ts->vddio);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev,
+				"Failed to get VDDIO regulator: %d\n", error);
+		return error;
+	}
+
 	/* Get the interrupt GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
@@ -761,6 +782,17 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
 	complete_all(&ts->firmware_loading_complete);
 }
 
+static void goodix_disable_regulator(void *arg)
+{
+	struct goodix_ts_data *ts = arg;
+
+	if (!IS_ERR(ts->vddio))
+		regulator_disable(ts->vddio);
+
+	if (!IS_ERR(ts->avdd28))
+		regulator_disable(ts->avdd28);
+}
+
 static int goodix_ts_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -786,6 +818,32 @@ static int goodix_ts_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	error = devm_add_action_or_reset(&client->dev,
+					 goodix_disable_regulator, ts);
+	if (error)
+		return error;
+
+	/* power the controller */
+	if (!IS_ERR(ts->avdd28)) {
+		error = regulator_enable(ts->avdd28);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to enable AVDD28 regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
+	if (!IS_ERR(ts->vddio)) {
+		error = regulator_enable(ts->vddio);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to enable VDDIO regulator: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	if (ts->gpiod_int && ts->gpiod_rst) {
 		/* reset the controller */
 		error = goodix_reset(ts);
-- 
2.18.0.321.gffc6fa0e3

