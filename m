Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5055BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A6D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="En3QXAdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A6D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2Vvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:51:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46664 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeK2Vvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:51:46 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so1452949edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ip1s5/eUtCFzB9tpB9q7uRXi2PSiBjYmNwyBewdZMP0=;
        b=En3QXAdlTwWk/0n7H37oKG+Gxxr4n9G5ytAfaMASlm22HN6GzOyUtZB5Ghb91OxKfn
         7OQd+U1M9YRQSsnHdW+Bj7d89opIkbPAtJDSIlKzcVr2PLbY34xtC2IG7jvuyUqZa1jl
         g7mO5DxTZQaWhxJFVhKCzjnBkA+nsUpYGnOGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ip1s5/eUtCFzB9tpB9q7uRXi2PSiBjYmNwyBewdZMP0=;
        b=DXJIb9rqFAbOtBfgB9BTPN4UXISOADKENCdBEJboHgg5uZiCU3YSAsUES2PT3X5VOS
         GZB3X8WPNiLvoQFzy+uo3JuwVJ/IS/313vYyNNTVTcapoG0sHJIvQMTH+jOYAHhAE1zu
         X7D643fzw+PqpoMYMm9OQWERFEAk+1LKiBSe5Jsw9ehyCrpMZVI+Fn6myzcVw/z38nFR
         sF7kAftG+s068iobzbXa7U+FEpq9ZVYnd9KNi531G+hwo4a7s+5BGOF1M+9zlGgfuD37
         gMY/MaFEZrhuLDyeL2YjKjUPiHB93MB5W8v0og0DvDriggT3yMLGp/rqkRq46u2BlXca
         t+iA==
X-Gm-Message-State: AA+aEWYk5K/WafCmGX5o8WnTMM/PHKjBXsa9crlv5Sbqddmce2sBSaFp
        wv+nfkLZAmsQtKS1kN98/sGaiG9OTrAD73BYwVIOLQ==
X-Google-Smtp-Source: AFSGD/VwviGWEDM9TJofM2YU/qnPWu4IJ63rLYlwJs5240a3xg1dxCbM32/L9Jc4MYuJe7GqfHpKphkRzQrEurcTRdE=
X-Received: by 2002:a50:9f64:: with SMTP id b91mr1185166edf.235.1543488408937;
 Thu, 29 Nov 2018 02:46:48 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <cb2cdfb9-f3e6-72cd-2d55-734b08ea3e15@intel.com> <CAAfSe-tw-pEdFBTjeGBQD03QdNMkdnHdf8=2J01Qczf54yJ9CA@mail.gmail.com>
 <9cbb0593-f817-5388-e379-0f7d33cb66b3@intel.com>
