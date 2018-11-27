Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED681C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5320660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD5320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeK1DOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:14:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42775 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbeK1DOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:14:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so19479791edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XeZ9vf4SwBGVS63tVJuI6NDvq2rsV7D369LO6QF7beA=;
        b=a1KUl1KYTHnZWqgnvAl30Ve9Q9+5lj2AACAVJqHcHJ3rhhbRc8LB6/uzjHjZrpn/Hz
         hnwWVKHE4zvfLqfMs2Dj5KXQJ95JQjQCS+IKuzN1Jio1aVz2S7o8HQZRmlj8MsmqJyUh
         3TzMNwKbEX9CfU9rnCoXdLcSchcNX2TFiT2bj0eD/u4nnep85DuYvn4HZUUBghrIM8im
         tgPwHFYR4qdF8QAUvMlu/UQj+iX8lK7+F1n0E20ZgPaKSsCWEc5fUdcmqf0JHd5LBCl/
         nIv67unif3cFjB8Ilr7tmxU1PK7SGuUqjGz7P5h/6hqIm/sSSNOoIZ8aPJ/Z1PL4TDgU
         H4Xw==
X-Gm-Message-State: AGRZ1gJXBwGJtGzGVz75vSCj8nFMCCY6S4iSnPMVS6z6Pefr/6wDe5OC
        8jgLlSRobtsO5Pmr4ERPpHTm1ABwiFI=
X-Google-Smtp-Source: AJdET5fRxlHRGJkK2iNBItntMrf0rPvTbRZ4hW/UDCPpSHwmrhCsbCbhOnV49GY2VVOw/jBVRDPzXA==
X-Received: by 2002:a17:906:59d6:: with SMTP id m22-v6mr23960061ejs.20.1543335366051;
        Tue, 27 Nov 2018 08:16:06 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s5-v6sm649023eji.25.2018.11.27.08.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:16:05 -0800 (PST)
