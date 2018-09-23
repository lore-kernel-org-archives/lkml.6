Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27575ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78EB208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU/30lVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78EB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIXFwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:52:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41956 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIXFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:52:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so16611747ljy.8;
        Sun, 23 Sep 2018 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+vWkV9PK2dW2ldgqA92Kie02InEocNbKcAQBBT4ZZo=;
        b=pU/30lVr5PxtDJpoiEk9N/gJiRxiEkf53c0h9LpydS1sJ9uJHqdHtyrFGiysB2qlVI
         /cohGpR3oywT2UA7PxgeVmqbl3/mixJ3Q4ALYNVJjv2yJow9fF+H5L3lZAJ2KJ4KaFTn
         fevevjodGrmfd+aKyAaLJ8XhGBm9bSBmaph3xUY+Jw5IwN43ImZJhaEN815rwfWgwfhJ
         nd+Ys8B43pH978psP6sxDNgZgM5Tqjfc8IXVs7dLexRqRw2sZbJJMdKShR6FAaJdWkVP
         jA/f9Dui+ZRJsK8N/iXPj/9NwrdE9Fwnl+76gQwNY6tt9KkUGWA4uBoW86sIBLOjEQsB
         qkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B+vWkV9PK2dW2ldgqA92Kie02InEocNbKcAQBBT4ZZo=;
        b=Tw+zmwxX0nGPaujhEOxYBuuWJSphBYrU4tlJWvXCK7Q8pEt0CBP2dTyfwMrThNqHQh
         X5KzPGeS9ZFyRUTvV5EuI5/iCetcbREEe6HxNjhdJ1GhDe2HQOeffm+KfxfO9/MB5lVc
         VXGVJ5O+mBA5QJ9aIudcnhOQ0tdMyysuY6Wms96yW5pviVkXNnEl8GZex2aSG2mN1yGc
         xrNbNXtixTRQBhBDpHxGzKb02CAblUBpZUY3cnsxog3OJRq+z0c9TUuyGgY9YeEY1623
         LYA1eRrbrSTWjI7wwwu2HQZXwFeZIP4DTYugPPxuc8XduxkmuX87VZFz+3Lb/uGXWsFa
         ED/w==
X-Gm-Message-State: ABuFfogFUnI67wx+b1MSZaHYnlNhTzokdFgED45+ywHEXOcI5UL0pz/t
        SDToE86JDnB2f3xS/mY7es8=
X-Google-Smtp-Source: ANB0VdaH4l/xZHBe4Mb2obhXCx25rZrr7kGUqyMDhJM5hbXkNPWP1Z69FaPqhgTQzYPBhaGy2qm20g==
X-Received: by 2002:a2e:4401:: with SMTP id r1-v6mr9187277lja.21.1537746751498;
        Sun, 23 Sep 2018 16:52:31 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id m8-v6sm3419718lfh.25.2018.09.23.16.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 16:52:30 -0700 (PDT)
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
Subject: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap processing path
Date:   Mon, 24 Sep 2018 01:53:34 +0200
Message-Id: <20180923235336.22148-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <2785169.v6aIfS3K2k@z50>
References: <2785169.v6aIfS3K2k@z50>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While investigating possible reasons of GPIO fast bitmap processing
related boot hang on Samsung Snow Chromebook, reported by Marek
Szyprowski (thanks!), I've discovered one coding bug, addressed by
PATCH 1/2 of this series, and one potential regression introduced at
design level of the solution, hopefully fixed by PATCH 2/2.  See
commit messages for details.

Janusz Krzysztofik (2):
      gpiolib: Fix missing updates of bitmap index
      gpiolib: Fix array members of same chip processed separately

The fixes should resolve the boot hang observed by Marek, however the
second change excludes that particular case from fast bitmap processing
and restores the old behaviour.  Hence, it is possible still another
issue which have had an influence on that boot hang exists in the code.
In order to fully verify the fix, it would have to be tested on a
platform where an array of GPIO descriptors is used which starts from
at least two consecutive pins of one GPIO chip in hardware order,
starting ftom 0, followed by one or more pins belonging to other
chip(s).

In order to verify if separate calls to .set() chip callback for each
pin instead of one call to .set_multiple() is actually the reason of
boot hang on Samsung Snow Chromebook, the affected driver -
drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
modified for testing purposes so it calls gpiod_set_value() for each
pin instead of gpiod_set_array_value() for all of them.  If that would
also result in boot hang, we could be sure the issue was really the
one addressed by the second fix.  Marek, could you please try to
perform such test?

Thanks,
Janusz


diffstat:
 Documentation/driver-api/gpio/board.rst |   19 +++++++++----
 drivers/gpio/gpiolib.c                  |   46 +++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 20 deletions(-)

