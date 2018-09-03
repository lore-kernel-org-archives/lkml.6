Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A736C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B1120867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7X34qz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B1120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeICQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:35:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40241 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbeICQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:35:33 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so833397ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=abv0T78eL7ZGvBBWOINcTDZAaxulTFEsnaIHNSk8yy4=;
        b=I7X34qz41HJyodjTp6KG1wGq4MDr39GDdHuvani0ipIN7PV80/WwpuaJF5itzTgjxC
         KVYOVhoNlfBZZ6tNz52W9bIVYJGHFRQAeFZG0P5UfnwvbQKe0rAGgNWfM/2hIsY1ygM/
         QDzjnPHI6AAUnEFq9AWEOXSwevbpbySFbF4JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=abv0T78eL7ZGvBBWOINcTDZAaxulTFEsnaIHNSk8yy4=;
        b=e97gnNOlEYpvYdesN5ZvRmB1IyhgWtc9tP54FGu5etCp8ZMIbin2au30iNfJv72L7S
         jUan5pqrj8BHoTnNKxbAoDMCbeoKhtGC3GMWJm4MepOtUy412Shn5NvvLmSlh9Tywrku
         Iyoj9GU1h6Oq0LLJ82U6FRU//8gk+kZFvADcXnNQNyW018L/kutN5BytTLWUlFAB+CIP
         dzYgqnwfcbzm+ovCn7H0z0zCK/wEFvmQRz3Stw0xsfwbbtqKcsyJ6JJM0zUvCFk4F/QN
         g0FtzQjF2JtmhvvW3KuTX2/zDS1l4Jm2cTH9uFbNfVP7ZucRdptTMFU/9hQaZSv1eSG0
         /H+Q==
X-Gm-Message-State: APzg51AvoHtlOl3g5N48uLMn2To576NbZkoSs8GFCebbl4yPDq76E2Wu
        8g+lD3PF5tNFBFYrvkx8+kp4ep18f58Iy3cijc5ddA==
X-Google-Smtp-Source: ANB0VdaPOLHDawH7tn2YxfSXvulQ++7KW+dO/XlI3QuzBIuywNnMYjA0h+BaRQqs1nkoWGhxhohD/w8LmDWyZcPebQ0=
X-Received: by 2002:a24:a388:: with SMTP id p130-v6mr4603306ite.146.1535976939890;
 Mon, 03 Sep 2018 05:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 05:15:39 -0700 (PDT)
In-Reply-To: <1533116221-380-7-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-7-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Sep 2018 14:15:39 +0200
Message-ID: <CAPDyKFqNOgK8sMa-o7jWecD2Y76+LdjmtYTq+1-ApapQv3fZxQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] mmc: mmci: merge prepare data functions
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
> This patch merges the prepare data functions.
> This allows to define a single access to prepare data service.
> This prepares integration for mmci host ops.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 5646c2e6..e4d80f1 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -651,11 +651,16 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
>         return -ENOMEM;
>  }
>
> -static inline int mmci_dma_prep_data(struct mmci_host *host,
> -                                    struct mmc_data *data)
> +static inline int mmci_dma_prepare_data(struct mmci_host *host,

Nitpick: I don't see the reason to why you need to rename this
function here, please keep it as is.

> +                                       struct mmc_data *data,
> +                                       bool next)
>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
> +       struct dmaengine_next *nd = &dmae->next_data;
>
> +       if (next)
> +               return __mmci_dma_prep_data(host, data, &nd->dma_chan,
> +                                           &nd->dma_desc);
>         /* Check if next job is already prepared. */
>         if (dmae->dma_current && dmae->dma_desc_current)
>                 return 0;
> @@ -665,22 +670,13 @@ static inline int mmci_dma_prep_data(struct mmci_host *host,
>                                     &dmae->dma_desc_current);
>  }
>
> -static inline int mmci_dma_prep_next(struct mmci_host *host,
> -                                    struct mmc_data *data)
> -{
> -       struct dmaengine_priv *dmae = host->dma_priv;
> -       struct dmaengine_next *nd = &dmae->next_data;
> -
> -       return __mmci_dma_prep_data(host, data, &nd->dma_chan, &nd->dma_desc);
> -}
> -
>  static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
>         struct mmc_data *data = host->data;
>         int ret;
>
> -       ret = mmci_dma_prep_data(host, host->data);
> +       ret = mmci_dma_prepare_data(host, host->data, false);
>         if (ret)
>                 return ret;
>
> @@ -737,7 +733,7 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (mmci_validate_data(host, data))
>                 return;
>
> -       if (!mmci_dma_prep_next(host, data))
> +       if (!mmci_dma_prepare_data(host, data, true))
>                 data->host_cookie = ++host->next_cookie < 0 ?
>                         1 : host->next_cookie;
>  }
> --
> 2.7.4
>

Kind regards
Uffe
