Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25B9ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DCF21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DCF21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeIVS0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:26:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43727 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeIVS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:26:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id u23so3639759edx.10;
        Sat, 22 Sep 2018 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QXc5E2LJMqUQghDIyQrukN2LaDLszgwLIgxiLGdI9I=;
        b=T3sauA5mo3CeSgvSzt3BJORZIYg/xRB1vVVobuW6INQVUzgo055A822qN7eVGagDdB
         5ytVCD7n5uASsRUiXwfRnK3x69peTE9rsw/dAmebeKHichiMhLMib6uRPNf6UOL7fRWn
         N4eDB2X4ipnK8vXkG+TGdO/WFXBmMRy+vYaZigC+jGRkBByLf1O43Tn9+Tcjw5cVDp4i
         r559VSvOe/zopdZZrFHHNMVtpDNlD/IBG2I2twPhJifa/bl8fnhgxYMCO0oBqWrz00O1
         TlikhPNTd0FZfMFNaB9Y/+k6Z3X+GZfMQF1GtT9TcskB3OmW29+cGjQF0dZw8mfGAdDl
         FX3g==
X-Gm-Message-State: ABuFfojz6an2cVAZz39mWld2LvhdwsBaFmMqzv6GLpty23+S0vWDd6fB
        H6Sf1Bx+7OKTiDmUuY2ZbKE7c4ZketI=
X-Google-Smtp-Source: ANB0VdYIkfaVDh3vH5eyjeR4rj5jNfFVfL5hhqewVj+ezl1VxZr5bJtPRh1qx4yH5Hd1S8qVrVsZpQ==
X-Received: by 2002:aa7:de1a:: with SMTP id h26-v6mr3686998edv.100.1537619564115;
        Sat, 22 Sep 2018 05:32:44 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id z30-v6sm3589535edb.4.2018.09.22.05.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 05:32:43 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id y8-v6so11647511wrh.7;
        Sat, 22 Sep 2018 05:32:43 -0700 (PDT)
X-Received: by 2002:adf:df0f:: with SMTP id y15-v6mr1702532wrl.26.1537619563184;
 Sat, 22 Sep 2018 05:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-12-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-12-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 20:32:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v67jweJ5OdSzKhj302OLbz7DacKmSGMKS536uquzKGZtAQ@mail.gmail.com>
Message-ID: <CAGb2v67jweJ5OdSzKhj302OLbz7DacKmSGMKS536uquzKGZtAQ@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Most, if not all, registers found in DE2 still exists in DE3. However,
> units are on different base addresses.
>
> To prepare for addition of DE3 support, registers macros are reworked so
> they take base address as parameter.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> [rebased]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This patch mostly checks out. But see below.


> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> index 406c42e752d7..020b0a097c84 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -29,20 +29,24 @@
>
>  #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE                BIT(0)
>
> -#define SUN8I_MIXER_BLEND_PIPE_CTL             0x1000
> -#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)       (0x1004 + 0x10 * (x) + 0x0)
> -#define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)       (0x1004 + 0x10 * (x) + 0x4)
> -#define SUN8I_MIXER_BLEND_ATTR_COORD(x)                (0x1004 + 0x10 * (x) + 0x8)
> -#define SUN8I_MIXER_BLEND_ROUTE                        0x1080
> -#define SUN8I_MIXER_BLEND_PREMULTIPLY          0x1084
> -#define SUN8I_MIXER_BLEND_BKCOLOR              0x1088
> -#define SUN8I_MIXER_BLEND_OUTSIZE              0x108c
> -#define SUN8I_MIXER_BLEND_MODE(x)              (0x1090 + 0x04 * (x))
> -#define SUN8I_MIXER_BLEND_CK_CTL               0x10b0
> -#define SUN8I_MIXER_BLEND_CK_CFG               0x10b4
> -#define SUN8I_MIXER_BLEND_CK_MAX(x)            (0x10c0 + 0x04 * (x))
> -#define SUN8I_MIXER_BLEND_CK_MIN(x)            (0x10e0 + 0x04 * (x))
> -#define SUN8I_MIXER_BLEND_OUTCTL               0x10fc
> +#define DE2_BLD_BASE                           0x1000
> +#define DE2_CH_BASE                            0x2000
> +#define DE2_CH_SIZE                            0x1000
> +
> +#define SUN8I_MIXER_BLEND_PIPE_CTL(base)       ((base) + 0)
> +#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x) ((base) + 0x4 + 0x10 * (x))
> +#define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x) ((base) + 0x8 + 0x10 * (x))
> +#define SUN8I_MIXER_BLEND_ATTR_COORD(base, x)  ((base) + 0xC + 0x10 * (x))

