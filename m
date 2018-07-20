Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F00820661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaUxM8Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeGTLlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:41:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32897 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeGTLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:41:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id u14-v6so1497423lfu.0;
        Fri, 20 Jul 2018 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ZgOJx5nmfCxa2XCWtgxQW6K5OK0WOME5fy/V+GQGVKY=;
        b=YaUxM8EzsNdNQQ+lZEx/+W9vjqMra6FoZu1a5wNIOzyCdwVzUXcOeCAO56azWYUI+a
         grA3QZ9pKNcsCB3uQzl6+JawhPMxvboE2h7K6hK0WvS/y8M1/V6QIDvAFNOPs/GyqETo
         cLLFFNZvDwhNEx8KqPvjA+PsLQ2oYEeqBNLtsEhfwG+uuJsWXA7rkRG0xxulCklPtQH8
         Vci0TIer8JFdJH5YvFLjB9tD4M/rLGLPnIXdMiuANtuj5DT+hVl7SdDoJqb5c9UtwHUc
         eT6CEoUauv2yXWSTFPGade6sKgmXYBR1jX6JnL5e9V2jF+ye42ACX9XCe9lbLqg8hgP4
         2BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ZgOJx5nmfCxa2XCWtgxQW6K5OK0WOME5fy/V+GQGVKY=;
        b=kF5QE+NPLGgxMJhNjEIlrSrOZ33ODIacbBBE1DN13l1d1LiFxBzxr9mDDftz4NYdEP
         uGAe+XJfjUfv4XigndPybfVaDbCpxCvC4fRTIRF+lUqqU2kY6L7+MGsFcGHrHstMnk47
         0PI9LjIWfy6/orN6cPELKaTrbfSZbqtyoq5P5gqxgIkGdrQa1yIrQ6NXLc/gM+7BBrAZ
         rjNykTv+8Q0aS8XGnYWV9FS/8fbrB9n0Titb3r6K77bPEPHXpKPaLZuUqFi36t+0V47/
         QxGhRmRhCGnyOKKef8mNJ8lBxDQYqUvLRhk6erkA/htSKGx4sB1WDRmLsdZUMFfU49JM
         F3Cg==
X-Gm-Message-State: AOUpUlE9PWbvMxhC2zRdolFonxO74dLhh2YrxhAgCydLI9sehULl3X5x
        Ith+fXBrYJH7FrVLMfJA6vY=
X-Google-Smtp-Source: AAOMgpceINjSI9Q3/B5IKucLeXgmAr4gcZsZQo65s+ub0BXYwcAHxboH2PfQh15ZUpAK0t/GRQ+rUw==
X-Received: by 2002:a19:8d07:: with SMTP id p7-v6mr1129956lfd.117.1532083998942;
        Fri, 20 Jul 2018 03:53:18 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id y16-v6sm300865lje.30.2018.07.20.03.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:53:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fgT20-0006Qw-6x; Fri, 20 Jul 2018 12:53:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karoly Pados <pados@pados.hu>,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v3] USB: serial: cp210x: Implement GPIO support for CP2102N
Date:   Fri, 20 Jul 2018 12:52:40 +0200
Message-Id: <20180720105240.24680-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karoly Pados <pados@pados.hu>

This is v2 of the patch and addresses all feedback previously
received from the maintainer. New input/output support stayed
as discussed on the e-mail lists separately. CP2105 is also
using the new code structure, but due to missing way to get
default pin states after reset from the device, support
for this device is basically still output-only as before, at
least in name. But CP2105 and CP2102N paths are unified.

This patch is based on the latest patch series by Johan just
submitted today.

Signed-off-by: Karoly Pados <pados@pados.hu>
[ johan: fix style issues and a couple of minor bugs ]
Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This is Karoly's v2 patch with some style issues and a couple of minor
bugs fixed. I'll wait for an updated commit message before applying.

