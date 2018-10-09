Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DCC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1B421479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtbqbBwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1B421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJIOqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:46:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40316 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJIOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:46:42 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so1198307iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8cKqTBQoCYuAot5+2FN79uavVggtUfCck3TZFEVkmmU=;
        b=KtbqbBwpCI3ccfyedIYaj1aJ2f+L2BOMVL7yeDbmGaKztnLQHCD29EIFdWEEitnouE
         WqlithFu1qgPk0AfmU9VppRq3plfJnQsZibkK8//znBUd+C+4aV5b7klEihY3XBmlRDJ
         fnAuaaTU2fFPa97/csBvw6MLKthRJzp4o/9Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8cKqTBQoCYuAot5+2FN79uavVggtUfCck3TZFEVkmmU=;
        b=k9m/IoJsf1m33Qo5QFCqpXeQfC8Hu173bQjCA75hmLgJuLswsc/QDHzN67Megk7me3
         SvTxd5blEoRiZSSy39X7xZcc+pmaLa1d7MticXSVtLdJRVkU4eihvrawbUkDEOIir9xm
         OY1RipyvXpJTSxFaXNqj81TZ5zjjprISvBefQWTgqyCKVqqoGbP1QvkYD3A1ku1qD244
         wm4gzAKIDyyIMwJYcAOMpv/I3gAGDuVoR8LxiYYmlNlr68GNlu889QtZykYCNwtdV7Tj
         5Ia63LSOoGqQ1DkycUkuAT+t1HgSl7I9RVZLI7rJTT3ngmEi2V24EHaQk64iDjZ87mPv
         HPpg==
X-Gm-Message-State: ABuFfojBQVFKPaayPFDAwDGlOgiT6RNkUn/EsBZNvsZc/Y2zMqZTPjhx
        G5jznWv9Vx/I2oydK/1c2rLEz/EgjWW3sOgesBj32Q==
X-Google-Smtp-Source: ACcGV62l17hkLz3LDB6n1k7owJf526X3ufq7hdhX3ZCGo9A5xv/K1b8tC4UjKGUL+7jzwvQoL7eawFktzDvQgzKmmXA=
X-Received: by 2002:a24:4795:: with SMTP id t143-v6mr837538itb.78.1539070267683;
 Tue, 09 Oct 2018 00:31:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 9 Oct 2018 00:30:27 -0700 (PDT)
In-Reply-To: <20181004111451.9539-6-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-6-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Oct 2018 09:30:27 +0200
Message-ID: <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
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
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on TI's AM654 devices.
>
> Therefore, add a new compatible, AM654 specific quirks
> and a new AM654 specific set_clock function which
> configures the PHY in a sane way.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c9e3e050ccc8..142c4b802f31 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -231,6 +231,25 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>  }
>
> +static void sdhci_arasan_am654_set_clock(struct sdhci_host *host,
> +                                        unsigned int clock)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (sdhci_arasan->is_phy_on) {
> +               phy_power_off(sdhci_arasan->phy);
> +               sdhci_arasan->is_phy_on = false;
> +       }
> +
> +       sdhci_set_clock(host, clock);
> +
> +       if (clock > PHY_CLK_TOO_SLOW_HZ) {
> +               phy_power_on(sdhci_arasan->phy);
> +               sdhci_arasan->is_phy_on = true;
> +       }
> +}
> +
>  static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                         struct mmc_ios *ios)
>  {
> @@ -316,6 +335,29 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
>         .pdata = &sdhci_arasan_pdata,
>  };
>
> +static const struct sdhci_ops sdhci_arasan_am654_ops = {
> +       .set_clock = sdhci_arasan_am654_set_clock,
> +       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +       .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_arasan_reset,
> +       .set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_arasan_am654_pdata = {
> +       .ops = &sdhci_arasan_am654_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN  |
> +                 SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +                 SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +                  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> +};
> +
> +static const struct sdhci_arasan_of_data sdhci_arasan_am654_data = {
> +       .pdata = &sdhci_arasan_am654_pdata,
> +};
> +
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  {
>         int cmd_error = 0;
> @@ -478,6 +520,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "rockchip,rk3399-sdhci-5.1",
>                 .data = &sdhci_arasan_rk3399_data,
>         },
> +       {
> +               .compatible = "ti,am654-sdhci-5.1",
> +               .data = &sdhci_arasan_am654_data,
> +       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> --
> 2.18.0
>
