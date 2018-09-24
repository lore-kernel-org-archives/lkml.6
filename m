Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78885C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C56D21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh89JW/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C56D21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbeIXUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:31:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50404 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeIXUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:31:13 -0400
Received: by mail-it1-f196.google.com with SMTP id j81-v6so10807202ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=460DIH8GVUzkqRJIr1VPbXzgFW1TlmdlrhHeJIh3SSw=;
        b=eh89JW/7HSQzYibqLITpkcWSOCtN1deqiIaF/ZzALGQW+ar+h0KNNTC61yfy5NVI8U
         VVyM/CPHL4vBUm5SEFK8PVoz+mPsNNuNhtrNoJTq3DTyTnZEDLqbhLkNkfEKgab5jYru
         gg7zlUbg9jD/iH7nNeqyh7EtOuV/REM4d3j3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=460DIH8GVUzkqRJIr1VPbXzgFW1TlmdlrhHeJIh3SSw=;
        b=mAmVXp+E8hBuuskO6xsYlmQlgMIb6SXazeu//vhXYqIBFuUnPvb7PE5ELCbwYeWaHt
         //9/1PNRxtJql/m/ydvP7EtlkG7YpppOo0qlXv36gO/GRId5hC6M/6ZkI+vTIZDtv73s
         ntANb++DeuZJWzxksP7W2A4VFRkI+G8JFSKtbFyjoqYN6iTQjMQfVNkMlZFR3z4E5YBg
         KuFIQF8j0b336GK/KcPD5bshB8yAp4XYx3VSD8VT3YLXtfa5cX8EVHXjYFeAYtgsP4H3
         4Y7zI8WhQsI6DHGkx3mhJAY+T2O0/IR+84uOZxtJbZSWDlc1FA4zAefc4OM+APmf1g3F
         LBRA==
X-Gm-Message-State: APzg51DFz/YyhA7xS42p20fBfFelQCEWiNuNDBcdoJxo1HZrSJIlnSYh
        P7NJgmVd1U9hMKcxuiWknFp4/ERgrDilUU7RExqdcg==
X-Google-Smtp-Source: ANB0VdbfLe5TJTyRxGBpNRDzBvq2GTs/z5BzKOz9+e+gFpjKu8psryQlq/zYVw13XdVm1HwT6g42PCC7HOhF9VNZEnw=
X-Received: by 2002:a02:6a6f:: with SMTP id m47-v6mr7624234jaf.121.1537799328418;
 Mon, 24 Sep 2018 07:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 07:28:07
 -0700 (PDT)
In-Reply-To: <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-4-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Sep 2018 16:28:07 +0200
Message-ID: <CAPDyKFqnN0gg9WsbNPQcodqUXJmFEzMM+ST36s6oEZ2OPoONug@mail.gmail.com>
Subject: Re: [PATCH V2 03/27] mmc: mmci: convert dma_setup callback to return
 an int
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch converts dma_setup callback to return an integer
> This patch is needed to prepare sdmmc variant with internal dma
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c          | 14 ++++++++++----
>  drivers/mmc/host/mmci.h          |  2 +-
>  drivers/mmc/host/mmci_qcom_dml.c |  6 ++++--
>  3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index cbd67bc..2f845f3 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -415,7 +415,7 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>   * no custom DMA interfaces are supported.
>   */
>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +static int mmci_dma_setup(struct mmci_host *host)
>  {
>         const char *rxname, *txname;
>
> @@ -466,7 +466,9 @@ static void mmci_dma_setup(struct mmci_host *host)
>         }
>
>         if (host->ops && host->ops->dma_setup)
> -               host->ops->dma_setup(host);
> +               return host->ops->dma_setup(host);
> +

Looks like you need to implement a error handling, instead of just
returning the error code.

> +       return 0;
>  }
>
>  /*
> @@ -741,8 +743,10 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>  static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>  {
>  }
> -static inline void mmci_dma_setup(struct mmci_host *host)
> +
> +static inline int mmci_dma_setup(struct mmci_host *host)
>  {
> +       return 0;
>  }
>
>  static inline void mmci_dma_release(struct mmci_host *host)
> @@ -1796,7 +1800,9 @@ static int mmci_probe(struct amba_device *dev,
>                  amba_rev(dev), (unsigned long long)dev->res.start,
>                  dev->irq[0], dev->irq[1]);
>
> -       mmci_dma_setup(host);
> +       ret = mmci_dma_setup(host);
> +       if (ret)
> +               goto clk_disable;
>
>         pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>         pm_runtime_use_autosuspend(&dev->dev);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 21aaf9a..06299ac 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -273,7 +273,7 @@ struct variant_data {
>
>  /* mmci variant callbacks */
>  struct mmci_host_ops {
> -       void (*dma_setup)(struct mmci_host *host);
> +       int (*dma_setup)(struct mmci_host *host);
>  };
>
>  struct mmci_host_next {
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index be3fab5..1bb59cf 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -119,7 +119,7 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>  }
>
>  /* Initialize the dml hardware connected to SD Card controller */
> -static void qcom_dma_setup(struct mmci_host *host)
> +static int qcom_dma_setup(struct mmci_host *host)
>  {
>         u32 config;
>         void __iomem *base;
> @@ -131,7 +131,7 @@ static void qcom_dma_setup(struct mmci_host *host)
>
>         if (producer_id < 0 || consumer_id < 0) {
>                 host->variant->qcom_dml = false;

It seems like the existing code is an attempt to fallback to use pio
mode. However, I doubt it works as is.

> -               return;
> +               return -EINVAL;

My point is, if you return an error code here, it means that the error
code becomes propagated and ->probe() will fail.

Ideally, we should be able fall back to pio mode when dma doesn't
work. I have looped in Srinivas who implemented the qcom dml support,
let's see if he can explains the intent with the code.

I also volunteer to help out running some tests on the 410c platform,
however allow me a day or two to do that.

>         }
>
>         base = host->base + DML_OFFSET;
> @@ -175,6 +175,8 @@ static void qcom_dma_setup(struct mmci_host *host)
>
>         /* Make sure dml initialization is finished */
>         mb();
> +
> +       return 0;
>  }
>
>  static struct mmci_host_ops qcom_variant_ops = {
> --
> 2.7.4
>

Kind regards
Uffe
