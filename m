Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D03B8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D372087E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUcc2oO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D372087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935928AbeFMWUv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:20:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39372 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935060AbeFMWUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:20:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so1934307pgc.6;
        Wed, 13 Jun 2018 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olZyJE7JtFdgkVw68gX+gLKD/adFLvepswQyMDrNi6Q=;
        b=qUcc2oO1NVqahuzYjmMOzlBJxBrcDudTWlQPw2LHD5kSqamkns3dnqi8OJ9rf2D0vR
         z1kkaF770WjZiu/EdPHS5cqAaYu5HAo+zv1x5HXqPoAwxe8knUMUE4WQf9xeUBLzmha6
         /rI2d2ZoIPJwURTurp819L3EZoX8DJvQQ4YMNYwPcMA+cEfBOmhYafwakZ69S8//PKD2
         FhZZPDjQPGLzcHoCTjqjAtEJNecT85NAdPbbDLK4FJM81D9iuz4lsuVf0Ad0kjhfJDcY
         ZASjuGRUh6j98/MbW5BqLPIWc/aVZt4oW8iXsfmsyPMSCLyEOzgkZ954mFX0lh/YuJ85
         sLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olZyJE7JtFdgkVw68gX+gLKD/adFLvepswQyMDrNi6Q=;
        b=K/xW3wydwXaGpQRlWvqFYQ4mxMi1G3HEx+RmzpwVLyVDMzlAAtOMZY9HgimhGc0P7s
         tOmjYLjtCLPW8ro0jPxCStnwcokdRswfYTVQ+Eo+q/vcmiGVPNk/rdjGJANQcg8cs6Qh
         8bmuxeeiCszqK6+RN/nlCcRPNAHqefKBUGeDhwZsJP7doOx9/wnWd9Qo/onm9nq03cXp
         Q9Q9BsfAykgs7cbvssa4IPNsTs/wLrIS2IBE0S7pCaazjgrKJmCDyEeZUaeyrXaJDAh/
         knVtkpVAh7ulaNIeH8yw9RuVUBIvWd94/c0PIk16WUas3tibEp9TzShtLLFubLmy7cUC
         hQPw==
X-Gm-Message-State: APt69E0xr71/sMjEzUrTzZx4+4xaZ0SX1fWaRgPhrTXWMgUEOlIGk9bK
        nG1C/r+fHPEzo2lx/OdEK/k=
X-Google-Smtp-Source: ADUXVKLfO3chzLVtfBtUPJkCzOlmTCp4akCgquRHq9W70Ba8DtXDQY9BqDZ7e6llp0UsVREMDenrWA==
X-Received: by 2002:a62:c16:: with SMTP id u22-v6mr6669085pfi.177.1528928448170;
        Wed, 13 Jun 2018 15:20:48 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id m11-v6sm9864136pfj.25.2018.06.13.15.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:20:46 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:20:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH v5] Input: add bu21029 touch driver
Message-ID: <20180613222044.GC62746@dtor-ws>
References: <73b4ea3ce1aa453681fae87b7bad5cab@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b4ea3ce1aa453681fae87b7bad5cab@de.bosch.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jun 13, 2018 at 03:27:16PM +0000, Jonas Mark (BT-FIR/ENG1) wrote:
> Hello Dmitry,
> 
> > > [PATCH v5] Input: add bu21029 touch driver
> > >
> > > Add Rohm BU21029 resistive touch panel controller support with I2C
> > > interface.
> > 
> > Is the patch ready to be pushed upstream? Is there anything I still need to do?
> 
> I would like to kindly remind you of the BU21029 touch screen driver.
> Could you please forward it to the mainline kernel?

Sorry for the delay. Could you please tell me if the patch below (shoudl
apply on top of your v5 version) works?

Thanks!

-- 
Dmitry


Input: bu - misc fixes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

- add support for VDD supply
- reset GPIO is optional - it is not necessarily wired to AP
- add OF match table
- rudimentary handling of touchscreen as wakeup source
- removed bu21029_remove() as we have ->close method so touchscreen will be
  disabled/powered down upon unregistration