Johan


 drivers/usb/serial/cp210x.c | 245 ++++++++++++++++++++++++++++++------
 1 file changed, 209 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 4a118eb13590..b9bc80700be7 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -224,9 +224,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
 struct cp210x_serial_private {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
-	u8			config;
-	u8			gpio_mode;
 	bool			gpio_registered;
+	u8			gpio_pushpull;
+	u8			gpio_altfunc;
+	u8			gpio_input;
 #endif
 	u8			partnum;
 	speed_t			max_speed;
@@ -343,6 +344,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CONTROL_WRITE_RTS	0x0200
 
 /* CP210X_VENDOR_SPECIFIC values */
+#define CP210X_READ_2NCONFIG	0x000E
 #define CP210X_READ_LATCH	0x00C2
 #define CP210X_GET_PARTNUM	0x370B
 #define CP210X_GET_PORTCONFIG	0x370C
@@ -452,6 +454,12 @@ struct cp210x_config {
 #define CP2105_GPIO1_RXLED_MODE		BIT(1)
 #define CP2105_GPIO1_RS485_MODE		BIT(2)
 
+/* CP2102N configuration array indices */
+#define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2
+#define CP210X_2NCONFIG_GPIO_MODE_IDX		581
+#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587
+#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
+
 /* CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */
 struct cp210x_gpio_write {
 	u8	mask;
@@ -1313,17 +1321,8 @@ static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 
-	switch (offset) {
-	case 0:
-		if (priv->config & CP2105_GPIO0_TXLED_MODE)
-			return -ENODEV;
-		break;
-	case 1:
-		if (priv->config & (CP2105_GPIO1_RXLED_MODE |
-				    CP2105_GPIO1_RS485_MODE))
-			return -ENODEV;
-		break;
-	}
+	if (priv->gpio_altfunc & BIT(offset))
+		return -ENODEV;
 
 	return 0;
 }
@@ -1331,10 +1330,15 @@ static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	u8 req_type = REQTYPE_DEVICE_TO_HOST;
 	int result;
 	u8 buf;
 
-	result = cp210x_read_vendor_block(serial, REQTYPE_INTERFACE_TO_HOST,
+	if (priv->partnum == CP210X_PARTNUM_CP2105)
+		req_type = REQTYPE_INTERFACE_TO_HOST;
+
+	result = cp210x_read_vendor_block(serial, req_type,
 					  CP210X_READ_LATCH, &buf, sizeof(buf));
 	if (result < 0)
 		return result;
@@ -1345,7 +1349,9 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_gpio_write buf;
+	int result;
 
 	if (value == 1)
 		buf.state = BIT(gpio);
@@ -1354,25 +1360,68 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 
 	buf.mask = BIT(gpio);
 
-	cp210x_write_vendor_block(serial, REQTYPE_HOST_TO_INTERFACE,
-				  CP210X_WRITE_LATCH, &buf, sizeof(buf));
+	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_INTERFACE,
+						   CP210X_WRITE_LATCH, &buf,
+						   sizeof(buf));
+	} else {
+		u16 wIndex = buf.state << 8 | buf.mask;
+
+		result = usb_control_msg(serial->dev,
+					 usb_sndctrlpipe(serial->dev, 0),
+					 CP210X_VENDOR_SPECIFIC,
+					 REQTYPE_HOST_TO_DEVICE,
+					 CP210X_WRITE_LATCH,
+					 wIndex,
+					 NULL, 0, USB_CTRL_SET_TIMEOUT);
+	}
+
+	if (result < 0) {
+		dev_err(&serial->interface->dev, "failed to set GPIO value: %d\n",
+				result);
+	}
 }
 
 static int cp210x_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
 {
-	/* Hardware does not support an input mode */
-	return 0;
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	return priv->gpio_input & BIT(gpio);
 }
 
 static int cp210x_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
 {
-	/* Hardware does not support an input mode */
-	return -ENOTSUPP;
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		/* hardware does not support an input mode */
+		return -ENOTSUPP;
+	}
+
+	/* push-pull pins cannot be changed to be inputs */
+	if (priv->gpio_pushpull & BIT(gpio))
+		return -EINVAL;
+
+	/* make sure to release pin if it is being driven low */
+	cp210x_gpio_set(gc, gpio, 1);
+
+	priv->gpio_input |= BIT(gpio);
+
+	return 0;
 }
 
 static int cp210x_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
 					int value)
 {
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	priv->gpio_input &= ~BIT(gpio);
+	cp210x_gpio_set(gc, gpio, value);
+
 	return 0;
 }
 
