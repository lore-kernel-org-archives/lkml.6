Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC165C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A2120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY0kGF4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A2120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbeHALxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:53:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54265 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbeHALxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:53:40 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so8826576itw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mwmax1l8RqlIaUVKaYEZVDMEdU/1qlb2reQHCd0FZjc=;
        b=RY0kGF4H1dLc5GzlISt+tyUuwNt2uJlI4xP+Nmp2wtIK0zJsjQJFHCAwj88XObl0r8
         vwpyN3ETl9jLndRoztovj7IbZlQhxqaqkNAhz+Mkr3FHocZyN6flCJ3IwYcGzvaR4Hve
         E6pfiiE6RwrAn0MT3vKzXIoKVxfk7sGPOP51c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mwmax1l8RqlIaUVKaYEZVDMEdU/1qlb2reQHCd0FZjc=;
        b=YCzy/mW9dUKQt94r2ZxRSEwjR/25ANDlC8ilaN4BPZ8ZYgD8OtwVCe/RX9Bi0hu/QW
         N9Yo35tCR/un/BagkXUCNmS17kW8dwcXZ4Swu2Iia3JkpEQ704WIzbs+103fnQO0T8Zv
         78WQaioLePTG9W7Mys6tMIV031GFdQ+97q/jo1KLZsNmyEuMu82SQGWiBfJMCAjhs83E
         uKvAaYa6tQ5hWVJHxAmOqSp1rg31iQC1C6d0F6E6F0BoPvAyvMDtUxX7Rl7VmAxYzx0d
         oGRKJHgCOCK/BLDKHrAu9RRNsMWamSokmFxEtWuozXvQY1lZIKJmp+ZE6f94a8C6lgoW
         lR/Q==
X-Gm-Message-State: AOUpUlFpPLyhqyFJQENQEm9/DE348xcRjut3/SezfFn5MRo9Loqs2KnT
        kVDUN1iqllD8wT/R5d2WlWd4pqoXfQzB2xjcZW2hUQ==
X-Google-Smtp-Source: AAOMgpfS0KrR871gYd2e8R1vX2G5L84qe9EJUoX1tvdGqH77ncfPUepxnWyCP/fEixIOJs9c1xprjftl7j9BLKk4DUg=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr3043791itc.102.1533118119493;
 Wed, 01 Aug 2018 03:08:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 03:08:38 -0700 (PDT)
In-Reply-To: <1533116221-380-2-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Aug 2018 12:08:38 +0200
Message-ID: <CAPDyKFq4Qx5e8Hk40F5DpTJn3g1bnm6sbQERS0Lt-OGmzEdLyQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] mmc: mmci: fix qcom dma issue during mmci init with
 new dma_setup callback
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
> This patch fixes qcom dma issue during mmci init.
> Like init callback of qcom variant is not set, the qcom dma
> is not correctly initialized and fail while dma transfer
> ("buggy DMA detected. Taking evasive action").
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 1 +
>  drivers/mmc/host/mmci.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 71e9336..1841d250 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -208,6 +208,7 @@ static struct variant_data variant_qcom = {
>         .mmcimask1              = true,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_ROD,
> +       .init                   = qcom_variant_init,
>  };
>
>  /* Busy detection for the ST Micro variant */
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 517591d..696a066 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -338,3 +338,4 @@ struct mmci_host {
>  #endif
>  };
>
> +void qcom_variant_init(struct mmci_host *host);

This isn't needed.

> --
> 2.7.4
>

Anyway, we can just drop this patch from your series as I amended the
patch causing the problem.

I will continue to review the rest.

Kind regards
Uffe
