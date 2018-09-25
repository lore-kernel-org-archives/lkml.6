Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B44C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D932098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="O29SQx7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D932098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeIYUG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:06:59 -0400
Received: from erza.pados.hu ([176.9.136.194]:35532 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeIYUG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jFw8dpHKDhwpcXzBPxT0KG2Uu9o9KTqWoe/WlhavWQk=; b=O29SQx7ONk99ZhR/g07TUwGcM8
        USF+1NAISl/ynTiJlJUdgus1XxnlDcPa5NSht7A5ac1J0EO9yss0ouDxIyAftFf8kO9wSqhj3jt+X
        TWSU765jcyTZp1zWa1dJhsGnXeHHavQUDeFrlMN/CVPm1WjMQZZeT811uBs+vzRoY8cqni13+RiLn
        f2zQn3mZdJbUzz1fGioev3sdvNxog/MG74CmEb9njh5X/zkKxMzouqDbGv6oFrRoPiirx2/+uEYNJ
        N5RYCYWA/wqL9ONgnWScQECK+1USNJ5wnQ7GPwucqJZ7PYQyOS29kZtxdyRg5f2nfX8skhR7ylyDg
        m9+Gp+Zg==;
Received: from [80.122.25.38] (helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4nru-0003hb-QY; Tue, 25 Sep 2018 15:59:15 +0200
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v7] USB: serial: ftdi_sio: implement GPIO support for FT-X devices
Date:   Tue, 25 Sep 2018 15:59:11 +0200
Message-Id: <20180925135911.2926-1-pados@pados.hu>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  This patch allows using the CBUS pins of FT-X devices as GPIO
    in CBUS bitbanging mode. There is no conflict between the GPIO and VCP functionality
    in this mode. Tested on FT230X and FT231X. As there is no way to request
   the current CBUS register configuration from the device, all CBUS pins are
    set to a known state when the first GPIO is requested. This allows using
   libftdi to set the GPIO pins before loading this module for UART functionality,
    a behavior that existing applications might be relying upon (though no specific
    case is known to the authors of this patch). [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: ftdichip.com]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows using the CBUS pins of FT-X devices as GPIO in CBUS
bitbanging mode. There is no conflict between the GPIO and VCP
functionality in this mode. Tested on FT230X and FT231X.

As there is no way to request the current CBUS register configuration
from the device, all CBUS pins are set to a known state when the first
GPIO is requested. This allows using libftdi to set the GPIO pins
before loading this module for UART functionality, a behavior that
existing applications might be relying upon (though no specific case
is known to the authors of this patch).

Signed-off-by: Karoly Pados <pados@pados.hu>
---
Changelog:
- v2: Fix compile error when CONFIG_GPIOLIB is not defined.
- v3: Incorporate review feedback.
- v4: Include linux/gpio/driver.h unconditionally.
      Replace and invert gpio_input with gpio_output.
      Make ftdi_gpio_direction_get return 0/1.
      Change dev_err msg in ftdi_set_bitmode_req.
      Change formatting of error checking in ftdi_gpio_get.
      Drop dev_err in ftdi_gpio_set.
      Remove some line breaks and empty lines.
      Change error handling in ftdi_read_eeprom (and adjust caller).
      Replace SIO->FTX in FTDI_SIO_CBUS_MUX_GPIO macro name.
- v5: Resent v4 with no changes by mistake. Please ignore.
- v6: Read only 4 bytes from eeprom in ftx_gpioconf_init.
      Compare ftdi_read_eeprom result with 0 instead of eq. cehck.
      Reserve 4 GPIOs even for FT234X.
      Release CBUS after gpiochip deregister to avoid possible race.
      Adjust comment on FTDI_SIO_SET_BITMODE macro.
      Protect GPIO value/dir setting with mutex.
      Add support for gpiochip.get_multiple and set_multiple.
      Add names to GPIO lines.
- v7: Move <linux/gpio/driver.h> line for better include sorting.
      Adjust comment on gpio_lock declaration.
      Space vs tab formatting changes in struct ftdi_private.
      Move ftdi_ftx_gpio_names to merge it with existing #ifdef.
      Rename function ftdi_set_bitmode_req to ftdi_set_bitmode.
      Rename rcvbuf to buf in function ftdi_read_cbus_pins.
      AND *bits and *mask in ftdi_gpio_set_multiple as gpiolib does not.
      Replace if in ftdi_gpio_direction_get with negation.
      Move priv->gc.names assignment to chip-specific ftx_gpioconf_init.

Though there is no code copied, libftdi was used as 
a reference. ftdi_read_eeprom is based on Loic Poulain's patch.

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

 drivers/usb/serial/ftdi_sio.c | 365 +++++++++++++++++++++++++++++++++-
 drivers/usb/serial/ftdi_sio.h |  27 ++-
 2 files changed, 390 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b5cef322826f..667018125ab6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -39,6 +39,7 @@
 #include <linux/uaccess.h>
 #include <linux/usb.h>
 #include <linux/serial.h>
+#include <linux/gpio/driver.h>
 #include <linux/usb/serial.h>
 #include "ftdi_sio.h"
 #include "ftdi_sio_ids.h"
@@ -72,6 +73,15 @@ struct ftdi_private {
 	unsigned int latency;		/* latency setting in use */
 	unsigned short max_packet_size;
 	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
+#if defined(CONFIG_GPIOLIB)
+	struct gpio_chip gc;
+	struct mutex gpio_lock;	/* protects GPIO state */
+	bool gpio_registered;	/* is the gpiochip in kernel registered */
+	bool gpio_used;		/* true if the user requested a gpio */
+	u8 gpio_altfunc;	/* which pins are in gpio mode */
+	u8 gpio_output;		/* pin directions cache */
+	u8 gpio_value;		/* pin value for outputs */
+#endif
 };
 
 /* struct ftdi_sio_quirk is used by devices requiring special attention. */
@@ -1766,6 +1776,349 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 
 }
 
