Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE37C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D024B2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+wHZMcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D024B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeITXkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:40:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37081 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeITXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:40:47 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so8635974iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bUFcJpjuQBK9I27ZQKgT97KpChNSn9yC6lv9abYHYlE=;
        b=j+wHZMcJHLq2txup1w8cVuMYohrhgx/fWQaUrFZi7F8Y4Jhl81nbOEA47LgTnYtyrN
         7oqxsUc0BI/QffgLYBOUCbBefwzWl0BU+6WvZicAgUCVhjdCkyNcj4d5jstiugfwqQqS
         UPXHQ552iQYmUywsyWuH8W9xcHl98kfWOISjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bUFcJpjuQBK9I27ZQKgT97KpChNSn9yC6lv9abYHYlE=;
        b=AYclvPKei9hNkx6tzPBWas1HzIhtZPyUKdki6kqCLcZPSaEASumXamtXx2gSucmBp4
         PqxTv0E1isQzTJioWcaOZYBhzAdyPYC0+onHue7DwfzkFUoRVa8pMfVvGr8+RH5TWH6t
         qZb2v3jr7pck8Xs7FCJ55sS2UIq4AD/AGrrd3GNyFP8b7QnLbv+ABXMoW2iPhpk0p4lS
         faTwxC4UH3/e7xPwFxLfTDaHedbNDL9QHoWEBa6ZGwrntVMF+MF/c7MygT9rbK2VPUpI
         izcEHClpOOKi1CRqWK4s0Qwcno/EgV/WBCeuC2tE2nlQz6B2VgDIA86zSgiv4J57frKl
         Z8tQ==
X-Gm-Message-State: APzg51AmTB4KEWkpE+NQeVDENm0SWvfSV1y8rIA8kfMGcFngTmhJAAbC
        HRSxERZI6hXxmkqlej0BBvJ7yTv2h7kDh3GGGW1Xzw==
X-Google-Smtp-Source: ANB0VdbpAJ8YbqBnmDqxdXC2TiSIRuDY+cUKrvkexX50YDnslk4aL8Ga57dOoVLyCCkbT3YlHj9T6/B7UNu9kqUjw2o=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr3203741itb.45.1537466168204;
 Thu, 20 Sep 2018 10:56:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 10:56:07
 -0700 (PDT)
In-Reply-To: <1537268144-21152-3-git-send-email-ludovic.Barre@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com> <1537268144-21152-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Sep 2018 19:56:07 +0200
Message-ID: <CAPDyKFrwiQv-EFfSrY7TwxXN-AnOsbbPop88GPo8_32hcjBzsg@mail.gmail.com>
Subject: Re: [PATCH V2 02/27] mmc: mmci: internalize dma_inprogress into mmci
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

On 18 September 2018 at 12:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the dma_inprogress into mmci dma interfaces.
> This allows to simplify and prepare the next dma callbacks
> for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
> and mmci_dma_finalize.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 16 ++++++++++------
>  drivers/mmc/host/mmci.h |  4 +---
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index bf0bb07..7d22cb9 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>
>  static void mmci_dma_data_error(struct mmci_host *host)
>  {
> +       if (!__dma_inprogress(host))
> +               return;
> +
>         dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>         dmaengine_terminate_all(host->dma_current);
>         host->dma_in_progress = false;
> @@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>         u32 status;
>         int i;
>
> +       if (!__dma_inprogress(dmae))
> +               return;
> +
>         /* Wait up to 1ms for the DMA to complete */
>         for (i = 0; ; i++) {
>                 status = readl(host->base + MMCISTATUS);
> @@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 u32 remain, success;
>
>                 /* Terminate the DMA transfer */
> -               if (dma_inprogress(host))
> -                       mmci_dma_data_error(host);
> +               mmci_dma_data_error(host);
>
>                 /*
>                  * Calculate how far we are into the transfer.  Note that
> @@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>                 dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>
>         if (status & MCI_DATAEND || data->error) {
> -               if (dma_inprogress(host))
> -                       mmci_dma_finalize(host, data);
> +               mmci_dma_finalize(host, data);
> +
>                 mmci_stop_data(host);
>
>                 if (!data->error)
> @@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         if ((!sbc && !cmd->data) || cmd->error) {
>                 if (host->data) {
>                         /* Terminate the DMA transfer */
> -                       if (dma_inprogress(host))
> -                               mmci_dma_data_error(host);
> +                       mmci_dma_data_error(host);
>
>                         mmci_stop_data(host);
>                 }
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 696a066..f1ec066 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,9 +332,7 @@ struct mmci_host {
>         struct mmci_host_next   next_data;
>         bool                    dma_in_progress;
>
> -#define dma_inprogress(host)   ((host)->dma_in_progress)
> -#else
> -#define dma_inprogress(host)   (0)
> +#define __dma_inprogress(host) ((host)->dma_in_progress)

Overall the change makes good sense to me, however I don't get why you
want to rename the macro-function. Please don't.

>  #endif
>  };
>
> --
> 2.7.4
>

Kind regards
Uffe
