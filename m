Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA20C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F30F21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6IXIxs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1Ld4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:33:56 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41373 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Ld4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:33:56 -0500
Received: by mail-ua1-f68.google.com with SMTP id z24so5453982ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBDrm1PCVZfCKpICeTE3MM436tQNH63XHBlLwrxqY+g=;
        b=B6IXIxs2rNeEKlGAAyr/j/89sOBRoDvDGz30BOTojHr8W10ibuNDOTAsBty5zduvPU
         FzfhlMVVXPMFBQcnNaaSYFTtUxvMS/YIseTjEiBVaInwBAkaq87rGGbcj6mADRC8g7TA
         nC/Jz92sM0ZtvA57OmmS2d8tee4SHU8gjB4pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBDrm1PCVZfCKpICeTE3MM436tQNH63XHBlLwrxqY+g=;
        b=TdOtH2VJtUFBYkLB8pLlmka7AWLuyW8KYnJBEB5wCx2irTxeKA3kYvSfe0NIYgwMQ0
         rJTXjExoDuXpeKMqyK4kYiTKQTLz3hFsNF6xT04rcXs0o+KDFuUAT5Ly5lwgAeAJUh93
         yB8efF2lxpckjnPI47AwJlbKL+s9We9TfT28/gZ+HC+dm2Iy2/wsDx6asdd+xPVdLIrp
         KzKJMw5j3SYW/Rlu7+sbqT6Uc9cv79APr+OvaSKnJJOiTi1QefoayD7OSLvOuxetsAHQ
         tZd6t/BVpVbjv/6ENefSlMjz0d7uMQhR7LedSLguaOkGqR8LXwfWF6WDe1vdCqnoXesn
         jSLQ==
X-Gm-Message-State: AJcUukeqtU6ACywRLpCBFlxfPCOrtIBiC26iX5ON+PzgFwu1iLwT+EJU
        U0y0XaW5yXxDFTb464NxGwYUHzbv5x+sy/GWZNflOQ==
X-Google-Smtp-Source: ALg8bN57wjlohKgYoWs9ZtVJVIMImSWEBQiDpa4XjMYAm0eWCz22/JoMHaV1RiUvGEbuQ7srVhMnAfC18N/1AK2fW64=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr8899547uar.39.1548675234990;
 Mon, 28 Jan 2019 03:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20190128102022.1880-1-martink@posteo.de>
In-Reply-To: <20190128102022.1880-1-martink@posteo.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jan 2019 12:33:19 +0100
Message-ID: <CAPDyKFpbSMpfdpEd_CkcMzfDU1nwG3A8dnZ8HR30mM+WF22kZw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
To:     Martin Kepplinger <martink@posteo.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 at 11:20, Martin Kepplinger <martink@posteo.de> wrote:
>
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
> doesn't turn off the VMMC regulator which leads to hangs when loading firmware.

Isn't there a GPIO that needs to be toggled and separate clk for the
WiFi chip that needs to be enabled as well?

>
> Tested on i.MX28.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>
> again, this isn't new. it's (rebased and simplified)
> https://patchwork.kernel.org/patch/4365751/
>
> Thanks Robin for your input!
>
> revision history
> ----------------
> v1: was just a question why this hasn't gone in earlier.
>
>
>  drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..fdaca0fcec99 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -66,11 +66,13 @@ struct mxs_mmc_host {
>         struct mmc_request              *mrq;
>         struct mmc_command              *cmd;
>         struct mmc_data                 *data;
> +       struct regulator                *vmmc;

You don't need this here as this is already part of the generic struct
mmc_host (via the struct mmc_supply).

>
>         unsigned char                   bus_width;
>         spinlock_t                      lock;
>         int                             sdio_irq_en;
>         bool                            broken_cd;
> +       unsigned char                   power_mode;

Ditto.

>  };
>
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -517,6 +519,24 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 host->bus_width = 0;
>
> +       if (host->vmmc && ios->power_mode != host->power_mode) {
> +               switch (ios->power_mode) {
> +               case MMC_POWER_OFF:
> +                       if (regulator_disable(host->vmmc))
> +                               dev_err(mmc_dev(host->mmc),
> +                                       "Failed to disable vmmc regulator\n");

You should use mmc_regulator_set_ocr() instead.

> +                       break;
> +               case MMC_POWER_UP:
> +                       if (regulator_enable(host->vmmc))

Ditto.

> +                               dev_err(mmc_dev(host->mmc),
> +                                       "Failed to enable vmmc regulator\n");
> +                       break;
> +               default:
> +                       break;
> +               }
> +               host->power_mode = ios->power_mode;
> +       }
> +
>         if (ios->clock)
>                 mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         host->mmc = mmc;
>         host->sdio_irq_en = 0;
> +       host->power_mode = MMC_POWER_OFF;

This isn't needed. The state is already controlled by the mmc core.

>
>         reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");

You should use mmc_regulator_get_supply() instead.

> -       if (!IS_ERR(reg_vmmc)) {
> -               ret = regulator_enable(reg_vmmc);
> -               if (ret) {
> -                       dev_err(&pdev->dev,
> -                               "Failed to enable vmmc regulator: %d\n", ret);
> -                       goto out_mmc_free;
> -               }
> -       }
> +       if (!IS_ERR(reg_vmmc))
> +               host->vmmc = reg_vmmc;
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(ssp->clk)) {
> --
> 2.20.1
>

Kind regards
Uffe