+#if defined(CONFIG_GPIOLIB)
+
+static const char * const ftdi_ftx_gpio_names[] = {
+	"CBUS0", "CBUS1", "CBUS2", "CBUS3"
+};
+
+static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	int result;
+	u16 val;
+
+	val = (mode << 8) | (priv->gpio_output << 4) | priv->gpio_value;
+	result = usb_control_msg(serial->dev,
+				 usb_sndctrlpipe(serial->dev, 0),
+				 FTDI_SIO_SET_BITMODE_REQUEST,
+				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
+				 priv->interface, NULL, 0, WDR_TIMEOUT);
+	if (result < 0) {
+		dev_err(&serial->interface->dev,
+			"bitmode request failed for value 0x%04x: %d\n",
+			val, result);
+	}
+
+	return result;
+}
+
+static int ftdi_set_cbus_pins(struct usb_serial_port *port)
+{
+	return ftdi_set_bitmode(port, FTDI_SIO_BITMODE_CBUS);
+}
+
+static int ftdi_exit_cbus_mode(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	priv->gpio_output = 0;
+	priv->gpio_value = 0;
+	return ftdi_set_bitmode(port, FTDI_SIO_BITMODE_RESET);
+}
+
+static int ftdi_gpio_request(struct gpio_chip *gc, unsigned int offset)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result;
+
+	if (priv->gpio_altfunc & BIT(offset))
+		return -ENODEV;
+
+	mutex_lock(&priv->gpio_lock);
+	if (!priv->gpio_used) {
+		/* Set default pin states, as we cannot get them from device */
+		priv->gpio_output = 0x00;
+		priv->gpio_value = 0x00;
+		result = ftdi_set_cbus_pins(port);
+		if (result) {
+			mutex_unlock(&priv->gpio_lock);
+			return result;
+		}
+
+		priv->gpio_used = true;
+	}
+	mutex_unlock(&priv->gpio_lock);
+
+	return 0;
+}
+
+static int ftdi_read_cbus_pins(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	unsigned char *buf;
+	int result;
+
+	buf = kmalloc(1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	result = usb_control_msg(serial->dev,
+				 usb_rcvctrlpipe(serial->dev, 0),
+				 FTDI_SIO_READ_PINS_REQUEST,
+				 FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
+				 priv->interface, buf, 1, WDR_TIMEOUT);
+	if (result < 1) {
+		if (result >= 0)
+			result = -EIO;
+	} else {
+		result = buf[0];
+	}
+
+	kfree(buf);
+
+	return result;
+}
+
+static int ftdi_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	int result;
+
+	result = ftdi_read_cbus_pins(port);
+	if (result < 0)
+		return result;
+
+	return !!(result & BIT(gpio));
+}
+
+static void ftdi_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	mutex_lock(&priv->gpio_lock);
+
+	if (value)
+		priv->gpio_value |= BIT(gpio);
+	else
+		priv->gpio_value &= ~BIT(gpio);
+
+	ftdi_set_cbus_pins(port);
+
+	mutex_unlock(&priv->gpio_lock);
+}
+
+static int ftdi_gpio_get_multiple(struct gpio_chip *gc,
+				   unsigned long *mask, unsigned long *bits)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	int result;
+
+	result = ftdi_read_cbus_pins(port);
+	if (result < 0)
+		return result;
+
+	*bits = result & *mask;
+
+	return 0;
+}
+
+static void ftdi_gpio_set_multiple(struct gpio_chip *gc,
+				   unsigned long *mask, unsigned long *bits)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	mutex_lock(&priv->gpio_lock);
+
+	priv->gpio_value &= ~(*mask);
+	priv->gpio_value |= *bits & *mask;
+	ftdi_set_cbus_pins(port);
+
+	mutex_unlock(&priv->gpio_lock);
+}
+
+static int ftdi_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	return !(priv->gpio_output & BIT(gpio));
+}
+
+static int ftdi_gpio_direction_input(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result;
+
+	mutex_lock(&priv->gpio_lock);
+
+	priv->gpio_output &= ~BIT(gpio);
+	result = ftdi_set_cbus_pins(port);
+
+	mutex_unlock(&priv->gpio_lock);
+
+	return result;
+}
+
+static int ftdi_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int gpio,
+					  int value)
+{
+	struct usb_serial_port *port = gpiochip_get_data(gc);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result;
+
+	mutex_lock(&priv->gpio_lock);
+
+	priv->gpio_output |= BIT(gpio);
+	if (value)
+		priv->gpio_value |= BIT(gpio);
+	else
+		priv->gpio_value &= ~BIT(gpio);
+
+	result = ftdi_set_cbus_pins(port);
+
+	mutex_unlock(&priv->gpio_lock);
+
+	return result;
+}
+
+static int ftdi_read_eeprom(struct usb_serial *serial, void *dst,
+			    u16 addr, u16 nbytes)
+{
+	int read = 0;
+
+	if (addr % 2 != 0)
+		return -EINVAL;
+	if (nbytes % 2 != 0)
+		return -EINVAL;
+
+	/* Read EEPROM two bytes at a time */
+	while (read < nbytes) {
+		int rv;
+
+		rv = usb_control_msg(serial->dev,
+				     usb_rcvctrlpipe(serial->dev, 0),
+				     FTDI_SIO_READ_EEPROM_REQUEST,
+				     FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
+				     0, (addr + read) / 2, dst + read, 2,
+				     WDR_TIMEOUT);
+		if (rv < 2) {
+			if (rv >= 0)
+				return -EIO;
+			else
+				return rv;
+		}
+
+		read += rv;
+	}
+
+	return 0;
+}
+
+static int ftx_gpioconf_init(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	const u16 cbus_cfg_addr = 0x1a;
+	const u16 cbus_cfg_size = 4;
+	u8 *cbus_cfg_buf;
+	int result;
+	u8 i;
+
+	priv->gc.names = ftdi_ftx_gpio_names;
+
+	/* Read a part of device EEPROM */
+	cbus_cfg_buf = kmalloc(cbus_cfg_size, GFP_KERNEL);
+	if (!cbus_cfg_buf)
+		return -ENOMEM;
+
+	result = ftdi_read_eeprom(serial, cbus_cfg_buf,
+				  cbus_cfg_addr, cbus_cfg_size);
+	if (result < 0)
+		goto out_free;
+
+	/* FIXME: FT234XD alone has 1 GPIO, but how to recognize this IC? */
+	priv->gc.ngpio = 4;
+
+	/* Determine which pins are configured for CBUS bitbanging */
+	priv->gpio_altfunc = 0xff;
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		if (cbus_cfg_buf[i] == FTDI_FTX_CBUS_MUX_GPIO)
+			priv->gpio_altfunc &= ~BIT(i);
+	}
+
+out_free:
+	kfree(cbus_cfg_buf);
+
+	return result;
+}
+
+static int ftdi_gpio_init(struct usb_serial_port *port)
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
+	mutex_init(&priv->gpio_lock);
+
+	/* Register GPIO chip to kernel */
+	priv->gc.label = "ftdi-cbus";
+	priv->gc.request = ftdi_gpio_request;
+	priv->gc.get_direction = ftdi_gpio_direction_get;
+	priv->gc.direction_input = ftdi_gpio_direction_input;
+	priv->gc.direction_output = ftdi_gpio_direction_output;
+	priv->gc.get = ftdi_gpio_get;
+	priv->gc.set = ftdi_gpio_set;
+	priv->gc.get_multiple = ftdi_gpio_get_multiple;
+	priv->gc.set_multiple = ftdi_gpio_set_multiple;
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
+static void ftdi_gpio_remove(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	if (priv->gpio_registered) {
+		gpiochip_remove(&priv->gc);
+		priv->gpio_registered = false;
+	}
+
+	if (priv->gpio_used) {
+		/* Remark: Exiting CBUS-mode does not reset pin states too */
+		ftdi_exit_cbus_mode(port);
+		priv->gpio_used = false;
+	}
+}
+
+#else
+
+static int ftdi_gpio_init(struct usb_serial_port *port)
+{
+	return 0;
+}
+
+static void ftdi_gpio_remove(struct usb_serial_port *port) { }
+
+#endif
+
 /*
  * ***************************************************************************
  * FTDI driver specific functions
@@ -1794,7 +2147,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv;
 	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
-
+	int result;
 
 	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
 	if (!priv)
@@ -1813,6 +2166,14 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 		priv->latency = 16;
 	write_latency_timer(port);
 	create_sysfs_attrs(port);
+
+	result = ftdi_gpio_init(port);
+	if (result < 0) {
+		dev_err(&port->serial->interface->dev,
+			"GPIO initialisation failed: %d\n",
+			result);
+	}
+
 	return 0;
 }
 
@@ -1930,6 +2291,8 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	ftdi_gpio_remove(port);
+
 	remove_sysfs_attrs(port);
 
 	kfree(priv);
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index dcd0b6e05baf..6cfe682f8348 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -35,7 +35,10 @@
 #define FTDI_SIO_SET_EVENT_CHAR		6 /* Set the event character */
 #define FTDI_SIO_SET_ERROR_CHAR		7 /* Set the error character */
 #define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
-#define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
+#define FTDI_SIO_GET_LATENCY_TIMER	0x0a /* Get the latency timer */
+#define FTDI_SIO_SET_BITMODE		0x0b /* Set bitbang mode */
+#define FTDI_SIO_READ_PINS		0x0c /* Read immediate value of pins */
+#define FTDI_SIO_READ_EEPROM		0x90 /* Read EEPROM */
 
 /* Interface indices for FT2232, FT2232H and FT4232H devices */
 #define INTERFACE_A		1
@@ -433,6 +436,28 @@ enum ftdi_sio_baudrate {
  *         1 = active
  */
 
+/* FTDI_SIO_SET_BITMODE */
+#define FTDI_SIO_SET_BITMODE_REQUEST_TYPE 0x40
+#define FTDI_SIO_SET_BITMODE_REQUEST FTDI_SIO_SET_BITMODE
+
+/* Possible bitmodes for FTDI_SIO_SET_BITMODE_REQUEST */
+#define FTDI_SIO_BITMODE_RESET		0x00
+#define FTDI_SIO_BITMODE_CBUS		0x20
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
+#define FTDI_FTX_CBUS_MUX_GPIO		8
 
 
 /* Descriptors returned by the device
-- 
2.19.0

