Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BF4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A3F21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892482;
	bh=O88otfgmGvF353fRKVh0SE4IUSHi6BiVxTwC9NLN65I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TIR+b7gbj09UXBks0W6GD9I08DZfE/NpSkp7YaLX6lpifTomwZu0vLYpCkOP8/tlq
	 PMnvhUuRBDP0Y0v5oOiqFQft8kDunNfM04gtY4DPSXKqpahKR0UJ79aRXkx1/NKw7n
	 jukKGKnxUYF5NegBeHGrnzqeZGgktmL4kTaOWl8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfBKNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKNlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:41:20 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5405021B69;
        Mon, 11 Feb 2019 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892478;
        bh=O88otfgmGvF353fRKVh0SE4IUSHi6BiVxTwC9NLN65I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2adBvqQWN4/SedRubB0DS+HZT2SOHbZ5hNBAf9NV64d1pLW1bxryV1DiX18iWoJM6
         BMQPQMcpOBHR1nMOr44y+VAZoD4T76IOSRmHQQCzC70HEvnmXmtG5hZEqS/h7IXcnH
         0czKVq30FHYAIHHnX8CfupIQaS00xd+FEwHZV93M=
Received: by mail-lf1-f48.google.com with SMTP id g2so2475266lfh.11;
        Mon, 11 Feb 2019 05:41:18 -0800 (PST)
X-Gm-Message-State: AHQUAuYPI8MQZJCfgBRmR6z5y2/Yd1YLUynO7Ecp9oPRG0KgSZQ9nb30
        HHy9dCG1q98lWqwit1KPqGtLRg/GlXrrWNatZ7Y=
X-Google-Smtp-Source: AHgI3IZH/rVRHAobRarN6DSgi0ecbz9+kdeC4QyYDBl0xWB7mleQUd/myhVltasOdMtc9F4OiRGEJGanjAdvhO/zgQQ=
X-Received: by 2002:a19:d83:: with SMTP id 125mr6313205lfn.159.1549892475362;
 Mon, 11 Feb 2019 05:41:15 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170105epcas1p3d4a1da9ae268f8e95b32fb499e5a1dad@epcas1p3.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-7-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-7-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:41:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfTZ1EGUpL_Zg20iWYJFkoCvEhoQSM=f92N-NJwo1LsNg@mail.gmail.com>
Message-ID: <CAJKOXPfTZ1EGUpL_Zg20iWYJFkoCvEhoQSM=f92N-NJwo1LsNg@mail.gmail.com>
Subject: Re: [PATCH 06/22] ASoC: samsung: i2s: Restore support for the
 secondary PCM
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
> This patch introduces again registration of additional platform device as
> we still need it for registering the secondary dmaengine PCM component.
>
> This patch in most part is a revert of changes done in commit
> be2c92eb64023e ("ASoC: samsung: i2s: Remove virtual device for secondary DAI")
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 52 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 4bc3b181f1c2..994dcd4b01fb 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -109,6 +109,7 @@ static DEFINE_SPINLOCK(lock);
>
>  struct samsung_i2s_priv {
>         struct platform_device *pdev;
> +       struct platform_device *pdev_sec;
>
>         /* Spinlock protecting access to the device's registers */
>         spinlock_t spinlock;
> @@ -1312,6 +1313,34 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
>         return ret;
>  }
>
> +/* Create platform device for the secondary PCM */
> +static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
> +       if (!pdev)
> +               return -ENOMEM;
> +
> +       ret = device_attach(&pdev->dev);
> +       if (ret < 0) {
> +               dev_info(&pdev->dev, "device_attach() failed\n");
> +               return ret;
> +       }
> +
> +       priv->pdev_sec = pdev;
> +
> +       return 0;
> +}
> +
> +static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
> +{
> +       if (priv->pdev_sec) {
> +               platform_device_del(priv->pdev_sec);
> +               priv->pdev_sec = NULL;
> +       }
> +}
>  static int samsung_i2s_probe(struct platform_device *pdev)
>  {
>         struct i2s_dai *pri_dai, *sec_dai = NULL;
> @@ -1329,13 +1358,15 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>                 i2s_dai_data = (struct samsung_i2s_dai_data *)
>                                 platform_get_device_id(pdev)->driver_data;
>
> +       /* Nothing to do if it is the secondary device probing */
> +       if (!i2s_dai_data)
> +               return 0;
> +
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
>         quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
> -       quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
> -
>         num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
>         priv->pdev = pdev;
>
> @@ -1425,8 +1456,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>                 sec_dai->pri_dai = pri_dai;
>                 pri_dai->sec_dai = sec_dai;
>
> -               ret = samsung_asoc_dma_platform_register(&pdev->dev,
> -                                       sec_dai->filter, "tx-sec", NULL, NULL);
> +               ret = i2s_create_secondary_device(priv);
> +               if (ret < 0)
> +                       goto err_disable_clk;
> +
> +               ret = samsung_asoc_dma_platform_register(&priv->pdev_sec->dev,
> +                                               sec_dai->filter, "tx-sec", NULL,
> +                                               &pdev->dev);
>                 if (ret < 0)
>                         goto err_disable_clk;
>
> @@ -1461,6 +1497,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>  err_disable_clk:
>         clk_disable_unprepare(pri_dai->clk);
> +       i2s_delete_secondary_device(priv);
>         return ret;
>  }
>
> @@ -1469,12 +1506,16 @@ static int samsung_i2s_remove(struct platform_device *pdev)
>         struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
>         struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
>
> +       if (!priv)

This is not obvious. Maybe comment that it is secondary device remove()?

> +               return 0;
> +
>         pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
>         i2s_unregister_clock_provider(pdev);
>         clk_disable_unprepare(pri_dai->clk);
>         pm_runtime_put_noidle(&pdev->dev);
> +       i2s_delete_secondary_device(priv);
>
>         return 0;
>  }
> @@ -1573,6 +1614,9 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
>                 .name           = "samsung-i2s",
>                 .driver_data    = (kernel_ulong_t)&i2sv3_dai_type,
>         },
> +       {

Nit - squash with previous line.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
