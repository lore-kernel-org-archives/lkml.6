Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA00CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7448020835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQn/cmwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7448020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeIBOd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:33:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46475 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeIBOd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:33:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so13160714ljj.13;
        Sun, 02 Sep 2018 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3fMok0crc1QBKbOP4mhqwOxX6VMu2jrrFK5Ca4q0QI=;
        b=aQn/cmwoPsTt28eG1Kz8hukFvQsbxBS7ZY+d6T2/EgUQiJRfRbfU9iVLPk7O7IwCOs
         48zfFWQyx5iA50C2d9Cw22K8zfHCJqySXD5dIoxR63EJPPNjCaxqHy2bq3YiyFW9Csdy
         XxNKhItcExvLDFDJIPXjm2Wd98TzxJtHVcZUNCYPYaqgQ+JKGEEBmn8t8WyImJRqiH97
         6oxqoQULxCBtk9ofaNSucXmgNUWFfixNWmWd58bhvxTDwuwodDF749RFYooXGFzP4tWv
         s0yVoEW+YnwVA08eFFrrCrd6ypNvKV2TGIxw4FnPwJXXTkwdx7gln5Xq3cpf/T9sUwKK
         Ohpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3fMok0crc1QBKbOP4mhqwOxX6VMu2jrrFK5Ca4q0QI=;
        b=hN840/pO6HZgjZyAbNNX8+haKZJpzg+7MygvgcuSFybSRwkXy/XCqhkHlDts5xXujj
         0IAfwz/xN+wDP7E0YmaWc0Dp13fBJsMstg2oKoSepHwI4Qlhw8M+fOeCKUwBPN7zjLhF
         +t8/BA6QqhNLxFQqSHMnRKOGaD50sAdSLrzHo3P/fmnWS/xkZNZv/9yqqVrQ/kWgz0qp
         iwEXcdvEsMOlohvGci2SuGaCLuy1xwa3oSJM6tOxzEfTU+0aDnGKyu0ii9zGMB2yZ95t
         074M9nL+tAsWy9kHjbEb2JfsXrABquqsGrBHu1Mbh4pb2VcxR1hSuLx+PdaWoRcQYnaB
         7yzw==
X-Gm-Message-State: APzg51Cy8P5ZfGVaaUeMVUujQXb/XbI+kXvrLi1HTK9rSwX0SRicP14+
        YHkejWBJFUf1NyEZ4+1ss8k=
X-Google-Smtp-Source: ANB0VdZssjmXQjNvrAVDa+Nn16fD2vH/0bm7fRqRBXJ13wzJqbyvdlvQEQxED3xy++MdXlvv7gB6rg==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr15730301lje.105.1535883487344;
        Sun, 02 Sep 2018 03:18:07 -0700 (PDT)
Received: from z50.localnet (apn-37-248-210-194.dynamic.gprs.plus.pl. [37.248.210.194])
        by smtp.gmail.com with ESMTPSA id k4-v6sm2770411ljc.6.2018.09.02.03.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 03:18:06 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array
Date:   Sun, 02 Sep 2018 12:19:11 +0200
Message-ID: <2195152.WzNjLO0DAH@z50>
In-Reply-To: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-2-jmkrzyszt@gmail.com> <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Thursday, August 30, 2018 1:10:59 PM CEST Miguel Ojeda wrote:
> Hi Janusz,
> 
> On Wed, Aug 29, 2018 at 10:48 PM, Janusz Krzysztofik
> <jmkrzyszt@gmail.com> wrote:
> > ...
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
> > +       value_bitmap[0] >>= PIN_DATA4;
> >
> >         /* Present the data to the port */
> > -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> > -                                      &values[PIN_DATA4]);
> > +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], 
value_bitmap);
> >
> >         hd44780_strobe_gpio(hd);
> >
> >         /* Low nibble */
> > -       for (i = 0; i < 4; i++)
> > -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> > +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> > +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);
> 
> This is still wrong! What I originally meant in my v4 review is that
> there is an extra ~ in the second line.

Indeed, that's wrong, I missed your original point, sorry.

> Also, a couple of general comments:
> 
>  - Please review the list of CCs (I was not CC'd originally, so maybe
> there are other maintainers that aren't, either)

That's probably because early versions of the series, prior to v4, were not 
touching existing GPIO API so there were no changes to users of gpiod_get/
set_array_value() and their variants. From v4 on, you are in the loop so don't 
worry, you haven't missed anything.
But anyway, thanks for your suggestion to review the Cc; list, I've done that 
for v7 and added still a few people who contributed most to the code being 
changed.

>  - In general, the new code seems harder to read than the original one
> (but that is my impression).

I hope we are slowly approaching acceptable readability in recent iterations.

Thanks,
Janusz



