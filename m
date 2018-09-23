Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3145BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B87208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6FVd2BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B87208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeIXFwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:52:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32857 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIXFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:52:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id l19-v6so2154537ljb.0;
        Sun, 23 Sep 2018 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/WVvvps4INqy3Y40qi5MvRWOHI2pdz+3o9vxbYSDG4=;
        b=S6FVd2BHYu/2b5qMyaKN6G+hqztoSPL88+3ZnsvAf8NybeBq4HEm31x2X3UwHKteXk
         oQ3weBnxNtYanLb6pxQE2hxtLJb+fcG4jTHt9VpOZZZpUk75CnRN/0RuiDZtZJkUlnh0
         u6V1XZemC/yRgpcBPKv2TrKJEl7X7X5nFAV9ikhgL7nCwyizeqsNEsiTX8/vyDuYdnlo
         I9ibtVqthDGnMncHUoArsAlymsE6RGUT0hsPTGIWtM1barov9IFV0y1DTzCDHmIyhCYv
         ASa758NbQ6GgtuR2QG2M+OhvLzk9Qc+/xYkuVRVPc/lGaf0daZCHtz2duyp9aTjZtrOC
         N4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/WVvvps4INqy3Y40qi5MvRWOHI2pdz+3o9vxbYSDG4=;
        b=lfFnfPIsB5DKg2AvGBdAIEmCVHby0ygJ2tvka3Vhd++b9XVpsAIgAKC7Dn1vR/IOrs
         XN5gPjl0RyD1WI+9oDewkIDbtJ2KKgAuNRXVRNFVBs3PdyIRwhpyrGC/1TikjztuSXxY
         KhnVDFLBmvwhQh9ASNjb8liH07XaeUoEzymIcrhIGm5nY5SjhH4hJ7fzhsCbYFDzhvhM
         yMQDC6ZdSuTigNZrQcisTjs7gFZGE539CacSE3y7/wHUlgaZV8SaD/SCgfctlzLzE6Fe
         dKr2qSY+BM+LFn+M+0g2A3muogJjC+z8NCWupeFjX4NsvEF+EwLuforHTJK9U0xGuhbo
         7JRw==
X-Gm-Message-State: APzg51Ceg92PlnG/wfvHnRUNYt3px0vPAZGuMcEXYbSuxm0hyIBnwig9
        uLtQxsY5a8VxkfwnJ7EKwqU=
X-Google-Smtp-Source: ACcGV612QnapKQBiKaGACwYISbJFvvjzlmvMHhe0tAiURUYc1VxJFw8bzDs1wDM+CBSISWwbkiCXkw==
X-Received: by 2002:a2e:947:: with SMTP id 68-v6mr8393674ljj.1.1537746755828;
        Sun, 23 Sep 2018 16:52:35 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id m8-v6sm3419718lfh.25.2018.09.23.16.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 16:52:35 -0700 (PDT)
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
Subject: [PATCH 2/2] gpiolib: Fix array members of same chip processed separately
Date:   Mon, 24 Sep 2018 01:53:36 +0200
Message-Id: <20180923235336.22148-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180923235336.22148-1-jmkrzyszt@gmail.com>
References: <2785169.v6aIfS3K2k@z50>
 <20180923235336.22148-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New code introduced by commit bf9346f5d47b ("gpiolib: Identify arrays
matching GPIO hardware") forcibly tries to find an array member which
has its array index number equal to its hardware pin number and set
up an array info for possible fast bitmap processing of all arrray
pins belonging to that chip which also satisfy that numbering rule.

Depending on array content, it may happen that consecutive array
members which belong to the same chip but don't have array indexes
equal to their pin hardware numbers will be split into groups, some of
them processed together via the fast bitmap path, and rest of them
separetely.  However, applications may expect all those pins being
processed together with a single call to .set_multiple() chip callback,
like that was done before the change.

Limit applicability of fast bitmap processing path to cases where all
pins of consecutive array members starting from 0 which belong to the
same chip have their hardware numbers equal to their corresponding
array indexes.  That should still speed up processing of applications
using whole GPIO banks as I/O ports, while not breaking simultaneous
manipulation of consecutive pins of the same chip which don't follow
the equal numbering rule.

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/board.rst | 19 +++++++++++++-----
 drivers/gpio/gpiolib.c                  | 35 +++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index c66821e033c2..a0f294e2e250 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -202,9 +202,18 @@ mapped to the device determines if the array qualifies for fast bitmap
 processing.  If yes, a bitmap is passed over get/set array functions directly
 between a caller and a respective .get/set_multiple() callback of a GPIO chip.
 
-In order to qualify for fast bitmap processing, the pin mapping must meet the
+In order to qualify for fast bitmap processing, the array must meet the
 following requirements:
-- it must belong to the same chip as other 'fast' pins of the function,
-- its index within the function must match its hardware number within the chip.
-
-Open drain and open source pins are excluded from fast bitmap output processing.
+- pin hardware number of array member 0 must also be 0,
+- pin hardware numbers of consecutive array members which belong to the same
+  chip as member 0 does must also match their array indexes.
+
+Otherwise fast bitmap processing path is not used in order to avoid consecutive
+pins which belong to the same chip but are not in hardware order being processed
+separately.
+
+If the array applies for fast bitmap processing path, pins which belong to
+different chips than member 0 does, as well as those with indexes different from
+their hardware pin numbers, are excluded from the fast path, both input and
+output.  Moreover, open drain and open source pins are excluded from fast bitmap
+output processing.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d9536a79a66..6ae13e3e05f1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4376,11 +4376,10 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 
 		chip = gpiod_to_chip(desc);
 		/*
-		 * Select a chip of first array member
-		 * whose index matches its pin hardware number
-		 * as a candidate for fast bitmap processing.
+		 * If pin hardware number of array member 0 is also 0, select
+		 * its chip as a candidate for fast bitmap processing path.
 		 */
-		if (!array_info && gpio_chip_hwgpio(desc) == descs->ndescs) {
+		if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
 			struct gpio_descs *array;
 
 			bitmap_size = BITS_TO_LONGS(chip->ngpio > count ?
@@ -4414,14 +4413,30 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 				   count - descs->ndescs);
 			descs->info = array_info;
 		}
-		/*
-		 * Unmark members which don't qualify for fast bitmap
-		 * processing (different chip, not in hardware order)
-		 */
-		if (array_info && (chip != array_info->chip ||
-		    gpio_chip_hwgpio(desc) != descs->ndescs)) {
+		/* Unmark array members which don't belong to the 'fast' chip */
+		if (array_info && array_info->chip != chip) {
 			__clear_bit(descs->ndescs, array_info->get_mask);
 			__clear_bit(descs->ndescs, array_info->set_mask);
+		}
+		/*
+		 * Detect array members which belong to the 'fast' chip
+		 * but their pins are not in hardware order.
+		 */
+		else if (array_info &&
+			   gpio_chip_hwgpio(desc) != descs->ndescs) {
+			/*
+			 * Don't use fast path if all array members processed so
+			 * far belong to the same chip as this one but its pin
+			 * hardware number is different from its array index.
+			 */
+			if (bitmap_full(array_info->get_mask, descs->ndescs)) {
+				array_info = NULL;
+			} else {
+				__clear_bit(descs->ndescs,
+					    array_info->get_mask);
+				__clear_bit(descs->ndescs,
+					    array_info->set_mask);
+			}
 		} else if (array_info) {
 			/* Exclude open drain or open source from fast output */
 			if (gpiochip_line_is_open_drain(chip, descs->ndescs) ||
-- 
2.16.4

