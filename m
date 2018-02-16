Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeBPSlu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:41:50 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:59739 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBPSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:41:48 -0500
Date: Fri, 16 Feb 2018 19:41:46 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/6] ARM: davinci: update the nand driver names
Message-ID: <20180216194146.4131dc12@bbrezillon>
In-Reply-To: <20180216193307.3c4372d8@bbrezillon>
References: <20180216164712.25898-1-brgl@bgdev.pl>
        <20180216164712.25898-3-brgl@bgdev.pl>
        <20180216193307.3c4372d8@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 19:33:07 +0100
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Fri, 16 Feb 2018 17:47:08 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Since commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
> > lookup table") we can no longer correctly lookup the nand clock when
> > booting in legacy mode. Said commit added a dev_id to the nand clock
> > which must match and it doesn't correspond with the device name which
> > is "davinci_nand" instead of "davinci-nand".
> > 
> > The driver name has been changed. Update the board files.  
> 
> Should be squashed in patch 1, otherwise your patch series is not
> bisectable.
> 

Okay, after reading the commit message a second time it seems
bisectability is already broken anyway :-). 

> > 
> > Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
> >  arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
> >  arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
> >  arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
> >  arch/arm/mach-davinci/board-dm365-evm.c     | 2 +-
> >  arch/arm/mach-davinci/board-dm644x-evm.c    | 2 +-
> >  arch/arm/mach-davinci/board-dm646x-evm.c    | 2 +-
> >  arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
> >  arch/arm/mach-davinci/board-neuros-osd2.c   | 2 +-
> >  arch/arm/mach-davinci/board-sffsdr.c        | 2 +-
> >  10 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> > index f673cd7a6766..f8838c7b174b 100644
> > --- a/arch/arm/mach-davinci/board-da830-evm.c
> > +++ b/arch/arm/mach-davinci/board-da830-evm.c
> > @@ -348,7 +348,7 @@ static struct resource da830_evm_nand_resources[] = {
> >  };
> >  
> >  static struct platform_device da830_evm_nand_device = {
> > -	.name		= "davinci_nand",
> > +	.name		= "davinci-nand",
> >  	.id		= 1,
> >  	.dev		= {
> >  		.platform_data	= &da830_evm_nand_pdata,
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> > index d898a94f6eae..828194045a2b 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> > @@ -266,7 +266,7 @@ static struct resource da850_evm_nandflash_resource[] = {
> >  };
> >  
> >  static struct platform_device da850_evm_nandflash_device = {
> > -	.name		= "davinci_nand",
> > +	.name		= "davinci-nand",
> >  	.id		= 1,
> >  	.dev		= {
> >  		.platform_data	= &da850_evm_nandflash_data,
> > diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> > index e457f299cd44..58ca7f56e112 100644
> > --- a/arch/arm/mach-davinci/board-dm355-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> > @@ -98,7 +98,7 @@ static struct resource davinci_nand_resources[] = {
> >  };
> >  
> >  static struct platform_device davinci_nand_device = {
> > -	.name			= "davinci_nand",
> > +	.name			= "davinci-nand",
> >  	.id			= 0,
> >  
> >  	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
> > diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
> > index be997243447b..196238117f9a 100644
> > --- a/arch/arm/mach-davinci/board-dm355-leopard.c
> > +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
> > @@ -93,7 +93,7 @@ static struct resource davinci_nand_resources[] = {
> >  };
> >  
> >  static struct platform_device davinci_nand_device = {
> > -	.name			= "davinci_nand",
> > +	.name			= "davinci-nand",
> >  	.id			= 0,
> >  
> >  	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
> > diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> > index e75741fb2c1d..563d66df480b 100644
> > --- a/arch/arm/mach-davinci/board-dm365-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> > @@ -159,7 +159,7 @@ static struct resource davinci_nand_resources[] = {
> >  };
> >  
> >  static struct platform_device davinci_nand_device = {
> > -	.name			= "davinci_nand",
> > +	.name			= "davinci-nand",
> >  	.id			= 0,
> >  	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
> >  	.resource		= davinci_nand_resources,
> > diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> > index 85e6fb33b1ee..e42ae2163c75 100644
> > --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > @@ -173,7 +173,7 @@ static struct resource davinci_evm_nandflash_resource[] = {
> >  };
> >  
> >  static struct platform_device davinci_evm_nandflash_device = {
> > -	.name		= "davinci_nand",
> > +	.name		= "davinci-nand",
> >  	.id		= 0,
> >  	.dev		= {
> >  		.platform_data	= &davinci_evm_nandflash_data,
> > diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> > index cb0a41e83582..614dd211e6fc 100644
> > --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> > +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> > @@ -108,7 +108,7 @@ static struct resource davinci_nand_resources[] = {
> >  };
> >  
> >  static struct platform_device davinci_nand_device = {
> > -	.name			= "davinci_nand",
> > +	.name			= "davinci-nand",
> >  	.id			= 0,
> >  
> >  	.num_resources		= ARRAY_SIZE(davinci_nand_resources),
> > diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> > index b73ce7bae81f..bf3659a21897 100644
> > --- a/arch/arm/mach-davinci/board-mityomapl138.c
> > +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> > @@ -422,7 +422,7 @@ static struct resource mityomapl138_nandflash_resource[] = {
> >  };
> >  
> >  static struct platform_device mityomapl138_nandflash_device = {
> > -	.name		= "davinci_nand",
> > +	.name		= "davinci-nand",
> >  	.id		= 1,
> >  	.dev		= {
> >  		.platform_data	= &mityomapl138_nandflash_data,
> > diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
> > index 4da210a1a110..04132494a7c9 100644
> > --- a/arch/arm/mach-davinci/board-neuros-osd2.c
> > +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
> > @@ -107,7 +107,7 @@ static struct resource davinci_ntosd2_nandflash_resource[] = {
> >  };
> >  
> >  static struct platform_device davinci_ntosd2_nandflash_device = {
> > -	.name		= "davinci_nand",
> > +	.name		= "davinci-nand",
> >  	.id		= 0,
> >  	.dev		= {
> >  		.platform_data	= &davinci_ntosd2_nandflash_data,
> > diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> > index d85accf7f760..c8569c8aa6e3 100644
> > --- a/arch/arm/mach-davinci/board-sffsdr.c
> > +++ b/arch/arm/mach-davinci/board-sffsdr.c
> > @@ -83,7 +83,7 @@ static struct resource davinci_sffsdr_nandflash_resource[] = {
> >  };
> >  
> >  static struct platform_device davinci_sffsdr_nandflash_device = {
> > -	.name		= "davinci_nand", /* Name of driver */
> > +	.name		= "davinci-nand", /* Name of driver */
> >  	.id		= 0,
> >  	.dev		= {
> >  		.platform_data	= &davinci_sffsdr_nandflash_data,  
> 
> 
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
