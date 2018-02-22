Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeBVSwW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:52:22 -0500
Received: from muru.com ([72.249.23.125]:57876 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750816AbeBVSwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:52:21 -0500
Date: Thu, 22 Feb 2018 10:45:42 -0800
From: Tony Lindgren <tony@atomide.com>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org,
        thierry.reding@gmail.com, aaro.koskinen@iki.fi,
        Claudiu.Beznea@microchip.com, narmstrong@baylibre.com,
        linux-pwm@vger.kernel.org, s-anna@ti.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org,
        robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
Subject: Re: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
Message-ID: <20180222184541.GB5184@atomide.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
 <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
 <20180222105713.GA30885@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222105713.GA30885@lenoch>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [180222 10:58]:
> On Thu, Feb 15, 2018 at 11:31:45AM +0530, Keerthy wrote:
> > Replace architecture specific guard with clocksource guard.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Replace architecture specific defines with clocksource
> 
> This looks like a bit unussual commit log. Also, what about merging
> it with previous patch?

I'll just remove that line locally to avoid yet another set
of patches being posted :)

> Btw, I tested whole serie again on the top of today's -next and it is
> still working fine. What is preventing these patches from being merged?

Well I noticed we need a fix for omap1 that I just posted.
And patch 4/10 needs the following select for omap16xx that
I'll fold in.

I'll push it all to omap-for-v4.17/timer and will merge into
my for-next after some more testing. It seems any further
patching can be done after move to drivers.

Regards,

Tony

8< -----------------
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -30,6 +30,7 @@ config ARCH_OMAP16XX
 	bool "OMAP16xx Based System"
 	select ARCH_OMAP_OTG
 	select CPU_ARM926T
+	select OMAP_DM_TIMER
 
 config OMAP_MUX
 	bool "OMAP multiplexing support"
