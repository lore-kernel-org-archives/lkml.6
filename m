Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C3D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQp+v2CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfA1VQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:16:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35831 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA1VQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:16:01 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so10679762vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOWZi8WDscFORR5TiqTg0jfh/8SxjXI1RRBYhheUJAk=;
        b=AQp+v2CJPS3M86L/8dh/3LpqF/uoJMIxcIKq7qfdJl57sv69oP4C3Dl17mr2s0VLIW
         jfHdpmiAtB0KPssie1IzhOKAWBZsoQOQnrGqv8cn6WALbYmQkvGySlcMmr8FyGdxu+pn
         wtNkbDVwEcEO4255bLtJ3FqKOeFYMesR+sZog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOWZi8WDscFORR5TiqTg0jfh/8SxjXI1RRBYhheUJAk=;
        b=g/zp7zD0TdNxCLVuye6D930cpa062TVc6BqUbyaFx5tGdTx7zI14+64OVP8uLY3LWj
         vwDl32S4aoFTAd1/CLi1yn1MBDXLUXLyZEAI6xlXUis8GbZYfn/4/LogU7tfJe/ngk4K
         vZTO9x82wk0j6HY1sGXuBPLALHHXPrROEkA6DI5I62Hn359/0f78UfkZfgjNktiIvOV8
         O1vjiHkj4KE2Dx6dFwNnayVS3zQGTP6NaSyg8H7bI5ZU7OYcppXLG6eqFizYPpFL1KW4
         49Cjm0YCZjiRGVl1OcXrxt6LxxDjt13ebl69LQ6EMPm5N1xz3j+i4j+TO3w+tCD1Gyu/
         yDtA==
X-Gm-Message-State: AJcUukfHXgERWKDdMXzv4n65a2ckL2ZL4FVuCRqR053e1LtLRXyKLTex
        lUKGyjujT9JbbF4/mudQHWZHl+ani6la9W8/TsMF1Q==
X-Google-Smtp-Source: ALg8bN4EU+x/ol6qZ8nv5c7gzwZQPGD8aPEroafnbqlFDu4IAQzxlTOWIC/ZOSGAkZKHVlcIRgcjsBGyo9QaOWPu8a0=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr9631601vsi.191.1548710159707;
 Mon, 28 Jan 2019 13:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128144119.10092-1-martink@posteo.de>
In-Reply-To: <20190128144119.10092-1-martink@posteo.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jan 2019 22:15:23 +0100
Message-ID: <CAPDyKFo7949rcxEX5U2QUS0c2xhC_z+JGeOiF2HC6+QukVpEaQ@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
To:     Martin Kepplinger <martink@posteo.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 at 15:41, Martin Kepplinger <martink@posteo.de> wrote:
>
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 WL1271 wifi controllers on imx28.
>
> While the wifi's vmmc-supply regulator can be configured in devicetree,
> "ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
> to hangs when loading firmware, for example.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>
>
> revision history
> ----------------
> v4: re-added forgotten regulator_enable() during probe
> v3: improve API usage as suggested by Ulf
> v2: tested patch with changes suggested by Robin
> v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in
>
>
>  drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..23d275269d61 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 host->bus_width = 0;
>
> +       switch (ios->power_mode) {
> +       case MMC_POWER_OFF:
> +               if (!IS_ERR(host->mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc,
> +                                             host->mmc->supply.vmmc, 0);
> +               break;
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(host->mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(host->mmc,
> +                                             host->mmc->supply.vmmc,
> +                                             ios->vdd);
> +               break;
> +       default:
> +               break;
> +       }
> +
>         if (ios->clock)
>                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct mmc_host *mmc;
>         struct resource *iores;
>         int ret = 0, irq_err;
> -       struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
>
>         irq_err = platform_get_irq(pdev, 0);
> @@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host->mmc = mmc;
>         host->sdio_irq_en = 0;
>
> -       reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> -       if (!IS_ERR(reg_vmmc)) {
> -               ret = regulator_enable(reg_vmmc);
> -               if (ret) {
> -                       dev_err(&pdev->dev,
> -                               "Failed to enable vmmc regulator: %d\n", ret);
> -                       goto out_mmc_free;
> -               }
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret == -EPROBE_DEFER)
> +               goto out_mmc_free;
> +
> +       ret = regulator_enable(mmc->supply.vmmc);

This is wrong, as it may cause the regulator usage count to become
wrongly balanced.

Instead, via ->set_ios() when calling mmc_regulator_set_ocr(), it will
take care of enabling and disabling the regulator depending of the
requested vdd voltage level.

> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "Failed to enable vmmc regulator: %d\n", ret);
> +               goto out_mmc_free;
>         }
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.20.1
>

BTW, you didn't really answer my earlier question about the TI WiFi
chip. Doesn't you need a special clock for WiFi chip as well? How do
you intend to manage that?

Kind regards
Uffe
