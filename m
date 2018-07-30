Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ADCFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E08C20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlmjH/xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E08C20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeG3QlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:41:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50398 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeG3QlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:24 -0400
Received: by mail-it0-f65.google.com with SMTP id g191-v6so6635789ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HL76Jryv+IQKJBL8H2qCz74spSCaYqrw2l0Y21FmJyU=;
        b=BlmjH/xyNEKgHPVMh3MBUkBTBZSIla+XqBLiIkjAc4dOnJCnfU5FrnI+pfzFIVWqCd
         xhoOVoTgYEkKBOZTG31l0fJb4mdhxVLGDU9g6lD5eWXsmfpxfspaatEPTAs43+8ZHHjo
         6wdhlhlOBODuHoxvN7bKDoWdJZAf5uvLiI/dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HL76Jryv+IQKJBL8H2qCz74spSCaYqrw2l0Y21FmJyU=;
        b=So5Kh/NEuzZa/RTTtfxsvfZOcLzdG1Ri2UCpRJcXdqBOsZ5TpU7FwLLDbKllEMA/hZ
         YyRO1fC9LIqxTnBQceXlj8tSq2N6Ro3FkWKbTsb0BVByFu8rftyiTLT0yue+9pYRAlaV
         dLA3FojOPOZuZ0oU1y1yFgnrM3EDb2GYiDKQSfzVqDKrFNTcY60+gX/xrL1ld0MZrjgk
         JjUnR+tzbWwie8qBrgy3NStvQNvSFR0MoPCtYNsBc0uVhB82K8h2RF8S/fIR8xHRLqrv
         SV7vEITuortodsB0Z8U5q0gThivdZ1NxfTq+QUQdsElq1qDGcu9Z3B803nTM7BsV7Kg2
         plOg==
X-Gm-Message-State: AOUpUlH3EJu1cZiAyl4+HID7JPb9onp6g2xxMmZ0mRmxkdGYWwSunGF0
        lAeM8YTanTzYs4zqu1SbKe4JNzP2bxmtRtYg6u4LKA==
X-Google-Smtp-Source: AAOMgpcBcAr7iaHoK72I/KcB3nsZ1Wx6B0eO+SgJUbVZMCd6aqQfL74Jc/glcR4V1oKhWh8UySM2127gvThEvhDEb3o=
X-Received: by 2002:a24:4524:: with SMTP id y36-v6mr1539652ita.97.1532963159764;
 Mon, 30 Jul 2018 08:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:05:59
 -0700 (PDT)
In-Reply-To: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
References: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:05:59 +0200
Message-ID: <CAPDyKFoRtSH6Run5WE-iyPgFOjxanNtHq6QtR007_KcW5Ld3=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: Force correct divider calculation on DDR50/52
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 16:34, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Tegra SDHCI controllers require the SDHCI clock divider to be configured
> to divide the clock by two in DDR50/52 modes. Incorrectly configured
> clock divider results in corrupted data.
>
> Prevent the possibility of incorrectly calculating the divider value due
> to clock rate rounding or low parent clock frequency by not assigning
> host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().
>
> See the comments for further details.
>
> Fixes: a8e326a ("mmc: tegra: implement module external clock change")
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index ddf00166..908b23e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (!clock)
>                 return sdhci_set_clock(host, clock);
>
> +       /*
> +        * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
> +        * divider to be configured to divided the host clock by two. The SDHCI
> +        * clock divider is calculated as part of sdhci_set_clock() by
> +        * sdhci_calc_clk(). The divider is calculated from host->max_clk and
> +        * the requested clock rate.
> +        *
> +        * By setting the host->max_clk to clock * 2 the divider calculation
> +        * will always result in the correct value for DDR50/52 modes,
> +        * regardless of clock rate rounding, which may happen if the value
> +        * from clk_get_rate() is used.
> +        */
>         host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>         clk_set_rate(pltfm_host->clk, host_clk);
> -       host->max_clk = clk_get_rate(pltfm_host->clk);
> +       if (tegra_host->ddr_signaling)
> +               host->max_clk = host_clk;
> +       else
> +               host->max_clk = clk_get_rate(pltfm_host->clk);
>
>         sdhci_set_clock(host, clock);
>
> --
> 2.7.4
>
