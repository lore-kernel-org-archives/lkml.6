Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAD8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A68224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i4YprPeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A68224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeKMBmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:42:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42351 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeKMBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:42:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id x63-v6so7502640oix.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4pEWEwojPYfQK9B/fdcglsTA9QWwPjW7gO4YGiQHOQ=;
        b=i4YprPeEBELHnBq/Mj8CXbS9DPqgDHn0GVkCr5b9AAl/Tfn0zr2OF/rWq9/AbtLlKG
         nAcyNY61c49TxFKd3c6mmIv8V2BY8C38trCc8AuqkAef3pOV5+O57gkDz0EB1YsZ9/j7
         qxjug+gcCn35g2fGz7t3BjZKyyYQH7CiaklDWT0HWDrxQgpZwCziGzlS0PdY1hGQMthz
         5oG7sSIgWGsB1//71WpGmVkiS5VeuiGG260d2C4l7Y9SI8Kyc9lVqk0q+BsoCyEwkWZv
         dqbxweCbP9iSHp7Xzr3GUIxXZp18dNfMollQbEJ00cF48uvowlrp7pW2XExEYusbpS+y
         e0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4pEWEwojPYfQK9B/fdcglsTA9QWwPjW7gO4YGiQHOQ=;
        b=GPEQbbel/kSayXUKIwvmNpfxRD6JycwO+PbNG95LUAWgbGPUBwAcVpt/htMqvhx77x
         45loqwXJ3TN2+B9SAoZc4gyPrCMzMS77YcIwBieAxqpsCWU+b8KVI30Mm8wJC7mmXrWu
         si+fp0pmGHwnqNLb48Ap/t2Do++M92EzSEODeB/EWD2lyUZOD36RanNQRcB3djUkN96U
         t5RbFh6aW3LKHpIxAb3x6h/1w1tLJ/AFPHHJwMy3pO7SvEwE0iXAMRfaZgkqLlwaL7mT
         2DBaZGLgb72O+D9wslsPQ82O7BfzV5z5CLtZwI8ZOP3HYXZgEUPGULUjUwhQ8Fro48Sf
         C5oQ==
X-Gm-Message-State: AGRZ1gKGogprfanmi+sziCUDepL++93O3r9vQLapXGCNZ78pVVzsH7x3
        x+53If1KBsWvNvGN0Z2TnKW3CJGFKwkD00NHRGRdNA==
X-Google-Smtp-Source: AJdET5fJohtihmOxDFdyggkUCAdKloiB5zWJuiGFe6P91rtVTX2SVySoBC/nyJh7uf7lpRuHjt94CfJDyPeIuxGcS+g=
X-Received: by 2002:aca:55d3:: with SMTP id j202-v6mr817117oib.277.1542037742940;
 Mon, 12 Nov 2018 07:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20181112141028.10213-1-johan@kernel.org>
In-Reply-To: <20181112141028.10213-1-johan@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 12 Nov 2018 16:48:51 +0100
Message-ID: <CAMpxmJVzbQ850uMkwG+e5Gg_GgfLS_wxXOoY+xEXfjqfFyt75A@mail.gmail.com>
Subject: Re: [PATCH] gpio: drop broken to_gpio_irq_chip() helper
To:     johan@kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, treding@nvidia.com,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 12 lis 2018 o 15:11 Johan Hovold <johan@kernel.org> napisa=C5=82(a):
>
> Drop the broken to_gpio_irq_chip() container_of() helper, which would
> break the build for anyone who tries to use it.
>

Which is the usual problem with APIs nobody uses...

> Specifically, struct gpio_irq_chip only holds a pointer to a struct
> irq_chip so using container_of() on an irq-chip pointer makes no sense.
>
> Fixes: da80ff81a8f5 ("gpio: Move irqchip into struct gpio_irq_chip")
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  include/linux/gpio/driver.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 2db62b550b95..21bff1f14fde 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -166,11 +166,6 @@ struct gpio_irq_chip {
>          */
>         void            (*irq_disable)(struct irq_data *data);
>  };
> -
> -static inline struct gpio_irq_chip *to_gpio_irq_chip(struct irq_chip *ch=
ip)
> -{
> -       return container_of(chip, struct gpio_irq_chip, chip);
> -}
>  #endif
>
>  /**
> --
> 2.19.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
