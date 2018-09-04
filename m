Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AF6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1006F20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLJxisgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1006F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeIDOH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:07:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52353 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeIDOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:07:27 -0400
Received: by mail-it0-f67.google.com with SMTP id h3-v6so4101837ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CZimQMljnxI9o76twaHdcYgfYeUcOBViTCHSkNt4jG4=;
        b=dLJxisgDMwGRRrS49UCM1A4CC0w8x28s15Drqu7cSIQTOJK4CYrz1NXBta5l1b+q6U
         goDRAAYP5N+/1TP9j3NduA+dXi/7R7BhZtMGJMJmDbXowbDITtj4KU81dMrzI8kps189
         CyeR4jlGFjc2RXg/kOUzg4BY5w/otNh6gTJfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CZimQMljnxI9o76twaHdcYgfYeUcOBViTCHSkNt4jG4=;
        b=aWkunHNOeH3z2a6ylYyj2ohUAbLQRnE4OID3s5N0J6LJU0NPawcMlyd0dMC1TpIeee
         kR2RFTwabn/KG+eAipelXP3dS1ZYDxnB3IMeJsd2q7/C0yrlx4kdczFLp4Lfa6mHmclD
         0hlwp6LBYYtCKZdEUEaDLQsWMK3vkG1HAvlM2TnwWeotLfkJn7aDgRUB9PE9YZxQ0gH2
         bAT48QyxYnTG7LnHqhOmLQR/s7zu7lwqjcSnnDsDseaZQQFfqDcWtx5qSP7aJ7S3/rB+
         99RC0b8joUKdnrZQVj0PTtUgzMsaKQxouJJHUBIl3H7cXFMJQLbdx4mZXNme5IYtR6/r
         uNRw==
X-Gm-Message-State: APzg51AEQk1Go1lLORmwlNowq+M2puSu9LE+pilIREe1+Ane8qq/M0k0
        s6obunSM1Vj4TKA7QPTCr123ChXyO8EgqSlm8ONihw==
X-Google-Smtp-Source: ANB0VdY9wxsYy24vxH+HIlJyK/Z9bfnHZhu93jwrLEwJxwTbsGsFCIwvQWUUaElpPt8rTShoqa/EA3JuedR6Fo2RYCM=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr7535087itb.45.1536054187456;
 Tue, 04 Sep 2018 02:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1bd8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 02:43:06 -0700 (PDT)
In-Reply-To: <1533116221-380-8-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com> <1533116221-380-8-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Sep 2018 11:43:06 +0200
Message-ID: <CAPDyKFrKNMBzqy-Fbf-_2BznBS5R3g_O3hPsfjqWef5FB7ZTmQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] mmc: mmci: add prepare/unprepare_data callbacks
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

[...]

>
>  static struct variant_data variant_qcom = {
> @@ -357,6 +365,31 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>         mmci_write_clkreg(host, clk);
>  }
>
> +int mmci_prepare_data(struct mmci_host *host, struct mmc_data *data, bool next)

I think we need to agree on naming rules for functions, as I think
this becomes a bit hard to follow when you decide to rename and pick
new names.

First, let's strive towards keeping existing names and in cases when a
subset of a function is re-used and called from the original function,
then name it with the same name, but add "__" or "_" as prefixes.

So for this one it should be:

mmci_dma_prep_data()
_mmci_dma_prep_data()
__mmci_dma_prep_data().

That should also decrease the number lines of code you need to change
and thus also make the review easier. Can you please try this?

> +{
> +       int err;
> +
> +       if (!host->ops || !host->ops->prepare_data)
> +               return 0;

Is the host->ops optional and so also the ->prepare_data() callback in it?

> +
> +       err = host->ops->prepare_data(host, data, next);

The job of the callback is to map the dma data. Perhaps a better name
would be ->dma_map_data()?

> +
> +       if (next && !err)
> +               data->host_cookie = ++host->next_cookie < 0 ?
> +                       1 : host->next_cookie;
> +
> +       return err;
> +}
> +
> +void mmci_unprepare_data(struct mmci_host *host, struct mmc_data *data,
> +                        int err)
> +{
> +       if (host->ops && host->ops->unprepare_data)
> +               host->ops->unprepare_data(host, data, err);

As stated, please follow existing naming convention. Perhaps
->dma_unmap_data() is a better name?

> +
> +       data->host_cookie = 0;
> +}
> +
>  static void
>  mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>  {
> @@ -588,9 +621,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>  }
>
>  /* prepares DMA channel and DMA descriptor, returns non-zero on failure */
> -static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
> -                               struct dma_chan **dma_chan,
> -                               struct dma_async_tx_descriptor **dma_desc)
> +static int __mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
> +                                struct dma_chan **dma_chan,
> +                                struct dma_async_tx_descriptor **dma_desc)
>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
>         struct variant_data *variant = host->variant;
> @@ -651,22 +684,21 @@ static int __mmci_dma_prep_data(struct mmci_host *host, struct mmc_data *data,
>         return -ENOMEM;
>  }
>
> -static inline int mmci_dma_prepare_data(struct mmci_host *host,
> -                                       struct mmc_data *data,
> -                                       bool next)
> +int mmci_dmae_prepare_data(struct mmci_host *host,
> +                          struct mmc_data *data, bool next)

Here's is yet another rename of a function. As stated, try to stick to
the existing names and use the scheme I described above.

