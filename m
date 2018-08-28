Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C296C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6220897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="YEybMKx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E6220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeH1VfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:35:20 -0400
Received: from erza.pados.hu ([176.9.136.194]:60726 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeH1VfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9zfo3B6+J2rVIpxbQ3VHwBVGJBesIS4J0jky0KXwkjA=; b=YEybMKx5dIPHpKjCfdBKNzO2gp
        EbKHzT76cnQXbT5UqavN3R9l+op0F6cj4EGdi9ZcnuOrz6nd4YTgUDy5T3wmhkhlnUOzhpWj5A90O
        gF0Xi3ZsIpA9o3sqaRYEDiq0I2dAcYnAd9DETRfF6Rm+68fhZeN9xyTGIFwOyQuGmlui2exnJ6N4g
        skEz6cB4b38C9jlZ6f9fF6zsHM1iQAUIxPyLL166CywNvO4Q97pCf/PWyOucLl8SfTaRPskMlWa7X
        clxjvIARnRp8brlKtN0xeRFtE58lSAbk/cc5GR5kIEKrN3KMMGlEWb8MZOLvCg2H+O3MUyfJE/OV1
        cWDufXPg==;
Received: from 92-249-224-221.pool.digikabel.hu ([92.249.224.221] helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fui0Y-0007wc-Sb; Tue, 28 Aug 2018 19:42:27 +0200
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v2] USB: serial: ftdi_sio: implement GPIO support for FT230X
Date:   Tue, 28 Aug 2018 19:42:16 +0200
Message-Id: <20180828174216.2587-1-pados@pados.hu>
X-Mailer: git-send-email 2.18.0
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  This patch uses the CBUS bitbang mode of the device, so there
    is no conflict between the GPIO and VCP functionality. Tested on FT230X and
    FT231X. Signed-off-by: Karoly Pados <pados@pados.hu> --- Changelog: - v2:
    Fix compile error when CONFIG_GPIOLIB is not defined. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
  0.0 TVD_RCVD_IP            Message was received from an IP address
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: pados.hu]
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the CBUS bitbang mode of the device, so there is
no conflict between the GPIO and VCP functionality. Tested on
FT230X and FT231X.

Signed-off-by: Karoly Pados <pados@pados.hu>
---

Changelog:
- v2: Fix compile error when CONFIG_GPIOLIB is not defined.

Though there is no copied code from other sources, libftdi was used as 
a reference.

I noticed there have been numerous historic attempts by other people at 
adding GPIO support to ftdi_sio. One tried adding it in some very 
application-specific way, another one tried to use the mfd framework, the
tried using a GPIO mode which is mutually exclusive to VCP, another
one did not implement the review results etc... I hope I learned from those 
attempts and am planning to respond to reviews. Also, this patch follows 
the rough structure of the GPIO support for cp210x devices that have 
already been accepted, in the hope that it is a good starting point.

This patch uses CBUS bitbanging mode, which works nicely in parallel with
the VCP function. The other modes do not, and so IMHO it does not make
sense to try adding them to this same module.

For this device, whenever changing the state of any single pin, all the
others need to be written too. This means in order to change any pin, we 
need to know the current state of all the others. So when using GPIO,
we need to have a known starting state for all pins, but there seems to 
be no way to retrieve the existing GPIO configuration (directions and
output register values). The way I handle this in this patch is that when
requesting a GPIO for the first time, the module initializes all pins to 
a known default state (to inputs). Input was chosen, because a potentially
floating pin is better than a potential driver conflict, because the latter
could result in hardware damage. However, if the user does not request a 
GPIO, the CBUS pins are not initialized, avoiding unnecessarily changing 
hardware state. I figured I cannot rely on the default power-on state of
the device for this as the user might have used libftdi before loading 
our module. When the module is unloaded, CBUS bitbanging mode is exited 
if it were us who entered it earlier.

checkpatch.pl emits a bunch of warnings, recommending const for structs. 
I am unsure if this makes sense, existing code in this same and also
other modules does not adhere to this rule either. I fixed everything else.

 drivers/usb/serial/ftdi_sio.c | 284 +++++++++++++++++++++++++++++++++-
 drivers/usb/serial/ftdi_sio.h |  25 +++
 2 files changed, 308 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b5cef322826f..1df9c553710b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -40,6 +40,9 @@
 #include <linux/usb.h>
 #include <linux/serial.h>
 #include <linux/usb/serial.h>
+#ifdef CONFIG_GPIOLIB
+#include <linux/gpio/driver.h>
+#endif
 #include "ftdi_sio.h"
 #include "ftdi_sio_ids.h"
 
@@ -72,6 +75,14 @@ struct ftdi_private {
 	unsigned int latency;		/* latency setting in use */
 	unsigned short max_packet_size;
 	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gc;
+	bool	gpio_registered;  /* is the gpiochip in kernel registered */
+	bool	gpio_used;	  /* true if the user requested a gpio */
+	u8	gpio_altfunc;	  /* which pins are in gpio mode */
+	u8	gpio_input;	  /* pin directions cache */
+	u8	gpio_value;	  /* pin value for outputs */
+#endif
 };
 
 /* struct ftdi_sio_quirk is used by devices requiring special attention. */
