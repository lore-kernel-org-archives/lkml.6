Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF76222B1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893487;
	bh=APdrdY/3ASpHFFt5Wc2BeZlw8lAumoJt1K4LzeeFQ/Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NALYsfQlJkRr0jF4ui6UFw4VVDtVxJwpy/azs5NYFYk+5H6eAZqXalJroLaBgaXy5
	 kXC4TO6WvB53IQRDZxuV9fAlBfYesrT96SCahSVQv4GJZwfhQkFcxPJ0SelpuClOHk
	 zNEszUS0thNuvsSVGC6xD0cz6tsGFLQVnbyqp9dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfBKN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:58:05 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86C9C222B3;
        Mon, 11 Feb 2019 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549893483;
        bh=APdrdY/3ASpHFFt5Wc2BeZlw8lAumoJt1K4LzeeFQ/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4fgLwr0kQf40biPhmee7VlB4VclNBFVaHtlq8TUA972I7znZrLww7LPOhqYLv0uF
         oN8xFXjdd/cXYxn/GQe29lHszRoOp+c783rCa51hKJmOmHXsamy/jbmcq5oOKPEGJi
         8xCj0Gt7QtSQC1Je7NZkEYjAw7w2pplCj3ioxfig=
Received: by mail-lj1-f170.google.com with SMTP id r10-v6so8838626ljj.4;
        Mon, 11 Feb 2019 05:58:03 -0800 (PST)
X-Gm-Message-State: AHQUAuYi5mZ6KcEs2EEIY51PWp2hZnyOG37Gagz78zdZL9dI0j4VxFa9
        48f33/yBnuxAFEDf+vhcVfllPNSL7m9dqXPjyoA=
X-Google-Smtp-Source: AHgI3IZ5Gt4XTcW31JjY6S7s+KN93O/LFZbdJGvPmjebc7CbwxwSvsCnoTGkE0NYXtd6K5TCeohf89FA8mCF89RU8V4=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr18866581lja.19.1549893481654;
 Mon, 11 Feb 2019 05:58:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170145epcas1p465da0715aa629b525c17d263c1b49a68@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-18-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-18-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:57:50 +0100
X-Gmail-Original-Message-ID: <CAJKOXPehfWHW+Mj=xZ_N+LA7nLUnOvHAwqEmBECquzVSx1ppPQ@mail.gmail.com>
Message-ID: <CAJKOXPehfWHW+Mj=xZ_N+LA7nLUnOvHAwqEmBECquzVSx1ppPQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] ASoC: samsung: odroid: Add support for secondary
 CPU DAI
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> This patch adds DPCM links in order to support the secondary I2S interface.
> For the secondary PCM interface to be actually available one more entry
> should be added to the sound-dai property in sound/cpu node in DT.
> The changes in driver are done in a way so we are backwards compatible with
> existing DTS/DTB, i.e. if the cpu sound-dai property contains only one entry
> only one PCM will be registered.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/odroid.c | 132 +++++++++++++++++++++++++++----------
>  1 file changed, 96 insertions(+), 36 deletions(-)
>
> diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
> index e7b371b07230..bab61e8278a0 100644
> --- a/sound/soc/samsung/odroid.c
> +++ b/sound/soc/samsung/odroid.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/module.h>
> @@ -17,21 +18,24 @@
>
>  struct odroid_priv {
>         struct snd_soc_card card;
> -       struct snd_soc_dai_link dai_link;
> -
>         struct clk *clk_i2s_bus;
>         struct clk *sclk_i2s;
>  };
>
> -static int odroid_card_startup(struct snd_pcm_substream *substream)
> +static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
>  {
>         struct snd_pcm_runtime *runtime = substream->runtime;
>
>         snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
> +
>         return 0;
>  }
>
> -static int odroid_card_hw_params(struct snd_pcm_substream *substream,
> +static const struct snd_soc_ops odroid_card_fe_ops = {
> +       .startup = odroid_card_fe_startup,
> +};
> +
> +static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
>                                       struct snd_pcm_hw_params *params)
>  {
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
> @@ -86,19 +90,56 @@ static int odroid_card_hw_params(struct snd_pcm_substream *substream,
>         return 0;
>  }
>
> -static const struct snd_soc_ops odroid_card_ops = {
> -       .startup = odroid_card_startup,
> -       .hw_params = odroid_card_hw_params,
> +static const struct snd_soc_ops odroid_card_be_ops = {
> +       .hw_params = odroid_card_be_hw_params,
> +};
> +
> +static struct snd_soc_dai_link odroid_card_dais[] = {
> +       {
> +               /* Primary FE <-> BE link */
> +               .codec_name = "snd-soc-dummy",
> +               .codec_dai_name = "snd-soc-dummy-dai",
> +               .ops = &odroid_card_fe_ops,
> +               .name = "Primary",
> +               .stream_name = "Primary",
> +               .platform_name = "3830000.i2s",

Why exposing address as platform_name? I think it is not used so how
about some friendlier name?

> +               .dynamic = 1,
> +               .dpcm_playback = 1,
> +       }, {
> +               /* BE <-> CODECs link */
> +               .name = "I2S Mixer",
> +               .cpu_name = "snd-soc-dummy",
> +               .cpu_dai_name = "snd-soc-dummy-dai",
> +               .platform_name = "snd-soc-dummy",
> +               .ops = &odroid_card_be_ops,
> +               .no_pcm = 1,
> +               .dpcm_playback = 1,
> +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +                               SND_SOC_DAIFMT_CBS_CFS,
> +       }, {
> +               /* Secondary FE <-> BE link */
> +               .playback_only = 1,
> +               .codec_name = "snd-soc-dummy",
> +               .codec_dai_name = "snd-soc-dummy-dai",
> +               .ops = &odroid_card_fe_ops,
> +               .name = "Secondary",
> +               .stream_name = "Secondary",
> +               .platform_name = "samsung-i2s-sec",
> +               .dynamic = 1,
> +               .dpcm_playback = 1,
> +       }
>  };
>
> +

Unneeded new line.

Best regards,
Krzysztof
