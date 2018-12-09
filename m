Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6240920831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqGkAHn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6240920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeLIGBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:01:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39836 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:01:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so3832743pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zON7zlcAVCocl9y+d8mj7k02JkCt42bGGlfMifRWrZE=;
        b=RqGkAHn079ZHTRbvpmoLp6OhxlQet9lc9Pph7i9Sb1oAt5i0x5o8Qukv4A490rZAg2
         VB/ZYNk9SAm4PtxcN2hVcAcVPxPTB/g99q3W2FqwTPlVChC4Xz6h28SlXEglMqmVMn9w
         veiQw6b53diWCPqiB5R3Lmq855pA8MwlEwibg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zON7zlcAVCocl9y+d8mj7k02JkCt42bGGlfMifRWrZE=;
        b=onuY72Aj0gWne9F0zidUn5265NCq7shJhRxHbCEvdjqt6D5/Z7SgY+Ic5IeJ0FZMHK
         dXdv1pOsJ5/0IVSHjF2C+6dIjgbNbsp7bvsJcUxc4L4uHHiVg5dWNHAXhPTvM6KHaFZc
         sOpAGC0rdQouuEJgaXQF/cKnsI+shkB4SquM6UZTtSrpikrNjR187Wywi9/SdWjwiQzk
         xmyVSMwlHb7caEDKbiyg/zLp1btW/vjiawPJZhIpjQCV2d4b4kclYqUXXDKqTLd+YO/l
         tNIltpuKIEBOxf9zDtRq1PCWsQwSZiGIwEGj014IUFyiXNFH3owXiwOx85XueTdv3n46
         c4jA==
X-Gm-Message-State: AA+aEWaNwdQZuXraaV5uRy6tnOJg/PICI7tx5+xLUdeIAcBUsnge/3lT
        ijS7bHJF1hxJpMBxmqFSQD3QnIYicfhw9ncsJg/BfA==
X-Google-Smtp-Source: AFSGD/Vmdus5HkOeH3bjTbWi7mibzO6Xi+g0yjI/0SCyY3P0VxupNcQ2UFI73kKgFeIW/MoSD681tiExRgGwsN7fTJA=
X-Received: by 2002:a63:4c04:: with SMTP id z4mr7094955pga.312.1544335265191;
 Sat, 08 Dec 2018 22:01:05 -0800 (PST)
MIME-Version: 1.0
References: <1542873780-13911-1-git-send-email-jjian.zhou@mediatek.com>
 <CANMq1KCO7tUGpXBR6x8cWiVd+5if2sPxU5N9J2aiMtuWuff3eg@mail.gmail.com> <1543310856.15593.32.camel@mhfsdcap03>
In-Reply-To: <1543310856.15593.32.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 9 Dec 2018 14:00:53 +0800
Message-ID: <CANMq1KBwH9OqispbPf83TWDwbZ6KNj=Z5v+S7tYwBHnYtdTwWg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: add MT8183 SDIO driver support
To:     jjian.zhou@mediatek.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <Chaotian.Jing@mediatek.com>,
        Ryder.Lee@mediatek.com, linux-mmc@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        lkml <linux-kernel@vger.kernel.org>, yong.mao@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>, sean.wang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 5:27 PM Jjian Zhou <jjian.zhou@mediatek.com> wrote:
>
> On Mon, 2018-11-26 at 19:47 +0800, Nicolas Boichat wrote:
> > On Thu, Nov 22, 2018 at 4:03 PM Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> > >
> > > MT8183 need SDIO driver. So it need add new code
> > > to support it.
> >
> > The description does not seem to match what is going on below: I don't
> > see anything that is obviously MT8183-specific. At first glance, this
> > seems like a patch that makes it possible to enable MMC_CAP_SDIO_IRQ
> > ("cap-sdio-irq" dt property).
> >
> > Can you describe in more detail what is going on here?
>
> Hi Nicolas,
>    Thank you for your comments.
>
> Host wants to use the new method to signal/process SDIO IRQs, must
> enable MMC_CAPS_SDIO_IRQ_NOTHREAD and implement the ->ack_sdio_irq()
> callback. The current driver doesn't support it. This code makes it
> possible to enable SDIO IRQs by using the new method. It is described as
> "MT8183 need SDIO driver". Because it is tested based on MT8183.
> How about the below commit message:
>
> This code wants to support SDIO IRQs. It enables MMC_CAP_SDIO_IRQ &
> MMC_CAP2_SDIO_IRQ_NOTHREAD and implement the ->ack_sdio_irq() callback.

