Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51863259E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51863259E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965969AbeF0Tgg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:36:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51216 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965379AbeF0Tge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:36:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8054203EC; Wed, 27 Jun 2018 21:36:31 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id E0C5D203EC;
        Wed, 27 Jun 2018 21:36:20 +0200 (CEST)
Date:   Wed, 27 Jun 2018 21:36:17 +0200
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
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO
 expander
Message-ID: <20180627213617.51e10712@bbrezillon>
In-Reply-To: <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
        <20180622104930.32050-10-boris.brezillon@bootlin.com>
        <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
        <20180626215648.1472b96e@bbrezillon>
        <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
        <20180626234638.076fb816@bbrezillon>
        <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, 27 Jun 2018 20:53:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 27, 2018 at 12:46 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue, 26 Jun 2018 23:44:36 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> >> On Tue, Jun 26, 2018 at 10:56 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:  
> >> > On Tue, 26 Jun 2018 22:07:03 +0300
> >> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> >> >> On Fri, Jun 22, 2018 at 1:49 PM, Boris Brezillon
> >> >> <boris.brezillon@bootlin.com> wrote:  
> 
> >> > I'll say it here because this is not the first time I'm pissed off by
> >> > one of your review.  
> >>
> >> Like 'I like offending people, because I think people who get offended
> >> should be offended.' ?
> >> I'm not that guy, relax.  
> >
> > I'm not offended, just annoyed, and not because I have things to change
> > in my patchset (I'm used to that and that's something I comply with
> > most of the time), but because the only reviews I had from you were of
> > this kind (nitpicking on minor stuff).  
> 
> OK, point taken.
> 
> >> > and most of the time your reviews are superficial (focused on tiny
> >> > details or coding style issues). Don't you have better things to do?  
> >>
> >> If your code is written using ancient style and / or API it's not good
> >> to start with.
> >> Isn't it? Otherwise, why we do introduce new internal APIs, for what purpose?  
> >
> > Come on!
> >
> > - kzalloc() vs kmalloc_array()
> > - for (i = 0; i < n, i++) { if (BIT(x) & var) ... }
> >   vs
> >   for_each_bit_set() (which is not even applicable here because I'm
> >   not manipulating an unsigned long)
> >
> > Where do you see ancient style APIs here?  
> 
> Both. kmalloc_array() and for_each_set_bit() were introduced quite
> long time ago.

I mean, kzalloc() is not deprecated AFAIK and I don't really see the
benefit of using kmalloc_array(), but if that makes you happy, let's go
for kmalloc_array().

For for_each_bit_set() it would require changing the type of isr +
having a temporary variable to get the reg value into an u8. Again, I
can do the change, but I don't really see how it improves the code. 

> 
> On top of that you are open coding, if I'm not mistaken, cpu_to_be32()
> and be32_to_cpu().

Care to point where?

> ...and more I believe.

Care to point what?
 
> >> On top of that you might find more interesting reviews where I pointed
> >> out to a memory leak or other nasty stuff. But of course you prefer
> >> not to norice that.  
> >
> > Yes, sometime you have valid point, but it gets lost in all the noise.  
> 
> Btw, you forgot to call of_node_put() on error path in one case.

In this driver or another patch of the series? I don't see any
of_node_get() call in this GPIO driver, but maybe it's something done
in one of the GPIO helper.

> Did I
> again missed the details?
> 
> >> > I mean, I'm fine when I get such comments from people that also do
> >> > useful comments, but yours are most of the time useless and sometime
> >> > even wrong because you didn't time to look at the code in details.  
> >>
> >> Calm down, please.  
> >
> > Why? Because I say you didn't look at the code in details? Isn't it
> > true? Did you look at what I3C is, how it works or how the I3C framework
> > is architectured? Because that's the kind of reviews I'd love to have on
> > this series.  
> 
> You got me.
> I have a copy of the spec, this require a bit of time to go through.

Cool!

> 
> For now I can offer you to consider IBI implementation using IRQ chip framework.
> It would give few advantages (like we do this for GPIO), such as IRQ
> statistics or wake up capabilities.

Just pasting the comment I made in my cover letter:

"
Main changes between the initial RFC and this v2 are:
- Add a generic infrastructure to support IBIs. It's worth mentioning
  that I tried exposing IBIs as a regular IRQs, but after several
  attempts and a discussion with Mark Zyngier, it appeared that it was
  not really fitting in the Linux IRQ model (the fact that you have
  payload attached to IBIs, the fact that most of the time an IBI will
  generate a transfer on the bus which has to be done in an atomic
  context, ...)
  The counterpart of this decision is the latency induced by the
  workqueue approach, but since I don't have real use cases, I don't
  know if this can be a problem or not. 
"

To sum-up, yes I tried implementing what you suggest, and it ended
being messy for 2 main reasons:

1/ IBIs have payload attached to them, and exposing IBIs are regular
IRQs meant adding a payload queuing mechanism to the i3c_device so that
the I3C device driver could dequeue each payload independently. Clearly
not impossible to deal with, but conceptually far from the concept of
IRQs we have in Linux.

2/ The I3C APIs are meant to be used in non-atomic context, but if you
expose IBIs are regular IRQs, the irqchip will have to mask/unmask the
IRQs from an atomic context, and masking/unmasking IRQs almost always
implies doing a CCC or priv SDR transfer. Plus, most of the time you'll
have to retrieve extra info from the IRQ handler, which again means
sending frames on the I3C bus. We could make that work by either
supporting async transfers or having the irq chip handle the IRQ
handlers from a thread. But both options add extra complexity for no
real benefit given that IBIs are already not exactly fitting in the
Linux IRQ model.

The discussion I had with Mark Zyngier finished convincing me that
IBIs would be better exposed with their own API.

> 
> >> You would simple ignore them. Your choice.  
> >
> > That's not my point. My point is, maybe you should do less reviews but
> > spend more time on each of them  
> 
> Good point.
> 
> > so you don't just scratch the surface
> > with comments I could get from a tool like checkpatch.  
> 
> Perhaps you should run checkpatch yourself then?
> 

I do run checkpatch --strict and fix most of the thing reported except
those hurting readability. I don't remember seeing checkpatch complain
about kzalloc() usage, and I guess it's not smart enough to detect that
for_each_bit_set() can be used to replace the "for() if (BIT(x) & val)"
pattern.

Anyway, thanks for having a look at the I3C spec and starting the
discussion on IBIs. I guess I owe you an apology.

Regards,

Boris
