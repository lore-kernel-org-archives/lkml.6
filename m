Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D91C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F317020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz/8Dqkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F317020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeJOVBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:01:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53198 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJOVBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:01:35 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so28547728itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mPPylqwYfXDattswl35P0/GSIgoCuVTuxx5faMjuSrM=;
        b=Tz/8DqkwngPrVYzw0C2eMUkntZIIh2w7YYKsqAvlI17LqV724Jn6MYxwyIa073T/pH
         g0EhhHnjr3xNbXy8LusvPPpqvQRmrMjjdkrigidJh7f2KChYDYStY6JDAC456cSlKdji
         JcbNilAwLnF9TEZb0am9HBTevx0NP/8bbr3yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mPPylqwYfXDattswl35P0/GSIgoCuVTuxx5faMjuSrM=;
        b=bZlMBBmyc+tnidmTw4kJZdQJnFQPMeaf5a2lVUPpVrwyAT3WjCsrikwy17+mBglmaq
         mLBsRf+F8IeVn7bnVVVax5ZoNF3mmNIlBnIjaNSO+EGKQUXObUvAmOuTSYt8dcmow9fU
         rTHEM2JSHUwJaGv3jLWe4MqrA6JNj53fnUPbRSONOrxXVi2waAJs+CZm6eal7A1g+/r8
         WrD1mgrNvUpFlxOVhG6PqU6miF43V0jhwwgFonjScUcI5gMG97dam0wxnb+zQQz508yf
         daxjB9YJoZ5m/S5EgL/qRrTfuPnhTZptmlZUxVfOOUqoB98m9zZ6gbNzkpkCzm2xUgRL
         /74w==
X-Gm-Message-State: ABuFfogDQPdljQFRkh5dKv9YcKgntF9IB7d5BwnPRf/w1PoXH7ikO1Hk
        rwbn7bc2/w7n+kgcNhvxpPC959RHx/Y0kMTd4D9+hA==
X-Google-Smtp-Source: ACcGV61302NSHW5Qtto1rGRedbGJ1TwMTXimI3BjykqMsSHifY4GzqEqOSGYW3mbG8PFEr/swtuTgpZqNUpue0UzgS8=
X-Received: by 2002:a02:c909:: with SMTP id t9-v6mr13910527jao.95.1539609378616;
 Mon, 15 Oct 2018 06:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:15:38
 -0700 (PDT)
