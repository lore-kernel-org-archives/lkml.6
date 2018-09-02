Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14E20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdrILBo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C14E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIBQQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 12:16:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43765 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 12:16:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so13119340lfi.10;
        Sun, 02 Sep 2018 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kaeCdDVQIew8mjGJ5ZxydvdcTd9icxb40grHlRSzLo=;
        b=hdrILBo+h7Lo91fw0VMhoaivyN+KhV3mgea5YEMsMo3t/6BgqkFkORSPxuCuEh4YWt
         prdcWtB7BdwpyS1QpPiCEjeKfw+bkZWedDmxe+uGuWsZWu9zQ8GpQn37LDUmGbrZPwPC
         HDnhI512PVQkhnGJ8NQvfmDUMYR6eChVEsM+JgCecdohganKv1tdaoySbmXwtAhTLz7u
         a71mCmUHqA2tmuIR+X+vrmUw6hskrq7fAcOqWDheOcf7t8hHyq+JKiDwOKOKqhfE/KTF
         ciKPeOmDJxvZkDnM2ltaMcjEJ5ta7WAKqxG8Ta8obuAO4xNfafwmf3OJ4uPvkjsRDHJo
         cLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kaeCdDVQIew8mjGJ5ZxydvdcTd9icxb40grHlRSzLo=;
        b=ZJA7sU8JqXCRMT7Oryc4jWqWMLfFfXyhiZ5VuxdlumvSqqmPr1dCZpY5Pf+s3EmbOT
         aVL6SBLAex0yTV21eh8+CB6t2cuEbig8auOPPN22V1bbW3t9cZI+yQ5U7BDy8MBE54Hy
         L67gfaK0gQK7eS75zRq9jTrybsAydngGYa4RugqeJGVrluKvIw4Tgb6hNWGRJGvzULLh
         UbAKcoJHvVTa575TGisQLoAh0w0C50osVKgp3wEt9iCM9rr24s4d21dsm3xxxrIuVf/2
         Rm+ZtK1khzCNTuaAS4s7RNwGBcQiviEV1xfjPKL7wtWhJTHspI3T5OJQMlnS+R4lTajj
         z/bw==
X-Gm-Message-State: APzg51BecnNpP5+BrquUeARk2vxkx+xIOXWPjrvEAKMGP7HFyjNXPIzu
        C0NTCgUHbGOLP8V+Uz021Gk=
X-Google-Smtp-Source: ANB0VdaHozmwLL1luAZlvywkTeTlSXUircqeoBaPCuEG9UOyu9ecqqnaTnB0ZbGmbtk8w026Hx5x/A==
X-Received: by 2002:a19:4f12:: with SMTP id d18-v6mr14806360lfb.121.1535889666385;
        Sun, 02 Sep 2018 05:01:06 -0700 (PDT)
Received: from localhost.localdomain (apn-37-248-210-194.dynamic.gprs.plus.pl. [37.248.210.194])
        by smtp.gmail.com with ESMTPSA id n3-v6sm2760321lji.96.2018.09.02.05.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 05:01:05 -0700 (PDT)
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
Subject: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date:   Sun,  2 Sep 2018 14:01:41 +0200
Message-Id: <20180902120144.6855-2-jmkrzyszt@gmail.com>
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

Most users of get/set array functions iterate consecutive bits of data,
usually a single integer, while processing array of results obtained
from, or building an array of values to be passed to those functions.
Save time wasted on those iterations by changing the functions' API to
accept bitmaps.

All current users are updated as well.

