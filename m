Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F011CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A720658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPp2CNiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932A720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIEPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:19:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35136 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeIEPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:19:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id q13-v6so5598671lfc.2;
        Wed, 05 Sep 2018 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=w9ku10cc/7mHJcG/fe0pXmcw0t640ptMgjjkBnqvg0c=;
        b=sPp2CNiAc7hkoNMdeX3T6mrAe91hK1lKC58ETnBPGLDDu18Od7W5qOKZXCxp9aUg/h
         HnzJ+LHfSjrv1+rA+lVs1HyakrE5+EjCVl+Kat1ke575sL97NQwT4mdvXQxCWozCncLz
         BpIGBd/AceF4B7e5CRTx11lIKa1uoaD3XiyQGMCHVDTDWtEtDSlCAzu1UZy4W64uYKjp
         B0821PjDU9HeuEgqzI0HyjY/IZFiit47KTF7aQllBT6dfyDri2jNNxZg+8jpKoYeO2Aq
         5VnykUxNbpgK6d9vFQsRgKES21yR5mlUEGKu3uLZgo6vEnIarxEPS24A6OndDmPioIkH
         c+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=w9ku10cc/7mHJcG/fe0pXmcw0t640ptMgjjkBnqvg0c=;
        b=leY6GtI9vTvT/auwLWMyu0/uBQeRLcJfc841bBJltTx7o8Vhc3ubPPykdCOy9otcxg
         R+1cHz5jPkf6qT8BX2GckLj3ildxP+YgMgm6M+dhsjn2WX6+istpZM2vwwZNQ8zVjl+L
         ctGTXJN13/MviHYH67cHzKZM/4qjgzZr9bn5N2LQCKfBhOPPAROLykZRQT3+IpSKb0oe
         Dn0aAJo6nMG8+hLDx/2RAqUsTmtQjOgoTnv7eB91BD+GlDEHiBF112Zl+5E9ejlKNUBJ
         OlQ2enoH9nTjyGbByivOUSTTJ1UUaPuPow9ATFaiBYMp+ZOZsPFzPI7mZHRriC7ep66k
         2HjA==
X-Gm-Message-State: APzg51Der58rZ1vkyDgJ6YlE5Lk7gMtkSVV3/WfktpGTctj1/2jjtV1V
        anIdaI4B1PIDR186apWeqcc=
X-Google-Smtp-Source: ANB0VdZvWRF+xxnNxD89dNF4+Gi0Tj3y+XPBwoAYqkh7MkB0WCtu5O5ZAESNyy3RgfKBotGW+QDf9g==
X-Received: by 2002:a19:c94a:: with SMTP id z71-v6mr22758153lff.34.1536144608266;
        Wed, 05 Sep 2018 03:50:08 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h71-v6sm258419lfg.64.2018.09.05.03.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 03:50:07 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fxVO6-00040H-Tk; Wed, 05 Sep 2018 12:50:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [RFC] USB: serial: ftdi_sio: add support for FT232R CBUS gpios
Date:   Wed,  5 Sep 2018 12:49:04 +0200
Message-Id: <20180905104904.15325-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the CBUS gpios on FT232R. The cbus configuration is
stored in one word in the EEPROM at offset 0x0a with the mux config for
CBUS1, CBUS2, CBUS3 and CBUS4 in bits 0..3, 4..7, 8..11 and 12..15,
respectively.

Tested using FT232RL with all CBUS pins in IO mode.

Applies on top of Karoly's CBUS gpio patch.

FIXME: use common eeprom_read helper
FIXME: return the number of gpios instead of setting gc.ngpio?
FIXME: verify each mux setting
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This is a cleaned up version of some code I've been using to test
Karoly's patch using an FT232RL in case anyone wants to give that a try.

May also be useful to get an idea of how the current setup code can be
refactored. This one needs to be rebased to use a common eeprom helper
eventually for example.

Johan


 drivers/usb/serial/ftdi_sio.c | 49 +++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1df9c553710b..4d63863bfb3f 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -43,6 +43,9 @@
 #ifdef CONFIG_GPIOLIB
 #include <linux/gpio/driver.h>
 #endif
+
+#include <asm/unaligned.h>
+
 #include "ftdi_sio.h"
 #include "ftdi_sio_ids.h"
 
@@ -1920,6 +1923,49 @@ static int ftdi_sio_gpio_direction_output(struct gpio_chip *gc,
 			  FTDI_SIO_GPIO_MODE_CBUS);
 }
 
+static int ftdi_ft232r_gpioconf_init(struct usb_serial_port *port)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev = port->serial->dev;
+	u16 tmp;
+	u8 *buf;
+	int res;
+	int i;
+
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	res = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				FTDI_SIO_READ_EEPROM_REQUEST,
+				FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
+				0, 0x0a, buf, 2,
+				WDR_TIMEOUT);
+	if (res < 2) {
+		if (res >= 0)
+			res = -EIO;
+		goto out_free;
+	}
+
+	tmp = get_unaligned_le16(buf);
+	dev_dbg(&port->dev, "cbus_config = 0x%04x\n", tmp);
+
+	priv->gc.ngpio = 4;
+	priv->gpio_altfunc = 0xff;
+
+	for (i = 0; i < priv->gc.ngpio; ++i) {
+		if ((tmp & 0xf) == FTDI_FT232R_CBUS_MUX_IOMODE)
+			priv->gpio_altfunc &= ~BIT(i);
+		tmp >>= 4;
+	}
+
+	res = 0;
+out_free:
+	kfree(buf);
+
+	return res;
+}
+
 static int ftx_gpioconf_init(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1980,6 +2026,9 @@ static int ftdi_sio_gpio_init(struct usb_serial_port *port)
 
 	/* Device-specific initializations */
 	switch (priv->chip_type) {
+	case FT232RL:
+		result = ftdi_ft232r_gpioconf_init(port);
+		break;
 	case FTX:
 		result = ftx_gpioconf_init(port);
 		break;
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 5046d02fe3ac..eed72608382b 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -458,6 +458,7 @@ enum ftdi_sio_baudrate {
 #define FTDI_SIO_GPIO_MODE_RESET	0x00
 
 #define FTDI_SIO_CBUS_MUX_GPIO		8
+#define FTDI_FT232R_CBUS_MUX_IOMODE	0xa
 
 
 /* Descriptors returned by the device
-- 
2.18.0

