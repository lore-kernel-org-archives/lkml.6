Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB45C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C136F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1cJ0dLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C136F20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLKJrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:47:45 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39973 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLKJro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:47:44 -0500
Received: by mail-vk1-f196.google.com with SMTP id v70so3229338vkv.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esOMjB9RbrmiA97RLnUMN0xYUZzOcq1giJGVXbJM8sQ=;
        b=G1cJ0dLSQBe6sKgCzWcn77cBRRitjwDsHZuNo5KyDTzwvIz0TkU9w59i5qMikgrtlN
         ZjPOlM1CYfEamIsqoDmCHTmjbBEjxKZh6VcgoK7pHSp4qAXV5UqkvdP9ljHQiqpYazo6
         zPWdYAFeBhrfRGeQLJm6T/eJZECczez0N8EgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esOMjB9RbrmiA97RLnUMN0xYUZzOcq1giJGVXbJM8sQ=;
        b=VCWC7EYQsJJJQmPM++YwaehAtQegtGxs/G5E19nrACAPLzgcvN0CO0bjl+gWkCNVWF
         pW7f7z4DCpC0J2qwd1EWWMZOa7+/u/9gppF0S9akn/gllJaoZ4F11F68RM27iadadhXO
         XUgzybtbd9FxMyLZ2FPlevsmELXBcScgocKAWvoTuHKzUsuRCwc5cPSpC+uxXRJHZuGf
         SacqDP/7ivvsblogsKCZhUO1JoIf24F0CxbdRCTjXwcLazL1SuG5VYGAjpeyge+2kSeQ
         Yng9b4O/tsgww7nhWV0dQEyuxsCECYn/LZ3budMqEzuwkG6ByPqXEjCbOtqquWUZZw6y
         y+lA==
X-Gm-Message-State: AA+aEWaQXyTeWyeZLR15FVaK4qRWQezl9AKMCEEvjEAHSdeKHzhLcH0T
        Vbhy3tfIkHTF99PU3zHOmGzon4Gp01kQO+lxqTqiDQ==
X-Google-Smtp-Source: AFSGD/XpIAPaPsECI6d8kvTPWYA2S2QWtq898MBKkAfa/VHuwWDabNRHupOf+NfhBstJfujXge8uuGw0gZDY3RYLhyk=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr6628383vka.4.1544521663017;
 Tue, 11 Dec 2018 01:47:43 -0800 (PST)
MIME-Version: 1.0
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com> <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:47:07 +0100
Message-ID: <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] mmc: mmci: add variant property to set command
 stop bit
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
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

On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
> cmdstop bit in command register. The CPSM ("Command Path State Machine")
> treats the command as a Stop Transmission command and signals
> abort to the DPSM ("Data Path State Machine").
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Withholding patch2 for a while, as I need some more time to review it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 6 ++++++
>  drivers/mmc/host/mmci.h | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 13fa640..e352f5a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/highmem.h>
>  #include <linux/log2.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>         .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>         .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>         .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>         .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>         .datactrl_first         = true,
> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 mmci_reg_delay(host);
>         }
>
> +       if (host->variant->cmdreg_stop &&
> +           cmd->opcode == MMC_STOP_TRANSMISSION)
> +               c |= host->variant->cmdreg_stop;
> +
>         c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 550dd39..2422909 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -264,6 +264,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -316,6 +317,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> --
> 2.7.4
>
