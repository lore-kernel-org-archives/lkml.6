Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B09C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00D620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fGVj0V8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00D620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeKSVpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:45:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38240 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeKSVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:45:49 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so3602206ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TA0tjnvEntm7WKuCiOxyeEgF0BAR0FEyPhya5grE5w=;
        b=fGVj0V8ulBIbtr8rVm8gCTyB62WBAwEqDm90S1LZzZ/l0LeLmakRwQtfq4Iph4wecR
         O2Mgc4rSkCyoNvgt0nKcPbGZsu49vmrylyt6Ky4JeomKD4Bq8Nr+OcKNIYI4zMvExQNy
         RTRU2YziouEHsUHTZpqJkRy/UVXNZb6q71uAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TA0tjnvEntm7WKuCiOxyeEgF0BAR0FEyPhya5grE5w=;
        b=I28f0RvF6H7vDFfPLgAEU2TmpGJVMypy2iDULHyftkgoRJHxp5b3ewGwR8Zm6zhEZW
         OHVpFmR+lI6K+QvmVNtLP3NDZ+0hRUMmBS+Z80LFFI8YbW0FSdfUDaFUYerxd18npjyG
         8ZvNFMP3kCfVepQRUdaIlyKw2KnMmof5Bk0baU3TUVNn8ZGvyNiQ4DICZaqaLY8G2IAr
         Xt4kMFeF6rdaNixVx/8dok7wNOYmjOhbwUvreQlmjZpLk+gN2kOll5zFcaQnEdw9NaHR
         JUXTzFke1c7VYkPpVdOPFI/ZWA25MtKM3n70kK3cQdjhm81DFC1vjV+p08BMaycXAwle
         PKjg==
X-Gm-Message-State: AA+aEWaQK2wf+pjNEYKePkq3JJdfqwkcENPzNXC0SybWq1ZO/I69v4Rd
        9wi9fKOPrXliWY8wP0HBQETwMFiQYfGEpd1UDnfcIw==
X-Google-Smtp-Source: AFSGD/WhN18HGQiWQz3HVjl5wVEouwQHBNICs1xinrArKvV2UBXcQE8ai3HfuWb+JHDLhjb8Vegl17sp7V1RjwsU4jU=
X-Received: by 2002:a24:2710:: with SMTP id g16-v6mr510905ita.107.1542626549241;
 Mon, 19 Nov 2018 03:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-5-jagan@amarulasolutions.com> <20181119083243.4njj2p2sy2xf2zyf@flea>
In-Reply-To: <20181119083243.4njj2p2sy2xf2zyf@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 19 Nov 2018 16:52:17 +0530
Message-ID: <CAMty3ZAKL2fZqwLwd_WiQpzz+cOETMR7ES7HQsBo3PsAvjM+6A@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] drm/sun4i: sun6i_mipi_dsi: Simplify drq set to
 support all modes
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:08PM +0530, Jagan Teki wrote:
> > Allwinner MIPI DSI DRQ set value can be varied with respective
> > video modes.
> > - burst mode the set value is always 0
> > - video modes whose front porch greater than 20, the set value
> >   can be computed based front porch and bpp.
> > - video modes whose front porch is not greater than 20, the set value
> >   is simply 0
> >
> > This patch simplifies existing drq set value code by grouping
> > into sun6i_dsi_get_drq and support all video modes.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index efd08bfd0cb8..d60955880c43 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -363,6 +363,26 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> >                    SUN6I_DSI_INST_JUMP_CFG_NUM(1));
> >  };
> >
> > +static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
> > +                           struct drm_display_mode *mode)
> > +{
> > +     struct mipi_dsi_device *device = dsi->device;
> > +     int drq = 0;
>
> So, here, you declaring a variable called drq, set to 0.
>
> > +     if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> > +             return drq;
>
> That you return here. You could just return 0, to be clearer.
>
> > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > +             /* Maaaaaagic */
> > +             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
>
> You re-declare a variable with the same name here, but a different
> type....
>
> > +             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > +             drq /= 32;
> > +     }
> > +
> > +     return drq;
>
> And then return the first one? How is that even working?

Will fix this.

>
> > +
> >  static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
> >                                     struct drm_display_mode *mode, u16 hblk)
> >  {
> > @@ -478,21 +498,9 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> >  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> >                                 struct drm_display_mode *mode)
> >  {
> > -     struct mipi_dsi_device *device = dsi->device;
> > -     u32 val = 0;
> > -
> > -     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > -             /* Maaaaaagic */
> > -             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
> > -
> > -             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > -             drq /= 32;
> > -
> > -             val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > -                    SUN6I_DSI_TCON_DRQ_SET(drq));
> > -     }
> > -
> > -     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> > +     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
> > +                  SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > +                  SUN6I_DSI_TCON_DRQ_SET(sun6i_dsi_get_drq(dsi, mode)));
>
> On top of that, you now enable the DRQ stuff all the time, while it

Earlier the val value is ENABLE_MODE ORed with drq value. for the
condition drq is computed in if block otherwise the val is 0.
So as I explained in commit message the drq value is 0
- for video modes whose front porch is not greater than 20 and
- for burst mode the val

ie reason I mode it common.
