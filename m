Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5796ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E52152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKGdWD7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857E52152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeITVbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:31:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41788 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbeITVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:31:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so8841988ljy.8;
        Thu, 20 Sep 2018 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZUKZkRjOSKC0gRH2KkEyLqg7z+f7HpBCBgWNOvY3kM=;
        b=ZKGdWD7t+JWRrLxXOFwq6ekURLLV8uu1NInkzDbxEvY+jZ6B6caIPtCxaiD7bmng1s
         AjWpFiLSNeAuksmGwulKgbcP9R0aG1UUPnrEsZDuPeBmeQAfkoEh56xVD8LUaeprY11s
         ZINTt13pshooD4PuQA0bX1d5m3S+xq+LtTDHIbTcTEctNardu4AsKT0ygVoFBcWqBEdr
         K09Nb1w6BOUyLidzDYBUOECR/6kaUIrFejwv3bE8bnCcX/kCOAbN9wFhRi/zm7ZknfFc
         t4zisEVvNOw5Kvqg0pishytLkFGXxEq1/rzRUL3F/VLCTb6htbHezTDAC4420gP4p2Az
         DnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZUKZkRjOSKC0gRH2KkEyLqg7z+f7HpBCBgWNOvY3kM=;
        b=NUCx6amtc7l004LtTHI5uffcMAgb8Tu5+saYYb4njQDOcddOkjjg47Pe/Z99jvdS1x
         dCZayZeJCmGQI3VZd7QPkKGJ0h/gwLaWn5yiGfAbC6U1SvHl/frdRleQoZwgHsHtiPis
         5dr5w76eKnvzi9H2y+51gYu8nlPs88xWtydZSdHufMxz2ZW3AT+iHMUbk4ycPXD7V+Ny
         szr10J4YCTfizsWHFjJRcqNASsH+73xANgmmUyaQug6cUQfvwv4PSqKs/ahBVP5yC/DQ
         lyyYjvZTRX63+Q0MbZz1XA2eU4mppUxG0tW+A9LsNCZD824hjkYtjIJcIvtdm7ecXp5u
         jFgw==
X-Gm-Message-State: APzg51BsnaTlGb1k+i6x0EuDoxkoQzBFpd7H5PGxKt6dfh7Sw9XF666q
        Al/eVKbDvKvcvV368z1+itU=
X-Google-Smtp-Source: ANB0Vda0NBhkYHNKMe06K7UDmQPrYd8h8tZfIx6mePv7MJtoKujaLEsILd/mzNUISdlPFMZHvDy5HA==
X-Received: by 2002:a2e:1290:: with SMTP id 16-v6mr27458053ljs.94.1537458418094;
        Thu, 20 Sep 2018 08:46:58 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id l141-v6sm1782706lfg.55.2018.09.20.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 08:46:57 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
Date:   Thu, 20 Sep 2018 17:48:22 +0200
Message-ID: <9860023.SlBYqtbjDV@z50>
In-Reply-To: <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > information on direct mapping of array members to pins of a single GPIO
> > chip in hardware order.  In such cases, bitmaps of values can be passed
> > directly from/to the chip's .get/set_multiple() callbacks without
> > wasting time on iterations.
> >
> > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > Pins not applicable for fast path are processed as before, skipping
> > over the 'fast' ones.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> 
> I've just noticed that this patch landed in today's linux-next. Sadly it
> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
> 
> Booting hangs after detecting MMC cards. Reverting this patch fixes the
> boot. I will try later to add some debugs and investigate it further what
> really happens when booting hangs.

Hi Marek,

Thanks for reporting. Could you please try the following fix?

Thanks,
Janusz

From d7ecd435bfb4972766b63ac383a43875700c7452 Mon Sep 17 00:00:00 2001
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date: Thu, 20 Sep 2018 17:37:21 +0200
Subject: [PATCH] gpiolib: Fix bitmap index not updated

While skipping fast path bits, bitmap index is not updated with next
found zero bit position. Fix it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpiolib.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d21..5bc3447949c9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			__set_bit(hwgpio, mask);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask,
+				i = find_next_zero_bit(array_info->get_mask,
 						   array_size, i);
 			else
 				i++;
@@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask, i, j);
+				i = find_next_zero_bit(array_info->get_mask, i,
+						       j);
 			else
 				j++;
 		}
@@ -3192,7 +3193,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			}
 
 			if (array_info)
-				find_next_zero_bit(array_info->set_mask,
+				i = find_next_zero_bit(array_info->set_mask,
 						   array_size, i);
 			else
 				i++;
-- 
2.16.4




