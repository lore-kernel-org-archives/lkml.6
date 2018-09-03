Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B5C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQvG6hVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B5C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeICQfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:35:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46927 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeICQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:35:20 -0400
Received: by mail-io0-f195.google.com with SMTP id y12-v6so230866ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aGWAvTSiVj6L6vAHu2k+auA/ADBzAGALoYfzaPu0Cpc=;
        b=FQvG6hVmQ5HNbR0S67KqaxtQDIIyIITagGm1dFCTxcPphMmE8OmSzIov3li0mkUZ+T
         KalMfyDlCyQK3Dsdz+LVAm7jy7wo6GbBtnyqLDFQkvaEDdZ7UYdxSR0pNrPQ8vk1ImvF
         08UJkFIEwQZ4vjbHnC8QEp0Ef/Db7Dmqho+t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aGWAvTSiVj6L6vAHu2k+auA/ADBzAGALoYfzaPu0Cpc=;
        b=rtfcrWDjTLWzGNGLgX79PyS05CPsDv6+tfSZtgnxvGgMuvq13ah1xNwb8pa9MqYJvk
         6BvtP7Ood6Z0TD4+ICIdleb2iNfRvf2t0jutKhE4wko2opP5l+5CRPQXYnNQ4TTOUSr5
         E8W1KNlh5zwLJXsdYEc2d8YUtu6gnUD1nRkyCHmADe3PtnxcUAj8Hwu2TyjEG4h+SOjq
         4jXYSooa7Rzf4qz958jR+eCGJAhJdUuzBcviWlk1IPs6aKILJbOExinr3kYUsYWjhBWI
         HO347RaVZHNDY5ZcjtCVcVWRMtYiSTogP3WtRva2NVF3gHPm93rQy3xyYxRYovOWgeX/
         RzCg==
X-Gm-Message-State: APzg51BIpTbYGwvWv5K5SoyjBtwimfqeDK3daxpp6TjYqLJFpb+h5ttt
        LYO/YU5v4COAHkFo/VnfIF3uH9JKbWk6npJmxXeRhA==
X-Google-Smtp-Source: ANB0VdbWym5uJWQ2osbOgMe3ONMt3VYPAgFyIFgDoi+P4kO4i/PhqFwdKiZC9WP92QmlyVieVhoOFSqCGoswniZclTk=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr18844162iou.218.1535976926738;
 Mon, 03 Sep 2018 05:15:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 05:15:26 -0700 (PDT)
In-Reply-To: <1533116221-380-5-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-5-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 14:15:26 +0200
Message-ID: <CAPDyKFrBtB8Z-9gxcYmmoVPwLQ8dedJLmDiLqbyEoL5oax5owg@mail.gmail.com>
Subject: Re: [PATCH 04/14] mmc: mmci: introduce dma_priv pointer to mmci_host
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch introduces dma_priv pointer to define specific
> needs for each dma engine. This patch is needed to prepare
> sdmmc variant with internal dma which not use dmaengine API.

Overall this looks good, however a couple a few things below, mostly nitpicks.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c          | 165 +++++++++++++++++++++++++--------------
>  drivers/mmc/host/mmci.h          |  20 +----
>  drivers/mmc/host/mmci_qcom_dml.c |   6 +-
>  3 files changed, 112 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 8144a87..bdc48c3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -415,31 +415,57 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>   * no custom DMA interfaces are supported.
>   */
>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +struct dmaengine_next {

I would rather rename this struct to something along the lines of
"mmci_dma_next", that should follow how most of the data structures
are named in mmci.

> +       struct dma_async_tx_descriptor *dma_desc;
> +       struct dma_chan *dma_chan;

For these two, I think you should remove the "dma_" prefix from their
names. At least to me, it's of obvious they are about dma if they are
part of a struct used (and named) used solely for that purpose.

> +       s32 cookie;
> +};
> +
> +struct dmaengine_priv {
> +       struct dma_chan *dma_current;
> +       struct dma_chan *dma_rx_channel;
> +       struct dma_chan *dma_tx_channel;
> +       struct dma_async_tx_descriptor  *dma_desc_current;
> +       struct dmaengine_next next_data;
> +       bool dma_in_progress;

For similar reasons as above, I suggest to rename the struct to
"mmci_dma_priv" and to drop the "dma_" prefix from the variable names.

> +};
> +
> +#define __dmae_inprogress(dmae) ((dmae)->dma_in_progress)

How about naming this to mmci_dma_inprogress() instead?

BTW, in general it looks like you are a bit fond of using "__" as
function name prefix for internally called functions. Please try to
avoid that, but rather try to pick names that explains what the
functions do.

> +
> +static int mmci_dma_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
> +       struct dmaengine_priv *dmae;
>
> -       host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> -       host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
> +       dmae = devm_kzalloc(mmc_dev(host->mmc), sizeof(*dmae), GFP_KERNEL);
> +       if (!dmae)
> +               return -ENOMEM;
> +
> +       host->dma_priv = dmae;
> +
> +       dmae->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
> +                                                        "rx");
> +       dmae->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc),
> +                                                        "tx");
>
>         /* initialize pre request cookie */
> -       host->next_data.cookie = 1;
> +       dmae->next_data.cookie = 1;
>
>         /*
>          * If only an RX channel is specified, the driver will
>          * attempt to use it bidirectionally, however if it is
>          * is specified but cannot be located, DMA will be disabled.
>          */
> -       if (host->dma_rx_channel && !host->dma_tx_channel)
> -               host->dma_tx_channel = host->dma_rx_channel;
> +       if (dmae->dma_rx_channel && !dmae->dma_tx_channel)
> +               dmae->dma_tx_channel = dmae->dma_rx_channel;
>
> -       if (host->dma_rx_channel)
> -               rxname = dma_chan_name(host->dma_rx_channel);
> +       if (dmae->dma_rx_channel)
> +               rxname = dma_chan_name(dmae->dma_rx_channel);
>         else
>                 rxname = "none";
>
> -       if (host->dma_tx_channel)
> -               txname = dma_chan_name(host->dma_tx_channel);
> +       if (dmae->dma_tx_channel)
> +               txname = dma_chan_name(dmae->dma_tx_channel);
>         else
>                 txname = "none";
>
> @@ -450,15 +476,15 @@ static void mmci_dma_setup(struct mmci_host *host)
>          * Limit the maximum segment size in any SG entry according to
>          * the parameters of the DMA engine device.
>          */
> -       if (host->dma_tx_channel) {
> -               struct device *dev = host->dma_tx_channel->device->dev;
> +       if (dmae->dma_tx_channel) {
> +               struct device *dev = dmae->dma_tx_channel->device->dev;
>                 unsigned int max_seg_size = dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
>                         host->mmc->max_seg_size = max_seg_size;
>         }
> -       if (host->dma_rx_channel) {
> -               struct device *dev = host->dma_rx_channel->device->dev;
> +       if (dmae->dma_rx_channel) {
> +               struct device *dev = dmae->dma_rx_channel->device->dev;
>                 unsigned int max_seg_size = dma_get_max_seg_size(dev);
>
>                 if (max_seg_size < host->mmc->max_seg_size)
> @@ -466,7 +492,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>         }
>
>         if (host->ops && host->ops->dma_setup)
> -               host->ops->dma_setup(host);
> +               return host->ops->dma_setup(host);

I agree that converting the ->dma_setup() callback to return an int makes sense.

However, please make that a separate change and while doing that,
don't forget to implement the error path, as that is missing here.

> +
> +       return 0;
>  }

[...]

Kind regards
Uffe