Sorry, I forgot to reply earlier.

"This patch enables support for SDIO IRQs" sounds better to me, but
that's for the commit message.

For the commit _title_, you should not need to mention MT8183 (we have
a similar out-of-tree patch on chromeos-3.18 for MT8173:
https://crrev.com/c/319366, so I assume it'd be useful on many MTK
SoCs). But you can mention that this is tested on MT8183 in the commit
message.

I'd use "mmc: mediatek: Add MMC_CAP_SDIO_IRQ support" as commit title.

Thanks,

>    Thanks a lot.
>
> >
> > > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > > Signed-off-by: Yong mao <yong.mao@mediatek.com>
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 48 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index 6334cc7..da2a047 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
> > >                 struct mmc_request *mrq, struct mmc_command *cmd)
> > >  {
> > >         u32 rawcmd;
> > > +       unsigned long flags;
> > >
> > >         WARN_ON(host->cmd);
> > >         host->cmd = cmd;
> > > @@ -1131,7 +1132,12 @@ static void msdc_start_command(struct msdc_host *host,
> > >         cmd->error = 0;
> > >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> > >
> > > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > > +               spin_lock_irqsave(&host->lock, flags);
> > >         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > > +               spin_unlock_irqrestore(&host->lock, flags);
> > > +
> > >         writel(cmd->arg, host->base + SDC_ARG);
> > >         writel(rawcmd, host->base + SDC_CMD);
> > >  }
> > > @@ -1351,6 +1357,27 @@ static void msdc_request_timeout(struct work_struct *work)
> > >         }
> > >  }
> > >
> > > +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > > +{
> > > +       unsigned long flags;
> > > +       struct msdc_host *host = mmc_priv(mmc);
> > > +
> > > +       if (enb)
> > > +               pm_runtime_get_sync(host->dev);
> > > +
> > > +       spin_lock_irqsave(&host->lock, flags);
> > > +       if (enb)
> > > +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > > +       else
> > > +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > > +       spin_unlock_irqrestore(&host->lock, flags);
> > > +
> > > +       if (!enb) {
> > > +               pm_runtime_mark_last_busy(host->dev);
> > > +               pm_runtime_put_autosuspend(host->dev);
> > > +       }
> > > +}
> > > +
> > >  static irqreturn_t msdc_irq(int irq, void *dev_id)
> > >  {
> > >         struct msdc_host *host = (struct msdc_host *) dev_id;
> > > @@ -1373,7 +1400,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> > >                 data = host->data;
> > >                 spin_unlock_irqrestore(&host->lock, flags);
> > >
> > > -               if (!(events & event_mask))
> > > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> > > +                       msdc_enable_sdio_irq(host->mmc, 0);
> > > +                       sdio_signal_irq(host->mmc);
> > > +               }
> > > +
> > > +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> > >                         break;
> > >
> > >                 if (!mrq) {
> > > @@ -1493,8 +1525,11 @@ static void msdc_init_hw(struct msdc_host *host)
> > >          */
> > >         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> > >
> > > -       /* disable detect SDIO device interrupt function */
> > > -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > > +       /* Config SDIO device detect interrupt function */
> > > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > > +       else
> > > +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > >
> > >         /* Configure to default data timeout */
> > >         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > > @@ -2013,6 +2048,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> > >         sdr_clr_bits(host->base + EMMC_IOCON, 1);
> > >  }
> > >
> > > +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> > > +{
> > > +       msdc_enable_sdio_irq(mmc, 1);
> > > +}
> > > +
> > >  static const struct mmc_host_ops mt_msdc_ops = {
> > >         .post_req = msdc_post_req,
> > >         .pre_req = msdc_pre_req,
> > > @@ -2020,6 +2060,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> > >         .set_ios = msdc_ops_set_ios,
> > >         .get_ro = mmc_gpio_get_ro,
> > >         .get_cd = mmc_gpio_get_cd,
> > > +       .enable_sdio_irq = msdc_enable_sdio_irq,
> > > +       .ack_sdio_irq = msdc_ack_sdio_irq,
> > >         .start_signal_voltage_switch = msdc_ops_switch_volt,
> > >         .card_busy = msdc_card_busy,
> > >         .execute_tuning = msdc_execute_tuning,
> > > @@ -2147,6 +2189,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
> > >         else
> > >                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
> > >
> > > +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> > > +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> > > +
> > >         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> > >         /* MMC core transfer sizes tunable parameters */
> > >         mmc->max_segs = MAX_BD_NUM;
> > > --
> > > 1.9.1
> > >
>
>
