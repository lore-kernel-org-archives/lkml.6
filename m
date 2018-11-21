Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26293C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02132151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLKwboHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02132151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeKVEcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:32:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36835 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbeKVEcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:32:15 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so10162160itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xVor19JQROKickQvk655i16YO8AaQ8r2h6kHhuVRYlY=;
        b=HLKwboHpgom3depjlX+vyaOFC4zEgLoa07W5QjPD/go9lNsUspZZ3QwUV97KwkaFn+
         RuSQ9+80mGilIPU8r1ChLE4c1Ond/lTSVz2ZxQ1+UqN2RzVi6Zb/hAKES9B1CWzeIzvk
         HJnXpe81XCvJJ74vVgRefqokM57BRYCUyR6no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xVor19JQROKickQvk655i16YO8AaQ8r2h6kHhuVRYlY=;
        b=FO33QgD5d8o5MszQ1QeUZt4IZrv2AXRjfCnYQrB0rXDXDMlyroM4mUWno5kNKIEGgP
         Jd/qdQHsE9aQsqOId1jLKZAVBEvyQJKTRcLLJmJBlqsbvKa8jYJWfhElRTNXIrDqSExB
         pqZXgm3T+wuRH/zAE5UCxuPhzVny5a2YtfOWgVlw+1pLHkRtUptv9doVQQg8haYwG9W3
         YXH92Ev0eR8DLDaY0e2V1IwxAvNy4PuxYvU1TbOfYNiPeOlLkpd5vXierx5zRrKn4kkT
         8BsgzgsHpWjmEmLj/sCPlxABHoU5bKMHIEO49J64qg5aOKTBZC5QSanm1LWFQ58mBq4D
         C+qg==
X-Gm-Message-State: AA+aEWYa6TlI8FNAYoZP9XQJg5b1d9vLVW7a+Q126QvUoK9gRtj7YRqo
        hchsvw8SYdXCMeFaRK/mLBKdu+ItYUg9HqzyKCSWSdVSBvY=
X-Google-Smtp-Source: AFSGD/UPoZH0nKEdK8Ee/WcJ+y/Q3xWiQJyYAfu+LEXdlu8FU/2yBYhU7DANR4cxqzCHeV/WzlYGLyZ9MToXOiRINjE=
X-Received: by 2002:a24:108a:: with SMTP id 132-v6mr6446123ity.78.1542823012798;
 Wed, 21 Nov 2018 09:56:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:70c8:0:0:0:0:0 with HTTP; Wed, 21 Nov 2018 09:56:12
 -0800 (PST)
In-Reply-To: <1541583041-17461-3-git-send-email-ludovic.Barre@st.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com> <1541583041-17461-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Nov 2018 18:56:12 +0100
Message-ID: <CAPDyKFpZyYJbDDjYaFPfGEfKme6QedxcD715M2v7kAf7tpUf5A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: mmci: add variant property to send stop cmd
 if a command fail
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

On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> The mmc framework follows the requirement of SD_Specification:
> the STOP_TRANSMISSION is sent on multiple write/read commands
> and the stop command (alone), not needed on other ADTC commands.
>
> But, if an error happens on command or data transmission, some
> variants require a stop command "STOP_TRANSMISION" to clear the DPSM
> "Data Path State Machine". If it's not done the next data
> command freezes hardware block.
> Needed to support the STM32 sdmmc variant.

May I suggest some re-wording of this changelog, as to make it more
clear of why this is needed. Something along the lines of:

"The current approach with sending a CMD12 (STOP_TRANSMISSION) to
complete a data transfer request, either because of using the open
ended transmission type or because of receiving an error during a data
transfer, isn't sufficient for the STM32 sdmmc variant.

More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine" )
needs to be cleared by sending a CMD12, also for the so called ADTC
commands. For this reason, add a new mmci variant property and let the
driver send a CMD12 to complete ADTC commands, in case it's set."

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  4 ++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 13fa640..47b865d 100644
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
> @@ -573,6 +577,24 @@ void mmci_dma_error(struct mmci_host *host)
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> +       /*
> +        * If an error happens on command or data transmission, some variants
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

I would rather move this code to a separate function. Also, I think
you need something else (or additional) than polling the MMCISTATUS
register, as in principle you could end up sending CMD12 several times
for the same request, which isn't correct.

To me the best solution would probably be to make use of the
host->data pointer, as it becomes set when DPSM has been enabled.
However, host->data is also cleared in mmci_stop_data() which is being
called prior mmci_request_end(). In other words, we need to figure
under what conditions the new code above should be triggered/called
and then also change the conditions for when mmci_request_end() shall
be called.

In principle look at callers of mmci_request_end() and
mmci_stop_data() and update those paths.

> +       }
> +
>         writel(0, host->base + MMCICOMMAND);
>
>         BUG_ON(host->data);
> @@ -1100,6 +1122,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 mmci_reg_delay(host);
>         }
>
> +       if (host->variant->cmdreg_stop &&
> +           cmd->opcode == MMC_STOP_TRANSMISSION)
> +               c |= host->variant->cmdreg_stop;
> +

Hmm.

It looks like the above changes, together with the introduction of the
variant property, belongs in a separate patch, preceding $subject
patch in the series.

The reason is, that to me, it makes sense to add the special treatment
of the ADTC commands in a separate patch. Can you please split it up
and then of course update the change log accordingly!?

>         c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136)
> @@ -1950,6 +1976,13 @@ static int mmci_probe(struct amba_device *dev,
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
> index 550dd39..35372cd 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -161,6 +161,7 @@
>  #define MCI_ST_CEATAEND                (1 << 23)
>  #define MCI_ST_CARDBUSY                (1 << 24)
>  /* Extended status bits for the STM32 variants */
> +#define MCI_STM32_DPSMACTIVE   BIT(12)
>  #define MCI_STM32_BUSYD0       BIT(20)
>
>  #define MMCICLEAR              0x038
> @@ -264,6 +265,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -316,6 +318,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> @@ -375,6 +378,7 @@ struct mmci_host {
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

Kind regards
Uffe