- misc code rearrangements

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/bu21029.txt         |    3 
 drivers/input/touchscreen/bu21029_ts.c             |  325 ++++++++++----------
 2 files changed, 169 insertions(+), 159 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
index 030a888365dff..1aaa647cc3eaa 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
@@ -5,13 +5,14 @@ Required properties:
  - reg                     : i2c device address of the chip (0x40 or 0x41)
  - interrupt-parent        : the phandle for the gpio controller
  - interrupts              : (gpio) interrupt to which the chip is connected
- - reset-gpios             : gpio pin to reset the chip (active low)
  - rohm,x-plate-ohms       : x-plate resistance in Ohm
 
 Optional properties:
+ - reset-gpios             : gpio pin to reset the chip (active low)
  - touchscreen-size-x      : horizontal resolution of touchscreen (in pixels)
  - touchscreen-size-y      : vertical resolution of touchscreen (in pixels)
  - touchscreen-max-pressure: maximum pressure value
+ - vdd-supply              : power supply for the controoler
 
 Example:
 
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index 5a7267187e7b1..65469c8617630 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -16,6 +16,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/timer.h>
 
 /*
@@ -34,8 +35,8 @@
  * HW_IDH: high 8bits of IC's ID
  * HW_IDL: low  8bits of IC's ID
  */
-#define BU21029_HWID_REG (0x0E << 3)
-#define SUPPORTED_HWID    0x0229
+#define BU21029_HWID_REG	(0x0E << 3)
+#define SUPPORTED_HWID		0x0229
 
 /*
  * CFR0 Register (PAGE=0, ADDR=0x00, Reset value=0x20)
@@ -49,8 +50,8 @@
  * INTRM: 0 = INT output depend on "pen down" (*)
  *        1 = INT output always "0"
  */
-#define BU21029_CFR0_REG (0x00 << 3)
-#define CFR0_VALUE        0x00
+#define BU21029_CFR0_REG	(0x00 << 3)
+#define CFR0_VALUE		0x00
 
 /*
  * CFR1 Register (PAGE=0, ADDR=0x01, Reset value=0xA6)
@@ -65,8 +66,8 @@
  *               if AVE>SMPL, then AVE=SMPL (=3)
  * SMPL: SMPL+1 = number of conversion samples for MAV (=7)
  */
-#define BU21029_CFR1_REG (0x01 << 3)
-#define CFR1_VALUE        0xA6
+#define BU21029_CFR1_REG	(0x01 << 3)
+#define CFR1_VALUE		0xA6
 
 /*
  * CFR2 Register (PAGE=0, ADDR=0x02, Reset value=0x04)
@@ -81,8 +82,8 @@
  * TIME_ST_ADC: waiting time between application of voltage
  *              to panel and start of A/D conversion (=100us)
  */
-#define BU21029_CFR2_REG (0x02 << 3)
-#define CFR2_VALUE        0xC9
+#define BU21029_CFR2_REG	(0x02 << 3)
+#define CFR2_VALUE		0xC9
 
 /*
  * CFR3 Register (PAGE=0, ADDR=0x0B, Reset value=0x72)
@@ -102,8 +103,8 @@
  * PIDAC_OFS: dual touch detection circuit adjustment, it is not necessary
  *            to change this from initial value
  */
-#define BU21029_CFR3_REG (0x0B << 3)
-#define CFR3_VALUE        0x42
+#define BU21029_CFR3_REG	(0x0B << 3)
+#define CFR3_VALUE		0x42
 
 /*
  * LDO Register (PAGE=0, ADDR=0x0C, Reset value=0x00)
@@ -115,8 +116,8 @@
  * PVDD: output voltage of panel output regulator (=2.000V)
  * AVDD: output voltage of analog circuit regulator (=2.000V)
  */
-#define BU21029_LDO_REG  (0x0C << 3)
-#define LDO_VALUE         0x77
+#define BU21029_LDO_REG		(0x0C << 3)
+#define LDO_VALUE		0x77
 
 /*
  * Serial Interface Command Byte 1 (CID=1)
@@ -132,7 +133,7 @@
  *      1 = keep power on after convert function stops
  * STP: 1 = abort current conversion and power down, set to "0" automatically
  */
