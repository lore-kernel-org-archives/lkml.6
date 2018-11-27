Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D57AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE0C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeK0UNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:13:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33851 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbeK0UNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:13:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so18365268ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xJ0j4DrdLUxaajuHS/Hwh9Qvy7ZwOxcZKvvEwXVplPI=;
        b=fU+81oxzqyHPw80zPr2WHyTEDYxCTuSUpas5tErDoL2pK0AhPPia+aHXHm2Cm4s0Ei
         ezX+oQM3FamMy5AqdzKLKwxruw/w5bI6fA63U2YZLLbr61nV8kj4+bt7Y3Er7yvPs8q4
         dbS/jb4ZxLc9n36HvPD27CudgcE4+awPLmxOUQC/2b7Iuas2ntt1Wk/+Wth8tvgPH4RY
         yK2FNId03BtLzXK4w0P4noFbqBj/IXhi/9K5CXxN05hk5wNNWH5NGUMZ9QuOOU8OrLMw
         epfsGPXmZhtTduZ62fJv25QJYPXA4GNldCuVoALi0JuF13IYGGQj5U8bEIWaBoY4MGBE
         bYCg==
X-Gm-Message-State: AGRZ1gKvLCpa/9/WcfFHH2xyQEyvt2JKPc4wffgIkUZM5hoyM14ILef9
        F4oDMVEVrQNqD8HGXcbtIO20ruEK0D8=
X-Google-Smtp-Source: AJdET5fpV1NxxIrlEcxMtGwrNF6lVODXOIB0wIC7IMki4mwRBlLW22RtWkRKUdhjyi/Bwc/B4EK0qQ==
X-Received: by 2002:a17:906:c7c9:: with SMTP id dc9-v6mr22407085ejb.232.1543310186748;
        Tue, 27 Nov 2018 01:16:26 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b2sm878148ede.30.2018.11.27.01.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:16:26 -0800 (PST)
Subject: Re: [PATCH v2 05/13] i2c: acpi: Return error pointers from
 i2c_acpi_new_device()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
 <20181126150858.16901-6-andriy.shevchenko@linux.intel.com>
 <20181127090432.GK2296@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <98674437-9374-32d4-4b25-dedd0cad5bea@redhat.com>
Date:   Tue, 27 Nov 2018 10:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127090432.GK2296@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-11-18 10:04, Mika Westerberg wrote:
> On Mon, Nov 26, 2018 at 05:08:50PM +0200, Andy Shevchenko wrote:
>> The caller would like to know the reason why the i2c_acpi_new_device() fails.
>> For example, if adapter is not available, it might be in the future and we
>> would like to re-probe the clients again. But at the same time we would like to
>> bail out if the error seems unrecoverable, such as out of memory condition.
>> To achieve this, return error pointer in some cases.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/i2c/i2c-core-acpi.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> index 32affd3fa8bd..af4b5bd5d973 100644
>> --- a/drivers/i2c/i2c-core-acpi.c
>> +++ b/drivers/i2c/i2c-core-acpi.c
>> @@ -387,6 +387,7 @@ struct notifier_block i2c_acpi_notifier = {
>>    * Also see i2c_new_device, which this function calls to create the i2c-client.
>>    *
>>    * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
>> + * In some cases might return an error pointer.
> 
> I would rather make it return error pointer always. Then the caller can
> just check for IS_ERR() and not need to deal with the possible NULL. It
> is also more consistent that way than saying "some cases might return an
> error pointer" (but some cases you get NULL or even pointer to the
> created object) ;-)

Good one, that will allow for a nice cleanup of the callers, we can make
i2c_acpi_new_device return -EPROBE_DEFER when the i2c_acpi_find_adapter_by_handle()
call fails, which is exactly the case when we want to defer.

One problem is that i2c_new_device() currently simply returns NULL on all
errors. Andy, you could take a look how much work it is to make that return
an ERR_PTR too, or just check its return value and return ERR_PTR(-ENXIO) if
it fails for now...

Regards,

Hans





