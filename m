Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B001C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90F621763
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuSi++rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F621763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeHUDBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:01:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33192 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUDAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:00:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id i134-v6so8232307wmf.0;
        Mon, 20 Aug 2018 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StURJd4arYEsJf1LOMGESRiF33V5550vQlBFGtzuka8=;
        b=fuSi++rtwMMEIaO4rAQkbneP3J77Ig0A6TGuR0QJWtMBAf2qVB1jfb9lul78h0a1WP
         cNA/5IZQU8Q4xe0+k/OrQQVVGTs8VSPceP/hx4sYwKMdCpzeOhowb2yBEznTwj37rKPH
         AFtt9BNahHcGYTkEFfKL+ey5VXbgz6DlixjIRavWX3mKiRRHd4mVTX8Al6uT7G34xGrf
         W3EtgOj/h2uf7SS9MuUkDXxFbKfOFr/h5ypMviVFA+TW5Z7V6nJBGzdCpUQ6hxNz/H23
         20mY/oPOTvW5xL8irz4yXKds1RVpPICtedkB1Gqvx+y0RUlq+211H4JDqMOx44qrkm5g
         puqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StURJd4arYEsJf1LOMGESRiF33V5550vQlBFGtzuka8=;
        b=FfIMcopIDei4wUdIJMhyzie2sd+C3Nj68NYkn6fWkWa2xipPTAI5x3D5Nr87UuEqsy
         hPVCHZBmdqjnaUxBzZXJCvJVIBqWwhWGY1/mN2dJec0qdmTqHuUTTjb+6t9NmeR1+7Iw
         iffUW+d68i6i4l7o4tMhcbegv1FyoNime+YQrhRnZAoejE5IEs164BWbodP2WJlgWmuY
         6GHos4/uVacmP8J0Gptu5uhgcPqzCvmIRyjXFrQ0SeICacnbGOzlAKlLfGj5tJbpZCk6
         62UfLRXyJglVvTuRXiAbh6C5So2CaHKm5DvqKBtt1M3YKC480iZSon6shKGx2aR8cLYl
         Scpw==
X-Gm-Message-State: AOUpUlHRpaVQ3urnyq4zQnLilKn0MFvl6aJZfZQfYAIhxTK0htWAWYQo
        6RSZhN6FyrOIvyqH3LI1JSQ=
X-Google-Smtp-Source: AA+uWPwwDz/gJ4P6x6v75KZsn3vUcq+3+rqbDiVXIZkOoQktbE9lndr/IbguOLa8awlvfk4ofeeSIg==
X-Received: by 2002:a1c:55c8:: with SMTP id j191-v6mr26675017wmb.67.1534808574079;
        Mon, 20 Aug 2018 16:42:54 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1197634wmg.45.2018.08.20.16.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:42:53 -0700 (PDT)
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
Subject: [RFC RFT PATCH v4 2/4] gpiolib: Identify arrays matching GPIO hardware
Date:   Tue, 21 Aug 2018 01:43:39 +0200
Message-Id: <20180820234341.5271-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain GPIO array lookup results may map directly to GPIO pins of a
single GPIO chip in hardware order.  If that condition is recognized
and handled efficiently, significant performance gain of get/set array
functions may be possible.

While processing a request for an array of GPIO descriptors, identify
those which represent corresponding pins of a single GPIO chip.  Skip
over pins which require open source or open drain special processing.
Moreover, identify pins which require inversion.  Pass a pointer to
that information with the array to the caller so it can benefit from
enhanced performance as soon as get/set array functions can accept and
make efficient use of it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  4 +-
 drivers/gpio/gpiolib.c                     | 72 +++++++++++++++++++++++++++++-
 drivers/gpio/gpiolib.h                     |  9 ++++
 include/linux/gpio/consumer.h              |  9 ++++
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index ed68042ddccf..7e0298b9a7b9 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -109,9 +109,11 @@ For a function using multiple GPIOs all of those can be obtained with one call::
 					   enum gpiod_flags flags)
 
 This function returns a struct gpio_descs which contains an array of
