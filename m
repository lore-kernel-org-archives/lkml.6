Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5357920831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbydAKoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5357920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJYEhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:37:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42778 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeJYEhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:37:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id z9-v6so1148442ljk.9;
        Wed, 24 Oct 2018 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zlyp8FXFAXo3O5WhMwUliI65vjRpl/Ro76LsLR9vxGs=;
        b=bbydAKoVCFUT+IQ+GltCEaCkn5nzYs8lRT3AKx53C85S8GI8DA8GE7C2INP2NODyZ6
         C0pFZByEH6WMOuxrqEqj6HDvDR6jSHRz7CEHldghaxab/dH5jTtgEGUJa610kB1HDIFE
         AAdJC8FtEfUslsDPdwqgEX14YTKrgo3ruyURmPZaJrFkK5qi4oSRLb2J8ZpK0b2Ipkt2
         OS33Q23ggVgYPGC9E7u8vQNpvEb+2+AvdQ090IHyJz37bp9hWe0AsQxDFxD2kos2NU09
         L4xO44TPfhcaEIkNgBATmbapGCgt+ctfrfvyMweoB5yljzMF9JNrguEdjJFMO2XmDAeZ
         VFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zlyp8FXFAXo3O5WhMwUliI65vjRpl/Ro76LsLR9vxGs=;
        b=GxGj14/B8NXPrbZus8iTCak2FORs9j7Jmwv+Qpy7sekZdx7DSR8bGYFvjn45exoIdE
         zCowZfXaISyfJ+dLmkTTyXnO/H7ByIGekeXgV7hfDsOlNUQalOU7U0LJdkYBV8lNSiNY
         RZD9VHN7v7BQvUVTWRdgiuVX4e+Q6xmHyFFZv/vaAvbOzbANX2LAveWvhEiovgO0N7BZ
         dPosIFkvWEVMgRNbMRZLnSvxgPvMfm7O7rcLlu6w+34N1O0erMgtTWfUjeaH3+oEp9UA
         XoFUUPo4BQ6ZpbSp0m27HqWlw3leiIs5VyGoPswcnSJ8Yp/imkHiShzwpVnyzTIKNZUn
         M79A==
X-Gm-Message-State: AGRZ1gJraE+Y7anCQBrYO/lqdUuT+O+LM8lyYAP3IiU8/0/z2eY76iO9
        13bZQAHNUGPnGx7KKhwsulA=
X-Google-Smtp-Source: AJdET5ecJZ7HvSizyzH4L0G5Mo7D2cmJkLksN3WIGBV6Ap65Q9lrsWynr7/SaGbvZPm5pjE6yYFiDA==
X-Received: by 2002:a2e:154b:: with SMTP id 11-v6mr2650237ljv.131.1540411653678;
        Wed, 24 Oct 2018 13:07:33 -0700 (PDT)
Received: from [192.168.1.18] (bgs214.neoplus.adsl.tpnet.pl. [83.28.82.214])
        by smtp.gmail.com with ESMTPSA id n16-v6sm600765ljh.27.2018.10.24.13.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:07:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com> <20181023185453.GA27397@amd>
 <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com> <20181023193014.GA32003@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <00720f10-a525-32d1-0aa5-00fc88251f5e@gmail.com>
Date:   Wed, 24 Oct 2018 22:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023193014.GA32003@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 09:30 PM, Pavel Machek wrote:
> On Tue 2018-10-23 21:09:54, Jacek Anaszewski wrote:
>> On 10/23/2018 08:54 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> +	led->field = devm_regmap_field_alloc(dev, regmap, conf);
>>>>> +	if (IS_ERR(led->field))
>>>>> +		return PTR_ERR(led->field);
>>>>> +
>>>>> +	led->cdev.max_brightness = 1;
>>>>
>>>> s/1/LED_ON/
>>>
>>> Actually, I prefer constant 1 here, as it makes it immediately obvious
>>> this supports just 0/1.
>>>
>>> Yes, LED_ON is also 1, but I had to grep the header files for
>>> that... (I thought it was 255).
>>
>> If we have the enum for that, let's use it.
>> Here's the commit message of the patch adding LED_ON - it should
>> be somehow familiar to you - see the ack.
> 
> Well .. brightness = LED_ON; is good usage. max_brightness = LED_ON is
> IMO less readable than max_brightness = 1.
> 
> Looking at situation again... Having LED_ON and LED_FULL, with some
> leds having max brightness of 1023, so LED_FULL is not really full
> brightness any more... Maybe it is time to get rid of the enum, and
> make it plain int. It does not really enumarate anything, and it does
> not help readability, either.

I agree that it introduces confusion.

Yet, there are many out of LED subsystem files to update:

find -name "*.c" -o -name "*.h" | xargs grep  "enum led_brightness" |
awk -F: '{print $1}' | sort -u | grep -v "leds" | wc -l

returns 87.

>> commit 4e552c8cb5bc9137e67e035bab8df6dddbca7384
>> Author: Andi Shyti <andi.shyti@samsung.com>
>> Date:   Thu Jan 5 11:34:12 2017 +0900
>>
>>     leds: add LED_ON brightness as boolean value
>>
>>     Some devices do not handle the led brightness or simply don't
>>     care about it. Conceptually said devices want to just switch on
>>     or off the led. It is useless in this case to have a 255 range
>>     of brightness, while just having an LED_ON and LED_OFF improves
>>     the boolean meaning of the led status.
>>
>>     Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>>     Acked-by: Pavel Machek <pavel@ucw.cz>
>>     Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>
>>
> 

-- 
Best regards,
Jacek Anaszewski
