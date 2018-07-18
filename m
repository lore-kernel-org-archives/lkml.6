Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26772084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="iQ5gh6FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26772084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeGRV77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:59:59 -0400
Received: from erza.pados.hu ([176.9.136.194]:39972 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbeGRV77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F4Rfa4a7lcScYXTkmhWhMwL3WKJ8zPc6D6AgAonzNbk=; b=iQ5gh6FNsRwuHRflPZ1ubeOHdM
        0Lzr/ZaQWrb9kk8a174w4dHNIU/zQaHaO9Aws344aj/TxjZyXN8K1SuYN2H1lvifusqXuHiMxMP1E
        BKcINrh4+Gmf0ZvAvQpXryv+n6H8QVD376XJqDL26fvxxmKg8MGx1NwlCkJ/kPir8i8PnetYWgx3S
        rxpYR5AWvSIvBxByFheHOdYFkIqet4vHa3JwOPpu6zQB4LW7m0IzGhocxFiUzCFgWTTooIc5S1NJQ
        3TwrwyLFsrtGLzMIip04k1nYB92ixD1zrXYMC0gr7IXc3lPLFObTJEdeS9YM4aM6R7xogHbJcjuhS
        N92Z+3BQ==;
Received: from 84-236-103-231.pool.digikabel.hu ([84.236.103.231] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fftrm-0003nJ-Ld; Wed, 18 Jul 2018 23:20:11 +0200
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v2] USB: serial: cp210x: Implement GPIO support for CP2102N
Date:   Wed, 18 Jul 2018 23:20:04 +0200
Message-Id: <20180718212004.11852-1-pados@pados.hu>
X-Mailer: git-send-email 2.17.1
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  This is v2 of the patch and addresses all feedback previously
    received from the maintainer. New input/output support stayed as discussed
    on the e-mail lists separately. CP2105 is also using the new code structure,
    but due to missing way to get default pin states after reset from the device,
    support for this device is basically still output-only as before, at least
    in name. But CP2105 and CP2102N paths are unified. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: silabs.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 TVD_RCVD_IP            Message was received from an IP address
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/usb/serial/cp210x.c | 274 ++++++++++++++++++++++++++++++------
 1 file changed, 232 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 4a118eb13590..81f9d3e183c6 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -224,9 +224,19 @@ MODULE_DEVICE_TABLE(usb, id_table);
 struct cp210x_serial_private {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gc;
-	u8			config;
-	u8			gpio_mode;
 	bool			gpio_registered;
+
+	/*
+	 * The following three fields are for devices that
+	 * emulate input/output pins using open-drain/pushpull
+	 * drive modes.
+	 */
+	/* One bit for each GPIO, 1 if pin is pushpull */
+	u8			gpio_pushpull;
+	/* One bit for each GPIO, 1 if pin is not in GPIO mode */
+	u8			gpio_altfunc;
+	/* One bit for each GPIO, 1 if pin direction is input */
+	u8			gpio_input;
 #endif
 	u8			partnum;
 	speed_t			max_speed;
@@ -343,6 +353,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 #define CONTROL_WRITE_RTS	0x0200
 
 /* CP210X_VENDOR_SPECIFIC values */
+#define CP210X_READ_2NCONFIG	0x000E
 #define CP210X_READ_LATCH	0x00C2
 #define CP210X_GET_PARTNUM	0x370B
 #define CP210X_GET_PORTCONFIG	0x370C
@@ -452,6 +463,12 @@ struct cp210x_config {
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
@@ -1308,21 +1325,29 @@ static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
 }
 
 #ifdef CONFIG_GPIOLIB
+
+/*
+ * Helper to determine if a specific serial device belongs to the cp2102n
+ * family of devices.
+ */
+static bool cp210x_is_cp2102n(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	return  (priv->partnum == CP210X_PARTNUM_CP2102N_QFN28) ||
+		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN24) ||
+		(priv->partnum == CP210X_PARTNUM_CP2102N_QFN20);
+}
+
 static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
 {
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
+	if (priv->gpio_altfunc & BIT(offset)) {
+		dev_warn(&serial->interface->dev,
+			 "Cannot control GPIO with active alternate function.\n");
+		return -ENODEV;
 	}
 
 	return 0;
@@ -1331,10 +1356,15 @@ static int cp210x_gpio_request(struct gpio_chip *gc, unsigned int offset)
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
@@ -1345,34 +1375,82 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	struct cp210x_gpio_write buf;
+	int result = 0;
 
-	if (value == 1)
-		buf.state = BIT(gpio);
-	else
-		buf.state = 0;
-
+	buf.state = (value == 1) ? BIT(gpio) : 0;
 	buf.mask = BIT(gpio);
 
-	cp210x_write_vendor_block(serial, REQTYPE_HOST_TO_INTERFACE,
-				  CP210X_WRITE_LATCH, &buf, sizeof(buf));
+	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_INTERFACE,
+						   CP210X_WRITE_LATCH, &buf,
+						   sizeof(buf));
+	} else if (cp210x_is_cp2102n(serial)) {
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
+	if (result < 0)
+		dev_err(&serial->interface->dev, "Failed to set GPIO value.\n");
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
+		/* Hardware does not support an input mode */
+		return -ENOTSUPP;
+	} else if (cp210x_is_cp2102n(serial)) {
+		/* Push-pull pins cannot be changed to be inputs */
+		if (priv->gpio_pushpull & BIT(gpio)) {
+			dev_warn(&serial->interface->dev,
+				 "Cannot change direction of a push-pull GPIO to input.\n");
+			return -EPERM;
+		}
+
+		/* Make sure to release pin if it is being driven low */
+		cp210x_gpio_set(gc, gpio, 1);
+
+		/* Note pin direction to ourselves */
+		priv->gpio_input |= BIT(gpio);
+
+		return 0;
+	}
+
+	return -EPERM;
 }
 
 static int cp210x_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
 					int value)
 {
+	struct usb_serial *serial = gpiochip_get_data(gc);
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+
+	/* Note pin direction to ourselves */
+	priv->gpio_input &= ~BIT(gpio);
+
+	/* Set requested initial output value */
+	cp210x_gpio_set(gc, gpio, value);
+
 	return 0;
 }
 
