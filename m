Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XBYAKOQfHlurSAAAmS7hNA
	; Mon, 11 Jun 2018 07:15:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1C042607A4; Mon, 11 Jun 2018 07:15:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3orN18A"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AF564605A5;
	Mon, 11 Jun 2018 07:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF564605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbeFKHPG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:15:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38301 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbeFKHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:15:04 -0400
Received: by mail-io0-f195.google.com with SMTP id l19-v6so22725933ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EAmvlFKeTS9v1ojXFILVNG9h2SZAYvtakCRes9k4vYw=;
        b=c3orN18Ao+au9WotaptMYMjElTbxBDaf+GbhpxIyqKAV4hjfz+ic+VrJlY+5EL2+hw
         nxmAzWw40PFrhn0MLAIQv6kYV93LktPU/EOnoeW43hPlEDLr8AV9XGqBGLr5uh3LQ7YZ
         JTbqJuY3s12POIDPcyU0uH81MAzawJwbxqLvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EAmvlFKeTS9v1ojXFILVNG9h2SZAYvtakCRes9k4vYw=;
        b=X9o0eWJzpJf8gaFGyI2ishNelrIinL/MuZ5vZOQYD1Wsv45lUfjCe0ZDa/7TBTLDP3
         QTDvBzmkBqA/U0wWPuxfUxU5dvzd7TgFeADEB9gJSXSE7iQEv2TQKyVmMGCi4qNxOLNJ
         hRePbfxgbXQMqCuGtTBmvCeHCMpgQOt+THYMLNGfFEUi5mSBu2VrzDMqyApZqxiy+eT4
         b1VPC86faIAIoiznT/2R7shohTRedTYOGd0UU+Xp6ic2XicJbcTtcL+0LlzrKv1wCgI3
         aK2QkuawxBgIvvLnZmSGWjdJu0MG4vQ+usk0FWTMUm6fMaAFIbvjmqVsk7xcMkhuQDAK
         x3Kw==
X-Gm-Message-State: APt69E37W1AJGyZb9kn+HD3oazW+bUyc3Z81vh2+/ePTmZVFnKy6gp9T
        FkqIbSmLQSzaxnHLYasRIo7nwfeglnzWZ6uNF2Dk0Q==
X-Google-Smtp-Source: ADUXVKI9gK7gmCUZh/hDOrPSMCo4vpzHoGxtjYzAuk5p5paUzQJJVHTg/6KgpU2qr0jhLlLe4d+Nejv1mWgsNsWHczs=
X-Received: by 2002:a6b:c986:: with SMTP id z128-v6mr13638533iof.266.1528701303922;
 Mon, 11 Jun 2018 00:15:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:15:03
 -0700 (PDT)
In-Reply-To: <1528445893-14530-7-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org> <1528445893-14530-7-git-send-email-zhang.chunyan@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 Jun 2018 09:15:03 +0200
Message-ID: <CAPDyKFq5WpLTySEPKjNxXSjz5hpiDGStNQo1pPzNmxy0Y9bpnQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: host: sdhci-sprd: added Spreadtrum's host
 controller R11
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 June 2018 at 10:18, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>
> This patch adds the initial support of Secure Digital Host Controller
> Interface compliant controller - R11 found in some latest Spreadtrum
> chipsets.
>
> R11 is a variant based on SD v4.0 specification.
>
> With this driver, mmc can be initialized, can be mounted, read and
> written.
>
> Original-by: Billows Wu <billows.wu@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  drivers/mmc/host/Kconfig          |  13 ++
>  drivers/mmc/host/Makefile         |   1 +
>  drivers/mmc/host/sdhci-sprd-r11.c | 472 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-sprd-r11.c

This is a DT based driver. Please add a separate patch describing the
corresponding bindings and compatibles.

[...]

> +static int sdhci_sprd_get_dt_resource(struct platform_device *pdev,
> +               struct sdhci_sprd_host *sprd_host)
> +{
> +       int ret = 0;
> +       struct clk *clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "sdio");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get sdio clock (%d)\n", ret);
> +               goto out;
> +       }
> +       sprd_host->clk_sdio = clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "source");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get source clock (%d)\n", ret);
> +               goto out;
> +       }
> +       sprd_host->clk_source = clk;
> +
> +       clk_set_parent(sprd_host->clk_sdio, sprd_host->clk_source);
> +       sprd_host->base_rate = clk_get_rate(sprd_host->clk_source);
> +       if (!sprd_host->base_rate) {
> +               sprd_host->base_rate = 26000000;
> +               dev_warn(&pdev->dev, "The source clock rate is 0\n");
> +       }
> +

