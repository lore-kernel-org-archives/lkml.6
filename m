Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F01218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIOqdQ4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfAYRvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:51:31 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45261 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbfAYRuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so7518716lfa.12;
        Fri, 25 Jan 2019 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mdcWJxzksVATppwqbwI/hcPn8CHwTYbubmN30c+0kzs=;
        b=ZIOqdQ4nEKXudrs3ns2vSN5FkXUfjNQexPUrxf+F69O1K0aPkDY2Or6BFgx+ooYd+q
         vOWU6BuIUn/7FMOaDrgRB4NjU/3auJFCI4jZfvcbb/OKlY4Wche2hOJfdy2ZTRD2atly
         iLS0Fq+glZRvafcuLtZtHfnuxweZT4sOB48FePh9cj5dsG1FeQpPSZ+SYfi2WpM39i1s
         F3FY+XRe4qdt5w3RdRfMlLymLIal890sQO42wUwOL9N69jBKVRB3oC1+pfL2SNjgoqNC
         RF3AcvEPiQN/N19zzrFIfukxJwbE+qgU3JM8v3lh4TV3bU79EZD7ykHyadfIjmCjC64n
         r59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mdcWJxzksVATppwqbwI/hcPn8CHwTYbubmN30c+0kzs=;
        b=Bp+l0eGPESxHYZGoZY6eMloWzOJnjLIM77r61MNOvXYSNAT3tiF87mu+tQOeoR+Pmb
         w9EuXgJhxk+xPbSknClMl7x5gbycNnSPFYamwP6lg0w0WkdEMDVWIxC5ga+bgf38iNZq
         +Gs+ZuR14KcXSt0bEBU7TFLZU+uhs7YFgv6gh1haJohYfEc19F/THplqfy37HKLIom7P
         YmIs4cRamjOqHflmZ8TPzmXBxVza6oczlvIW+ezOOEYPUZa4kc2of3S9uJOMdznSW+4D
         RNlbRPqmZUV1rRsWQm1ztzxwoO5y6EIWPu3u0OMDi4Ya523PaFGt5vCIoGtblHn+Z4uW
         ISfw==
X-Gm-Message-State: AJcUukeIymqckfdJqCH8WTdhTzjKx1h0DNd2I93rGE9mhQWCr3yDlNCX
        Bnoj8K0IJamTfDaVxDyqL0Q=
X-Google-Smtp-Source: ALg8bN4kbOp/qU4cpBt7mIikPndzHszbQnHXSbZ2K1orKXrsFLiiRuWcshuQlfxLrxWx5Lm0onI2Bw==
X-Received: by 2002:a19:1f54:: with SMTP id f81mr9472210lff.153.1548438652020;
        Fri, 25 Jan 2019 09:50:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1575606ljj.48.2019.01.25.09.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:50:51 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/4] input: misc: gp2a: Add support for light sensor
Date:   Fri, 25 Jan 2019 18:50:43 +0100
Message-Id: <20190125175045.22576-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The gp2a driver previously only supported the proximity part of the
sensor while the hardware supports both.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/Kconfig         |  2 +
 drivers/input/misc/gp2ap002a00f.c  | 71 +++++++++++++++++++++++++++++-
 include/linux/input/gp2ap002a00f.h |  4 ++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ca59a2be9bc5..a532efb4e6d8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -252,6 +252,8 @@ config INPUT_GP2A
 	tristate "Sharp GP2AP002A00F I2C Proximity/Opto sensor driver"
 	depends on I2C
 	depends on GPIOLIB || COMPILE_TEST
+	depends on IIO
+	select INPUT_POLLDEV
 	help
 	  Say Y here if you have a Sharp GP2AP002A00F proximity/als combo-chip
 	  hooked to an I2C bus.
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 79c8c4c56d1a..090c8c313295 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -10,9 +10,12 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/input-polldev.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
@@ -20,7 +23,9 @@
 #include <linux/input/gp2ap002a00f.h>
 
 struct gp2a_data {
+	struct iio_channel *channel;
 	struct input_dev *input;
+	struct input_polled_dev *poll_dev;
 	const struct gp2a_platform_data *pdata;
 	struct i2c_client *i2c_client;
 };
@@ -58,6 +63,19 @@ static irqreturn_t gp2a_irq(int irq, void *handle)
 	return IRQ_HANDLED;
 }
 
