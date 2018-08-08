Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1BC21A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kxx81N3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1BC21A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeHHSvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:51:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43285 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHHSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:51:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so4743810oib.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hh0LsN1BucTaVxY6Jhcaq3BSVyOj2qSRqX2sYKeZLhE=;
        b=Kxx81N3ldnJ8QogcHmiwABcmZvo255w4w3waJgOk+CMKfEh0uWtpvGmbAz5s4GGlJF
         Qmn8W8zcxjD659qTKUIUH3ByYdabSpVVdcY6dbmRkGNYvkjqT4hO6KR81ieVOt1YUsvf
         tRck1XykNt6qcX+JHdJe7Sln2Mw4ugBF/HDkn+naRIq1hwc3rmkWc+FDEPgiERD/qKc0
         UTYgrHFss3PXr1+DKdXiX+ft5v3K26PdYgG6f2UdVKJ74PbpLtP0e7wummxIFEaJL/yy
         IczqrI4cTHDXuZnXzmoL+QO1MmE+lhkhKPIeG9+V9vteo9+Mm+5fYQ6dlsDwrkNkXFQV
         Vhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hh0LsN1BucTaVxY6Jhcaq3BSVyOj2qSRqX2sYKeZLhE=;
        b=MoNYwJqkKg6pnOHXMvyChes0A5Spej+1OqLHXr28OQimKcmhLSOIllBvTUw3zYHwbX
         aMs08IDuA9TevOQmLf832cI8XMJVyL9fAf7jqwqZRlZ6/rvOUC8WLQCgpvpepRKzJFst
         7Wk70ux3h6tHLvenjZogLsFMKKTKJf6KvP5gK1RuYSh8dnr3CsysjIGC4gqqEsBr2WUT
         iGHqRZnt9fLDwOlhI3G6UvoyIEX1ObxJN8wc5S+3Csh6eep+XZLRFt/v5AofB2ZSDO0M
         O7HO7l2Rd7Rh3VtnoKYFPJOz9OHAaNx2oHD7pEVE992OQm8HY5VJ7/FKubds1UBpn0+r
         xqdw==
X-Gm-Message-State: AOUpUlGXr25ucfbfw5Aa0PPTKgNnk810i+J+FVbMJg8gACLKTOaaKSef
        +7sMukcBycFphTpPfcs63caCFM0W9ApflUoJl0v4yA==
X-Google-Smtp-Source: AA+uWPytUSGpTMeUnMgrm7X2fjHNZJtNvBTFnxgr3feFVqBgGghIB0feIsatlFGQGcmNa7EcSWh1SX51eOW/wtFUd6s=
X-Received: by 2002:aca:45c3:: with SMTP id s186-v6mr3390752oia.289.1533745850144;
 Wed, 08 Aug 2018 09:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c03:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:30:49 -0700 (PDT)
In-Reply-To: <20180808161353.GF7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-4-brgl@bgdev.pl>
 <20180808161353.GF7275@lunn.ch>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 8 Aug 2018 18:30:49 +0200
Message-ID: <CAMpxmJXr60+7mRNf+AQrvSPAxW2hJXCP13rDbmtRfqouKzt3Bg@mail.gmail.com>
Subject: Re: [PATCH 03/28] nvmem: add a notifier chain
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-08 18:13 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 05:31:25PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Add a blocking notifier chain with two events (add and remove) so that
>> users can get notified about the addition of nvmem devices they're
>> waiting for.
>>
>> We'll use this instead of the at24 setup callback in the mityomapl138
>> board file.
>
> Hi Bartosz
>
> What context is this notifier chain called in?
>
> I did something similar using the i2c notifier to try to work around
> the impending disappearing of the setup callback. But i got lockdep
> splats, because the notifier was called while some locks were being
> held, so it was not possible to register other i2c devices.
>
> The at24 setup callback is done as part of probe, so no important
> locks are held. Are any locks held when this notifier chain is called?
>
> Thanks
>         Andrew

In the case of at24 it would be called from at24_probe() ->
nvmem_register() in process context. Would you mind testing it? Would
be great to see if it works on multiple setups.

Bart
