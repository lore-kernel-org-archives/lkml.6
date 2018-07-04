Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D3FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B5820899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NupzNERn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B5820899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGDNhn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37344 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeGDNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:40 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so8086608itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5y5837z6iuj6UC8VJ+ajNugJX5s7b1IviQNxU2aOWeo=;
        b=NupzNERnsH9vXw/hDehNL3uacTf331YKzfNtvHbmQBOFPNMrfdt0hH6mlBKB8IsU5M
         ciAKvEXbiaJubXKY/dkHdpjDrI+0187MeG5I17C13UsUT483CqTrGztritoOTELH6Zg5
         sZ51zifn2YyR/PDJdTKT+Vn95PUcKFHbZUYKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5y5837z6iuj6UC8VJ+ajNugJX5s7b1IviQNxU2aOWeo=;
        b=JkdZz3vPnjiB/Tl+QiSIf3pK/zNILk0SDNnueFURpaUMrwWV8exD6TZ/jlQvMghUy6
         ltPZ8RX3KIUl6DV0IHSkoxSsMjAOMJLcXQ531izOaPjXMgDR7c9PtVCvSHI0/sKpY3I7
         JZahYr3SoZLDT5NcvPVBvfPtNagfHpAfetK/aeLQ8/fHK2+9xqnEq8FV+SGu17etwGgc
         T9GIaL2R9oift0oXZBpUDqafR9YXNmo3UTLQPPaSmLy/EXNsNgG6LAlLNeNl2QI+TqfC
         dZur5+ugV6CjRvGLC0tx3n/3TyHR0fORlP1QpKScj2E1qbfGyYCM5xh8tSQLh1Wu28RQ
         OkbQ==
X-Gm-Message-State: APt69E2S9P9AL5w7Gk4hczTp8ZElBUtjnfpJiaDbYfHTBNOKrhlmdDNR
        YE5CMcEk+PxuFJTNoC8zxIyBFR68yYx8JKWX1tIVjA==
X-Google-Smtp-Source: AAOMgpfogTzjv+3sqQ6hh6TlQoc8Rtn4062c0eUngdKvm/DXLbz3QAOPUP1KK0FGy3fadXoacx+dOPX6/R3wLvrZGMM=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr1959940itc.102.1530711460076;
 Wed, 04 Jul 2018 06:37:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 06:37:39 -0700 (PDT)
In-Reply-To: <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 15:37:39 +0200
Message-ID: <CAPDyKFrbHcyy+rcVPrJAvO+y-ywQ=yE=gT3dbG2kqroQAhMF2Q@mail.gmail.com>
Subject: Re: [PATCH 13/19] mmc: mmci: send stop cmd if a data command fail
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
> The mmc framework follows the requirement of SD_Specification:
> the STOP_TRANSMISSION is sent on multiple write/read commands
> and the stop command (alone), not needed on other ADTC commands.
>
> But, some variants require a stop command "STOP_TRANSMISION" to clear
> the DPSM "Data Path State Machine" if an error happens on command or data
> step. If it's not done the next data command will freeze hardware block.
> Needed to support the STM32 sdmmc variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 36 +++++++++++++++++++++++++++++++-----
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 87724e1..9af7db8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -24,6 +24,7 @@
>  #include <linux/mmc/pm.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/amba/bus.h>
>  #include <linux/clk.h>
> @@ -522,11 +523,28 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
>         host->mask1_reg = mask;
>  }
>
> -static void mmci_stop_data(struct mmci_host *host)
> +static int mmci_stop_data(struct mmci_host *host)

Let's leave this as void function and instead add a check in
mmci_start_command(), to see if the command is a
MMC_STOP_TRANSMISSION. If so, then add host->variant->cmdreg_stop to
the register that is written in it.

And actually, I think this change alone should be a separate patch
coming before $subject patch in the series, as it addresses the first
problem of two.

