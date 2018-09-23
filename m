Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35745208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlWr2aPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35745208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIXFwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:52:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37959 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeIXFwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:52:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id z186-v6so15160781lfa.5;
        Sun, 23 Sep 2018 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mg0atZwESfwIvpH4FO9elFcUPvpgUp8Akcfpx+l/4o8=;
        b=NlWr2aPvPsEDztjPTg3Dpib4GS4ZiJaa/tBuMFavHB9ZhRnC8KcMfFPIr/yI6xcRXb
         yywZ8JJle1hJzKCPf1ScmVflVsBGe5x4ElqJ7Gqo193QiGa2fbAsK2vW0y3uPd9vqwvq
         bgBXvcy/ydBbGFBwGQIZLgCDNrPWsiRukjwFUr/euIp1iO+EbveIU2Qjyk1uRK3/OZjn
         uqJum//WQjxJvRTFuKjZAbd8CUfhtXtTwsHGEkqMvpSIjxOJWeeqHyu8GOTlXODaUBY3
         r2tl7cWotTOw34iEzZAcyXTPwsJsvKKqm88l98KPFbSebGtM/Y5Kig/87NSoYr/FWyG1
         CnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mg0atZwESfwIvpH4FO9elFcUPvpgUp8Akcfpx+l/4o8=;
        b=GFQAWR86eWHEp0Fs0wxHmOKArP20v/wrZAjQHw42Tjk9XqgUF6AVEN35szWOtq1lpu
         Pxl+SXhIVkLq/gmlVAoGuDxMUYIdwUASBYcwzanrt1VnnHTOSFhu8cLuuHRc9o9uqRD3
         YcHehaZZaDdTokXytCMpM+kH6WBodpRGE+YCSUy9AHrHQZy5FvYlfEyzyum66UwjRxs3
         tZB7wUX2/TnWNeIqQYilN7zryKY7eEMulMLtR2ZrPsJZiiLU2pRrXUVVUTXJH/cwA0xK
         4mlIZhxswkjNy87IEdfog/S2V8KJQxV4hYu1PVGBQrNjuG8yTss/+F9uN4ZebD7p1f5B
         Q+mg==
X-Gm-Message-State: APzg51BxQM9Qd8+73NU/iiMUcyI7PWgEr5i7aUGW731Dur46Fqlknrmd
        UCnt7ho8bjp/afxyNVIGVPs=
X-Google-Smtp-Source: ANB0VdYalzWvTuVqZQt/8iRSFb8VkyNMD/akAle0kXEQQLAf+V+s/mSFK23Sz+1ODikX1K7fFIQSQw==
X-Received: by 2002:a19:1952:: with SMTP id 79-v6mr2474242lfz.85.1537746753683;
        Sun, 23 Sep 2018 16:52:33 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id m8-v6sm3419718lfh.25.2018.09.23.16.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 16:52:33 -0700 (PDT)
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: [PATCH 1/2] gpiolib: Fix missing updates of bitmap index
Date:   Mon, 24 Sep 2018 01:53:35 +0200
Message-Id: <20180923235336.22148-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180923235336.22148-1-jmkrzyszt@gmail.com>
References: <2785169.v6aIfS3K2k@z50>
 <20180923235336.22148-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In new code introduced by commit b17566a6b08b ("gpiolib: Implement fast
processing path in get/set array"), bitmap index is not updated with
next found zero bit position as it should while skipping over pins
already processed via fast bitmap path, possibly resulting in an
infinite loop.  Fix it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpiolib.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d21..7d9536a79a66 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2880,8 +2880,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			__set_bit(hwgpio, mask);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask,
-						   array_size, i);
+				i = find_next_zero_bit(array_info->get_mask,
+						       array_size, i);
 			else
 				i++;
 		} while ((i < array_size) &&
@@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 			trace_gpio_value(desc_to_gpio(desc), 1, value);
 
 			if (array_info)
-				find_next_zero_bit(array_info->get_mask, i, j);
+				j = find_next_zero_bit(array_info->get_mask, i,
+						       j);
 			else
 				j++;
 		}
@@ -3192,8 +3193,8 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 			}
 
 			if (array_info)
-				find_next_zero_bit(array_info->set_mask,
-						   array_size, i);
+				i = find_next_zero_bit(array_info->set_mask,
+						       array_size, i);
 			else
 				i++;
 		} while ((i < array_size) &&
-- 
2.16.4