-descriptors::
+descriptors.  It also contains a pointer to a gpiolib private structure which,
+if passed back to get/set array functions, may speed up I/O proocessing::
 
 	struct gpio_descs {
+		struct gpio_array *info;
 		unsigned int ndescs;
 		struct gpio_desc *desc[];
 	}
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f0e9ffa8cab6..c1ed1c759345 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4174,7 +4174,9 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 {
 	struct gpio_desc *desc;
 	struct gpio_descs *descs;
-	int count;
+	struct gpio_array *array_info = NULL;
+	struct gpio_chip *chip;
+	int count, bitmap_size;
 
 	count = gpiod_count(dev, con_id);
 	if (count < 0)
@@ -4190,9 +4192,77 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 			gpiod_put_array(descs);
 			return ERR_CAST(desc);
 		}
+
 		descs->desc[descs->ndescs] = desc;
+
+		chip = gpiod_to_chip(desc);
+		/*
+		 * Select a chip of first array member
+		 * whose index matches its pin hardware number
+		 * as a candidate for fast bitmap processing.
+		 */
+		if (!array_info && gpio_chip_hwgpio(desc) == descs->ndescs) {
+			struct gpio_descs *array;
+
+			bitmap_size = BITS_TO_LONGS(chip->ngpio > count ?
+						    chip->ngpio : count);
+
+			array = kzalloc(struct_size(descs, desc, count) +
+					struct_size(array_info, invert_mask,
+					3 * bitmap_size), GFP_KERNEL);
+			if (!array) {
+				gpiod_put_array(descs);
+				return ERR_PTR(-ENOMEM);
+			}
+
+			memcpy(array, descs,
+			       struct_size(descs, desc, descs->ndescs + 1));
+			kfree(descs);
+
+			descs = array;
+			array_info = (void *)(descs->desc + count);
+			array_info->get_mask = array_info->invert_mask +
+						  bitmap_size;
+			array_info->set_mask = array_info->get_mask +
+						  bitmap_size;
+
+			array_info->desc = descs->desc;
+			array_info->size = count;
+			array_info->chip = chip;
+			bitmap_set(array_info->get_mask, descs->ndescs,
+				   count - descs->ndescs);
+			bitmap_set(array_info->set_mask, descs->ndescs,
+				   count - descs->ndescs);
+			descs->info = array_info;
+		}
+		/*
+		 * Unmark members which don't qualify for fast bitmap
+		 * processing (different chip, not in hardware order)
+		 */
+		if (array_info && (chip != array_info->chip ||
+		    gpio_chip_hwgpio(desc) != descs->ndescs)) {
+			__clear_bit(descs->ndescs, array_info->get_mask);
+			__clear_bit(descs->ndescs, array_info->set_mask);
+		} else if (array_info) {
+			/* Exclude open drain or open source from fast output */
+			if (gpiochip_line_is_open_drain(chip, descs->ndescs) ||
+			    gpiochip_line_is_open_source(chip, descs->ndescs))
+				__clear_bit(descs->ndescs,
+					    array_info->set_mask);
+			/* Identify 'fast' pins which require invertion */
+			if (gpiod_is_active_low(desc))
+				__set_bit(descs->ndescs,
+					  array_info->invert_mask);
+		}
+
 		descs->ndescs++;
 	}
+	if (array_info)
+		dev_dbg(dev,
+			"GPIO array info: chip=%s, size=%d, get_mask=%lx, set_mask=%lx, invert_mask=%lx\n",
+			array_info->chip->label, array_info->size,
+			*array_info->get_mask, *array_info->set_mask,
+			*array_info->invert_mask);
 	return descs;
 }
 EXPORT_SYMBOL_GPL(gpiod_get_array);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 11e83d2eef89..b60905d558b1 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -183,6 +183,15 @@ static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
 }
 #endif
 
+struct gpio_array {
+	struct gpio_desc	**desc;
+	unsigned int		size;
+	struct gpio_chip	*chip;
+	unsigned long		*get_mask;
+	unsigned long		*set_mask;
+	unsigned long		invert_mask[];
+};
+
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip, u16 hwnum);
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 1b21dc7b0fad..8dede3e886af 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -17,11 +17,20 @@ struct device;
  */
 struct gpio_desc;
 
+/**
+ * Opaque descriptor for a structure of GPIO array attributes.  This structure
+ * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
+ * passed back to get/set array functions in order to activate fast processing
+ * path if applicable.
+ */
+struct gpio_array;
+
 /**
  * Struct containing an array of descriptors that can be obtained using
  * gpiod_get_array().
  */
 struct gpio_descs {
+	struct gpio_array *info;
 	unsigned int ndescs;
 	struct gpio_desc *desc[];
 };
-- 
2.16.4

