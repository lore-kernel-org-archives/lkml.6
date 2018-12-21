Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D52C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31BD21924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeLUQsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:48:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLUQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:48:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so5174430edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqqCdnbZYBpsITc5EMAHVafk34rmCvV3c1syI8YgPPY=;
        b=FG4m2GTxcy7iUPZkCxjfPGE5PqoKrA4m4XcpaIq+BhVm9fuO+IUcHalvicaQpMjzdO
         2AoIJl3o8DK4TkjMv5LJKXK7A+IzEMMfZLPLVPd9/owEN0OGQc38m+BtIgLCtq0lpvhk
         esQyOJ40QS20vZ35jK99L97NnTHHwsyin9CVPn3G/PAYAxrAOBatqFQ4+cLGEcFGKeCW
         7B4ig1QF2oh5tQfHA9CgMKmIAhRkobpXtScb4a+r68iNzWNJQZrD5bSR0yXpYYIWawGX
         t2pRg5Wpada9CtQLxkaKqdqR9FEjiANR1MTMT+nxcGPV3RVp5Q8c18tenpp+HNu1+XMg
         Z5Hw==
X-Gm-Message-State: AA+aEWZC6ON2Plbbu3NQY9yZ9kX4XDJ9dC/Uo+RsrxGDQKPiklhKhP4w
        6MMNXaN0+2E4LgNZC7hIKO0Lu+fgSfY=
X-Google-Smtp-Source: AFSGD/U8qL7Tp9PiPMRlUh43GGXJwBjeJ6Sd+HiE8G+K1Kqkj4QkbotKthQ9HQS9L/CQhtaeO9oZog==
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr2851651edp.173.1545410931771;
        Fri, 21 Dec 2018 08:48:51 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id j8sm7195825ede.55.2018.12.21.08.48.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:48:51 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id m22so6368041wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:48:51 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id c134mr3475663wmh.124.1545410931063;
 Fri, 21 Dec 2018 08:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-4-codekipper@gmail.com>
In-Reply-To: <20181221152110.17982-4-codekipper@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Dec 2018 00:48:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
Message-ID: <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
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
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample for the earlier SoCs.
>
> Newer SoCs can also handle 32bit samples.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 80bf29e0cc86..adb988ae9ac5 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>         case 16:
>                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 break;
> +       case 20:
> +       case 24:
> +       case 32:
> +               width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +               break;
>         default:
>                 dev_err(dai->dev, "Unsupported physical sample width: %d\n",
>                         params_physical_width(params));
> @@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>                 sr = 0;
>                 wss = 0;
>                 break;
> -
> +       case 20:
> +               sr = 1;
> +               wss = 1;
> +               break;
> +       case 24:
> +               sr = 2;
> +               wss = 2;
> +               break;
> +       case 32:
> +               sr = 4;
> +               wss = 4;
> +               break;
>         default:
>                 dev_err(dai->dev, "Unsupported sample width: %d\n",
>                         params_width(params));
> @@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
>         return 0;
>  }
>
> +#define SUN4I_FORMATS  (SNDRV_PCM_FMTBIT_S16_LE | \
> +                        SNDRV_PCM_FMTBIT_S20_3LE | \
> +                        SNDRV_PCM_FMTBIT_S24_LE)

IIRC SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24
are different things, in regards to how the sample is aligned in a 4 byte
space. Have you checked that things actually work as expected? This was
something that did not work using SNDRV_PCM_FMTBIT_S24_LE on sun4i-codec.

> +
> +#define SUN8I_FORMATS  (SUN4I_FORMATS | \
> +                        SNDRV_PCM_FMTBIT_S32_LE)
> +
>  static struct snd_soc_dai_driver sun4i_i2s_dai = {
>         .probe = sun4i_i2s_dai_probe,
>         .capture = {
> @@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
>                 .channels_min = 2,
>                 .channels_max = 2,
>                 .rates = SNDRV_PCM_RATE_8000_192000,
> -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> +               .formats = SUN4I_FORMATS,
>         },
>         .playback = {
>                 .stream_name = "Playback",
>                 .channels_min = 2,
>                 .channels_max = 2,
>                 .rates = SNDRV_PCM_RATE_8000_192000,
> -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> +               .formats = SUN4I_FORMATS,
>         },
>         .ops = &sun4i_i2s_dai_ops,
>         .symmetric_rates = 1,
> @@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>         i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
>         i2s->capture_dma_data.maxburst = 8;
>
> +       soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> +                              sizeof(*soc_dai), GFP_KERNEL);
> +       if (!soc_dai) {
> +               ret = -ENOMEM;
> +               goto err_pm_disable;
> +       }
> +
> +       if (i2s->variant->has_fmt_set_lrck_period) {

This condition deserves a comment, particularly as to why you use it
in place of having a separate quirk field to represent 32 bit support.

Regards
ChenYu

> +               soc_dai->playback.formats = SUN8I_FORMATS;
> +               soc_dai->capture.formats = SUN8I_FORMATS;
> +       }
> +
>         pm_runtime_enable(&pdev->dev);
>         if (!pm_runtime_enabled(&pdev->dev)) {
>                 ret = sun4i_i2s_runtime_resume(&pdev->dev);
> --
> 2.20.1
>
