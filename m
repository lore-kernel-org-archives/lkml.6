Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47DBECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C24C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9nzEVcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C24C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbeITWEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:04:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35408 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeITWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:04:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so8960501ljg.2;
        Thu, 20 Sep 2018 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UPtWUl6Yh7NRq4oZEu4K6wGXZnx26UbRhox6oV/oH4=;
        b=T9nzEVcKHbkS0N9olmvbKlcapG6lPHsVNt13Hug5keW+LOAnopW9H2KQZEKvY+Yr2U
         m8cFBK4aZ/yJ4Ny1aGvQdWHNLckm3pSZs55Y15JQwqajfCBgb5wsOKZSzbN3BL9roYO9
         8JC2tlOY7L4hoG8v49Ol+FoJxQ6Z5KY3McO8zZoE1TevEOjXRAfi7SBbHslXxYk+XkWV
         D0SM9N7FQmdV6pzLQPhQmKSfCRhn3QMsUqx98UMaimu6/k8GqqFC0Y/FcQ+Ua/nGBNoe
         K60aiNa+cpTzYm0PSPi/xja5b7TnNYkXqQGy/DMF1o9YRHDJzT5kd4gSjriSnQXTK0mL
         fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UPtWUl6Yh7NRq4oZEu4K6wGXZnx26UbRhox6oV/oH4=;
        b=lpc/4zc8LnK1MlX/9AaD9UhoXks2S7s4/5tHJzMzXGawJsdDyrXhE0XMs8qCgaXK2W
         ff+AJeFqmEDUDWReEjOBhT/0NuUafKoj3/op5S5Yv3LlqpZXzE+EzdrWlUzHv6DM/saY
         PU7oVlpXsqRBFMvuS10SiDmITDJiIoo+jmmzWuoB0VY6W2GM3Ht7JfJBFNHzq/oAXieM
         QYGT+S3OJ0ZWna/KVBtBgsEPFqROJrcKsenD9MZHkwvqI1R1sAnNyu8Rp6woVpuleHDU
         Koyg5buxTauPHXZu4K2O8I8svn4P43hgQPnoQAhlgfIhfYteTzjREzDSTYJAqDzCcgJh
         G5GQ==
X-Gm-Message-State: ABuFfojPlCCV4M0FpIPegBQUjZIEAt8xY9JDd80NGd86kPM7CivkiVRU
        rVruFMG7kwtdmGid2rdpiSs=
X-Google-Smtp-Source: ACcGV61IaZrFaNaOrrBrXeXaPHBLj2w8Qhx58iEUo43xsPFYBvkiR533Phu4rhsuMh83BNFrs/am3g==
X-Received: by 2002:a2e:b007:: with SMTP id y7-v6mr2609415ljk.22.1537460384110;
        Thu, 20 Sep 2018 09:19:44 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id b80-v6sm1810441lfe.83.2018.09.20.09.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:43 -0700 (PDT)
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
Date:   Thu, 20 Sep 2018 18:21:09 +0200
Message-ID: <15226900.TQMLYV7PZ0@z50>
In-Reply-To: <9860023.SlBYqtbjDV@z50>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com> <9860023.SlBYqtbjDV@z50>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
> > Hi All,
> > 
> > On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> > > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > > information on direct mapping of array members to pins of a single GPIO
> > > chip in hardware order.  In such cases, bitmaps of values can be passed
> > > directly from/to the chip's .get/set_multiple() callbacks without
> > > wasting time on iterations.
> > >
> > > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > > Pins not applicable for fast path are processed as before, skipping
> > > over the 'fast' ones.
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > 
> > I've just noticed that this patch landed in today's linux-next. Sadly it
> > breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> > device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
> > 
> > Booting hangs after detecting MMC cards. Reverting this patch fixes the
> > boot. I will try later to add some debugs and investigate it further what
> > really happens when booting hangs.
> 
> Hi Marek,
> 
> Thanks for reporting. Could you please try the following fix?

Hi again,

I realized the patch was not correct, j, not i, should be updated in second 
hunk. Please try the following one.

Thanks,
Janusz

From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
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
index a53d17745d21..369bdd358fcc 100644
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
+				j = find_next_zero_bit(array_info->get_mask, i,
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




