Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF30C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9842720870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpBGwxKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9842720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIYNGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:06:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55838 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:06:13 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so5896172itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QODh4Cqjxml/wZUHKfYxxgOXpIhFrlARWbmMKj3h+6Q=;
        b=gpBGwxKXGlpa0VfqfWYvCc1KS1H4QNNA8rzl18r1XIVtdl1TGM7TfxiVYvcM7UhKkO
         QcNCvJZ8IRJyUp+ZHiG4QbU3Cvw3t6RGqmTfRothvbRL/+LeOxxPNPOlItuw7ZnNr+RF
         o9ByqTw/jJZAKr0Z8JGN1cBg++PcQA4hXBTeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QODh4Cqjxml/wZUHKfYxxgOXpIhFrlARWbmMKj3h+6Q=;
        b=ZXRc2QY4yIIULcjmUXGbcWJkUqeBcbpCC6j6+O8MqMUyZDZQlrcPsMIgki350ptw7n
         /QqAG9LO3xQlq/tYjodvYGdxDXQLOOEpnATnIftP2kQDCXLLulAu38aiGl84XW5mB0ld
         w0yk4CW6kVJ76XDU4qKhUQJfkwM0/xM8SOsSfjacVQKsTVsNXkDVvsvn9gjyi0VoY3GF
         oy3rvA6yzwu9EW8gQ6EiLKu+LpPwIvDCp51P3hDP9y4AqS57lZ63HjjHHdlKSwCHRnnv
         tnhJnEn9y52MNVwAk7go/4QQOSTbKDuduBHQlgwolfgqcSRhzVRdMZBZJNkgnyEZv7GH
         sHFQ==
X-Gm-Message-State: ABuFfohv2Mp2FuOOkUVC2sPp2W1n8XSF5pclTJ9mpNTXLutGvUROAOb/
        mnwnr1s29YYEpD8NGsMPEgIMbNl3DBxfWu87TKUYyA==
X-Google-Smtp-Source: ACcGV61D/UFDJhPmEEOeTw+UhpqubeeU4wpYDEVoHv30ncd0eoUo0dHgJm1Bs2z7zNGWJM7ypWrrmWX867+LOcJTSHI=
X-Received: by 2002:a02:9c39:: with SMTP id q54-v6mr1930357jak.142.1537858806380;
 Tue, 25 Sep 2018 00:00:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 23:59:25
 -0700 (PDT)
In-Reply-To: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
References: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Sep 2018 08:59:25 +0200
Message-ID: <CAPDyKFqmyCg_BL6bAEB7x48KtvYmS45VR9KC4jyQ9=9Pt3QMjA@mail.gmail.com>
Subject: Re: [PATCH] sdhci: arasan: Add runtime PM support
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2018 at 17:04, Manish Narani <manish.narani@xilinx.com> wrote:
> Add runtime PM support in Arasan SDHCI driver.

According to the patch you seem to deploy support for it, but since
you call pm_runtime_forbid() in ->probe(), this means in practice that
the code becomes unused, at least until user-space decides to change
it.

Does it mean that you haven't tested the code or that there are some problems?

In either case, it would be good to know so please add this
information to the changelog.

>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 80 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index a40bcc2..370ada5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -30,6 +31,7 @@
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_ARASAN_AUTOSUSPEND_DELAY 2000 /* ms */
>  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
>  #define SDHCI_ARASAN_CQE_BASE_ADDR     0x200
>  #define VENDOR_ENHANCED_STROBE         BIT(0)
> @@ -363,6 +365,70 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if (sdhci_arasan->has_cqe) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
> +       clk_disable(pltfm_host->clk);
> +       clk_disable(sdhci_arasan->clk_ahb);
> +
> +       return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_enable(sdhci_arasan->clk_ahb);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable AHB clock.\n");
> +               return ret;
> +       }
> +
> +       ret = clk_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable SD clock.\n");
> +               return ret;
> +       }
> +
> +       ret = sdhci_runtime_resume_host(host);
> +       if (ret)
> +               goto out;
> +
> +       if (sdhci_arasan->has_cqe)
> +               return cqhci_resume(host->mmc);
> +
> +       return 0;
> +out:
> +       clk_disable(pltfm_host->clk);
> +       clk_disable(sdhci_arasan->clk_ahb);
> +
> +       return ret;
> +}
> +#endif /* ! CONFIG_PM */
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -455,8 +521,10 @@ static int sdhci_arasan_resume(struct device *dev)
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
>
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -                        sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
> +       SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +                          sdhci_arasan_runtime_resume, NULL) };
>
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>         /* SoC-specific compatible strings w/ soc_ctl_map */
> @@ -821,6 +889,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_add_host;
>
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev,
> +                                        SDHCI_ARASAN_AUTOSUSPEND_DELAY);
> +       pm_runtime_mark_last_busy(&pdev->dev);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_forbid(&pdev->dev);

When sdhci_arasan_suspend|resume() gets called, which calls into
sdhci_suspend|resume_host(), we requires that the host is already
runtime resumed. I am guessing that's why you are calling
pm_runtime_forbid() here?

To me, it looks like you may want to look into using
pm_runtime_force_suspend|resume() from the system suspend/resume
callbacks. The tricky part seems to be to manage the phy correctly, as
there seems to be some constraints while changing the clock in regards
to the state of the phy - and of course make sure to deal with wakeups
correctly.

I suggest you to have a look at how sdhci-of-at91 has implemented PM
support, that might give you an idea of how it could be done.

> +
>         return 0;
>
>  err_add_host:
> --
> 2.1.1
>

Kind regards
Uffe
