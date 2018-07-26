Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A2FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEB020673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klg6vhIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEB020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeGZGYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:24:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeGZGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:24:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id b17-v6so182860pfi.0;
        Wed, 25 Jul 2018 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+jFslDIlB1tbHPpDDYjSykHVUPEmC4O+2ITeytPUf7w=;
        b=klg6vhIpiWuUJKRWXQBHI4xFAZU2jraLaH0uQyfQv8Njpx8b+UYFvyjPjSut8XTD4f
         +z5J9+/7c5X9qSWZu8r0K/CBJxKkUHJMX4tGEv6YLnnerR6hxoCnhPOUEndvL17ciJz5
         MN+AdWPksuDZJLiKgu6/4/BAdUYhW56UVSPol84oO8tqH+yTD6rtQoalgZfWiZSMHIVe
         SDMJ+wqnHuYwMu1Nt2oNJhVmS1EdKxaIEoyun+EAJFPjPY5+kxHOfMBheN3uM+HhdM1I
         Nh7V9iAHnrRlnNxTOgwmr47HSDmuxm5xy0kPrWihk/kjDCWYqm/6nYW/EFPKgsx4Qh/D
         5tFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jFslDIlB1tbHPpDDYjSykHVUPEmC4O+2ITeytPUf7w=;
        b=Mh47xxA/ySqTZOBzVCCmumNcwTTgEkEFZ+Ke32Mw1LGy6+hSRG9/s7jVbSwKMS0ZCr
         yHw+TEknvZ7zP7gJ5/OIX3lympbNjhsmnSItnllLSwemVNiKaCUKfMovBTMC5PqQPixn
         bvc+xqHyCslCsXTdGU9m1a7THpDKHzfiZ5qe28UYSCv11TfX4mHD+Iph6qQixCiSZUTO
         iUGpUk7XbOB30C130vt4c8ydGEFbktc3rYCL2CnkbqtkMRYYMUOHWt6i1oILp+NCmuZS
         NVqFdo4JQefgVqsFaN3Hbeh+GvynEOZtFeZFcF7x/gsjJ2dXdzOpAvRd294SyfBorxqr
         yagw==
X-Gm-Message-State: AOUpUlG+EaNCmvGqbQMgPewH2BWmidq0v6iHEK9TVTQa8p7F4FSN3S4x
        2XCRbwN3UMCGQ3eZt2gvovM=
X-Google-Smtp-Source: AAOMgpe9ACORhsSHGvt4se6i3z+we27yxWv8LOjwuTQ4us4DLDsKuasrSrDaTiMDJ2VghbDufChvAw==
X-Received: by 2002:a62:1c16:: with SMTP id c22-v6mr580327pfc.148.1532581747141;
        Wed, 25 Jul 2018 22:09:07 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h10-v6sm748867pfj.78.2018.07.25.22.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 22:09:06 -0700 (PDT)
Subject: Re: [PATCH] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
 <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net>
 <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca37de93-4079-4270-aa91-8411a07b168f@roeck-us.net>
Date:   Wed, 25 Jul 2018 22:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 09:47 PM, Srinath Mannam wrote:
> Hi Guenter,
> 
> It was my mistake sorry for that. I thought to add as Rivewed-by your name..
> Many changes are made based on your review comments and suggestions.
> So, Can I add your name in Reviewed list?

You did that already below, and I am ok with that.

Guenter

> I will modify and send next patchset.
> 
> thank you.
> 
> Regards,
> Srinath.
> 
> On Thu, Jul 26, 2018 at 10:12 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/23/2018 01:37 AM, Srinath Mannam wrote:
>>>
>>> Use clock-frequency property given in _DSD object
>>> of ACPI device to calculate Watchdog rate as binding
>>> clock devices are not available as device tree.
>>>
>>> Note: There is no formal review process for _DSD
>>> properties
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>>
>> I just noticed this. This is completely inappropriate. It is
>> the equivalent of forging a signature on a check.
>>
>> _Never_ add a Signed-off-by: statement for anyone but yourself.
>>
>> Guenter
>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>    drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>>    1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..a896b1c 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>     * warranty of any kind, whether express or implied.
>>>     */
>>>    +#include <linux/acpi.h>
>>>    #include <linux/device.h>
>>>    #include <linux/resource.h>
>>>    #include <linux/amba/bus.h>
>>> @@ -22,6 +23,7 @@
>>>    #include <linux/math64.h>
>>>    #include <linux/module.h>
>>>    #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>    #include <linux/pm.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/spinlock.h>
>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>          spinlock_t                      lock;
>>>          void __iomem                    *base;
>>>          struct clk                      *clk;
>>> +       u64                             rate;
>>>          struct amba_device              *adev;
>>>          unsigned int                    load_val;
>>>    };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>          u64 load, rate;
>>>    -     rate = clk_get_rate(wdt->clk);
>>> +       rate = wdt->rate;
>>>          /*
>>>           * sp805 runs counter with given value twice, after the end of
>>> first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>> unsigned int timeout)
>>>    static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>    {
>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -       u64 load, rate;
>>> -
>>> -       rate = clk_get_rate(wdt->clk);
>>> +       u64 load;
>>>          spin_lock(&wdt->lock);
>>>          load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>>> watchdog_device *wdd)
>>>                  load += wdt->load_val + 1;
>>>          spin_unlock(&wdt->lock);
>>>    -     return div_u64(load, rate);
>>> +       return div_u64(load, wdt->rate);
>>>    }
>>>      static int
>>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const
>>> struct amba_id *id)
>>>          if (IS_ERR(wdt->base))
>>>                  return PTR_ERR(wdt->base);
>>>    -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -       if (IS_ERR(wdt->clk)) {
>>> -               dev_warn(&adev->dev, "Clock not found\n");
>>> -               ret = PTR_ERR(wdt->clk);
>>> -               goto err;
>>> +       if (adev->dev.of_node) {
>>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +               if (IS_ERR(wdt->clk)) {
>>> +                       dev_err(&adev->dev, "Clock not found\n");
>>> +                       return PTR_ERR(wdt->clk);
>>> +               }
>>> +               wdt->rate = clk_get_rate(wdt->clk);
>>> +       } else if (has_acpi_companion(&adev->dev)) {
>>> +               /*
>>> +                * When Driver probe with ACPI device, clock devices
>>> +                * are not available, so watchdog rate get from
>>> +                * clock-frequency property given in _DSD object.
>>> +                */
>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                                        &wdt->rate);
>>> +               if (!wdt->rate) {
>>> +                       dev_err(&adev->dev, "no clock-frequency
>>> property\n");
>>> +                       return -ENODEV;
>>> +               }
>>>          }
>>>          wdt->adev = adev;
>>>
>>
> 

