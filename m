Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938A720847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fokn1aIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938A720847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeGENNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:13:44 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46777 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeGENNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:13:39 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so7671639ioh.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=G9ypjRlhk5P7unrQUJ1g9vImFuZ/3zYOrtYHJHB/8Is=;
        b=Fokn1aIHzwm4rOwtCvcSiCKFVSYD91nRqdnxNS3Fl4gtu4jd2rJrA3hV3Ee0xgGZFn
         Xn/JYP8mhOfLrvFCuyAt0HdE7udZo27tSJDuqaFw/9RSudNCC+5dwq0NI9MW3vZ8jCS0
         1ytveoXUXaAFVCpddwphGqYtM0/LZ+GGXELng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=G9ypjRlhk5P7unrQUJ1g9vImFuZ/3zYOrtYHJHB/8Is=;
        b=llzhndoSwegBsPF9hra/6CcyfJp0J1spuJ5W3yCkksHIUK+8p6Fy3rW6KrhgvS7zDo
         3Fa8Z2KLGYv8RmrBdd7docNWHqqG+mIq7zTkxTwj9aNCq7QvT7Oun9CDvo042CsxKgB6
         dyggE742hEpC+9MpMHrAOGjHIr8jIZxAyPBFNJhPnuTd9ifvr/Bg1dugVEIQ0BXmav2J
         pWYHu2/CYtXFy7U+bbu5eeX9XlO2WQokyM1jRWaOXn2jP3voO41WZD3q+GiMKduCZygo
         coeuDLJ+zBbRwd0l8HllGe2zbL7i4eVxrGrbE/s1rTl3gQlm7Zgk/bk1A3/eVPP6ROIl
         QV6A==
X-Gm-Message-State: AOUpUlGrGzqra1HmKM35iV0f4htAQbsKhKKURo5gAnQQVg6HLzHsZtXu
        aKuwKV3EnLgpXMP7xxrCyafwBrK/y0VdciSvYa8YHw==
X-Google-Smtp-Source: AAOMgpe4D4ULcoWNlFNfAgTW8Bf6olfmrR0FqKRzO0HjQMBK2gY1J5/2V+h1lGOqrDgtHA5armg4q1riCEjzNnm71G4=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr5032715iof.266.1530796418993;
 Thu, 05 Jul 2018 06:13:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:13:38 -0700 (PDT)
In-Reply-To: <20180704174524.5f6d50fb@xhacker.debian>
References: <20180704174524.5f6d50fb@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:13:38 +0200
Message-ID: <CAPDyKFpGvxJyBGwPtq7OJc2pOLWYg6wEw0YyZQdcdiYe2-4D9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC dirver
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 11:45, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> Add a driver for SDHCI OF Synopsys DesignWare Cores Mobile Storage
> Host Controller.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++

Please split DT docs into separate patches.

Ehh, just make checkpatch not to complain, then I am happy with this patch!

Kind regards
Uffe

>  drivers/mmc/host/Kconfig                      |  10 ++
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 117 ++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> new file mode 100644
> index 000000000000..ee4253b33be2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> @@ -0,0 +1,20 @@
> +* Synopsys DesignWare Cores Mobile Storage Host Controller
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "snps,dwcmshc-sdhci"
> +- reg: offset and length of the register set for the device.
> +- interrupts: a single interrupt specifier.
> +- clocks: Array of clocks required for SDHCI; requires at least one for
> +    core clock.
> +- clock-names: Array of names corresponding to clocks property; shall be
> +    "core" for core clock and "bus" for optional bus clock.
> +
> +Example:
> +       sdhci2: sdhci@aa0000 {
> +               compatible = "snps,dwcmshc-sdhci";
> +               reg = <0xaa0000 0x1000>;
> +               interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&emmcclk>;
> +               bus-width = <8>;
> +       }
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..23beb9ec6dbf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -176,6 +176,16 @@ config MMC_SDHCI_OF_HLWD
>
>           If unsure, say N.
>
> +config MMC_SDHCI_OF_DWCMSHC
> +       tristate "SDHCI OF support for the Synopsys DWC MSHC"
> +       depends on MMC_SDHCI_PLTFM
> +       depends on OF
> +       depends on COMMON_CLK
> +       help
> +         This selects Synopsys DesignWare Cores Mobile Storage Controller.
> +         If you have a controller with this interface, say Y or M here.
> +         If unsure, say N.
> +
>  config MMC_SDHCI_CADENCE
>         tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
>         depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 85dc1322c3de..a18fbba1b97e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)     += sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)                += sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)       += sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)                += sdhci-of-hlwd.o
> +obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)     += sdhci-of-dwcmshc.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)       += sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)          += sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)            += sdhci-msm.o
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> new file mode 100644
> index 000000000000..93b613cd7c33
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Synopsys DesignWare Cores Mobile Storage Host Controller
> + *
> + * Copyright (C) 2018 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +struct dwcmshc_priv {
> +       /* bus clock */
> +       struct clk      *bus_clk;
> +};
> +
> +static const struct sdhci_ops sdhci_dwcmshc_ops = {
> +       .set_clock              = sdhci_set_clock,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .reset                  = sdhci_reset,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> +       .ops = &sdhci_dwcmshc_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +};
> +
> +static int dwcmshc_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_host *host;
> +       struct dwcmshc_priv *priv;
> +       int err;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> +                               sizeof(struct dwcmshc_priv));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       pltfm_host = sdhci_priv(host);
> +       priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> +       if (IS_ERR(pltfm_host->clk)) {
> +               err = PTR_ERR(pltfm_host->clk);
> +               dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +               goto free_pltfm;
> +       }
> +       err = clk_prepare_enable(pltfm_host->clk);
> +       if (err)
> +               goto free_pltfm;
> +
> +       priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +       if (!IS_ERR(priv->bus_clk))
> +               clk_prepare_enable(priv->bus_clk);
> +
> +       err = mmc_of_parse(host->mmc);
> +       if (err)
> +               goto err_clk;
> +
> +       sdhci_get_of_property(pdev);
> +
> +       err = sdhci_add_host(host);
> +       if (err)
> +               goto err_clk;
> +
> +       return 0;
> +
> +err_clk:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       clk_disable_unprepare(priv->bus_clk);
> +free_pltfm:
> +       sdhci_pltfm_free(pdev);
> +       return err;
> +}
> +
> +static int dwcmshc_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       sdhci_remove_host(host, 0);
> +
> +       clk_disable_unprepare(pltfm_host->clk);
> +       clk_disable_unprepare(priv->bus_clk);
> +
> +       sdhci_pltfm_free(pdev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +       { .compatible = "snps,dwcmshc-sdhci" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> +
> +static struct platform_driver sdhci_dwcmshc_driver = {
> +       .driver = {
> +               .name   = "sdhci-dwcmshc",
> +               .of_match_table = sdhci_dwcmshc_dt_ids,
> +       },
> +       .probe  = dwcmshc_probe,
> +       .remove = dwcmshc_remove,
> +};
> +module_platform_driver(sdhci_dwcmshc_driver);
> +
> +MODULE_DESCRIPTION("SDHCI platform driver for Synopsys DWC MSHC");
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.18.0
>
