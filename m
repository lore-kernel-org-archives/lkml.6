Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEDUuA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:50:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeEDUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:49:58 -0400
Date: Fri, 4 May 2018 13:49:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
Message-Id: <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
In-Reply-To: <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
        <20180305102524.5905-4-o.rempel@pengutronix.de>
        <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018 20:50:52 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hallo Andrew,
> I need your ACK or NACK for this patch.
> 
> This function is used to configure external PMIC to interpret
> signal which will be triggered by pm_power_off as power off.
> Since same signal can be used for stand by, I linked PMIC configuration
> with pm_power_off_prepare to avoid possible conflicts.
> 
> ...
>
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -49,6 +49,7 @@ int reboot_force;
> >   */
> >  
> >  void (*pm_power_off_prepare)(void);
> > +EXPORT_SYMBOL(pm_power_off_prepare);
> >  

OK by me, but it's more of a Rafael thing.
