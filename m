Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF12DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C0A207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgRGmBqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C0A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJZD4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:56:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41200 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeJZD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:56:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id c16so7671190lfj.8;
        Thu, 25 Oct 2018 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ts7TFkOcQrNT9QZYRG9orPdQBG1lJlw9nmhyPLAOg8M=;
        b=RgRGmBqpivL0cDX7ogVD3Vi6M0/z5/7693frqaStH5UZk/AylevH8/20uVw+xqJkLN
         msP4AA9N/5GkZRhUl4ABxA5VnPfwVnC2i1FhaP2GfGmi2s975mP5V5tkXn4qRHWozSdm
         wWk5WJ4kqGv7w75vduGBgzBTBRymLs+rs44uezmfa2WmPCYwyKVJd9+TgfEzCoIkVG9o
         P1Zhj44oPi6lbQgBUpZdeIgyb7jG9ZihG3MipArD9KNBpj1W4+pPcXIQa+YRyYUPtS8P
         ypie3Z/ZPJR972Y5bHHcP4cxlbLMUXFmHLIMJZKIHkAJWMvJiSLyIp8ltxo1lMVWW7AS
         p/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ts7TFkOcQrNT9QZYRG9orPdQBG1lJlw9nmhyPLAOg8M=;
        b=bifFxGqoQ+zwDDZm8kw/XZ0PAUjBAMuofoFr6GjvYKa5Jg4hkcKx4L11JZRsAkF9lE
         JTLRNMKnZkJYbzpRnsZI3iFQ9AnQ1RjTXvml2go/5KdtfhI+IeXpBjt4MrgijT6/24cC
         f4GJLDXw5dzY2J5Adaxb/pQUygQ3Tzp8cQ2Znekaz1aUYVW3m5VlyKKKhkE9XkAI9RXe
         nRMyNY2qhUA5lyuESLX+fdw8z2ruVmsq3e0Kmv4GY010KPOYOtTAVmxOccUFsxJrkh00
         S4ihBDS+/pNX7/RliUKUNB6ERRPt4fPtqxgrgWzVC44jJbZW3TjnpF+Z5FVaFqDnJwTt
         Tq1A==
X-Gm-Message-State: AGRZ1gIcceCsvuBXoNvzdHa9SiKRYRLAB/vv7YqrT14NL4VHNMc1zDxb
        437hNg8l0urEm1DMgO1z2j8=
X-Google-Smtp-Source: AJdET5cGpddryjUGgJjST20SZyQiCm1oso9cBeNnqMsKHeuKJ3xul/e9VReVwSeSjaUSp+AYbLIXew==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr286778lff.141.1540495359123;
        Thu, 25 Oct 2018 12:22:39 -0700 (PDT)
Received: from [192.168.1.18] (dnt139.neoplus.adsl.tpnet.pl. [83.24.101.139])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1263547ljc.64.2018.10.25.12.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:22:38 -0700 (PDT)
Subject: Re: [PATCH] leds: gpio: Fix gpiod for DT based devices
To:     Dan Sneddon <dan.sneddon@gmail.com>, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <CACceFXdF9XQS6WeSWvO=EKUEGnKwG_VkqUOECA3kJY-Hy72fjQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <05996b8d-f35c-d2d6-3043-75456fbfe0fa@gmail.com>
Date:   Thu, 25 Oct 2018 21:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACceFXdF9XQS6WeSWvO=EKUEGnKwG_VkqUOECA3kJY-Hy72fjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch. Nonetheless, I've just applied similar Liviu's
patch [0], since it arrived one week ago already.

I'll send it upstream with LED fixes for 4-20-rc2.

[0] https://lkml.org/lkml/2018/10/18/154

Best regards,
Jacek Anaszewski

On 10/25/2018 05:06 PM, Dan Sneddon wrote:
> commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> failes to set the gpio descriptor for DT based machines.  Since the
> value being passed in is always 0 the descriptor fails the validation
> check but does so silently.  This means the driver probes successfully
> even though it can't actually control the gpio line.  This patch sets
> the gpio descriptor in the path taken by DT based devices.
> 
> Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
> Signed-off-by: Dan Sneddon <dan.sneddon@gmail.com>
> ---
>  drivers/leds/leds-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index 32fa752..e0e57c2 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -162,6 +162,7 @@ static struct gpio_leds_priv
> *gpio_leds_create(struct platform_device *pdev)
>             fwnode_handle_put(child);
>             return ERR_CAST(led.gpiod);
>         }
> +       led_dat->gpiod = led.gpiod;
> 
>         fwnode_property_read_string(child, "linux,default-trigger",
>                         &led.default_trigger);
> 


