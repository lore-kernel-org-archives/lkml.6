Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0017721722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVtXp4GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0017721722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeHUDAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:00:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51496 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeHUDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:00:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so1176377wma.1;
        Mon, 20 Aug 2018 16:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLEz5YDk/S+SzRglbAXUAYm/+jPKdI6d73xLAxFOXQ8=;
        b=hVtXp4GFLLFT9I3VRLGWUj9kJFMJji9s0UGL1lpONZIAfid2+O4831/KI8Nkmh/LRA
         Zw9Oe1dfa7Q4Q5+f5rlmPXIJsOihVzIkSYBgNMe4ORhupvnsiItL9sOsUqphk10gsOsF
         9y401Z7/AM8fQBFcNuCfmSgUYqPZo71k+KXzg5ntPuhbCAmp5cb4XdWZDMfCr5z7EjNZ
         QXwJ91KLnkyirYHaGkEn9kcTBcIive97X1Ara7UDoq68L1QaKZVbz+dtFPdkvDoKurX3
         noe+/znsSFyUW3pGKPkFLnYmyTWFlJULji+tSd6MroExgYFDkFwlLwGYt7Bnz8Ho7VTY
         6rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLEz5YDk/S+SzRglbAXUAYm/+jPKdI6d73xLAxFOXQ8=;
        b=JnN1T6jJVclrvoJvffg4kydTFZHi0z9WK0GNJvCX5Eu76GxF8K+UaQf1hHfpRh4VbF
         Qk2/Ll+scJhFdwk2I1/03zCVmkDIlNotEgPpin7Dv2i35RVfcKF3E2A0V3XRi4o9FyMv
         J3aufaiSQVyl+nZvrIFD24/mIIINqD3Es1NUZ9XGDvLNj/uv/0vq3nuar5RiIMDH4Kmr
         WUvBZ4JbRiBRYJnYdaE8NY9zlQ3GcYpQddiG5f2vo0qYuN/KIoZqtn8l9tHyujLA2vkS
         mHDLaeC5gmk/zFFGFrnc+NTeR/guws6/P92zUiNuUIlML5Hr0Rp+9NRt7QZM7ZCBN7qJ
         u4xQ==
X-Gm-Message-State: AOUpUlE/WHcnQtxzDBG6pCx1ApVMdm5gtX/fMC/XqpAfQyV2Fw3lVhnP
        LeeiZbOxktCeDjBMUKI8PB8=
X-Google-Smtp-Source: AA+uWPwg8/ZOsR2NntA7dQNcvgZ3LEbs+isp9NK9Yfai7zS399EYCXKaN61/ng3Rygw7RFh8N6XrXg==
X-Received: by 2002:a1c:8955:: with SMTP id l82-v6mr25896313wmd.110.1534808577778;
        Mon, 20 Aug 2018 16:42:57 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1197634wmg.45.2018.08.20.16.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:42:57 -0700 (PDT)
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC RFT PATCH v4 4/4] gpiolib: Implement fast processing path in get/set array
Date:   Tue, 21 Aug 2018 01:43:41 +0200
Message-Id: <20180820234341.5271-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GPIO descriptor arrays returned by gpio_get_array() may contain
information on direct mapping of array members to pins of a single GPIO
chip in hardware order.  In such cases, bitmaps of values can be passed
directly from/to the chip's .get/set_multiple() callbacks without
wasting time on iterations.

Add respective code to gpiod_get/set_array_bitmap_complex() functions.
Pins not applicable for fast path are processed as before, skipping
over the 'fast' ones.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/board.rst    | 15 ++++++
 Documentation/driver-api/gpio/consumer.rst |  8 +++
 drivers/gpio/gpiolib.c                     | 87 ++++++++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 2c112553df84..c66821e033c2 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -193,3 +193,18 @@ And the table can be added to the board code as follows::
 
 The line will be hogged as soon as the gpiochip is created or - in case the
 chip was created earlier - when the hog table is registered.
+
+Arrays of pins
+--------------
+In addition to requesting pins belonging to a function one by one, a device may
+also request an array of pins assigned to the function.  The way those pins are
+mapped to the device determines if the array qualifies for fast bitmap
+processing.  If yes, a bitmap is passed over get/set array functions directly
+between a caller and a respective .get/set_multiple() callback of a GPIO chip.
+
+In order to qualify for fast bitmap processing, the pin mapping must meet the
+following requirements:
+- it must belong to the same chip as other 'fast' pins of the function,
+- its index within the function must match its hardware number within the chip.
+
+Open drain and open source pins are excluded from fast bitmap output processing.
diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index 0afd95a12b10..cf992e5ab976 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -388,6 +388,14 @@ array_info should be set to NULL.
 Note that for optimal performance GPIOs belonging to the same chip should be
 contiguous within the array of descriptors.
 
