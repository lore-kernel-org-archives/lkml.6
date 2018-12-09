Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF0C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322420855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pifrzaPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9322420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLISzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:55:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLISzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:55:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so7658361lja.5;
        Sun, 09 Dec 2018 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=itRQ8suyIq9UlplYVR+WqdNG7qNHhSsNmijEKYsf6xA=;
        b=pifrzaPDqNDVS6eP++cY3FBllzRYA5f4zZSyI/ibVB81kigc8eNo+zP2UGIXtPCM7V
         2Cuf8yBhXasVpe9UGW0Q0jSZCHMygOD+tvQqjty6bIXIYvejgZZ6KWoercKwdc2d1jJP
         H6nqm2MHovnFxcFijTKqHWwoHLI2y1HNLjg+3hjCZeyAvKguj8jpAX9akxUU2DWwx8Hr
         Hjk7OG23RBJAr+8aJxMJzKGmoj2OdXfUtWIQZPfxy0tWIOHZdNCUWlBu6aSSYCABEz0U
         yAMvtoQzZcJJTkNrE3RdmKibhySelqlj1VIwMCSm5LqkFF/wCjoYoNMmlpjY2/WXbgfR
         ZGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=itRQ8suyIq9UlplYVR+WqdNG7qNHhSsNmijEKYsf6xA=;
        b=c3zf5H6VQD9qrwr7iBEyfePSxWafVRX+Ml/7yYwY4Sef1wK9aMfAnrwSpyiKZA41vl
         uy8RWRax0vj8BuBBw2/WE2u5+QZ5Mi1C9qEqnb9+bR/wpyMW2G1BNCfikCxs1LmDZ7x2
         DMkSLnh2OchrByHVU9v7neMh6gr3F9afUa0054a7JRrvu4ikLgDLZkc8yHYFdRRqpKIr
         iSuy3KDDVGT2aQ8gpIf9psexSUNPdylp44OsKDH75w3dVpLJpbZMZhEHOg05552uOVoU
         g0SNBCbi0J4d6n+RPjDeojdLf4Kz9aox75+w4rID4On+vQMvUuGf9brf+lfgFy1Vh4HQ
         lcdA==
X-Gm-Message-State: AA+aEWaaDHlLVXsseoqVOtpKTIwiTVtE2Nmi2I17UJMiqcvNk34xqdVw
        lMX0NhkPwNZpC8T23qZ1Jsbh5PSDIGQ=
X-Google-Smtp-Source: AFSGD/VVkQBBuBtES+VskEivPT0gFRAkpoKraS+e/9QpmAnsq3sNlSdvB2Cb4j2iJLYy7IsNGaAVnw==
X-Received: by 2002:a2e:8989:: with SMTP id c9-v6mr5346673lji.124.1544381730685;
        Sun, 09 Dec 2018 10:55:30 -0800 (PST)
Received: from [192.168.1.18] (cit97.neoplus.adsl.tpnet.pl. [83.31.43.97])
        by smtp.gmail.com with ESMTPSA id s62sm858072lfg.34.2018.12.09.10.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:55:29 -0800 (PST)
Subject: Re: [PATCH 4/4] leds: trigger: Add pattern initialization from Device
 Tree
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
 <1544185974-5932-4-git-send-email-krzk@kernel.org>
 <8222f85b-4e61-69c4-6d31-ba559de02829@gmail.com>
Message-ID: <fcb28be6-7d6a-1216-5a22-339f30366fd1@gmail.com>
Date:   Sun, 9 Dec 2018 19:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8222f85b-4e61-69c4-6d31-ba559de02829@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/18 7:44 PM, Jacek Anaszewski wrote:
> Hi Krzysztof,
> 
> Thank you for the patch set.
> 
> Applied 1/4 and 2/4.
> 
> I'll hold on merging 3/4 until we sort out the issues
> I have with this one. Please refer to my comment below.
> 
> On 12/7/18 1:32 PM, Krzysztof Kozlowski wrote:
>> Allow initialization of pattern used in pattern trigger from Device Tree
>> property.
>>
>> This is especially useful for embedded systems where the pattern trigger
>> would be used to indicate the process of boot status in a nice,
>> user-friendly blinking way.  This initialization pattern will be used
>> till user-space is brought up and sets its own pattern, indicating the
>> boot status is for example finished.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c 
>> b/drivers/leds/trigger/ledtrig-pattern.c
>> index 1870cf87afe1..96309d3bc43c 100644
>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/leds.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/of.h>
>>   #include <linux/slab.h>
>>   #include <linux/timer.h>
>> @@ -331,6 +332,21 @@ static const struct attribute_group 
>> *pattern_trig_groups[] = {
>>       NULL,
>>   };
>> +static void pattern_init(struct led_classdev *led_cdev)
>> +{
>> +    struct device_node *np = dev_of_node(led_cdev->dev);
>> +    const char *pattern;
>> +
>> +    if (!np)
>> +        return;
>> +
>> +    if (!of_property_read_string(np, "linux,trigger-pattern", 
>> &pattern)) {
>> +        if (strlen(pattern))
>> +            pattern_trig_store_patterns(led_cdev, pattern,
>> +                            strlen(pattern), false);
>> +    }
>> +}
>> +
>>   static int pattern_trig_activate(struct led_classdev *led_cdev)
>>   {
>>       struct pattern_trig_data *data;
>> @@ -354,6 +370,8 @@ static int pattern_trig_activate(struct 
>> led_classdev *led_cdev)
>>       timer_setup(&data->timer, pattern_trig_timer_function, 0);
>>       led_cdev->activated = true;
>> +    pattern_init(led_cdev);

With my recent patches it would suffice to replace above line with:

if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
	pattern_init(led_cdev);
	led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
}

> It means that the pattern defined in DT would be applied
> whenever the pattern trigger is set for a LED class device,
> whereas it should happen only on LED class device initialization,
> if linux,default-trigger is set to "pattern".
> 
> What we would need for making that work is a generic support for
> parsing trigger specific initialization data in the
> of_led_classdev_register().
> 
>> +
>>       return 0;
>>   }
>>
> 

-- 
Best regards,
Jacek Anaszewski
