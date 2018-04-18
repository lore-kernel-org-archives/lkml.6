Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeDRFrb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:47:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51615 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeDRFr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:47:29 -0400
Date: Wed, 18 Apr 2018 07:46:43 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/11] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180418074643.5bd68168@dell-desktop.home>
In-Reply-To: <20180417112038.mw7bfhqw4xwvzxcw@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
        <20180416215032.5023-10-mylene.josserand@bootlin.com>
        <20180417112038.mw7bfhqw4xwvzxcw@flea>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On Tue, 17 Apr 2018 13:20:38 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Apr 16, 2018 at 11:50:30PM +0200, Mylène Josserand wrote:
> > @@ -535,8 +599,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
> >  	return !ret;
> >  }
> >  
> > -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> > +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
> >  {
> > +	/* CPU0 hotplug not handled for sun8i-a83t */
> > +	if (is_sun8i)
> > +		if (cpu == 0)
> > +			return false;
> >  	return true;  
> 
> I think Chen-Yu told you how to implement the hotplug in the previous
> iteration, did you have time to test it?

Not yet, I will have a look this evening.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
