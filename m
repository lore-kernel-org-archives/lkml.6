Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7792C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715412064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agigNKJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715412064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeH2V5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:57:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45062 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2V5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:57:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id u83-v6so5081648lje.12;
        Wed, 29 Aug 2018 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYip9AbOVCQgzEPXolEh51dBtI4CiIkZBSQPky4ecn4=;
        b=agigNKJjS8dB2aFfLGNADSTn+0JLzQYB07CkbSmeMBWx4BOPO8ybWk9tvjGQSRl9dH
         ZfkWMOWjaNHs/ne+WEcxR3TmGvdx9G1qYZtnjdp5gPr0tajZDDM8zszWZDRaMUtjydod
         6f6dJP37AJnKSnO64NBFETSvpwtfdNWi4tru1vKy4mDu72eliTxjjbLjPnuziGMtrs86
         ad5wdnNty3vEAvyuvo68HtyjYVTGszZFgIVt7oFHCpgI2nddVWwDTYD98UcgdhHQTH60
         JOfiRynYp5cr+CC9MpCqT2V5H0zCI4FdtfxBW9YH+ebXl/+tgnfDM5Ff4O395Ov8aLBh
         vvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYip9AbOVCQgzEPXolEh51dBtI4CiIkZBSQPky4ecn4=;
        b=Rv9IfGAiy4rcePh6R8pjaOSu4/rqUDg+pQ7fEfOEYvu6eM27YzJ5Zu5/ZDxEandWnN
         1qvlkflIt+XtG2KFy5ZP5m6SIasGH7pUl9qOjju9lbRbn2ni5G5WdnEbN6FxkxAfcPJd
         5clbfLCUZRjCLx742pwkFzYOHOmo7mZOoGRR+YTtJw4TIx3xXiUH6pBg5nMslifyYwun
         HmUlvtRFUQGskn/VeQWwgdijHmUnYorspW5tT4CYOK2KeHkuu2VEN+VNVczlfWH1922m
         6YGkDqs/i+fL9EkU3EsjSeIJFJwr81aJDGGzixX48MxlzRhIsg2UqzbY394RM5FcluS9
         aSCw==
X-Gm-Message-State: APzg51C97F6aDd0UVmV5QfrMRFUQtkUMmd1Dr513yJAp5rmNJCfioCRZ
        DHyLwauMQ9VGm0gjTQs/Oy0=
X-Google-Smtp-Source: ANB0VdbupMqoF339jwiN7cehTpN+3p+1Lv3klNTnCV/qDkPvJb2gkHmzZMVvnJIXySfRnj4NDV8Y2w==
X-Received: by 2002:a2e:1301:: with SMTP id 1-v6mr1094029ljt.56.1535565587710;
        Wed, 29 Aug 2018 10:59:47 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id j10-v6sm860262ljb.33.2018.08.29.10.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 10:59:46 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC RFT PATCH v4 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date:   Wed, 29 Aug 2018 20:01:01 +0200
Message-ID: <21039309.e3MgZOjmZl@z50>
In-Reply-To: <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com> <20180820234341.5271-2-jmkrzyszt@gmail.com> <CANiq72kM9bYJ1Q+dbLumjfQLZW223ZTrYEFqfQ2Jv2SAjrD1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 29, 2018 2:03:18 PM CEST Miguel Ojeda wrote:
> Hi Janusz,
> 
> On Tue, Aug 21, 2018 at 1:43 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > Most users of get/set array functions iterate consecutive bits of data,
> > usually a single integer, while or processing array of results obtained
> > from or building an array of values to be passed to those functions.
> > Save time wasted on those iterations by changing the functions' API to
> > accept bitmaps.
> >
> > All current users are updated as well.
> >
> > More benefits from the change are expected as soon as planned support
> > for accepting/passing those bitmaps directly from/to respective GPIO
> > chip callbacks if applicable is implemented.
> >
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  Documentation/driver-api/gpio/consumer.rst  | 22 ++++----
> >  drivers/auxdisplay/hd44780.c                | 52 +++++++++--------
> 
> [CC'ing Willy and Geert for hd44780]
> 
> > diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
> > index f1a42f0f1ded..d340473aa142 100644
> > --- a/drivers/auxdisplay/hd44780.c
> > +++ b/drivers/auxdisplay/hd44780.c
> > @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
> >  /* write to an LCD panel register in 8 bit GPIO mode */
> >  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -       int values[10]; /* for DATA[0-7], RS, RW */
> > -       unsigned int i, n;
> > +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */
> 
> Why [1]? I understand it is because in other cases it may be more than
> one,

Yes, I tried to point out the fact the new API accepts a bitmap of an arbitrary 
length, and I tried to use the same code pattern across changes to the API 
users.

> but...
> 
> > +       unsigned int n;
> >
> > -       for (i = 0; i < 8; i++)
> > -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -       values[PIN_CTRL_RS] = rs;
> > +       value_bitmap[0] = val;
> > +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
> >         n = 9;
> >         if (hd->pins[PIN_CTRL_RW]) {
> > -               values[PIN_CTRL_RW] = 0;
> > +               __clear_bit(PIN_CTRL_RW, value_bitmap);
> >                 n++;
> >         }
> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >  }
> > @@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  /* write to an LCD panel register in 4 bit GPIO mode */
> >  static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> > -       unsigned int i, n;
> > +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> > +       unsigned long value_bitmap[0];
> 
> This one is even more strange... :-)

This one is an error, should be 1 of course :-), thanks.

> > +       unsigned int n;
> >
> >         /* High nibble + RS, RW */
> > -       for (i = 4; i < 8; i++)
> > -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -       values[PIN_CTRL_RS] = rs;
> > +       value_bitmap[0] = val;
> > +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
> >         n = 5;
> >         if (hd->pins[PIN_CTRL_RW]) {
> > -               values[PIN_CTRL_RW] = 0;
> > +               __clear_bit(PIN_CTRL_RW, value_bitmap);
> >                 n++;
> >         }
> > +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;
> 
> Maybe >>=?

OK.

Answering you question below:
To make my changes as clear as I could imagine, I decided to use the same indexing as in the original code, i.e., assign high nibble of val to bits 4-7 and two other values - rs and an optional 0 - to bits 8 and 9, respectively.
Unlike in case of array of integers, where for the high nibble part you could just pass a pointer to a sub-array starting at the 5th value (i.e., &values[PIN_DATA4]), it was not possible to do the same for and arbitrary bit of a bitmap, e.g., pass a pointer to the 5th bit of *value_bitmap as an argument pointing to bit 0 of a bitmap to be processed. That's why I shifted the bitmap right by 4 bits.
Then, ...

> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >
> >         /* Low nibble */
> > -       for (i = 0; i < 4; i++)
> > -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> > +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> > +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
> 
> Are you sure this is correct? You are basically doing an or of
> value_bitmap and val and clearing the low-nibble.

having the rs and optional 0 already assigned to bits 4 and 5 of the bitmap, I just cleared bits 0-3 still containing the high nibble of val and assigned the low nibble of it to those bits, getting a result ready to be passed as an argument to gpiod_set_array_value_cansleep() below.

I hope I didn't miss anything.

Thanks,
Janusz

> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >  }
> 
> Cheers,
> Miguel
> 




