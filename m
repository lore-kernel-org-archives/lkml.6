Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B3222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I0rfuUg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfBLUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:53:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44308 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbfBLUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:53:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so20032pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=RKa0vaLRy80JEhZ94QJ0R+r1K4+tymdSzaV0CbMmito=;
        b=I0rfuUg/aRWA58ZBeJdAyPj/P3U0VGCvFmtUZNoDA8gEFpbHX77HskfEB6IZf3uiAG
         tyzE9UXVVdXebpIBUm2FTE2Ujt6ccKmY+YrAK1/Et4qr/smWBthcsBGshhuD4sRSJk0R
         Cy/Y8IdTcS58C5mx3DZoB4e42wNRZaRtPp238=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RKa0vaLRy80JEhZ94QJ0R+r1K4+tymdSzaV0CbMmito=;
        b=pS+ZB7uw54IBpgSumBBTrsyKmPFsn41R+qSMCqGCxr1gdrLN4aMTB1qYE/vwETGngx
         42xmXuXraiq9x+daEopWr2bNfgohJBoCuFP6GeIFIb70WWFxEFUMj44A0QLLauO/FPRG
         wMDrHI9J3PUBrUa5jtQyfV0l27qe45+j8toC01z79fRBeIgrGhqtdsOFpvMXckbps2m1
         Oja0EhvKLiZ8uGUTeQhmSDaD1YoC6k1r+Z7fNoPSXS6U+hsgwBVFQFKVUY8Is/Wk3Wph
         n8fxB7BIDJx1T07ua7LOBYMrCLH6xQ7XxDxCL55WkSw/sVEKjmsyu9nX2/45OfqQtbh3
         vLwA==
X-Gm-Message-State: AHQUAuauDjutoQCvSpYYb9xn/na4BtnLp2BA0DTYWvTvLTYvFzeWqctA
        l8ZnoRZQa1mIwBvNhjYXqYynaA==
X-Google-Smtp-Source: AHgI3Ibr1us+nXy12eZ01bccUnB9Nx0nRxTA0KEvQ1BedCMiBk0ed7Ukm+3s+7aMSYNZNA+yioeM2Q==
X-Received: by 2002:a65:608d:: with SMTP id t13mr5460568pgu.129.1550004825589;
        Tue, 12 Feb 2019 12:53:45 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x6sm14595179pfb.183.2019.02.12.12.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:53:44 -0800 (PST)
Subject: Re: [PATCH 1/3] gpio: bcm-kona: drop
 ->irq_{request,release}_resources hooks
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20190208115201.7518-1-thomas.petazzoni@bootlin.com>
 <20190208115201.7518-2-thomas.petazzoni@bootlin.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b51bb5e5-846e-5982-7a2b-67f6c488f267@broadcom.com>
Date:   Tue, 12 Feb 2019 12:53:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208115201.7518-2-thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-02-08 3:51 a.m., Thomas Petazzoni wrote:
> Those hooks implement the exact same behavior as the default hooks by
> gpiolib, so there is no point in having a duplicated definition in
> gpio-bcm-kona.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> ---
> Note: this commit was only build tested.
> ---
>   drivers/gpio/gpio-bcm-kona.c | 16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index c5536a509b59..0ae806edabc2 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -484,28 +484,12 @@ static void bcm_kona_gpio_irq_handler(struct irq_desc *desc)
>   	chained_irq_exit(chip, desc);
>   }
>   
> -static int bcm_kona_gpio_irq_reqres(struct irq_data *d)
> -{
> -	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
> -
> -	return gpiochip_reqres_irq(&kona_gpio->gpio_chip, d->hwirq);
> -}
> -
> -static void bcm_kona_gpio_irq_relres(struct irq_data *d)
> -{
> -	struct bcm_kona_gpio *kona_gpio = irq_data_get_irq_chip_data(d);
> -
> -	gpiochip_relres_irq(&kona_gpio->gpio_chip, d->hwirq);
> -}
> -
>   static struct irq_chip bcm_gpio_irq_chip = {
>   	.name = "bcm-kona-gpio",
>   	.irq_ack = bcm_kona_gpio_irq_ack,
>   	.irq_mask = bcm_kona_gpio_irq_mask,
>   	.irq_unmask = bcm_kona_gpio_irq_unmask,
>   	.irq_set_type = bcm_kona_gpio_irq_set_type,
> -	.irq_request_resources = bcm_kona_gpio_irq_reqres,
> -	.irq_release_resources = bcm_kona_gpio_irq_relres,
>   };
>   
>   static struct of_device_id const bcm_kona_gpio_of_match[] = {
