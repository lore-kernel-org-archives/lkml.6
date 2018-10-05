Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72832084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="criQz7ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72832084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeJEUqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:46:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39736 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbeJEUqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:46:42 -0400
Received: by mail-it1-f195.google.com with SMTP id w200-v6so2770692itc.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k6ZeblyyPZv+ruxOP2cA8B6uM+ewR1uksgYFqy+Agc4=;
        b=criQz7arVy+RYju/Zfn4XXyIa9DlyCmH+QjCBvQgKGQ/PEHKSnThXYYe9AAHZjgrG4
         O07tT2N8iELSMKKhYfO8oB2SfSIk2noxi8Lx96a5ful/gzd7vGmWWnZ/h1pNbmRxAAS0
         +z+kLgLL9DmxyD8TTyYojOXkvP+2C7LqkZD5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k6ZeblyyPZv+ruxOP2cA8B6uM+ewR1uksgYFqy+Agc4=;
        b=PSWKJVOOwnDp+6kBwgVjjzKUd1+Zs+WEf6V3unD2DLHbzCFZUpGB0T2urokZZnW1XN
         AylJ5TOoGKn/q9OvregUVc+UTyAuNqVf7KBwGY6obe77bSpTlvsb3aDEK/EOIojruYeN
         b8hqS1RVv/TuDgE8qDBNVbF12SvC3FqslWfyz+ZFKDEW+pZITsJgULEsiYVCJpqpwcDE
         GZKvyVpFeeovcX2hIhaN9cqgcjtnLB31Ly4TQtn3NLPBylI+XgYqpPTGkOOoNtwbFm46
         /xVvWnZcH/ekqgywmEPsXu+XrxB3NCsW90wcu7ajWK4h/XdWzyV2rl3Jub3xSUSHtcAM
         m6bQ==
X-Gm-Message-State: ABuFfoimPu0ofBm1PorHvLhNeV5uMWLXd6xUZuUsLAa+gAqUduz6vuNf
        T/CNmBw7kT6is8ZSLeJhFWMdq9EMHcd4TBLVIe3c6Q==
X-Google-Smtp-Source: ACcGV63+dqoFKRl+zQi6d36SZTi3jl9UOxmvZpAliP7O5ufdzBcE7LM42sTtN5dCgKHTiEAPissKRGLrh2dKMzkwsW4=
X-Received: by 2002:a24:8045:: with SMTP id g66-v6mr8958725itd.45.1538747273351;
 Fri, 05 Oct 2018 06:47:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 06:47:12 -0700 (PDT)
In-Reply-To: <1538745782-27446-3-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com> <1538745782-27446-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Oct 2018 15:47:12 +0200
Message-ID: <CAPDyKFogS_74csmZm5_M3D-JFNn_8fi2sxcHpRwVxZOqZhndVg@mail.gmail.com>
Subject: Re: [PATCH V5 02/24] mmc: mmci: create common mmci_dma_setup/release
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
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

On 5 October 2018 at 15:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch creates a common mmci_dma_setup/release which calls
> dma_setup/release callbacks of mmci_host_ops and manages
> common features like use_dma... If there is a fallbacks to
> pio mode, dma functions must check use_dma.
>
> error management:
> -mmci_dmae_setup fail if Tx and Rx dma channels are not defined
> -qcom_dma_setup fail if one of both dma channels is not defined,
>  Qcom has no specific resource to release, just mmci dmae resource.

Makes perfect sense!

[...]

> +void mmci_dma_setup(struct mmci_host *host)
> +{
> +       if (!host->ops || !host->ops->dma_setup)
> +               return;
> +
> +       if (host->ops->dma_setup(host)) {
> +               mmci_dma_release(host);

Please remove this and let the variants clean up themselves. That
makes it more straight forward.

> +               return;
> +       }
> +
> +       host->use_dma = true;
> +}
> +

[...]

> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 01e6c6b..9b0a960 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -273,7 +273,8 @@ struct variant_data {
>
>  /* mmci variant callbacks */
>  struct mmci_host_ops {
> -       void (*dma_setup)(struct mmci_host *host);
> +       int (*dma_setup)(struct mmci_host *host);
> +       void (*dma_release)(struct mmci_host *host);
>  };
>
>  struct mmci_host_next {
> @@ -323,6 +324,7 @@ struct mmci_host {
>         unsigned int            size;
>         int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>
> +       u8                      use_dma:1;
>  #ifdef CONFIG_DMA_ENGINE
>         /* DMA stuff */
>         struct dma_chan         *dma_current;
> @@ -336,3 +338,14 @@ struct mmci_host {
>  #endif
>  };
>
> +#ifdef CONFIG_DMA_ENGINE
> +void mmci_variant_init(struct mmci_host *host);
> +#else
> +static inline void mmci_variant_init(struct mmci_host *host)
> +{
> +}
> +#endif

This can be kept in mmci.c instead.

> +
> +int mmci_dmae_setup(struct mmci_host *host);
> +void mmci_dmae_release(struct mmci_host *host);
> +
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index be3fab5..aa070a9 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>  }
>
>  /* Initialize the dml hardware connected to SD Card controller */
> -static void qcom_dma_setup(struct mmci_host *host)
> +static int qcom_dma_setup(struct mmci_host *host)
>  {
>         u32 config;
>         void __iomem *base;
>         int consumer_id, producer_id;
>         struct device_node *np = host->mmc->parent->of_node;
>
> +       if (mmci_dmae_setup(host))
> +               return -EINVAL;
> +
>         consumer_id = of_get_dml_pipe_index(np, "tx");
>         producer_id = of_get_dml_pipe_index(np, "rx");
>
>         if (producer_id < 0 || consumer_id < 0) {
>                 host->variant->qcom_dml = false;
> -               return;
> +               return -EINVAL;

This relies on error handling to be done by mmci_dma_setup(), which as
stated, feels a bit wrong.

I would rather just call mmci_dmae_realease() here, before returning -EINVAL.

[...]

Otherwise, this looks good to me now.

Kind regards
Uffe
