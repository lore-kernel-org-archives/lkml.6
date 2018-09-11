Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD26C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7921E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeIKUgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:36:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51443 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbeIKUgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:36:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6265E20789; Tue, 11 Sep 2018 17:36:32 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33238206FF;
        Tue, 11 Sep 2018 17:36:22 +0200 (CEST)
Date:   Tue, 11 Sep 2018 17:36:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180911153621.GP2494@piout.net>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell>
 <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2018 16:59:09+0200, Geert Uytterhoeven wrote:
> Hi Alexandre,
> 
> On Tue, Sep 11, 2018 at 11:40 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 11/09/2018 10:33:56+0100, Lee Jones wrote:
> > > On Tue, 04 Sep 2018, Radu Pirea wrote:
> > > > Radu Pirea (6):
> > > >   MAINTAINERS: add at91 usart mfd driver
> > > >   dt-bindings: add binding for atmel-usart in SPI mode
> > > >   mfd: at91-usart: added mfd driver for usart
> > > >   MAINTAINERS: add at91 usart spi driver
> > > >   spi: at91-usart: add driver for at91-usart as spi
> > > >   tty/serial: atmel: change the driver to work under at91-usart mfd
> > > >
> > > >  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
> > > >  MAINTAINERS                                   |  16 +
> > > >  drivers/mfd/Kconfig                           |   9 +
> > > >  drivers/mfd/Makefile                          |   1 +
> > > >  drivers/mfd/at91-usart.c                      |  71 +++
> > > >  drivers/spi/Kconfig                           |   8 +
> > > >  drivers/spi/Makefile                          |   1 +
> > > >  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
> > > >  drivers/tty/serial/Kconfig                    |   1 +
> > > >  drivers/tty/serial/atmel_serial.c             |  42 +-
> > > >  include/dt-bindings/mfd/at91-usart.h          |  17 +
> > > >  11 files changed, 606 insertions(+), 17 deletions(-)
> > > >  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
> > > >  create mode 100644 drivers/mfd/at91-usart.c
> > > >  create mode 100644 drivers/spi/spi-at91-usart.c
> > > >  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> > >
> > > Seeing as this patch-set has caused some issues this morning, I took
> > > the liberty to peruse back into its history to figure out where things
> > > started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
> > > I did!
> > >
> > > My Acked-by has been attached to the MFD portion since v5, which is
> > > why the code hasn't caught my eye before today.  I reviewed the
> > > relocation of the *binding document* (serial => mfd with no changes)
> > > in v4 and nothing else.  It appears as though you mistakenly added it
> > > to the *MFD driver* instead.  This explains my confusion in v10 when I
> > > told you I'd already reviewed the binding document.
> > >
> > > As I said, I have re-reviewed the MFD driver and I'm afraid to say
> > > that I do not like what I see.  Besides the missing header file and
> > > the whitespace tabbing errors, I do not agree with the implementation.
> > > Using MFD as a shim to hack around driver selection is not a valid
> > > use-case.
> > >
> > > What's stopping you from just using the compatible string directly to
> > > select which driver you need to probe?
> > >
> >
> > Then you'd have multiple compatible strings for the same IP which is a
> > big no-no.
> 
> It's still the same hardware device, isn't?
> What if the SPI or UART slave is not on-board, but on an expansion board?
> Then the SoC-specific .dtsi has no idea what mode should be used.
> 
> Hence shouldn't the software derive the hardware mode from the full
> hardware description in DT? If that's impossible (I didn't look into detail
> whether an SPI bus can easily be distinguished from a UART bus), perhaps
> a mode property should be added?
> 

Yes, this is exactly what is done:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/tree/drivers/mfd/at91-usart.c?h=ib-mfd-spi-tty-4.20-1#n33

Only one compatbile for the IP and a property to know what is the mode.
That property should indeed be set in the board dts and not the SoC
dtsi.

the other, less robust alternative was to look for child nodes and
decide that if some where present it would indicate an SPI bus. But I
think at some point we may have child nodes under a UART node.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
