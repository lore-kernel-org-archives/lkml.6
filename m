Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B9B222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892991;
	bh=AKkS36lH1paxJiK/GEwJDWufneUPwfbNc7PQw0AXkbM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k+V5GVcyh2r/PrYMB0CR4ZK76Qg3ya3uHdAX+zQf7FjHUNQK9lQ2IL77PTrJNGdmg
	 tWrJY3tak0MDSB0vsn+7H3gaaqzDGrtNG77ZvV9ALxzk7J8kpcLxIjLhOdPLiW8oQ4
	 7CaDGWnYr+J2274J1RR75HTcbwyZQKUoxGa7srdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfBKNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfBKNtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:49:49 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35701222AA;
        Mon, 11 Feb 2019 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892988;
        bh=AKkS36lH1paxJiK/GEwJDWufneUPwfbNc7PQw0AXkbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=co1Frrhvh1Dm4h60iIb7/oEisWn0q0RKmuU2HeR7vltoZvTf4/BN3oDtAgK01snyz
         GwlrW2MRA8XceUQJ6IXM5rJ3yNk2C6iUWROwam94dEQQ4X/y4Z2kxAmJSe/JVcgCBe
         rn9mPNM0PyaojqMJABL4zeda1LSA7Kl6fkEakv8k=
Received: by mail-lj1-f169.google.com with SMTP id z25-v6so8784724ljk.7;
        Mon, 11 Feb 2019 05:49:48 -0800 (PST)
X-Gm-Message-State: AHQUAubb/x4Sio/dTd1go4S9RB44CMx3VVhffrHwtagUSg79XsOG6lFE
        Jqp30uRvcXUiaAdznAJ7B7SSZRx8m+xVTJWuOvE=
X-Google-Smtp-Source: AHgI3IYZABqg+rE+90eHN6Xanvlf3LqVsluqcq3RPmG+ZIp6pxAxKvzNJlgP9S7d8J2vK7diCTyWuVzLoCSaglk5G4s=
X-Received: by 2002:a2e:80cf:: with SMTP id r15-v6mr549629ljg.183.1549892986399;
 Mon, 11 Feb 2019 05:49:46 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170138epcas2p31134b2beee877922d27fab5c79fdc7b1@epcas2p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-16-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-16-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:49:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf1P3zH6b+uRMWEvcPL0K6Ufsgb4S5ZH6ndAHDiDFyiqQ@mail.gmail.com>
Message-ID: <CAJKOXPf1P3zH6b+uRMWEvcPL0K6Ufsgb4S5ZH6ndAHDiDFyiqQ@mail.gmail.com>
Subject: Re: [PATCH 15/22] ASoC: samsung: i2s: Move quirks data to common
 driver data structure
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
> The quirk flags are common for the primary and the secondary DAI
> so move respective field from struct i2s_dai to common driver data
> structure.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 6ea0f0050fc8..e11d678e9c1f 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -84,7 +84,6 @@ struct i2s_dai {
>         struct snd_dmaengine_dai_dma_data dma_capture;
>         struct snd_dmaengine_dai_dma_data idma_playback;
>         dma_filter_fn filter;
> -       u32     quirks;
>
>         struct samsung_i2s_priv *priv;
>  };
> @@ -122,19 +121,13 @@ struct samsung_i2s_priv {
>         u32 suspend_i2spsr;
>
>         const struct samsung_i2s_variant_regs *variant_regs;
> +       u32 quirks;
>
>         /* The clock provider's data */
>         struct clk *clk_table[3];
>         struct clk_onecell_data clk_data;
>  };
>
> -struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
> -{
> -       struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
> -
> -       return &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
> -}
> -
>  /* Returns true if this is the 'overlay' stereo DAI */
>  static inline bool is_secondary(struct i2s_dai *i2s)
>  {
> @@ -343,7 +336,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
>  {
>         struct samsung_i2s_priv *priv = i2s->priv;
>         u32 mod = readl(priv->addr + I2SMOD);
> -       int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
> +       int tdm = priv->quirks & QUIRK_SUPPORTS_TDM;
>         int bfs_shift = priv->variant_regs->bfs_off;
>
>         /* Non-TDM I2S controllers do not support BCLK > 48 * FS */
> @@ -563,7 +556,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
>         case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
>                 mask = 1 << i2s_regs->rclksrc_off;
>
> -               if ((i2s->quirks & QUIRK_NO_MUXPSR)
> +               if ((priv->quirks & QUIRK_NO_MUXPSR)
>                                 || (clk_id == SAMSUNG_I2S_RCLKSRC_0))
>                         clk_id = 0;
>                 else
> @@ -830,8 +823,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>
>  /* We set constraints on the substream acc to the version of I2S */
>  static int i2s_startup(struct snd_pcm_substream *substream,
> -         struct snd_soc_dai *dai)
> +       struct snd_soc_dai *dai)

This change looks unrelated.

For the rest:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
