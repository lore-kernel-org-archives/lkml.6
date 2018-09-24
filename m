Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20736C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B182148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B182148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeIXIE4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 04:04:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33108 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeIXIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 04:04:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id g26-v6so1827144edp.0;
        Sun, 23 Sep 2018 19:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Wr+3HkDRWHuCh/b0po6xZ6UHTUrrY0EkciAoY8oGNI=;
        b=nidN9R3zuU6OjvzXvucyzyv9r7cPVfp+5H8nczKO4WSo1r6rFHKLo35wNazLiOqXy4
         5J4GW1zD21FDvWM19/61SI7Kc28H6DeMp4Bisklmt8jV2jSJUfc7ibRGwDsLKTZqg61a
         z5FVLt+pJfiWs/dHQNKK8h5r0JA26u72LND8H+kfgmrma/EUQmjV3JOsEhNCBRzJvHNa
         eIDQzPOcgUtOKIucHqvYOFn2QycNazWGLgAEHTsc814jE5WZ+ez/4gYloBGqp/fqzIeR
         pTQNNezz3S2cQpydDj4GDSrnm3ItawWBpQiMlhjPa2rboWb4XFRSRCj9MExQYw5phIXy
         15EQ==
X-Gm-Message-State: ABuFfog8oYNdcUycwaZuKGlgVJ1Rqs1aSRtAzs+p2yssQX6x5kDGpPgy
        O0c9bkBclNwUgCJrOF4r2/w3ElmEwEQ=
X-Google-Smtp-Source: ACcGV617L2cbA3BedAGQ0Zh/VTcsvunqKiqUpcv1CmtEjkriIoGSt0KQ5QcwS/fmXKmhw1DTAen3AQ==
X-Received: by 2002:a50:98a3:: with SMTP id j32-v6mr13397429edb.6.1537754702945;
        Sun, 23 Sep 2018 19:05:02 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id f10-v6sm1370780edt.56.2018.09.23.19.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 19:05:02 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id j8-v6so14301805wrw.5;
        Sun, 23 Sep 2018 19:05:02 -0700 (PDT)
X-Received: by 2002:adf:df09:: with SMTP id y9-v6mr565042wrl.26.1537754702074;
 Sun, 23 Sep 2018 19:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-13-jernej.skrabec@siol.net> <CAGb2v65tt4S-k=AF2AmjQyEkUydzMimB8TT2Uiqmpf6G8qD1Cw@mail.gmail.com>
 <2453235.vVnySQtb9h@jernej-laptop>