The above can be managed by the assigned-clock* DT bindings. Please
have a look at:

Documentation/devicetree/bindings/clock/clock-bindings.txt
drivers/clk/clk-conf.c

> +       clk = devm_clk_get(&pdev->dev, "enable");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get gate clock (%d)\n", ret);

The printed name of the clock doesn't match the name used in
devm_clk_get() call.

BTW, I think devm_clk_get() already prints some information when it
fails to lookup a clock. Isn't that sufficient?

> +               goto out;
> +       }
> +       sprd_host->clk_enable = clk;
> +
> +out:
> +       return ret;
> +}
> +
> +static void sdhci_sprd_set_mmc_struct(struct platform_device *pdev,
> +                               struct mmc_host *mmc)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> +               MMC_CAP_ERASE | MMC_CAP_CMD23;
> +
> +       mmc_of_parse(mmc);
> +       mmc_of_parse_voltage(np, &host->ocr_mask);

mmc_of_parse_voltage() is intended to be used for controllers that
internally manages the powered to the card. Is that really the case?

I assume you have external regulator(s) to manage that, no?

> +
> +       mmc->ocr_avail = 0x40000;
> +       mmc->ocr_avail_sdio = mmc->ocr_avail;
> +       mmc->ocr_avail_sd = mmc->ocr_avail;
> +       mmc->ocr_avail_mmc = mmc->ocr_avail;

If there is external regulators used, all the above can go away. In
either case, at least the *_sdio, *_sd, *_mmc can go away.

> +
> +       mmc->max_current_330 = SDHCI_SPRD_MAX_CUR;
> +       mmc->max_current_300 = SDHCI_SPRD_MAX_CUR;
> +       mmc->max_current_180 = SDHCI_SPRD_MAX_CUR;

This should probably also be fetched used an external regulator and
sdhci already manages that.

> +
> +       host->dma_mask = DMA_BIT_MASK(64);
> +       mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
> +}

[...]

> +
> +static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
> +{
> +       return 400000;
> +}

Isn't there a more straightforward way to assign the minimum clock
rate? Do you really need to use a callback?

> +
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +}

Looks like an unnecessary wrapper function.

[...]

> +static int sdhci_sprd_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct sdhci_sprd_host *sprd_host;
> +       int ret = 0;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_sprd_pdata, sizeof(*sprd_host));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       sprd_host = TO_SPRD_HOST(host);
> +
> +       ret = sdhci_sprd_get_dt_resource(pdev, sprd_host);
> +       if (ret)
> +               goto pltfm_free;
> +
> +       clk_prepare_enable(sprd_host->clk_sdio);
> +       clk_prepare_enable(sprd_host->clk_enable);
> +
> +       sdhci_sprd_init_config(host);
> +
> +       sdhci_sprd_set_mmc_struct(pdev, host->mmc);
> +
> +       host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
> +       sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
> +                              SDHCI_VENDOR_VER_SHIFT);
> +
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
> +       ret = sdhci_add_host(host);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add mmc host: %d\n", ret);
> +               goto pm_runtime_disable;
> +       }
> +

Looks like there is a missing call to pm_runtime_put() here, no?

Unless it's intentional to prevent runtime suspend, for whatever reasons!?

> +       return 0;
> +
> +pm_runtime_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +
> +       clk_disable_unprepare(sprd_host->clk_sdio);
> +       clk_disable_unprepare(sprd_host->clk_enable);
> +
> +pltfm_free:
> +       sdhci_pltfm_free(pdev);
> +       return ret;
> +}
> +
> +static int sdhci_sprd_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +       struct mmc_host *mmc = host->mmc;
> +
> +       mmc_remove_host(mmc);
> +       clk_disable_unprepare(sprd_host->clk_sdio);
> +       clk_disable_unprepare(sprd_host->clk_enable);
> +
> +       mmc_free_host(mmc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_sprd_of_match[] = {
> +       { .compatible = "sprd,sdhc-r11", },

As stated, don't forget to document this.

[...]

Kind regards
Uffe
