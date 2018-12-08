Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD69EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EE32081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmSnXPWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EE32081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLHSCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:02:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40869 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeLHSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:02:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so5245184lfe.7;
        Sat, 08 Dec 2018 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IEKyT2Opv/QM5bXnBJ0q4LnXDeVKaW/0XvtZsTh0ha0=;
        b=UmSnXPWaTMk/BTuCCROZcVmmvzXj3nSOwemfDzhoZ9DUXdKUHBYno82IG3QBHtzdHV
         1qLe6IBzJsK8Jfke8okCjBjaR1VLTtQLPpjXhYDyHIzu3pHEVqREyAVa5FT4C6ftsRj2
         iF8dA9aiKXtIeH7sI+0hoqZ13iY1w0wanK5HsX/Bp+ziqXT6qzae7fxTOycP+h7Mc8TB
         optS0bpz7gqpGQ7kbZKE1y5bCim9JTcQnvbUiynD+bU74M9StYfDAKVf1APrFK/APXck
         chHm7PXfEMAZJvQDj6CuX+DoMYqYjQknnYc7Dmukogloq6Sy1Vc1XaEOip2QsU11/FE1
         O+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEKyT2Opv/QM5bXnBJ0q4LnXDeVKaW/0XvtZsTh0ha0=;
        b=lisnTo3MDx0FSKEtUyqyuerVZdvRAUbD03YDkEMmgCt5UbyQZbu6E9lLNpFMAmdsuo
         g4r4W+JOUt3AnlOX7WFj1NSV5VrcMot3+CfPQ+mfY6kfrQq3F/HA4t7OPQIknUPlXSD8
         Gdp5fWJZorGpyGcHRCwjMZaulT2dppIP4nf/AB5YmPc2MfzRTeRKs+BsvEOzqXAcN9uw
         OUMAMk/MOPJB3rmv+m5pckrsB7dau0oT4tpezIX+zyLASyv7ASRK3w0TM9XpVNhvV98m
         MWTAaAB2oDr33JCvI+VC4wZGDMs+agJT5CtwZwewiNysc0HcExbWHACGyKwgWPQ7CnvI
         s+HQ==
X-Gm-Message-State: AA+aEWatoexWCfz72UBw49M2nEN+mqMqn4rDSO12lcPhIbci1F1gGvpT
        ra6j3/CAlhzabfXt2xhyjraxMs6m
X-Google-Smtp-Source: AFSGD/W+61zr31CUXL7bcH7lXAf7t/OIQZZTRBWML3k5YnmhTnu2Tb/1ZBAQEZL6UECMw5SHp4BK6w==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr3526516lfg.89.1544292166215;
        Sat, 08 Dec 2018 10:02:46 -0800 (PST)
Received: from [192.168.1.18] (blg173.neoplus.adsl.tpnet.pl. [83.28.200.173])
        by smtp.gmail.com with ESMTPSA id q4-v6sm1192731ljb.4.2018.12.08.10.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 10:02:45 -0800 (PST)
Subject: Re: [PATCH] leds: gpio: Drop unneeded manual of_node assignment
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544177406-24752-1-git-send-email-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0e918f62-a210-bcba-416a-db2178eade08@gmail.com>
Date:   Sat, 8 Dec 2018 19:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544177406-24752-1-git-send-email-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the patch.

On 12/7/18 11:10 AM, Krzysztof Kozlowski wrote:
> This reverts the main change of commit bff23714bc36 ("leds: leds-gpio:
> Set of_node for created LED devices") because of_node assignment is
> handled by core since commit 7ea79ae86c28 ("leds: gpio: use OF variant
> of LED registering function").  Basically the code was overwriting the
> of_node with same value.
> 
> No functional change expected.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/leds/leds-gpio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 45e012093865..998f2ff6914d 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -190,7 +190,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>   			fwnode_handle_put(child);
>   			return ERR_PTR(ret);
>   		}
> -		led_dat->cdev.dev->of_node = np;
>   		priv->num_leds++;
>   	}
>   
> 

Applied.

-- 
Best regards,
Jacek Anaszewski