@@ -1766,6 +1777,268 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 
 }
 
+#ifdef CONFIG_GPIOLIB
+
+static int ftdi_sio_set_cbus(struct usb_serial_port *port,
+			     u8 direction,
+			     u8 value,
+			     u8 mode)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	u16 val;
+
+	/* device's direction polarity is different from kernel's */
+	direction = (~direction) & 0x0f;
+
+	val = (mode << 8) | (direction << 4) | (value & 0x0f);
+	return usb_control_msg(port->serial->dev,
+				 usb_sndctrlpipe(port->serial->dev, 0),
+				 FTDI_SIO_SET_BITMODE_REQUEST,
+				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
+				 priv->interface, NULL, 0, WDR_TIMEOUT);
+}
+
+static int ftdi_sio_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result = 0;
+
+	if (priv->gpio_altfunc & BIT(offset))
+		return -ENODEV;
+
+	if (!priv->gpio_used) {
+		/* Set default pin states, as we cannot get them from device */
+		priv->gpio_input = 0xff;
+		priv->gpio_value = 0x00;
+		result = ftdi_sio_set_cbus(port,
+					   priv->gpio_input,
+					   priv->gpio_value,
+					   FTDI_SIO_GPIO_MODE_CBUS);
+		if (result)
+			return result;
+
+		priv->gpio_used = true;
+	}
+
+	return 0;
+}
+
+static int ftdi_sio_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	unsigned char *rcvbuf;
+	int result;
+
+	rcvbuf = kmalloc(1, GFP_KERNEL);
+	if (!rcvbuf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				 usb_rcvctrlpipe(serial->dev, 0),
+				 FTDI_SIO_READ_PINS_REQUEST,
+				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
+				 priv->interface, rcvbuf, 1, WDR_TIMEOUT);
+
+	if (result < 1)
+		result = -EIO;
+	else
+		result = !!(rcvbuf[0] & BIT(gpio));
+
+	kfree(rcvbuf);
+
+	return result;
+}
+
+static void ftdi_sio_gpio_set(struct gpio_chip *gc,
+			      unsigned int gpio,
+			      int value
+)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result;
+
+	if (value)
+		priv->gpio_value |= BIT(gpio);
+	else
+		priv->gpio_value &= ~BIT(gpio);
+
+	result = ftdi_sio_set_cbus(port,
+				   priv->gpio_input,
+				   priv->gpio_value,
+				   FTDI_SIO_GPIO_MODE_CBUS);
+
+	if (result < 0) {
+		dev_err(&port->serial->interface->dev,
+			"failed to set GPIO value: %d\n",
+			result);
+	}
+}
+
+static int ftdi_sio_gpio_direction_get(struct gpio_chip *gc,
+				       unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	return priv->gpio_input & BIT(gpio);
+}
+
+static int ftdi_sio_gpio_direction_input(struct gpio_chip *gc,
+					 unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	priv->gpio_input |= BIT(gpio);
+
+	return ftdi_sio_set_cbus(port,
+			  priv->gpio_input,
+			  priv->gpio_value,
+			  FTDI_SIO_GPIO_MODE_CBUS);
+}
+
+static int ftdi_sio_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int gpio,
+					  int value)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	priv->gpio_input &= ~BIT(gpio);
+	if (value)
+		priv->gpio_value |= BIT(gpio);
+	else
+		priv->gpio_value &= ~BIT(gpio);
+
+	return ftdi_sio_set_cbus(port,
+			  priv->gpio_input,
+			  priv->gpio_value,
+			  FTDI_SIO_GPIO_MODE_CBUS);
+}
+
+static int ftx_gpioconf_init(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	const u16 config_size = 0x24;
+	u8 *config_buf;
+	int result;
+	u8 i;
+
+	/* Read part of device EEPROM */
+	config_buf = kmalloc(config_size, GFP_KERNEL);
+	if (!config_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < config_size / 2; i++) {
+		result = usb_control_msg(serial->dev,
+					 usb_rcvctrlpipe(serial->dev, 0),
+					 FTDI_SIO_READ_EEPROM_REQUEST,
+					 FTDI_SIO_READ_EEPROM_REQUEST_TYPE, 0,
+					 i, config_buf + (i * 2),
+					 2, WDR_TIMEOUT);
+		if (result < 2) {
+			result = -EIO;
+			break;
+		}
+	}
+
+	if (result < 0) {
+		kfree(config_buf);
+		return result;
+	}
+
+	/*
+	 * All FT-X devices have at least 1 GPIO, some have more.
+	 * Chip-type guessing logic based on libftdi.
+	 */
+	priv->gc.ngpio = 1;
+	if (serial->dev->descriptor.bcdDevice == 0x1000)  /* FT230X, FT231X */
+		priv->gc.ngpio = 4;
+
+	/* Determine which pins are configured for CBUS bitbanging */
+	priv->gpio_altfunc = 0xff;
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		if (config_buf[0x1A + i] == FTDI_SIO_CBUS_MUX_GPIO)
+			priv->gpio_altfunc &= ~BIT(i);
+	}
+
+	kfree(config_buf);
+
+	return 0;
+}
+
+static int ftdi_sio_gpio_init(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	int result;
+
+	/* Device-specific initializations */
+	switch (priv->chip_type) {
+	case FTX:
+		result = ftx_gpioconf_init(port);
+		break;
+	default:
+		return 0;
+	}
+
+	if (result < 0)
+		return result;
+
+	/* Register GPIO chip to kernel */
+	priv->gc.label = "ftdi_sio";
+	priv->gc.request = ftdi_sio_gpio_request;
+	priv->gc.get_direction = ftdi_sio_gpio_direction_get;
+	priv->gc.direction_input = ftdi_sio_gpio_direction_input;
+	priv->gc.direction_output = ftdi_sio_gpio_direction_output;
+	priv->gc.get = ftdi_sio_gpio_get;
+	priv->gc.set = ftdi_sio_gpio_set;
+	priv->gc.owner = THIS_MODULE;
+	priv->gc.parent = &serial->interface->dev;
+	priv->gc.base = -1;
+	priv->gc.can_sleep = true;
+
+	result = gpiochip_add_data(&priv->gc, port);
+	if (!result)
+		priv->gpio_registered = true;
+
+	return result;
+}
+
+static void ftdi_sio_gpio_remove(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	if (priv->gpio_used) {
+		ftdi_sio_set_cbus(port, 0, 0, FTDI_SIO_GPIO_MODE_RESET);
+		priv->gpio_used = false;
+	}
+
+	if (priv->gpio_registered) {
+		gpiochip_remove(&priv->gc);
+		priv->gpio_registered = false;
+	}
+}
+
+#else
+
+static int ftdi_sio_gpio_init(struct usb_serial_port *port)
+{
+	return 0;
+}
+
+static void ftdi_sio_gpio_remove(struct usb_serial_port *port)
+{
+	/* Nothing to do */
+}
+
+#endif
+
 /*
  * ***************************************************************************
  * FTDI driver specific functions
@@ -1794,7 +2067,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv;
 	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
-
+	int result;
 
 	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
 	if (!priv)
@@ -1813,6 +2086,13 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 		priv->latency = 16;
 	write_latency_timer(port);
 	create_sysfs_attrs(port);
+
+	result = ftdi_sio_gpio_init(port);
+	if (result < 0)
+		dev_err(&port->serial->interface->dev,
+			"GPIO initialisation failed: %d\n",
+			result);
+
 	return 0;
 }
 
@@ -1930,6 +2210,8 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	ftdi_sio_gpio_remove(port);
+
 	remove_sysfs_attrs(port);
 
 	kfree(priv);
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index dcd0b6e05baf..5046d02fe3ac 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -36,6 +36,10 @@
 #define FTDI_SIO_SET_ERROR_CHAR		7 /* Set the error character */
 #define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
 #define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
