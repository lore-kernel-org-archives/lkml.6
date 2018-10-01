Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5227C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A5A20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMiRlEi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A5A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeJAQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:08:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50822 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:08:17 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so10353257ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FHz95d/pMGf2H33zSYbM9UM1RBNiXE38wOhfi7Jg5bc=;
        b=MMiRlEi/9tEkV1wKjUujP0yu5jCoUUUAi6Ek1/+tLec5BWpS8InkU6yqeDhGcOeDVF
         RCNrqlkdRcfz1BKfQDELsw2xBfiCxJOxkmCLmILU7gBBgQI97p6HoSZlB+VlOaWonnrJ
         6UD5SuZ23PTkYLnfV04ssl0EHFCyrShwvXVB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FHz95d/pMGf2H33zSYbM9UM1RBNiXE38wOhfi7Jg5bc=;
        b=j0b0LPoCtpOBxWF7Xk51KYwX94N5VZY/QnSaf+tFwwL45rDTjvzNlF5oJJj6KbbKgi
         oEfiQo9kt6/6S48W+Y9+UOCUafDHgTRcYEptZZ9X9CN8vCGnJ7h1Y6OmBT+UAkp7/olb
         mayCBKjF/kpAU/jV/k2BXWBWS8DoFw6HU93BQ8KQEi4oPkhmUdXWT7Ig35Y8fLoN4QSv
         KerZs41qBuQsAANwWfomfrY4TQhLg10wbPGh7oOPnXkabRDa2pcX1kSeltVZ72rENkeK
         lOvX+NMt5vCiunlQiVQRhX58LetL4MBRGQDP0kfeA2eo1XDLXdua8KOMKD6+MopH21r8
         7r0A==
X-Gm-Message-State: ABuFfojBcmHoiKX5Dx3lhrNi95+TkFyC+umD9/f/htvUa5RmYubP/69Q
        VcBFuLD7xv8/HHCwN0W9JrMK3P3XfNCSIBDACsLm1Q==
X-Google-Smtp-Source: ACcGV61trHttGsA2HabjP+CRBguIQOSe3H3y1YYTNoK4v7s8NIa4aShBfjE2s/9tet6Wskq7AMTM2Q8VEXbAeK2l3pE=
X-Received: by 2002:a02:6a6f:: with SMTP id m47-v6mr7654745jaf.121.1538386284647;
 Mon, 01 Oct 2018 02:31:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:30:44 -0700 (PDT)
In-Reply-To: <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 11:30:44 +0200
Message-ID: <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
Subject: Re: [PATCH V2 23/27] mmc: mmci: add variant property to request a reset
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> Some variants could require a reset.
> STM32 sdmmc variant needs to reset hardware block
> during the power cycle procedure (for re-initialization)
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>  drivers/mmc/host/mmci.c                        | 9 +++++++++
>  drivers/mmc/host/mmci.h                        | 4 ++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index 03796cf..e952707 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -11,6 +11,8 @@ Required properties:
>  - compatible             : contains "arm,pl18x", "arm,primecell".
>  - vmmc-supply            : phandle to the regulator device tree node, mentioned
>                             as the VCC/VDD supply in the eMMC/SD specs.
> +depend of variant:
> +- resets                 : phandle to internal reset line.
>

This looks like a thing depending on the SoC, rather than on the
variant. Therefore, I suggest you move this to be an optional DT
property.

Also, please move the DT doc update into a separate patch.

>  Optional properties:
>  - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b1d5bc5..6b3c33f 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -37,6 +37,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/types.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/reset.h>
>
>  #include <asm/div64.h>
>  #include <asm/io.h>
> @@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
>
>         dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>
> +       if (variant->reset) {
> +               host->rst = devm_reset_control_get_exclusive(&dev->dev, NULL);

As suggested, let's make this optional and not depending on the variant.

> +               if (IS_ERR(host->rst)) {
> +                       ret = PTR_ERR(host->rst);
> +                       goto clk_disable;
> +               }
> +       }
> +
>         /* Get regulators and the supported OCR mask */
>         ret = mmc_regulator_get_supply(mmc);
>         if (ret)
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index e130689..f0fa185 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -247,6 +247,7 @@ struct mmci_host;
>   * @start_err: bitmask identifying the STARTBITERR bit inside MMCISTATUS
>   *            register.
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
> + * @reset: true if variant has need reset signal.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -285,6 +286,7 @@ struct variant_data {
>         bool                    qcom_dml;
>         bool                    reversed_irq_handling;
>         bool                    mmcimask1;
> +       bool                    reset;
>         unsigned int            irq_pio_mask;
>         u32                     start_err;
>         u32                     opendrain;
> @@ -318,6 +320,8 @@ struct mmci_host {
>         struct clk              *clk;
>         bool                    singleirq;
>
> +       struct reset_control    *rst;
> +
>         spinlock_t              lock;
>
>         unsigned int            mclk;
> --
> 2.7.4
>

Kind regards
Uffe
