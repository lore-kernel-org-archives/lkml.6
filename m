Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E8E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E8E2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeIXIBZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 04:01:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39278 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIXIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 04:01:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so14958841edi.6;
        Sun, 23 Sep 2018 19:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oye42SGX0DDLauHH/OzMUQhs01EJCbAKLltDCA1uXFw=;
        b=M2JcvcH3cpoqX2Iqb9BRndM85TPWxJ82Lz1eU80WH9atoRtDiokOF6/zxh2SoBf8a3
         TMcL26BDjw47cWvgXKvrhfQH8HRT3lstz0KhVD4GoniZY8XbOj+6kSdUYwyGTMr6zcmy
         YJVkg58cidJyRHHb46glbDIR0xDSx1xAp1SQRQ79iCoBXJ3zfmdNQEVR5WNowOxQLWD0
         yqBZvX+VEB5vrB5XBlZeAYEhJtybJTmid3DpN8m6z/lcLD9QgK8nHO32fXZGvklXQrZo
         cdRS4a8UwXuInaTPflYIAY5FsiVxWmHN2qj7q851kL5Xa1fuiD1sPdaWC3rUb4hKPKU3
         EIXQ==
X-Gm-Message-State: ABuFfoh+X9PYwZAABVsTCLvX8Y5U2VnKyJVd8F9jKytoY/bG/ErQF++F
        OWtxyKnKGBUHgoDou42v5RsRIprzJ6U=
X-Google-Smtp-Source: ACcGV61ZyKHSP5fOrnfEMGDEU0YVBjFCyoZtY2SXeYWjW4krUjUE2s/hS9205fn7tP/kol5rXd1jpw==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr633980edy.99.1537754494929;
        Sun, 23 Sep 2018 19:01:34 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id h24-v6sm5531638edb.43.2018.09.23.19.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 19:01:33 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id n11-v6so8389106wmc.2;
        Sun, 23 Sep 2018 19:01:33 -0700 (PDT)
X-Received: by 2002:a7b:c18a:: with SMTP id y10-v6mr5786732wmi.87.1537754492998;
 Sun, 23 Sep 2018 19:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-12-jernej.skrabec@siol.net> <CAGb2v67jweJ5OdSzKhj302OLbz7DacKmSGMKS536uquzKGZtAQ@mail.gmail.com>
 <2037444.yZ41eTID0S@jernej-laptop>
