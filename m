Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FB2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B0020867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxqNbVlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B0020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeH2QAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:00:15 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35852 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2QAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:00:15 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so5361672qtn.3;
        Wed, 29 Aug 2018 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QhyyQ5o8Tbf1PRCvhaTyJhFjlkhiBxtgPelayeRtD3w=;
        b=nxqNbVlJUU92BbTvT8nlwsKHmPTeT8JgXq2mfIA3snNb6/eMxMa1tRERXPNnuOWoiG
         PhI/GyZkzeLg0Hc0pGoF0AaCOGQtgXFXGxJ4T53t8LgEdA41JB41Ct/Rddt4mjOotOb8
         Oyw4ioaf2W5YgiXE+ehwd3tmfQWqpdIOMIQq8da8dWAw2F7eVhd/Wq/8S8+4+ue7nCHq
         +slR50cLmD6/GLvLh1FKXl86AP1CwfYtg9egyP9a9EDXUBCFX63E7nF9dfcdpV7nEunh
         mrw/Of0WBeuxmRNMdtcHVFxcwQaAgPZuUHgSGWIM8b5K/XUyO41NQym8t0SQwuQXNQ/M
         yGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QhyyQ5o8Tbf1PRCvhaTyJhFjlkhiBxtgPelayeRtD3w=;
        b=q0gCQQoJVQazDGSOXtUa5sLy6zqz+UNjN62qjxynXO0J8JI4rv5Vt7bL/w+Rofi79f
         LTCqORUF0KGfG7wbnkbJHmMOpeS9quLtXaMas7iNOBU7s+ayA5I69iPkNJ/5EjRAlT9U
         h6QBGDaV01HGRQmVmqsDUyaRkjKs7T4/9TrKzpyXynTvlrfJl7ff1gV/Z7hj51Qz7e2F
         tUPJ8D7h/6gbgWTlneD5ZFRkL1jIzISXn5klxSIcASLq5NlPZJw0xSSkS9tY9O8GBEn5
         BeCPhzw2tT0nPW4/U4ESaq64Ok6qvW2hodYIWy3yTPfkyeEiuNG0Hoypw7xa2NmuGXBV
         zwUg==
X-Gm-Message-State: APzg51C35oWapWApwMzPHRiM4GmaFw4CQ3MbdUHvo6K/Fn9UH61Ogo6o
        WsmQ6VI8l7o2oO1sonrTxEbGP/RVZkvHLLmxyJk=
X-Google-Smtp-Source: ANB0VdaZjvh2LG5L2TR4qHb0WX5yW+FGpBFXqpg7c39H/GNAZ7XOVnQqMznAYox4xSV0u43hWgntshcUNJDr2sJz4Bo=
X-Received: by 2002:ac8:350f:: with SMTP id y15-v6mr6320343qtb.241.1535544218743;
 Wed, 29 Aug 2018 05:03:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 05:03:18
 -0700 (PDT)
In-Reply-To: <20180820234341.5271-2-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180820234341.5271-2-jmkrzyszt@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 29 Aug 2018 14:03:18 +0200
Message-ID: <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays,
 to get/set array
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Tue, Aug 21, 2018 at 1:43 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while or processing array of results obtained
> from or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
>
> All current users are updated as well.
>
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
>  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------

[CC'ing Willy and Geert for hd44780]

> diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> index f1a42f0f1ded..d340473aa142 100644
> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */

Why [1]? I understand it is because in other cases it may be more than
one, but...

> +       unsigned int n;
>
> -       for (i = 0; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 9;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }
> @@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  /* write to an LCD panel register in 4 bit GPIO mode */
>  static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> -       unsigned int i, n;
> +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> +       unsigned long value_bitmap[0];

This one is even more strange... :-)

> +       unsigned int n;
>
>         /* High nibble + RS, RW */
> -       for (i = 4; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 5;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
> +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;

Maybe >>=?

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>
>         /* Low nibble */
> -       for (i = 0; i < 4; i++)
> -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);

Are you sure this is correct? You are basically doing an or of
value_bitmap and val and clearing the low-nibble.

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }

Cheers,
Miguel
