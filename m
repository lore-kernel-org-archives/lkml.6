Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D450C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1C120870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="J2grgvIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1C120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeKUBS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:18:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42826 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeKUBS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:18:29 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so1530264ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqNP6j2bKKLZkG076wYf/DOtCNqtk3MKMSERBFtE8jM=;
        b=J2grgvIyvF1ojO5DSsQJHH8zfBCd97CvS6ZgxPnKZSlb9DTXplSqT/hpUyVZ3NSXni
         MQCgNAbAMqSfh41eslGGG4P9kDp6xcPrn/uy596VeE5Jdl7CHd2wDqVCpiAxt0hWbyMU
         RfwuSz40qqtxPZV1fxnCtLw+BiGzoi9tNASsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqNP6j2bKKLZkG076wYf/DOtCNqtk3MKMSERBFtE8jM=;
        b=SsdO2HmTQpxAMmmndIVAFVwJF/4D9pH4yx+FzO9bibAM2U6YfCx1m9+N12i04zHEA4
         1SsfCmCuboYae2W4JdHilKVbpNtzcJNXX0keK4hgMTGK+fHXH/9j4A12x7jBkWqFwsfM
         LiqLsgubyrSwMLXGxAUBa2BC3woWvFqtxCLGC6Cu/8tmtJvlUG3HvwtRqqw4Fv996VSQ
         QR7fQ1FQ5o1xW2JLjqZd83UEyNFFVpFBYtZK78TCCbXvDIrkVReZluH3kmuYSIfcPiCm
         pE+tOhkg4vKNxdBExZzuusJaAL343cVw5COKBghBI2wGNGUD8I+YrhXB7C3TQBxC4UWc
         ucpQ==
X-Gm-Message-State: AA+aEWb2IWXJknimRY0AjTd9BfpNNZWMWTzJJmHZdFMN6hqhDBOKbhbu
        JSGK1mDZkSoCPfpbcJgDRlLQhqgCQrWqxIV1Z2vnmNH+SmFgRw==
X-Google-Smtp-Source: AFSGD/XlkE7ji92vz4smrbHOg9YDKoS7ymnQ2aNtjx4hRqZO/xtk0m21HJLbQXDYr0LkKeM8aDdMd+LIFnmR6aIbPLI=
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr1777323iod.267.1542725338111;
 Tue, 20 Nov 2018 06:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-5-jagan@amarulasolutions.com> <20181119083243.4njj2p2sy2xf2zyf@flea>
 <CAMty3ZAKL2fZqwLwd_WiQpzz+cOETMR7ES7HQsBo3PsAvjM+6A@mail.gmail.com> <20181120143229.ncx3hk2manc7hnwl@flea>
In-Reply-To: <20181120143229.ncx3hk2manc7hnwl@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 20 Nov 2018 20:18:46 +0530
Message-ID: <CAMty3ZDMrSfzBk8wRkc9KC5FUOOnSiZE7SO+Gn_8BFKzEyZHYQ@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 8:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Nov 19, 2018 at 04:52:17PM +0530, Jagan Teki wrote:
> > On Mon, Nov 19, 2018 at 2:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Fri, Nov 16, 2018 at 10:09:08PM +0530, Jagan Teki wrote:
> > > > Allwinner MIPI DSI DRQ set value can be varied with respective
> > > > video modes.
> > > > - burst mode the set value is always 0
> > > > - video modes whose front porch greater than 20, the set value
> > > >   can be computed based front porch and bpp.
> > > > - video modes whose front porch is not greater than 20, the set value
> > > >   is simply 0
> > > >
> > > > This patch simplifies existing drq set value code by grouping
> > > > into sun6i_dsi_get_drq and support all video modes.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++----------
> > > >  1 file changed, 23 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index efd08bfd0cb8..d60955880c43 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -363,6 +363,26 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
> > > >                    SUN6I_DSI_INST_JUMP_CFG_NUM(1));
> > > >  };
> > > >
> > > > +static int sun6i_dsi_get_drq(struct sun6i_dsi *dsi,
> > > > +                           struct drm_display_mode *mode)
> > > > +{
> > > > +     struct mipi_dsi_device *device = dsi->device;
> > > > +     int drq = 0;
> > >
> > > So, here, you declaring a variable called drq, set to 0.
> > >
> > > > +     if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> > > > +             return drq;
> > >
> > > That you return here. You could just return 0, to be clearer.
> > >
> > > > +     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > > > +             /* Maaaaaagic */
> > > > +             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
> > >
> > > You re-declare a variable with the same name here, but a different
> > > type....
> > >
> > > > +             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > > > +             drq /= 32;
> > > > +     }
> > > > +
> > > > +     return drq;
> > >
> > > And then return the first one? How is that even working?
> >
> > Will fix this.
>
> I don't want you to only fix this, I also want you to contribute code
> that is A) useful, B) tested.

It was tested in burst mode panel, the same added in the series. It
worked because burst mode need 0 drq rate.

>
> > > >  static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
> > > >                                     struct drm_display_mode *mode, u16 hblk)
> > > >  {
> > > > @@ -478,21 +498,9 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
> > > >  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
> > > >                                 struct drm_display_mode *mode)
> > > >  {
> > > > -     struct mipi_dsi_device *device = dsi->device;
> > > > -     u32 val = 0;
> > > > -
> > > > -     if ((mode->hsync_start - mode->hdisplay) > 20) {
> > > > -             /* Maaaaaagic */
> > > > -             u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
> > > > -
> > > > -             drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> > > > -             drq /= 32;
> > > > -
> > > > -             val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > > > -                    SUN6I_DSI_TCON_DRQ_SET(drq));
> > > > -     }
> > > > -
> > > > -     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> > > > +     regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG,
> > > > +                  SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> > > > +                  SUN6I_DSI_TCON_DRQ_SET(sun6i_dsi_get_drq(dsi, mode)));
> > >
> > > On top of that, you now enable the DRQ stuff all the time, while it
> >
> > Earlier the val value is ENABLE_MODE ORed with drq value. for the
> > condition drq is computed in if block otherwise the val is 0.
> > So as I explained in commit message the drq value is 0
> > - for video modes whose front porch is not greater than 20 and
> > - for burst mode the val
> >
> > ie reason I mode it common.
>
> The previous code was enabling it if the front porch was larger than
> 20 only. You enable it all the time now, and you never explain why.

Got it. Loo like I was confused to test these two separate series in
separate panels and missed something. Is it Ok to combine all dsi
changes together and send it in next version.
