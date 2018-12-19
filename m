Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13F3217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVjCaFqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeLSJSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:18:44 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44945 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbeLSJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:18:44 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so11803535vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSVOxWjXIUXef9Dklx0hH0r/WZbFPxfM5408rI07BrY=;
        b=eVjCaFqTJ8w/XBYhLHUmw1J5FvUpAY5NNZM6dsZqEAUgVZLVOJ0e1yFD7VM+xplMkW
         nf38yoWaXK+S/OXHdOGlTP8YntFkMcymw69yi2t74Y4R+NNCO4+3VKOrXsc/tyC2p/ex
         /bWSn2fo9gy/Ge07YKyvf+tqhjNbqsW/SlRK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSVOxWjXIUXef9Dklx0hH0r/WZbFPxfM5408rI07BrY=;
        b=t5iu5bIavCak2hkUevtuwqNdpBwkIg+Pu5K3QYDvHScscP2b0Z3/B+/d1SqhQyQYMe
         Q9W1KAaVE9FaHiMneYtp1H9VgDWx2g201Y4lv4lV8d4waUkvv56/y2NG9b11KJA0Nldk
         ii5c1jLhLYuXoi+aukO5L5b/st9nt8OzucoH1Ds6JSE92Sm2WEKtklmi81KPcg1sugt7
         pSt9fYQ8XmQAYBE774gJ6nkaxl7xZ4QTKSDtVTcCer1CsPYZCA8Jg9/jdKEU2we5HtI2
         bngtdz/fzH/jFtUWXNHbcj68zx+UiIdFC3/PzCevrjESciGw6pZdxauaqWa1cQIclAyM
         d4WQ==
X-Gm-Message-State: AA+aEWaqRhc/hSuimd7YgI1DWigCzLZ0fo/yLPVBERpgmOogmYHE93O5
        Gup8Fw55sjm6s3mshSBjRI8n7u/f+fsrZm+Al+IJ7g==
X-Google-Smtp-Source: AFSGD/Vq3ftIQg45Dq5PZEKSkdqk6S5f/h59JZEaOR1FSiADKNeQs8GmU3yKlCrl9bR6ogxM5IBeRNOp08mNloWfsKw=
X-Received: by 2002:a67:7685:: with SMTP id r127mr9725315vsc.35.1545211122817;
 Wed, 19 Dec 2018 01:18:42 -0800 (PST)
MIME-Version: 1.0
References: <1545136398-5066-1-git-send-email-jjian.zhou@mediatek.com>
In-Reply-To: <1545136398-5066-1-git-send-email-jjian.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 10:18:06 +0100
Message-ID: <CAPDyKFr+TYXCEDtsdXQ5tLNqDv1yx2zPh+yiURmq_wji9q4cAg@mail.gmail.com>
Subject: Re: [v4] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
To:     Jjian Zhou <jjian.zhou@mediatek.com>
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

On Tue, 18 Dec 2018 at 13:33, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 53 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 6334cc7..8afeaf8 100644
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
>         writel(cmd->arg, host->base + SDC_ARG);
>         writel(rawcmd, host->base + SDC_CMD);
>  }
> @@ -1351,6 +1355,31 @@ static void msdc_request_timeout(struct work_struct *work)
>         }
>  }
>
> +static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (enb)
> +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       else
> +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> +{
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       __msdc_enable_sdio_irq(mmc, enb);
> +
> +       if (enb)
> +               pm_runtime_get_noresume(host->dev);
> +       else
> +               pm_runtime_put_noidle(host->dev);
> +}
> +
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
>         struct msdc_host *host = (struct msdc_host *) dev_id;
> @@ -1373,7 +1402,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>                 data = host->data;
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> -               if (!(events & event_mask))
> +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> +                       __msdc_enable_sdio_irq(host->mmc, 0);
> +                       sdio_signal_irq(host->mmc);
> +               }
> +
> +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
>                         break;
>
>                 if (!mrq) {
> @@ -1493,8 +1527,11 @@ static void msdc_init_hw(struct msdc_host *host)
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
> @@ -2013,6 +2050,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         sdr_clr_bits(host->base + EMMC_IOCON, 1);
>  }
>
> +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       __msdc_enable_sdio_irq(mmc, 1);
> +}
> +
>  static const struct mmc_host_ops mt_msdc_ops = {
>         .post_req = msdc_post_req,
>         .pre_req = msdc_pre_req,
> @@ -2020,6 +2062,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .set_ios = msdc_ops_set_ios,
>         .get_ro = mmc_gpio_get_ro,
>         .get_cd = mmc_gpio_get_cd,
> +       .enable_sdio_irq = msdc_enable_sdio_irq,
> +       .ack_sdio_irq = msdc_ack_sdio_irq,
>         .start_signal_voltage_switch = msdc_ops_switch_volt,
>         .card_busy = msdc_card_busy,
>         .execute_tuning = msdc_execute_tuning,
> @@ -2147,6 +2191,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
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