More benefits from the change are expected as soon as planned support
for accepting/passing those bitmaps directly from/to respective GPIO
chip callbacks if applicable is implemented.

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
 Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
 drivers/auxdisplay/hd44780.c                | 59 +++++++--------------
 drivers/bus/ts-nbus.c                       | 15 ++----
 drivers/gpio/gpio-max3191x.c                | 10 ++--
 drivers/gpio/gpiolib.c                      | 82 +++++++++++++++--------------
 drivers/gpio/gpiolib.h                      |  4 +-
 drivers/i2c/muxes/i2c-mux-gpio.c            | 13 ++---
 drivers/mmc/core/pwrseq_simple.c            | 13 ++---
 drivers/mux/gpio.c                          | 13 ++---
 drivers/net/phy/mdio-mux-gpio.c             | 11 ++--
 drivers/pcmcia/soc_common.c                 |  8 +--
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 13 ++---
 drivers/staging/iio/adc/ad7606.c            |  9 ++--
 drivers/tty/serial/serial_mctrl_gpio.c      |  7 +--
 include/linux/gpio/consumer.h               | 18 ++++---
 15 files changed, 129 insertions(+), 168 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index aa03f389d41d..ed68042ddccf 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -323,29 +323,29 @@ The following functions get or set the values of an array of GPIOs::
 
 	int gpiod_get_array_value(unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array);
+				  unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value(unsigned int array_size,
 				      struct gpio_desc **desc_array,
-				      int *value_array);
+				      unsigned long *value_bitmap);
 	int gpiod_get_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
-					   int *value_array);
+					   unsigned long *value_bitmap);
 	int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 					   struct gpio_desc **desc_array,
-					   int *value_array);
+					   unsigned long *value_bitmap);
 
 	void gpiod_set_array_value(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array)
+				       unsigned long *value_bitmap)
 	void gpiod_set_array_value_cansleep(unsigned int array_size,
 					    struct gpio_desc **desc_array,
-					    int *value_array)
+					    unsigned long *value_bitmap)
 	void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 						struct gpio_desc **desc_array,
-						int *value_array)
+						unsigned long *value_bitmap)
 
 The array can be an arbitrary set of GPIOs. The functions will try to access
 GPIOs belonging to the same bank or chip simultaneously if supported by the
@@ -356,8 +356,8 @@ accessed sequentially.
 The functions take three arguments:
 	* array_size	- the number of array elements
 	* desc_array	- an array of GPIO descriptors
-	* value_array	- an array to store the GPIOs' values (get) or
-			  an array of values to assign to the GPIOs (set)
+	* value_bitmap	- a bitmap to store the GPIOs' values (get) or
+			  a bitmap of values to assign to the GPIOs (set)
 
 The descriptor array can be obtained using the gpiod_get_array() function
 or one of its variants. If the group of descriptors returned by that function
@@ -366,7 +366,7 @@ the struct gpio_descs returned by gpiod_get_array()::
 
 	struct gpio_descs *my_gpio_descs = gpiod_get_array(...);
 	gpiod_set_array_value(my_gpio_descs->ndescs, my_gpio_descs->desc,
-			      my_gpio_values);
+			      my_gpio_value_bitmap);
 
 It is also possible to access a completely arbitrary array of descriptors. The
 descriptors may be obtained using any combination of gpiod_get() and
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index f1a42f0f1ded..333e30e378b5 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
 /* write to an LCD panel register in 8 bit GPIO mode */
 static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 {
-	int values[10];	/* for DATA[0-7], RS, RW */
-	unsigned int i, n;
-
-	for (i = 0; i < 8; i++)
-		values[PIN_DATA0 + i] = !!(val & BIT(i));
-	values[PIN_CTRL_RS] = rs;
-	n = 9;
-	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
-		n++;
-	}
+	DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
+	unsigned int n;
+
+	*values = val;
+	__assign_bit(8, values, rs);
+	n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
 
 	/* Present the data to the port */
 	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
@@ -83,32 +78,25 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
 /* write to an LCD panel register in 4 bit GPIO mode */
 static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 {
-	int values[10];	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
-	unsigned int i, n;
+	DECLARE_BITMAP(values, 6); /* for DATA[4-7], RS, RW */
+	unsigned int n;
 
 	/* High nibble + RS, RW */
-	for (i = 4; i < 8; i++)
-		values[PIN_DATA0 + i] = !!(val & BIT(i));
-	values[PIN_CTRL_RS] = rs;
-	n = 5;
-	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
-		n++;
-	}
+	*values = val >> 4;
+	__assign_bit(4, values, rs);
+	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
 
 	hd44780_strobe_gpio(hd);
 
 	/* Low nibble */
