Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84ECC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBFD21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdqY1i1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBFD21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeI0GFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:05:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40550 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeI0GFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:05:24 -0400
Received: by mail-it1-f196.google.com with SMTP id h23-v6so5327379ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eI4NpEJhPXXJCZL/jds2N2Ql80zzYvIwriaBpbUy+Bo=;
        b=MdqY1i1MQqPeKPNaweWnRdafni8+L9R23hygP8D1KPJPnVm6qVRUaF8YGSmrApFgV0
         PqfFlJkiq3FzXXYZVbNsoyXzRngjc+6qS8rYSplDUMDadyATZy6FE9pIvX4elDjtvv/z
         dTnAix4WL8v+IQZ6hWEd6lxQGza8BtVDZjJFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eI4NpEJhPXXJCZL/jds2N2Ql80zzYvIwriaBpbUy+Bo=;
        b=BmF/OW9IvwVL+aSdmV3VwQCjMzghDHqVPRUwIfGS0hOTZDm1yPlVci+bPkVM4D/XX8
         e0+fMT1Fb0/6YCPPMiYCLL6MXkTipM/wWMeaaLSh/U/UfDyPxdpqRu6zLVLU+DFXpJsH
         H7spYWLB/Yh7k4YcOY+CfWqWl8EbOFV/AvGo1S2WYb4VJccLbhT+FhMwP0xDjmi3QlVm
         i24PCsYQ0LBKRVwUEIhIG/dLX1P5+5SktXSsq4K0+7gaKrLys8/Kx74Ujpg03RU265Qw
         xrY6xpDtCflff2/e2w+HZfB8d6gb9N2ZhxmNBAq3ZQXteZ/Kb9cTf5G+5xseX5cNUDfV
         gBBA==
X-Gm-Message-State: ABuFfoiEyPtxxMSnIC+9ivQjIwd48JPQtnjO35glu75/T5f0YE8obbC/
        lnoFaU/4mm6YyyA2Ll6x2D008lI7KrG+koCVOicSGA==
X-Google-Smtp-Source: ACcGV61zmHZjhCn89gSFHu0HMk1R1NAXI6BG1caM/QU++7iH7CgwN6YgyfUuDLGmuWAsA2YL95cS5nkF9ygX45yS56k=
X-Received: by 2002:a02:6a6f:: with SMTP id m47-v6mr7998648jaf.121.1538005799701;
 Wed, 26 Sep 2018 16:49:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:49:19
 -0700 (PDT)
In-Reply-To: <1537523181-14578-2-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 01:49:19 +0200
Message-ID: <CAPDyKFqGwihup0q=-mq_9-fj2YxJHWjWyP9jVSjUk6n=rdAvEg@mail.gmail.com>
Subject: Re: [PATCH V2 01/27] mmc: mmci: internalize dma map/unmap into mmci
 dma functions
To:     Ludovic Barre <ludovic.Barre@st.com>
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
> This patch internalizes the management of dma map/unmap into
> mmci dma interfaces. This allows to simplify and prepare the next dma
> callbacks for mmci host ops.
> mmci_dma_unmap was called in mmci_data_irq & mmci_cmd_irq functions
> and can be integrated in mmci_dma_data_error.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1841d250..bf0bb07 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -482,16 +482,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
>         host->dma_rx_channel = host->dma_tx_channel = NULL;
>  }
>
> -static void mmci_dma_data_error(struct mmci_host *host)
> -{
> -       dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> -       dmaengine_terminate_all(host->dma_current);
> -       host->dma_in_progress = false;
> -       host->dma_current = NULL;
> -       host->dma_desc_current = NULL;
> -       host->data->host_cookie = 0;
> -}
> -
>  static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct dma_chan *chan;
> @@ -505,6 +495,18 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>                      mmc_get_dma_dir(data));
>  }
>
> +static void mmci_dma_data_error(struct mmci_host *host)
> +{
> +       dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> +       dmaengine_terminate_all(host->dma_current);
> +       host->dma_in_progress = false;
> +       host->dma_current = NULL;
> +       host->dma_desc_current = NULL;
> +       host->data->host_cookie = 0;
> +
> +       mmci_dma_unmap(host, host->data);
> +}
> +
>  static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>  {
>         u32 status;
> @@ -528,10 +530,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>                 mmci_dma_data_error(host);
>                 if (!data->error)
>                         data->error = -EIO;
> -       }
> -
> -       if (!data->host_cookie)
> +       } else if (!data->host_cookie) {
>                 mmci_dma_unmap(host, data);
> +       }
>
>         /*
>          * Use of DMA with scatter-gather is impossible.
> @@ -742,10 +743,6 @@ static inline void mmci_dma_release(struct mmci_host *host)
>  {
>  }
>
> -static inline void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
> -{
> -}
> -
>  static inline void mmci_dma_finalize(struct mmci_host *host,
>                                      struct mmc_data *data)
>  {
> @@ -906,10 +903,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 u32 remain, success;
>
>                 /* Terminate the DMA transfer */
> -               if (dma_inprogress(host)) {
> +               if (dma_inprogress(host))
>                         mmci_dma_data_error(host);
> -                       mmci_dma_unmap(host, data);
> -               }
>
>                 /*
>                  * Calculate how far we are into the transfer.  Note that
> @@ -1055,10 +1050,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         if ((!sbc && !cmd->data) || cmd->error) {
>                 if (host->data) {
>                         /* Terminate the DMA transfer */
> -                       if (dma_inprogress(host)) {
> +                       if (dma_inprogress(host))
>                                 mmci_dma_data_error(host);
> -                               mmci_dma_unmap(host, host->data);
> -                       }
> +
>                         mmci_stop_data(host);
>                 }
>                 mmci_request_end(host, host->mrq);
> --
> 2.7.4
>
