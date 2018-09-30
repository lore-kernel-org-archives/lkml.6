Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468C520833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF+ZgeYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468C520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeI3TCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 15:02:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33334 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeI3TCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 15:02:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so568775ljz.0;
        Sun, 30 Sep 2018 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ov2E+Hw2gTRg717M7nwl/CIyTDdH/8VFGvMxw7MErr0=;
        b=RF+ZgeYF7ue8iBVfEFWYWekyIr2O353cOSzaORmNVixhjW5lijC+rt3mH5ABXLAAbs
         8NconmlBq++KhpgH4r+z8X2iGJLjYc5Jzc2xYuZuaGoqRGF9B6huq0UWexhYulABAKWU
         YVj5wsOUR2fJarMcf5cL27Lq8vczLGfu3AZlpGlQFmJ7YJo7mq5g9pENdxxuLgQW+40d
         hBfQsg+KiyuvkvGIsvpUUwAumxwFrvPm4k7N6UgW0Vd48OXMoQijtiPvw63apQRAN4Al
         qTe33XZRdcpmBeMtm1qkCe+9drhHG06T+HCM8f2R2GbiV8/mFbX64Su8540xIkTULiML
         ENXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ov2E+Hw2gTRg717M7nwl/CIyTDdH/8VFGvMxw7MErr0=;
        b=M3JexRP1cgPYTlDKVesOF/zbdp+JH7qpsoxz0ZwWmqpUZ3QV5x/o6r7LEjc+Lu7kHq
         sBx9CFuuCQfGsCygGFmdfmnAFHmjZpAfUfrRYPj/4yuyCr3jQcbymlOt/QDKzwuyJqb5
         cYnGPpn7NAKLvvJNh7xSZlW0QzmNJSsJVbd50VlVazHHtrasmJuU2VsI2P/VZbVjvuHp
         VS7KFvGzQDCWXmdpc2RYSMWszatyKz5O6FgLqSdyc0e+jv7QPKtZEWlxzHONVb5zUA+B
         MuqAxpYmH9RO7akfyuqXSgw8GEGj0MIznYcfkotfcl1abp06+DT6Kn/5iyhKTSIdIwVo
         6Cig==
X-Gm-Message-State: ABuFfohbbmGzhx0QeZEGOy4h/O5jyGwji+9hKub+4vtyYtH1kkEr63uz
        UFUo871P09sS0eXGxB6ghiQykcTD
X-Google-Smtp-Source: ACcGV60kDR3rLf9Dgs6ecLHxOeFM0tNTFPjBgisgkZxVmEoxqrllMYQZfzzN+mJvNw4llUOos1DRCA==
X-Received: by 2002:a2e:5614:: with SMTP id k20-v6mr3667403ljb.48.1538310583630;
        Sun, 30 Sep 2018 05:29:43 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w202-v6sm482230lff.71.2018.09.30.05.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 05:29:42 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1g6aqz-0001sP-9Y; Sun, 30 Sep 2018 14:29:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Karoly Pados <pados@pados.hu>,
        Loic Poulain <loic.poulain@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] USB: serial: ftdi_sio: fix gpio name collisions
Date:   Sun, 30 Sep 2018 14:27:02 +0200
Message-Id: <20180930122703.7115-2-johan@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930122703.7115-1-johan@kernel.org>
References: <20180930122703.7115-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the gpio line names, which cause gpiolib to complain loudly
whenever a second ftdi gpiochip is registered:

	gpio gpiochip5: Detected name collision for GPIO name 'CBUS0'
	gpio gpiochip5: Detected name collision for GPIO name 'CBUS1'
	gpio gpiochip5: Detected name collision for GPIO name 'CBUS2'
	gpio gpiochip5: Detected name collision for GPIO name 'CBUS3'

and also prevents the legacy sysfs interface from being used (as the
line names are used as device names whenever they are set):

	sysfs: cannot create duplicate filename '/class/gpio/CBUS0'

Until non-unique names are supported by gpiolib (without warnings and
stack dumps), let's leave the gpio lines unnamed.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 6b727ada20cf..be50b2a200aa 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1778,10 +1778,6 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 
 #ifdef CONFIG_GPIOLIB
 
-static const char * const ftdi_ftx_gpio_names[] = {
-	"CBUS0", "CBUS1", "CBUS2", "CBUS3"
-};
-
 static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -2032,7 +2028,6 @@ static int ftx_gpioconf_init(struct usb_serial_port *port)
 
 	/* FIXME: FT234XD alone has 1 GPIO, but how to recognize this IC? */
 	priv->gc.ngpio = 4;
-	priv->gc.names = ftdi_ftx_gpio_names;
 
 	/* Determine which pins are configured for CBUS bitbanging */
 	priv->gpio_altfunc = 0xff;
-- 
2.19.0

