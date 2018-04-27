Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeD0I0r convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:26:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932323AbeD0I0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:26:45 -0400
Date: Fri, 27 Apr 2018 10:26:14 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] ARM: sun9i: smp: Add is_a83t field
Message-ID: <20180427102614.1558a1ae@dell-desktop.home>
In-Reply-To: <20180423081423.h7b35sobagypokpe@flea>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
        <20180420211022.11759-9-mylene.josserand@bootlin.com>
        <20180423081423.h7b35sobagypokpe@flea>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 23 Apr 2018 10:14:23 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Fri, Apr 20, 2018 at 11:10:19PM +0200, Mylène Josserand wrote:
> > To prepare the support of sun8i-a83t, add a field in the smp_data
> > structure to know if we are on sun9i-a80 or sun8i-a83t.
> > 
> > Add also a global variable to retrieve which architecture we are
> > having.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/mc_smp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index 03f021d0c73e..48e5f4db64b6 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -74,6 +74,7 @@ static void __iomem *sram_b_smp_base;
> >  
> >  extern void sunxi_mc_smp_secondary_startup(void);
> >  extern void sunxi_mc_smp_resume(void);
> > +static int is_a83t;
> >  
> >  static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
> >  {
> > @@ -624,6 +625,7 @@ struct sunxi_mc_smp_nodes {
> >  struct sunxi_mc_smp_data {
> >  	const char *enable_method;
> >  	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
> > +	int is_a83t;  
> 
> This can be made a boolean.
> 
> Maxime
> 

ACK. It will be fixed in next version.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
