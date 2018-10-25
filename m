Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E505720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRhZFgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E505720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJZDwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:52:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeJZDwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:52:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so10453333wrw.11;
        Thu, 25 Oct 2018 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CdjmIkEAGOl/px5mDsTshXfeP45BKOqdMjgKWJ0OPaI=;
        b=HeRhZFgIhUlcP5M3Il6p53W5hfu/zaj4kl3CpqGAyLODdyeUxsi8KCjyyV8hc3Hv01
         Rv5JFv8dO33Al9MWOsX/S2FyZjc0YiGcWHN8RzmXMw8tGcZZnnHViNrUjRw4ppJ6fnsR
         7ei32UPkOUxylFwQ4zXCmWjo7Ow+xEGSan4VKkA7b9OcL+wYDuOoLUtYgyxHTELGTBq4
         qq+c3jo4l58HGz77zypcj6uls/7hX/x47fWw+YxZftFwC1LKFng8f9e9MQG+WfRBp5UH
         7R2SXKTYInxSHy6sWNwDSwoWVKTklGMBFJ8qNuQVSvjsm18xFgysDBsJ8/m7qkJggtwu
         4AVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdjmIkEAGOl/px5mDsTshXfeP45BKOqdMjgKWJ0OPaI=;
        b=fj9GA7ndrGLXGwMWl2VsUeNp0ZsoD8PoM1tiNq0XdsTnUiuf6Rg87grp5LyfkLwc0Q
         05u63W/oUa04WBDRwFnFOhHFO8/oaErLkmrw6ojB7GZofV9d7U/O0oYUCS9tMbnAcWiB
         Tel79JVYFIc2dIuv/5LFIbqMmlMVD32WCsD+9M5gzzVnGw2ecMm4UlsEQ1fFZHgafvi+
         DkMjXqKYuXTeRr6qmo2Edu842i2V0IBdhfOIUFuRZkoikHZNlJY6tiuZdi7LdSiktDR+
         ijSAEKn/l27afzO6OSLhrcMMlOu2JCY4Xj3hjVEmY0m96RMrRNNP6trg+k+jEfTDrWya
         +BAA==
X-Gm-Message-State: AGRZ1gJAR4E/itutfY/NCDoks1JUINrIj+dLaQNFBrBiGtFXiUxw6TyR
        IespSXpMdVit0zCfB4kTFYUlC5Sf
X-Google-Smtp-Source: AJdET5fLL/f7kOf3iS+obW0DlZCvYpoXUbANimsWVzFMnifXn3t0o2S0hsPG5IZNKfrqaZ0WL4b7rg==
X-Received: by 2002:adf:f852:: with SMTP id d18-v6mr3056111wrq.125.1540495086132;
        Thu, 25 Oct 2018 12:18:06 -0700 (PDT)
Received: from [192.168.1.18] (dnt139.neoplus.adsl.tpnet.pl. [83.24.101.139])
        by smtp.gmail.com with ESMTPSA id b139-v6sm3862983wmd.36.2018.10.25.12.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:18:05 -0700 (PDT)
Subject: Re: [PATCH] leds: gpio: set led_dat->gpiod pointer for OF defined
 GPIO leds
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20181018001432.710-1-liviu@dudau.co.uk>
 <20181023111842.GA29083@bart.dudau.co.uk>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <02905f80-4d61-33c7-778a-68e7aa29c2c2@gmail.com>
Date:   Thu, 25 Oct 2018 21:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023111842.GA29083@bart.dudau.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

Thank you for the patch.

On 10/23/2018 01:18 PM, Liviu Dudau wrote:
> On Thu, Oct 18, 2018 at 01:14:32AM +0100, Liviu Dudau wrote:
>> Commit 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
>> removed the common code path that set the led_dat->gpiod pointer in
>> create_gpio_led(), but only added it back for the devices that have
>> a valid gpio_led_platform_data structure. Calling gpio_leds_create()
>> in gpio_led_probe() is not enough to get a valid gpiod pointer.
>>
>> Fortunately enough, gpio_leds_create() already gets the needed pointer,
>> we just need to assign it to the relevant gpio_led_data structure.
>>
>> Fixes: 45d4c6de4e49 ("leds: gpio: Try to lookup gpiod from device")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
>> ---
> 
> Gentle ping! I haven't seen any reply to this, even if the commit it fixes is
> still in for-next branch.

I found this message in the Spam folder of my gmail mailbox.
It can have something in common with the ASCII art in your signature.

Anyway, I've just applied the patch to the fixes-for-4.20-rc2 branch
of linux-leds.git.

Best regards,
Jacek Anaszewski

> 
>>
>> Hi,
>>
>> I found this issue while testing linux-next-20181017, I don't know how
>> stable the leds for-next tree is in terms of commit IDs, if that gets
>> rebased then the Fixes commit ID needs updating.
>>
>> Best regards,
>> Liviu
>>
>>  drivers/leds/leds-gpio.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
>> index 32fa752565bc..45e012093865 100644
>> --- a/drivers/leds/leds-gpio.c
>> +++ b/drivers/leds/leds-gpio.c
>> @@ -163,6 +163,8 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
>>  			return ERR_CAST(led.gpiod);
>>  		}
>>  
>> +		led_dat->gpiod = led.gpiod;
>> +
>>  		fwnode_property_read_string(child, "linux,default-trigger",
>>  					    &led.default_trigger);
>>  
>> -- 
>> 2.19.0
>>
> 

