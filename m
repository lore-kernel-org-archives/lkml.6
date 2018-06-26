Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FE0208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuG59Bn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FE0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeFZUom (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:44:42 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39170 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933191AbeFZUoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:44:39 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so11798539uad.6;
        Tue, 26 Jun 2018 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nfOtQiQHZ+wi2NG1xVzLSk3SFSAgbgKPgSuzz4qK8fo=;
        b=iuG59Bn6usjcFnFs4CV35JsJ0FRReAKI9QmMgE3PK0iqIO9maDgbclk8R4v3EMBhvY
         F8Upcehbqn7P9qfFRxa7BPAEbNW2Xx+glh+aHdoOsKWbutXFDhV51j4B6wkZl6G/CfwL
         VuA/HA6caQhrFrLIlh6Jhm+I0zVuNUIXnbMz5LU4ZskihQ1M2lux09H5s1oseK+Fn3Ru
         qjpKrlcqwqJuk2F+XWq4Pk8w45OPNmD6wVywZU+tehjOdvLcZclJKgZR7el+uDVxPJuQ
         GPYemnP+GqFGVvWMbx6bmTYoUFc4nPGy8oPASkvOxlo3Z1vscVh9m6nS0HEa7jbm5M8o
         8K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nfOtQiQHZ+wi2NG1xVzLSk3SFSAgbgKPgSuzz4qK8fo=;
        b=rMFZVA3MkEQeeHIogM9ixMr5vBwfPW6uM89GT1rOPyLoV/ID0+J5p7HLPMWoLnWvky
         P660yLzavMnRk956d37CSBdRbqFTR7wzmo2d7cA1MgaSnvSOysvE+xjOl66BUgeR6r2q
         Oi1mmT0/ZR5jhbQUoqvFUpfHXusbvLQ3eQWiCDoNT+JtNxNkucNsu11MKI/LjDjoqO3E
         1JoM4BvAFKoBVfGM1bfmjDBOLsh8jgpo4Y8+ZtXSN/l9Yq0FSQ4b6IgtkHoTl/55qtIt
         +uDkmSb7GWhlH8FM6R8nohJ0YR7lkGhO71LJ4sSmaPH9HwZ4pwEsURgcPu7oYhYWPjBS
         lrjg==
X-Gm-Message-State: APt69E3PwVWiRlvquGJc7mIYubw/cNTVs42rhjz6wwUd1ANtTWyrQzCD
        TV7fkqi9GIHoLUCGNjwQUI7U5APdKLhSybw/Jxo=
X-Google-Smtp-Source: AAOMgpcyePGt4F6P1c+lxoqDOFkHK+pzDDR2qwKo6khdtmM60soMD4jUK7Hb9va+tSCrLoIyNVnSBkHfn8AIgX8el0M=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr1983563ual.141.1530045877911;
 Tue, 26 Jun 2018 13:44:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 13:44:36
 -0700 (PDT)
In-Reply-To: <20180626215648.1472b96e@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 23:44:36 +0300
Message-ID: <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 26 Jun 2018 22:07:03 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > Add a driver for Cadence I3C GPIO expander.
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>
>> > +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);
>>
>> kmalloc_array() ?
>>
>> > +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
>> > +                                      ARRAY_SIZE(xfers));
>>
>> One line?
>>

>> You don't change mask here, why do you need a pointer to it?
>
> What are you talking about??!!! This is part of the gpio_chip interface
> that drivers have to implement. You can't decide that mask should not be
> a pointer. And if you actually look at the code, you'll probably see
> that the reason we're passed a pointer here is that the GPIO chip might
> expose more GPIOs than can be represented by an unsigned long, hence
> the array of unsigned long.
>

> I'll say it here because this is not the first time I'm pissed off by
> one of your review.

Like 'I like offending people, because I think people who get offended
should be offended.' ?
I'm not that guy, relax.

>  You seem to review everything that is posted on the LKML,

That's not true.

> and most of the time your reviews are superficial (focused on tiny
> details or coding style issues). Don't you have better things to do?

If your code is written using ancient style and / or API it's not good
to start with.
Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?

On top of that you might find more interesting reviews where I pointed
out to a memory leak or other nasty stuff. But of course you prefer
not to norice that.
I understand you.

> I mean, I'm fine when I get such comments from people that also do
> useful comments, but yours are most of the time useless and sometime
> even wrong because you didn't time to look at the code in details.

Calm down, please.
You would simple ignore them. Your choice.

But okay, I would try to avoid your stuff to make you happier. Sorry
for disturbing.

>> Ditto.

In these two comments I'm indeed wrong.

-- 
With Best Regards,
Andy Shevchenko
