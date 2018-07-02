Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4927C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701C7253E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwO/eCV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701C7253E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeGBOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:37:10 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40508 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbeGBOhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:37:07 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so12264050ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bURNuA6Qcue88cjvMx+hohPzygY+S7YdRGSNxT7k2YM=;
        b=bwO/eCV4cigcbX02J8qhjFPxbOf/du2gCR050enkfEPberxev63LMLaHf0FjXda+XE
         W64DAfyw6KiYjVsMaTV7B1QD6hJ4A2brOGa9O8lXvcL+O+gz5m0nzWgLkWg4chVsxIET
         Kiw0Pa21bhWe/aPAIOvYDTZrVEVaZ1SH9+a4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bURNuA6Qcue88cjvMx+hohPzygY+S7YdRGSNxT7k2YM=;
        b=bVNY4o5eHc6e5ABSzyiXaaNgxrcEz6/wJD5csxA9gvMHUYMPPy3MGFHS7jUWQbfN3P
         /75O/nR510NbLkXVHCw3sQIbLWWOQWjiL0C+3ArOEBwDrKpTslnTxXNdC6d34DzD7gGg
         TvL3bSSl5Z9i2gY+ZZfG3o/vYnNTmfUFbGBT/wAzZj2tZiUBkHoaBRNkbhfyJ6Pnj50a
         mnrka5/gMSR8TVzb6XnqVHa4cUY8NTRil4ieMTjMBtvsWlmzlUwSP8Hl0kh4Of9zPxKw
         yFnuLLU6ulJTB/PZMsKmWnQaQ1GlJLtqc1nYIB/KTMhK5sL4lsj8wT7S78t73JdNIzrz
         0zeg==
X-Gm-Message-State: APt69E2goAwYb8MPyXNZG0y2ZSozFhKnSLHqqdJaOMrkSkRxMQK/DoGs
        tFJlc6sLl4x1i0anFZPsp6Zl1CVbUuCwMvB/st+KyQ==
X-Google-Smtp-Source: AAOMgpdfRt9f4KXGx2aJXtrr0B74glNnMZggPZXHSP9OsCa2JOhs/bYyXx7+Y/khzMr0gSBREDP8Q05mMzY/3XFAX8A=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr10858789itc.102.1530542226686;
 Mon, 02 Jul 2018 07:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:37:06 -0700 (PDT)
In-Reply-To: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
References: <20180628084509.19646-1-laurentiu.tudor@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 16:37:06 +0200
Message-ID: <CAPDyKFoNmcg+7JbWq1eeb2Dx7GKSh=FWpZcEeB8RORaBbrr=qA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 10:45, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
> SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
> when doing DMA. Make sure that the corresponding dma mask is correctly
> configured.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 4ffa6b173a21..8332f56e6c0d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -22,6 +22,7 @@
>  #include <linux/sys_soc.h>
>  #include <linux/clk.h>
>  #include <linux/ktime.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/mmc/host.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
>  static int esdhc_of_enable_dma(struct sdhci_host *host)
>  {
>         u32 value;
> +       struct device *dev = mmc_dev(host->mmc);
> +
> +       if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
> +           of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
> +               dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
>
>         value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>         value |= ESDHC_DMA_SNOOP;
> --
> 2.17.1
>
