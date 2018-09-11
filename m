Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38784C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9923206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9923206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeILAAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:00:04 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45772 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeILAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:00:04 -0400
Received: by mail-ua1-f65.google.com with SMTP id q7-v6so21646759uam.12;
        Tue, 11 Sep 2018 11:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbJfPC/7OLVXR+pZM3OrG1JkPMOdJCJanLlsjxs3gQc=;
        b=GOFxJw8eOfdil8PPOhs2FiBOyWwZFp5KwIfViVrgo4dqAIFfDReaaHmm729IrLi97K
         xkPgY2ZdN80DyGY9malbykXYfmx+rCZftB1STTw9yRz7wPnt9CTIhA1mpVINzHRVTDxs
         WAfCsgBF8SHV+V2SEWyDWJRge0o/5S33UhHahJXus0SFCtdxWsMRH9Ae9sM8+L0AbVOJ
         J6mZfTcOrxoKnyXIXnbt3AOAArp3q8Yi93dQrydNRL7EICRrZps7kEAWAaM5CQdKLTBf
         TSY/hNCrLXprgBEncPWSlTvm3hDz+1TRP9G+KWFh/RvscvYk12M7Vno56RAn7MHoNwZy
         iXHg==
X-Gm-Message-State: APzg51BupbwEqNpidgR5kAPfvKpVw+3klRWsQFiOidoYI9vA2Cwcd6ec
        Bixg+dRJi7AMWCUS9c/H5LX0A4XQz/OTb3gcwN8=
X-Google-Smtp-Source: ANB0VdYz/YbuMgYXeP3Y9hIelpLGWg/xAuwETezPmG0dPhmZOo03tCWEGhsZdimSwEBKgZ8mhdQcqIX5KLPz3De1kCg=
X-Received: by 2002:a67:6908:: with SMTP id e8-v6mr9844272vsc.21.1536692363895;
 Tue, 11 Sep 2018 11:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net> <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell>
In-Reply-To: <20180911181838.GI4185@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Sep 2018 20:59:12 +0200
Message-ID: <CAMuHMdUMt=HJGCDZvJF99=45mecn5AjnTr-tA_LioxWrNKM2ag@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>,
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

Hi Lee,

On Tue, Sep 11, 2018 at 8:40 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 11 Sep 2018, Geert Uytterhoeven wrote:
> > On Tue, Sep 11, 2018 at 5:36 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > > On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> > > > On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> > > > <alexandre.belloni@bootlin.com> wrote:
> > > > > On 11/09/2018 10:33:56+0100, Lee Jones wrote:
> > > > > > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > > > > > Radu Pirea (6):
> > > > > > >   MAINTAINERS: add at91 usart mfd driver
> > > > > > >   dt-bindings: add binding for atmel-usart in SPI mode
> > > > > > >   mfd: at91-usart: added mfd driver for usart
> > > > > > >   MAINTAINERS: add at91 usart spi driver
> > > > > > >   spi: at91-usart: add driver for at91-usart as spi
> > > > > > >   tty/serial: atmel: change the driver to work under at91-usart mfd
> > > > > > >
> > > > > > >  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
> > > > > > >  MAINTAINERS                                   |  16 +
> > > > > > >  drivers/mfd/Kconfig                           |   9 +
> > > > > > >  drivers/mfd/Makefile                          |   1 +
> > > > > > >  drivers/mfd/at91-usart.c                      |  71 +++
> > > > > > >  drivers/spi/Kconfig                           |   8 +
> > > > > > >  drivers/spi/Makefile                          |   1 +
> > > > > > >  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
> > > > > > >  drivers/tty/serial/Kconfig                    |   1 +
> > > > > > >  drivers/tty/serial/atmel_serial.c             |  42 +-
> > > > > > >  include/dt-bindings/mfd/at91-usart.h          |  17 +
> > > > > > >  11 files changed, 606 insertions(+), 17 deletions(-)
> > > > > > >  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
> > > > > > >  create mode 100644 drivers/mfd/at91-usart.c
> > > > > > >  create mode 100644 drivers/spi/spi-at91-usart.c
> > > > > > >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > > > > >
> > > > > > Seeing as this patch-set has caused some issues this morning, I took
> > > > > > the liberty to peruse back into its history to figure out where things
> > > > > > started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
> > > > > > I did!
> > > > > >
> > > > > > My Acked-by has been attached to the MFD portion since v5, which is
> > > > > > why the code hasn't caught my eye before today.  I reviewed the
> > > > > > relocation of the *binding document* (serial => mfd with no changes)
> > > > > > in v4 and nothing else.  It appears as though you mistakenly added it
> > > > > > to the *MFD driver* instead.  This explains my confusion in v10 when I
> > > > > > told you I'd already reviewed the binding document.
> > > > > >
> > > > > > As I said, I have re-reviewed the MFD driver and I'm afraid to say
> > > > > > that I do not like what I see.  Besides the missing header file and
> > > > > > the whitespace tabbing errors, I do not agree with the implementation.
> > > > > > Using MFD as a shim to hack around driver selection is not a valid
> > > > > > use-case.
> > > > > >
> > > > > > What's stopping you from just using the compatible string directly to
> > > > > > select which driver you need to probe?
> > > > > >
> > > > >
> > > > > Then you'd have multiple compatible strings for the same IP which is a
> > > > > big no-no.
> > > >
> > > > It's still the same hardware device, isn't?
> > > > What if the SPI or UART slave is not on-board, but on an expansion board?
> > > > Then the SoC-specific .dtsi has no idea what mode should be used.
> > > >
> > > > Hence shouldn't the software derive the hardware mode from the full
> > > > hardware description in DT? If that's impossible (I didn't look into detail
> > > > whether an SPI bus can easily be distinguished from a UART bus), perhaps
> > > > a mode property should be added?
> > >
> > > Yes, this is exactly what is done:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33
> >
> > OK.
> >
> > I guess the main "hackish" part is that the mfd_cell uses of_compatible,
> > which thus requires having additional compatible values?
> >
> > I think those can just be removed. AFAICS, the SPI and serial drivers already
> > match against the "at91_usart_spi" resp. "atmel_usart_serial" platform device
> > names?
>
> The hackish part of this driver is that it's using MFD for something
> which is clearly not an MFD.  It's a USART device.  Nothing more,
> nothing less.
>
> Does anyone have the datasheet to hand?

I haven't read it, but I believe it's not unlike Renesas SCIF, which is
served by both drivers/tty/serial/sh-sci.c and drivers/spi/spi-sh-sci.c.
But the latter is not used from DT, so we haven't experienced (and solved)
the similar issue yet.

Would it work if the UART driver and SPI driver would match against the
same compatible value, but the UART driver would do in its probe()
function:

    device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
    if (opmode != AT91_USART_MODE_SERIAL)
        return ENODEV;

while the SPI driver would do:

    device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
    if (opmode != AT91_USART_MODE_SPI)
        return ENODEV;

? No MFD driver involved.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
