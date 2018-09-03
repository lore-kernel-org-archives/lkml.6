Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791D20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjtBRSNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E791D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeICQet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:34:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53517 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeICQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:34:49 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so899555itp.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=so8C29sL5MbRh1j1cxHQvlXv8Wo+gNEUMMBOzTXe/kE=;
        b=FjtBRSNpVvYVjsx/rb7NLgOJl4i4pe0Pb6Nowp+MAql/DZ7d9g2AIkRR2Pu0dN49EA
         nAfzbXDfKJq+tuVTGWGC/WJcc2gXBhW6/pZFoBTNVZTZBWHGvqhf2CANitFdytXV6QOu
         Xsh5vnyS7q2ltDtQRg56UtrZO73hOUGw5ftTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=so8C29sL5MbRh1j1cxHQvlXv8Wo+gNEUMMBOzTXe/kE=;
        b=kVguoAOJv0RV7wrv6mlEJQAMXj6zGZNJAiMqICFqz6G6ovfmqiWxkObueIwMQstR69
         x4qMRxEJXV+n2UrUrzmvfmCBhhrXTp9hLoHbeOvtCKhJbZQ3DCEbbIYNEYfA1UvXnFMq
         959MRh84cgGtRN6hMnJxpkQ6YU/H6n8FodPc2BmCr4ee9RziY9UIML+ybYXs7qaV3I/y
         00N51JudH6wB6ZaZJ92ay3Vs7nmd5KmzJ7k6JG1tP7OaQ7u66dBON/pBPDyr35lXkvDL
         JEkV4jltEyYMCEcpuLEfaOdhYfUAtRlmuB+HVj+G3mdGkK7IlTrIdkBquLXZ8jK3Fjz4
         1xiA==
X-Gm-Message-State: APzg51DaAUoOLG5f/YPkN6VeffaxerdhVkjS6cLJCt02cIQUqY0L9kWc
        mJGuawD6TvyOC+dQSNcsEHRKMpu3hUSr2Dcjw1W93Q==
X-Google-Smtp-Source: ANB0VdZu7dSMOJkN765zyg2/3jHxvz4Y83w1i3J4REmH3xXu91IU7Wwdwty0kgEcL6l2M7/qovpVe734dwrB1uhz1oQ=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr5017698itb.45.1535976896220;
 Mon, 03 Sep 2018 05:14:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 05:14:55 -0700 (PDT)
In-Reply-To: <1533116221-380-3-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 14:14:55 +0200
Message-ID: <CAPDyKFpmjVK8P8p-KkKMVYpEMkDW64F_i7-WMexsne1qgSQoxQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] mmc: mmci: internalize dma map/unmap into mmci dma functions
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
> This patch internalizes the management of dma map/unmap into
> mmci dma interfaces. This allows to simplify and prepare the next dma
> callbacks for mmci host ops.
> mmci_dma_unmap was called in mmci_data_irq & mmci_cmd_irq functions
> and can be integrated in mmci_dma_data_error.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1841d250..d8fa178 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -482,17 +482,7 @@ static inline void mmci_dma_release(struct mmci_host *host)
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
> -static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
> +static void __mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)

The renaming of the function seems irrelevant to this change. Can you
please keep the existing name?

[...]

Besides the minor thing above, this looks good to me!

Kind regards
Uffe
