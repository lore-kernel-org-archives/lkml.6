Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B50820857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRG5MHaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B50820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeIBQRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:17:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36937 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:17:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so13140613lfb.4;
        Sun, 02 Sep 2018 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUP8hVZZHfnZdGxwxdQ4hnKRy6Ys9kDZ7ORt5poUXFA=;
        b=JRG5MHaq6/MajsNMmqdMnfnkkbkT6EctCJxvfcR/Q7fZkqhEWRHTmvcJiR6rEDaytR
         8qtFpeWa1blfJfb/lZ59ddjkT8aLO5hlT9kwsaJWMynvUEr596A3bLtWKHOwg3m9JcIZ
         hvS+bWCMxA2zUs0TawpeZGJuefIcdCO0OtGAH7/I/HjT7hIaafILNYG2XmZc/C00EV9c
         zWBYHEfvPTJ9P7uDTZoBws8Sb4+c8h0p2hSqYbtHTNtNDFhqrnAK1OC4fISqQuhREmNe
         pCNSCbyZgNjlupac6oAqBXKvy2Ox82N0vd9tzZO3k5UITXqHeUjFpkyesmYGCxQro4pZ
         xIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUP8hVZZHfnZdGxwxdQ4hnKRy6Ys9kDZ7ORt5poUXFA=;
        b=m4d+TCe1a2tZch9pSeoVh+MKKNcQYUiSL0E7tMCrZzTjq9KwxzGlIuF+2HfvCfsEhj
         x/5GtkIeTOi8Nh9SRamUkV/5EpHbaZ1v/CqpqDtvBz7lh5LLuPW8dwOurJbIg4er+3LC
         wMl20xLbhbLxXTfcLa7IFpHxsdeA6oVGSp7n3exQjen9gkJmZ/Kx5i97EdWq6eszd/hp
         x2GrT0dsp6iP7FcRo5o7/xwkUKVtEbeOpaOFvZN+82NAV39qrE06Ey1GkT8dvEhhX9HZ
         GYQ1vqsNB5yyP/wS8CVd60oaAGjBwk4sSiWcJR8decQUu7wKdqMVNekkvLq6YEGx/qQj
         vFYw==
X-Gm-Message-State: APzg51BxmIju788c1O0gtzTbp6fnY41yj+U6RKAhoBVrsKDsonkkrX28
        +waPvr9H5Io3J1amXV1li4g=
X-Google-Smtp-Source: ANB0VdaZnbhD4fCuuUjejCPzAtXkuvI+WK6xsqsUl5OxdyuEYOuxRk5m5tPLHIsvpB4hIQQpbw2HLQ==
X-Received: by 2002:a19:11d1:: with SMTP id 78-v6mr14736952lfr.25.1535889685861;
        Sun, 02 Sep 2018 05:01:25 -0700 (PDT)
Received: from localhost.localdomain (apn-37-248-210-194.dynamic.gprs.plus.pl. [37.248.210.194])
        by smtp.gmail.com with ESMTPSA id n3-v6sm2760321lji.96.2018.09.02.05.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 05:01:25 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v7 3/4] gpiolib: Pass array info to get/set array functions
Date:   Sun,  2 Sep 2018 14:01:43 +0200
Message-Id: <20180902120144.6855-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180902120144.6855-1-jmkrzyszt@gmail.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make use of array info obtained from gpiod_get_array() and
speed up processing of arrays matching single GPIO chip layout, that
information must be passed to get/set array functions.  Extend the
functions' API with that additional parameter and update all users.
Pass NULL if a user bulids an array itself from single GPIOs.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/driver-api/gpio/consumer.rst  | 14 +++++++++++--
 drivers/auxdisplay/hd44780.c                |  8 ++++----
 drivers/bus/ts-nbus.c                       |  5 +++--
 drivers/gpio/gpio-max3191x.c                |  6 ++++--
 drivers/gpio/gpiolib.c                      | 32 +++++++++++++++++++++--------
 drivers/gpio/gpiolib.h                      |  2 ++
 drivers/i2c/muxes/i2c-mux-gpio.c            |  3 ++-
 drivers/mmc/core/pwrseq_simple.c            |  2 +-
 drivers/mux/gpio.c                          |  3 ++-
 drivers/net/phy/mdio-mux-gpio.c             |  2 +-
 drivers/pcmcia/soc_common.c                 |  2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c |  4 +++-
 drivers/staging/iio/adc/ad7606.c            |  3 ++-
 drivers/tty/serial/serial_mctrl_gpio.c      |  2 +-
 include/linux/gpio/consumer.h               |  8 ++++++++
 15 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 7e0298b9a7b9..0afd95a12b10 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -325,28 +325,36 @@ The following functions get or set the values of an array of GPIOs::
 
 	int gpiod_get_array_value(unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
+				      struct gpio_array *array_info,
 				      unsigned long *value_bitmap);
 	int gpiod_get_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
