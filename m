Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBZQUE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:20:04 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:39025 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751835AbeBZQUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:20:02 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 08/15] drm/sun4i: Fix polarity configuration for DW HDMI PHY
Date: Mon, 26 Feb 2018 17:19:58 +0100
Message-ID: <2043407.cqGGRsJjYq@jernej-laptop>
In-Reply-To: <20180226093930.mipjyr6sr35ldkw6@flea.lan>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-9-jernej.skrabec@siol.net> <20180226093930.mipjyr6sr35ldkw6@flea.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne ponedeljek, 26. februar 2018 ob 10:39:30 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Sat, Feb 24, 2018 at 10:45:38PM +0100, Jernej Skrabec wrote:
> > Current polarity configuration code is cleary wrong since it compares
> > same flag two times. However, even if flag name is fixed, it won't work
> > well for resolutions which have one polarity positive and another
> > negative.
> > 
> > Fix that by properly set each bit according to each polarity. Since
> > those two bits are not described in any documentation, relationships
> > were obtained by experimentation.
> > 
> > Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index e5bfcdd43ec9..f48e8b70fabe
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -35,10 +35,11 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi,
> > void *data,> 
> >  	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
> >  	u32 val = 0;
> > 
> > -	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
> > -	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
> > -		val = 0x03;
> > -	}
> > +	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > +		val |= 0x01;
> > +
> > +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> > +		val |= 0x02;
> 
> Can you introduce defines for those?

Of course.

Best regards,
Jernej
