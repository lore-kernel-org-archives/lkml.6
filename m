Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30140C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C57240FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRvfh7iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C57240FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeGEP1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:27:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34419 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:26:59 -0400
Received: by mail-it0-f66.google.com with SMTP id d191-v6so2665287ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xB1M2lHmxvntef28CHhN3rJ7DQA5vk2yC/neLJ2sQPY=;
        b=NRvfh7iGcQuSzXI1UapmD7t+gXIBFGdb2YxcV/USTHi3Mb19pFYRxh7gU7VrFEzLlI
         OPFF4zG9qluooES0WUPSTqy2LQ5QnRBy5CzO+USm8TDseCVfwhpPWIJ8NRStuAyPdnM5
         ULIg/YSWmmAH5fN0gyuBfc6q2H8GQDMZgqsyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xB1M2lHmxvntef28CHhN3rJ7DQA5vk2yC/neLJ2sQPY=;
        b=IzKgFNT2pie8NBpK8z7zqTplK1S3dUkdd2shNTF8WUv5CX+ZS3yuNlzjarVLEr1Owa
         uzrj2/BrRcNsijEgHSLkM9I5NHtVd0yXzQh9wh8ha0FLJr1ZaoKnBnEzvoNlKHfV9u4x
         u/jmmrvARzUM/QN4VDWzuPr0TdCc5Pl6DJL8HXed4oWFYn9UvJ3AG/tTuX6R9lg0ab/l
         WrJP3hXHO9F47MsOwVPfrDFMcmxYf/RIicFGHDeo+ONUcoIeCH/i4qG2MC3ALccfj1YI
         CUrZB77CpL/aytFGsFbHE7u/aOyv1vFT/p83/CGV0P0ka2sHrZ6MwYtVbtH7vhXAi4oH
         M3TQ==
X-Gm-Message-State: APt69E0KFp74K7hmETajv0TtTMppAL08dpvm8CbOr3S0xWaFluqTGP5d
        +wsrQU4ouhy/Zk+lYuSchkCtepL4S8G6V0YFDLkiVw==
X-Google-Smtp-Source: AAOMgpc+mVtn4oUBjXf9uCMczze5c/vvvAeeD39fMFAvPN5KqJgN1ttuN02sQj2lt8DaUcmGuxWdQSqDz1l/3xEJc0w=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr5683647itc.102.1530804418524;
 Thu, 05 Jul 2018 08:26:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:26:58 -0700 (PDT)
In-Reply-To: <1528809280-31116-3-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com> <1528809280-31116-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 17:26:58 +0200
Message-ID: <CAPDyKFqOOvbNc79hdWhdS4pxkYrh48At-BLuGmX0jDMER3Akdw@mail.gmail.com>
Subject: Re: [PATCH 02/19] mmc: mmci: merge qcom dml feature into mmci dma
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
> This patch integrates qcom dml feature into mmci_dma file.
> Qualcomm Data Mover lite/local is already a variant of mmci dmaengine.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/Makefile        |   1 -
>  drivers/mmc/host/mmci.c          |   1 -
>  drivers/mmc/host/mmci.h          |  35 ++++++++
>  drivers/mmc/host/mmci_dma.c      | 135 ++++++++++++++++++++++++++++-
>  drivers/mmc/host/mmci_qcom_dml.c | 177 ---------------------------------------
>  drivers/mmc/host/mmci_qcom_dml.h |  31 -------
>  6 files changed, 169 insertions(+), 211 deletions(-)
>  delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>  delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h

No, this is not the way to go. Instead I I think there are two options.

1) Keep mmci_qcom_dml.c|h and thus add new files for the stm32 dma variant.

2) Start by renaming mmci_qcom_dml.* to mmc_dma.* and then in the next
step add the code for stm32 dma into the renamed files.

