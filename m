Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F967C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAF240AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTHDIHSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DAF240AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeGENsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:48:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52112 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbeGENsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:48:04 -0400
Received: by mail-it0-f65.google.com with SMTP id o5-v6so12062259itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0tqe4gpVDUQDRYasPJ/C7QWR9cnzUzRO5mhk3QyrASE=;
        b=iTHDIHSv80Ju4bT3HoZj+cqLIAnga0CWDplZxjwIVYZ+Bm6FUGNb54n11ckP+kNdyT
         h23VsERZpiqWVxf+5i8rZM3smZfPGWh2hd2nCYBFn2U6yH2pwdo1tM6kBz27PmP9SiRU
         Zog3xZvhiT3RiN/EpwEykWLtvrNSfTXi87toQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0tqe4gpVDUQDRYasPJ/C7QWR9cnzUzRO5mhk3QyrASE=;
        b=XOh1J1HbxY6QkO6FdVZT5ahL9gQ5xJ/HLsvnAm3mGEHRLoFIRo0TEnU+R9eLLsf8Zz
         puQgqFLMToxTmgZZNFvQbbTJxQuD97lJ+z/xrBrPby+OXrbgve3BASqZzeQqebmL1o3K
         xQr7Tm2dKM/HLGXIpCC0GBvAaLhaNca25mV5l8wv+niW17bY1bkWX/RU2oSb4Vj0tycw
         9WAh1qBv/aJMxo5Me3pbMZ75e4zrHpvErt0tRg6Z2ET8r/Z8LcgrAARLdxFBnYF8/kQj
         Wj5uftO4N/YTv51CPBurZdPc0IAN9yRIUhsTZqArExNcHXjWZpFelb239iMpusDvvNPw
         w3og==
X-Gm-Message-State: APt69E2NyJY33sFtHUIV7wnzAva5001ABe2+zqEw+jHh/HFYmX3JbTMG
        MN7x9vLLZG1MWcFNPndBBRh4pAarXztCcxAPT4aA+A==
X-Google-Smtp-Source: AAOMgpdNhDRRohdU8WGArMWj60l5syb01hI6m1dYtHR5aepGr4R1vTgMI2O1xH3lkQGmJTz5YzbIq9Ame/ZGZNjqEkI=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr4926460jad.107.1530798483601;
 Thu, 05 Jul 2018 06:48:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:48:02 -0700 (PDT)
In-Reply-To: <1528809280-31116-6-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-6-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:48:02 +0200
Message-ID: <CAPDyKFpwVMX9LoC_abHm09UNhLse8MJBUpCCHkR8NnK7fOU5Yg@mail.gmail.com>
Subject: Re: [PATCH 05/19] mmc: mmci: allow to overwrite clock/power procedure
 to specific variant
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> A specific variant could have different power or clock procedures.
> This patch allows to overwrite the default mmci_set_clkreg and
> mmci_set_pwrreg for a specific variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 96 +++++++++++++++++++++++++++++--------------------
>  drivers/mmc/host/mmci.h |  7 ++++
>  2 files changed, 64 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index ede95b7..801c86b 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -374,6 +374,52 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>         mmci_write_clkreg(host, clk);
>  }
>
> +static void mmci_set_pwrreg(struct mmci_host *host, unsigned char power_mode,
> +                           unsigned int pwr)
> +{
> +       struct variant_data *variant = host->variant;
> +       struct mmc_host *mmc = host->mmc;
> +
> +       switch (power_mode) {
> +       case MMC_POWER_OFF:
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
> +                       regulator_disable(mmc->supply.vqmmc);
> +                       host->vqmmc_enabled = false;
> +               }
> +
> +               break;
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> +                                             mmc->ios.vdd);
> +
> +               /*
> +                * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
> +                * and instead uses MCI_PWR_ON so apply whatever value is
> +                * configured in the variant data.
> +                */
> +               pwr |= variant->pwrreg_powerup;
> +
> +               break;
> +       case MMC_POWER_ON:
> +               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> +                       if (regulator_enable(mmc->supply.vqmmc) < 0)
> +                               dev_err(mmc_dev(mmc),
> +                                       "failed to enable vqmmc regulator\n");
> +                       else
> +                               host->vqmmc_enabled = true;
> +               }
> +
> +               pwr |= MCI_PWR_ON;
> +               break;
> +       }
> +
> +       mmci_write_pwrreg(host, pwr);
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> @@ -1031,7 +1077,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
>         struct variant_data *variant = host->variant;
> -       u32 pwr = 0;
> +       unsigned int pwr = 0;

