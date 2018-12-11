Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBBEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08B72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyKnBWoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08B72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLKJcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:32:36 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37928 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLKJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:32:36 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so8478366vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vw/FzuAAc9nusM5lpA0fQi/m+fCQhnvjrojvco83qTI=;
        b=HyKnBWoXK8lyezyPlvI+7B6ftdOr5rC9e1C/oeV+eiakLcUKH7iCOm94R4zb60AFMc
         tLZ67O3vxxxsXIgnYa/aVQ8OU5V1nRxze7ABhRpHJKK8IalKOzsyGKa0R9r5HnCJeI9p
         UN16nArc4YgvGfW+j3FwyXtZDNGDrXhF9q4to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vw/FzuAAc9nusM5lpA0fQi/m+fCQhnvjrojvco83qTI=;
        b=WYP+F3Z/HosIzTjn8PUIYZ9gJtFHPY8o4HEjBqvoMxY5uhM1yhzm1hdUQZbV4ce5Z8
         tNUuj8q/MvV/Z0qsr0uqTN2bS4cZbsDuT5gzzjjgvAhnwpBlIZUMcWhn79X5J12gBp5F
         SrdtOPb7lLB7qrPr/2N38SaIWtjT9+MKI2EuV2IkZ40zVW42B6e4wZQNSWGMVpDA1P5d
         j4GnvPhwZ2si2x7H3h0etX9hrQ7GzGdejSLtccswJ73BQedkE5p+G426dkKcwrl3y6eY
         1TjlBq/6yR6x59/huQ9sLFdwjfRAGSqlyDEDd3OUixWu4f3RjgH18aUDfQvDB3h0zcOa
         tsFQ==
X-Gm-Message-State: AA+aEWZdR3gpZqR8inLaA9RLNcyKDbP/9K78Euaqzeicc/1yohKnq0BS
        0B4pT95/a/RdrzmqjZI/kXJrq40RvnvFxnMjWZnBGQ==
X-Google-Smtp-Source: AFSGD/XpsdzNNMl4b5P4tB4kMPbAPTv+PZ+FvvbGg6ij0GTPoOFv8QJp3iNsubqNmq36lF+xz9PtCgpsfn588VBCcWo=
X-Received: by 2002:a67:e002:: with SMTP id c2mr7070013vsl.34.1544520754640;
 Tue, 11 Dec 2018 01:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20181210204546.2384299-1-arnd@arndb.de>
In-Reply-To: <20181210204546.2384299-1-arnd@arndb.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:31:58 +0100
Message-ID: <CAPDyKFo-o0BV2wssJqAH2qgoOtJ_3YeKY=k9K3rrZ3j_J2Xz+A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: avoid unused function warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 21:45, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added sdhci_msm_restore_sdr_dll_config() function is only
> called if CONFIG_PM is enabled:
>
> drivers/mmc/host/sdhci-msm.c:1050:12: error: 'sdhci_msm_restore_sdr_dll_config' defined but not used [-Werror=unused-function]
>
> Better remove the incorrect #ifdef altogether and just use __maybe_unused,
> which is harder to get wrong.
>
> Fixes: ec3349733550 ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5497a71abe07..d6c9ebd8d263 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1997,8 +1997,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int sdhci_msm_runtime_suspend(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2010,7 +2009,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int sdhci_msm_runtime_resume(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2030,7 +2029,6 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> --
> 2.20.0
>
