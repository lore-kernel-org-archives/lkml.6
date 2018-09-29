Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EDFC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2920879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2VKbhwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E2920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeI2Src (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 14:47:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45707 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeI2Srb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 14:47:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id x16-v6so8143690ljd.12;
        Sat, 29 Sep 2018 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZKOW8+0FgaclRFDEZ6kADxUMQh2fYfYr5W6bwztBiH8=;
        b=C2VKbhwnD6GJ6ayhrmaaB5aqh7KlPYIsrzbH/OJ3n6FZnDgSe7qoVHwudHxHJ/or20
         H/HJ4nPLx06af5jFM7ANcvbmzdSK6wNaTSS92mn/E/rmPCxNgkulrgQ4D6CC9AKjAn6Z
         syIujMCDYCYwuptlEkFrcLfWuxwoJBuYeLHd+Pu+G4T5F3D9W65mYWgYz/ImU0W8YGTQ
         WD3wyovStKpDrghs4UScfxE7zbxLdgHK3Yfn9UkIaYGO69K901xajfPWBcMcunxU8E/S
         5S48y7t4XqvNBvtPpLB+EABtZAxVA9v2MFqLk89jh/0AK7kZcrklQNcsNcAzS7a36lQw
         9MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZKOW8+0FgaclRFDEZ6kADxUMQh2fYfYr5W6bwztBiH8=;
        b=jqyyZ5NLMz0q+VKYxM7cFDUt4lkDjWYzsakf0nx0NHOxGMvPbke1gAAXsrxWpOvhUb
         uh7OqyKtcDy91ReR/vOIPoAvjOQTyxlk3yNmWh6luOvK5MolVpAT8TrpO79n6+iNeN0K
         wB2rjX2LtHEGI32EPqqe8E3I/EiYZ3gJMjMbdTedsFys2GnI2zJ+lpWwZAS5xhpFAGEa
         nmuMm7z8x+vhFLrJKCShcp5mmZV12oz2jhqk7PuQ8tSGih+6ge0HM2kV821UQm0eKliQ
         7p7T5YvZ/zoKl/Ym75YrgPMUKCLxzoiU5GudQIcMruF4NJtCQtfMGow/F+b2cRuQRimy
         50RQ==
X-Gm-Message-State: ABuFfojYXntTMz9FwPpjZE066W7ZmKbep2/7lZwdy58fwaAr+H/+6Pgh
        VDXbpuVENvR4AUj9FwphJNY=
X-Google-Smtp-Source: ACcGV62f0MDwQsulatKVCLLNdly9sxwvw36JP37qUy3vslQoCeZ1/yOxdL/RoZzoANkrKnCDXRjvHQ==
X-Received: by 2002:a2e:6353:: with SMTP id x80-v6mr1649114ljb.11.1538223552013;
        Sat, 29 Sep 2018 05:19:12 -0700 (PDT)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id t15-v6sm1536665ljh.21.2018.09.29.05.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 05:19:11 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
Date:   Sat, 29 Sep 2018 14:20:22 +0200
Message-Id: <20180929122022.6825-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180923235336.22148-2-jmkrzyszt@gmail.com>
References: <20180923235336.22148-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b17566a6b08b ("gpiolib: Implement fast processing path in
get/set array"), already fixed to some extent with commit 5d581d7e8cdc
("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
of processing bitmaps where bits applicable for fast bitmap processing
path are supposed to be skipped while iterating bits which don't apply.
Unfortunately, find_next_zero_bit() function supposed to skip over
those fast bits is always called with a 'start' argument equal to an
index of last zero bit found and returns that index value again an
again, causing an infinite loop.

Fix it by incrementing the index uncoditionally before
find_next_zero_bit() is optionally called.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Marek,

Could you please test it on top of next-20180920 with "gpiolib: Fix
missing updates of bitmap index" and optionally "mmc: pwrseq_simple:
Fix incorrect handling of GPIO bitmap" also applied?

Thanks,
Janusz


 drivers/gpio/gpiolib.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6ae13e3e05f1..940b543e966d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2878,12 +2878,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			int hwgpio = gpio_chip_hwgpio(desc);
 
 			__set_bit(hwgpio, mask);
+			i++;
 
 			if (array_info)
 				i = find_next_zero_bit(array_info->get_mask,
 						       array_size, i);
-			else
-				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 
@@ -2903,12 +2902,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				value = !value;
 			__assign_bit(j, value_bitmap, value);
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
+			j++;
 
 			if (array_info)
 				j = find_next_zero_bit(array_info->get_mask, i,
 						       j);
-			else
-				j++;
 		}
 
 		if (mask != fastpath)
@@ -3191,12 +3189,11 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 					__clear_bit(hwgpio, bits);
 				count++;
 			}
+			i++;
 
 			if (array_info)
 				i = find_next_zero_bit(array_info->set_mask,
 						       array_size, i);
-			else
-				i++;
 		} while ((i < array_size) &&
 			 (desc_array[i]->gdev->chip == chip));
 		/* push collected bits to outputs */
-- 
2.16.4

