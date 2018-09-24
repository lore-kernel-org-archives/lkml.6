Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8308DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB582098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCvMIt3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB582098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeIXRJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:09:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40551 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:09:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id j68-v6so568839oib.7;
        Mon, 24 Sep 2018 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1p534W35sqCWplCn+Y6xqzi2jcGhSQqylEiQ9nfK2Pk=;
        b=HCvMIt3YT78N2Oxx2VcMJ7CtI1Dj4WP0OEjzsb8YYhKjt/n2ob1o7mVkYRDxebSyXD
         +zqUyXU6uZKmiT4ciRWzgdZ6C8q1tJ3PUAo8ywi/DcDisDSGvZ22JFKaMA0dXDmnFSO7
         yMw4w+NZkc5afa0qUmMf1pdaYMp43g/JOdR5pecrBVw+v+4CivO+EQ+18+35Iv1QbzlO
         VFtPNZI/Zd/9cpdpxA9BjSTcy79SRxfB/gQckys1TpYaTl/fvTuu4OVjxvyBYc6z+Jqm
         Z4iPx/Kf9qsWJMyxiaTgrq2GuA7Y+GDIUgY/ABTvwyMshQKYuqYtSZ8Xl08ZHIOWMyJT
         d6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1p534W35sqCWplCn+Y6xqzi2jcGhSQqylEiQ9nfK2Pk=;
        b=erzZ+KFkLInEnMN7QRdfK0nhsAPX8r55TkNHq83zoXHWdVQ8C9r2fXi8nAzy2qPcUF
         aOj0O05QWUqsXYo/FqW43shRssgON1p/13jursJAH/B4kkHFl5SLB5Too47ACCLzhtnb
         OriJ5TJmScqldhDS2vm3HDeXfy4mHxY+Z6Pc2CXxArkoQpdH4k1+9w1Kn/o8AoSRUK2Z
         ti9k5OhIAcQZg7pANqwrZi5RkYd1hD/9C0Ab8PeN1Lpz7euhdtFkAl0Bog6PS+N1O2ac
         w673s+oGsmDTI8VP6rtc29Dpekce98HY7hJMEdiaqSc7n0pXet5gI5Yc4YoffeNnsdmn
         CUFg==
X-Gm-Message-State: APzg51CCMnzzX1S6DtM1Bnnj9UV2WiclqiC+8VhZMusymFk2rLyhuKDJ
        bLhnwsVaYfGvxZlEGAD7tx8DdCLwBx0m7mjS9Og=
X-Google-Smtp-Source: ANB0VdbBfoKUbge7FxBeLUm4b0djnokjW9sswz1vA8HKkmQnjpns1aIQpr7VnzxzXK74/kMX1T5MkGfhn3OOTLSczBI=
X-Received: by 2002:aca:6898:: with SMTP id o24-v6mr4895085oik.44.1537787291681;
 Mon, 24 Sep 2018 04:08:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:326:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 04:08:10 -0700 (PDT)
In-Reply-To: <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
References: <2785169.v6aIfS3K2k@z50> <CGME20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2@epcas3p3.samsung.com>
 <20180923235336.22148-1-jmkrzyszt@gmail.com> <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
Date:   Mon, 24 Sep 2018 13:08:11 +0200
Message-ID: <CAGfqbt6H8u_dUokB-pg51kCj09G8Mh7wB0879nKMw5Dw83tcSg@mail.gmail.com>
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

2018-09-24 11:43 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
> Hi Janusz,
>
> On 2018-09-24 01:53, Janusz Krzysztofik wrote:
>> While investigating possible reasons of GPIO fast bitmap processing
>> related boot hang on Samsung Snow Chromebook, reported by Marek
>> Szyprowski (thanks!), I've discovered one coding bug, addressed by
>> PATCH 1/2 of this series, and one potential regression introduced at
>> design level of the solution, hopefully fixed by PATCH 2/2.  See
>> commit messages for details.
>>
>> Janusz Krzysztofik (2):
>>        gpiolib: Fix missing updates of bitmap index
>>        gpiolib: Fix array members of same chip processed separately
>>
>> The fixes should resolve the boot hang observed by Marek, however the
>> second change excludes that particular case from fast bitmap processing
>> and restores the old behaviour.
>
> I confirm, that the above 2 patches fixes boot issue on Samsung Snow
> Chromebook with next-20180920.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>> Hence, it is possible still another
>> issue which have had an influence on that boot hang exists in the code.
>> In order to fully verify the fix, it would have to be tested on a
>> platform where an array of GPIO descriptors is used which starts from
>> at least two consecutive pins of one GPIO chip in hardware order,
>> starting ftom 0, followed by one or more pins belonging to other
>> chip(s).
>>
>> In order to verify if separate calls to .set() chip callback for each
>> pin instead of one call to .set_multiple() is actually the reason of
>> boot hang on Samsung Snow Chromebook, the affected driver -
>> drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
>> modified for testing purposes so it calls gpiod_set_value() for each
>> pin instead of gpiod_set_array_value() for all of them.  If that would
>> also result in boot hang, we could be sure the issue was really the
>> one addressed by the second fix.  Marek, could you please try to
>> perform such test?
>
> Yes, I've just tested next-20180920 only with the first patch from this
> patchset and the mentioned change to drivers/mmc/core/pwrseq_simple.c.
> It boots fine, so indeed the issue is in handling of arrays of gpios.
>
> Just to be sure I did it right, this is my change to the mentioned file:

Yeah, that's what I had on mind.  However, I'd be more lucky if it didn't work
for you.  Setting the pins sequentially, not simultaneously as before, was
exactly what I hoped was the reason of the hang.

> diff --git a/drivers/mmc/core/pwrseq_simple.c
> b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..9397dc1f2e38 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -38,16 +38,11 @@ static void mmc_pwrseq_simple_set_gpios_value(struct
> mmc_pwrseq_simple *pwrseq,
>                                                int value)
>   {
>          struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> +       int i;
>
> -       if (!IS_ERR(reset_gpios)) {
> -               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> -               int nvalues = reset_gpios->ndescs;
> -
> -               values[0] = value;
> -
> -               gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
> -                                              reset_gpios->info, values);
> -       }
> +       if (!IS_ERR(reset_gpios))
> +               for (i = 0; i < reset_gpios->ndescs; i++)

The only difference from the behaviour when the hang was occurring is now
the order the pins are manipulated.  Maybe that matters?
Could you please retry the same with the order of pins reversed, either in
the .dts file or here inside this for loop?

Thanks,
Janusz

> + gpiod_set_value_cansleep(reset_gpios->desc[i], value);
>   }
>
>   static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
