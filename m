Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820FC20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="XAczpn0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820FC20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeIXUec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:34:32 -0400
Received: from erza.pados.hu ([176.9.136.194]:38928 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeIXUec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DfpGv0iLy3Qnytcj+hGC5eiW5V9i280bnQf6aMR0JaY=; b=XAczpn0JFpP0FFzM5t9Pwyxh0k
        BcKe0KR2kfRtge2GF8fRjgjrm8j+NUg+LJWpMDy6PLjzlkFK16fyMOKooqcf2c5Bc+60DCrbUamiZ
        wivUQiDDbVMGWRinwYcwWivI3jWkrK65xeI5T+MJusDMwYKRQxkRvnHjObuqajN8jXkmVCcB/efEq
        2FnHLhkPKxYBZVbMp9y8OwCURrsbkO8ufpnOxnUUNRT+ehxW0FQYwGwKsaweqvaN8/M0gMMb93g1Q
        ie6pR/s05EQWrm2wbniqj+GVQzZq6fTCuaItYedSY9T/618ZlRjhuBwz7XQ7jTkV+dMg3Qzye2brH
        kqqWDKyQ==;
Received: from [80.122.25.38] (helo=localhost)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1g4Ru6-000262-Hg; Mon, 24 Sep 2018 16:32:03 +0200
From:   Karoly Pados <pados@pados.hu>
To:     "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Loic Poulain" <loic.poulain@linaro.org>
Cc:     Karoly Pados <pados@pados.hu>
Subject: [PATCH v6] USB: serial: ftdi_sio: implement GPIO support for FT-X devices
Date:   Mon, 24 Sep 2018 16:31:51 +0200
Message-Id: <20180924143151.2273-1-pados@pados.hu>
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

Of special note, in this vesion of the patch GPIO names and support for
get_multiple / set_multiple methods have been added in addition to earlier
review comments.

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

 drivers/usb/serial/ftdi_sio.c | 369 +++++++++++++++++++++++++++++++++-
 drivers/usb/serial/ftdi_sio.h |  27 ++-
 2 files changed, 394 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b5cef322826f..566284e2c316 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -40,6 +40,7 @@
 #include <linux/usb.h>
 #include <linux/serial.h>
 #include <linux/usb/serial.h>
+#include <linux/gpio/driver.h>
 #include "ftdi_sio.h"
 #include "ftdi_sio_ids.h"
 
@@ -72,8 +73,23 @@ struct ftdi_private {
 	unsigned int latency;		/* latency setting in use */
 	unsigned short max_packet_size;
 	struct mutex cfg_lock; /* Avoid mess by parallel calls of config ioctl() and change_speed() */
+#if defined(CONFIG_GPIOLIB)
+	struct gpio_chip gc;
+	struct mutex  gpio_lock;  /* Protect GPIO state against parallel calls */
+	bool	gpio_registered;  /* is the gpiochip in kernel registered */
+	bool	gpio_used;	  /* true if the user requested a gpio */
+	u8	gpio_altfunc;	  /* which pins are in gpio mode */
+	u8	gpio_output;	  /* pin directions cache */
+	u8	gpio_value;	  /* pin value for outputs */
+#endif
 };
 
+#if defined(CONFIG_GPIOLIB)
+static const char * const ftdi_ftx_gpio_names[] = {
+	"CBUS0", "CBUS1", "CBUS2", "CBUS3"
+};
+#endif
+
 /* struct ftdi_sio_quirk is used by devices requiring special attention. */
 struct ftdi_sio_quirk {
 	int (*probe)(struct usb_serial *);
@@ -1766,6 +1782,347 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 
 }
 
+#if defined(CONFIG_GPIOLIB)
+
+static int ftdi_set_bitmode_req(struct usb_serial_port *port, u8 mode)
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
+	return ftdi_set_bitmode_req(port, FTDI_SIO_BITMODE_CBUS);
+}
+
+static int ftdi_exit_cbus_mode(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+
+	priv->gpio_output = 0;
+	priv->gpio_value = 0;
+	return ftdi_set_bitmode_req(port, FTDI_SIO_BITMODE_RESET);
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
+	if (result < 1) {
+		if (result >= 0)
+			result = -EIO;
+	} else {
+		result = rcvbuf[0];
+	}
+
+	kfree(rcvbuf);
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
+	priv->gpio_value |= *bits;
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
+	if (priv->gpio_output & BIT(gpio))
+		return 0;
+	else
+		return 1;
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
+	priv->gc.names = ftdi_ftx_gpio_names;
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
@@ -1794,7 +2151,7 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv;
 	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
-
+	int result;
 
 	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
 	if (!priv)
@@ -1813,6 +2170,14 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
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
 
@@ -1930,6 +2295,8 @@ static int ftdi_sio_port_remove(struct usb_serial_port *port)
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

