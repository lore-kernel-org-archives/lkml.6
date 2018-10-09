Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C0C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922DF204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMkUUPVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922DF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJIOqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:46:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35865 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeJIOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:46:37 -0400
Received: by mail-io1-f68.google.com with SMTP id p4-v6so432599iom.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8wFr2rKofUpUFAw6Yx32gh7f9LNBxOaex9mp8MbwOV4=;
        b=PMkUUPVoUyPA3FuPZRxv/gjEnhJr3UCUtCwd3JLDBn5mfMYI8dN+XnyF7khalnzAOO
         ifrTz4KGBNGQJOktoHQiez3EIbU7Gy9YVrXcfqf9Fm50nGcgWqcinLrz0Zsux06PlCDH
         4zpVgdpt9QZRv7XhTm1T9y3o2CjDhVrsSci/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8wFr2rKofUpUFAw6Yx32gh7f9LNBxOaex9mp8MbwOV4=;
        b=dFrlh5hzippW0tm/e3pRgqcWBQS1Fe6W/BJmAHA7nMaMbm/ee2KUu0t9CiTiBYeElu
         +dlNZ2jQr7R2x1SUWUup4Lou/MGiveQPA/O+V3gzUhxGHGLdEa5Mnj7PCFABYI+aLRah
         xnKGZlsLaqGkLv/VqEGNGCJae9Q4yBtH2K76fx5IRm2t3wBzybh0cR1rbdoFvv/YEGN/
         rL6+egeubXGZj8q63N5fDYyDy0khEnCkWz0wn3x/suPTbDJJUxcZmmiLm1ScLFCxkIOq
         OFiqFdLrJkh3hIhPcFTWeQLJGQpcZo5IZzb/jCQSvgSqpt1xaSM+iY/ghjyDeiZ0FvQp
         03sA==
X-Gm-Message-State: ABuFfohS7hM2sY8H5ZaRvmzxegE9M0kH7Qq7osGhitYM5Re7Bd69x+Hn
        rMnt/2OE+2z/xavQncO3f+qQU+4ALIO8vmsozsrUxw==
X-Google-Smtp-Source: ACcGV62biH+0Bzrus8ye57npiUhh0lzx8GgzHHDFvONIexWdW+SgKDVAd8FWcAqgV7Ax7bpSfMkFGXZRQ+IUmROlOe4=
X-Received: by 2002:a6b:8fcb:: with SMTP id r194-v6mr7407163iod.266.1539070262624;
 Tue, 09 Oct 2018 00:31:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 00:30:22 -0700 (PDT)
In-Reply-To: <20181004111451.9539-5-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-5-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 09:30:22 +0200
Message-ID: <CAPDyKFq4YMAj5m6o26-dV5UHasg668GSk+SdhR7LQrEs5r582Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] mmc: sdhci-of-arasan: Add a single data structure to
 incorporate pdata and soc_ctl_map
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Currently, the driver passes platform data as a global structure
> and uses the .data of of_device_id to pass the soc_ctl_map. To
> make the implementation more flexible add a single data structure
> that incorporates both of the above and pass it in the .data of
> of_device_id.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 47 ++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b806b24a3e5f..c9e3e050ccc8 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -107,6 +107,11 @@ struct sdhci_arasan_data {
>  #define SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE BIT(1)
>  };
>
> +struct sdhci_arasan_of_data {
> +       const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +       const struct sdhci_pltfm_data *pdata;
> +};
> +
>  static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>         .baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
>         .clockmultiplier = { .reg = 0xf02c, .width = 8, .shift = 0},
> @@ -307,6 +312,10 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>                         SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>
> +static struct sdhci_arasan_of_data sdhci_arasan_data = {
> +       .pdata = &sdhci_arasan_pdata,
> +};
> +
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>         int cmd_error = 0;
> @@ -363,6 +372,11 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> +       .soc_ctl_map = &rk3399_soc_ctl_map,
> +       .pdata = &sdhci_arasan_cqe_pdata,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -462,14 +476,21 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>         /* SoC-specific compatible strings w/ soc_ctl_map */
>         {
>                 .compatible = "rockchip,rk3399-sdhci-5.1",
> -               .data = &rk3399_soc_ctl_map,
> +               .data = &sdhci_arasan_rk3399_data,
>         },
> -
>         /* Generic compatible below here */
> -       { .compatible = "arasan,sdhci-8.9a" },
> -       { .compatible = "arasan,sdhci-5.1" },
> -       { .compatible = "arasan,sdhci-4.9a" },
> -
> +       {
> +               .compatible = "arasan,sdhci-8.9a",
> +               .data = &sdhci_arasan_data,
> +       },
> +       {
> +               .compatible = "arasan,sdhci-5.1",
> +               .data = &sdhci_arasan_data,
> +       },
> +       {
> +               .compatible = "arasan,sdhci-4.9a",
> +               .data = &sdhci_arasan_data,
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> @@ -707,14 +728,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_arasan_data *sdhci_arasan;
>         struct device_node *np = pdev->dev.of_node;
> -       const struct sdhci_pltfm_data *pdata;
> -
> -       if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-5.1"))
> -               pdata = &sdhci_arasan_cqe_pdata;
> -       else
> -               pdata = &sdhci_arasan_pdata;
> +       const struct sdhci_arasan_of_data *data;
>
> -       host = sdhci_pltfm_init(pdev, pdata, sizeof(*sdhci_arasan));
> +       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> +       data = match->data;
> +       host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
>
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
> @@ -723,8 +741,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>         sdhci_arasan->host = host;
>
> -       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> -       sdhci_arasan->soc_ctl_map = match->data;
> +       sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
>
>         node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
>         if (node) {
> --
> 2.18.0
>