+static void gp2a_poll(struct input_polled_dev *dev)
+{
+	struct gp2a_data *dt = dev->private;
+	int ret, value;
+
+	ret = iio_read_channel_processed(dt->channel, &value);
+	if (ret < 0)
+		dev_err(&dt->i2c_client->dev, "failed to read value!");
+
+	input_report_abs(dev->input, ABS_MISC, value);
+	input_sync(dev->input);
+}
+
 static int gp2a_enable(struct gp2a_data *dt)
 {
 	return i2c_smbus_write_byte_data(dt->i2c_client, GP2A_ADDR_OPMOD,
@@ -127,7 +145,7 @@ static int gp2a_probe(struct i2c_client *client,
 {
 	const struct gp2a_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct gp2a_data *dt;
-	int error;
+	int error, value;
 
 	if (!pdata)
 		return -EINVAL;
@@ -152,6 +170,49 @@ static int gp2a_probe(struct i2c_client *client,
 	dt->pdata = pdata;
 	dt->i2c_client = client;
 
+	dt->channel = devm_iio_channel_get(&client->dev, "light");
+	if (!IS_ERR(dt->channel)) {
+		if (!dt->channel->indio_dev) {
+			error = -ENXIO;
+			goto err_hw_shutdown;
+		}
+
+		if (dt->pdata->light_adc_max <= 0 ||
+			dt->pdata->light_adc_fuzz <= 0) {
+			error = -EINVAL;
+			goto err_hw_shutdown;
+		}
+
+		dt->poll_dev = devm_input_allocate_polled_device(&client->dev);
+		if (!dt->poll_dev) {
+			dev_err(&client->dev,
+				"failed to allocate polled input device");
+			error = -ENOMEM;
+			goto err_hw_shutdown;
+		}
+
+		if (!device_property_read_u32(&client->dev, "poll-interval",
+					      &value))
+			dt->poll_dev->poll_interval = value;
+
+		dt->poll_dev->poll = gp2a_poll;
+		dt->poll_dev->private = dt;
+
+		dt->poll_dev->input->name = GP2A_I2C_NAME;
+
+		input_set_capability(dt->poll_dev->input, EV_ABS, ABS_MISC);
+		input_set_abs_params(dt->poll_dev->input, ABS_MISC, 0,
+				     dt->pdata->light_adc_max,
+				     dt->pdata->light_adc_fuzz, 0);
+
+		error = input_register_polled_device(dt->poll_dev);
+		if (error)
+			goto err_hw_shutdown;
+	} else if (PTR_ERR(dt->channel) == -EPROBE_DEFER) {
+		error = -EPROBE_DEFER;
+		goto err_hw_shutdown;
+	}
+
 	error = gp2a_initialize(dt);
 	if (error < 0)
 		goto err_hw_shutdown;
@@ -203,6 +264,8 @@ static int gp2a_remove(struct i2c_client *client)
 	const struct gp2a_platform_data *pdata = dt->pdata;
 
 	input_unregister_device(dt->input);
+	if (dt->poll_dev)
+		input_unregister_polled_device(dt->poll_dev);
 
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
@@ -243,6 +306,12 @@ static int __maybe_unused gp2a_resume(struct device *dev)
 		mutex_unlock(&dt->input->mutex);
 	}
 
+	if (dt->poll_dev) {
+		/* Out of range value so real value goes through next */
+		input_abs_set_val(dt->poll_dev->input, ABS_MISC,
+				  -dt->pdata->light_adc_max);
+	}
+
 	return retval;
 }
 
diff --git a/include/linux/input/gp2ap002a00f.h b/include/linux/input/gp2ap002a00f.h
index 3614a13a8297..0212948897b4 100644
--- a/include/linux/input/gp2ap002a00f.h
+++ b/include/linux/input/gp2ap002a00f.h
@@ -12,12 +12,16 @@
  * @wakeup: Set to true if the proximity can wake the device from suspend
  * @hw_setup: Callback for setting up hardware such as gpios and vregs
  * @hw_shutdown: Callback for properly shutting down hardware
+ * @light_adc_max: Maximum adc value the light sensor will read
+ * @light_adc_fuzz: Fuzz value for light adc sensor
  */
 struct gp2a_platform_data {
 	int vout_gpio;
 	bool wakeup;
 	int (*hw_setup)(struct i2c_client *client);
 	int (*hw_shutdown)(struct i2c_client *client);
+	int light_adc_max;
+	int light_adc_fuzz;
 };
 
 #endif
-- 
2.17.1

