Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E475ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFE120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8XlGtaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFE120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeIXUUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:20:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42100 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbeIXUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:20:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so19968758otl.9;
        Mon, 24 Sep 2018 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4pJG+c8XlNf7twfB38HXibR4Kbp7wNQVu3EnYQJ9GS8=;
        b=l8XlGtaw9leEalBysDL2VUcpypz2FkoTmkHiWmXCes9aSSQ65W0P3j7g5zuJP+T/Zo
         u4kR8YXt5zMhBdlVHLUPhP1oHT0zejEb7bzYS99AEF3L7W+O2mcf3Hv0+y+grfbUCkGS
         UCFmyffq9PbtgzLABcyMFNKFshKkZSlsW9tgy0hsw+6f79twIycbPDJCqHdthzADwR6c
         eQ1cwIK3HI+x9Il6OGkrTwh8eun2AELZJET5PmShaydcRbEdi/5TSJDWQ8vVeCSPRCB5
         DxuymYgofC541XLnATI9Pb9ahQGpS7H6SZEfWh7TBU/UNmffFcUSATGcOSsqDWJdgOT3
         u1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4pJG+c8XlNf7twfB38HXibR4Kbp7wNQVu3EnYQJ9GS8=;
        b=SRB/ezNWyGMmWqrQIm3rXJCc09X5b5J6hOFJzNEA93Trj+CruWCspLySotAeeq6i7n
         JlmLg6lFQftBDiZar2nZbVFKYHlJG2PedxwOS1xo2r4SwjAd0Qx3fOjedTSPse6SIT3Y
         uQwHItCD3h83dBK5HiwrUjyYMkb1q1k1y7lot/HJyIdlKFT7pqPAPChfXYcWHzTAue6v
         +mB8ZEK2SMEuGVcBMCIFLSDa0zBmaGegrh78iGF4poHzdy13Z/N4c+8mhDNk0FpGTwed
         DdG3hYcNcBum8d3s+ulgZPG2w8JCTXUdTvfLkVtxNqsb8ST1nb07lQkHp5Cfr83CU1D3
         fmTw==
X-Gm-Message-State: ABuFfohqkHWM7N00nVmLTu6wci3rVIxR5RQySn0APDo9NDwuR6NaKlaX
        BLIDkuBPftRTcUkoujFCl1XUGtFskJX7pHUZtrw=
X-Google-Smtp-Source: ACcGV61JcTSpesLNrH5fv+ToEJm5w910BBROnn9tT4RdUQ24LLy/mhmNt3slCICLYX3ahfXQJIacrN3NQTIo5u4K3HQ=
X-Received: by 2002:a9d:7519:: with SMTP id r25-v6mr7086134otk.73.1537798696670;
 Mon, 24 Sep 2018 07:18:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:326:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 07:18:15 -0700 (PDT)
In-Reply-To: <20180924113859eucas1p160322f5844c771bc9c680d35de4877a3~XUxM0smXV0334103341eucas1p1s@eucas1p1.samsung.com>
References: <2785169.v6aIfS3K2k@z50> <CGME20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2@epcas3p3.samsung.com>
 <20180923235336.22148-1-jmkrzyszt@gmail.com> <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
 <CAGfqbt6H8u_dUokB-pg51kCj09G8Mh7wB0879nKMw5Dw83tcSg@mail.gmail.com> <20180924113859eucas1p160322f5844c771bc9c680d35de4877a3~XUxM0smXV0334103341eucas1p1s@eucas1p1.samsung.com>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Mon, 24 Sep 2018 16:18:15 +0200
Message-ID: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap
 processing path
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-serial@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