+					   struct gpio_array *array_info,
 					   unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
+					   struct gpio_array *array_info,
 					   unsigned long *value_bitmap);
 
 	void gpiod_set_array_value(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
+					    struct gpio_array *array_info,
 					    unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
+						struct gpio_array *array_info,
 						unsigned long *value_bitmap)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
@@ -358,6 +366,7 @@ accessed sequentially.
 The functions take three arguments:
 	* array_size	- the number of array elements
 	* desc_array	- an array of GPIO descriptors
+	* array_info	- optional information obtained from gpiod_array_get()
 	* value_bitmap	- a bitmap to store the GPIOs' values (get) or
 			  a bitmap of values to assign to the GPIOs (set)
 
@@ -368,12 +377,13 @@ the struct gpio_descs returned by gpiod_get_array()::
 
 	struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
 	gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
-			      my_gpio_value_bitmap);
+			      my_gpio_descs->info, my_gpio_value_bitmap);
 
 It is also possible to access a completely arbitrary array of descriptors. The
 descriptors may be obtained using any combination of gpiod_get() and
 gpiod_get_array(). Afterwards the array of descriptors has to be setup
-manually before it can be passed to one of the above functions.
+manually before it can be passed to one of the above functions.  In that case,
+array_info should be set to NULL.
 
 Note that for optimal performance GPIOs belonging to the same chip should be
 contiguous within the array of descriptors.
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 333e30e378b5..033024df3962 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -70,7 +70,7 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 	n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -87,7 +87,7 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 
@@ -96,7 +96,7 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 	*values |= val & 0x0f;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -152,7 +152,7 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], NULL, values);
 
 	hd44780_strobe_gpio(hd);
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 6499957a8044..60796f2db6fc 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -114,7 +114,8 @@ static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 
 	*values = 0;
 
-	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, values);
+	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc,
+				       ts_nbus->data->info, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
 	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
 	gpiod_set_value_cansleep(ts_nbus->ale, 0);
@@ -159,7 +160,7 @@ static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 
 	*values = byte;
 
-	gpiod_set_array_value_cansleep(8, gpios->desc, values);
+	gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
 }
 
 /*
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index bd4a245fc5a0..9a8876abeb57 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -313,6 +313,7 @@ static int max3191x_set_config(struct gpio_chip *gpio, unsigned int offset,
 
 static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
+						  struct gpio_array *info,
 						  int value)
 {
 	unsigned long *values;
@@ -326,7 +327,7 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 	else
 		bitmap_zero(values, ndescs);
 
-	gpiod_set_array_value_cansleep(ndescs, desc, values);
+	gpiod_set_array_value_cansleep(ndescs, desc, info, values);
 	kfree(values);
 }
 
@@ -399,7 +400,8 @@ static int max3191x_probe(struct spi_device *spi)
 	if (max3191x->modesel_pins)
 		gpiod_set_array_single_value_cansleep(
 				 max3191x->modesel_pins->ndescs,
-				 max3191x->modesel_pins->desc, max3191x->mode);
+				 max3191x->modesel_pins->desc,
+				 max3191x->modesel_pins->info, max3191x->mode);
 
 	max3191x->ignore_uv = device_property_read_bool(dev,
 						  "maxim,ignore-undervoltage");
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 141f2f290538..cef6ee31fe05 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -436,6 +436,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 							true,
 							lh->numdescs,
 							lh->descs,
+							NULL,
 							vals);
 		if (ret)
 			return ret;
@@ -468,6 +469,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 					      true,
 					      lh->numdescs,
 					      lh->descs,
+					      NULL,
 					      vals);
 	}
 	return -EINVAL;
@@ -2784,6 +2786,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -2908,12 +2911,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
+			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, false, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
 
@@ -2931,12 +2936,14 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  */
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, false, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
@@ -3029,6 +3036,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
 	int i = 0;
@@ -3166,12 +3174,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
 			 struct gpio_desc **desc_array,
