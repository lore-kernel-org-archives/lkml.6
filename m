Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD412081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2lTS7wb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD412081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLKJ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:29:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33310 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:29:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so8473311vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXRx8P4XTyfhPJqyVW9CVmbIqSJ8UU3vsH6S7dbXOj0=;
        b=H2lTS7wbJhWxhnDWmbS7dW4Ud3IcShM8ZY29OKehmplZ5mXu2VpKGI5n87PfA+0IRj
         WZZvQFzcQwOGoBf1oVFvqNNQ8ES0ACeCRl+QmifGcWxeEQQZqNj6YkxV/cgArmWp08DF
         DLSBVoAoBVrTPUfuYu2zz7Yq1ftyRukIchLew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXRx8P4XTyfhPJqyVW9CVmbIqSJ8UU3vsH6S7dbXOj0=;
        b=UX4UDEGseiw1YIFB9CxZp7s4yqMSqwVcMHA+V5+m7hE6tYmOmpAUB6Zm2kM1/S/yb3
         wUYaFOAZC9mXJq5WdesPG77RBgeERYgMNqL1BSnw/3hQrO+Mardd5wRqrCOgmgn4L8+P
         OLXNCLgcULCGexEpuiXtTQ/wt+tDdBW4aJt535W8c3zgAYhR3wMfqz2PqBI//DTbRV+Z
         hdj2kC/KZYcUOjsMSV4+UqktZgT4H1J91GNFgWq7CdTrUXPis05EOAtvwlL02BudapoA
         I52eg0r6NUnuPybGkJUUZcC3EXtxL2xMtK2XRbWX6uu9RBnGoaxFBUvjLtn2Cr1dzFbO
         0wFQ==
X-Gm-Message-State: AA+aEWZmHLHsw2PeWmexueVc4FaCba7+kH658QMp7sw4m9OKAQfP6w1k
        5bXfjRq/i3xAZizpG8cfJuaWqHIEVOTzLdbGr2/gHQ==
X-Google-Smtp-Source: AFSGD/VBeSJOK9ht7gt8byvv4bPE2jXlM2MM8lrbwqoOmsqsTxHRNdXQdw2Z7jLrLD8XzJfH8NcROH98432MGIlW1Oo=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr6814477vsi.191.1544520587619;
 Tue, 11 Dec 2018 01:29:47 -0800 (PST)
MIME-Version: 1.0
References: <1544442233-20303-1-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1544442233-20303-1-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Dec 2018 10:29:11 +0100
Message-ID: <CAPDyKFq2xH2m4JTbOwbh38mqjbwLRNewuYEVyOKCsBAPrUm9Dg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
To:     jjian.zhou@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Mao <yong.mao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 12:44, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> From: jjian zhou <jjian.zhou@mediatek.com>
>
> This patch enables support SDIO IRQs. It enables
> MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
> and implement the ->ack_sdio_irq callback.
>
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6334cc7..40a1848 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
>         u32 rawcmd;
> +       unsigned long flags;
>
>         WARN_ON(host->cmd);
>         host->cmd = cmd;
> @@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
>         cmd->error = 0;
>         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +

The above looks like a reasonable change, however does it really
belong in $subject patch. If so, can you explain why?

Maybe you should move this into a standalone separate patch?

>         writel(cmd->arg, host->base + SDC_ARG);
>         writel(rawcmd, host->base + SDC_CMD);
>  }
> @@ -1351,6 +1355,27 @@ static void msdc_request_timeout(struct work_struct *work)
>         }
>  }
>
> +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       if (enb)
> +               pm_runtime_get_sync(host->dev);

I would convert to pm_runtime_get_noresume() as the host is already
been runtime resumed by the mmc core.

> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (enb)
> +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       else
> +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       spin_unlock_irqrestore(&host->lock, flags);

You should move the code above into a separate function. Along the lines of:

static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)

You need this, because you will otherwise mess up the runtime PM usage
count when acking the SDIO irq. More comments about that below.

> +
> +       if (!enb) {
> +               pm_runtime_mark_last_busy(host->dev);
> +               pm_runtime_put_autosuspend(host->dev);

Convert to pm_runtime_put_noidle(), as the above is already managed by
the mmc core.

> +       }
> +}
> +
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
>         struct msdc_host *host = (struct msdc_host *) dev_id;
> @@ -1373,7 +1398,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 data = host->data;
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> -               if (!(events & event_mask))
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> +                       msdc_enable_sdio_irq(host->mmc, 0);

To not mess up the runtime PM reference count and to avoid invoking
runtime PM callbacks from atomic context, I suggest you call
__msdc_enable_sdio_irq(host->mmc, 0) (new proposed function according
to earlier comment).

> +                       sdio_signal_irq(host->mmc);
> +               }
> +
> +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
>                         break;
>
>                 if (!mrq) {
> @@ -1493,8 +1523,11 @@ static void msdc_init_hw(struct msdc_host *host)
>          */
>         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>
> -       /* disable detect SDIO device interrupt function */
> -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       /* Config SDIO device detect interrupt function */
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       else
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> @@ -2013,6 +2046,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         sdr_clr_bits(host->base + EMMC_IOCON, 1);
>  }
>
> +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       msdc_enable_sdio_irq(mmc, 1);

To not mess up the runtime PM reference count, I suggest you call
__msdc_enable_sdio_irq(host->mmc, 1) (new proposed function according
to earlier comment).

> +}
> +
>  static const struct mmc_host_ops mt_msdc_ops = {
>         .post_req = msdc_post_req,
>         .pre_req = msdc_pre_req,
> @@ -2020,6 +2058,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .set_ios = msdc_ops_set_ios,
>         .get_ro = mmc_gpio_get_ro,
>         .get_cd = mmc_gpio_get_cd,
> +       .enable_sdio_irq = msdc_enable_sdio_irq,
> +       .ack_sdio_irq = msdc_ack_sdio_irq,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
>         .card_busy = msdc_card_busy,
>         .execute_tuning = msdc_execute_tuning,
> @@ -2147,6 +2187,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         else
>                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
>
> +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
>         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>         /* MMC core transfer sizes tunable parameters */
>         mmc->max_segs = MAX_BD_NUM;
> --
> 1.9.1
>

Kind regards
Uffe
