Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42299C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05212216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05212216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeHHKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:25:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45631 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeHHKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:25:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so795618edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fzuacOZI1sCh5smMmvFoKEVAATaBZJHJDuDHOBDsSfo=;
        b=LpQu73ic6M2g2lkRDxPdN+Y3//txMfk4RyBVCDeF61xSMYxgWImyxWwCdO01I37SZi
         DZt0zvFe0Erif96AH/0w5pv2r9YTsq/Nh4XPWnUAMOncX87zKNIjH4iooxxgmF3F2zU3
         6M7P5N1gRgh5WfdTTZiuVnzMqCO5xWOVhCpgDrisKcaKJvOTA+LRKsNe5ykLHdYQH7mY
         OLwF8WWsyJJPybmp+z2TisP+L+aFk9RDAff2B9YOMc/3QTAF+QNj8gfE1wD2jUjFZer2
         QyTbv2DN+kLZayMKJMjK15kXS9xDPmFPzSrUXLtNY60hfrH7zvXkYKHroTkWDMYbbq9w
         ORhA==
X-Gm-Message-State: AOUpUlEdGWN7NClcpN1hSl7Y1zlZ5LesAxvCjMFXScVsOvJ5sxmrdJ+i
        AHWYq62UHmIf21Ppc+mjVkDGsQ==
X-Google-Smtp-Source: AA+uWPx+BT5Iyxu8rzlWtEB1SHUc/U3v+DbmSyHiR+Uwz0DfnM85PdUcLwPCmYAfY92sfO+0dxbdlA==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr993730edf.17.1533715644313;
        Wed, 08 Aug 2018 01:07:24 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1374727edo.44.2018.08.08.01.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 01:07:23 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] ACPI / scan: Create platform device for fwnodes
 with multiple i2c devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-3-hdegoede@redhat.com>
 <00e16cb09c171b536449b61124473291f2b30d0b.camel@linux.intel.com>
 <13770931-2322-96a3-1667-83c96b25bcfb@redhat.com>
 <43d45add4c8059d44a0b228e4beffb03c094a512.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e71b6ab-5a2d-a1a1-bb4b-46ef85e8a9ad@redhat.com>
Date:   Wed, 8 Aug 2018 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <43d45add4c8059d44a0b228e4beffb03c094a512.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-08-18 13:49, Andy Shevchenko wrote:
> On Tue, 2018-08-07 at 13:29 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 07-08-18 13:19, Andy Shevchenko wrote:
>>> On Tue, 2018-08-07 at 10:05 +0200, Hans de Goede wrote:
> 
>>>> +	/*
>>>> +	 * These devices have multiple I2cSerialBus resources and an
>>>> i2c-client
>>>> +	 * must be instantiated for each, each with its own
>>>> i2c_device_id.
>>>> +	 * Normally we only instantiate an i2c-client for the first
>>>> resource,
>>>> +	 * using the ACPI HID as id. These special cases are handled by
>>>> the
>>>> +	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which
>>>> knows
>>>> +	 * which i2c_device_id to use for each resource.
>>>> +	 */
>>>> +	static const struct acpi_device_id i2c_multi_instantiate_ids[] =
>>>> {
>>>> +		{"BSG1160", 0},
>>>> +		{"", 0},
>>>> +	};
>>>
>>> Style nits:
>>> - can we move it outside of function?
>>
>> Sure, but there are 2 existing users of an array of acpi_device_id-s
>> combined with an acpi_match_device_ids() call and both have the array
>> inside the function, so for consistency it seems better to keep it
>> where it is.
> 
> Hmm... OK.
> 
>>> - is this existing style in the file and / or files in this folder
>>> for
>>> IDs? (I mean unnecessary 0:s and empty string?
>>
>> It seems that all variants one can come up with are already used
>> inside
>> this single file.
> 
> Ah, that's sad.
> 
>> I agree that less is more, so I will change this to:
>>
>>           static const struct acpi_device_id
>> i2c_multi_instantiate_ids[] = {
> 
>>                   {"BSG1160", },
>>                   {}
>>           };
> 
> In case if it mimics already existing style, looks quite good to me
> (otherwise perhaps comma inside {} can also be removed).
> 
>>
>> For v4.
> 
> Does it make sense to test v3 on your opinion? Or better to wait for v4?

Sorry for being a bit slow to answer, I'm about to send out v4, so probably
best to wait for that now. Note the 2 will be functionally identical,
I mainly fixed / clarified commit messages and the MAINTAINERS entry +
the small style fixed discussed above.

Regards,

Hans