?

>         unsigned long flags;
>         int ret;
>
> @@ -1039,42 +1085,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 host->plat->ios_handler(mmc_dev(mmc), ios))
>                         dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
>
> -       switch (ios->power_mode) {
> -       case MMC_POWER_OFF:
> -               if (!IS_ERR(mmc->supply.vmmc))
> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> -
> -               if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
> -                       regulator_disable(mmc->supply.vqmmc);
> -                       host->vqmmc_enabled = false;
> -               }
> -
> -               break;
> -       case MMC_POWER_UP:
> -               if (!IS_ERR(mmc->supply.vmmc))
> -                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> -
> -               /*
> -                * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
> -                * and instead uses MCI_PWR_ON so apply whatever value is
> -                * configured in the variant data.
> -                */
> -               pwr |= variant->pwrreg_powerup;
> -
> -               break;
> -       case MMC_POWER_ON:
> -               if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> -                       ret = regulator_enable(mmc->supply.vqmmc);
> -                       if (ret < 0)
> -                               dev_err(mmc_dev(mmc),
> -                                       "failed to enable vqmmc regulator\n");
> -                       else
> -                               host->vqmmc_enabled = true;
> -               }
> -
> -               pwr |= MCI_PWR_ON;
> -               break;
> -       }

This above looks like pure re-factoring. Please make the above change
a separate patch.

>
>         if (variant->signal_direction && ios->power_mode != MMC_POWER_OFF) {
>                 /*
> @@ -1126,8 +1136,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         spin_lock_irqsave(&host->lock, flags);
>
> -       mmci_set_clkreg(host, ios->clock);
> -       mmci_write_pwrreg(host, pwr);
> +       if (variant->set_clkreg)
> +               variant->set_clkreg(host, ios->clock);
> +       else
> +               mmci_set_clkreg(host, ios->clock);

This means a change in behavior, which I don't think is what you want.

1) The spin lock will be held while doing the regulator operations.
2) The clock register will be written to before the regulator
operations have been done. Not sure if that works fine!?

An overall comment, I think we should create a mmci_host_ops structure
and put the needed callbacks in there (kept to a minimum of course),
rather than putting them as a part of the variant struct. More
importantly, also the legacy mmci variants should get a mmci_host_ops
structure assigned during probe.

The point is, I think it makes the code above (and future wise) more
flexible. It should also allow us to better share functions between
the variants. In principle, I expect that we end up with a bunch of
"library" mmci functions that can be invoked from variant's
mmci_host_ops (if not assigned directly).

> +
> +       if (variant->set_pwrreg)
> +               variant->set_pwrreg(host, ios->power_mode, pwr);
> +       else
> +               mmci_set_pwrreg(host, ios->power_mode, pwr);
> +
>         mmci_reg_delay(host);
>
>         spin_unlock_irqrestore(&host->lock, flags);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 2ba9640..7265ca6 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -231,6 +231,7 @@
>
>  struct clk;
>  struct dma_chan;
> +struct mmci_host;
>
>  /**
>   * struct variant_data - MMCI variant-specific quirks
> @@ -273,6 +274,8 @@ struct dma_chan;
>   *            register.
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
>   * @mmci_dma: Pointer to platform-specific DMA callbacks.
> + * @set_clk_ios: if clock procedure of variant is specific
> + * @set_pwr_ios: if power procedure of variant is specific
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -307,6 +310,9 @@ struct variant_data {
>         u32                     start_err;
>         u32                     opendrain;
>         struct mmci_dma_ops     *mmci_dma;
> +       void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
> +       void (*set_pwrreg)(struct mmci_host *host, unsigned char power_mode,
> +                          unsigned int pwr);
>  };
>
>  struct mmci_host {
> @@ -328,6 +334,7 @@ struct mmci_host {
>         u32                     pwr_reg;
>         u32                     pwr_reg_add;
>         u32                     clk_reg;
> +       u32                     clk_reg_add;

What's this? Some leftover I guess?

>         u32                     datactrl_reg;
>         u32                     busy_status;
>         u32                     mask1_reg;
> --
> 2.7.4
>

Kind regards
Uffe