-#define BU21029_AUTOSCAN  0x80
+#define BU21029_AUTOSCAN	0x80
 
 /*
  * The timeout value needs to be larger than INTVL_TIME + tConv4 (sample and
@@ -140,40 +141,31 @@
  * tPON + tDLY1 + (tTIME_ST_ADC + (tADC * tSMPL) * 2 + tDLY2) * 3
  * see figure 8 in datasheet p15 for details of each field.
  */
-#define PEN_UP_TIMEOUT msecs_to_jiffies(50)
+#define PEN_UP_TIMEOUT_MS	50
 
-#define STOP_DELAY_MIN_US 50
-#define STOP_DELAY_MAX_US 1000
-#define START_DELAY_MS    2
-#define BUF_LEN           8
-#define SCALE_12BIT       (1 << 12)
-#define MAX_12BIT         ((1 << 12) - 1)
-#define DRIVER_NAME       "bu21029"
+#define STOP_DELAY_MIN_US	50
+#define STOP_DELAY_MAX_US	1000
+#define START_DELAY_MS		2
+#define BUF_LEN			8
+#define SCALE_12BIT		(1 << 12)
+#define MAX_12BIT		((1 << 12) - 1)
+#define DRIVER_NAME		"bu21029"
 
 struct bu21029_ts_data {
-	struct i2c_client            *client;
-	struct input_dev             *in_dev;
-	struct timer_list             timer;
-	struct gpio_desc             *reset_gpios;
-	u32                           x_plate_ohms;
-	struct touchscreen_properties prop;
+	struct i2c_client		*client;
+	struct input_dev		*in_dev;
+	struct timer_list		timer;
+	struct regulator		*vdd;
+	struct gpio_desc		*reset_gpios;
+	u32				x_plate_ohms;
+	struct touchscreen_properties	prop;
 };
 