>  {
>         struct dmaengine_priv *dmae = host->dma_priv;
>         struct dmaengine_next *nd = &dmae->next_data;
>
>         if (next)
> -               return __mmci_dma_prep_data(host, data, &nd->dma_chan,
> +               return __mmci_dmae_prep_data(host, data, &nd->dma_chan,
>                                             &nd->dma_desc);
>         /* Check if next job is already prepared. */
>         if (dmae->dma_current && dmae->dma_desc_current)
>                 return 0;
>
>         /* No job were prepared thus do it now. */
> -       return __mmci_dma_prep_data(host, data, &dmae->dma_current,
> +       return __mmci_dmae_prep_data(host, data, &dmae->dma_current,
>                                     &dmae->dma_desc_current);
>  }
>
> @@ -676,7 +708,7 @@ static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
>         struct mmc_data *data = host->data;
>         int ret;
>
> -       ret = mmci_dma_prepare_data(host, host->data, false);
> +       ret = mmci_prepare_data(host, host->data, false);
>         if (ret)
>                 return ret;
>
> @@ -720,33 +752,11 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>         next->dma_chan = NULL;
>  }
>
> -static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
> -{
> -       struct mmci_host *host = mmc_priv(mmc);
> -       struct mmc_data *data = mrq->data;
> -
> -       if (!data)
> -               return;
> -
> -       BUG_ON(data->host_cookie);
> -
> -       if (mmci_validate_data(host, data))
> -               return;
> +void mmci_dmae_unprepare_data(struct mmci_host *host,
> +                             struct mmc_data *data, int err)
>
> -       if (!mmci_dma_prepare_data(host, data, true))
> -               data->host_cookie = ++host->next_cookie < 0 ?
> -                       1 : host->next_cookie;
> -}
> -
> -static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
> -                             int err)
>  {
> -       struct mmci_host *host = mmc_priv(mmc);
>         struct dmaengine_priv *dmae = host->dma_priv;
> -       struct mmc_data *data = mrq->data;
> -
> -       if (!data || !data->host_cookie)
> -               return;
>
>         __mmci_dmae_unmap(host, data);
>
> @@ -769,10 +779,13 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>
>                 next->dma_desc = NULL;
>                 next->dma_chan = NULL;
> -               data->host_cookie = 0;
>         }
>  }
>
> +static struct mmci_host_ops mmci_variant_ops = {
> +       .prepare_data = mmci_dmae_prepare_data,
> +       .unprepare_data = mmci_dmae_unprepare_data,
> +};
>  #else
>  /* Blank functions if the DMA engine is not available */
>  static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
> @@ -802,11 +815,42 @@ static inline int mmci_dma_start_data(struct mmci_host *host, unsigned int datac
>         return -ENOSYS;
>  }
>
> -#define mmci_pre_request NULL
> -#define mmci_post_request NULL
> -
> +static struct mmci_host_ops mmci_variant_ops = {};
>  #endif

Ahh, now I see why you need the mmci_host_ops to be optional, earlier above.

However, I have been thinking on what granularity we should pick for
the mmci host ops callbacks. Honestly I am not sure, but let me
through out an idea and see what you think about it.

So, having callbacks for dealing with dma_map|unmap() kind of
operations, becomes rather fine-grained and not very flexible.
Instead, what do you think of allowing the variant init function to
dynamically assign the ->pre_req() and the ->post_req() callbacks in
the struct mmc_host_ops. Common mmci functions to manage these
operations can instead be shared via mmci.h and called by the
variants.

The point is, following that scheme may improve flexibility, but
possibly also decrease the number of needed mmci specific host ops
callbacks, don't you think?

>
> +void mmci_variant_init(struct mmci_host *host)
> +{
> +       host->ops = &mmci_variant_ops;
> +}
> +
> +static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!data)
> +               return;
> +
> +       WARN_ON(data->host_cookie);
> +
> +       if (mmci_validate_data(host, data))
> +               return;
> +
> +       mmci_prepare_data(host, data, true);
> +}
> +
> +static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
> +                             int err)
> +{
> +       struct mmci_host *host = mmc_priv(mmc);
> +       struct mmc_data *data = mrq->data;
> +
> +       if (!data || !data->host_cookie)
> +               return;
> +
> +       mmci_unprepare_data(host, data, err);
> +}
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct variant_data *variant = host->variant;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index d2ec4fd..fa2702b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -273,6 +273,10 @@ struct variant_data {
>
>  /* mmci variant callbacks */
>  struct mmci_host_ops {
> +       int (*prepare_data)(struct mmci_host *host, struct mmc_data *data,
> +                           bool next);
> +       void (*unprepare_data)(struct mmci_host *host, struct mmc_data *data,
> +                              int err);
>         int (*dma_setup)(struct mmci_host *host);
>  };
>
> @@ -323,3 +327,9 @@ struct mmci_host {
>  };
>
>  void qcom_variant_init(struct mmci_host *host);
> +void mmci_variant_init(struct mmci_host *host);
> +
> +int mmci_dmae_prepare_data(struct mmci_host *host, struct mmc_data *data,
> +                          bool next);
> +void mmci_dmae_unprepare_data(struct mmci_host *host,
> +                             struct mmc_data *data, int err);
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 1bb59cf..d534fa1 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -180,6 +180,8 @@ static int qcom_dma_setup(struct mmci_host *host)
>  }
>
>  static struct mmci_host_ops qcom_variant_ops = {
> +       .prepare_data = mmci_dmae_prepare_data,
> +       .unprepare_data = mmci_dmae_unprepare_data,
>         .dma_setup = qcom_dma_setup,
>  };
>
> --
> 2.7.4
>

Kind regards
Uffe