Subject: Re: [PATCH v3 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
From:   Hans de Goede <hdegoede@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
 <20181127153728.47866-6-andriy.shevchenko@linux.intel.com>
 <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Message-ID: <70577604-73cb-f08f-86f8-705029bec56c@redhat.com>
Date:   Tue, 27 Nov 2018 17:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <c6a0201e-d69e-7646-dcae-0b1b6fe42451@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-11-18 17:14, Hans de Goede wrote:
> Hi,
> 
> On 27-11-18 16:37, Andy Shevchenko wrote:
>> The caller would like to know the reason why the i2c_acpi_new_device() fails.
>> For example, if adapter is not available, it might be in the future and we
>> would like to re-probe the clients again. But at the same time we would like to
>> bail out if the error seems unrecoverable, such as invalid argument supplied.
>> To achieve this, return error pointer in some cases.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/i2c/i2c-core-acpi.c                  | 21 ++++++++++++++------
>>   drivers/platform/x86/i2c-multi-instantiate.c |  2 +-
>>   drivers/platform/x86/intel_cht_int33fe.c     |  6 +++---
>>   3 files changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> index 32affd3fa8bd..7e872ceaa14f 100644
>> --- a/drivers/i2c/i2c-core-acpi.c
>> +++ b/drivers/i2c/i2c-core-acpi.c
>> @@ -386,20 +386,22 @@ struct notifier_block i2c_acpi_notifier = {
>>    *
>>    * Also see i2c_new_device, which this function calls to create the i2c-client.
>>    *
>> - * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
>> + * Returns a pointer to the new i2c-client, or error pointer in case of failure.
>> + * Specifically, -ENODEV is returned if the adapter is not found.
>>    */
>>   struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>>                          struct i2c_board_info *info)
>>   {
>>       struct i2c_acpi_lookup lookup;
>>       struct i2c_adapter *adapter;
>> +    struct i2c_client *client;
>>       struct acpi_device *adev;
>>       LIST_HEAD(resource_list);
>>       int ret;
>>       adev = ACPI_COMPANION(dev);
>>       if (!adev)
>> -        return NULL;
>> +        return ERR_PTR(-EINVAL);
>>       memset(&lookup, 0, sizeof(lookup));
>>       lookup.info = info;
>> @@ -408,16 +410,23 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>>       ret = acpi_dev_get_resources(adev, &resource_list,
>>                        i2c_acpi_fill_info, &lookup);
>> +    if (ret < 0)
>> +        return ERR_PTR(ret);
>> +
>>       acpi_dev_free_resource_list(&resource_list);
>> -    if (ret < 0 || !info->addr)
>> -        return NULL;
>> +    if (!info->addr)
>> +        return ERR_PTR(-EADDRNOTAVAIL);
>>       adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
>>       if (!adapter)
>> -        return NULL;
>> +        return ERR_PTR(-ENODEV);
> 
> Why not simply return -EPROBE_DEFER here (and simplify the callers a lot).
> 
> This is the only case where we really want to defer.
> 
> 
>> +
>> +    client = i2c_new_device(adapter, info);
>> +    if (!client)
>> +        return ERR_PTR(-ENODEV);
> 
> If you look at i2c_new_device, it can fail because it is
> out of memory, the i2c slave address is invalid, or
> their already is an i2c slave with the same address,
> iow if this were to return an ERR_PTR itself, this
> would return -ENOMEM, -EINVAL or -EBUSY and never
> -EPROBE_DEFER.
> 
> Note keeping the -ENODEV here is fine, what I'm trying
> to say is that in this case the caller of i2c_acpi_new_device
> really should not return PROBE_DEFER, so directly returning
> EPROBE_DEFER above, rather then let the caller guess is better.
> 
> And e.g. this:
> 
>                  multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>                  if (IS_ERR(multi->clients[i]))
>                          ret = PTR_ERR(multi->clients[i]);
>                  else if (!multi->clients[i])
>                          ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>                  else
>                          ret = 0;
>                  if (ret) {
>                          dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>                          goto error;
>                  }
> 
> Can be simplified to:
> 
>                  multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>                  if (IS_ERR(multi->clients[i])) {
>                          ret = PTR_ERR(multi->clients[i]);
>                          dev_err(dev, "Error creating i2c-client, idx %d\n", i);
>                          goto error;
>                  }

Correction, that should be:

                 multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
                 if (IS_ERR(multi->clients[i])) {
                         ret = PTR_ERR(multi->clients[i]);
                         if (ret != -EPROBE_DEFER)
                                 dev_err(dev, "Error creating i2c-client, idx %d\n", i);
                         goto error;
                 }

We don't want to log an error when deferring.

Regards,

Hans



> 
> This will also allow you to split out the patches cleaning up the callers
> without having a bisect problem (the NULL case will now simply never happen).
> 
> Regards,
> 
> Hans
> 
> 
>> -    return i2c_new_device(adapter, info);
>> +    return client;
>>   }
>>   EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>> index 0e3a36f3ef64..18928e4ede7f 100644
>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>> @@ -72,7 +72,7 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>>               board_info.irq = ret;
>>           }
>>           multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
>> -        if (!multi->clients[i])
>> +        if (PTR_ERR(multi->clients[i]) == -ENODEV)
>>               ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>>           else if (IS_ERR(multi->clients[i]))
>>               ret = PTR_ERR(multi->clients[i]);
> 
> 
>> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
>> index 3ba139d3bd03..b8cab17ec596 100644
>> --- a/drivers/platform/x86/intel_cht_int33fe.c
>> +++ b/drivers/platform/x86/intel_cht_int33fe.c
>> @@ -168,7 +168,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>           board_info.dev_name = "max17047";
>>           board_info.properties = max17047_props;
>>           data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
>> -        if (!data->max17047)
>> +        if (PTR_ERR(data->max17047) == -ENODEV)
>>               ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>>           else if (IS_ERR(data->max17047))
>>               ret = PTR_ERR(data->max17047);
>> @@ -200,7 +200,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>       board_info.irq = fusb302_irq;
>>       data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
>> -    if (!data->fusb302)
>> +    if (PTR_ERR(data->fusb302) == -ENODEV)
>>           ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>>       else if (IS_ERR(data->fusb302))
>>           ret = PTR_ERR(data->fusb302);
>> @@ -214,7 +214,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>>       strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
>>       data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
>> -    if (!data->pi3usb30532)
>> +    if (PTR_ERR(data->pi3usb30532) == -ENODEV)
>>           ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>>       else if (IS_ERR(data->pi3usb30532))
>>           ret = PTR_ERR(data->pi3usb30532);
>>