@@ -1385,11 +1434,11 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 
 	/* Succeed only if in correct mode (this can't be set at runtime) */
 	if ((param == PIN_CONFIG_DRIVE_PUSH_PULL) &&
-	    (priv->gpio_mode & BIT(gpio)))
+	    (priv->gpio_pushpull & BIT(gpio)))
 		return 0;
 
 	if ((param == PIN_CONFIG_DRIVE_OPEN_DRAIN) &&
-	    !(priv->gpio_mode & BIT(gpio)))
+	    !(priv->gpio_pushpull & BIT(gpio)))
 		return 0;
 
 	return -ENOTSUPP;
@@ -1402,12 +1451,13 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
  * this driver that provide GPIO do so in a way that does not impact other
  * signals and are thus expected to have very different initialisation.
  */
-static int cp2105_shared_gpio_init(struct usb_serial *serial)
+static int cp2105_gpioconf_init(struct usb_serial *serial)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_pin_mode mode;
 	struct cp210x_config config;
 	u8 intf_num = cp210x_interface_num(serial);
+	u8 iface_config;
 	int result;
 
 	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
@@ -1424,20 +1474,26 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
 
 	/*  2 banks of GPIO - One for the pins taken from each serial port */
 	if (intf_num == 0) {
-		if (mode.eci == CP210X_PIN_MODE_MODEM)
+		if (mode.eci == CP210X_PIN_MODE_MODEM) {
+			/* mark all GPIOs of this interface as reserved */
+			priv->gpio_altfunc = 0xff;
 			return 0;
+		}
 
-		priv->config = config.eci_cfg;
-		priv->gpio_mode = (u8)((le16_to_cpu(config.gpio_mode) &
+		iface_config = config.eci_cfg;
+		priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
 						CP210X_ECI_GPIO_MODE_MASK) >>
 						CP210X_ECI_GPIO_MODE_OFFSET);
 		priv->gc.ngpio = 2;
 	} else if (intf_num == 1) {
-		if (mode.sci == CP210X_PIN_MODE_MODEM)
+		if (mode.sci == CP210X_PIN_MODE_MODEM) {
+			/* mark all GPIOs of this interface as reserved */
+			priv->gpio_altfunc = 0xff;
 			return 0;
+		}
 
-		priv->config = config.sci_cfg;
-		priv->gpio_mode = (u8)((le16_to_cpu(config.gpio_mode) &
+		iface_config = config.sci_cfg;
+		priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
 						CP210X_SCI_GPIO_MODE_MASK) >>
 						CP210X_SCI_GPIO_MODE_OFFSET);
 		priv->gc.ngpio = 3;
@@ -1445,6 +1501,125 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
 		return -ENODEV;
 	}
 
