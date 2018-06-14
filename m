Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A391EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59292208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aDyA4BQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59292208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeFNFkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:40:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30252 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeFNFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:40:33 -0400
X-Greylist: delayed 703 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 01:40:33 EDT
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5E5eIBm019326;
        Thu, 14 Jun 2018 14:40:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5E5eIBm019326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528954819;
        bh=yrxNZ9X2J4xjCoD9alG5CMv5HE6/H9UjPDo6EWwalsc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=aDyA4BQ6mEK4p994J2vFWarTC670Ep716AoQxDPXqSokF9fIEfv+Q0p3fRYNGxoxp
         r2TGIHBYhwTtuZMwkebs9l1wMoglueJZd8h+VkC2nJEfg/sqreTnfUAlLcZwfLk3Ij
         Rpkp3gjj+/NIGbY2Qos9vNJrDEdFSTrUrm6j+m76rmoLX7Ufr9Ns2hR4gJRCqy5fLq
         6MNohYLHvPWCtcfxa2U3BfKAgg62jCkCQaj0vqt56rEmrpL0jKWjgNdHgLM5fYnv6t
         xw/o8HBO5v+3QGjkxoeEB3NSWeoPv3JTAcyN3DX7Eb37TL9TA04R3NhV6euTvocpba
         1UiG2xxV7JuXg==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id o17-v6so2951615vka.2;
        Wed, 13 Jun 2018 22:40:19 -0700 (PDT)
X-Gm-Message-State: APt69E3Z5QFFdRziCKNbq2J2HaFFfBF7roKWL3UeBUJMdCj3xdlnH0Ef
        HkzneT2I13XEt7me0zLtH//LlRQa1tERcYQGpAU=
X-Google-Smtp-Source: ADUXVKKn3CGRXF+8Sxc7UE8q5tmJOgmMuL1107lhIwEZsmQDuuVz3tznx0Gehpd4PR2DMQCyk5pxMczDja1WIJ5Bjl8=
X-Received: by 2002:a1f:b143:: with SMTP id a64-v6mr660699vkf.65.1528954817909;
 Wed, 13 Jun 2018 22:40:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 22:39:37
 -0700 (PDT)
In-Reply-To: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
References: <1528954065-25563-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 14:39:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASh4j2nTbemsPmQXOnCrqJ4BQ0-PnWHQsUe-qa4KzpDLA@mail.gmail.com>
Message-ID: <CAK7LNASh4j2nTbemsPmQXOnCrqJ4BQ0-PnWHQsUe-qa4KzpDLA@mail.gmail.com>
Subject: Re: [PATCH] gpio: uniphier: set legitimate irq trigger type in
 .to_irq hook
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-14 14:27 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> If a GPIO chip is a part of a hierarchy IRQ domain, there is no
> way to specify the trigger type when gpio(d)_to_irq() allocates an
> interrupt on-the-fly.
>
> Currently, uniphier_gpio_to_irq() sets IRQ_TYPE_NONE, but it causes
> an error in the .alloc() hook of the parent domain.
> (drivers/irq/irq-uniphier-aidet.c)
>
> Even if we change irq-uniphier-aidet.c to accept the NONE type,
> GIC complains about it since commit 83a86fbb5b56 ("irqchip/gic:
> Loudly complain about the use of IRQ_TYPE_NONE").
>
> Instead, use IRQ_TYPE_LEVEL_HIGH as a temporary value when an irq
> is allocated.  irq_set_irq_type() will override it when the irq is
> really requested.
>
> Fixes: dbe776c2ca54 ("gpio: uniphier: add UniPhier GPIO controller driver")
> Reported-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

BTW, gpio-xgene-sb.c is also suspicious.
https://github.com/torvalds/linux/blob/v4.17/drivers/gpio/gpio-xgene-sb.c#L136


I do not have that hardware, but GIC will complain about NONE type
if gpio(d)_to_irq() is used.



Commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of
IRQ_TYPE_NONE")
only mentions DT cases.

It is unclear how to take care of GPIO-originated IRQs.




>  drivers/gpio/gpio-uniphier.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index d3cf950..58faeb1 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -181,7 +181,11 @@ static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>         fwspec.fwnode = of_node_to_fwnode(chip->parent->of_node);
>         fwspec.param_count = 2;
>         fwspec.param[0] = offset - UNIPHIER_GPIO_IRQ_OFFSET;
> -       fwspec.param[1] = IRQ_TYPE_NONE;
> +       /*
> +        * IRQ_TYPE_NONE is rejected by the parent irq domain. Set LEVEL_HIGH
> +        * temporarily. Anyway, ->irq_set_type() will override it later.
> +        */
> +       fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>
>         return irq_create_fwspec_mapping(&fwspec);
>  }
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
