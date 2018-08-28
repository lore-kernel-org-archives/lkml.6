Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8BCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807FF20671
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAqNWaTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807FF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeH1QCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:02:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40397 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeH1QCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so1350057wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=38BGpdB/NVurJHaDcMO6WA/jWev3r68w5fImgfwQOgE=;
        b=YAqNWaTdppEqEjw2kV+l/rsqw8lXNW053JdIw4d6GzvcSsR18tC6ZChjncnpccDD+G
         diywZID6ZUgqKVqgnct93ueb//CFjiq+L9De2ScGC0/97hGP0BhtE2W7LdD9leCtk2xJ
         xymemj9je+jAr1vS2l4VdywvxpeFBK3zddSuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=38BGpdB/NVurJHaDcMO6WA/jWev3r68w5fImgfwQOgE=;
        b=JDVLXm+KvMWnjjc0nNu8y96oaEbtyMBJviRyZa/MY8b+FljMzI9FdFl+9XnDTTdFd2
         yWpOjftS9gXgr/5LykoZuSlROzs16jla17VOQKY5NeD5puLIDOtJPxnyqZ5ht9sY7+Gq
         FxqCD33xYzOVTpDbJIzzstZC1LxzzfASzwD4XQtzmLorpbMNyHMSxYQUBK8HE81UyUAe
         bzLi2/LdEqgYqmfMh9rBeZ18TTJfvbZ7fG3tJQrKpVw25e5dRrQz5tlDEADFRt9YzPhu
         QrK/WFC6pjlLNG8Id4+N3gwRvUdRqH3uoOvFA/NEuNS6306NtmpQFz9pkbooEvMa8q9o
         zdvw==
X-Gm-Message-State: APzg51B5hZJgXljV/GryPfXE9RHhw0mi371Z39fqgoWCdZ3R29chBbJG
        7iFgb8JHqH6hMQdUQzqRArAEHQ==
X-Google-Smtp-Source: ANB0VdYSa8MfRTG7upwvBz+bQjgePZmqnKXTEa/WMoMU5hbCjZo1/lvuEs1myabKtYce+3lE2XzQSw==
X-Received: by 2002:adf:e211:: with SMTP id j17-v6mr1001206wri.205.1535458277328;
        Tue, 28 Aug 2018 05:11:17 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id h73-v6sm3660029wma.11.2018.08.28.05.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:16 -0700 (PDT)
Subject: Re: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
To:     "J, KEERTHY" <j-keerthy@ti.com>, tglx@linutronix.de
Cc:     lokeshvutla@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, baolin.wang@linaro.org,
        d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com,
        t-kristo@ti.com
References: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
 <12b80b5f-3dd8-793e-75b2-94d2a0248d3e@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7234a135-96e4-89d8-1b3f-c2bb4e5534f5@linaro.org>
Date:   Tue, 28 Aug 2018 14:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12b80b5f-3dd8-793e-75b2-94d2a0248d3e@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2018 13:44, J, KEERTHY wrote:
> 
> 
> On 8/8/2018 6:44 PM, Keerthy wrote:
>> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
>> add the flag for all the other SoCs.
> 
> A gentle ping on this one.

Yeah, saw it. Returning from vacation, still unstacking emails ... :)

>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> ---
>>
>> Changes in v2:
>>
>>    * Changed am43 compatible to more generic ti,am43 to cover epos
>> boards.
>>    * Added Tony's Ack.
>>
>>   drivers/clocksource/timer-ti-32k.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-ti-32k.c
>> b/drivers/clocksource/timer-ti-32k.c
>> index 29e2e1a..dd09171 100644
>> --- a/drivers/clocksource/timer-ti-32k.c
>> +++ b/drivers/clocksource/timer-ti-32k.c
>> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct
>> device_node *np)
>>           return -ENXIO;
>>       }
>>   +    if (!of_machine_is_compatible("ti,am43"))
>> +        ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>> +
>>       ti_32k_timer.counter = ti_32k_timer.base;
>>         /*
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

