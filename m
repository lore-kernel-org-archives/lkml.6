Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6064B20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I66K8b2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbeLQIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:08:06 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44386 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeLQIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:08:05 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so4090265uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 00:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuTPdcTZsmfjTvIAZxgYtNpoCpjJPm6ixeiYdUiAvKk=;
        b=I66K8b2H5tC521pfh9q1nXpopTwnHQduKLY7abjA7izf4npnmD6RuBFVMu/n3cYQ8u
         UQ2WARqGDqis5aes9gP+P1vOF5w02h+P/2O7re5AkyQhBtAMAKhwb5P4Im37Td6rVDql
         D4DPaFq3vLAXlP+rO0T35m5dPg6AgaIRRVD3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuTPdcTZsmfjTvIAZxgYtNpoCpjJPm6ixeiYdUiAvKk=;
        b=Gcc2oqeUQTNCkxXRDlFXMu+9N/6K+TlC2ao+3/wIIzZcJ2dNQO5840WURiZMXwsri6
         Gc3HuXnyBHvHFY4LeQ+xLzoza35dHgCnrkJCroBa8U71BFA7P8Coyf5zJ7xPxQMiPgR2
         AzTdrg3nHg2rDG8UHHsMa+ID9HriPj5eiLv9JYvJasOaGt7yPxNFgGcEI7AJrvGtyOTQ
         w0CkwgwfLqSR3MlFfVqL/7VCx3LkmRbv5nBnHJlK+t7r8ep1rj+XW7mSch1gxhMAKUS/
         yaUxT8FLp2XYJgb6wKlPM5N8yKUK+Ow0g+YLBL7fluUg87zmJk4OQc3WkjpT+c9O3wV2
         VOfw==
X-Gm-Message-State: AA+aEWaiYPV07Ptf/kTIu3Q+o1MbMw0vbLwKGD/h+eLE8vM0Bwsn4o3i
        dGVYWG9RaCNuTS5Lud3BWlAKfeCNysj/yo6Rjlk1Ng==
X-Google-Smtp-Source: AFSGD/Vi0siMpy49iuvUFHnQmBzMJwcETaMhLnL2ALt3H3Vz71mS/Yf6Urp4wGRd8YBuwrRND0ps6E0LLFMzm8Xjdds=
X-Received: by 2002:ab0:526:: with SMTP id 35mr5826217uax.25.1545034084207;
 Mon, 17 Dec 2018 00:08:04 -0800 (PST)
MIME-Version: 1.0
References: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 09:07:28 +0100
Message-ID: <CAPDyKFppX9wxUyBycNLTinP8nNVV9wt5M70XWODVZmeVAvAVHw@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 21:25, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Some of the SDMMC pads auto calibration values parsed from
> devicetree are assigned incorrectly. This patch fixes it.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for fixes and added a fixes tag, thanks!

Fixes: 51b77c8ea784 ("mmc: tegra: Program pad autocal offsets from dt")

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7b95d088fdef..e6ace31e2a41 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -510,25 +510,25 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
> -                       &autocal->pull_up_3v3);
> +                       &autocal->pull_up_3v3_timeout);
>         if (err)
>                 autocal->pull_up_3v3_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
> -                       &autocal->pull_down_3v3);
> +                       &autocal->pull_down_3v3_timeout);
>         if (err)
>                 autocal->pull_down_3v3_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
> -                       &autocal->pull_up_1v8);
> +                       &autocal->pull_up_1v8_timeout);
>         if (err)
>                 autocal->pull_up_1v8_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
> -                       &autocal->pull_down_1v8);
> +                       &autocal->pull_down_1v8_timeout);
>         if (err)
>                 autocal->pull_down_1v8_timeout = 0;
>
> --
> 2.7.4
>
