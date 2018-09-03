Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55236C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E220652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdkXMHSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8E220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeICKdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:33:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33881 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeICKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:33:02 -0400
Received: by mail-io0-f195.google.com with SMTP id c22-v6so15060033iob.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=We7LNafJy+Vt3sjW2KFoQGF5khqUR7daFFGymTNei7Y=;
        b=PdkXMHSLD7r+dFnK/A/FRL6FJj44IMJjPoFbz0DGVdpEUiiNJcbD2wLbzxlYDa4WeK
         U+iLS1nqodELWcs3XEFBY7XzShBUZ085UEVoGTHLurSFR040gdVZ7wT6jKEK/xduimd2
         FPthft25PJXwANoPBNXQrISjYaX2eDvLTmQNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=We7LNafJy+Vt3sjW2KFoQGF5khqUR7daFFGymTNei7Y=;
        b=uBKWyW1PhV7108r6cEgLGyRysNPlkljQh8QdVa9Izj554/isDNuy+AmJ4M4/xQ2SRx
         7t8pqjlXzFaMMYrS/lX4arDGkfKK++kn8a7JC8WQ9jN0XmVOkuxiEVZdeCssA9zwPcxq
         9U0O5RXnxGG4BZOLyOxRDbUW7uvIxthNXEW9fZ92o1zaU+c/ZcCjFb6VUsefVGmqwEOz
         465Lv4YLskR+JCnzauGFI1HIyGhSEgY+N1zJuz/rgIidBkAu8/AgswOyUgKHwb4H9foE
         s7FqRS8kDU3C4GTJohvwL6+bWrnqzCLN7R0cXGnk273hG1N4SHefuk4S4JDyyS9pZaee
         pw3Q==
X-Gm-Message-State: APzg51ARsuGV2yzHNsbvJgO6lYS7Phu8josmcQeejS8cC0IeCm3EjVYU
        UouAFlR/r/yWCsQatv/wPMl6s20Ocm32ne8w08lcSw==
X-Google-Smtp-Source: ANB0VdZQAMdUFLnJDl7lNIWMX+ptlxJ0vu4VNNfAHrwXpp873RVT0i2vTbTqJZqeqep++LMTzsNt8OVdgwnrdWFbglw=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr19082126iof.266.1535955262101;
 Sun, 02 Sep 2018 23:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 23:14:21 -0700 (PDT)
In-Reply-To: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 08:14:21 +0200
Message-ID: <CAPDyKFpVaxttnTZPPZFPn4yvQET_=WcA5TyW2rSbyVEeZOuFVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Rerun the pad calibration procedure before sdhci_request() if
> the 100 ms recalibration interval has been exceeded.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 94624ec..ef18a0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -30,6 +30,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/ktime.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -122,6 +123,7 @@ struct sdhci_tegra {
>         struct pinctrl_state *pinctrl_state_1v8;
>
>         struct sdhci_tegra_autocal_offsets autocal_offsets;
> +       ktime_t last_calib;
>
>         u32 default_tap;
>         u32 default_trim;
> @@ -533,6 +535,22 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_down_hs400 = autocal->pull_down_1v8;
>  }
>
> +static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       ktime_t since_calib = ktime_sub(ktime_get(), tegra_host->last_calib);
> +
> +       /* 100 ms calibration interval is specified in the TRM */
> +       if (ktime_to_ms(since_calib) > 100) {
> +               tegra_sdhci_pad_autocalib(host);
> +               tegra_host->last_calib = ktime_get();
> +       }
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1014,6 +1032,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>                                 sdhci_tegra_start_signal_voltage_switch;
>         }
>
> +       /* Hook to periodically rerun pad calibration */
> +       if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> +               host->mmc_host_ops.request = tegra_sdhci_request;
> +
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                         tegra_sdhci_hs400_enhanced_strobe;
>
> --
> 2.7.4
>
