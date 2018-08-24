Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A822AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4876721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ioQ+8sEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4876721557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHXFXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:23:37 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:24833 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:23:36 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7O1p74m026483;
        Fri, 24 Aug 2018 10:51:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7O1p74m026483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535075468;
        bh=kepMZOHvAyRHq2xgQ7f6pd6pvWIyEAnwypZ8JAYcSQg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ioQ+8sEdUPDuU0BdDetxGm7V05l7MidW1xrHkF8NzC/D2z3Evkx2VZOikvJm9f+r1
         wgEVEkhJdn/h8CizWmlIawQWnscmLQ7ZofdoJ01itwElxI9Yk2M17myqnVbwtm2cMR
         QmO2i18QmWTvGnyx1nJymB/F9QBxRRs5pWp4/LkHW7oLdxPwsaWfcD0WsBsm5EFTG8
         zfQIm017WNuNbnVusksyuKeFqrv1fpiqEUftFMwSUKTmglfpYup5E8zlM53dZoCYOk
         Aj5zMs8m4ENJclizSfpilh9k/EEvKIpuVLIfTjSnqQBzwMNvTB1PkcIcMpguncPDZq
         g8pC9MVEoTaeg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id m26-v6so3142168uap.2;
        Thu, 23 Aug 2018 18:51:08 -0700 (PDT)
X-Gm-Message-State: APzg51B5na4dcv9bJMdqFDsw6FhEqxGFMnx1ZT4WDupM88qmmfW6Ilgz
        5YM9KKv55XKWA54P1wN4f5/pwguXhNJmsFNxy8Q=
X-Google-Smtp-Source: AA+uWPwkPOcMSOrQ7MY4k3d+vJ/3s+qIg38RCYE7k1e57piskYaclYa2kaOXLlizJhjbbYc5JEL4chZq86ml06MhoKA=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr10801384uah.135.1535075467020;
 Thu, 23 Aug 2018 18:51:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 18:50:26
 -0700 (PDT)
In-Reply-To: <CAPDyKFoW=wuYZw+VV6TncLgtMbFdvJCfYOzL8xg7x2WimqNN2A@mail.gmail.com>
References: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
 <1534999460-15111-5-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFoW=wuYZw+VV6TncLgtMbFdvJCfYOzL8xg7x2WimqNN2A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 24 Aug 2018 10:50:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYEf34cJG8=z4TgbuVAEzn=NMdOTH5tfMryHQX7uJrgg@mail.gmail.com>
Message-ID: <CAK7LNARYEf34cJG8=z4TgbuVAEzn=NMdOTH5tfMryHQX7uJrgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

2018-08-23 19:43 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> [...]
>
>> +static void uniphier_sd_external_dma_request(struct tmio_mmc_host *host,
>> +                                            struct tmio_mmc_data *pdata)
>> +{
>> +       struct uniphier_sd_priv *priv = uniphier_sd_priv(host);
>> +       struct dma_chan *chan;
>> +
>> +       chan = dma_request_chan(mmc_dev(host->mmc), "rx-tx");
>> +       if (IS_ERR(chan)) {
>> +               dev_warn(mmc_dev(host->mmc),
>> +                        "failed to request DMA channel. falling back to PIO\n");
>> +               return; /* just use PIO even for -EPROBE_DEFER */
>> +       }
>> +
>> +       /* this driver uses a single channel for both RX an TX */
>> +       priv->chan = chan;
>> +       host->chan_rx = chan;
>> +       host->chan_tx = chan;
>> +
>> +       tasklet_init(&host->dma_issue, uniphier_sd_external_dma_issue,
>> +                    (unsigned long)host);
>
> Isn't it time to get rid of tasklets for tmio?
>
> No worries, I don't require that to be changed prior $subject patch,
> however using threaded IRQs is a justified modernization for the tmio
> variants.


Yeah, I also thought this.

But, the irq handler is in the TMIO common code,
so it would affect Renesas code.

tmio-mmc has lots to be improved.
Tasklet is not the only problem.


Before investing more effort,
I want working code base for my platform.


Anyway, thanks for applying this!



> [...]
>
> Kind regards
> Uffe



-- 
Best Regards
Masahiro Yamada