+			 struct gpio_array *array_info,
 			 unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, false, array_size,
-					desc_array, value_bitmap);
+					desc_array, array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
 
@@ -3189,12 +3198,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  */
 void gpiod_set_array_value(unsigned int array_size,
 			   struct gpio_desc **desc_array,
+			   struct gpio_array *array_info,
 			   unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3426,13 +3436,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, true, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
 
@@ -3449,13 +3461,15 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, true, array_size,
-					     desc_array, value_bitmap);
+					     desc_array, array_info,
+					     value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
@@ -3508,13 +3522,14 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
 					unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value_cansleep);
 
@@ -3548,13 +3563,14 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  */
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
+				    struct gpio_array *array_info,
 				    unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      value_bitmap);
+				      array_info, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b60905d558b1..b65ca896b24d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -196,10 +196,12 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
+				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap);
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
 
 /* This is just passed between gpiolib and devres */
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 0717cfb56732..c6e1c7776a56 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -30,7 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 
 	*values = val;
 
-	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, values);
+	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, NULL,
+				       values);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 5ad764c88b50..a17252f51418 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -46,7 +46,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		*values = value;
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-					       values);
+					       reset_gpios->info, values);
 	}
 }
 
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 1b6b4cc22a2c..4f58a3198c4e 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -27,7 +27,8 @@ static int mux_gpio_set(struct mux_control *mux, int state)
 	*values = state;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc, values);
+				       mux_gpio->gpios->desc,
+				       mux_gpio->gpios->info, values);
 
 	return 0;
 }
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index eb8c56b83c70..7d8bea21f099 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -34,7 +34,7 @@ static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 	*values = desired_child;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       values);
+				       s->gpios->info, values);
 
 	return 0;
 }
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 388dbdc46129..8447eeeaf3fe 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -365,7 +365,7 @@ static int soc_common_pcmcia_config_skt(
 		}
 
 		if (n)
-			gpiod_set_array_value_cansleep(n, descs, values);
+			gpiod_set_array_value_cansleep(n, descs, NULL, values);
 
 		/*
 		 * This really needs a better solution.  The IRQ
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 4de7f4577433..08e71c7ae199 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -162,7 +162,8 @@ static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 	*values = val;
 
 	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
-				       ddata->cmd_gpios->desc, values);
+				       ddata->cmd_gpios->desc,
+				       ddata->cmd_gpios->info, values);
 }
 
 /**
@@ -181,6 +182,7 @@ static void phy_mdm6600_status(struct work_struct *work)
 
 	error = gpiod_get_array_value_cansleep(PHY_MDM6600_NR_STATUS_LINES,
 					       ddata->status_gpios->desc,
+					       ddata->status_gpios->info,
 					       values);
 	if (error)
 		return;
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 053c9b7f1084..d32dba23e782 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -230,7 +230,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		*values = ret;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(3, st->gpio_os->desc, values);
+		gpiod_set_array_value(3, st->gpio_os->desc, st->gpio_os->info,
+				      values);
 		st->oversampling = val;
 		mutex_unlock(&st->lock);
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 30444fd6cf32..d7934ca55e2f 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -53,7 +53,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 				     !!(mctrl & mctrl_gpios_desc[i].mctrl));
 			count++;
 		}
-	gpiod_set_array_value(count, desc_array, values);
+	gpiod_set_array_value(count, desc_array, NULL, values);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 8dede3e886af..bf037ebe2ed8 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -114,36 +114,44 @@ int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
 int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
 			  struct gpio_desc **desc_array,
+			  struct gpio_array *array_info,
 			  unsigned long *value_bitmap);
 void gpiod_set_value(struct gpio_desc *desc, int value);
 void gpiod_set_array_value(unsigned int array_size,
 			   struct gpio_desc **desc_array,
+			   struct gpio_array *array_info,
 			   unsigned long *value_bitmap);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
+			      struct gpio_array *array_info,
 			      unsigned long *value_bitmap);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
+			       struct gpio_array *array_info,
 			       unsigned long *value_bitmap);
 
 /* Value get/set from sleeping context */
 int gpiod_get_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
+				   struct gpio_array *array_info,
 				   unsigned long *value_bitmap);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
+				    struct gpio_array *array_info,
 				    unsigned long *value_bitmap);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
+				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
+					struct gpio_array *array_info,
 					unsigned long *value_bitmap);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
-- 
2.16.4

