Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3AC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739C3222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550045204;
	bh=uJ6ERBBAaKgiMg3BzCBksU/zrO6HHVX3jfIbEBPhst8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jbW1MWBHUowyybOneTiK+fHJzhW8uUdgvVCc+j1eEfvCmv3rtMQgOrws2LWJRh8Tz
	 aXarxKutG1fyATCzc+Dmr6dYOVh93pFEFzLsH/gu7j/21zw8yfO7uB/l8DD4uAgkVA
	 0+w0bUFh/29tYkInje4XeJE15Ohdmiga74wNTk9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbfBMIGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbfBMIGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:06:40 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03782222C7;
        Wed, 13 Feb 2019 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550045199;
        bh=uJ6ERBBAaKgiMg3BzCBksU/zrO6HHVX3jfIbEBPhst8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xLUI88zSWg14yqcQYnjKeAmVKtrPvwzH4CM48Zk1JtRAV8Qktz7+G5sQ+yNUsMRx4
         PwyEvy8byFXSjGb1TET56ugtELbCdAOId1K442LbiqK0xK8nM1G/9a90A30Kbc7RGF
         XwY1GmT+eLlcy4cg4/X32wOLQUYfGzfRuP8RytB8=
Received: by mail-lj1-f171.google.com with SMTP id j13-v6so1207294ljc.2;
        Wed, 13 Feb 2019 00:06:38 -0800 (PST)
X-Gm-Message-State: AHQUAuYrjCXiwJv/iAu5V25utDEgjysTeSRznH6c8TRO/bdu1CI2qBrA
        4glOOQcsYU9iXYY14b74xHyMriimlW3NwX3jrgo=
X-Google-Smtp-Source: AHgI3IY8k/euccyBiOh/b4aqRdlcqPv5Dn5ObMy3tm7jcqxtPHPF8c1UZAKfBBN8SoOJ2rLDuMVfCtWLSRGIT2tOeLw=
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr4869483lja.184.1550045197122;
 Wed, 13 Feb 2019 00:06:37 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0@epcas2p2.samsung.com>
 <20190212180342.32040-1-s.nawrocki@samsung.com> <20190212180342.32040-19-s.nawrocki@samsung.com>
In-Reply-To: <20190212180342.32040-19-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 13 Feb 2019 09:06:25 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeSYf8bHNSnpvK1X=cCV=_JxzN_bKdvN9a+RCEqBfK3hQ@mail.gmail.com>
Message-ID: <CAJKOXPeSYf8bHNSnpvK1X=cCV=_JxzN_bKdvN9a+RCEqBfK3hQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] ASoC: samsung: i2s: Comments clean up
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

On Tue, 12 Feb 2019 at 19:05, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Spelling error fixes, upper/lower case letter changes.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index debeaf51cc7e..77c0f70beab1 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1,5 +1,4 @@
> -/* sound/soc/samsung/i2s.c
> - *
> +/*
>   * ALSA SoC Audio Layer - Samsung I2S Controller driver
>   *
>   * Copyright (c) 2010 Samsung Electronics Co. Ltd.
> @@ -61,10 +60,10 @@ struct i2s_dai {
>         /* Platform device for this DAI */
>         struct platform_device *pdev;
>
> -       /* Frame Clock */
> +       /* Frame clock */
>         unsigned frmclk;
>         /*
> -        * Specifically requested RCLK,BCLK by MACHINE Driver.
> +        * Specifically requested RCLK, BCLK by machine driver.
>          * 0 indicates CPU driver is free to choose any value.
>          */
>         unsigned rfs, bfs;
> @@ -72,8 +71,9 @@ struct i2s_dai {
>         struct i2s_dai *pri_dai;
>         /* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
>         struct i2s_dai *sec_dai;
> -#define DAI_OPENED     (1 << 0) /* Dai is opened */
> -#define DAI_MANAGER    (1 << 1) /* Dai is the manager */
> +
> +#define DAI_OPENED     (1 << 0) /* DAI is opened */
> +#define DAI_MANAGER    (1 << 1) /* DAI is the manager */
>         unsigned mode;
>
>         /* Driver for this DAI */
> @@ -98,7 +98,7 @@ struct samsung_i2s_priv {
>         /* Spinlock protecting access to the device's registers */
>         spinlock_t lock;
>
> -       /* Lock for cross i/f checks */
> +       /* Lock for cross interface checks */
>         spinlock_t pcm_lock;
>
>         /* CPU DAIs and their corresponding drivers */
> @@ -309,7 +309,7 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
>         writel(mod, priv->addr + I2SMOD);
>  }
>
> -/* Read Bit-Clock of I2S (in multiples of LRCLK) */
> +/* Read bit-clock of I2S (in multiples of LRCLK) */
>  static inline unsigned get_bfs(struct i2s_dai *i2s)
>  {
>         struct samsung_i2s_priv *priv = i2s->priv;
> @@ -331,7 +331,7 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
>         }
>  }
>
> -/* Write Bit-Clock of I2S (in multiples of LRCLK) */
> +/* Write bit-clock of I2S (in multiples of LRCLK) */
>  static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
>  {
>         struct samsung_i2s_priv *priv = i2s->priv;
> @@ -383,7 +383,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
>         writel(mod, priv->addr + I2SMOD);
>  }
>
> -/* Sample-Size */
> +/* Sample size */
>  static inline int get_blc(struct i2s_dai *i2s)
>  {
>         int blc = readl(i2s->priv->addr + I2SMOD);
> @@ -397,7 +397,7 @@ static inline int get_blc(struct i2s_dai *i2s)
>         }
>  }
>
> -/* TX Channel Control */
> +/* TX channel control */
>  static void i2s_txctrl(struct i2s_dai *i2s, int on)
>  {
>         struct samsung_i2s_priv *priv = i2s->priv;
> @@ -742,7 +742,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>         switch (params_channels(params)) {
>         case 6:
>                 val |= MOD_DC2_EN;
> -               /* fall through */
> +               /* Fall through */

Just to be sure - did you check whether this passes GCC
-Wimplicit-fallthrough=3 (you need GCC v7)? It looks correct - like
one of accepted patterns
(https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html).

Rest looks good so:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
