Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5AAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F1C2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aF0vUheB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbeIYAum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:50:42 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39787 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbeIYAum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:50:42 -0400
Received: by mail-it1-f196.google.com with SMTP id w200-v6so3734219itc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ij/VUEX3cyquQzAbBiFvxSobhkltRtpY44H4fmkEhNE=;
        b=aF0vUheBttgEh7TPLYfyJFKMCdZExoZ+go+8CPSN473Zk7a06rXuhIFHJ1jQnIaI71
         x6U+WXHAldyqx1LRPOx09oM79FIGFFKKV4i2b4CW7MkmuxDpBuOywXjCdvckBOvpXe6I
         P+xPQWxWAJ/NJ6YDtivoTM/zLTKV9SURG0Q68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ij/VUEX3cyquQzAbBiFvxSobhkltRtpY44H4fmkEhNE=;
        b=qLAr2AZIpzmipCDQqOIpuQWXsmVH6unEsIQThHwtPEdfx/KGqwx8OFM37Hi5Jth6A4
         syGXS9c4yihFQG3GR0aWnjQDEkppofOok/bpQrT7IOqsKtcQR5QWy/T12+SpWHtVJaAg
         0EANpKZ/68bvhzfIBMPUnTPxSRKPlncgwKxTv9eIcXwTxN5mLzG/RVfPHfI9nslXjENS
         1FFdz8/lqDB+3vje0lPUVqbZbPzSkrZpmnwUKfrbf1LrBt48Qgse5ZvkCavzfnMDGKgD
         NhEX1xV9Xv+5ivNTS3sTmMUnjr1yzbYAi+061TpD7lF80g8fkGNnIC9rE04+cz9Vs3Xq
         mUWg==
X-Gm-Message-State: ABuFfohiI7Tpb8U73Ih8QG5ZlXLBl9l/fi92w/w++Lj7luvVUdEHgLyD
        87rRNzctd1d7FCbJlF3ha3KVmg1vZGLVada4ePohiQ==
X-Google-Smtp-Source: ACcGV62srpjhynyTxih6eOFJzXAKMjFb4pZ8Y7knirFzA8C5RjYhQeAe8qUv941jW9lMuhHrbzcfPeC3wWEXkUL2zEQ=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr117262jad.107.1537814830630;
 Mon, 24 Sep 2018 11:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 11:46:30
 -0700 (PDT)
In-Reply-To: <1537523181-14578-6-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-6-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Sep 2018 20:46:30 +0200
Message-ID: <CAPDyKFqhyVrRGRraGQzx9kwRxLtr56Gwc_NKqNqwLvZuM=jM1A@mail.gmail.com>
Subject: Re: [PATCH V2 05/27] mmc: mmci: move mmci next cookie to mci host
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
> This patch moves next cookie to mmci host structure to
> share same cookie management between all variants.

I would suggest you to squash this with patch4, as I think it makes
more sense to keep these changes together.

>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 10 ++++------
>  drivers/mmc/host/mmci.h |  2 ++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 6de7c8d..43f2a1a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -418,7 +418,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>  struct mmci_dmae_next {
>         struct dma_async_tx_descriptor *desc;
>         struct dma_chan *chan;
> -       s32 cookie;
>  };
>
>  struct mmci_dmae_priv {
> @@ -449,7 +448,7 @@ static int mmci_dma_setup(struct mmci_host *host)
>                                                      "tx");
>
>         /* initialize pre request cookie */
> -       dmae->next_data.cookie = 1;
> +       host->next_cookie = 1;
>
>         /*
>          * If only an RX channel is specified, the driver will
> @@ -716,7 +715,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>         struct mmci_dmae_priv *dmae = host->dma_priv;
>         struct mmci_dmae_next *next = &dmae->next_data;
>
> -       WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
> +       WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
>         WARN_ON(!data->host_cookie && (next->desc || next->chan));
>
>         dmae->desc_current = next->desc;
> @@ -728,9 +727,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>  static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
> -       struct mmci_dmae_priv *dmae = host->dma_priv;
>         struct mmc_data *data = mrq->data;
> -       struct mmci_dmae_next *nd = &dmae->next_data;
>
>         if (!data)
>                 return;
> @@ -741,7 +738,8 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 return;
>
>         if (!mmci_dma_prep_next(host, data))
> -               data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
> +               data->host_cookie = ++host->next_cookie < 0 ?
> +                       1 : host->next_cookie;
>  }
>
>  static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 1e9a45b..5bb1ce2 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -318,5 +318,7 @@ struct mmci_host {
>         int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>
>         void                    *dma_priv;
> +
> +       s32                     next_cookie;
>  };
>
> --
> 2.7.4
>

Kind regards
Uffe
