Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6710520A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Xnfh3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6710520A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeHPDIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:08:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38307 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeHPDIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:08:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so1173901plq.5;
        Wed, 15 Aug 2018 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HgM14SYS88sNN8JlnQh8L3WOJvqLHLkL0+Z+QL6CT/k=;
        b=P1Xnfh3QeVytKZwQvL7lsTVSi0lbCfHkrYagrfN9KPCQaU5V2YkzqZATzrkTLXIg0u
         tScE2m6pR61KaMux5dtJ704udBKO3s6mxWn7fGqbiXqD60YZLN0NDgHXELACtORXhNnK
         6YCbk82MqLlFTTHUPiPBq0S94hKLMyPM/X3nFDyzIKvdr7OEiLNbGNPRRcQVK8zQ8QNv
         MB1yjzn+fuKfHBbU8Ux3rzv9uibcUyoc0/rGOcclkk9A0+2Cs4lBMjfrRUSTOaXspdCZ
         N9d3u7OsBB90N+GGqPjgNFXSDWVws02+x+PFRdG32q9FCB8szH5QFhps5qXMMnDkJ7lC
         yISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HgM14SYS88sNN8JlnQh8L3WOJvqLHLkL0+Z+QL6CT/k=;
        b=ZVSC5kbsaHHul0RyMuyk53B0iisukUuNQGulelCrbg8fznksxkmHXcOYz9kY17aFeq
         zNNzxVrRlWCm+FNXRGEceFfhzzRN5IGv5vP1Df/4KP+NSnVye13qVqn/WxH1r0W9M7tJ
         Rv/faJLgF1xBwVwmCFui4Bj/L3bhSdFPhsskulRPFWRm8ndIs5D2JSf2pM6U+nhgRHyS
         QqsqmfIE9r3FWUwq0E7lQ2HKOKYtnuuf/y4+XXTa/ymp9en0FqSQLi3a2du8SY0UnUOn
         4+KxlxWC1X+esDSLlIZfe3pdYpSIxrlMPBYfQ72e3INZwnSk1xkWYwdo2EkalsBP74Wx
         iHNw==
X-Gm-Message-State: AOUpUlGtcO5Xt//nloScCD0t+zjJP17dIELGr+k1/Dfmux8Dq+g9dMXy
        iqRX3W+NlLvCq//U2Ggyf0s=
X-Google-Smtp-Source: AA+uWPyfhpdZHYdmKD3nqsF5+O7BQUkF1MrbWvaA98or58otNfpZ6z0I8xV9nwYOaPMYGMIM3x9JrQ==
X-Received: by 2002:a17:902:680d:: with SMTP id h13-v6mr20726524plk.146.1534378448797;
        Wed, 15 Aug 2018 17:14:08 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id t21-v6sm40169123pfi.73.2018.08.15.17.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 17:14:07 -0700 (PDT)
Subject: Re: [PATCH] gpio: brcmstb: allow 0 width GPIO banks
To:     justinpopo6@gmail.com, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        computersforpeace@gmail.com, linus.walleij@linaro.org,
        gregory.0xf0@gmail.com
References: <1534289517-1805-1-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d52fd4f0-1589-86e5-9dfd-4748bdab9bde@gmail.com>
Date:   Wed, 15 Aug 2018 17:14:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534289517-1805-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 04:31 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks. We handle 0 width GPIO banks by
> incrementing the bank and number of GPIOs, but not initializing them.
> This will mean a call into the non-existent GPIOs will return an error.
> 
> Also remove banks and GPIO information from the dev_info print. This
> information is misleading since the incremented banks and gpio_base do
> not reflect the actual GPIOs that got initialized. We leave this
> information out since it is already printed with dev_dbg.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 16c7f9f..8658910 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -664,6 +664,18 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>  		struct brcmstb_gpio_bank *bank;
>  		struct gpio_chip *gc;
>  
> +		/*
> +		 * If bank_width is 0, then there is an empty bank in the
> +		 * register block. Special handling for this case.
> +		 */
> +		if (bank_width == 0) {
> +			dev_dbg(dev, "Width 0 found: Empty bank @ %d\n",
> +					num_banks);

Stylistic nit: you would want the second line to be aligned at the start
of the opening parenthesis

> +			num_banks++;
> +			gpio_base += MAX_GPIO_PER_BANK;
> +			continue;
> +		}
> +
>  		bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
>  		if (!bank) {
>  			err = -ENOMEM;
> @@ -740,8 +752,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
>  			goto fail;
>  	}
>  
> -	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
> -			num_banks, priv->gpio_base, gpio_base - 1);
> +	dev_info(dev, "Brcmstb GPIO registered\n");

Not sure if there much value in preserving that message anymore, if the
controller is not there, nothing will show up in /sys/class/gpio, so you
would pretty quickly find out that something went wrong?

>  
>  	if (priv->parent_wake_irq && need_wakeup_event)
>  		pm_wakeup_event(dev, 0);
> 


-- 
Florian
