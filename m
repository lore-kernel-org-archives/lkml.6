Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AB4208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AB4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeK0UZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:25:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62401 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729656AbeK0UZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:25:08 -0500
X-UUID: 3cbd24d186904ce381dcdb11227a27ab-20181127
X-UUID: 3cbd24d186904ce381dcdb11227a27ab-20181127
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <jjian.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1917544905; Tue, 27 Nov 2018 17:27:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 17:27:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Nov 2018 17:27:36 +0800
Message-ID: <1543310856.15593.32.camel@mhfsdcap03>
Subject: Re: [PATCH v2] mmc: mediatek: add MT8183 SDIO driver support
From:   Jjian Zhou <jjian.zhou@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= 
        <Chaotian.Jing@mediatek.com>,
        Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?= 
        <Ryder.Lee@mediatek.com>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yong Mao =?UTF-8?Q?=28=E6=AF=9B=E5=8B=87=29?= 
        <yong.mao@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 27 Nov 2018 17:27:36 +0800
In-Reply-To: <CANMq1KCO7tUGpXBR6x8cWiVd+5if2sPxU5N9J2aiMtuWuff3eg@mail.gmail.com>
References: <1542873780-13911-1-git-send-email-jjian.zhou@mediatek.com>
         <CANMq1KCO7tUGpXBR6x8cWiVd+5if2sPxU5N9J2aiMtuWuff3eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 19:47 +0800, Nicolas Boichat wrote:
> On Thu, Nov 22, 2018 at 4:03 PM Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> >
> > MT8183 need SDIO driver. So it need add new code
> > to support it.
> 
> The description does not seem to match what is going on below: I don't
> see anything that is obviously MT8183-specific. At first glance, this
> seems like a patch that makes it possible to enable MMC_CAP_SDIO_IRQ
> ("cap-sdio-irq" dt property).
> 
> Can you describe in more detail what is going on here?

Hi Nicolas,
   Thank you for your comments.

Host wants to use the new method to signal/process SDIO IRQs, must
enable MMC_CAPS_SDIO_IRQ_NOTHREAD and implement the ->ack_sdio_irq()
callback. The current driver doesn't support it. This code makes it
possible to enable SDIO IRQs by using the new method. It is described as
"MT8183 need SDIO driver". Because it is tested based on MT8183. 
How about the below commit message:

This code wants to support SDIO IRQs. It enables MMC_CAP_SDIO_IRQ &
MMC_CAP2_SDIO_IRQ_NOTHREAD and implement the ->ack_sdio_irq() callback.

   Thanks a lot.

> 
> > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > Signed-off-by: Yong mao <yong.mao@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 6334cc7..da2a047 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
> >                 struct mmc_request *mrq, struct mmc_command *cmd)
> >  {
> >         u32 rawcmd;
> > +       unsigned long flags;
> >
> >         WARN_ON(host->cmd);
> >         host->cmd = cmd;
> > @@ -1131,7 +1132,12 @@ static void msdc_start_command(struct msdc_host *host,
> >         cmd->error = 0;
> >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> >
> > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               spin_lock_irqsave(&host->lock, flags);
> >         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               spin_unlock_irqrestore(&host->lock, flags);
> > +
> >         writel(cmd->arg, host->base + SDC_ARG);
> >         writel(rawcmd, host->base + SDC_CMD);
> >  }
> > @@ -1351,6 +1357,27 @@ static void msdc_request_timeout(struct work_struct *work)
> >         }
> >  }
> >
> > +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > +{
> > +       unsigned long flags;
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       if (enb)
> > +               pm_runtime_get_sync(host->dev);
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       if (enb)
> > +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       else
> > +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +       if (!enb) {
> > +               pm_runtime_mark_last_busy(host->dev);
> > +               pm_runtime_put_autosuspend(host->dev);
> > +       }
> > +}
> > +
> >  static irqreturn_t msdc_irq(int irq, void *dev_id)
> >  {
> >         struct msdc_host *host = (struct msdc_host *) dev_id;
> > @@ -1373,7 +1400,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >                 data = host->data;
> >                 spin_unlock_irqrestore(&host->lock, flags);
> >
> > -               if (!(events & event_mask))
> > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> > +                       msdc_enable_sdio_irq(host->mmc, 0);
> > +                       sdio_signal_irq(host->mmc);
> > +               }
> > +
> > +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> >                         break;
> >
> >                 if (!mrq) {
> > @@ -1493,8 +1525,11 @@ static void msdc_init_hw(struct msdc_host *host)
> >          */
> >         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> >
> > -       /* disable detect SDIO device interrupt function */
> > -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       /* Config SDIO device detect interrupt function */
> > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       else
> > +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> >         /* Configure to default data timeout */
> >         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > @@ -2013,6 +2048,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         sdr_clr_bits(host->base + EMMC_IOCON, 1);
> >  }
> >
> > +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> > +{
> > +       msdc_enable_sdio_irq(mmc, 1);
> > +}
> > +
> >  static const struct mmc_host_ops mt_msdc_ops = {
> >         .post_req = msdc_post_req,
> >         .pre_req = msdc_pre_req,
> > @@ -2020,6 +2060,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         .set_ios = msdc_ops_set_ios,
> >         .get_ro = mmc_gpio_get_ro,
> >         .get_cd = mmc_gpio_get_cd,
> > +       .enable_sdio_irq = msdc_enable_sdio_irq,
> > +       .ack_sdio_irq = msdc_ack_sdio_irq,
> >         .start_signal_voltage_switch = msdc_ops_switch_volt,
> >         .card_busy = msdc_card_busy,
> >         .execute_tuning = msdc_execute_tuning,
> > @@ -2147,6 +2189,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >         else
> >                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
> >
> > +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> > +
> >         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> >         /* MMC core transfer sizes tunable parameters */
> >         mmc->max_segs = MAX_BD_NUM;
> > --
> > 1.9.1
> >


