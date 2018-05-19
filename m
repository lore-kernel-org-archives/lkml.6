Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeESHMC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 03:12:02 -0400
Received: from mailout6.siol.net ([213.250.19.133]:59350 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750832AbeESHL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 03:11:57 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY clock parents
Date: Sat, 19 May 2018 09:11:15 +0200
Message-ID: <1589389.XrQdaPTFv2@jernej-laptop>
In-Reply-To: <20180518152651.lfymc3kj7npj5tww@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com> <4909574.Q3IFWM0xt6@jernej-laptop> <20180518152651.lfymc3kj7npj5tww@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 18. maj 2018 ob 17:26:51 CEST je Maxime Ripard napisal(a):
> On Fri, May 18, 2018 at 04:46:41PM +0200, Jernej Škrabec wrote:
> > > And this is a bit sloppy, since if phy_clk_num == 3, you won't try to
> > > lookup pll-2 either.
> > 
> > It is highly unlikely this will be higher than 2, at least for this HDMI
> > PHY, since it has only 1 bit reserved for parent selection. But since I
> > have to fix it, I'll add ">= 2"
> 
> If we're only going to have two parents at most, ever, why don't we
> had just a single other boolean. This would be less intrusive, and we
> wouldn't have to check for those corner cases.

It seems that usage of "bool" data type in structures is not wanted anymore 
according to checkpatch and this: https://lkml.org/lkml/2017/11/21/384

I guess I'll use "unsigned int" as recommended by Linus and named it 
"has_second_parent" to be unambigous that it's boolean in reality.

Best regards,
Jernej

> 
> > BTW, I'll resend fixed version of this patch for my R40 HDMI series, since
> > there is nothing to hold it back, unlike for this.
> 
> Awesome, thanks!
> Maxime
> 
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
