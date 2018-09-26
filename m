Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3416521536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQLNFaUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3416521536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeI0GFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:05:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39931 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeI0GFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:05:30 -0400
Received: by mail-io1-f66.google.com with SMTP id l7-v6so598397iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W84WQ2wTZMbN14ercsJ2MlkPyNnU74KHVZILRnTExAI=;
        b=RQLNFaUg1wN75/UpGKZFWN3GNxyl85sq722Zf32jrQX8mQKeFv9cB/Gvs+CAU0AxHr
         fTDm9IW9po81hm9xrTN6raEpsPAbOI8xeI95ZUrxcx98Z38vVwdDDX1WjB09ZQToe0YG
         79Gk2A06tsSCZjBtXSi0olJoUL/SNUnYrdEyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W84WQ2wTZMbN14ercsJ2MlkPyNnU74KHVZILRnTExAI=;
        b=R24oj0dP7PyF1GgjnK/k0hQMzFTSWHzbk/DlI8E2PziCzdJp2UZ+lrq9jLyEnhW6as
         WwqvxXUYTVVn4u26wNZni6ZTAjENX9W3U/ljKum9Omwu2JloknK/DMwSVtVhnhRc6HJE
         HJT5US1ZPW+a+Mupb/QFqv/a8+gaO5OQ3gRBvuVubWLxa3wlomXmhX7WbmUM3rgHFvyI
         ig/oLhh5AhhtTLn+MOb+xPZti+Rdq7PoO/pTwDo6x9OJjVd/ehLR802yUtMJlMhMudz6
         JULKlyad1EuoPA+AEDW9UBCuSRUGICERU3eE2yGhXr5oZwws76ctvKyAX43culhmfffN
         GKNA==
X-Gm-Message-State: ABuFfohq7JpOFmY97LluvHPDQFo15RSOFuB/bjR3ASeXFkB6UQydP2pe
        AqIphN5DtUVJBHgXBV2i+AnhoxD0rTR0n/vT57XJww==
X-Google-Smtp-Source: ACcGV62hISszbC8h+BQeS1U9J8Hdd9NA4EXEBhhsl3itpctx45yyGSm6dm30ZC09sZBr+2w4rKUk9sWW+GcKoTnASaU=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr6912709ioc.131.1538005805860;
 Wed, 26 Sep 2018 16:50:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 16:49:25
 -0700 (PDT)
In-Reply-To: <1537523181-14578-3-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Sep 2018 01:49:25 +0200
Message-ID: <CAPDyKFrkTNyvEtLeaDRhJjMk90gfKJseX=Ukn-244awCGMp3EQ@mail.gmail.com>
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

On 21 September 2018 at 11:45, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the dma_inprogress into mmci dma interfaces.
> This allows to simplify and prepare the next dma callbacks
> for mmci host ops. dma_inprogress is called in mmci_dma_data_error
> and mmci_dma_finalize.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> change v3:
> -remove __dma_inprogress rename
>
>  drivers/mmc/host/mmci.c | 16 ++++++++++------
>  drivers/mmc/host/mmci.h |  2 --
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index bf0bb07..cbd67bc 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>
>  static void mmci_dma_data_error(struct mmci_host *host)
>  {
> +       if (!dma_inprogress(host))
> +               return;
> +
>         dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>         dmaengine_terminate_all(host->dma_current);
>         host->dma_in_progress = false;
> @@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>         u32 status;
>         int i;
>
> +       if (!dma_inprogress(host))
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
> index 517591d..21aaf9a 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -333,8 +333,6 @@ struct mmci_host {
>         bool                    dma_in_progress;
>
>  #define dma_inprogress(host)   ((host)->dma_in_progress)
> -#else
> -#define dma_inprogress(host)   (0)
>  #endif
>  };
>
> --
> 2.7.4
>