In-Reply-To: <9cbb0593-f817-5388-e379-0f7d33cb66b3@intel.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Thu, 29 Nov 2018 18:46:37 +0800
Message-ID: <CAG2=9p9h-uOhVgeBK8kpJs1cODX5ZiqXSXX1JVp8E8Mcm63yFg@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Lyra Zhang <zhang.lyra@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 18:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/11/18 11:44 AM, Chunyan Zhang wrote:
> > On Thu, 29 Nov 2018 at 17:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 29/11/18 8:07 AM, Chunyan Zhang wrote:
> >>> Some standard SD host controllers can support both external dma
> >>> controllers as well as ADMA/SDMA in which the SD host controller
> >>> acts as DMA master. TI's omap controller is the case as an example.
> >>>
> >>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> >>> the host controller but does not have any support for external DMA
> >>> controllers implemented using dmaengine, meaning that custom code is
> >>> needed for any systems that use an external DMA controller with SDHCI.
> >>>
> >>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> >>> ---
> >>>  drivers/mmc/host/Kconfig |  14 ++++
> >>>  drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  drivers/mmc/host/sdhci.h |   8 ++
> >>>  3 files changed, 206 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>> index 1b58739..4183f43 100644
> >>> --- a/drivers/mmc/host/Kconfig
> >>> +++ b/drivers/mmc/host/Kconfig
> >>> @@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
> >>>  config MMC_SDHCI_OMAP
> >>>       tristate "TI SDHCI Controller Support"
> >>>       depends on MMC_SDHCI_PLTFM && OF
> >>> +     select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
> >>>       help
> >>>         This selects the Secure Digital Host Controller Interface (SDHCI)
> >>>         support present in TI's DRA7 SOCs. The controller supports
> >>> @@ -977,3 +978,16 @@ config MMC_SDHCI_OMAP
> >>>         If you have a controller with this interface, say Y or M here.
> >>>
> >>>         If unsure, say N.
> >>> +
> >>> +config MMC_SDHCI_EXTERNAL_DMA
> >>> +        bool "Support external DMA in standard SD host controller"
> >>> +     depends on MMC_SDHCI
> >>> +     depends on DMA_ENGINE
> >>> +     help
> >>> +       This is an option for using external DMA device via dmaengine
> >>> +       framework.
> >>> +
> >>> +       If you have a controller which support using external DMA device
> >>> +       for data transfer, can say Y.
> >>> +
> >>> +       If unsure, say N.
> >>
> >> So if you are going to select this, then you don't need the prompt or help
> >> anymore i.e.
> >>
> >> config MMC_SDHCI_EXTERNAL_DMA
> >>         bool
> >>
> >>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 99bdae5..ad7cc80 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -14,6 +14,7 @@
> >>>   */
> >>>
> >>>  #include <linux/delay.h>
> >>> +#include <linux/dmaengine.h>
> >>>  #include <linux/ktime.h>
> >>>  #include <linux/highmem.h>
> >>>  #include <linux/io.h>
> >>> @@ -1309,6 +1310,162 @@ static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
> >>>               del_timer(&host->timer);
> >>>  }
> >>>
> >>> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> >>> +static int sdhci_external_dma_init(struct sdhci_host *host)
> >>> +{
> >>> +     int ret = 0;
> >>> +     struct mmc_host *mmc = host->mmc;
> >>> +
> >>> +     host->tx_chan = dma_request_chan(mmc->parent, "tx");
> >>> +     if (IS_ERR(host->tx_chan)) {
> >>> +             ret = PTR_ERR(host->tx_chan);
> >>> +             if (ret != -EPROBE_DEFER)
> >>> +                     pr_warn("Failed to request TX DMA channel.\n");
> >>> +             host->tx_chan = NULL;
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     host->rx_chan = dma_request_chan(mmc->parent, "rx");
> >>> +     if (IS_ERR(host->rx_chan)) {
> >>> +             if (host->tx_chan) {
> >>> +                     dma_release_channel(host->tx_chan);
> >>> +                     host->tx_chan = NULL;
> >>> +             }
> >>> +
> >>> +             ret = PTR_ERR(host->rx_chan);
> >>> +             if (ret != -EPROBE_DEFER)
> >>> +                     pr_warn("Failed to request RX DMA channel.\n");
> >>> +             host->rx_chan = NULL;
> >>> +     }
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static inline struct dma_chan *
> >>> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
> >>> +{
> >>> +     return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
> >>> +}
> >>> +
> >>> +static int sdhci_external_dma_setup(struct sdhci_host *host,
> >>> +                                 struct mmc_command *cmd)
> >>> +{
> >>> +     int ret, i;
> >>> +     struct dma_async_tx_descriptor *desc;
> >>> +     struct mmc_data *data = cmd->data;
> >>> +     struct dma_chan *chan;
> >>> +     struct dma_slave_config cfg;
> >>> +     dma_cookie_t cookie;
> >>> +
> >>> +     if (!host->mapbase)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (!data)
> >>> +             return 0;
> >>
> >> It would read better if the above 2 if-statements were the other way around i.e.
> >>
> >>         if (!data)
> >>                 return 0;
> >>
> >>         if (!host->mapbase)
> >>                 return -EINVAL;
> >>
> >
> > Ok.
> >
> >>> +
> >>> +     cfg.src_addr = host->mapbase + SDHCI_BUFFER;
> >>> +     cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
> >>> +     cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +     cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +     cfg.src_maxburst = data->blksz / 4;
> >>> +     cfg.dst_maxburst = data->blksz / 4;
> >>> +
> >>> +     /* Sanity check: all the SG entries must be aligned by block size. */
> >>> +     for (i = 0; i < data->sg_len; i++) {
> >>> +             if ((data->sg + i)->length % data->blksz)
> >>> +                     return -EINVAL;
> >>> +     }
> >>> +
> >>> +     chan = sdhci_external_dma_channel(host, data);
> >>> +
> >>> +     ret = dmaengine_slave_config(chan, &cfg);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> >>> +                                    mmc_get_dma_dir(data),
> >>> +                                    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> >>> +     if (!desc)
> >>> +             return -EINVAL;
> >>> +
> >>> +     desc->callback = NULL;
> >>> +     desc->callback_param = NULL;
> >>> +
> >>> +     cookie = dmaengine_submit(desc);
> >>> +     if (cookie < 0)
> >>> +             ret = cookie;
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static void sdhci_external_dma_release(struct sdhci_host *host)
> >>> +{
> >>> +     if (host->tx_chan) {
> >>> +             dma_release_channel(host->tx_chan);
> >>> +             host->tx_chan = NULL;
> >>> +     }
> >>> +
> >>> +     if (host->rx_chan) {
> >>> +             dma_release_channel(host->rx_chan);
> >>> +             host->rx_chan = NULL;
> >>> +     }
> >>> +
> >>> +     sdhci_switch_external_dma(host, false);
> >>> +}
> >>> +
> >>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> >>> +                                         struct mmc_command *cmd)
> >>> +{
> >>> +     if (sdhci_external_dma_setup(host, cmd)) {
> >>> +             sdhci_external_dma_release(host);
> >>> +             pr_err("%s: Failed to setup external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> >>> +                    mmc_hostname(host->mmc));
> >>> +     } else {
> >>> +             /* Prepare for using external dma */
> >>> +             host->flags |= SDHCI_REQ_USE_DMA;
> >>> +     }
> >>> +
> >>> +     sdhci_prepare_data(host, cmd);
> >>> +}
> >>> +
> >>> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> >>> +                                         struct mmc_command *cmd)
> >>> +{
> >>> +     struct dma_chan *chan;
> >>> +
> >>> +     if (cmd->opcode != MMC_SET_BLOCK_COUNT && cmd->data) {
> >>
> >> MMC_SET_BLOCK_COUNT doesn't have data so that part is not needed
> >
> > Didn't get you here.
> > This is for other packets except MMC_SET_BLOCK_COUNT.
> >
>
> MMC_SET_BLOCK_COUNT is not a data transfer command, so cmd->data == NULL anyway.

Oh, got you.
"if (cmd->data)" is enough here :)

Thank you,
Chunyan