2018-09-24 13:38 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
> Hi Janusz,
>
> On 2018-09-24 13:08, Janusz Krzysztofik wrote:
>> 2018-09-24 11:43 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
>>> On 2018-09-24 01:53, Janusz Krzysztofik wrote:
>>>> While investigating possible reasons of GPIO fast bitmap processing
>>>> related boot hang on Samsung Snow Chromebook, reported by Marek
>>>> Szyprowski (thanks!), I've discovered one coding bug, addressed by
>>>> PATCH 1/2 of this series, and one potential regression introduced at
>>>> design level of the solution, hopefully fixed by PATCH 2/2.  See
>>>> commit messages for details.
>>>>
>>>> Janusz Krzysztofik (2):
>>>>         gpiolib: Fix missing updates of bitmap index
>>>>         gpiolib: Fix array members of same chip processed separately
>>>>
>>>> The fixes should resolve the boot hang observed by Marek, however the
>>>> second change excludes that particular case from fast bitmap processing
>>>> and restores the old behaviour.
>>> I confirm, that the above 2 patches fixes boot issue on Samsung Snow
>>> Chromebook with next-20180920.
>>>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>>> Hence, it is possible still another
>>>> issue which have had an influence on that boot hang exists in the code.
>>>> In order to fully verify the fix, it would have to be tested on a
>>>> platform where an array of GPIO descriptors is used which starts from
>>>> at least two consecutive pins of one GPIO chip in hardware order,
>>>> starting ftom 0, followed by one or more pins belonging to other
>>>> chip(s).
>>>>
>>>> In order to verify if separate calls to .set() chip callback for each
>>>> pin instead of one call to .set_multiple() is actually the reason of
>>>> boot hang on Samsung Snow Chromebook, the affected driver -
>>>> drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
>>>> modified for testing purposes so it calls gpiod_set_value() for each
>>>> pin instead of gpiod_set_array_value() for all of them.  If that would
>>>> also result in boot hang, we could be sure the issue was really the
>>>> one addressed by the second fix.  Marek, could you please try to
>>>> perform such test?
>>> Yes, I've just tested next-20180920 only with the first patch from this
>>> patchset and the mentioned change to drivers/mmc/core/pwrseq_simple.c.
>>> It boots fine, so indeed the issue is in handling of arrays of gpios.
>>>
>>> Just to be sure I did it right, this is my change to the mentioned file:
>> Yeah, that's what I had on mind.  However, I'd be more lucky if it didn't
>> work
>> for you.  Setting the pins sequentially, not simultaneously as before,
>> was
>> exactly what I hoped was the reason of the hang.
>>
>>> diff --git a/drivers/mmc/core/pwrseq_simple.c
>>> b/drivers/mmc/core/pwrseq_simple.c
>>> index 7f882a2bb872..9397dc1f2e38 100644
>>> --- a/drivers/mmc/core/pwrseq_simple.c
>>> +++ b/drivers/mmc/core/pwrseq_simple.c
>>> @@ -38,16 +38,11 @@ static void mmc_pwrseq_simple_set_gpios_value(struct
>>> mmc_pwrseq_simple *pwrseq,
>>>                                                 int value)
>>>    {
>>>           struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>>> +       int i;
>>>
>>> -       if (!IS_ERR(reset_gpios)) {
>>> -               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
>>> -               int nvalues = reset_gpios->ndescs;
>>> -
>>> -               values[0] = value;
>>> -
>>> -               gpiod_set_array_value_cansleep(nvalues,
>>> reset_gpios->desc,
>>> -                                              reset_gpios->info,
>>> values);
>>> -       }
>>> +       if (!IS_ERR(reset_gpios))
>>> +               for (i = 0; i < reset_gpios->ndescs; i++)
>> The only difference from the behaviour when the hang was occurring is now
>> the order the pins are manipulated.  Maybe that matters?
>> Could you please retry the same with the order of pins reversed, either
>> in
>> the .dts file or here inside this for loop?
>
> I've switched the order of pins in dts and next-20180920 + first patch +
> above
> change also boots fine.

Thanks for performing those tests.

Since we are not able to reproduce the issue by any means other than
using the original code introduced by fast bitmap processing changes,
regardless of the first fix being applied or not, and we are only able to
resolve the hangup by excluding affected use case from the fast path,
we have to assume one or more bugs which affect mixed arrays, i.e.,
those which apply for fast bitmap processing only in part, may still exist
in the code introduced by the fast bitmap processing series.  I hope we
are able to resolve it soon, before the changes reach mainline.

Thanks,
Janusz


> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
