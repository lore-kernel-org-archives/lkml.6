Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F47C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2462156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RwJWm1dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2462156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeGEPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:17:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36444 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeGEPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:17:47 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so8075470iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I3R+5e5unJC1fsWWBxGs2NDQTZikP3mj0LzyrRQJMBw=;
        b=RwJWm1djCx+h7rhC/K4OBmAaArrJ098wOPeYe3pwcUCq6T+tv9yvo+JZ8iqBEiv+AW
         gSYP9uRpvpx4gjTxyL+5uAz6GrgPNUKc8X1RMKiaZebV+2Sop7e3w9oU17PSEOvVqU4y
         zL84rFI8pE6AkJcdZx4d51nminUPoFIn8gTtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I3R+5e5unJC1fsWWBxGs2NDQTZikP3mj0LzyrRQJMBw=;
        b=iSZ5ciI0PsDh0/Pi1Az5LkyctIt3+2yW5NU+5ApJHf9+u11y05j5uqI7l8clKfc6Up
         ixE7O4TYDfrZf+yD2wAo4hPJshCZtcQ5hf/nYHY7eE4bIl58Rm5NwduAMfiu/MGFUdnT
         LhZqBMaUiJF94edMoTCMkxsRkeWWfkzHkaZcbywyXimvvmKNsXcW3YC73LjeHEIkXMPe
         4a4EqINoaMv5iTZLxOKoMawyVSgPZOIjP1c9q8ygk95cemlO48ZWiui4YMiPsLu2kdUx
         AU1OwdQ2jfR4z7rmgx9G1KYkAjLNfbBeEZmIw1LH7RVJEA8cD17Wj+t720ROQpJY0n3F
         Nb9A==
X-Gm-Message-State: AOUpUlGHqFSddyM0mH8LGXRJlZ9dmXpeBpgLT4dByA0ARijFCvXVoPu8
        CY2bLrtrHwyh45WMBiPFDE0JbpcQk5g3nf/3y7ossA==
X-Google-Smtp-Source: AAOMgpe0cGzeC5J34BLSxLLcrweiiKxV4+15Sy0qIlHJ+fd2HWMa6nBrhTFzf7X/oczRGhKH4BZcbTgnrkO767YaOOw=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr5241401iou.218.1530803867286;
 Thu, 05 Jul 2018 08:17:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:17:46 -0700 (PDT)
In-Reply-To: <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 17:17:46 +0200
Message-ID: <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
Subject: Re: [PATCH 01/19] mmc: mmci: regroup and define dma operations
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
> Prepare mmci driver to manage dma interface by new property.
> This patch defines and regroups dma operations for mmci drivers.
> mmci_dma_XX prototypes are added to call member of mmci_dma_ops
> if not null. Based on legacy need, a mmci dma interface has been
> defined with:
> -mmci_dma_setup
> -mmci_dma_release
> -mmci_dma_pre_req
> -mmci_dma_start
> -mmci_dma_finalize
> -mmci_dma_post_req
> -mmci_dma_error
> -mmci_dma_get_next_data

As I suggested for one of the other patches, I would rather turn core
mmci functions into library functions, which can be either invoked
from variant callbacks or assigned directly to them.

In other words, I would leave the functions that you move in this
patch to stay in mmci.c. Although some needs to be re-factored and we
also needs to make some of them available to be called from another
file, hence the functions needs to be shared via mmci.h rather than
being declared static.

Let me take a concrete example on how I would move forward, hopefully
that explains it a bit better. Please see below.

[...]

> -/*
> - * All the DMA operation mode stuff goes inside this ifdef.
> - * This assumes that you have a generic DMA device interface,
> - * no custom DMA interfaces are supported.
> - */
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> -{
> -       const char *rxname, *txname;
> -       struct variant_data *variant = host->variant;
> -
> -       host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
> -       host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
> -
> -       /* initialize pre request cookie */
> -       host->next_data.cookie = 1;
> -
> -       /*
> -        * If only an RX channel is specified, the driver will
> -        * attempt to use it bidirectionally, however if it is
> -        * is specified but cannot be located, DMA will be disabled.
> -        */
> -       if (host->dma_rx_channel && !host->dma_tx_channel)
> -               host->dma_tx_channel = host->dma_rx_channel;
> -
> -       if (host->dma_rx_channel)
> -               rxname = dma_chan_name(host->dma_rx_channel);
> -       else
> -               rxname = "none";
> -
> -       if (host->dma_tx_channel)
> -               txname = dma_chan_name(host->dma_tx_channel);
> -       else
> -               txname = "none";
> -
> -       dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
> -                rxname, txname);
> -
> -       /*
> -        * Limit the maximum segment size in any SG entry according to
> -        * the parameters of the DMA engine device.
> -        */
> -       if (host->dma_tx_channel) {
> -               struct device *dev = host->dma_tx_channel->device->dev;
> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> -
> -               if (max_seg_size < host->mmc->max_seg_size)
> -                       host->mmc->max_seg_size = max_seg_size;
> -       }
> -       if (host->dma_rx_channel) {
> -               struct device *dev = host->dma_rx_channel->device->dev;
> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> -
> -               if (max_seg_size < host->mmc->max_seg_size)
> -                       host->mmc->max_seg_size = max_seg_size;
> -       }

Everything above shall be left as generic library function,
mmci_dma_setup() and I would share it via mmci.h and thus change it
from being static.

> -
> -       if (variant->qcom_dml && host->dma_rx_channel && host->dma_tx_channel)
> -               if (dml_hw_init(host, host->mmc->parent->of_node))
> -                       variant->qcom_dml = false;

This piece of code, should be made specific to the qcom variant and
managed though a "mmci_host_ops" callback. The corresponding code in
that callback would then start by invoking mmci_dma_setup(), before it
continues with the qcom specific operations.

For legacy variants, the corresponding callback would be set directly
to mmci_dma_setup() and called through the callback from mmci.c when
needed. There is no need to have a separate file for DMA for the
legacy variants, I think.

[...]

Kind regards
Uffe
