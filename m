Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeELLOI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 07:14:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47205 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeELLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 07:14:06 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
Date: Sat, 12 May 2018 13:13:36 +0200
Message-ID: <1937901.oyadCYFYNo@aspire.rjw.lan>
In-Reply-To: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de> <20180305102524.5905-4-o.rempel@pengutronix.de> <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 4, 2018 8:50:52 PM CEST Oleksij Rempel wrote:
> Hallo Andrew,
> I need your ACK or NACK for this patch.
> 
> This function is used to configure external PMIC to interpret
> signal which will be triggered by pm_power_off as power off.
> Since same signal can be used for stand by, I linked PMIC configuration
> with pm_power_off_prepare to avoid possible conflicts.
> 
> On Mon, Mar 05, 2018 at 11:25:20AM +0100, Oleksij Rempel wrote:
> > Export pm_power_off_prepare. It is needed to implement power off on
> > Freescale/NXP iMX6 based boards with external power management
> > integrated circuit (PMIC).
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  kernel/reboot.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index e4ced883d8de..350be6baa60d 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -49,6 +49,7 @@ int reboot_force;
> >   */
> >  
> >  void (*pm_power_off_prepare)(void);
> > +EXPORT_SYMBOL(pm_power_off_prepare);

Why not EXPORT_SYMBOL_GPL() ?

> >  
> >  /**
> >   *	emergency_restart - reboot the system
> 
> 
