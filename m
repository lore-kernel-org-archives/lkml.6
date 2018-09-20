Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A856C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9722152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBkkj9kB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9722152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbeITVdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:33:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38635 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeITVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:33:23 -0400
Received: by mail-io1-f66.google.com with SMTP id y3-v6so7803640ioc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLScAZUucBAJe+mPRClQyep3NXXhLY9Un4hpVlWMTcw=;
        b=XBkkj9kBjoOnzbKxWGlCcJxWOJb4hf8ElWm4LesYUz/DY7HFm+tN6iEjR0Q3Z1d1gW
         O0phjGfbiaWoaGkFJxpzkwEeApCU2wUOwDAJI0Yui1vyCFG/S0HIURdA4dM5M4pjbK9o
         7krIPrNoRFHXnc6VGwZix9/d6X9SEEnEDdSZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLScAZUucBAJe+mPRClQyep3NXXhLY9Un4hpVlWMTcw=;
        b=CCxJxqZxnPPDwpjQe2BVQpw+TPDSi2xq8Lnl9F1rN97nj2Hpl1TnX9Yd+m+w4GRqPK
         qG4D5aXKJcY7GCc4GY1py8YSpx/YJ0XCrcLSkEM4Mlf0s8AiCXEmrrsrE1qJEPQL3UKs
         5JAWUpYdis/Sp3nABLGrdleSdKVhLlZkUXc4Qy25gpm/ixTPcK0sBOPNUbFU+bmJLeUn
         AR7aX/TOElzhSLW4mCkKcwfEhaa5DmE1I1XmgxczqiaOA2lfDFm4hTxges6D1sEq0UP9
         sDuwjzzoWozbk3hHUMYbmwzVSymWUNloze8bfkEIZv0WUYkpCZnDLLhB9LIYtbcReMLK
         s1GQ==
X-Gm-Message-State: APzg51AQu40uiEZWZrCpasoe0KEyQw2bwwhimDJURHxlbVjsrzqxenUo
        anopPqppkWHz8vQGLRim+T3GCCrEofgZXcNfL6vDKg==
X-Google-Smtp-Source: ANB0VdYTDgdY1RsiUxiB4yUyidfGZoUl0IzQb/REjA1hoRBXyj3X1XtiDKua4QPJ1dyuHn/nQcOoAAbWn7nFOM/ZVyc=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr33165533iof.304.1537458557495;
 Thu, 20 Sep 2018 08:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
 <20180902120144.6855-5-jmkrzyszt@gmail.com> <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
In-Reply-To: <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Sep 2018 08:49:04 -0700
Message-ID: <CACRpkdZD+kFsyvSKBm1JpCOd1is_TBRJGx3Yvd=kshoH5iPhXA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>, kishon@ti.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:11 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> I've just noticed that this patch landed in today's linux-next. Sadly it
> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).

Thanks for testing on this platform!

> Booting hangs after detecting MMC cards. Reverting this patch fixes the
> boot. I will try later to add some debugs and investigate it further what
> really happens when booting hangs.

How typical. I hope we can fix it, because this should mean speedups
for your platform.

Yours,
Linus Walleij