-static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
+static void bu21029_touch_report(struct bu21029_ts_data *bu21029, const u8 *buf)
 {
-	struct i2c_client *i2c = bu21029->client;
-	u8 buf[BUF_LEN];
 	u16 x, y, z1, z2;
 	u32 rz;
-	s32 max_pressure = bu21029->in_dev->absinfo[ABS_PRESSURE].maximum;
-
-	/* read touch data and deassert INT (by restarting the autoscan mode) */
-	int error = i2c_smbus_read_i2c_block_data(i2c,
-						  BU21029_AUTOSCAN,
-						  BUF_LEN,
-						  buf);
-	if (error < 0)
-		return error;
+	s32 max_pressure = input_abs_get_max(bu21029->in_dev, ABS_PRESSURE);
 
 	/*
 	 * compose upper 8 and lower 4 bits into a 12bit value:
@@ -190,31 +182,28 @@ static int bu21029_touch_report(struct bu21029_ts_data *bu21029)
 	z1 = (buf[4] << 4) | (buf[5] >> 4);
 	z2 = (buf[6] << 4) | (buf[7] >> 4);
 
-	if (z1 == 0 || z2 == 0)
-		return 0;
-
-	/*
-	 * calculate Rz (pressure resistance value) by equation:
-	 * Rz = Rx * (x/Q) * ((z2/z1) - 1), where
-	 * Rx is x-plate resistance,
-	 * Q  is the touch screen resolution (8bit = 256, 12bit = 4096)
-	 * x, z1, z2 are the measured positions.
-	 */
-	rz  = z2 - z1;
-	rz *= x;
-	rz *= bu21029->x_plate_ohms;
-	rz /= z1;
-	rz  = DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
-	if (rz <= max_pressure) {
-		touchscreen_report_pos(bu21029->in_dev, &bu21029->prop,
-				       x, y, false);
-		input_report_abs(bu21029->in_dev, ABS_PRESSURE,
-				 max_pressure - rz);
-		input_report_key(bu21029->in_dev, BTN_TOUCH, 1);
-		input_sync(bu21029->in_dev);
+	if (z1 && z2) {
+		/*
+		 * calculate Rz (pressure resistance value) by equation:
+		 * Rz = Rx * (x/Q) * ((z2/z1) - 1), where
+		 * Rx is x-plate resistance,
+		 * Q  is the touch screen resolution (8bit = 256, 12bit = 4096)
+		 * x, z1, z2 are the measured positions.
+		 */
+		rz  = z2 - z1;
+		rz *= x;
+		rz *= bu21029->x_plate_ohms;
+		rz /= z1;
+		rz  = DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
+		if (rz <= max_pressure) {
+			touchscreen_report_pos(bu21029->in_dev, &bu21029->prop,
+					       x, y, false);
+			input_report_abs(bu21029->in_dev, ABS_PRESSURE,
+					 max_pressure - rz);
+			input_report_key(bu21029->in_dev, BTN_TOUCH, 1);
+			input_sync(bu21029->in_dev);
+		}
 	}
-
-	return 0;
 }
 
 static void bu21029_touch_release(struct timer_list *t)
@@ -229,32 +218,34 @@ static void bu21029_touch_release(struct timer_list *t)
 static irqreturn_t bu21029_touch_soft_irq(int irq, void *data)
 {
 	struct bu21029_ts_data *bu21029 = data;
+	u8 buf[BUF_LEN];
+	int error;
 
 	/*
-	 * report touch and deassert interrupt (will assert again after
+	 * Read touch data and deassert interrupt (will assert again after
 	 * INTVL_TIME + tConv4 for continuous touch)
 	 */
-	int error = bu21029_touch_report(bu21029);
+	error = i2c_smbus_read_i2c_block_data(bu21029->client, BU21029_AUTOSCAN,
+					      sizeof(buf), buf);
+	if (error < 0)
+		goto out;
 
-	if (error)
-		return IRQ_NONE;
+	bu21029_touch_report(bu21029, buf);
 
 	/* reset timer for pen up detection */
-	mod_timer(&bu21029->timer, jiffies + PEN_UP_TIMEOUT);
+	mod_timer(&bu21029->timer,
+		  jiffies + msecs_to_jiffies(PEN_UP_TIMEOUT_MS));
 
+out:
 	return IRQ_HANDLED;
 }
 
-static void bu21029_stop_chip(struct input_dev *dev)
+static void bu21029_put_chip_in_reset(struct bu21029_ts_data *bu21029)
 {
-	struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
-
-	disable_irq(bu21029->client->irq);
-	del_timer_sync(&bu21029->timer);
-
-	/* put chip into reset */
-	gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
-	usleep_range(STOP_DELAY_MIN_US, STOP_DELAY_MAX_US);
+	if (bu21029->reset_gpios) {
+		gpiod_set_value_cansleep(bu21029->reset_gpios, 1);
+		usleep_range(STOP_DELAY_MIN_US, STOP_DELAY_MAX_US);
+	}
 }
 
 static int bu21029_start_chip(struct input_dev *dev)
@@ -274,23 +265,30 @@ static int bu21029_start_chip(struct input_dev *dev)
 	int error, i;
 	__be16 hwid;
 
+	error = regulator_enable(bu21029->vdd);
+	if (error) {
+		dev_err(&i2c->dev, "failed to power up chip: %d", error);
+		return error;
+	}
+
 	/* take chip out of reset */
-	gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
-	msleep(START_DELAY_MS);
+	if (bu21029->reset_gpios) {
+		gpiod_set_value_cansleep(bu21029->reset_gpios, 0);
+		msleep(START_DELAY_MS);
+	}
 
-	error = i2c_smbus_read_i2c_block_data(i2c,
-					      BU21029_HWID_REG,
-					      2,
-					      (u8 *)&hwid);
+	error = i2c_smbus_read_i2c_block_data(i2c, BU21029_HWID_REG,
+					      sizeof(hwid), (u8 *)&hwid);
 	if (error < 0) {
 		dev_err(&i2c->dev, "failed to read HW ID\n");
-		goto out;
+		goto err_out;
 	}
 
 	if (be16_to_cpu(hwid) != SUPPORTED_HWID) {
-		dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
+		dev_err(&i2c->dev,
+			"unsupported HW ID 0x%x\n", be16_to_cpu(hwid));
 		error = -ENODEV;
-		goto out;
+		goto err_out;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(init_table); ++i) {
@@ -299,50 +297,37 @@ static int bu21029_start_chip(struct input_dev *dev)
 						  init_table[i].value);
 		if (error < 0) {
 			dev_err(&i2c->dev,
-				"failed to write 0x%x to register 0x%x\n",
-				init_table[i].value,
-				init_table[i].reg);
-			goto out;
+				"failed to write %#02x to register %#02x: %d\n",
+				init_table[i].value, init_table[i].reg,
+				error);
+			goto err_out;
 		}
 	}
 
 	error = i2c_smbus_write_byte(i2c, BU21029_AUTOSCAN);
 	if (error < 0) {
 		dev_err(&i2c->dev, "failed to start autoscan\n");
-		goto out;
+		goto err_out;
 	}
 
 	enable_irq(bu21029->client->irq);
 	return 0;
 
