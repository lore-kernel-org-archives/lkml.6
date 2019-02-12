Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C8C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GAgXieVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfBLM3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:29:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40921 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfBLM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:29:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so4051199oth.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ra7LCZ/lf2uw2t4sAFfcvxGp8nDlEvhVh2aiSaqLEVI=;
        b=GAgXieVLcSlRgosjj10zUMSvJoNk6HKKoSqcfjZjw6c720PZbHZhyr788el9L5n03Z
         zFtr2CYYDmy0Cbw2WU2Z8xw0aG9nRfVmt+tg6iKvgmqn0yoMKmqrWWkZB3U0eVppupr8
         IYIKk9ctGhJbGou+X336CsFP5c+dlBUWGCh5hiAlOVBI58hfobGRPIGGLPWKsQfSzeze
         a0cu8vSiZZScUCfGQZbIINskGULXxnLjBYpQrT78sqG22h7MUbzoeCS/dWjRsouWVpp1
         hfuKLrUYcxFDWWtBP4jrmWp9DhTncZTYpFg3GXoHYz75s/Q2Xs1xV9I0R8uBG1XAIQcN
         JH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ra7LCZ/lf2uw2t4sAFfcvxGp8nDlEvhVh2aiSaqLEVI=;
        b=AxAMlWKc3FBwqETdVYdaL4cEJL88t4Fdpyt/ntGDaQRgw00x4q6ZouqBhEcnMbD04z
         pW+79JidyveiNEsqldCnCBUmzfh4NnkmP3bA5KRfjOQxh0AS6uabDIewNy9rLd49Iyij
         gMzdvCjgaL/ekBuak6Vk2Bwf3fEB7jmDrEFI+Ol42e5AMeap/EifmRE/5Q/di66T92e0
         WKadt5K29802A+yML3YzOxgsImosluMDT3BcQIK1zyTiT7cQi/+7LPq/vWPZ7IQqAEKf
         cg2x9zaPW8Eh0jho0VNX4llF3+jDL4RX1UYU+GWS7vQvxf59tlv/GI77KlfX/oSJG3VD
         zfBQ==
X-Gm-Message-State: AHQUAuYh6mNYMcGCyvg2DoLgUxy76akbuUL7N2ZTtYBYKJxyGag0HzBm
        W+VGnctM8delguAHe3cTRgGclvxfeouNyHErxQmYKA==
X-Google-Smtp-Source: AHgI3IYymIY46aGlMuHJC+Acd/0oJa4EoF5fgHnhXDneSHx/pJPUd41+S06+S+Z/KhuiBmSmzcB7yvvrCfBF77BV6vE=
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr3393647otl.108.1549974590601;
 Tue, 12 Feb 2019 04:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell> <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell> <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell> <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell>
In-Reply-To: <20190212111403.GC20638@dell>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Feb 2019 13:29:39 +0100
Message-ID: <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
>
> > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisa=C5=82(=
a):
> > >
> > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > >
> > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisa=C5=
=82(a):
> > > > >
> > > > >  * The declaration of a superfluous struct
> > > > >  * 100 lines of additional/avoidable code
> > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > >  * Resources were designed for HWIRQs (unless a domain is present=
)
> > > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > > >
> > > > While the above may be right, this one is negligible and you know i=
t. :)
> > >
> > > You have nested for() loops.  You *are* wasting lots of cycles.
> > >
> > > > > Need I go on? :)
> > > > >
> > > > > Surely the fact that you are using both sides of an API
> > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, m=
ust
> > > > > set some alarm bells ringing?
> > > > >
> > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mes=
s.
> > > > >
> > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > >
> > > > What do you propose? Should I go back to the approach in v1 and pas=
s
> > > > the regmap_irq_chip_data to child drivers?
> > >
> > > I'm saying you should remove all of this hackery and pass IRQs as the=
y
> > > are supposed to be passed (like everyone else does).
> >
> > I'm not sure what you mean by "like everyone else does" - different
> > mfd drivers seem to be doing different things. Is a simple struct
> > containing virtual irq numbers passed to sub-drivers fine?
>
> How do you plan on deriving the VIRQs to place into the struct?

Exampe:

struct max77650_gpio_pdata {
    int gpi_irq;
};

In MFD driver:

struct max77650_gpio_pdata *gpio_data =3D devm_kmalloc(dev, sizeof(*gpio_da=
ta));

gpio_data->gpi_irq =3D regmap_irq_get_virq(irqchip_data, GPI_NUM);

gpio_cell.platform_data =3D gpio_data;

In GPIO driver:

struct max77650_gpio_pdata *gpio_data =3D pdev->dev.platform_data;

int irq =3D gpio_data->gpi_irq;

Bart
