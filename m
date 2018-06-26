Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5CA2240D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5CA2240D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFZVq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:46:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50363 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbeFZVqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:46:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 49A1120875; Tue, 26 Jun 2018 23:46:52 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7D4EF2079D;
        Tue, 26 Jun 2018 23:46:41 +0200 (CEST)
Date:   Tue, 26 Jun 2018 23:46:38 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Message-ID: <20180626234638.076fb816@bbrezillon>
In-Reply-To: <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-10-boris.brezillon@bootlin.com>
        <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
        <20180626215648.1472b96e@bbrezillon>
        <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 23:44:36 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue, 26 Jun 2018 22:07:03 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> >> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:  
> >> > Add a driver for Cadence I3C GPIO expander.
> >> >
> >> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>  
> >>  
> >> > +       scratchbuf = kmalloc(sizeof(*scratchbuf) * 2, GFP_KERNEL);  
> >>
> >> kmalloc_array() ?
> >>  
> >> > +       ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
> >> > +                                      ARRAY_SIZE(xfers));  
> >>
> >> One line?
> >>  
> 
> >> You don't change mask here, why do you need a pointer to it?  
> >
> > What are you talking about??!!! This is part of the gpio_chip interface
> > that drivers have to implement. You can't decide that mask should not be
> > a pointer. And if you actually look at the code, you'll probably see
> > that the reason we're passed a pointer here is that the GPIO chip might
> > expose more GPIOs than can be represented by an unsigned long, hence
> > the array of unsigned long.
> >  
> 
> > I'll say it here because this is not the first time I'm pissed off by
> > one of your review.  
> 
> Like 'I like offending people, because I think people who get offended
> should be offended.' ?
> I'm not that guy, relax.

I'm not offended, just annoyed, and not because I have things to change
in my patchset (I'm used to that and that's something I comply with
most of the time), but because the only reviews I had from you were of
this kind (nitpicking on minor stuff).

> 
> >  You seem to review everything that is posted on the LKML,  
> 
> That's not true.
> 
> > and most of the time your reviews are superficial (focused on tiny
> > details or coding style issues). Don't you have better things to do?  
> 
> If your code is written using ancient style and / or API it's not good
> to start with.
> Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?

Come on!

- kzalloc() vs kmalloc_array()
- for (i = 0; i < n, i++) { if (BIT(x) & var) ... }
  vs
  for_each_bit_set() (which is not even applicable here because I'm
  not manipulating an unsigned long)

Where do you see ancient style APIs here?

And that's not even the problem. I'm okay to fix those things, but you
only ever do these kind of reviews, and sometime you even act like you
know better than the developer or the maintainer how the code should be
organized without even digging enough to have a clue (your comment on
the fact that mask should not be a pointer is a good example of such
situations).

> 
> On top of that you might find more interesting reviews where I pointed
> out to a memory leak or other nasty stuff. But of course you prefer
> not to norice that.

Yes, sometime you have valid point, but it gets lost in all the noise.

> I understand you.
> 
> > I mean, I'm fine when I get such comments from people that also do
> > useful comments, but yours are most of the time useless and sometime
> > even wrong because you didn't time to look at the code in details.  
> 
> Calm down, please.

Why? Because I say you didn't look at the code in details? Isn't it
true? Did you look at what I3C is, how it works or how the I3C framework
is architectured? Because that's the kind of reviews I'd love to have on
this series.

> You would simple ignore them. Your choice.

That's not my point. My point is, maybe you should do less reviews but
spend more time on each of them so you don't just scratch the surface
with comments I could get from a tool like checkpatch.