In-Reply-To: <2037444.yZ41eTID0S@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 24 Sep 2018 10:01:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67cW=6q04oO4RiUqEHvhzK9W0Bg_49arO73GugVd5NUbA@mail.gmail.com>
Message-ID: <CAGb2v67cW=6q04oO4RiUqEHvhzK9W0Bg_49arO73GugVd5NUbA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 11/27] drm/sun4i: Rework DE2 register defines
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 4:02 AM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne sobota, 22. september 2018 ob 14:32:30 CEST je Chen-Yu Tsai napisal(a):
> > Hi,
> >
> > On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > Most, if not all, registers found in DE2 still exists in DE3. However,
> > > units are on different base addresses.
> > >
> > > To prepare for addition of DE3 support, registers macros are reworked so
> > > they take base address as parameter.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > [rebased]
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> > This patch mostly checks out. But see below.
> >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 406c42e752d7..020b0a097c84
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > > @@ -29,20 +29,24 @@
> > >
> > >  #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE                BIT(0)
> > >
> > > -#define SUN8I_MIXER_BLEND_PIPE_CTL             0x1000
> > > -#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)       (0x1004 + 0x10 * (x) +
> > > 0x0)
> > > -#define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)       (0x1004 + 0x10 * (x) +
> > > 0x4)
> > > -#define SUN8I_MIXER_BLEND_ATTR_COORD(x)                (0x1004 + 0x10 *
> > > (x) + 0x8) -#define SUN8I_MIXER_BLEND_ROUTE                        0x1080
> > > -#define SUN8I_MIXER_BLEND_PREMULTIPLY          0x1084
> > > -#define SUN8I_MIXER_BLEND_BKCOLOR              0x1088
> > > -#define SUN8I_MIXER_BLEND_OUTSIZE              0x108c
> > > -#define SUN8I_MIXER_BLEND_MODE(x)              (0x1090 + 0x04 * (x))
> > > -#define SUN8I_MIXER_BLEND_CK_CTL               0x10b0
> > > -#define SUN8I_MIXER_BLEND_CK_CFG               0x10b4
> > > -#define SUN8I_MIXER_BLEND_CK_MAX(x)            (0x10c0 + 0x04 * (x))
> > > -#define SUN8I_MIXER_BLEND_CK_MIN(x)            (0x10e0 + 0x04 * (x))
> > > -#define SUN8I_MIXER_BLEND_OUTCTL               0x10fc
> > > +#define DE2_BLD_BASE                           0x1000
> > > +#define DE2_CH_BASE                            0x2000
> > > +#define DE2_CH_SIZE                            0x1000
> > > +
> > > +#define SUN8I_MIXER_BLEND_PIPE_CTL(base)       ((base) + 0)
> > > +#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x) ((base) + 0x4 + 0x10 *
> > > (x))
> > > +#define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x) ((base) + 0x8 + 0x10 *
> > > (x))
> > > +#define SUN8I_MIXER_BLEND_ATTR_COORD(base, x)  ((base) + 0xC + 0x10 *
> > > (x))
> >
> > Nit: Use lowercase for '0xC' to be consistent.
> >
> > > +#define SUN8I_MIXER_BLEND_ROUTE(base)          ((base) + 0x80)
> > > +#define SUN8I_MIXER_BLEND_PREMULTIPLY(base)    ((base) + 0x84)
> > > +#define SUN8I_MIXER_BLEND_BKCOLOR(base)                ((base) + 0x88)
> > > +#define SUN8I_MIXER_BLEND_OUTSIZE(base)                ((base) + 0x8c)
> > > +#define SUN8I_MIXER_BLEND_MODE(base, x)                ((base) + 0x90 +
> > > 0x04 * (x)) +#define SUN8I_MIXER_BLEND_CK_CTL(base)         ((base) +
> > > 0xb0)
> > > +#define SUN8I_MIXER_BLEND_CK_CFG(base)         ((base) + 0xb4)
> > > +#define SUN8I_MIXER_BLEND_CK_MAX(base, x)      ((base) + 0xc0 + 0x04 *
> > > (x)) +#define SUN8I_MIXER_BLEND_CK_MIN(base, x)      ((base) + 0xe0 +
> > > 0x04 * (x)) +#define SUN8I_MIXER_BLEND_OUTCTL(base)         ((base) +
> > > 0xfc)
> > >
> > >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK      GENMASK(12, 8)
> > >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)    BIT(8 + pipe)
> >
> > [...]
> >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > > b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c index
> > > 6bb2aa164c8e..c68eab8a748f 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > > @@ -10,6 +10,7 @@
> > >
> > >   */
> > >
> > >  #include "sun8i_ui_scaler.h"
> > >
> > > +#include "sun8i_vi_scaler.h"
> > >
> > >  static const u32 lan2coefftab16[240] = {
> > >
> > >         0x00004000, 0x00033ffe, 0x00063efc, 0x000a3bfb,
> > >
> > > @@ -88,6 +89,14 @@ static const u32 lan2coefftab16[240] = {
> > >
> > >         0x0b1c1603, 0x0d1c1502, 0x0e1d1401, 0x0f1d1301,
> > >
> > >  };
> > >
> > > +static inline u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int
> > > channel)
> > I recently saw a review comment stating one should not inline functions
> > unless they are defined in header files. Otherwise the decision should
> > be left up to the compiler.
> >
> > > +{
> > > +       int vi_num = mixer->cfg->vi_num;
> > > +
> > > +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * vi_num +
> > > +              DE2_UI_SCALER_SIZE * (channel - vi_num);
> > > +}
> > > +
> > >
> > >  static int sun8i_ui_scaler_coef_index(unsigned int step)
> > >  {
> > >
> > >         unsigned int scale, int_part, float_part;
> >
> > [...]
> >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c index
> > > d3f1acb234b7..8697afc36023 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > > @@ -833,6 +833,11 @@ static const u32 bicubic4coefftab32[480] = {
> > >
> > >         0x1012110d, 0x1012110d, 0x1013110c, 0x1013110c,
> > >
> > >  };
> > >
> > > +static inline u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int
> > > channel) +{
> > > +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * channel;
> > > +}
> > > +
> >
> > This one as well.
> >
> > >  static int sun8i_vi_scaler_coef_index(unsigned int step)
> > >  {
> > >
> > >         unsigned int scale, int_part, float_part;
> > >
> > > @@ -857,7 +862,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int
> > > step)>
> > >         }
> > >
> > >  }
> > >
> > > -static void sun8i_vi_scaler_set_coeff(struct regmap *map, int layer,
> > > +static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
> > >
> > >                                       u32 hstep, u32 vstep,
> > >                                       const struct drm_format_info
> > >                                       *format)
> >
> > This is the only instance where a function's "layer" parameter was changed
> > to "base". It would be nice if it were consistent.
>
> Why not? Caller already have base address calculated, so it poses no overhead.
> Additionally, sun8i_vi_scaler_set_coeff() doesn't have struct sun8i_mixer
> *mixer parameter, which would allow calculating base address based on layer
> id. So, you can chose between existing variant or adding additional parameter
> for no real reason.

Thanks for the explanation. Yeah, then the current patch makes sense.

ChenYu