In-Reply-To: <2453235.vVnySQtb9h@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 24 Sep 2018 10:04:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v667zERDhWTwhoNykvKEJWU2TXdCfNNtOiTt9Wtv+gfR1w@mail.gmail.com>
Message-ID: <CAGb2v667zERDhWTwhoNykvKEJWU2TXdCfNNtOiTt9Wtv+gfR1w@mail.gmail.com>
Subject: Re: [PATCH 12/27] drm/sun4i: Add basic support for DE3
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 3:51 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne sobota, 22. september 2018 ob 15:19:12 CEST je Chen-Yu Tsai napisal(a):
> > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > Display Engine 3 is an upgrade of DE2 with new features like support for
> > > 10 bit color formats and support for AFBC.
> > >
> > > Most of DE2 code works with DE3, except some small details.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  drivers/gpu/drm/sun4i/sun8i_csc.c       | 96 +++++++++++++++++++++++--
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c     | 17 ++++-
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.h     | 21 +++++-
> > >  drivers/gpu/drm/sun4i/sun8i_ui_scaler.c |  8 ++-
> > >  drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |  1 +
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |  8 +++
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |  2 +
> > >  drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 34 ++++++++-
> > >  drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 23 ++++++
> > >  9 files changed, 197 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c
> > > b/drivers/gpu/drm/sun4i/sun8i_csc.c index b14925b40ccf..101901ccf2dc
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_csc.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
> > > @@ -34,6 +34,34 @@ static const u32 yvu2rgb[] = {
> > >
> > >         0x000004A8, 0x00000000, 0x00000813, 0xFFFBAC4A,
> > >
> > >  };
> > >
> > > +/*
> > > + * DE3 has a bit different CSC units. Factors are in two's complement
> > > format. + * First three have 17 bits for fractinal part and last two 2
> > > bits. First + * three values in each line are multiplication factor, 4th
> > > is difference, + * which is subtracted from the input value before the
> > > multiplication and + * last value is constant, which is added at the end.
> > > + *
> > > + * x' = c00 * (x + d0) + c01 * (y + d1) + c02 * (z + d2) + const0
> > > + * y' = c10 * (x + d0) + c11 * (y + d1) + c12 * (z + d2) + const1
> > > + * z' = c20 * (x + d0) + c21 * (y + d1) + c22 * (z + d2) + const2
> > > + *
> > > + * Please note that above formula is true only for Blender CSC. Other DE3
> > > CSC + * units takes only positive value for difference. From what can be
> > > deducted + * from BSP driver code, those units probably automatically
> > > assume that + * difference has to be subtracted.
> > > + */
> > > +static const u32 yuv2rgb_de3[] = {
> > > +       0x0002542a, 0x00000000, 0x0003312a, 0xffffffc0, 0x00000000,
> > > +       0x0002542a, 0xffff376b, 0xfffe5fc3, 0xfffffe00, 0x00000000,
> > > +       0x0002542a, 0x000408d3, 0x00000000, 0xfffffe00, 0x00000000,
> > > +};
> > > +
> > > +static const u32 yvu2rgb_de3[] = {
> > > +       0x0002542a, 0x0003312a, 0x00000000, 0xffffffc0, 0x00000000,
> > > +       0x0002542a, 0xfffe5fc3, 0xffff376b, 0xfffffe00, 0x00000000,
> > > +       0x0002542a, 0x00000000, 0x000408d3, 0xfffffe00, 0x00000000,
> > > +};
> > > +
> > >
> > >  static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
> > >
> > >                                        enum sun8i_csc_mode mode)
> > >
> > >  {
> > >
> > > @@ -61,6 +89,38 @@ static void sun8i_csc_set_coefficients(struct regmap
> > > *map, u32 base,>
> > >         }
> > >
> > >  }
> > >
> > > +static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int
> > > layer,
> > > +                                           enum sun8i_csc_mode mode)
> > > +{
> > > +       const u32 *table;
> > > +       int i, j;
> > > +
> > > +       switch (mode) {
> > > +       case SUN8I_CSC_MODE_YUV2RGB:
> > > +               table = yuv2rgb_de3;
> > > +               break;
> > > +       case SUN8I_CSC_MODE_YVU2RGB:
> > > +               table = yvu2rgb_de3;
> > > +               break;
> > > +       default:
> > > +               DRM_WARN("Wrong CSC mode specified.\n");
> > > +               return;
> > > +       }
> > > +
> > > +       for (i = 0; i < 3; i++) {
> > > +               for (j = 0; j < 3; j++)
> > > +                       regmap_write(map,
> > > +
> > > SUN8I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, +
> > >                                  layer, i, j), +
> > >           table[i * 5 + j]);
> >
> > Given that the first three values occupy contiguous addresses,
> > you can use regmap_bulk_write() here.
> >
> > > +               regmap_write(map,
> > > +                            SUN8I_MIXER_BLEND_CSC_CONST(DE3_BLD_BASE,
> > > +                                                        layer, i),
> > > +                            SUN8I_MIXER_BLEND_CSC_CONST_VAL(table[i * 5 +
> > > 3], +                                                            table[i
> > > * 5 + 4]));
> > Nit: Using a two-dimension array might make it easier to read.
> >
> > > +       }
> > > +}
> > > +
> > >
> > >  static void sun8i_csc_enable(struct regmap *map, u32 base, bool enable)
> > >  {
> > >
> > >         u32 val;
> > >
> > > @@ -73,21 +133,45 @@ static void sun8i_csc_enable(struct regmap *map, u32
> > > base, bool enable)>
> > >         regmap_update_bits(map, SUN8I_CSC_CTRL(base), SUN8I_CSC_CTRL_EN,
> > >         val);
> > >
> > >  }
> > >
> > > +static void sun8i_de3_ccsc_enable(struct regmap *map, int layer, bool
> > > enable) +{
> > > +       u32 val, mask;
> > > +
> > > +       mask = SUN8I_MIXER_BLEND_CSC_CTL_EN(layer);
> > > +
> > > +       if (enable)
> > > +               val = mask;
> > > +       else
> > > +               val = 0;
> > > +
> > > +       regmap_update_bits(map, SUN8I_MIXER_BLEND_CSC_CTL(DE3_BLD_BASE),
> > > +                          mask, val);
> > > +}
> > > +
> > >
> > >  void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int
> > >  layer,
> > >
> > >                                      enum sun8i_csc_mode mode)
> > >
> > >  {
> > >
> > > -       u32 base;
> > > +       if (!mixer->cfg->is_de3) {
> > > +               u32 base;
> >
> > You could rewrite this as
> >
> >     if (mixer->cfg->is_de3) {
> >                sun8i_de3_ccsc_set_coefficients(mixer->engine.regs,
> >                                                layer, mode);
> >                return;
> >     }
> >
> > That way you don't need to change the indentation on the existing lines.
> > I suppose this is more of a personal preference. The downside is the control
> > flow is slightly more complicated.
> >
> > > -       base = ccsc_base[mixer->cfg->ccsc][layer];
> > > +               base = ccsc_base[mixer->cfg->ccsc][layer];
> > >
> > > -       sun8i_csc_set_coefficients(mixer->engine.regs, base, mode);
> > > +               sun8i_csc_set_coefficients(mixer->engine.regs, base,
> > > mode);
> > > +       } else {
> > > +               sun8i_de3_ccsc_set_coefficients(mixer->engine.regs,
> > > +                                               layer, mode);
> > > +       }
> > >
> > >  }
> > >
> > >  void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer, int layer, bool
> > >  enable) {
> > >
> > > -       u32 base;
> > > +       if (!mixer->cfg->is_de3) {
> > > +               u32 base;
> > >
> > > -       base = ccsc_base[mixer->cfg->ccsc][layer];
> > > +               base = ccsc_base[mixer->cfg->ccsc][layer];
> > >
> > > -       sun8i_csc_enable(mixer->engine.regs, base, enable);
> > > +               sun8i_csc_enable(mixer->engine.regs, base, enable);
> > > +       } else {
> > > +               sun8i_de3_ccsc_enable(mixer->engine.regs, layer, enable);
> > > +       }
> > >
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index 743941a33d88..a9218abf0935
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -460,8 +460,21 @@ static int sun8i_mixer_bind(struct device *dev,
> > > struct device *master,>
> > >         base = sun8i_blender_base(mixer);
> > >
> > >         /* Reset the registers */
> > >
> > > -       for (i = 0x0; i < 0x20000; i += 4)
> > > -               regmap_write(mixer->engine.regs, i, 0);
> > > +       if (mixer->cfg->is_de3) {
> > > +               for (i = 0x0; i < 0x3000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> > > +               for (i = 0x20000; i < 0x40000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> > > +               for (i = 0x70000; i < 0x88000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> > > +               for (i = 0xa0000; i < 0xb0000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> > > +               for (i = 0xd0000; i < 0xe0000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> >
> > Could you use the macros *_BASE and *_SIZE here? That would make
> > it more obviously what parts you're clearing.
>
> Ok, but where should I define them? In sun8i-mixer.h?

If it's only used here you could put them just above this function.

> >
> > The last offset, 0xd0000, isn't even defined in the DE3 spec.
>
> It is, check chapter 2.3.2, table 2-3.

I must have read something incorrectly. I see it now. Thanks.

ChenYu

> >
> > > +       } else {
> > > +               for (i = 0x0; i < 0x20000; i += 4)
> > > +                       regmap_write(mixer->engine.regs, i, 0);
> > > +       }
> > >
> > >         /* Enable the mixer */
> > >         regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 020b0a097c84..4c9a442bbb44
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > @@ -33,6 +33,10 @@
> > >
> > >  #define DE2_CH_BASE                            0x2000
> > >  #define DE2_CH_SIZE                            0x1000
> > >
> > > +#define DE3_BLD_BASE                           0x0800
> > > +#define DE3_CH_BASE                            0x1000
> > > +#define DE3_CH_SIZE                            0x0800
> > > +
> > >
> > >  #define SUN8I_MIXER_BLEND_PIPE_CTL(base)       ((base) + 0)
> > >  #define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x) ((base) + 0x4 + 0x10 *
> > >  (x))
> > >  #define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x) ((base) + 0x8 + 0x10 *
> > >  (x))
> > >
> > > @@ -47,6 +51,11 @@
> > >
> > >  #define SUN8I_MIXER_BLEND_CK_MAX(base, x)      ((base) + 0xc0 + 0x04 *
> > >  (x))
> > >  #define SUN8I_MIXER_BLEND_CK_MIN(base, x)      ((base) + 0xe0 + 0x04 *
> > >  (x))
> > >  #define SUN8I_MIXER_BLEND_OUTCTL(base)         ((base) + 0xfc)
> > >
> > > +#define SUN8I_MIXER_BLEND_CSC_CTL(base)                ((base) + 0x100)
> > > +#define SUN8I_MIXER_BLEND_CSC_COEFF(base, layer, x, y) \
> > > +       ((base) + 0x110 + (layer) * 0x30 +  (x) * 0x10 + 4 * (y))
> > > +#define SUN8I_MIXER_BLEND_CSC_CONST(base, layer, i) \
> > > +       ((base) + 0x110 + (layer) * 0x30 +  (i) * 0x10 + 0x0c)
> >
> > Should these have a DE3 prefix?
>
> Ok for all prefix comments.
>
> >
> > >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK      GENMASK(12, 8)
> > >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)    BIT(8 + pipe)
> > >
> > > @@ -61,6 +70,9 @@
> > >
> > >  #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED    BIT(1)
> > >
> > > +#define SUN8I_MIXER_BLEND_CSC_CTL_EN(ch)       BIT(ch)
> > > +#define SUN8I_MIXER_BLEND_CSC_CONST_VAL(d, c)  (((d) << 16) | ((c) &
> > > 0xffff)) +
> >
> > Same here.
> >
> > >  #define SUN8I_MIXER_FBFMT_ARGB8888     0
> > >  #define SUN8I_MIXER_FBFMT_ABGR8888     1
> > >  #define SUN8I_MIXER_FBFMT_RGBA8888     2
> >
> > [...]
> >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h index 46f0237c17bb..3d0ad64178ea
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
> > > @@ -30,6 +30,8 @@
> > >
> > >  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE                BIT(15)
> > >  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET    8
> > >  #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK      GENMASK(12, 8)
> > >
> > > +#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK      GENMASK(31, 24)
> > > +#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)                ((x) <<
> > > 24)
> >
> > DE3 prefix?
> >
> > >  struct sun8i_mixer;
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c index
> > > 8697afc36023..22e1ed5cd7a4 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > @@ -835,7 +835,10 @@ static const u32 bicubic4coefftab32[480] = {
> > >
> > >  static inline u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int
> > >  channel) {
> > >
> > > -       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * channel;
> > > +       if (mixer->cfg->is_de3)
> > > +               return DE3_VI_SCALER_BASE + DE3_VI_SCALER_SIZE * channel;
> > > +       else
> > > +               return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * channel;
> > >
> > >  }
> > >
> > >  static int sun8i_vi_scaler_coef_index(unsigned int step)
> > >
> > > @@ -951,6 +954,35 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer,
> > > int layer,>
> > >                 cvphase = vphase;
> > >
> > >         }
> > >
> > > +       if (mixer->cfg->is_de3) {
> > > +               u32 val;
> > > +
> > > +               if (format->hsub == 1 && format->vsub == 1)
> > > +                       val = SUN8I_SCALER_VSU_SCALE_MODE_UI;
> > > +               else
> > > +                       val = SUN8I_SCALER_VSU_SCALE_MODE_NORMAL;
> > > +
> > > +               regmap_write(mixer->engine.regs,
> > > +                            SUN8I_SCALER_VSU_SCALE_MODE(base), val);
> >
> > The remaining settings seem to be related to the edge detection scaling
> > method. Since you aren't supporting it, are they necessary?
>
> Didn't really tried without them IIRC. I will for next revision.
>
> Best regards,
> Jernej
>
> >
> > > +               regmap_write(mixer->engine.regs,
> > > +                            SUN8I_SCALER_VSU_DIR_THR(base),
> > > +                            SUN8I_SCALER_VSU_SUB_ZERO_DIR_THR(0) |
> > > +                            SUN8I_SCALER_VSU_ZERO_DIR_THR(0) |
> > > +                            SUN8I_SCALER_VSU_HORZ_DIR_THR(0xff) |
> > > +                            SUN8I_SCALER_VSU_VERT_DIR_THR(1));
> > > +               regmap_write(mixer->engine.regs,
> > > +                            SUN8I_SCALER_VSU_EDGE_THR(base),
> > > +                            SUN8I_SCALER_VSU_EDGE_SHIFT(8) |
> > > +                            SUN8I_SCALER_VSU_EDGE_OFFSET(0));
> > > +               regmap_write(mixer->engine.regs,
> > > +                            SUN8I_SCALER_VSU_EDSCL_CTRL(base), 0);
> > > +               regmap_write(mixer->engine.regs,
> > > +                            SUN8I_SCALER_VSU_ANGLE_THR(base),
> > > +                            SUN8I_SCALER_VSU_ANGLE_SHIFT(2) |
> > > +                            SUN8I_SCALER_VSU_ANGLE_OFFSET(0));
> > > +       }
> > > +
> > >
> > >         regmap_write(mixer->engine.regs,
> > >
> > >                      SUN8I_SCALER_VSU_OUTSIZE(base), outsize);
> > >
> > >         regmap_write(mixer->engine.regs,
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h index
> > > cd015405f66d..c322f5652481 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
> > > @@ -15,6 +15,9 @@
> > >
> > >  #define DE2_VI_SCALER_BASE 0x20000
> > >  #define DE2_VI_SCALER_SIZE 0x20000
> > >
> > > +#define DE3_VI_SCALER_BASE 0x20000
> > > +#define DE3_VI_SCALER_SIZE 0x08000
> > > +
> > >
> > >  /* this two macros assumes 16 fractional bits which is standard in DRM */
> > >  #define SUN8I_VI_SCALER_SCALE_MIN              1
> > >  #define SUN8I_VI_SCALER_SCALE_MAX              ((1UL << 20) - 1)
> > >
> > > @@ -25,6 +28,11 @@
> > >
> > >  #define SUN8I_VI_SCALER_SIZE(w, h)             (((h) - 1) << 16 | ((w) -
> > >  1))
> > >
> > >  #define SUN8I_SCALER_VSU_CTRL(base)            ((base) + 0x0)
> > >
> > > +#define SUN8I_SCALER_VSU_SCALE_MODE(base)      ((base) + 0x10)
> > > +#define SUN8I_SCALER_VSU_DIR_THR(base)         ((base) + 0x20)
> > > +#define SUN8I_SCALER_VSU_EDGE_THR(base)                ((base) + 0x24)
> > > +#define SUN8I_SCALER_VSU_EDSCL_CTRL(base)      ((base) + 0x28)
> > > +#define SUN8I_SCALER_VSU_ANGLE_THR(base)       ((base) + 0x2c)
> >
> > DE3 prefix for the new ones please.
> >
> > >  #define SUN8I_SCALER_VSU_OUTSIZE(base)         ((base) + 0x40)
> > >  #define SUN8I_SCALER_VSU_YINSIZE(base)         ((base) + 0x80)
> > >  #define SUN8I_SCALER_VSU_YHSTEP(base)          ((base) + 0x88)
> > >
> > > @@ -46,6 +54,21 @@
> > >
> > >  #define SUN8I_SCALER_VSU_CTRL_EN               BIT(0)
> > >  #define SUN8I_SCALER_VSU_CTRL_COEFF_RDY                BIT(4)
> > >
> > > +#define SUN8I_SCALER_VSU_SUB_ZERO_DIR_THR(x)   (((x) << 24) & 0xFF)
> > > +#define SUN8I_SCALER_VSU_ZERO_DIR_THR(x)       (((x) << 16) & 0xFF)
> > > +#define SUN8I_SCALER_VSU_HORZ_DIR_THR(x)       (((x) << 8) & 0xFF)
> > > +#define SUN8I_SCALER_VSU_VERT_DIR_THR(x)       ((x) & 0xFF)
> > > +
> > > +#define SUN8I_SCALER_VSU_SCALE_MODE_UI         0
> > > +#define SUN8I_SCALER_VSU_SCALE_MODE_NORMAL     1
> > > +#define SUN8I_SCALER_VSU_SCALE_MODE_ED_SCALE   2
> > > +
> > > +#define SUN8I_SCALER_VSU_EDGE_SHIFT(x)         (((x) << 16) & 0xF)
> > > +#define SUN8I_SCALER_VSU_EDGE_OFFSET(x)                ((x) & 0xFF)
> > > +
> > > +#define SUN8I_SCALER_VSU_ANGLE_SHIFT(x)                (((x) << 16) &
> > > 0xF)
> > > +#define SUN8I_SCALER_VSU_ANGLE_OFFSET(x)       ((x) & 0xFF)
> > > +
> >
> > Same here.
> >
> > Regards
> > ChenYu
> >
> > >  void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool
> > >  enable); void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int
> > >  layer,
> > >
> > >                            u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
> > >
> > > --
> > > 2.18.0
>
>
>
>