>  {
> +       struct mmc_command *stop = &host->stop_abort;
> +       struct mmc_data *data = host->data;
> +       unsigned int cmd = 0;
> +
>         mmci_write_datactrlreg(host, 0);
>         mmci_set_mask1(host, 0);
>         host->data = NULL;
> +
> +       if (host->variant->cmdreg_stop) {
> +               cmd |= host->variant->cmdreg_stop;
> +               if (!data->stop) {
> +                       memset(stop, 0, sizeof(struct mmc_command));
> +                       stop->opcode = MMC_STOP_TRANSMISSION;
> +                       stop->arg = 0;
> +                       stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> +                       data->stop = stop;

I don't understand why you want the host->stop_abort being present in
the mmci host struct? Can we get rid of that?

Anyway, re-using the data->stop pointer seems reasonable.

> +               }
> +       }
> +
> +       return cmd;
>  }
>
>  static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
> @@ -703,6 +721,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>               unsigned int status)
>  {
>         unsigned int status_err;
> +       unsigned int cmd_reg = 0;
>
>         /* Make sure we have data to handle */
>         if (!data)
> @@ -761,7 +780,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>         if (status & MCI_DATAEND || data->error) {
>                 mmci_dma_finalize(host, data);
>
> -               mmci_stop_data(host);
> +               cmd_reg = mmci_stop_data(host);
>
>                 if (!data->error)
>                         /* The error clause is handled above, success! */
> @@ -770,7 +789,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 if (!data->stop || host->mrq->sbc) {
>                         mmci_request_end(host, data->mrq);
>                 } else {
> -                       mmci_start_command(host, data->stop, 0);
> +                       mmci_start_command(host, data->stop, cmd_reg);
>                 }
>         }
>  }
> @@ -780,6 +799,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>              unsigned int status)
>  {
>         void __iomem *base = host->base;
> +       struct mmc_data *data = host->data;
> +       unsigned int cmd_reg = 0;
>         bool sbc;
>
>         if (!cmd)
> @@ -865,11 +886,16 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         }
>
>         if ((!sbc && !cmd->data) || cmd->error) {
> -               if (host->data) {
> +               if (data) {
>                         /* Terminate the DMA transfer */
>                         mmci_dma_error(host);
>
> -                       mmci_stop_data(host);
> +                       cmd_reg = mmci_stop_data(host);
> +
> +                       if (data->stop) {

This means a change in behavior for !host->variant->cmdreg_stop
variants, because the mmc core may have assigned data->stop. Did you
test this path for any of the old variants?

The change as such anyway seems like a good idea. If we had data, we
may play safe and send a stop command to let the card to try to close
down the transfer. On the other hand, we don't want this to come as
side-effect, but rather it deserves is own standalone patch.

I guess there are two options going forward.
1) Split the patch and see if this works for other variants first and
the add your changes on top for the new ST variant.
2) Make this change only to affect the new ST variant.

I am fine with both.

> +                               mmci_start_command(host, data->stop, cmd_reg);
> +                               return;
> +                       }
>                 }
>                 mmci_request_end(host, host->mrq);
>         } else if (sbc) {
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 2d7e901..4b4cd1d 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -243,6 +243,7 @@ struct mmci_host;
>   * @cmdreg_lrsp_crc: enable value for long response with crc
>   * @cmdreg_srsp_crc: enable value for short response with crc
>   * @cmdreg_srsp: enable value for short response without crc
> + * @cmdreg_stop: enable value for stop and abort transmission
>   * @datalength_bits: number of bits in the MMCIDATALENGTH register
>   * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>   *           is asserted (likewise for RX)
> @@ -298,6 +299,7 @@ struct variant_data {
>         unsigned int            cmdreg_lrsp_crc;
>         unsigned int            cmdreg_srsp_crc;
>         unsigned int            cmdreg_srsp;
> +       unsigned int            cmdreg_stop;
>         unsigned int            datalength_bits;
>         unsigned int            fifosize;
>         unsigned int            fifohalfsize;
> @@ -343,6 +345,7 @@ struct mmci_host {
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
> +       struct mmc_command      stop_abort;
>         struct mmc_host         *mmc;
>         struct clk              *clk;
>         bool                    singleirq;
> --
> 2.7.4
>

Kind regards
Uffe
