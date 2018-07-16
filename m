Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE05208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaK6lya1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE05208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGPKh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:37:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39861 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbeGPKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:37:56 -0400
Received: by mail-io0-f196.google.com with SMTP id e13-v6so37236768iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9q1WaT/2V+uxn0Yztk64P6o3fEZdTOj0JElUDP6oULs=;
        b=AaK6lya1U9rZEcQ2ORk4hlQJ2aScX4U+VK3M1Ywys0m8Dhdup81bOwxR6e7J5/Dxpj
         CB/pJQ/DULTHtnYF9ekBkonRyVrcveWf3zeup61VyctGWJp/ZhHfxEDk1lWgydka8agg
         02Crs67KJiw0hWy8b1oRl5m6jReBDPRAuQXfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9q1WaT/2V+uxn0Yztk64P6o3fEZdTOj0JElUDP6oULs=;
        b=LFVAbd09Jjzh1XULtS1tdAt8GTmU/8722axGwOeN3tFk/UJVknF88jMT94J+kCSlEm
         sgzZrn/Dbz/ksvhd+TmQubEmX0tNKlJQrR75sw+Smf0Lv/n7hNyA1PYJUTjN+WZW1qQu
         eV1IVCmQ38F/xz5aR+8Ao9lkZWwvrvXAsfePdyz9oyIk1BaKR/5PO7w9E7+by5gNF3MK
         e8JuFJPPbU5jY08GaTbSb69RrQtR8fAJTa/VXk1CNpouLBZ/MLujyO0iJjRZ66Y1sUPa
         96Kx5xR9gDr1psa0WjMd8F1QaJ0FN2tDvodKFCjge9mx/RF+BHDttx76rLFNNmcvZmzJ
         9D+w==
X-Gm-Message-State: AOUpUlHeGXQMAdSRHZEvjJSIfQk6VlT9G8+N+LhjWTDSy66J+O0VqklQ
        QWEj4bG9LXj+chw/DQn/XZWFmzkiwBEok5G3gkwcBA==
X-Google-Smtp-Source: AAOMgpfxZ47HjznYHTUzvOPekrUBTfSd4/Y2QPJSK/IqW8Y8B8Uc6g20zw3+CtsXMmCmxgbcjQtnTYdr56o3OhOllO0=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr40392167iof.266.1531735875254;
 Mon, 16 Jul 2018 03:11:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:11:14
 -0700 (PDT)
In-Reply-To: <20180712073904.4705-1-stefan@agner.ch>
References: <20180712073904.4705-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jul 2018 12:11:14 +0200
Message-ID: <CAPDyKFq=zPvoCHUbeCSCdZAj7BWkuJxe9xRruwhkV1WK8WA61w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: tegra: prevent HS200 on Tegra 3
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 July 2018 at 09:39, Stefan Agner <stefan@agner.ch> wrote:
> The stack assumes that SDHC controller which support SD3.0 (SDR104) do
> support HS200. This is not the case for Tegra 3, which does support SD
> 3.0
> but only supports eMMC spec 4.41.
>
> Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
> support HS200.
>
> Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
> the tie between SD3.0 (SDR104) and HS200. I don't think that this is
> necessarly true. It is fully legitimate to support SD3.0 and not support
> HS200. The quirk naming suggests something is broken in the controller,
> but this is not the case: The controller simply does not support HS200.
>
> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied all three patches for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 970d38f68939..137df06b9b6e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>                   SDHCI_QUIRK_NO_HISPD_BIT |
>                   SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_BROKEN_HS200,
>         .ops  = &tegra_sdhci_ops,
>  };
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
