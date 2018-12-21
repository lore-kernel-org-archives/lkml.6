Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C721924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbeLUQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:55:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32886 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLUQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:55:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so5217931eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xply796OrFTbPbKOInlOGea+sluCH6NYMVhwCZIZIu4=;
        b=dtJq5Wz0sC3Ro9uEPbY7jC27h9wJyhUKl69fROmfqAGNJKNArI9z4A7cfs2Rwvxy56
         oWoZjuuPwGug6dnW3rgaG88zoC1UV7hPgp1SSiAN79XjhNGE88fng6XoRAzrXLAbQopd
         fSTdv+F74lBDL2c7N+GMcU0+fuVHghi/Ata0qyDPeb4qbGQQnslv7USH23R/OvFM+CEn
         ztJYlhd4RwqU4z4XmAyvX4F0h2Ld0lMQyWySdx+OE5IWgATpn/YBtymQDgDTAiElE+W9
         aU0flEvUKM2KQCuFP3uFfpM3xtYw38XRO3DT0Kf//tG6x5exkFfB2hZ/lzVtyba3txTv
         FLtg==
X-Gm-Message-State: AA+aEWaH6Xi69XFZ/Q+LknGbiT7UZ4bQj6Eb29ne0o6633sFkAFVMRA2
        8LbBqf2n5lZE/5nrQYc3PnqJtTWwSXo=
X-Google-Smtp-Source: AFSGD/WDPLbdptvvmWtmzTKcn5lee8OocycS2F/Wd415pdyEKVQB1azK5+N/nII2y3dxSqWfu1aZAQ==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr2816715edr.256.1545411299870;
        Fri, 21 Dec 2018 08:54:59 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id w31sm7092428edw.82.2018.12.21.08.54.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:54:59 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id x10so5943952wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:54:59 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr3535599wrv.188.1545411299075;
 Fri, 21 Dec 2018 08:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-5-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-5-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Dec 2018 00:54:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
Message-ID: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>
> From: Marcus Cooper <codekipper@gmail.com>
>
> Also add offset to RX channel select
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Commit log seems a bit lacking. You could probably explain how you
found this, either when comparing datasheet macros, or some actual
error manifested and you "heard" it. You could also state what the
fixed outcome should be.

Also please add a fixes tag.

The RX channel select offset should be added as a separate patch,
also with an explanation on how you found this missing, and a fixes
tag.

ChenYu

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index adb988ae9ac5..93a484d7e228 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -110,7 +110,7 @@
>
>  #define SUN8I_I2S_TX_CHAN_MAP_REG      0x44
>  #define SUN8I_I2S_TX_CHAN_SEL_REG      0x34
> -#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 11)
> +#define SUN8I_I2S_TX_CHAN_OFFSET_MASK          GENMASK(13, 12)
>  #define SUN8I_I2S_TX_CHAN_OFFSET(offset)       (offset << 12)
>  #define SUN8I_I2S_TX_CHAN_EN_MASK              GENMASK(11, 4)
>  #define SUN8I_I2S_TX_CHAN_EN(num_chan)         (((1 << num_chan) - 1) << 4)
> @@ -482,6 +482,10 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                 regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>                                    SUN8I_I2S_TX_CHAN_OFFSET_MASK,
>                                    SUN8I_I2S_TX_CHAN_OFFSET(offset));
> +
> +               regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET_MASK,
> +                                  SUN8I_I2S_TX_CHAN_OFFSET(offset));
>         }
>
>         regmap_field_write(i2s->field_fmt_mode, val);
> --
> 2.20.1
>
