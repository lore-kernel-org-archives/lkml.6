Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638DECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFAD21477
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFAD21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeIXCBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 22:01:10 -0400
Received: from mailoutvs46.siol.net ([185.57.226.237]:45876 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726994AbeIXCBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 22:01:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 9BE6952190A;
        Sun, 23 Sep 2018 22:02:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IGuE0ID0Q3HV; Sun, 23 Sep 2018 22:02:25 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 7D51C521916;
        Sun, 23 Sep 2018 22:02:25 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id 521725218F7;
        Sun, 23 Sep 2018 22:02:24 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
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
Subject: Re: [linux-sunxi] [PATCH 11/27] drm/sun4i: Rework DE2 register defines
Date:   Sun, 23 Sep 2018 22:02:24 +0200
Message-ID: <2037444.yZ41eTID0S@jernej-laptop>
In-Reply-To: <CAGb2v67jweJ5OdSzKhj302OLbz7DacKmSGMKS536uquzKGZtAQ@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-12-jernej.skrabec@siol.net> <CAGb2v67jweJ5OdSzKhj302OLbz7DacKmSGMKS536uquzKGZtAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 22. september 2018 ob 14:32:30 CEST je Chen-Yu Tsai napisal(a):
> Hi,
> 
> On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Most, if not all, registers found in DE2 still exists in DE3. However,
> > units are on different base addresses.
> > 
> > To prepare for addition of DE3 support, registers macros are reworked so
> > they take base address as parameter.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > [rebased]
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> This patch mostly checks out. But see below.
> 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 406c42e752d7..020b0a097c84
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > @@ -29,20 +29,24 @@
> > 
> >  #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE                BIT(0)
> > 
> > -#define SUN8I_MIXER_BLEND_PIPE_CTL             0x1000
> > -#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)       (0x1004 + 0x10 * (x) +
> > 0x0)
> > -#define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)       (0x1004 + 0x10 * (x) +
> > 0x4)
> > -#define SUN8I_MIXER_BLEND_ATTR_COORD(x)                (0x1004 + 0x10 *
> > (x) + 0x8) -#define SUN8I_MIXER_BLEND_ROUTE                        0x1080
> > -#define SUN8I_MIXER_BLEND_PREMULTIPLY          0x1084
> > -#define SUN8I_MIXER_BLEND_BKCOLOR              0x1088
> > -#define SUN8I_MIXER_BLEND_OUTSIZE              0x108c
> > -#define SUN8I_MIXER_BLEND_MODE(x)              (0x1090 + 0x04 * (x))
> > -#define SUN8I_MIXER_BLEND_CK_CTL               0x10b0
> > -#define SUN8I_MIXER_BLEND_CK_CFG               0x10b4
> > -#define SUN8I_MIXER_BLEND_CK_MAX(x)            (0x10c0 + 0x04 * (x))
> > -#define SUN8I_MIXER_BLEND_CK_MIN(x)            (0x10e0 + 0x04 * (x))
> > -#define SUN8I_MIXER_BLEND_OUTCTL               0x10fc
> > +#define DE2_BLD_BASE                           0x1000
> > +#define DE2_CH_BASE                            0x2000
> > +#define DE2_CH_SIZE                            0x1000
> > +
> > +#define SUN8I_MIXER_BLEND_PIPE_CTL(base)       ((base) + 0)
> > +#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x) ((base) + 0x4 + 0x10 *
> > (x))
> > +#define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x) ((base) + 0x8 + 0x10 *
> > (x))
> > +#define SUN8I_MIXER_BLEND_ATTR_COORD(base, x)  ((base) + 0xC + 0x10 *
> > (x))
> 
> Nit: Use lowercase for '0xC' to be consistent.
> 
> > +#define SUN8I_MIXER_BLEND_ROUTE(base)          ((base) + 0x80)
> > +#define SUN8I_MIXER_BLEND_PREMULTIPLY(base)    ((base) + 0x84)
> > +#define SUN8I_MIXER_BLEND_BKCOLOR(base)                ((base) + 0x88)
> > +#define SUN8I_MIXER_BLEND_OUTSIZE(base)                ((base) + 0x8c)
> > +#define SUN8I_MIXER_BLEND_MODE(base, x)                ((base) + 0x90 +
> > 0x04 * (x)) +#define SUN8I_MIXER_BLEND_CK_CTL(base)         ((base) +
> > 0xb0)
> > +#define SUN8I_MIXER_BLEND_CK_CFG(base)         ((base) + 0xb4)
> > +#define SUN8I_MIXER_BLEND_CK_MAX(base, x)      ((base) + 0xc0 + 0x04 *
> > (x)) +#define SUN8I_MIXER_BLEND_CK_MIN(base, x)      ((base) + 0xe0 +
> > 0x04 * (x)) +#define SUN8I_MIXER_BLEND_OUTCTL(base)         ((base) +
> > 0xfc)
> > 
> >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK      GENMASK(12, 8)
> >  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)    BIT(8 + pipe)
> 
> [...]
> 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c index
> > 6bb2aa164c8e..c68eab8a748f 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> > @@ -10,6 +10,7 @@
> > 
> >   */
> >  
> >  #include "sun8i_ui_scaler.h"
> > 
> > +#include "sun8i_vi_scaler.h"
> > 
> >  static const u32 lan2coefftab16[240] = {
> >  
> >         0x00004000, 0x00033ffe, 0x00063efc, 0x000a3bfb,
> > 
> > @@ -88,6 +89,14 @@ static const u32 lan2coefftab16[240] = {
> > 
> >         0x0b1c1603, 0x0d1c1502, 0x0e1d1401, 0x0f1d1301,
> >  
> >  };
> > 
> > +static inline u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int
> > channel)
> I recently saw a review comment stating one should not inline functions
> unless they are defined in header files. Otherwise the decision should
> be left up to the compiler.
> 
> > +{
> > +       int vi_num = mixer->cfg->vi_num;
> > +
> > +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * vi_num +
> > +              DE2_UI_SCALER_SIZE * (channel - vi_num);
> > +}
> > +
> > 
> >  static int sun8i_ui_scaler_coef_index(unsigned int step)
> >  {
> >  
> >         unsigned int scale, int_part, float_part;
> 
> [...]
> 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c index
> > d3f1acb234b7..8697afc36023 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> > @@ -833,6 +833,11 @@ static const u32 bicubic4coefftab32[480] = {
> > 
> >         0x1012110d, 0x1012110d, 0x1013110c, 0x1013110c,
> >  
> >  };
> > 
> > +static inline u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int
> > channel) +{
> > +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * channel;
> > +}
> > +
> 
> This one as well.
> 
> >  static int sun8i_vi_scaler_coef_index(unsigned int step)
> >  {
> >  
> >         unsigned int scale, int_part, float_part;
> > 
> > @@ -857,7 +862,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int
> > step)> 
> >         }
> >  
> >  }
> > 
> > -static void sun8i_vi_scaler_set_coeff(struct regmap *map, int layer,
> > +static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
> > 
> >                                       u32 hstep, u32 vstep,
> >                                       const struct drm_format_info
> >                                       *format)
> 
> This is the only instance where a function's "layer" parameter was changed
> to "base". It would be nice if it were consistent.

Why not? Caller already have base address calculated, so it poses no overhead. 
Additionally, sun8i_vi_scaler_set_coeff() doesn't have struct sun8i_mixer 
*mixer parameter, which would allow calculating base address based on layer 
id. So, you can chose between existing variant or adding additional parameter 
for no real reason.

Best regards,
Jernej



