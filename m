Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF045C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798902081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wv5s07+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798902081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeKAAPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:15:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52884 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKAAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:15:36 -0400
Received: by mail-it1-f195.google.com with SMTP id r5-v6so16775292ith.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EvCmC7UDDiojjF1KUdL7ZPFkIHjxz1xIoQxXLCp0G78=;
        b=Wv5s07+BUn7ilIy+AElsqoAm7xPBIXETRmwHZKHKJ0EYCDuH+ILVCcLogcPnM1zlQj
         I9Dx00OoJ32Fq51vX9fOBcUCEfXXWxA4WDMgsARtqYAAT1KfTU9FonjxvJDYpB3/x+18
         xh0jInBKsu0sahAIEc+s9V/UGRj78MuM4u41A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EvCmC7UDDiojjF1KUdL7ZPFkIHjxz1xIoQxXLCp0G78=;
        b=Ng99eRa9Cew9GPSLWN5RDnoxl75tvryr0fvPLkpcTgFUYN+qCSXImbvm+lMmvAA6G+
         OF5FGfwWsSEUfHHL5mmWHqPRVtpkJ3kcayd+jZ2xfxzqG/1KdbWbULCodr2rkBNzpVX2
         Iwu9LP7d7qkv5rJwtrMLbcEzzlZM1xqU41ieWiqXMmUQTXEYXLdLckLaOHUVa10ug3jE
         Q6yJYX7L5S2zYXkhfDATnL8OMl3FpPTEzzbqTSF68hyDiuX9qmqjQJhd4S3K7l0vTSco
         +//LfTWBYqXIzlu1Mk9ERXPYbPVFxmw368FbIsqB1YTS/AnsPjHuV0nQV1OSl2fGZAJI
         26Qw==
X-Gm-Message-State: AGRZ1gInPUD0ZBQUJIJ4FImnjyQFoikP4+RV8uVKxlXuDKmlNj/4FTtC
        MlhLn5aQI3Rq9BLiJGvnQ6+j0RMlRY8MZkEcPhCmpg==
X-Google-Smtp-Source: AJdET5eEwPb24BSb3j3fcpiRchAAfklOUxnxzUWkRKyufT/tXi1BNki3dMesD4/1FVvW4cmvAK3T2OLvf9wwRHZDFe0=
X-Received: by 2002:a24:47c5:: with SMTP id t188-v6mr2331948itb.78.1540999029494;
 Wed, 31 Oct 2018 08:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 08:16:28 -0700 (PDT)
In-Reply-To: <1540894589-4004-1-git-send-email-ludovic.Barre@st.com>
References: <1540894589-4004-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Oct 2018 16:16:28 +0100
Message-ID: <CAPDyKFoyvKeFFwvJppg=NFDQNnDmL83+BR0fhkX=5DwpsGZ11g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: add variant property to send stop cmd if a
 command fail
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

On 30 October 2018 at 11:16, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The mmc framework follows the requirement of SD_Specification:
> the STOP_TRANSMISSION is sent on multiple write/read commands
> and the stop command (alone), not needed on other ADTC commands.

Well, there is a bit more to it than that.

Host drivers may set MMC_CAP_CMD23 support, which means pre-defined
multi-block transfers, becomes preferable to open-ended ones.

However, even for pre-defined transfers, a CM12 (stop transmission)
should be sent, in case of data transfer errors. At least if I
understand the specs correctly.

By looking at the code in mmci_data_irq(), I realize that it's not
considering this case - so I think that need to be fixed as to start
with.

>
> But, if an error happens on command or data step, some variants
> require a stop command "STOP_TRANSMISION" to clear the DPSM
> "Data Path State Machine". If it's not done the next data
> command freezes hardware block.
> Needed to support the STM32 sdmmc variant.

I don't really follow this, sorry. Could you start by clarifying what
you mean by "data step", according to the above?

As far as I understand, you need to send a CMD12 to clear the DPSM, in
case of any errors happening during a data transfer (which includes
ADTC commands as well), right?

Or is there anything else to it?

Kind regards
Uffe

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  4 ++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 19650ed..ecedca3 100644
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
> @@ -57,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
>  #else
>  static inline void sdmmc_variant_init(struct mmci_host *host) {}
>  #endif
> +static void
> +mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
>
>  static unsigned int fmax = 515633;
>
> @@ -274,6 +277,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
>         .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
>         .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
>         .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
>         .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
>         .datactrl_first         = true,
> @@ -574,6 +578,24 @@ void mmci_dma_error(struct mmci_host *host)
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       /*
> +        * If an error happens on command or data step, some variants
> +        * require a stop command to reinit the DPSM.
> +        * If it's not done the next data command freeze hardware block.
> +        */
> +       if (host->variant->cmdreg_stop) {
> +               u32 dpsm;
> +
> +               dpsm = readl_relaxed(host->base + MMCISTATUS);
> +               dpsm &= MCI_STM32_DPSMACTIVE;
> +
> +               if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
> +                            (mrq->data && mrq->data->error))) {
> +                       mmci_start_command(host, &host->stop_abort, 0);
> +                       return;
> +               }
> +       }
> +
>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1106,6 +1128,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
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
> @@ -1957,6 +1983,13 @@ static int mmci_probe(struct amba_device *dev,
>                 mmc->max_busy_timeout = 0;
>         }
>
> +       /* prepare the stop command, used to abort and reinitialized the DPSM */
> +       if (variant->cmdreg_stop) {
> +               host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
> +               host->stop_abort.arg = 0;
> +               host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
> +       }
> +
>         mmc->ops = &mmci_ops;
>
>         /* We support these PM capabilities. */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index ec13d90..afb6ec4 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -166,6 +166,7 @@
>  #define MCI_ST_CEATAEND                (1 << 23)
>  #define MCI_ST_CARDBUSY                (1 << 24)
>  /* Extended status bits for the STM32 variants */
> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>  #define MCI_STM32_BUSYD0       BIT(20)
>
>  #define MMCICLEAR              0x038
> @@ -269,6 +270,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -322,6 +324,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> @@ -384,6 +387,7 @@ struct mmci_host {
>         void __iomem            *base;
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
> +       struct mmc_command      stop_abort;
>         struct mmc_data         *data;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
> --
> 2.7.4
>
