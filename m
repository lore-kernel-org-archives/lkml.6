Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD86FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1623EEA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A1623EEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeFVIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:24:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeFVIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:24:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A4E7820799; Fri, 22 Jun 2018 10:24:41 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id F2A58206FF;
        Fri, 22 Jun 2018 10:24:40 +0200 (CEST)
Date:   Fri, 22 Jun 2018 10:24:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Message-ID: <20180622102441.35856a50@bbrezillon>
In-Reply-To: <CACRpkdY_7mi8GPiopZ9Yg4Y0-AV_SriZe=1yN5is6eH6FUm6Qg@mail.gmail.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-10-boris.brezillon@bootlin.com>
        <CACRpkdY_7mi8GPiopZ9Yg4Y0-AV_SriZe=1yN5is6eH6FUm6Qg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I realize I never replied to this review.

On Thu, 26 Apr 2018 10:44:26 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Mar 30, 2018 at 9:47 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > Add a driver for Cadence I3C GPIO expander.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> 
> This is pretty much OK, and I don't want to raise the bar
> even higher for you to get this code into the kernel, so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

> 
> The following is an observation for future improvement:
> 
> > +static int cdns_i3c_gpio_read_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> > +                                 u8 *val)
> > +{
> > +       struct i3c_priv_xfer xfers[] = {
> > +               {
> > +                       .len = sizeof(reg),
> > +                       .data.out = &reg,
> > +               },
> > +               {
> > +                       .rnw = true,
> > +                       .len = sizeof(*val),
> > +                       .data.in = val,
> > +               },
> > +       };
> > +
> > +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> > +                                       ARRAY_SIZE(xfers));
> > +}
> > +
> > +static int cdns_i3c_gpio_write_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
> > +                                  u8 val)
> > +{
> > +       struct i3c_priv_xfer xfers[] = {
> > +               {
> > +                       .len = sizeof(reg),
> > +                       .data.out = &reg,
> > +               },
> > +               {
> > +                       .len = sizeof(val),
> > +                       .data.out = &val,
> > +               },
> > +       };
> > +
> > +       return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> > +                                       ARRAY_SIZE(xfers));
> > +}  
> 
> This is starting to resemble
> drivers/base/regmap/regmap-i2c.c
> 
> Maybe we should very quickly add regmap-i3c.c as this
> infrastructre has had a great positive effect on may kernel
> subsystems.

Yes I considered that too, I was just waiting for at least one
other user before adding this regmap-i3c implementation.

> 
> > +static int cdns_i3c_gpio_get_direction(struct gpio_chip *g, unsigned offset)
> > +{
> > +       struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
> > +
> > +       return gpioc->dir & BIT(offset);  
> 
> I would:
> 
> return !!(gpioc->dir & BIT(offset));
> 
> So you clamp it to bit 0.

Will fix that in my v5.

Thanks for your review.

Boris