-	for (i = 0; i < 4; i++)
-		values[PIN_DATA4 + i] = !!(val & BIT(i));
+	*values &= ~0x0fUL;
+	*values |= val & 0x0f;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
 
 	hd44780_strobe_gpio(hd);
 }
@@ -155,23 +143,16 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
 static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 {
-	int values[10];	/* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
+	DECLARE_BITMAP(values, 6); /* for DATA[4-7], RS, RW */
 	struct hd44780 *hd = lcd->drvdata;
-	unsigned int i, n;
+	unsigned int n;
 
 	/* Command nibble + RS, RW */
-	for (i = 0; i < 4; i++)
-		values[PIN_DATA4 + i] = !!(cmd & BIT(i));
-	values[PIN_CTRL_RS] = 0;
-	n = 5;
-	if (hd->pins[PIN_CTRL_RW]) {
-		values[PIN_CTRL_RW] = 0;
-		n++;
-	}
+	*values = cmd & 0x0f;
+	n = hd->pins[PIN_CTRL_RW] ? 6 : 5;
 
 	/* Present the data to the port */
-	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
-				       &values[PIN_DATA4]);
+	gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], values);
 
 	hd44780_strobe_gpio(hd);
 }
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
index 073fd9011154..6499957a8044 100644
--- a/drivers/bus/ts-nbus.c
+++ b/drivers/bus/ts-nbus.c
@@ -110,11 +110,9 @@ static void ts_nbus_set_direction(struct ts_nbus *ts_nbus, int direction)
  */
 static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
 {
-	int i;
-	int values[8];
+	DECLARE_BITMAP(values, 8);
 
-	for (i = 0; i < 8; i++)
-		values[i] = 0;
+	*values = 0;
 
 	gpiod_set_array_value_cansleep(8, ts_nbus->data->desc, values);
 	gpiod_set_value_cansleep(ts_nbus->csn, 0);
@@ -157,14 +155,9 @@ static int ts_nbus_read_byte(struct ts_nbus *ts_nbus, u8 *val)
 static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
 {
 	struct gpio_descs *gpios = ts_nbus->data;
-	int i;
-	int values[8];
+	DECLARE_BITMAP(values, 8);
 
-	for (i = 0; i < 8; i++)
-		if (byte & BIT(i))
-			values[i] = 1;
-		else
-			values[i] = 0;
+	*values = byte;
 
 	gpiod_set_array_value_cansleep(8, gpios->desc, values);
 }
diff --git a/drivers/gpio/gpio-max3191x.c b/drivers/gpio/gpio-max3191x.c
index b5b9cb1fda50..bd4a245fc5a0 100644
--- a/drivers/gpio/gpio-max3191x.c
+++ b/drivers/gpio/gpio-max3191x.c
@@ -315,14 +315,16 @@ static void gpiod_set_array_single_value_cansleep(unsigned int ndescs,
 						  struct gpio_desc **desc,
 						  int value)
 {
-	int i, *values;
+	unsigned long *values;
 
-	values = kmalloc_array(ndescs, sizeof(*values), GFP_KERNEL);
+	values = bitmap_alloc(ndescs, GFP_KERNEL);
 	if (!values)
 		return;
 
-	for (i = 0; i < ndescs; i++)
-		values[i] = value;
+	if (value)
+		bitmap_fill(values, ndescs);
+	else
+		bitmap_zero(values, ndescs);
 
 	gpiod_set_array_value_cansleep(ndescs, desc, values);
 	kfree(values);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8f8a1999393..434d09779a1f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -427,7 +427,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 	struct linehandle_state *lh = filep->private_data;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
-	int vals[GPIOHANDLES_MAX];
+	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
 	int i;
 
 	if (cmd == GPIOHANDLE_GET_LINE_VALUES_IOCTL) {
@@ -442,7 +442,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 
 		memset(&ghd, 0, sizeof(ghd));
 		for (i = 0; i < lh->numdescs; i++)
-			ghd.values[i] = vals[i];
+			ghd.values[i] = test_bit(i, vals);
 
 		if (copy_to_user(ip, &ghd, sizeof(ghd)))
 			return -EFAULT;
@@ -461,7 +461,7 @@ static long linehandle_ioctl(struct file *filep, unsigned int cmd,
 
 		/* Clamp all values to [0,1] */
 		for (i = 0; i < lh->numdescs; i++)
-			vals[i] = !!ghd.values[i];
+			__assign_bit(i, vals, !!ghd.values[i]);
 
 		/* Reuse the array setting function */
 		return gpiod_set_array_value_complex(false,
@@ -2784,7 +2784,7 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array)
+				  unsigned long *value_bitmap)
 {
 	int i = 0;
 
@@ -2835,7 +2835,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 
 			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
-			value_array[j] = value;
+			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 		}
 
@@ -2895,9 +2895,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
 
 /**
  * gpiod_get_raw_array_value() - read raw values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
@@ -2907,20 +2907,21 @@ EXPORT_SYMBOL_GPL(gpiod_get_value);
  * and it will complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_get_raw_array_value(unsigned int array_size,
-			      struct gpio_desc **desc_array, int *value_array)
+			      struct gpio_desc **desc_array,
+			      unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, false, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
 
 /**
  * gpiod_get_array_value() - read values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitnap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.  Return 0 in case of success, else an error code.
@@ -2929,12 +2930,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value);
  * and it will complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_get_array_value(unsigned int array_size,
-			  struct gpio_desc **desc_array, int *value_array)
+			  struct gpio_desc **desc_array,
+			  unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, false, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value);
 
@@ -3027,7 +3029,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *chip,
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 {
 	int i = 0;
 
@@ -3056,7 +3058,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		do {
 			struct gpio_desc *desc = desc_array[i];
 			int hwgpio = gpio_chip_hwgpio(desc);
-			int value = value_array[i];
+			int value = test_bit(i, value_bitmap);
 
 			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
@@ -3152,9 +3154,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
 
 /**
  * gpiod_set_raw_array_value() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.
@@ -3163,20 +3165,21 @@ EXPORT_SYMBOL_GPL(gpiod_set_value);
  * complain if the GPIO chip functions potentially sleep.
  */
 int gpiod_set_raw_array_value(unsigned int array_size,
-			 struct gpio_desc **desc_array, int *value_array)
+			 struct gpio_desc **desc_array,
+			 unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, false, array_size,
-					desc_array, value_array);
+					desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
 
 /**
  * gpiod_set_array_value() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.
@@ -3185,12 +3188,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value);
  * complain if the GPIO chip functions potentially sleep.
  */
 void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array)
+			   struct gpio_desc **desc_array,
+			   unsigned long *value_bitmap)
 {
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, false, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value);
 