+	/* mark all pins which are not in GPIO mode */
+	if (iface_config & CP2105_GPIO0_TXLED_MODE)	/* GPIO 0 */
+		priv->gpio_altfunc |= BIT(0);
+	if (iface_config & (CP2105_GPIO1_RXLED_MODE |	/* GPIO 1 */
+			CP2105_GPIO1_RS485_MODE))
+		priv->gpio_altfunc |= BIT(1);
+
+	/* driver implementation for CP2105 only supports outputs */
+	priv->gpio_input = 0;
+
+	return 0;
+}
+
+static int cp2102n_gpioconf_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	const u16 config_size = 0x02a6;
+	u8 gpio_rst_latch;
+	u8 config_version;
+	u8 gpio_pushpull;
+	u8 *config_buf;
+	u8 gpio_latch;
+	u8 gpio_ctrl;
+	int result;
+	u8 i;
+
+	/*
+	 * Retrieve device configuration from the device.
+	 * The array received contains all customization settings done at the
+	 * factory/manufacturer. Format of the array is documented at the
+	 * time of writing at:
+	 * https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa
+	 */
+	config_buf = kmalloc(config_size, GFP_KERNEL);
+	if (!config_buf)
+		return -ENOMEM;
+
+	result = cp210x_read_vendor_block(serial,
+					  REQTYPE_DEVICE_TO_HOST,
+					  CP210X_READ_2NCONFIG,
+					  config_buf,
+					  config_size);
+	if (result < 0) {
+		kfree(config_buf);
+		return result;
+	}
+
+	config_version = config_buf[CP210X_2NCONFIG_CONFIG_VERSION_IDX];
+	gpio_pushpull = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
+	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
+	gpio_rst_latch = config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
+
+	kfree(config_buf);
+
+	/* Make sure this is a config format we understand. */
+	if (config_version != 0x01)
+		return -ENOTSUPP;
+
+	/*
+	 * We only support 4 GPIOs even on the QFN28 package, because
+	 * config locations of GPIOs 4-6 determined using reverse
+	 * engineering revealed conflicting offsets with other
+	 * documented functions. So we'll just play it safe for now.
+	 */
+	priv->gc.ngpio = 4;
+
+	/*
+	 * Get default pin states after reset. Needed so we can determine
+	 * the direction of an open-drain pin.
+	 */
+	gpio_latch = (gpio_rst_latch >> 3) & 0x0f;
+
+	/* 0 indicates open-drain mode, 1 is push-pull */
+	priv->gpio_pushpull = (gpio_pushpull >> 3) & 0x0f;
+
+	/* 0 indicates GPIO mode, 1 is alternate function */
+	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0f;
+
+	/*
+	 * The CP2102N does not strictly has input and output pin modes,
+	 * it only knows open-drain and push-pull modes which is set at
+	 * factory. An open-drain pin can function both as an
+	 * input or an output. We emulate input mode for open-drain pins
+	 * by making sure they are not driven low, and we do not allow
+	 * push-pull pins to be set as an input.
+	 */
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/*
+		 * Set direction to "input" iff pin is open-drain and reset
+		 * value is 1.
+		 */
+		if (!(priv->gpio_pushpull & BIT(i)) && (gpio_latch & BIT(i)))
+			priv->gpio_input |= BIT(i);
+	}
+
+	return 0;
+}
+
+static int cp210x_gpio_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	int result;
+
+	switch (priv->partnum) {
+	case CP210X_PARTNUM_CP2105:
+		result = cp2105_gpioconf_init(serial);
+		break;
+	case CP210X_PARTNUM_CP2102N_QFN28:
+	case CP210X_PARTNUM_CP2102N_QFN24:
+	case CP210X_PARTNUM_CP2102N_QFN20:
+		result = cp2102n_gpioconf_init(serial);
+		break;
+	default:
+		return 0;
+	}
+
+	if (result < 0)
+		return result;
+
 	priv->gc.label = "cp210x";
 	priv->gc.request = cp210x_gpio_request;
 	priv->gc.get_direction = cp210x_gpio_direction_get;
@@ -1477,7 +1652,7 @@ static void cp210x_gpio_remove(struct usb_serial *serial)
 
 #else
 
-static int cp2105_shared_gpio_init(struct usb_serial *serial)
+static int cp210x_gpio_init(struct usb_serial *serial)
 {
 	return 0;
 }
@@ -1588,12 +1763,10 @@ static int cp210x_attach(struct usb_serial *serial)
 
 	cp210x_init_max_speed(serial);
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
-		result = cp2105_shared_gpio_init(serial);
-		if (result < 0) {
-			dev_err(&serial->interface->dev,
-				"GPIO initialisation failed, continuing without GPIO support\n");
-		}
+	result = cp210x_gpio_init(serial);
+	if (result < 0) {
+		dev_err(&serial->interface->dev, "GPIO initialisation failed: %d\n",
+				result);
 	}
 
 	return 0;
-- 
2.18.0