+#define FTDI_SIO_SET_BITMODE		11 /* Set CBUS GPIO pin mode */
+#define FTDI_SIO_READ_PINS		12 /* Read immediate value of pins */
+#define FTDI_SIO_READ_EEPROM		144 /* Read EEPROM */
+
 
 /* Interface indices for FT2232, FT2232H and FT4232H devices */
 #define INTERFACE_A		1
@@ -433,6 +437,27 @@ enum ftdi_sio_baudrate {
  *         1 = active
  */
 
+/* FTDI_SIO_SET_BITMODE */
+#define FTDI_SIO_SET_BITMODE_REQUEST_TYPE 0x40
+#define FTDI_SIO_SET_BITMODE_REQUEST FTDI_SIO_SET_BITMODE
+
+/* FTDI_SIO_READ_PINS */
+#define FTDI_SIO_READ_PINS_REQUEST_TYPE 0xc0
+#define FTDI_SIO_READ_PINS_REQUEST FTDI_SIO_READ_PINS
+
+/*
+ * FTDI_SIO_READ_EEPROM
+ *
+ * EEPROM format found in FTDI AN_201, "FT-X MTP memory Configuration",
+ * http://www.ftdichip.com/Support/Documents/AppNotes/AN_201_FT-X%20MTP%20Memory%20Configuration.pdf
+ */
+#define FTDI_SIO_READ_EEPROM_REQUEST_TYPE 0xc0
+#define FTDI_SIO_READ_EEPROM_REQUEST FTDI_SIO_READ_EEPROM
+
+#define FTDI_SIO_GPIO_MODE_CBUS		0x20
+#define FTDI_SIO_GPIO_MODE_RESET	0x00
+
+#define FTDI_SIO_CBUS_MUX_GPIO		8
 
 
 /* Descriptors returned by the device
-- 
2.18.0