@@ -3410,9 +3414,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
 
 /**
  * gpiod_get_raw_array_value_cansleep() - read raw values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.  Return 0 in case of success,
@@ -3422,21 +3426,21 @@ EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
  */
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array)
+				       unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(true, true, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
 
 /**
  * gpiod_get_array_value_cansleep() - read values from an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be read
- * @value_array: array to store the read values
+ * @value_bitmap: bitmap to store the read values
  *
  * Read the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.  Return 0 in case of success, else an error code.
@@ -3445,13 +3449,13 @@ EXPORT_SYMBOL_GPL(gpiod_get_raw_array_value_cansleep);
  */
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array)
+				   unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_get_array_value_complex(false, true, array_size,
-					     desc_array, value_array);
+					     desc_array, value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
 
@@ -3493,9 +3497,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
 
 /**
  * gpiod_set_raw_array_value_cansleep() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the raw values of the GPIOs, i.e. the values of the physical lines
  * without regard for their ACTIVE_LOW status.
@@ -3504,13 +3508,13 @@ EXPORT_SYMBOL_GPL(gpiod_set_value_cansleep);
  */
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
-					int *value_array)
+					unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return -EINVAL;
 	return gpiod_set_array_value_complex(true, true, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_raw_array_value_cansleep);
 
@@ -3533,9 +3537,9 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
 
 /**
  * gpiod_set_array_value_cansleep() - assign values to an array of GPIOs
- * @array_size: number of elements in the descriptor / value arrays
+ * @array_size: number of elements in the descriptor array / value bitmap
  * @desc_array: array of GPIO descriptors whose values will be assigned
- * @value_array: array of values to assign
+ * @value_bitmap: bitmap of values to assign
  *
  * Set the logical values of the GPIOs, i.e. taking their ACTIVE_LOW status
  * into account.
@@ -3544,13 +3548,13 @@ void gpiod_add_lookup_tables(struct gpiod_lookup_table **tables, size_t n)
  */
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
-				    int *value_array)
+				    unsigned long *value_bitmap)
 {
 	might_sleep_if(extra_checks);
 	if (!desc_array)
 		return;
 	gpiod_set_array_value_complex(false, true, array_size, desc_array,
-				      value_array);
+				      value_bitmap);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a7e49fef73d4..11e83d2eef89 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -187,11 +187,11 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
-				  int *value_array);
+				  unsigned long *value_bitmap);
 int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 				   unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array);