In-Reply-To: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539356588-18191-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 15:15:38 +0200
Message-ID: <CAPDyKFoJfUyMi7oFo2pkxfEUTerNSBwHvJOB2d22xoPL4RTQUA@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: simplify the DMA mode test
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 17:03, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> host->chan_{rx,tx} represents the DMA capability of the platform.
> Even if DMA is supported, there are cases where we want to use PIO,
> for example, data length is short enough as commit 5f52c3552946
> ("mmc: tmio: use PIO for short transfers") mentioned.
>
> Regarding the hardware control flow, we are interested in whether DMA
> is currently enabled or not, instead of whether the platform has the
> DMA capability.
>
> Hence, the several conditionals in tmio_mmc_core.c end up with
> checking host->chan_{rx,tx} and !host->force_pio. This is not nice.
>
> Let's flip the flag host->force_pio into host->dma_on.
>
> host->dma_on represents whether the DMA is currently enabled or not.
> This flag is set false in the beginning of each command, then should
> be set true by tmio_mmc_start_dma() when the DMA is turned on.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 ++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 10 ++++------
>  drivers/mmc/host/tmio_mmc.h                   |  2 +-
>  drivers/mmc/host/tmio_mmc_core.c              | 14 +++++++-------
>  drivers/mmc/host/uniphier-sd.c                |  6 ++++--
>  5 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index ca0b439..885676b 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -201,13 +201,14 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
>         renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
>                                             sg_dma_address(sg));
>
> +       host->dma_on = true;
> +
>         return;
>
>  force_pio_with_unmap:
>         dma_unmap_sg(&host->pdev->dev, sg, host->sg_len, mmc_get_dma_dir(data));
>
>  force_pio:
> -       host->force_pio = true;
>         renesas_sdhi_internal_dmac_enable_dma(host, false);
>  }
>
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 5389c48..3c97831 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -213,10 +213,8 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
>                 goto pio;
>         }
>
> -       if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
> -               host->force_pio = true;
> +       if (sg->length < TMIO_MMC_MIN_DMA_LEN)
>                 return;
> -       }
>
>         /* The only sg element can be unaligned, use our bounce buffer then */
>         if (!aligned) {
> @@ -240,6 +238,7 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
>                         desc = NULL;
>                         ret = cookie;
>                 }
> +               host->dma_on = true;
>         }
>  pio:
>         if (!desc) {
> @@ -286,10 +285,8 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
>                 goto pio;
>         }
>
> -       if (sg->length < TMIO_MMC_MIN_DMA_LEN) {
> -               host->force_pio = true;
> +       if (sg->length < TMIO_MMC_MIN_DMA_LEN)
>                 return;
> -       }
>
>         /* The only sg element can be unaligned, use our bounce buffer then */
>         if (!aligned) {
> @@ -318,6 +315,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
>                         desc = NULL;
>                         ret = cookie;
>                 }
> +               host->dma_on = true;
>         }
>  pio:
>         if (!desc) {
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 18b4308..1c3bdad 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -142,7 +142,7 @@ struct tmio_mmc_host {
>         struct tmio_mmc_data *pdata;
>
>         /* DMA support */
> -       bool                    force_pio;
> +       bool                    dma_on;
>         struct dma_chan         *chan_rx;
>         struct dma_chan         *chan_tx;
>         struct tasklet_struct   dma_issue;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index a571106..38be3fc 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -364,7 +364,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
>         unsigned int count;
>         unsigned long flags;
>
> -       if ((host->chan_tx || host->chan_rx) && !host->force_pio) {
> +       if (host->dma_on) {
>                 pr_err("PIO IRQ in DMA mode!\n");
>                 return;
>         } else if (!data) {
> @@ -436,7 +436,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
>          */
>
>         if (data->flags & MMC_DATA_READ) {
> -               if (host->chan_rx && !host->force_pio)
> +               if (host->dma_on)
>                         tmio_mmc_check_bounce_buffer(host);
>                 dev_dbg(&host->pdev->dev, "Complete Rx request %p\n",
>                         host->mrq);
> @@ -473,7 +473,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
>         if (stat & TMIO_STAT_CRCFAIL || stat & TMIO_STAT_STOPBIT_ERR ||
>             stat & TMIO_STAT_TXUNDERRUN)
>                 data->error = -EILSEQ;
> -       if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && !host->force_pio) {
> +       if (host->dma_on && (data->flags & MMC_DATA_WRITE)) {
>                 u32 status = sd_ctrl_read16_and_16_as_32(host, CTL_STATUS);
>                 bool done = false;
>
> @@ -497,7 +497,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
>                         tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
>                         tmio_mmc_dataend_dma(host);
>                 }
> -       } else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
> +       } else if (host->dma_on && (data->flags & MMC_DATA_READ)) {
>                 tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
>                 tmio_mmc_dataend_dma(host);
>         } else {
> @@ -550,7 +550,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
>          */
>         if (host->data && (!cmd->error || cmd->error == -EILSEQ)) {
>                 if (host->data->flags & MMC_DATA_READ) {
> -                       if (host->force_pio || !host->chan_rx) {
> +                       if (!host->dma_on) {
>                                 tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
>                         } else {
>                                 tmio_mmc_disable_mmc_irqs(host,
> @@ -558,7 +558,7 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *host, unsigned int stat)
>                                 tasklet_schedule(&host->dma_issue);
>                         }
>                 } else {
> -                       if (host->force_pio || !host->chan_tx) {
> +                       if (!host->dma_on) {
>                                 tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
>                         } else {
>                                 tmio_mmc_disable_mmc_irqs(host,
> @@ -688,7 +688,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
>
>         tmio_mmc_init_sg(host, data);
>         host->data = data;
> -       host->force_pio = false;
> +       host->dma_on = false;
>
>         /* Set transfer length / blocksize */
>         sd_ctrl_write16(host, CTL_SD_XFER_LEN, data->blksz);
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
> index 1ee9fd0..91a2be4 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -157,13 +157,14 @@ static void uniphier_sd_external_dma_start(struct tmio_mmc_host *host,
>         if (cookie < 0)
>                 goto unmap_sg;
>
> +       host->dma_on = true;
> +
>         return;
>
>  unmap_sg:
>         dma_unmap_sg(mmc_dev(host->mmc), host->sg_ptr, host->sg_len,
>                      priv->dma_dir);
>  force_pio:
> -       host->force_pio = true;
>         uniphier_sd_dma_endisable(host, 0);
>  }
>
> @@ -283,9 +284,10 @@ static void uniphier_sd_internal_dma_start(struct tmio_mmc_host *host,
>         writel(lower_32_bits(dma_addr), host->ctl + UNIPHIER_SD_DMA_ADDR_L);
>         writel(upper_32_bits(dma_addr), host->ctl + UNIPHIER_SD_DMA_ADDR_H);
>
> +       host->dma_on = true;
> +
>         return;
>  force_pio:
> -       host->force_pio = true;
>         uniphier_sd_dma_endisable(host, 0);
>  }
>
> --
> 2.7.4
>
