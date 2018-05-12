Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeELNmd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 09:42:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36105 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeELNmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 09:42:31 -0400
Date: Sat, 12 May 2018 15:42:23 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@bolin.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] mtd: nand: Add support for reading ooblayout from
 device tree
Message-ID: <20180512154223.3b81c7f7@bbrezillon>
In-Reply-To: <20180512115551.56C6E20787@mail.bootlin.com>
References: <20180512115551.56C6E20787@mail.bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 08:55:40 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Boris,
> 
> Le 12 mai 2018 02:55, Boris Brezillon <boris.brezillon@bootlin.com> a écrit :
> >
> > Hi Paul, 
> >
> > On Fri, 11 May 2018 23:29:12 +0200 
> > Paul Cercueil <paul@crapouillou.net> wrote: 
> >  
> > > By specifying the properties "mtd-oob-ecc" and "mtd-oob-free", it is 
> > > now possible to specify from devicetree where the ECC data is located 
> > > inside the OOB region.   
> >
> > Why would we want to do that? I mean, ECC/free regions are ECC 
> > controller dependent (and NAND chip dependent for the OOB size part), 
> > so there's no reason to describe it in the DT. And more importantly, 
> > people are likely to get it wrong. 
> >
> > I'm curious, why do you need that?   
> 
> Good question.
> 
> The reason is that some SoCs have no ECC controller.
> The various boards for these SoCs then all use a different layout.

Okay. Still think defining the layouts in the DT is a bad idea. We
can add a jz4740 specific property to define the layout id
(ingenic,nand-oob-layout = <layout-id>), but not a generic way to
define custom layouts for all kind of NAND controller.

> 
> My motivation is to get rid of this (move it to devicetree):
> https://elixir.bootlin.com/linux/latest/source/arch/mips/jz4740/board-qi_lb60.c#L93
> And enable the support of other boards with custom OOB layouts.

Can you list the different layouts you have? I'm pretty sure there's a
pattern. Maybe we can even deduce the layout from the page size or OOB
size.