+				   unsigned long *value_bitmap);
 
 /* This is just passed between gpiolib and devres */
 struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 401308e3d036..0717cfb56732 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -22,18 +22,15 @@ struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
 	unsigned gpio_base;
 	struct gpio_desc **gpios;
-	int *values;
 };
 
 static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
-	int i;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(val));
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		mux->values[i] = (val >> i) & 1;
+	*values = val;
 
-	gpiod_set_array_value_cansleep(mux->data.n_gpios,
-				       mux->gpios, mux->values);
+	gpiod_set_array_value_cansleep(mux->data.n_gpios, mux->gpios, values);
 }
 
 static int i2c_mux_gpio_select(struct i2c_mux_core *muxc, u32 chan)
@@ -182,15 +179,13 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 
 	muxc = i2c_mux_alloc(parent, &pdev->dev, mux->data.n_values,
-			     mux->data.n_gpios * sizeof(*mux->gpios) +
-			     mux->data.n_gpios * sizeof(*mux->values), 0,
+			     mux->data.n_gpios * sizeof(*mux->gpios), 0,
 			     i2c_mux_gpio_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
 	mux->gpios = muxc->priv;
-	mux->values = (int *)(mux->gpios + mux->data.n_gpios);
 	muxc->priv = mux;
 
 	platform_set_drvdata(pdev, muxc);
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index a8b9fee4d62a..5ad764c88b50 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,18 +40,13 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		int i, *values;
+		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
 		int nvalues = reset_gpios->ndescs;
 
-		values = kmalloc_array(nvalues, sizeof(int), GFP_KERNEL);
-		if (!values)
-			return;
+		*values = value;
 
-		for (i = 0; i < nvalues; i++)
-			values[i] = value;
-
-		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc, values);
-		kfree(values);
+		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
+					       values);
 	}
 }
 
diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 6fdd9316db8b..1b6b4cc22a2c 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -17,20 +17,17 @@
 
 struct mux_gpio {
 	struct gpio_descs *gpios;
-	int *val;
 };
 
 static int mux_gpio_set(struct mux_control *mux, int state)
 {
 	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
-	int i;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(state));
 
-	for (i = 0; i < mux_gpio->gpios->ndescs; i++)
-		mux_gpio->val[i] = (state >> i) & 1;
+	*values = state;
 
 	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
-				       mux_gpio->gpios->desc,
-				       mux_gpio->val);
+				       mux_gpio->gpios->desc, values);
 
 	return 0;
 }
@@ -58,13 +55,11 @@ static int mux_gpio_probe(struct platform_device *pdev)
 	if (pins < 0)
 		return pins;
 
