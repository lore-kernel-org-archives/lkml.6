Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A101C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E86E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TY/k+Lo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfA1MDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:03:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42942 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfA1MDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:03:35 -0500
Received: by mail-ua1-f67.google.com with SMTP id d21so5481008uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZI2rJhuRCzGYru6LjGYY0vfB1SqN0M1XOhW5Tz6Lk7A=;
        b=TY/k+Lo2IT512g2KVK6WNcKuxdLu7t6HKvs5zFdh5aIuPIbX5hufcmX6gnggjMU2mc
         3EDo31d+L8eaBno1DclQucQSHfkN+YYV4Ni4Ii0pvyKVs8wtx228ZO8CHU3IJvLuxUCe
         ytoXK7ROGSMn5j7m8gc7NyPDN5TnbnBVxZvB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZI2rJhuRCzGYru6LjGYY0vfB1SqN0M1XOhW5Tz6Lk7A=;
        b=VmhBnopiAUo7sIk/XuN1CLUdwc3WiYP85GET3MOVjokOO9o5+UiQUuqsg2YEiSj2dV
         qXjE3FqbCAPCiYE9lX7l3hAXx7vTRUvjnH8y59TeqhJF8AwBIk6xE/SerTrRNkdVCvF0
         Oi4cGxehk3Iuatqhup2js9t/UMC5goLodrOiOsuiSoGtvv3P4tYiRMaPY6Pkw1vHTrm9
         oI/MOxF2gAwI6ehInHTX6EG+M3sHFcipaujsIE9HYBrAIki9XiYFM/lB7wa32O1nfTu9
         l46lz9tFXAIwRXsuiei49NBrEo00U86yuC+oYl5eQDJMYK59RC+NRHtS9S7DSfJgVmQX
         dT1g==
X-Gm-Message-State: AJcUukcHPkrgdenkmhUBmm0dlNuC9rHnGY5HpYtlTvc5wB+EN+CdCO3g
        a2hZUiCI7xyvtr2blr/R5482C4Phc3Ws8Mfgf+U3dg==
X-Google-Smtp-Source: ALg8bN6XI4demFBgig4UHhPOh5qkV8Re9J+zxw8EG0fTzF7hG1NU894ECURbakMPtUmPnbLG6nHMDkO5YWlTep9Vp1U=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr8936571uar.39.1548677014331;
 Mon, 28 Jan 2019 04:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20190125200927.21045-1-paul@crapouillou.net>
In-Reply-To: <20190125200927.21045-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jan 2019 13:02:58 +0100
Message-ID: <CAPDyKFrkq4GQbCbcJFqeERt3y41VJ7we+eL9NziPf2Obe+yGkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: jz4740: Remove platform data and use standard APIs
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        DTML <devicetree@vger.kernel.org>, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 at 21:09, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Drop the custom code to get the 'cd' and 'wp' GPIOs. The driver now
> calls mmc_of_parse() which will init these from devicetree or
> device properties.
>
> Also drop the custom code to get the 'power' GPIO. The MMC core
> provides us with the means to power the MMC card through an external
> regulator.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Should I also pick up the other two MIPS patches or you want to funnel
those through the MIPS soc tree?

Kind regards
Uffe

> ---
>  drivers/mmc/host/jz4740_mmc.c | 71 +++++++++----------------------------------
>  1 file changed, 14 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 33215d66afa2..e41c7230815f 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -21,7 +21,6 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -36,7 +35,6 @@
>  #include <asm/cacheflush.h>
>
>  #include <asm/mach-jz4740/dma.h>
> -#include <asm/mach-jz4740/jz4740_mmc.h>
>
>  #define JZ_REG_MMC_STRPCL      0x00
>  #define JZ_REG_MMC_STATUS      0x04
> @@ -148,9 +146,7 @@ enum jz4780_cookie {
>  struct jz4740_mmc_host {
>         struct mmc_host *mmc;
>         struct platform_device *pdev;
> -       struct jz4740_mmc_platform_data *pdata;
>         struct clk *clk;
> -       struct gpio_desc *power;
>
>         enum jz4740_mmc_version version;
>
> @@ -894,16 +890,16 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         switch (ios->power_mode) {
>         case MMC_POWER_UP:
>                 jz4740_mmc_reset(host);
> -               if (host->power)
> -                       gpiod_set_value(host->power, 1);
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>                 host->cmdat |= JZ_MMC_CMDAT_INIT;
>                 clk_prepare_enable(host->clk);
>                 break;
>         case MMC_POWER_ON:
>                 break;
>         default:
> -               if (host->power)
> -                       gpiod_set_value(host->power, 0);
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>                 clk_disable_unprepare(host->clk);
>                 break;
>         }
> @@ -936,38 +932,6 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
>         .enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
>  };
>
> -static int jz4740_mmc_request_gpios(struct jz4740_mmc_host *host,
> -                                   struct mmc_host *mmc,
> -                                   struct platform_device *pdev)
> -{
> -       struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -       int ret = 0;
> -
> -       if (!pdata)
> -               return 0;
> -
> -       if (!pdata->card_detect_active_low)
> -               mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> -       if (!pdata->read_only_active_low)
> -               mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> -
> -       /*
> -        * Get optional card detect and write protect GPIOs,
> -        * only back out on probe deferral.
> -        */
> -       ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
> -       if (ret == -EPROBE_DEFER)
> -               return ret;
> -
> -       ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
> -       if (ret == -EPROBE_DEFER)
> -               return ret;
> -
> -       host->power = devm_gpiod_get_optional(&pdev->dev, "power",
> -                                             GPIOD_OUT_HIGH);
> -       return PTR_ERR_OR_ZERO(host->power);
> -}
> -
>  static const struct of_device_id jz4740_mmc_of_match[] = {
>         { .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
>         { .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
> @@ -982,9 +946,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         struct mmc_host *mmc;
>         struct jz4740_mmc_host *host;
>         const struct of_device_id *match;
> -       struct jz4740_mmc_platform_data *pdata;
> -
> -       pdata = dev_get_platdata(&pdev->dev);
>
>         mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
>         if (!mmc) {
> @@ -993,29 +954,25 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         }
>
>         host = mmc_priv(mmc);
> -       host->pdata = pdata;
>
>         match = of_match_device(jz4740_mmc_of_match, &pdev->dev);
>         if (match) {
>                 host->version = (enum jz4740_mmc_version)match->data;
> -               ret = mmc_of_parse(mmc);
> -               if (ret) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&pdev->dev,
> -                                       "could not parse of data: %d\n", ret);
> -                       goto err_free_host;
> -               }
>         } else {
>                 /* JZ4740 should be the only one using legacy probe */
>                 host->version = JZ_MMC_JZ4740;
> -               mmc->caps |= MMC_CAP_SDIO_IRQ;
> -               if (!(pdata && pdata->data_1bit))
> -                       mmc->caps |= MMC_CAP_4_BIT_DATA;
> -               ret = jz4740_mmc_request_gpios(host, mmc, pdev);
> -               if (ret)
> -                       goto err_free_host;
>         }
>
> +       ret = mmc_of_parse(mmc);
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev,
> +                               "could not parse device properties: %d\n", ret);
> +               goto err_free_host;
> +       }
> +
> +       mmc_regulator_get_supply(mmc);
> +
>         host->irq = platform_get_irq(pdev, 0);
>         if (host->irq < 0) {
>                 ret = host->irq;
> --
> 2.11.0
>