-out:
-	bu21029_stop_chip(dev);
+err_out:
+	bu21029_put_chip_in_reset(bu21029);
+	regulator_disable(bu21029->vdd);
 	return error;
 }
 
-static int bu21029_parse_dt(struct bu21029_ts_data *bu21029)
+static void bu21029_stop_chip(struct input_dev *dev)
 {
-	struct device *dev = &bu21029->client->dev;
-	int error;
-
-	bu21029->reset_gpios = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bu21029->reset_gpios)) {
-		error = PTR_ERR(bu21029->reset_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "invalid 'reset-gpios':%d\n", error);
-		return error;
-	}
-
-	error = device_property_read_u32(dev, "rohm,x-plate-ohms",
-					 &bu21029->x_plate_ohms);
-	if (error) {
-		dev_err(dev, "invalid 'x-plate-ohms' supplied:%d\n", error);
-		return error;
-	}
+	struct bu21029_ts_data *bu21029 = input_get_drvdata(dev);
 
-	touchscreen_parse_properties(bu21029->in_dev, false, &bu21029->prop);
+	disable_irq(bu21029->client->irq);
+	del_timer_sync(&bu21029->timer);
 
-	return 0;
+	bu21029_put_chip_in_reset(bu21029);
+	regulator_disable(bu21029->vdd);
 }
 
 static int bu21029_probe(struct i2c_client *client,
@@ -365,6 +350,33 @@ static int bu21029_probe(struct i2c_client *client,
 	if (!bu21029)
 		return -ENOMEM;
 
+	error = device_property_read_u32(&client->dev, "rohm,x-plate-ohms",
+					 &bu21029->x_plate_ohms);
+	if (error) {
+		dev_err(&client->dev,
+			"invalid 'x-plate-ohms' supplied: %d\n", error);
+		return error;
+	}
+
+	bu21029->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(bu21029->vdd)) {
+		error = PTR_ERR(bu21029->vdd);
+		if (error != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"failed to acquire 'vdd' supply: %d\n", error);
+		return error;
+	}
+
+	bu21029->reset_gpios = devm_gpiod_get_optional(&client->dev,
+						       "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(bu21029->reset_gpios)) {
+		error = PTR_ERR(bu21029->reset_gpios);
+		if (error != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"failed to acquire 'reset' gpio: %d\n", error);
+		return error;
+	}
+
 	in_dev = devm_input_allocate_device(&client->dev);
 	if (!in_dev) {
 		dev_err(&client->dev, "unable to allocate input device\n");
@@ -372,42 +384,36 @@ static int bu21029_probe(struct i2c_client *client,
 	}
 
 	bu21029->client = client;
-	bu21029->in_dev	= in_dev;
+	bu21029->in_dev = in_dev;
 	timer_setup(&bu21029->timer, bu21029_touch_release, 0);
 
-	in_dev->name       = DRIVER_NAME;
-	in_dev->id.bustype = BUS_I2C;
-	in_dev->open       = bu21029_start_chip;
-	in_dev->close      = bu21029_stop_chip;
+	in_dev->name		= DRIVER_NAME;
+	in_dev->id.bustype	= BUS_I2C;
+	in_dev->open		= bu21029_start_chip;
+	in_dev->close		= bu21029_stop_chip;
 
 	input_set_capability(in_dev, EV_KEY, BTN_TOUCH);
 	input_set_abs_params(in_dev, ABS_X, 0, MAX_12BIT, 0, 0);
 	input_set_abs_params(in_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
 	input_set_abs_params(in_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
-
-	error = bu21029_parse_dt(bu21029);
-	if (error)
-		return error;
+	touchscreen_parse_properties(in_dev, false, &bu21029->prop);
 
 	input_set_drvdata(in_dev, bu21029);
 
-	error = devm_request_threaded_irq(&client->dev,
-					  client->irq,
-					  NULL,
-					  bu21029_touch_soft_irq,
-					  IRQF_ONESHOT,
-					  DRIVER_NAME,
-					  bu21029);
+	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, bu21029_touch_soft_irq,
+					  IRQF_ONESHOT, DRIVER_NAME, bu21029);
 	if (error) {
-		dev_err(&client->dev, "unable to request touch irq\n");
+		dev_err(&client->dev,
+			"unable to request touch irq: %d\n", error);
 		return error;
 	}
 
-	bu21029_stop_chip(in_dev);
-
 	error = input_register_device(in_dev);
 	if (error) {
-		dev_err(&client->dev, "unable to register input device\n");
+		dev_err(&client->dev,
+			"unable to register input device: %d\n", error);
 		return error;
 	}
 
@@ -416,24 +422,17 @@ static int bu21029_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int bu21029_remove(struct i2c_client *client)
-{
-	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(client);
-
-	bu21029_stop_chip(bu21029->in_dev);
-
-	return 0;
-}
-
 static int __maybe_unused bu21029_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(i2c);
 
-	mutex_lock(&bu21029->in_dev->mutex);
-	if (bu21029->in_dev->users)
-		bu21029_stop_chip(bu21029->in_dev);
-	mutex_unlock(&bu21029->in_dev->mutex);
+	if (!device_may_wakeup(dev)) {
+		mutex_lock(&bu21029->in_dev->mutex);
+		if (bu21029->in_dev->users)
+			bu21029_stop_chip(bu21029->in_dev);
+		mutex_unlock(&bu21029->in_dev->mutex);
+	}
 
 	return 0;
 }
@@ -443,29 +442,39 @@ static int __maybe_unused bu21029_resume(struct device *dev)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct bu21029_ts_data *bu21029 = i2c_get_clientdata(i2c);
 
-	mutex_lock(&bu21029->in_dev->mutex);
-	if (bu21029->in_dev->users)
-		bu21029_start_chip(bu21029->in_dev);
-	mutex_unlock(&bu21029->in_dev->mutex);
+	if (!device_may_wakeup(dev)) {
+		mutex_lock(&bu21029->in_dev->mutex);
+		if (bu21029->in_dev->users)
+			bu21029_start_chip(bu21029->in_dev);
+		mutex_unlock(&bu21029->in_dev->mutex);
+	}
 
 	return 0;
 }
 static SIMPLE_DEV_PM_OPS(bu21029_pm_ops, bu21029_suspend, bu21029_resume);
 
 static const struct i2c_device_id bu21029_ids[] = {
-	{DRIVER_NAME, 0},
-	{}
+	{ DRIVER_NAME, 0 },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, bu21029_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id bu21029_of_ids[] = {
+	{ .compatible = "rohm,bu21029" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, bu21029_of_ids);
+#endif
+
 static struct i2c_driver bu21029_driver = {
-	.driver = {
-		.name = DRIVER_NAME,
-		.pm   = &bu21029_pm_ops,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= of_match_ptr(bu21029_of_ids),
+		.pm		= &bu21029_pm_ops,
 	},
-	.id_table = bu21029_ids,
-	.probe    = bu21029_probe,
-	.remove   = bu21029_remove,
+	.id_table	= bu21029_ids,
+	.probe		= bu21029_probe,
 };
 module_i2c_driver(bu21029_driver);
 
