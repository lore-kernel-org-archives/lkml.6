Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC05520657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iKZ2wHaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC05520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJ2XRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:17:00 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36149 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeJ2XRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:17:00 -0400
Received: by mail-it1-f193.google.com with SMTP id t4-v6so1275707itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csIQGmJZW/l9oIw4NG0CrTd9Cu8XhuD8enkaPjecEOQ=;
        b=iKZ2wHaTvE6ksFUFqShoFkngC/STPgBDWs2hcguLbzLZ4nnwOXBV55Io9yOrnjVDRP
         A8D0rscbbtt5lc/YhuaOPNF+dAC3rKYM3JCa3eXKBCfvEcd+XqLdMWeJW91eyspZEbar
         PSZHe/jQoMXeKckz6dNitLi+Whoi2zwV8gsgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csIQGmJZW/l9oIw4NG0CrTd9Cu8XhuD8enkaPjecEOQ=;
        b=nPY7byLu61IvJmydu5XUBaizxH/gwfH2kbwXdnIwTkCMh0Xj5+4YSxbYgvFxjaY1FO
         M3+cTdiAp08JVa+xl05ppH/w8MYTyaTQQ5xGKDAL6+wgfie7M65cZHvr88lS1BowEyg5
         Na+IW5M9euHHjOJZpw941jpHuF2+y91ctOpWuAhEhViP2yYHCfYGcR9bFNKABHGZpORJ
         ZorWVHrD9ryH43NZh/BDJH6nWI/W8fdsab5r29Xv+0enGjH0wKH7Ocw8N01w7k6M1Cb0
         BtfHY1+fgq5pzUgwbRGwRTCgIMHwjRFLeF8V0Q/0+22QXflnrSSSxk5hOM0WjwAzFJhJ
         W9mQ==
X-Gm-Message-State: AGRZ1gKtDxYBC4JI2koGfSv7isa3PFkLrGEz4q4wyISXGWyhZbXqP3fS
        Y+oJ+8qY03iMMcI1s63sDa3apF2U35nZC4qbJWd9aA==
X-Google-Smtp-Source: AJdET5eSOhIgrHT5t7Cf+O/UWztETUMyO8jP9QslfQGZF5eRcVE7azZvCoDzoPefeNZt5cymtvAOdOfLFbLayq0d9a0=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr10579109jad.85.1540823287094;
 Mon, 29 Oct 2018 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-15-jagan@amarulasolutions.com> <20181029092754.2tl7i5k5qpbn4557@flea>
In-Reply-To: <20181029092754.2tl7i5k5qpbn4557@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 29 Oct 2018 19:57:56 +0530
Message-ID: <CAMty3ZC6B-o1Oij_FLpotjN_900kF6OikK323y=bQ9VPzSPDgg@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] drm/sun4i: sun6i_mipi_dsi: Increase hfp packet overhead
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

On Mon, Oct 29, 2018 at 2:58 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:13:33PM +0530, Jagan Teki wrote:
> > Increase the hfp packet overhead with another 10 bytes, the extra
> > 10 bytes(which is hblk packet overhead) is adding for hfp packet
> > overhead since hfp depends on hblk.
> >
> > This is truely as per BSP code from BPI-M64-bsp.
> > The real computation from BSP is
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
> > dsi_hact = x * dsi_pixel_bits[format]/8;
> > dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> > dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);
> >
> > Example,
> > u32 fmt = dsi_pixel_bits[format]/8;
> > => ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
> > => (ht - hspw - x - (hbp - hspw)) * fmt - 16
> > => (ht - x - hbp) * fmt - 16
> > => (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
> > * fmt - 16
> > => (timmings->hor_total_time - x - timmings->hor_total_time +
> > timmings->hor_front_porch + x) * fmt - 16
> > => timmings->hor_front_porch * fmt - 16
> >
> > So, increase the DSI hfp packet overhead by hblk packet overhead.
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
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 6584b51736a9..20e330186b7f 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >  {
> >       struct mipi_dsi_device *device = dsi->device;
> >       unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> > -     u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
> > +     u16 hbp, hfp_pkt_overhead, hfp, hsa, hblk_max, hblk, vblk;
> >       size_t bytes;
> >       u8 *buffer;
> >
> > @@ -484,14 +484,6 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >       hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> >                 (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
> >
> > -     /*
> > -      * The frontporch is set using a blanking packet (4 bytes +
> > -      * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > -      */
> > -#define HFP_PACKET_OVERHEAD  6
> > -     hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> > -               (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
> > -
> >       /*
> >        * hblk seems to be the line + porches length.
> >        * The blank is set using a blanking packet (4 bytes + 4 bytes +
> > @@ -502,6 +494,18 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >       hblk_max -= HBLK_PACKET_OVERHEAD;
> >       hblk = max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);
> >
> > +     /*
> > +      * The frontporch is set using a blanking packet (4 bytes +
> > +      * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > +      *
> > +      * According to BSP code, extra 10 bytes(which is hblk packet overhead)
> > +      * is adding for hfp packet overhead since hfp depends on hblk.
>
> "According to the BSP code, another 10 bytes (the HBLK packet
> overhead) need to be added to the front porch overhead."
>
> How has this been verified? Since we have registers to set all the
> parameters, this seems kind of weird.

Verified based on the BSP calculation which I explained in commit
message and tested by validating these numbers with mainline vs bsp
code.
