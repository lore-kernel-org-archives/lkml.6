Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47146C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A2F20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A2F20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeILAFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:05:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46721 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeILAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:05:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id u11-v6so21666883uan.13;
        Tue, 11 Sep 2018 12:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWI6zvQ9G7tcKp4qOPEjq0IE4UeDmsu5osBqyCg6Cyc=;
        b=c/cD9/tjyI/j0RDVxPxTr9rYELgOq3CVqb4D1GVSjbBMVc4+GWyQ9+qgsSPOzIJJTH
         6iQYcZ38XOvtpzFim0fQZyc2uacWMAyi3O7Iv7AVCRSiXIKXIH6+vy8KtG4Gw2fUrH41
         dwhwVX/hJ2RIZT/jEMfzDdU8/5BDpmPdRhG/9dEggtwG/KMOqKXL5MgGup3B+f/JyTcw
         cmN7jnXumzjB6x5Ma3Mte8RHGdW7xBk+ZoerUTKNgJh+gKAG//tF39GziqGXr9/20FNl
         Nf7j1AOnIda3DCciZeqR0whAdWQToYxPcvWQCiftRlAXrXcQSLTla8hVi8jkFo8VWWVf
         ytmw==
X-Gm-Message-State: APzg51CvG/jt6UhlAX7JzkaCvASiylofJpAwGbKecyIFM6f1jlQSydtS
        kVarcVIRXm714TsBPNDSaMV46xOdJNcLA6fOxIo=
X-Google-Smtp-Source: ANB0Vda5kA31RzC38qTr4Xm/62uomRc2UNfITX8CqChzt+Hrf4p1DgPhMxw7/VVJohJ/PhWHP+92Ly6GBjnLzU2DJIM=
X-Received: by 2002:a67:3241:: with SMTP id y62-v6mr9048304vsy.57.1536692708784;
 Tue, 11 Sep 2018 12:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net> <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
In-Reply-To: <20180911185839.GA25212@piout.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Sep 2018 21:04:56 +0200
Message-ID: <CAMuHMdV_btX=HcTpfnrP6iUfrBNvQfDybE_tKtJZZERMQ8n=ZA@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>, radu_nicolae.pirea@upb.ro,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Sep 11, 2018 at 8:58 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 11/09/2018 19:39:30+0100, Lee Jones wrote:
> > On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:
> >
> > > On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > > Then you'd have multiple compatible strings for the same IP which is a
> > > > > > big no-no.
> > > > >
> > > > > It's still the same hardware device, isn't?
> > > > > What if the SPI or UART slave is not on-board, but on an expansion board?
> > > > > Then the SoC-specific .dtsi has no idea what mode should be used.
> > > > >
> > > > > Hence shouldn't the software derive the hardware mode from the full
> > > > > hardware description in DT? If that's impossible (I didn't look into detail
> > > > > whether an SPI bus can easily be distinguished from a UART bus), perhaps
> > > > > a mode property should be added?
> > > >
> > > > Yes, this is exactly what is done:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33
> > >
> > > OK.
> > >
> > > I guess the main "hackish" part is that the mfd_cell uses of_compatible,
> > > which thus requires having additional compatible values?
> > >
> > > I think those can just be removed. AFAICS, the SPI and serial drivers already
> > > match against the "at91_usart_spi" resp. "atmel_usart_serial" platform device
> > > names?
> >
> > The hackish part of this driver is that it's using MFD for something
> > which is clearly not an MFD.  It's a USART device.  Nothing more,
> > nothing less.
> >
> > Does anyone have the datasheet to hand?
>
> It is not a simple usart, it is either a usart or a full blown SPI
> controller with registers changing layout depending on the selected
> mode. Otherwise, I'm not sure how you would get a USART to do SPI.

Note the "S" in USART. SPI is just synchronous serial with a shared clock
for transmit and receive. So the hardware is not that unrelated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
