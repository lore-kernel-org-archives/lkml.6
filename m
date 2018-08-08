Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA0C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAAB21722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJpBwhq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAAB21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHHMEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:04:25 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32890 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHHMEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:04:25 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so1704459uak.0;
        Wed, 08 Aug 2018 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T/J+nHci0wQM62sFOhVzw+wHC6Uo2xAWQuBx36pIaOY=;
        b=UJpBwhq7QDcUkbdf2av4Zu4XhXz/IVRLc1cFYMXmBpZSpK/TOyvbNYYQUg2BqmAsBO
         U9rUdpOgQtk/51j+NQNDsNMlNZ7xNxR6vAwEGCXJ2ZQ2eZrhkF8NjVwe0/MPo7l/Lf4z
         Uepb+sg26CCdL0XmHSqxd9VvN14PhMfEMof/ANg3+RETVOm5vj1ISw7kISTha5qvDT5H
         KpeMbccN1uSik2jG8WSkLCXwvYnMZIiEV40N7irHK3nmdAIKKOND7jepRaG0W94s4xwi
         OMDGxWlOnF5tYI5NL0Q3U4PrbiGWhDODKjjcdArDEANZYSJJ/+0GMgwuWl/WvBM0p2vm
         mmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T/J+nHci0wQM62sFOhVzw+wHC6Uo2xAWQuBx36pIaOY=;
        b=emEFE8GnQmqImTva6grAhCIvd4gI/8e/omgoAzvwnnow7IpyGRy4tggz4oD8xucHJO
         wUsdJYW1ws1+x+dW6E7ziQyE8sExN/gRpxuK70wlaAyv8CMSjoUgT36b4Gt6E9qRJH0y
         4KQbNV/VKCLITRkd7fBXcCyONlsbTmOn4aa3ek8OMAFiK0PSGityqu3Kubb/FNqAjWaA
         5mzGeK80yDbIDHpX4f1qK1M32fs39whNJHnf8SKhlYHPWULcp+1a853503dazz3Rs2SR
         qzDiPjNFoap7rDwYUdWfNdD2WRduaSGvCCedY8N0/ySTgB1bpLD6A6qZQ0MOiXHrrS8I
         AKQw==
X-Gm-Message-State: AOUpUlHkIlOmYaoqx1NK2VjAlJc49PZnidDdlMLwr5Ucvdf8CAtQo9Mt
        Vu8k2q8WPfKDakvPrpdpo6yWOrA5N7aYsjOwRgM=
X-Google-Smtp-Source: AA+uWPynZyw32eEDJ8K2rPtba7YYNKzGIf9ngdhO9qt4Htwqh0Q5/NWLvDazgAhtJw6QWcoMC7puM96B0WIM1/B8Aec=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr1486758uac.49.1533721530400;
 Wed, 08 Aug 2018 02:45:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:45:29 -0700 (PDT)
In-Reply-To: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 12:45:29 +0300
Message-ID: <CAHp75VdmrwZ4P0xrOOqpJaU7iuKS8zXGcRTg4zLrofZLdcb=8Q@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: support 4-16 bits per word
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 10:14 AM, Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:
> The spi-dw driver currently only supports 8 or 16 bits per word.
>
> Since the hardware supports 4-16 bits per word, adapt the driver
> to also support this.
>
> Tested on socfpga cyclone5 with a 9-bit SPI display.

> +       if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
> +               return -EINVAL;

> +       if (transfer->bits_per_word <= 8) {
>                 dws->n_bytes = 1;
>                 dws->dma_width = 1;
> -       } else if (transfer->bits_per_word == 16) {
> +       } else {
>                 dws->n_bytes = 2;
>                 dws->dma_width = 2;
>         }

Now these can be just

n_bytes = round_up(8);
dma_width = round_up(8);

-- 
With Best Regards,
Andy Shevchenko
