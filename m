Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843DB214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F52VVMWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843DB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeIYUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:01:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34615 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbeIYUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:01:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so5850625lfj.1;
        Tue, 25 Sep 2018 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BaGC+THh4UwO3hU4rHmOvtS8IlJ4GvsyLOEINfH/rKM=;
        b=F52VVMWLQdMiF5r5AEJ2yd9O3/Z4l7mzifxkfAOWdS6pTDWbyPIsDkC7ucnI1E/sov
         J779fPFly6V5oC9rAAzYqcKkDex2ag+JTsSJAgzxsBEEK0Ozy/8F92Yrt+VPkc7LIDJv
         xzqcVx/hGupK95z5Ekk3vmf2UU9b6IXCvErzzhUyWGPnWjvG3om6So3IhUuKZp0GC4pG
         l/jUeZgjpmDG2f7DlaNkOhFRUBB4tDo6MBhvI87uxElO06p96IVqrfhYx0zkCLL2bGHM
         ajcmR1prKMg9Z2Cuv/yGZt3TdyqlLzh8yX4DkFMSMj8BrCguiletpJwF7iMzTLlZVgCS
         L+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BaGC+THh4UwO3hU4rHmOvtS8IlJ4GvsyLOEINfH/rKM=;
        b=Sfpx5dbzghbDr9bDKpxRXoqhHUCKB3ajooPJn0JXq9u/tXmCIFTrtgYrXeKzWIH+f0
         Pd2HWmvLtVtZWZjlDjH4GzLFlzVT/Nk+JaFq+9EV6LTxTYeohNw2UZB+s5GXgXf6li6v
         9e+xt5anIz8F7gWAYJMhyaKNF3bPqcfEo90Bqi+Seneg295BqQWosX7iIwyFnqoYO/pi
         C2L8Oc6cag3qVtbyGdX32DjHazk/bj4ELriEbXcjuyrzAh/ihuQlY9OuAjdE7c44c/1S
         7cn4lC0uqtHykUgEZYNVJ4Au0eGK+SJnFUo55nxQS5dHHdXiRCiuq9oLdV12jO3G2GbH
         Xj3w==
X-Gm-Message-State: ABuFfogg+nGGDUknd4VwRuSvzoCbjGlkDgJesBCKmIG0RH6m51noXrmJ
        L9LCo7EozM6k19FT2uZsGOe6OQNh
X-Google-Smtp-Source: ACcGV60hXtu7AV6w6Djrii1ZwFJljKY2oN+t+OIufrKnw4aOgItCNrY+NU6SV9By8/Y1xhyfXwGQXA==
X-Received: by 2002:a19:7391:: with SMTP id h17-v6mr922567lfk.140.1537883613238;
        Tue, 25 Sep 2018 06:53:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm415931ljg.12.2018.09.25.06.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 06:53:32 -0700 (PDT)
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com> <20180924101354.GH21032@ulmo>
 <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com> <20180925100046.GD7097@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f12b82d6-0fc9-443e-f68b-be63265c8354@gmail.com>
Date:   Tue, 25 Sep 2018 16:53:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925100046.GD7097@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 1:00 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:39:43PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 1:13 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
>>>> There is no need to match device with the DT node since it was already
>>>> matched, use of_device_get_match_data() helper to get the match-data.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/memory/tegra/mc.c | 10 ++--------
>>>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>>> index 5454ffe5b2e0..cdc33f93cf7c 100644
>>>> --- a/drivers/memory/tegra/mc.c
>>>> +++ b/drivers/memory/tegra/mc.c
>>>> @@ -11,8 +11,7 @@
>>>>  #include <linux/interrupt.h>
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/module.h>
>>>> -#include <linux/of.h>
>>>> -#include <linux/platform_device.h>
>>>
>>> It's better not to remove these two because the code still uses
>>> functions declared in them. If ever we were going to remove code using
>>> linux/of_device.h and then remove the linux/of_device.h include, we'd
>>> break the build and have to reintroduce the includes.
>>
>> That doesn't sound like a good argument. You're way too picky here ;)
>>
>>> The same would happen if linux/of_device.h were ever to stop including
>>> linux/platform_device.h or linux/of.h. That may sound unlikely, but it
>>> has happened in the past with other includes. It can also happen that
>>> some restructuring takes place in some headers that is not so obvious
>>> and then things can still start falling apart miles away.
>>
>> Restructuring will be somebody else problem. Not sure that we really
>> should care about it, I think it is unnecessary. But since you're
>> insisting..
> 
> It's actually a very common argument and I've seen patches in the past
> that add includes just for the purpose of making sure the right
> definitions get pulled in. This happens quite frequently as a preamble
> to some major rework of some header files that would otherwise cause a
> lot of breakage.
> 
> So I think it's best to be proactive about this and make sure we
> explicitly pull in all the necessary headers in the first place,
> irrespective of whether or not they may already get pulled in indirectly
> by some other headers.

Ok
