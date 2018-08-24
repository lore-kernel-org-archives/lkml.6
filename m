Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A46C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC06F2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGIpN+x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06F2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeHXKGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:06:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52620 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeHXKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:06:09 -0400
Received: by mail-it0-f68.google.com with SMTP id g18-v6so793125itg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o9cjN+yDtt5R5YrCXZf9x2gnCRB40hNeo/UUGru3P6k=;
        b=iGIpN+x9u4nofzlYhChxD8rZrllgIMMdHJmn+oQf0ghdKIEZNIXmW7+0q0dszLD59Q
         WarEXtqxSsFwNLdWARmdenrJ6Rm9EmiR4ijDqXscn5TLqKaPYoblpW9uu3XbcH9QXudW
         E29CrGYAX0dr0rg2yN759zNoMEUOlKAcMBI+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o9cjN+yDtt5R5YrCXZf9x2gnCRB40hNeo/UUGru3P6k=;
        b=U94b8G+w+6n+qr0uEpp3jRMHgjBvckw9bk3BKS5TDZDz9DsP6q5h04H0phvBvdrpri
         +TSucTaLdfIqdUl7nmj7t7djQD2gX87LvFzAIsHx0sXMXhWzHvAkNcf5jv2l2FdoxTGF
         GZennjerP9XRozTdpcJcYacrMCd1KtfxnHf7n9lptXX70G8MdDCCcjmDaj+g8HxY+5od
         jYZIGKgi2H098SbNEJTq+LrS7TK7b7+alwlBsgzV6HYx15z/ooZbho5RHzM58V1yrKhs
         QzlLqqGQ0lObqGhbM1WMaHPZ8VVD3RJ9Vp179DrsX3JjlA7+K11uGbYB5+LUOzuKmzQ8
         55ag==
X-Gm-Message-State: APzg51DzHtGoUSXVMd4cH7kaOyusOjjrq66YpLDoODDYqS3D0qDfwFRP
        h14LeqphzR0xJWUUtI+4EyUN+fUDD9aQf36eqG6+0g==
X-Google-Smtp-Source: ANB0VdbMIAA9GQTsG7Dc9ljb87h1FlXfdStdY4rdqBxef6d2cXvVI4ptwgEelxaqa4vyR16npdnP/5c10xCH7M0Mv8w=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr424370ita.64.1535092377199;
 Thu, 23 Aug 2018 23:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 23:32:56
 -0700 (PDT)
In-Reply-To: <CAK7LNARYEf34cJG8=z4TgbuVAEzn=NMdOTH5tfMryHQX7uJrgg@mail.gmail.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFoW=wuYZw+VV6TncLgtMbFdvJCfYOzL8xg7x2WimqNN2A@mail.gmail.com> <CAK7LNARYEf34cJG8=z4TgbuVAEzn=NMdOTH5tfMryHQX7uJrgg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 08:32:56 +0200
Message-ID: <CAPDyKFrx4rSE_SsQJYxT8UgPmKMhyXPQGz2-9Zt_ANh7Wy8VAQ@mail.gmail.com>
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

On 24 August 2018 at 03:50, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-08-23 19:43 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> [...]
>>
>>> +static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
>>> +                                            struct tmio_mmc_data *pdata)
>>> +{
>>> +       struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
>>> +       struct dma_chan *chan;
>>> +
>>> +       chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
>>> +       if (IS_ERR(chan)) {
>>> +               dev_warn(mmc_dev(host->mmc),
>>> +                        "failed to request DMA channel. falling back to PIO\n");
>>> +               return; /* just use PIO even for -EPROBE_DEFER */
>>> +       }
>>> +
>>> +       /* this driver uses a single channel for both RX an TX */
>>> +       priv->chan = chan;
>>> +       host->chan_rx = chan;
>>> +       host->chan_tx = chan;
>>> +
>>> +       tasklet_init(&host->dma_issue, uniphier_sd_external_dma_issue,
>>> +                    (unsigned long)host);
>>
>> Isn't it time to get rid of tasklets for tmio?
>>
>> No worries, I don't require that to be changed prior $subject patch,
>> however using threaded IRQs is a justified modernization for the tmio
>> variants.
>
>
> Yeah, I also thought this.
>
> But, the irq handler is in the TMIO common code,
> so it would affect Renesas code.

Yep.

>
> tmio-mmc has lots to be improved.
> Tasklet is not the only problem.

Sure.

>
>
> Before investing more effort,
> I want working code base for my platform.

Totally acceptable!

[...]

Kind regards
Uffe