I guess if there is some overlap in functionality, 2) may be best as
it could easier avoid open coding. However, I am fine with whatever
option and I expect that you knows what is best.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index daecaa98..608a020 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -5,7 +5,6 @@
>
>  obj-$(CONFIG_MMC_ARMMMCI) += armmmci.o
>  armmmci-y := mmci.o mmci_dma.o
> -armmmci-$(CONFIG_MMC_QCOM_DML) += mmci_qcom_dml.o
>  obj-$(CONFIG_MMC_PXA)          += pxamci.o
>  obj-$(CONFIG_MMC_MXC)          += mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)          += mxs-mmc.o
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 8868be0..7a15afd 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -43,7 +43,6 @@
>
>  #include "mmci.h"
>  #include "mmci_dma.h"
> -#include "mmci_qcom_dml.h"
>
>  #define DRIVER_NAME "mmci-pl18x"
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index a73bb98..f7cba35 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -194,6 +194,41 @@
>
>  #define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
>
> +/* QCOM DML Registers */
> +#define DML_CONFIG                     0x00
> +#define PRODUCER_CRCI_MSK              GENMASK(1, 0)
> +#define PRODUCER_CRCI_DISABLE          0
> +#define PRODUCER_CRCI_X_SEL            BIT(0)
> +#define PRODUCER_CRCI_Y_SEL            BIT(1)
> +#define CONSUMER_CRCI_MSK              GENMASK(3, 2)
> +#define CONSUMER_CRCI_DISABLE          0
> +#define CONSUMER_CRCI_X_SEL            BIT(2)
> +#define CONSUMER_CRCI_Y_SEL            BIT(3)
> +#define PRODUCER_TRANS_END_EN          BIT(4)
> +#define BYPASS                         BIT(16)
> +#define DIRECT_MODE                    BIT(17)
> +#define INFINITE_CONS_TRANS            BIT(18)
> +
> +#define DML_SW_RESET                   0x08
> +#define DML_PRODUCER_START             0x0c
> +#define DML_CONSUMER_START             0x10
> +#define DML_PRODUCER_PIPE_LOGICAL_SIZE 0x14
> +#define DML_CONSUMER_PIPE_LOGICAL_SIZE 0x18
> +#define DML_PIPE_ID                    0x1c
> +#define PRODUCER_PIPE_ID_SHFT          0
> +#define PRODUCER_PIPE_ID_MSK           GENMASK(4, 0)
> +#define CONSUMER_PIPE_ID_SHFT          16
> +#define CONSUMER_PIPE_ID_MSK           GENMASK(20, 16)
> +
> +#define DML_PRODUCER_BAM_BLOCK_SIZE    0x24
> +#define DML_PRODUCER_BAM_TRANS_SIZE    0x28
> +
> +/* other definitions */
> +#define PRODUCER_PIPE_LOGICAL_SIZE     4096
> +#define CONSUMER_PIPE_LOGICAL_SIZE     4096
> +
> +#define DML_OFFSET                     0x800
> +
>  struct clk;
>  struct dma_chan;
>
> diff --git a/drivers/mmc/host/mmci_dma.c b/drivers/mmc/host/mmci_dma.c
> index 98a542d..dd7dae5 100644
> --- a/drivers/mmc/host/mmci_dma.c
> +++ b/drivers/mmc/host/mmci_dma.c
> @@ -8,11 +8,11 @@
>  #include <linux/dmaengine.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/of.h>
>  #include <linux/scatterlist.h>
>
>  #include "mmci.h"
>  #include "mmci_dma.h"
> -#include "mmci_qcom_dml.h"
>
>  int mmci_dma_setup(struct mmci_host *host)
>  {
> @@ -101,6 +101,139 @@ struct dmaengine_priv {
>
>  #define dma_inprogress(dmae) ((dmae)->dma_in_progress)
>
> +#ifdef CONFIG_MMC_QCOM_DML
> +void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
> +{
> +       u32 config;
> +       void __iomem *base = host->base + DML_OFFSET;
> +
> +       if (data->flags & MMC_DATA_READ) {
> +               /* Read operation: configure DML for producer operation */
> +               /* Set producer CRCI-x and disable consumer CRCI */
> +               config = readl_relaxed(base + DML_CONFIG);
> +               config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_X_SEL;
> +               config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_DISABLE;
> +               writel_relaxed(config, base + DML_CONFIG);
> +
> +               /* Set the Producer BAM block size */
> +               writel_relaxed(data->blksz, base + DML_PRODUCER_BAM_BLOCK_SIZE);
> +
> +               /* Set Producer BAM Transaction size */
> +               writel_relaxed(data->blocks * data->blksz,
> +                              base + DML_PRODUCER_BAM_TRANS_SIZE);
> +               /* Set Producer Transaction End bit */
> +               config = readl_relaxed(base + DML_CONFIG);
> +               config |= PRODUCER_TRANS_END_EN;
> +               writel_relaxed(config, base + DML_CONFIG);
> +               /* Trigger producer */
> +               writel_relaxed(1, base + DML_PRODUCER_START);
> +       } else {
> +               /* Write operation: configure DML for consumer operation */
> +               /* Set consumer CRCI-x and disable producer CRCI*/
> +               config = readl_relaxed(base + DML_CONFIG);
> +               config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_X_SEL;
> +               config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_DISABLE;
> +               writel_relaxed(config, base + DML_CONFIG);
> +               /* Clear Producer Transaction End bit */
> +               config = readl_relaxed(base + DML_CONFIG);
> +               config &= ~PRODUCER_TRANS_END_EN;
> +               writel_relaxed(config, base + DML_CONFIG);
> +               /* Trigger consumer */
> +               writel_relaxed(1, base + DML_CONSUMER_START);
> +       }
> +
> +       /* make sure the dml is configured before dma is triggered */
> +       wmb();
> +}
> +
> +static int of_get_dml_pipe_index(struct device_node *np, const char *name)
> +{
> +       int index;
> +       struct of_phandle_args dma_spec;
> +
> +       index = of_property_match_string(np, "dma-names", name);
> +
> +       if (index < 0)
> +               return -ENODEV;
> +
> +       if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> +                                      &dma_spec))
> +               return -ENODEV;
> +
> +       if (dma_spec.args_count)
> +               return dma_spec.args[0];
> +
> +       return -ENODEV;
> +}
> +
> +/* Initialize the dml hardware connected to SD Card controller */
> +int dml_hw_init(struct mmci_host *host, struct device_node *np)
> +{
> +       u32 config;
> +       void __iomem *base;
> +       int consumer_id, producer_id;
> +
> +       consumer_id = of_get_dml_pipe_index(np, "tx");
> +       producer_id = of_get_dml_pipe_index(np, "rx");
> +
> +       if (producer_id < 0 || consumer_id < 0)
> +               return -ENODEV;
> +
> +       base = host->base + DML_OFFSET;
> +
> +       /* Reset the DML block */
> +       writel_relaxed(1, base + DML_SW_RESET);
> +
> +       /* Disable the producer and consumer CRCI */
> +       config = (PRODUCER_CRCI_DISABLE | CONSUMER_CRCI_DISABLE);
> +       /*
> +        * Disable the bypass mode. Bypass mode will only be used
> +        * if data transfer is to happen in PIO mode and don't
> +        * want the BAM interface to connect with SDCC-DML.
> +        */
> +       config &= ~BYPASS;
> +       /*
> +        * Disable direct mode as we don't DML to MASTER the AHB bus.
> +        * BAM connected with DML should MASTER the AHB bus.
> +        */
> +       config &= ~DIRECT_MODE;
> +       /*
> +        * Disable infinite mode transfer as we won't be doing any
> +        * infinite size data transfers. All data transfer will be
> +        * of finite data size.
> +        */
> +       config &= ~INFINITE_CONS_TRANS;
> +       writel_relaxed(config, base + DML_CONFIG);
> +
> +       /*
> +        * Initialize the logical BAM pipe size for producer
> +        * and consumer.
> +        */
> +       writel_relaxed(PRODUCER_PIPE_LOGICAL_SIZE,
> +                      base + DML_PRODUCER_PIPE_LOGICAL_SIZE);
> +       writel_relaxed(CONSUMER_PIPE_LOGICAL_SIZE,
> +                      base + DML_CONSUMER_PIPE_LOGICAL_SIZE);
> +
> +       /* Initialize Producer/consumer pipe id */
> +       writel_relaxed(producer_id | (consumer_id << CONSUMER_PIPE_ID_SHFT),
> +                      base + DML_PIPE_ID);
> +
> +       /* Make sure dml initialization is finished */
> +       mb();
> +
> +       return 0;
> +}
> +#else
> +static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
> +{
> +}
> +#endif /* CONFIG_MMC_QCOM_DML */
> +
>  static int dmaengine_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> deleted file mode 100644
> index 00750c9..0000000
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ /dev/null
> @@ -1,177 +0,0 @@
> -/*
> - *
> - * Copyright (c) 2011, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -#include <linux/of.h>
> -#include <linux/of_dma.h>
> -#include <linux/bitops.h>
> -#include <linux/mmc/host.h>
> -#include <linux/mmc/card.h>
> -#include "mmci.h"
> -
> -/* Registers */
> -#define DML_CONFIG                     0x00
> -#define PRODUCER_CRCI_MSK              GENMASK(1, 0)
> -#define PRODUCER_CRCI_DISABLE          0
> -#define PRODUCER_CRCI_X_SEL            BIT(0)
> -#define PRODUCER_CRCI_Y_SEL            BIT(1)
> -#define CONSUMER_CRCI_MSK              GENMASK(3, 2)
> -#define CONSUMER_CRCI_DISABLE          0
> -#define CONSUMER_CRCI_X_SEL            BIT(2)
> -#define CONSUMER_CRCI_Y_SEL            BIT(3)
> -#define PRODUCER_TRANS_END_EN          BIT(4)
> -#define BYPASS                         BIT(16)
> -#define DIRECT_MODE                    BIT(17)
> -#define INFINITE_CONS_TRANS            BIT(18)
> -
> -#define DML_SW_RESET                   0x08
> -#define DML_PRODUCER_START             0x0c
> -#define DML_CONSUMER_START             0x10
> -#define DML_PRODUCER_PIPE_LOGICAL_SIZE 0x14
> -#define DML_CONSUMER_PIPE_LOGICAL_SIZE 0x18
> -#define DML_PIPE_ID                    0x1c
> -#define PRODUCER_PIPE_ID_SHFT          0
> -#define PRODUCER_PIPE_ID_MSK           GENMASK(4, 0)
> -#define CONSUMER_PIPE_ID_SHFT          16
> -#define CONSUMER_PIPE_ID_MSK           GENMASK(20, 16)
> -
> -#define DML_PRODUCER_BAM_BLOCK_SIZE    0x24
> -#define DML_PRODUCER_BAM_TRANS_SIZE    0x28
> -
> -/* other definitions */
> -#define PRODUCER_PIPE_LOGICAL_SIZE     4096
> -#define CONSUMER_PIPE_LOGICAL_SIZE     4096
> -
> -#define DML_OFFSET                     0x800
> -
> -void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
> -{
> -       u32 config;
> -       void __iomem *base = host->base + DML_OFFSET;
> -
> -       if (data->flags & MMC_DATA_READ) {
> -               /* Read operation: configure DML for producer operation */
> -               /* Set producer CRCI-x and disable consumer CRCI */
> -               config = readl_relaxed(base + DML_CONFIG);
> -               config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_X_SEL;
> -               config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_DISABLE;
> -               writel_relaxed(config, base + DML_CONFIG);
> -
> -               /* Set the Producer BAM block size */
> -               writel_relaxed(data->blksz, base + DML_PRODUCER_BAM_BLOCK_SIZE);
> -
> -               /* Set Producer BAM Transaction size */
> -               writel_relaxed(data->blocks * data->blksz,
> -                              base + DML_PRODUCER_BAM_TRANS_SIZE);
> -               /* Set Producer Transaction End bit */
> -               config = readl_relaxed(base + DML_CONFIG);
> -               config |= PRODUCER_TRANS_END_EN;
> -               writel_relaxed(config, base + DML_CONFIG);
> -               /* Trigger producer */
> -               writel_relaxed(1, base + DML_PRODUCER_START);
> -       } else {
> -               /* Write operation: configure DML for consumer operation */
> -               /* Set consumer CRCI-x and disable producer CRCI*/
> -               config = readl_relaxed(base + DML_CONFIG);
> -               config = (config & ~CONSUMER_CRCI_MSK) | CONSUMER_CRCI_X_SEL;
> -               config = (config & ~PRODUCER_CRCI_MSK) | PRODUCER_CRCI_DISABLE;
> -               writel_relaxed(config, base + DML_CONFIG);
> -               /* Clear Producer Transaction End bit */
> -               config = readl_relaxed(base + DML_CONFIG);
> -               config &= ~PRODUCER_TRANS_END_EN;
> -               writel_relaxed(config, base + DML_CONFIG);
> -               /* Trigger consumer */
> -               writel_relaxed(1, base + DML_CONSUMER_START);
> -       }
> -
> -       /* make sure the dml is configured before dma is triggered */
> -       wmb();
> -}
> -
> -static int of_get_dml_pipe_index(struct device_node *np, const char *name)
> -{
> -       int index;
> -       struct of_phandle_args  dma_spec;
> -
> -       index = of_property_match_string(np, "dma-names", name);
> -
> -       if (index < 0)
> -               return -ENODEV;
> -
> -       if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> -                                      &dma_spec))
> -               return -ENODEV;
> -
> -       if (dma_spec.args_count)
> -               return dma_spec.args[0];
> -
> -       return -ENODEV;
> -}
> -
> -/* Initialize the dml hardware connected to SD Card controller */
> -int dml_hw_init(struct mmci_host *host, struct device_node *np)
> -{
> -       u32 config;
> -       void __iomem *base;
> -       int consumer_id, producer_id;
> -
> -       consumer_id = of_get_dml_pipe_index(np, "tx");
> -       producer_id = of_get_dml_pipe_index(np, "rx");
> -
> -       if (producer_id < 0 || consumer_id < 0)
> -               return -ENODEV;
> -
> -       base = host->base + DML_OFFSET;
> -
> -       /* Reset the DML block */
> -       writel_relaxed(1, base + DML_SW_RESET);
> -
> -       /* Disable the producer and consumer CRCI */
> -       config = (PRODUCER_CRCI_DISABLE | CONSUMER_CRCI_DISABLE);
> -       /*
> -        * Disable the bypass mode. Bypass mode will only be used
> -        * if data transfer is to happen in PIO mode and don't
> -        * want the BAM interface to connect with SDCC-DML.
> -        */
> -       config &= ~BYPASS;
> -       /*
> -        * Disable direct mode as we don't DML to MASTER the AHB bus.
> -        * BAM connected with DML should MASTER the AHB bus.
> -        */
> -       config &= ~DIRECT_MODE;
> -       /*
> -        * Disable infinite mode transfer as we won't be doing any
> -        * infinite size data transfers. All data transfer will be
> -        * of finite data size.
> -        */
> -       config &= ~INFINITE_CONS_TRANS;
> -       writel_relaxed(config, base + DML_CONFIG);
> -
> -       /*
> -        * Initialize the logical BAM pipe size for producer
> -        * and consumer.
> -        */
> -       writel_relaxed(PRODUCER_PIPE_LOGICAL_SIZE,
> -                      base + DML_PRODUCER_PIPE_LOGICAL_SIZE);
> -       writel_relaxed(CONSUMER_PIPE_LOGICAL_SIZE,
> -                      base + DML_CONSUMER_PIPE_LOGICAL_SIZE);
> -
> -       /* Initialize Producer/consumer pipe id */
> -       writel_relaxed(producer_id | (consumer_id << CONSUMER_PIPE_ID_SHFT),
> -                      base + DML_PIPE_ID);
> -
> -       /* Make sure dml initialization is finished */
> -       mb();
> -
> -       return 0;
> -}
> diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
> deleted file mode 100644
> index 6e405d0..0000000
> --- a/drivers/mmc/host/mmci_qcom_dml.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/*
> - *
> - * Copyright (c) 2011, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -#ifndef __MMC_QCOM_DML_H__
> -#define __MMC_QCOM_DML_H__
> -
> -#ifdef CONFIG_MMC_QCOM_DML
> -int dml_hw_init(struct mmci_host *host, struct device_node *np);
> -void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
> -#else
> -static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
> -{
> -       return -ENOSYS;
> -}
> -static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
> -{
> -}
> -#endif /* CONFIG_MMC_QCOM_DML */
> -
> -#endif /* __MMC_QCOM_DML_H__ */
> --
> 2.7.4
>