-	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio) +
-				       pins * sizeof(*mux_gpio->val));
+	mux_chip = devm_mux_chip_alloc(dev, 1, sizeof(*mux_gpio));
 	if (IS_ERR(mux_chip))
 		return PTR_ERR(mux_chip);
 
 	mux_gpio = mux_chip_priv(mux_chip);
-	mux_gpio->val = (int *)(mux_gpio + 1);
 	mux_chip->ops = &mux_gpio_ops;
 
 	mux_gpio->gpios = devm_gpiod_get_array(dev, "mux", GPIOD_OUT_LOW);
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
index bc90764a8b8d..eb8c56b83c70 100644
--- a/drivers/net/phy/mdio-mux-gpio.c
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -20,23 +20,21 @@
 struct mdio_mux_gpio_state {
 	struct gpio_descs *gpios;
 	void *mux_handle;
-	int values[];
 };
 
 static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
 				   void *data)
 {
 	struct mdio_mux_gpio_state *s = data;
-	unsigned int n;
+	DECLARE_BITMAP(values, BITS_PER_TYPE(desired_child));
 
 	if (current_child == desired_child)
 		return 0;
 
-	for (n = 0; n < s->gpios->ndescs; n++)
-		s->values[n] = (desired_child >> n) & 1;
+	*values = desired_child;
 
 	gpiod_set_array_value_cansleep(s->gpios->ndescs, s->gpios->desc,
-				       s->values);
+				       values);
 
 	return 0;
 }
@@ -51,8 +49,7 @@ static int mdio_mux_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gpios))
 		return PTR_ERR(gpios);
 
