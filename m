Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294524137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPfrG0fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294524137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeGENJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44564 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754558AbeGENJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:09:29 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so7672874ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pLfRU5BmtkI3HBal1FyEXxaMtxhUq0lQ17/j2CvDbWU=;
        b=KPfrG0fyRk5vUawFegp2WxwfFyY44sSCKhDjFTrmWMKIkpexQvl9sZKUFZ05lyH+tm
         8nGBLXEC3kUfpUxIjt42S1l9F1ha5XREUhPTeLu2Jmx5GcK5KatcEMrvkGvJ3a9OLizG
         UdmnN89U/p3jB1Q4vOpJbpmUpmttDXXRdQvHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pLfRU5BmtkI3HBal1FyEXxaMtxhUq0lQ17/j2CvDbWU=;
        b=mLARfGNlkKobmXl+ZQ/idunMb0/IwO9KAkJDKdhojHDeUROgIC3/B6WAWADLlfjZl+
         nUcE6P/ykeinlKlLUkPNmBtpr0vGzeCU5C/5cf5AYWKGjc9stFtR5Qfce2FO6jSz6EBp
         GVLcRNqPEhbw8LcY7oeDQs/svOgq64e7EGkJ1c2UlCjD4h+MzR5IhFj71EkIWKwORj9i
         y1dxhKUoZEBnf4A9p7TWEYAY6tP3HHeJ3zA9/gXejjxS0RyNJZlS9WtcmSBEW0tuAzKs
         h7foRBqBz5LYXZ0VsYFuNjsx8qmKGXKlyhKy3vki/tLPFlrfItIVovOz7gLxwwGe17NO
         7e0w==
X-Gm-Message-State: AOUpUlHXqWOwJBk+QV+yPZfI+z0Q0TSeU1b8WAMAmW1ll8NMyVDF7q3p
        PfPj17KwopVOhJpZpLjzQ9ntrHtWs4HruMU+nQ/Cww==
X-Google-Smtp-Source: AAOMgpcdKKbYzcW7Iik921KohaZgiPgD5gPYqEYgl8mMyegSdkZX2sJqBlgWysN4AOuneFz8iIKxxkfhVOKcPXsVi+I=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr5017280iof.266.1530796168729;
 Thu, 05 Jul 2018 06:09:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:09:28 -0700 (PDT)
In-Reply-To: <20180704113420.22204-1-laurentiu.tudor@nxp.com>
References: <CAPDyKFrabODyn4qgprFS4+Pfg0Xvy1tBzqDofJOwWuM7HK=0ZQ@mail.gmail.com>
 <20180704113420.22204-1-laurentiu.tudor@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:09:28 +0200
Message-ID: <CAPDyKFqogj2PZ_KfzS5CHy2z23Z4P36pTaCsh0V1WxaW36U+Lg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
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

On 4 July 2018 at 13:34, Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
> SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
> when doing DMA. Make sure that the corresponding dma mask is correctly
> configured.
>
> Context: when enabling smmu on these chips the following problem is
> encountered: the smmu input address size is 48 bits so the dma mappings
> for sdhci end up 48-bit wide. However, on these chips sdhci only use
> 40-bits of that address size when doing dma.
> So you end up with a 48-bit address translation in smmu but the device
> generates transactions with clipped 40-bit addresses, thus smmu context
> faults are triggered. Setting up the correct dma mask fixes this
> situation.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thanks, re-placed v1 with v2 on my next branch.

Kind regards
Uffe

> ---
> Changes in v2:
>  - updated commit log with some context
>
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