+Still better performance may be achieved if array indexes of the descriptors
+match hardware pin numbers of a single chip.  If an array passed to a get/set
+array function matches the one obtained from gpiod_get_array() and array_info
+associated with the array is also passed, the function may take a fast bitmap
+processing path, passing the value_bitmap argument directly to the respective
+.get/set_multiple() callback of the chip.  That allows for utilization of GPIO
+banks as data I/O ports without much loss of performance.
+
 The return value of gpiod_get_array_value() and its variants is 0 on success
 or negative on error. Note the difference to gpiod_get_value(), which returns
 0 or 1 on success to convey the GPIO value. With the array functions, the GPIO
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4d26cdbdb7cf..b799a89c4c17 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2787,7 +2787,36 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  struct gpio_array *array_info,
 				  unsigned long *value_bitmap)
 {
-	int i = 0;
+	int err, i = 0;
+
+	/*
+	 * Validate array_info against desc_array and its size.
+	 * It should immediately follow desc_array if both
+	 * have been obtained from the same gpiod_get_array() call.
+	 */
+	if (array_info && array_info->desc == desc_array &&
+	    array_size <= array_info->size &&
+	    (void *)array_info == desc_array + array_info->size) {
+		if (!can_sleep)
+			WARN_ON(array_info->chip->can_sleep);
+
+		err = gpio_chip_get_multiple(array_info->chip,
+					     array_info->get_mask,
+					     value_bitmap);
+		if (err)
+			return err;
+
+		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
+			bitmap_xor(value_bitmap, value_bitmap,
+				   array_info->invert_mask, array_size);
+
+		if (bitmap_full(array_info->get_mask, array_size))
+			return 0;
+
+		i = find_first_zero_bit(array_info->get_mask, array_size);
+	} else {
+		array_info = NULL;
+	}
 
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
@@ -2818,7 +2847,12 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 
 			__set_bit(hwgpio, mask);
-			i++;
+
+			if (array_info)
+				find_next_zero_bit(array_info->get_mask,
+						   array_size, i);
+			else
+				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 
@@ -2829,7 +2863,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			return ret;
 		}
 
-		for (j = first; j < i; j++) {
+		for (j = first; j < i; ) {
 			const struct gpio_desc *desc = desc_array[j];
 			int hwgpio = gpio_chip_hwgpio(desc);
 			int value = test_bit(hwgpio, bits);
@@ -2838,6 +2872,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				value = !value;
 			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
+
+			if (array_info)
+				find_next_zero_bit(array_info->get_mask, i, j);
+			else
+				j++;
 		}
 
 		if (mask != fastpath)
@@ -3039,6 +3078,32 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 {
 	int i = 0;
 
+	/*
+	 * Validate array_info against desc_array and its size.
+	 * It should immediately follow desc_array if both
+	 * have been obtained from the same gpiod_get_array() call.
+	 */
+	if (array_info && array_info->desc == desc_array &&
+	    array_size <= array_info->size &&
+	    (void *)array_info == desc_array + array_info->size) {
+		if (!can_sleep)
+			WARN_ON(array_info->chip->can_sleep);
+
+		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
+			bitmap_xor(value_bitmap, value_bitmap,
+				   array_info->invert_mask, array_size);
+
+		gpio_chip_set_multiple(array_info->chip, array_info->set_mask,
+				       value_bitmap);
+
+		if (bitmap_full(array_info->set_mask, array_size))
+			return 0;
+
+		i = find_first_zero_bit(array_info->set_mask, array_size);
+	} else {
+		array_info = NULL;
+	}
+
 	while (i < array_size) {
 		struct gpio_chip *chip = desc_array[i]->gdev->chip;
 		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
@@ -3066,7 +3131,14 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 			int value = test_bit(i, value_bitmap);
 
-			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+			/*
+			 * Pins applicable for fast input but not for
+			 * fast output processing may have been already
+			 * inverted inside the fast path, skip them.
+			 */
+			if (!raw && !(array_info &&
+			    test_bit(i, array_info->invert_mask)) &&
+			    test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 				value = !value;
 			trace_gpio_value(desc_to_gpio(desc), 0, value);
 			/*
@@ -3085,7 +3157,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 					__clear_bit(hwgpio, bits);
 				count++;
 			}
-			i++;
+
+			if (array_info)
+				find_next_zero_bit(array_info->set_mask,
+						   array_size, i);
+			else
+				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 		/* push collected bits to outputs */
-- 
2.16.4

