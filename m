Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBABA2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c4Lpqvcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBABA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJ2XPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:15:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50624 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeJ2XPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:15:33 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so9722089ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwcLW3LNYYGydI4/fUe4zYSPYaXNLWgbJ8dUBFW9/4Y=;
        b=c4LpqvcvymuZA+56QKDy7e7YzwQFpcAw2tsV0KGADKhreT/i+PS+RlvayOyUQM4jX1
         4VVtT2ohDjkCDwyGYhPZ6h1scF+Eta1Hg/kb3XK8L0qyayLWbfaItQyPr6QeEsuxeXly
         HUNHVA35+NTwojBZPLq0TUl71TmcIb5WR44Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwcLW3LNYYGydI4/fUe4zYSPYaXNLWgbJ8dUBFW9/4Y=;
        b=QQ/VgxmdKgvEriBiELsc26/Uis2Wa3uKKOQ3ok/s/0XVxgjYKIdkSLgG/U5CvYzl/e
         9vsivwnCW+gs4kKq/t17yWyFdZ5oKP+jAEe0XsIb5Gh79G880+Q8k47qH8kQam19HEnQ
         /pQZLHK+9bWtI18Na3GWTWwofMX98rab5Ux4O2lKDXWRH3OYjMVFs3Y7mzivoesRvqNX
         8dT2agsEFtIrZ8DQaHXkDzJYMpSKjgRmT0pCSzJxk7xv5Y7pdntJ/83TOzWsjfX4OWaJ
         ariwaots5Exp/vZ4FSTDM9xVnJ/erjsNNg8R95ciH5tDwbuQDmiOAkdGsVvCZvNl5/iB
         5tyA==
X-Gm-Message-State: AGRZ1gKFF2Wnf4NjaZ5GfztxqWEPu38yBFh7h4dse3KZLiKGspcZSTfH
        Du3zNhvifMndG/rgeV/ym8KOhq7dxsyB2TVjSOLuIQ==
X-Google-Smtp-Source: AJdET5fMnsAArk8E1miDYi3V+FNFG8pbihMkdJ5HPZEJCCXDUw54IWSqhDcd49ZBoIjaCFdU0mivrbTVXxMuBdd0Sq4=
X-Received: by 2002:a24:d0c2:: with SMTP id m185-v6mr3376418itg.173.1540823200535;
 Mon, 29 Oct 2018 07:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-13-jagan@amarulasolutions.com> <20181029092227.mdxgvg5aqzh22j72@flea>
In-Reply-To: <20181029092227.mdxgvg5aqzh22j72@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 29 Oct 2018 19:56:27 +0530
Message-ID: <CAMty3ZBHU5eXRLLJmUroLgSKcF6O9gHOHRM1XBnt9_Lp7B8rEA@mail.gmail.com>
Subject: Re: [PATCH v3 12/25] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:52 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:13:31PM +0530, Jagan Teki wrote:
> > Add 10 bytes packet overhead for hblk where blank is set using
> > a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)
> >
> > This is according to BSP code from BPI-M64-bsp
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> >
> > So, add 10 bytes packet overhead for DSI hblk.
> >
> > Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - new patch
> > Changes for v2:
> > - none
> >
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 596e560263bf..cf42be1f1ba1 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >  {
> >       struct mipi_dsi_device *device = dsi->device;
> >       unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> > -     u16 hbp, hfp, hsa, hblk, vblk;
> > +     u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
> >       size_t bytes;
> >       u8 *buffer;
> >
> > @@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >
> >       /*
> >        * hblk seems to be the line + porches length.
> > +      * The blank is set using a blanking packet (4 bytes + 4 bytes +
> > +      * payload + 2 bytes). So minimal size is 10 bytes
> >        */
> > -     hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> > +#define HBLK_PACKET_OVERHEAD 10
> > +     hblk_max = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> > +     hblk_max -= HBLK_PACKET_OVERHEAD;
> > +     hblk = max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
>
> I'd rather use the same convention than the other assignments done
> before in that function.

Yes, old code did use hsa. but it's added 10 bytes packet head instead
of subtracting it.

hblk = mode->htotal * Bpp - hsa;
=> mode->htotal * Bpp - (mode->hsync_end - mode->hsync_start) * Bpp -
HSA_PACKET_OVERHEAD);
=> (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp +
HSA_PACKET_OVERHEAD;

And it should be
(mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
HSA_PACKET_OVERHEAD;

This patch is simply doing the same by explicitly adding packet over
ahead macro, which again used in hfp.