-	s = devm_kzalloc(&pdev->dev, struct_size(s, values, gpios->ndescs),
-			 GFP_KERNEL);
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
 	if (!s) {
 		gpiod_put_array(gpios);
 		return -ENOMEM;
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index c5f2344c189b..388dbdc46129 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -351,15 +351,17 @@ static int soc_common_pcmcia_config_skt(
 
 	if (ret == 0) {
 		struct gpio_desc *descs[2];
-		int values[2], n = 0;
+		DECLARE_BITMAP(values, 2);
+		int n = 0;
 
 		if (skt->gpio_reset) {
 			descs[n] = skt->gpio_reset;
-			values[n++] = !!(state->flags & SS_RESET);
+			__assign_bit(n++, values, !!(state->flags & SS_RESET));
 		}
 		if (skt->gpio_bus_enable) {
 			descs[n] = skt->gpio_bus_enable;
-			values[n++] = !!(state->flags & SS_OUTPUT_ENA);
+			__assign_bit(n++, values,
+				     !!(state->flags & SS_OUTPUT_ENA));
 		}
 
 		if (n)
diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 0075fb0bef8c..4de7f4577433 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -157,12 +157,9 @@ static const struct phy_ops gpio_usb_ops = {
  */
 static void phy_mdm6600_cmd(struct phy_mdm6600 *ddata, int val)
 {
-	int values[PHY_MDM6600_NR_CMD_LINES];
-	int i;
+	DECLARE_BITMAP(values, PHY_MDM6600_NR_CMD_LINES);
 
-	val &= (1 << PHY_MDM6600_NR_CMD_LINES) - 1;
-	for (i = 0; i < PHY_MDM6600_NR_CMD_LINES; i++)
-		values[i] = (val & BIT(i)) >> i;
+	*values = val;
 
 	gpiod_set_array_value_cansleep(PHY_MDM6600_NR_CMD_LINES,
 				       ddata->cmd_gpios->desc, values);
@@ -176,7 +173,7 @@ static void phy_mdm6600_status(struct work_struct *work)
 {
 	struct phy_mdm6600 *ddata;
 	struct device *dev;
-	int values[PHY_MDM6600_NR_STATUS_LINES];
+	DECLARE_BITMAP(values, PHY_MDM6600_NR_STATUS_LINES);
 	int error, i, val = 0;
 
 	ddata = container_of(work, struct phy_mdm6600, status_work.work);
@@ -189,9 +186,9 @@ static void phy_mdm6600_status(struct work_struct *work)
 		return;
 
 	for (i = 0; i < PHY_MDM6600_NR_STATUS_LINES; i++) {
-		val |= values[i] << i;
+		val |= test_bit(i, values) << i;
 		dev_dbg(ddata->dev, "XXX %s: i: %i values[i]: %i val: %i\n",
-			__func__, i, values[i], val);
+			__func__, i, test_bit(i, values), val);
 	}
 	ddata->status = val;
 
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 25b9fcd5e3a4..053c9b7f1084 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -202,7 +202,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int values[3];
+	DECLARE_BITMAP(values, 3);
 	int ret, i;
 
 	switch (mask) {
@@ -227,13 +227,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		values[0] = (ret >> 0) & 1;
-		values[1] = (ret >> 1) & 1;
-		values[2] = (ret >> 2) & 1;
+		*values = ret;
 
 		mutex_lock(&st->lock);
-		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
-				      values);
+		gpiod_set_array_value(3, st->gpio_os->desc, values);
 		st->oversampling = val;
 		mutex_unlock(&st->lock);
 
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 1c06325beaca..30444fd6cf32 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -40,7 +40,7 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 {
 	enum mctrl_gpio_idx i;
 	struct gpio_desc *desc_array[UART_GPIO_MAX];
-	int value_array[UART_GPIO_MAX];
+	DECLARE_BITMAP(values, UART_GPIO_MAX);
 	unsigned int count = 0;
 
 	if (gpios == NULL)
@@ -49,10 +49,11 @@ void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl)
 	for (i = 0; i < UART_GPIO_MAX; i++)
 		if (gpios->gpio[i] && mctrl_gpios_desc[i].dir_out) {
 			desc_array[count] = gpios->gpio[i];
-			value_array[count] = !!(mctrl & mctrl_gpios_desc[i].mctrl);
+			__assign_bit(count, values,
+				     !!(mctrl & mctrl_gpios_desc[i].mctrl));
 			count++;
 		}
-	gpiod_set_array_value(count, desc_array, value_array);
+	gpiod_set_array_value(count, desc_array, values);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_set);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 21ddbe440030..1b21dc7b0fad 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -104,36 +104,38 @@ int gpiod_direction_output_raw(struct gpio_desc *desc, int value);
 /* Value get/set from non-sleeping context */
 int gpiod_get_value(const struct gpio_desc *desc);
 int gpiod_get_array_value(unsigned int array_size,
-			  struct gpio_desc **desc_array, int *value_array);
+			  struct gpio_desc **desc_array,
+			  unsigned long *value_bitmap);
 void gpiod_set_value(struct gpio_desc *desc, int value);
 void gpiod_set_array_value(unsigned int array_size,
-			   struct gpio_desc **desc_array, int *value_array);
+			   struct gpio_desc **desc_array,
+			   unsigned long *value_bitmap);
 int gpiod_get_raw_value(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value(unsigned int array_size,
 			      struct gpio_desc **desc_array,
-			      int *value_array);
+			      unsigned long *value_bitmap);
 void gpiod_set_raw_value(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value(unsigned int array_size,
 			       struct gpio_desc **desc_array,
-			       int *value_array);
+			       unsigned long *value_bitmap);
 
 /* Value get/set from sleeping context */
 int gpiod_get_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_array_value_cansleep(unsigned int array_size,
 				   struct gpio_desc **desc_array,
-				   int *value_array);
+				   unsigned long *value_bitmap);
 void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_array_value_cansleep(unsigned int array_size,
 				    struct gpio_desc **desc_array,
-				    int *value_array);
+				    unsigned long *value_bitmap);
 int gpiod_get_raw_value_cansleep(const struct gpio_desc *desc);
 int gpiod_get_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_desc **desc_array,
-				       int *value_array);
+				       unsigned long *value_bitmap);
 void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
-					int *value_array);
+					unsigned long *value_bitmap);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
-- 
2.16.4