@@ -1385,11 +1463,11 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 
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
@@ -1402,13 +1480,14 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
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
 	int result;
+	u8 iface_config;
 
 	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
 					  CP210X_GET_DEVICEMODE, &mode,
@@ -1424,20 +1503,25 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
 
 	/*  2 banks of GPIO - One for the pins taken from each serial port */
 	if (intf_num == 0) {
-		if (mode.eci == CP210X_PIN_MODE_MODEM)
+		if (mode.eci == CP210X_PIN_MODE_MODEM) {
+			/* Mark all GPIOs of this interface as reserved */
+			priv->gpio_altfunc = 0xFF;
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
-			return 0;
+		if (mode.sci == CP210X_PIN_MODE_MODEM) {
+			/* Mark all GPIOs of this interface as reserved */
+			priv->gpio_altfunc = 0xFF;
+		}
 
-		priv->config = config.sci_cfg;
-		priv->gpio_mode = (u8)((le16_to_cpu(config.gpio_mode) &
+		iface_config = config.sci_cfg;
+		priv->gpio_pushpull = (u8)((le16_to_cpu(config.gpio_mode) &
 						CP210X_SCI_GPIO_MODE_MASK) >>
 						CP210X_SCI_GPIO_MODE_OFFSET);
 		priv->gc.ngpio = 3;
@@ -1445,6 +1529,118 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
 		return -ENODEV;
 	}
 
+	/* Mark all pins which are not in GPIO mode */
+	priv->gpio_altfunc = 0;
+	if (iface_config & CP2105_GPIO0_TXLED_MODE)	/* GPIO 0 */
+		priv->gpio_altfunc |= BIT(0);
+	if (iface_config & (CP2105_GPIO1_RXLED_MODE |	/* GPIO 1 */
+			CP2105_GPIO1_RS485_MODE))
+		priv->gpio_altfunc |= BIT(1);
+
+	/* Driver implementation for CP2105 only supports outputs */
+	priv->gpio_input = 0;
+
+	return 0;
+}
+
+static int cp2102n_gpioconf_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	const u16 CONFIG_SIZE = 0x02A6;
+	u8 gpio_rst_latch;
+	u8 config_version;
+	u8 gpio_pushpull;
+	u8 *config_buf;
+	u8 gpio_latch;
+	u8 gpio_ctrl;
+	int result;
+	u8 i;
+
+	/* Retrieve device configuration from the device.
+	 * The array received contains all customization settings
+	 * done at the factory/manufacturer.
+	 * Format of the array is documented at the time of writing at
+	 * https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa
+	 */
+	config_buf = kmalloc(CONFIG_SIZE, GFP_KERNEL);
+	if (!config_buf)
+		return -ENOMEM;
+
+	result = cp210x_read_vendor_block(serial,
+					  REQTYPE_DEVICE_TO_HOST,
+					  CP210X_READ_2NCONFIG,
+					  config_buf,
+					  CONFIG_SIZE);
+	if (result < 0) {
+		kfree(config_buf);
+		return -EIO;
+	}
+
+	config_version = config_buf[CP210X_2NCONFIG_CONFIG_VERSION_IDX];
+	gpio_pushpull = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
+	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
+	gpio_rst_latch = config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
+
+	kfree(config_buf);
+
+	/* Make sure this is a config format we understand */
+	if (config_version != 0x01)
+		return -ENOTSUPP;
+
+	/* We only support 4 GPIOs even on the QFN28 package, because
+	 * config locations of GPIOs 4-6 determined using reverse
+	 * engineering revealed conflicting offsets with other
+	 * documented functions. So we'll just play it safe for now.
+	 */
+	priv->gc.ngpio = 4;
+
+	/* Get default pin states after reset. Needed so we can determine
+	 * the direction of an open-drain pin.
+	 */
+	gpio_latch = (gpio_rst_latch >> 3) & 0x0F;
+
+	/* 0 indicates open-drain mode, 1 is push-pull */
+	priv->gpio_pushpull = (gpio_pushpull >> 3) & 0x0F;
+
+	/* 0 indicates GPIO mode, 1 is alternate function */
+	priv->gpio_altfunc = (gpio_ctrl >> 2) & 0x0F;
+
+	/* The CP2102N does not strictly has input and output pin modes,
+	 * it only knows open-drain and push-pull modes which is set at
+	 * factory. An open-drain pin can function both as an
+	 * input or an output. We emulate input mode for open-drain pins
+	 * by making sure they are not driven low, and we do not allow
+	 * push-pull pins to be set as an input.
+	 */
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		/* Set direction to "input" iff
+		 * pin is open-drain and reset value is 1
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
+	int result = 0;
+
+	if (cp210x_is_cp2102n(serial))
+		result = cp2102n_gpioconf_init(serial);
+	else if (priv->partnum == CP210X_PARTNUM_CP2105)
+		result = cp2105_gpioconf_init(serial);
+	else
+		return 0;
+
+	if (result < 0) {
+		dev_err(&serial->interface->dev,
+			"GPIO initialisation failed, continuing without GPIO support\n");
+		return result;
+	}
+
 	priv->gc.label = "cp210x";
 	priv->gc.request = cp210x_gpio_request;
 	priv->gc.get_direction = cp210x_gpio_direction_get;
@@ -1477,7 +1673,7 @@ static void cp210x_gpio_remove(struct usb_serial *serial)
 
 #else
 
-static int cp2105_shared_gpio_init(struct usb_serial *serial)
+static int cp210x_gpio_init(struct usb_serial *serial)
 {
 	return 0;
 }
@@ -1588,13 +1784,7 @@ static int cp210x_attach(struct usb_serial *serial)
 
 	cp210x_init_max_speed(serial);
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
-		result = cp2105_shared_gpio_init(serial);
-		if (result < 0) {
-			dev_err(&serial->interface->dev,
-				"GPIO initialisation failed, continuing without GPIO support\n");
-		}
-	}
+	cp210x_gpio_init(serial);
 
 	return 0;
 }
-- 
2.17.1

