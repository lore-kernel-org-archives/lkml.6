Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeDRFwF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:52:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51783 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeDRFwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:52:04 -0400
Date: Wed, 18 Apr 2018 07:51:51 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] ARM: sun9i: smp: Rename clusters's power-off
Message-ID: <20180418075151.3542f7cd@dell-desktop.home>
In-Reply-To: <fd19ec26-9240-5ae2-fc6e-d3918ab91d01@cogentembedded.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
        <20180416215032.5023-8-mylene.josserand@bootlin.com>
        <fd19ec26-9240-5ae2-fc6e-d3918ab91d01@cogentembedded.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 17 Apr 2018 11:21:02 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> Hello!
> 
> On 4/17/2018 12:50 AM, Mylène Josserand wrote:
> 
> > To prepare the support for sun8i-a83t, rename the variable name  
> 
>     s/variable/macro/ maybe? Also "rename the ... name" sounds tautological...

Thank you for the correction.

Best regards,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

> 
> > that handles the power-off of clusters because it is different from
> > sun9i-a80 to sun8i-a83t.
> > 
> > The power off register for clusters are different from a80 and a83t.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >   arch/arm/mach-sunxi/mc_smp.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index 727968d6a3e5..03f021d0c73e 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -60,7 +60,7 @@
> >   #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
> >   #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
> >   #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
> > -#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
> > +#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
> >   #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
> >   #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
> >   #define PRCM_CPU_SOFT_ENTRY_REG		0x164
> > @@ -255,7 +255,7 @@ static int sunxi_cluster_powerup(unsigned int cluster)
> >   
> >   	/* clear cluster power gate */
> >   	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> > -	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
> > +	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> >   	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >   	udelay(20);
> >   
> > @@ -452,7 +452,7 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
> >   	/* gate cluster power */
> >   	pr_debug("%s: gate cluster power\n", __func__);
> >   	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> > -	reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
> > +	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
> >   	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
> >   	udelay(20);
> >     
> 
> MBR, Sergei
