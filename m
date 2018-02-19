Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBSKup convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:50:45 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58943 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBSKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:50:44 -0500
Date: Mon, 19 Feb 2018 11:50:31 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 7/7] ARM: sun8i: smp: Remove the disabling of CPU0
Message-ID: <20180219115031.77a0a1ca@dell-desktop.home>
In-Reply-To: <20180219085408.5to43p7jbtijx4q3@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-8-mylene.josserand@bootlin.com>
        <20180219085408.5to43p7jbtijx4q3@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Feb 2018 09:54:08 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Feb 19, 2018 at 09:18:37AM +0100, Mylène Josserand wrote:
> > On sun8i-a63t, hotplug CPU for CPU0 is currently not working.
> > Remove the possibility to disable CPU0 only for sun8i-a83t.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/mc_smp.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> > index fec592bf68b4..69d5ae5b3d72 100644
> > --- a/arch/arm/mach-sunxi/mc_smp.c
> > +++ b/arch/arm/mach-sunxi/mc_smp.c
> > @@ -661,8 +661,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
> >  	return !ret;
> >  }
> >  
> > -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> > +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
> >  {
> > +	/* CPU0 hotplug handled only for sun9i */
> > +	if (of_machine_is_compatible("allwinner,sun8i-a83t"))
> > +		if (cpu == 0)
> > +			return false;  
> 
> This also means that you have a window in your patch sequence where
> you can disable the CPU0 on the A83t. This patch should be earlier.

It is true.
With your comment in my first patch, it will be done earlier.

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
