Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE3C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91086217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ8vyTGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91086217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeHDUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:23:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDUXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:23:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so4936372wru.2;
        Sat, 04 Aug 2018 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFFI0EISTPJdVf0+8pY3UPl0OPXEx7SkUOMOEODVh0Q=;
        b=KJ8vyTGkhoH7eUNCPEdo82+/LOA4qWmY6WkTP3/seeCF0uxO4avIFomW1Jk34YlwWL
         xw+DnPyA/xBGtHnpCIauq5lNHrCFLeXEQ3IiURrQIbpdLZvGxZg8YGRkaJhj8Q3Mh+59
         6l+wo31a6QtSp4H3GJzEPgUd33M3Um/vIjjBTBfEg3lVUB7QWjbF446KawIehznxSRNy
         044BOMoidmt+17q02hzDhx4k/YI5SzLaWnYmUQ8rIcB2Ury18BBMbXPSdYLN9UtmFfMs
         5a1MWRkaIIavJ8H8ye1X6feZ3ASzDFIi+8rqOy8nzed2Sw4ukjs7HTmM2XRpR+dp+hkn
         edmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFFI0EISTPJdVf0+8pY3UPl0OPXEx7SkUOMOEODVh0Q=;
        b=SQYGWe6wIqZS6U7h7GsgLi3DobSx1B81k5vGaQzzS9nf2RQjL18+Ehgna25MjH/BiI
         gZDbnY2FjFSqDWUf8MwsdMx8af2TGZJjqboILtbHbRBCjbUERQ9VAVc4fGTdzsg+R4dU
         ZjXYRWTeZ3eaYUiT8wkxLsvDMSL7zPgLvKZoEuct8m0EZyMRM43muMmxzvYpV5jMWtKV
         UA1T4ePi5CN/V51jYYDwHCNzAo3tZdB6sfW/OVDMy6k/ydg62IKmYMOBZ65ik1huRjqX
         rM9ZgotjvVewWUnmLyGDT5RnvDACa2Ca41Fr2VqLid08T62Ho0ShVrpc2tPS+A3eYlqo
         QcaQ==
X-Gm-Message-State: AOUpUlGZXwQWZAL8L6F1j4CwlRwPGhWKMfVMo5T30GzTaOmeFhifxzGA
        AdnhKlFytOLKrK2JLg/bBBIerW3G
X-Google-Smtp-Source: AAOMgpfcnfXNDJ5IbXYlcggnMZvgQguzwR0WaWrtS6dawhyGOjZXQXPt7ubP+bqtB0yGLxeOBnFjcQ==
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr5785088wrg.34.1533406942666;
        Sat, 04 Aug 2018 11:22:22 -0700 (PDT)
Received: from debian64.daheim (p4FD09136.dip0.t-ipconnect.de. [79.208.145.54])
        by smtp.gmail.com with ESMTPSA id v5-v6sm5795798wru.60.2018.08.04.11.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 11:22:21 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.91)
        (envelope-from <chunkeey@gmail.com>)
        id 1fm1C0-0003hH-Oz; Sat, 04 Aug 2018 20:22:20 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     fe@dev.tdt.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: Add driver for PC Engines APU2/APU3 GPIOs
Date:   Sat, 04 Aug 2018 20:22:20 +0200
Message-ID: <1846152.TW98f23PIX@debian64>
In-Reply-To: <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
References: <20180801111243.2848-1-fe@dev.tdt.de> <CACRpkdbY3w-ptUOkv5TUZh+5oEGU+4BLO_6=12QecRveTSBKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 2, 2018 11:30:00 PM CEST Linus Walleij wrote:
> On Wed, Aug 1, 2018 at 1:12 PM Florian Eckert <fe@dev.tdt.de> wrote:
> 
> > Add a new device driver "gpio-apu" which will now handle the GPIOs on
> > APU2 and APU3 devices from PC Engines.
> >
> > - APU2/APU3 -> front button reset support
> > - APU3 -> SIM switch support
> >
> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> 
> Hi Florian, thanks for the patch!

There have been multiple attempts at upstreaming a gpio/pinctrl driver for
the different APU SoC by now. The last attempt I remember took place on 
this ML too: <https://lkml.org/lkml/2017/12/20/824>

But sadly most attempts stalled, because there is already a leds-apu driver 
<https://github.com/torvalds/linux/blob/master/drivers/leds/leds-apu.c>
(since the gpio-driver was never accepted) that will do in a pinch for the
LEDs (which most people care about).

> I looped in Andy Schevchenko and Mika Westerberg who are authorities on
> x86 platform drivers in general and GPIO and pin control in particular
> so they can help out with the review.
Intel helping AMD. That's nice to see ;-)

> I'm a bit confused whether these things are really GPIOs or just
> switches but since they can change direction they seem to be GPIOs.

Yes, it's a real gpio/pinctrl in AMDs Tech docs.
<https://support.amd.com/TechDocs/52740_16h_Models_30h-3Fh_BKDG.pdf>

Some of the pins are muxed. I.e GPIO167-170 can either be a GPIO or
used for HD audio.
"The HD audio controller supports up to four codecs with one AZ_SDIN
pin from each codec. The four AZ_SDIN pins are multiplexed with
GPIO167-170 (GPIOxA7-GPIOxAA). If a particular pin is to be used for
HD audio functionality". There's a full table in "3.26.12.1 GPIO Registers". 




As for the APUs. The vendor (PC Engines) happily provides
PDFs and schematics for their boards:
<https://www.pcengines.ch/pdf/apu1.pdf>
<https://www.pcengines.ch/schema/apu1c.pdf>
<https://www.pcengines.ch/pdf/apu2.pdf>
<http://pcengines.ch/schema/apu2c.pdf>

So, it's possible to repurpose several test points as additional
GPIOs and more.

Note2:
On both boards there is also a dedicated GPIO pin header J19, but
these pins are controlled by the SuperIO Nuvoton NCT5104D.

> > +config GPIO_APU
> > +       tristate "PC Engines APU2/APU3 GPIO support"
> > +       depends on X86
> > +       select GPIO_GENERIC
> > +       help
> > +         Say Y here to support GPIO functionality on APU2/APU3 boards
> > +         from PC Engines.
> > +         - APU2/APU3 -> front button reset support
> > +         - APU3 -> SIM switch support
Well, by design this driver will sort of clash with the leds-apu driver. 
 
Regards,
Christian


