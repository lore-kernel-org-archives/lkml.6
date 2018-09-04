Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03278C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8103A2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrRnEH7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8103A2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeIDS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:59:58 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52140 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:59:58 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so5280241itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oW/D9naYHMrpMfgJxVUiEQ9rSnPU2w8v4zhoEmuJ17Y=;
        b=WrRnEH7myfd0gr2Fqg2tJ74ijufzUpGLss3Ecja1A0KzHA1aROxodGs9LnLo6xlSa4
         XRxyo1OBDkquMNqNsB7+eAXjq78I51XsMp3sA+Z/CUtvrWPZSivVe8ptYP/X2a6Wn90l
         1uDH56J7pJILK2Emj4gH2I4M23FEcaB6oVADk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oW/D9naYHMrpMfgJxVUiEQ9rSnPU2w8v4zhoEmuJ17Y=;
        b=ArxH32Cny3ux3oxCPEON/Rhoz9ZPk00nMsEeCdFKlfVtkKWDzZZhJg2xu0pOZpJjdO
         3eRP7YxTyRSS5tK9M2Gu8NwyA2XE8oY9Om3OGTuOrDQkXEFU7nXFAswq+aZB8LU302KV
         +iP3NU/GvrLeQzkpVL/Q2nYQLsxVnF/f60UFJxaF3M9IRch3ciRVHuM+8I82xTKfpMo8
         gK86EBKJp7GCyWJjw+qg7lIgybYclTpVuoeFiCqeSk8h/GEU1sK+q7mqN5cXVQlF2QtD
         VWJvfIFJVaAaq4gYGzkRdeN2qIUypy9H0se8J9cPD8b+WuD7abYm4Ow+O+Nwg4qmCTeq
         lR5g==
X-Gm-Message-State: APzg51B9cGEW5lSiKmuBiPij6xZxzcCpmQI5mhM1atqGTxQS/Hls9Iat
        7Z9Fh+xLI+C5JxuP0c5YS8rSoCUfjLpxDGXnNhMMTA==
X-Google-Smtp-Source: ANB0VdaQfdqtWd2TwYfO7xuaSivLi6z0hHt85DK6gV3x9Wdnr0iGmX2F523SuIODqCuCNojggrjpYpQX/DZhsQe25Qg=
X-Received: by 2002:a24:b919:: with SMTP id w25-v6mr425013ite.101.1536071677235;
 Tue, 04 Sep 2018 07:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 07:34:36 -0700 (PDT)
In-Reply-To: <20180904025909.13700-1-yuehaibing@huawei.com>
References: <20180904025909.13700-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Sep 2018 16:34:36 +0200
Message-ID: <CAPDyKFqSqsXLt0HPJNXbmsfia53yHk5GaPhDpGo=NL1nMp-JRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: tegra: fix inconsistent IS_ERR and PTR_ERR
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 September 2018 at 04:59, YueHaibing <yuehaibing@huawei.com> wrote:
> Fix inconsistent IS_ERR and PTR_ERR in tegra_sdhci_init_pinctrl_info,
> the proper pointer to be passed as argument is 'pinctrl_state_1v8'
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index e80716c..c789158 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -724,7 +724,7 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
>         if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
>                 dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
> -                        PTR_ERR(tegra_host->pinctrl_state_3v3));
> +                        PTR_ERR(tegra_host->pinctrl_state_1v8));
>                 return -1;
>         }
>
> --
> 2.7.0
>
>
