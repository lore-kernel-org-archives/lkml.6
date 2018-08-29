Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C582C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1E2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlRSNLkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeH2OPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:15:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35658 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2OPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:15:54 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so4022199iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fb1c9G+2Z7Eb/LHsM72s2v2VMyfTPPK5sD2QVtu7bD0=;
        b=XlRSNLkRdedirUpxm9Ig613opdEjxA53i+QLztDD0zfwISWWrsya8wv0jLbcgdxXgf
         aIcoXdlibk47CFNqz2JJANtxlFTVVL+ud7bEjqmIy72UKYtvov9OeQUfJBvBPQ4yKkfh
         Zerq6XngGvgijuN4oI+g5XYbjOQWnsiVf9FAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fb1c9G+2Z7Eb/LHsM72s2v2VMyfTPPK5sD2QVtu7bD0=;
        b=gPcxGTNy0LOTdjcYmiOCARo7TWv4Zf1+c0xE/Wnhddn0mvTn/87YTkd5rt/3amBLS9
         yKRcPbGuBbgAyiSDGHU7rpt0hTyUniB+WVZ50iOMtzmY4reMrEoVb2Jkpfn/T4V2iKbu
         YM10/zl3o5KDECWUHk358UW5NPz2sWr1fUteuVX2gaezKj1eHQjsoUHN1viLpsYv5Nev
         xJiwU4s9vCgYhqfUQEE51kEkJV78S+0KmHD2PHgFu8qMNno7WdY6t4UaefjDomh16eRz
         B/24z/hxY+xndIRnP6utFsiEKb7szhlUQEiPsZPYbzUFm8XzXUK8sTLe6/pxaPsRNSHl
         Os4A==
X-Gm-Message-State: APzg51ASwA1H0XQzgpVokjMZlLYvPky47Ml+12DvqPfBX/ywWX1Mdfk4
        ve6sfGF3nwxlnclySlNnyuo6FyEmM0v1DHhmLBwtEQ==
X-Google-Smtp-Source: ANB0Vda2gHwN2j4A/R+Om0XUo8yGk2JTaK3RhGGjq0qfL4cie1M0gtLQGf5dJIBLv/cNj07C1riLBv78I5WWJ9yisTc=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr4490032iou.218.1535537981989;
 Wed, 29 Aug 2018 03:19:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 03:19:41
 -0700 (PDT)
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 29 Aug 2018 12:19:41 +0200
Message-ID: <CAPDyKFoWrsq9Qu3AOM=6xmpqOGU8XwaAmKZr9_xD-dpAzwWENg@mail.gmail.com>
Subject: Re: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
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
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        netdev@vger.kernel.org, linux-iio@vger.kernel.org,
        driverdevel <devel@driverdev.osuosl.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 August 2018 at 01:43, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>
> This series is a follow up of the former "mtd: rawnand: ams-delta: Use
> gpio-omap accessors for data I/O" which already contained some changes
> to gpiolib.  Those previous attempts were commented by Borris Brezillon
> who suggested using GPIO API modified to accept bitmaps, and by Linus
> Walleij who suggested still more great ideas for further immprovement
> of the proposed API changes - thanks!
>
> The goal is to boost performans of get/set array functions while
> processing GPIO arrays which represent pins of a signle chip in
> hardware order.  If resulting performance is close to PIO, GPIO API
> can be used for data I/O without much loss of speed.
>
> Created and tested on a low end Amstrad Delta board with NAND driver
> updated to use GPIO API for data I/O.  Performance degrade compared to
> PIO is much better than before the optimization but still not quite
> satisfactory.
>
>
> Janusz Krzysztofik (4):
>       gpiolib: Pass bitmaps, not integer arrays, to get/set array
>       gpiolib: Identify arrays matching GPIO hardware
>       gpiolib: Pass array info to get/set array functions
>       gpiolib: Implement fast processing path in get/set array
>
>
>  Documentation/driver-api/gpio/board.rst     |   15 +
>  Documentation/driver-api/gpio/consumer.rst  |   48 +++-
>  drivers/auxdisplay/hd44780.c                |   64 +++---
>  drivers/bus/ts-nbus.c                       |   25 --
>  drivers/gpio/gpio-max3191x.c                |   23 +-
>  drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
>  drivers/gpio/gpiolib.h                      |   15 +
>  drivers/i2c/muxes/i2c-mux-gpio.c            |    5
>  drivers/mmc/core/pwrseq_simple.c            |   15 -
>  drivers/mux/gpio.c                          |    7
>  drivers/net/phy/mdio-mux-gpio.c             |    5
>  drivers/pcmcia/soc_common.c                 |   14 -
>  drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
>  drivers/staging/iio/adc/ad7606.c            |   12 -
>  drivers/tty/serial/serial_mctrl_gpio.c      |    9
>  include/linux/gpio/consumer.h               |   35 ++-
>  16 files changed, 410 insertions(+), 182 deletions(-)
>

For the mmc related changes:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
