Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F5BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151E321530
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaobaZ2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151E321530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbeHWOMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:12:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33457 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbeHWOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:12:47 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so1614276ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aMWFVbn1KKH89InwxtYnbfXAonTjKhd6O4YqJjFuEBU=;
        b=PaobaZ2Qju0YFohMhsy25RXJDPnfShIQOWmv67yIa/MaeDf1n4dscwJQ3ZHsZCfiqH
         W0UoEq0rnTQdCp23NINNiC/XWkBIk6369DhDqKaA8oHb596ky/fXhea+Q1CT3Te172R2
         A1iOHkp+ZV6pXGFW3grVJskVSa033r6yi6LS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aMWFVbn1KKH89InwxtYnbfXAonTjKhd6O4YqJjFuEBU=;
        b=g7b1JCYvFDNZF9FUtPHTesCeC5KC4R7vHO7lrHfdOUdui3fiwiAjgkdkVWeeC/2WkJ
         GGmuDKXiWQXX9nsvZz7FJiS1R1Vx1Fb/2StbBnqkI2+3ecfF0VyqlU4bxfoiL3MEUm5G
         MP/2XZCmHCsiKoTgd3nPEVxsUjg4wVRvuVfIR7ZN7TluE4whoKUKnXq+2YTto3aNB8hv
         Clv340WjpCXCVhVyJ1QYVOPyWRVWEubg3dynivouaCxrOLeIsfMHTUVcLCACc4CmUwpJ
         LKHvKkKwSN9Mfgs5jSc8v6r04Vxs5AgQxAQ4TwjjdapjP9KgPZ2wl1ewrwzkkeLgNqRn
         ZhGw==
X-Gm-Message-State: APzg51BLC6YR30+UO6Yt3ljPlRCZZibX8fvNyBKgWkzADCE+Jvw9x3zy
        Rp3EEd+SMTuRhJq58rva+XlBmn1IHKVaU3QnpIGa1Zf3
X-Google-Smtp-Source: ANB0VdZKQ2owCuRjRIodQ+7NMBWIgi6cdy0KrKySfMJxMxgjCKBEg0Vbc00ZySOj1Cp3AfAsLPDRk2YMwMFZ4g8kXes=
X-Received: by 2002:a02:212f:: with SMTP id e47-v6mr724824jaa.121.1535021020728;
 Thu, 23 Aug 2018 03:43:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 03:43:40
 -0700 (PDT)
In-Reply-To: <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com> <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Aug 2018 12:43:40 +0200
Message-ID: <CAPDyKFoW=wuYZw+VV6TncLgtMbFdvJCfYOzL8xg7x2WimqNN2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
> +                                            struct tmio_mmc_data *pdata)
> +{
> +       struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
> +       struct dma_chan *chan;
> +
> +       chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
> +       if (IS_ERR(chan)) {
> +               dev_warn(mmc_dev(host->mmc),
> +                        "failed to request DMA channel. falling back to PIO\n");
> +               return; /* just use PIO even for -EPROBE_DEFER */
> +       }
> +
> +       /* this driver uses a single channel for both RX an TX */
> +       priv->chan = chan;
> +       host->chan_rx = chan;
> +       host->chan_tx = chan;
> +
> +       tasklet_init(&host->dma_issue, uniphier_sd_external_dma_issue,
> +                    (unsigned long)host);

Isn't it time to get rid of tasklets for tmio?

No worries, I don't require that to be changed prior $subject patch,
however using threaded IRQs is a justified modernization for the tmio
variants.

[...]

Kind regards
Uffe
