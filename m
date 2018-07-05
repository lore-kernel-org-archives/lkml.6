Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4A224053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQMTnePo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4A224053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeGENzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:55:41 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46315 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeGENzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:55:38 -0400
Received: by mail-io0-f196.google.com with SMTP id p7-v6so7796555ioh.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wKjFdcUAf1vR0wLkwrAQQaNvvogkfAtbdXBgkHcgGqQ=;
        b=LQMTnePo5HK7ScLbA1odn8w8L45B9u/KmyS826u5f+ai3fDpcjJ0mbo6wdiyt7yPsW
         6PeRMMLTFnDnHn6/zxAxSMrV6rV/za8Eiqk4c+apjtps2Ar3136Vc8lMcdmmKS8R+uAh
         /uVoQBXN6N1EW6AXXni42RINKFRvc6OsDuxws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wKjFdcUAf1vR0wLkwrAQQaNvvogkfAtbdXBgkHcgGqQ=;
        b=sFAMZhazZQArP2XOSA5H8L692Y2Jfi9aaaeIPqA1i6z/z9HlQtl3CJ19DKwe4f+rX0
         XG+0sUaQbfBDVm3paLRH4NDkmhiNU9xHeZEAfce8B7tx2frUJ/MZBv8eFmWTJIIfLSze
         tdzlvivd7UNQdh/g0kjGuILQ2S989gqGad2LIpTrLs8RvvayoXX4+xhZOv+DzAfemc1N
         D9D/j3vNuiPaazywAsLtPVN0a/PVPzMc8t+JG8abLB1kx+Jp9ITd/TNIrnXPzWz1peU8
         g9vQc44DcrjfmDv8nI3EoMr78fVUiRZnNMWeCAxNRE1BAVnvQnk5fb7NaA0PgOWIt77i
         eoxg==
X-Gm-Message-State: AOUpUlF4FKJbLdLoTnNywSaYw1qW3gVxxgaQklq9Gznk3aRrvsTRyA2K
        Jkmrj6+STH1meuCa/SFiVSMd1+2LxJo/ySWQ7mtqEg==
X-Google-Smtp-Source: AAOMgpdRcHYfQa9RjGuFfInsCYOnhFsFwfc+/z/lsv9jU6RuYxJdw7LX9Uwpan+rIzhKdofnmLm5VnxXkr1yafFRjLA=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr5174896iof.266.1530798937869;
 Thu, 05 Jul 2018 06:55:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:55:37 -0700 (PDT)
In-Reply-To: <1528809280-31116-11-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-11-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:55:37 +0200
Message-ID: <CAPDyKFpS6EPBtPstTi7wg3jJ+C-7k6mzypR1OcuHpV94VWjvkw@mail.gmail.com>
Subject: Re: [PATCH 10/19] mmc: mmci: add variant property to allow remain data
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
> This patch adds a boolean property to read remaining data.
> Needed to support the STM32 sdmmc variant. MMCIDATACNT
> register should be read only after the data transfer is complete.
> When reading after an error event the read data count value may be
> different from the real number of data bytes transferred.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 17 +++++++++++++++--
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 83c3572..abddad7 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -58,6 +58,7 @@ static struct variant_data variant_arm = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,

According to the description in the changelog, it sounds like
MMCIDATACNT is broken (or useless for the STM32 variant). I suggest to
rename the new variant to something along those lines instead.

Like "datacnt_broken", then you only need to set it to true for the
STM32 variant and legacy variants can remain as is.

>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .reversed_irq_handling  = true,
> @@ -78,6 +79,7 @@ static struct variant_data variant_arm_extended_fifo = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .mmcimask1              = true,
> @@ -98,6 +100,7 @@ static struct variant_data variant_arm_extended_fifo_hwfc = {
>         .datalength_bits        = 16,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 100000000,
>         .mmcimask1              = true,
> @@ -120,6 +123,7 @@ static struct variant_data variant_u300 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                        = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
>         .f_max                  = 100000000,
> @@ -146,6 +150,7 @@ static struct variant_data variant_nomadik = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -175,6 +180,7 @@ static struct variant_data variant_ux500 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -209,6 +215,7 @@ static struct variant_data variant_ux500v2 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .blksz_datactrl16       = true,
> @@ -244,6 +251,7 @@ static struct variant_data variant_stm32 = {
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
>         .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
> +       .datacnt_remain         = true,
>         .st_sdio                = true,
>         .st_clkdiv              = true,
>         .pwrreg_powerup         = MCI_PWR_ON,
> @@ -270,6 +278,7 @@ static struct variant_data variant_qcom = {
>         .datalength_bits        = 24,
>         .datactrl_blocksz       = 11,
>         .datactrl_dpsm_enable   = MCI_DPSM_ENABLE,
> +       .datacnt_remain         = true,
>         .pwrreg_powerup         = MCI_PWR_UP,
>         .f_max                  = 208000000,
>         .explicit_mclk_control  = true,
> @@ -711,8 +720,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                  * can be as much as a FIFO-worth of data ahead.  This
>                  * matters for FIFO overruns only.
>                  */
> -               remain = readl(host->base + MMCIDATACNT);
> -               success = data->blksz * data->blocks - remain;
> +               if (host->variant->datacnt_remain) {
> +                       remain = readl(host->base + MMCIDATACNT);
> +                       success = data->blksz * data->blocks - remain;
> +               } else {
> +                       success = 0;
> +               }
>
>                 dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
>                         status_err, success);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 5091025..12ee2e6 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -260,6 +260,8 @@ struct mmci_host;
>   * @datactrl_blksz: block size in power of two
>   * @datactrl_dpsm_enable: enable value for DPSM
>   * @datactrl_first: true if data must be setup before send command
> + * @datacnt_remain: true if you could read datacnt register
> + *                  to define remain data
>   * @pwrreg_powerup: power up value for MMCIPOWER register
>   * @f_max: maximum clk frequency supported by the controller.
>   * @signal_direction: input/out direction of bus signals can be indicated
> @@ -303,6 +305,7 @@ struct variant_data {
>         unsigned int            datactrl_blocksz;
>         unsigned int            datactrl_dpsm_enable;
>         bool                    datactrl_first;
> +       bool                    datacnt_remain;
>         bool                    st_sdio;
>         bool                    st_clkdiv;
>         bool                    blksz_datactrl16;
> --
> 2.7.4
>

Kind regards
Uffe