Nit: Use lowercase for '0xC' to be consistent.

> +#define SUN8I_MIXER_BLEND_ROUTE(base)          ((base) + 0x80)
> +#define SUN8I_MIXER_BLEND_PREMULTIPLY(base)    ((base) + 0x84)
> +#define SUN8I_MIXER_BLEND_BKCOLOR(base)                ((base) + 0x88)
> +#define SUN8I_MIXER_BLEND_OUTSIZE(base)                ((base) + 0x8c)
> +#define SUN8I_MIXER_BLEND_MODE(base, x)                ((base) + 0x90 + 0x04 * (x))
> +#define SUN8I_MIXER_BLEND_CK_CTL(base)         ((base) + 0xb0)
> +#define SUN8I_MIXER_BLEND_CK_CFG(base)         ((base) + 0xb4)
> +#define SUN8I_MIXER_BLEND_CK_MAX(base, x)      ((base) + 0xc0 + 0x04 * (x))
> +#define SUN8I_MIXER_BLEND_CK_MIN(base, x)      ((base) + 0xe0 + 0x04 * (x))
> +#define SUN8I_MIXER_BLEND_OUTCTL(base)         ((base) + 0xfc)
>
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK      GENMASK(12, 8)
>  #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)    BIT(8 + pipe)

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> index 6bb2aa164c8e..c68eab8a748f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include "sun8i_ui_scaler.h"
> +#include "sun8i_vi_scaler.h"
>
>  static const u32 lan2coefftab16[240] = {
>         0x00004000, 0x00033ffe, 0x00063efc, 0x000a3bfb,
> @@ -88,6 +89,14 @@ static const u32 lan2coefftab16[240] = {
>         0x0b1c1603, 0x0d1c1502, 0x0e1d1401, 0x0f1d1301,
>  };
>
> +static inline u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int channel)

I recently saw a review comment stating one should not inline functions
unless they are defined in header files. Otherwise the decision should
be left up to the compiler.

> +{
> +       int vi_num = mixer->cfg->vi_num;
> +
> +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * vi_num +
> +              DE2_UI_SCALER_SIZE * (channel - vi_num);
> +}
> +
>  static int sun8i_ui_scaler_coef_index(unsigned int step)
>  {
>         unsigned int scale, int_part, float_part;

[...]

> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> index d3f1acb234b7..8697afc36023 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> @@ -833,6 +833,11 @@ static const u32 bicubic4coefftab32[480] = {
>         0x1012110d, 0x1012110d, 0x1013110c, 0x1013110c,
>  };
>
> +static inline u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int channel)
> +{
> +       return DE2_VI_SCALER_BASE + DE2_VI_SCALER_SIZE * channel;
> +}
> +

This one as well.

>  static int sun8i_vi_scaler_coef_index(unsigned int step)
>  {
>         unsigned int scale, int_part, float_part;
> @@ -857,7 +862,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int step)
>         }
>  }
>
> -static void sun8i_vi_scaler_set_coeff(struct regmap *map, int layer,
> +static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
>                                       u32 hstep, u32 vstep,
>                                       const struct drm_format_info *format)

This is the only instance where a function's "layer" parameter was changed
to "base". It would be nice if it were consistent.

ChenYu
