Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269722088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SK36VBrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269722088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeGZGCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:02:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33160 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbeGZGCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:02:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so728059oii.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 21:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ruvPz/UrriC/xjCGf3GPlAqlFGnNxF0Z8W1qR1KeOE=;
        b=SK36VBrUdHjnxIZPlPkyI3I7p91lhJMMlNTEZHj8bSXp5R5VQwjPphItm0dlzkmAZn
         BrXc4q6R/5503e0hDlP/7H9KMkPFycaqbjdx++gkNOj2k4QmyBizlb71jPq+HhcK2bv2
         pbPNAGjs9bobUBfYWRywDxUQctAtj8rFM1pgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ruvPz/UrriC/xjCGf3GPlAqlFGnNxF0Z8W1qR1KeOE=;
        b=PhRrR6cBCy3t6bIEKVtVs2LJrb2kjZgFM9fETX40jA9Jpw4KgnKxc9pe4YThUcw40A
         oM7/wJ6Lo05r5+oq+wek0Es/K9ZeZVULwI5Lgc7Zkzaj4Y3WAjPJPo6uHsIg0NM1Zohn
         whx7dC8BtR2YB20uJSZL0d5/WmPd76Fi07uofogYRpdNNh8hqlvZvHPxSLaf7TfPuwo9
         5qnC+1sTZdHqEynrZOie5MJNyS0CbfC22yzDHMWitBcnH3Axw+AkDxN+5NIN9TM4+aGm
         c4Ok/pKJnHP0zKvOkml272B156EVWa+vtbaDlI0HiQNKPLLG88aY7AMglaszJcM8iBf1
         kZKg==
X-Gm-Message-State: AOUpUlHJLr7yABcfxCn04WiB0OvIoTd2mBUJAyMjbbzJ8auFPwXGDah+
        PTG6B2hJ3izXcA1AZNba5kRdhIPkVP3+H9v1foOL2A==
X-Google-Smtp-Source: AAOMgpcWvcZZPwhPp59MZ1RnFnUjFcK8nRAcMgRyTuWtGxBpmtpSEW5Efzxq4J9pIx6TWahp6acGQm+Ao3ENYieTMTM=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr391003oig.282.1532580459026;
 Wed, 25 Jul 2018 21:47:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7592:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 21:47:37
 -0700 (PDT)
In-Reply-To: <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net>
References: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com> <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 26 Jul 2018 10:17:37 +0530
Message-ID: <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: sp805: Add clock-frequency property
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

It was my mistake sorry for that. I thought to add as Rivewed-by your name..
Many changes are made based on your review comments and suggestions.
So, Can I add your name in Reviewed list?
I will modify and send next patchset.

thank you.

Regards,
Srinath.

On Thu, Jul 26, 2018 at 10:12 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/23/2018 01:37 AM, Srinath Mannam wrote:
>>
>> Use clock-frequency property given in _DSD object
>> of ACPI device to calculate Watchdog rate as binding
>> clock devices are not available as device tree.
>>
>> Note: There is no formal review process for _DSD
>> properties
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
>
> I just noticed this. This is completely inappropriate. It is
> the equivalent of forging a signature on a check.
>
> _Never_ add a Signed-off-by: statement for anyone but yourself.
>
> Guenter
>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 9849db0..a896b1c 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -11,6 +11,7 @@
>>    * warranty of any kind, whether express or implied.
>>    */
>>   +#include <linux/acpi.h>
>>   #include <linux/device.h>
>>   #include <linux/resource.h>
>>   #include <linux/amba/bus.h>
>> @@ -22,6 +23,7 @@
>>   #include <linux/math64.h>
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>> +#include <linux/of.h>
>>   #include <linux/pm.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>         spinlock_t                      lock;
>>         void __iomem                    *base;
>>         struct clk                      *clk;
>> +       u64                             rate;
>>         struct amba_device              *adev;
>>         unsigned int                    load_val;
>>   };
>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>> unsigned int timeout)
>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>         u64 load, rate;
>>   -     rate = clk_get_rate(wdt->clk);
>> +       rate = wdt->rate;
>>         /*
>>          * sp805 runs counter with given value twice, after the end of
>> first
>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>> unsigned int timeout)
>>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>   {
>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> -       u64 load, rate;
>> -
>> -       rate = clk_get_rate(wdt->clk);
>> +       u64 load;
>>         spin_lock(&wdt->lock);
>>         load = readl_relaxed(wdt->base + WDTVALUE);
>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>> watchdog_device *wdd)
>>                 load += wdt->load_val + 1;
>>         spin_unlock(&wdt->lock);
>>   -     return div_u64(load, rate);
>> +       return div_u64(load, wdt->rate);
>>   }
>>     static int
>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const
>> struct amba_id *id)
>>         if (IS_ERR(wdt->base))
>>                 return PTR_ERR(wdt->base);
>>   -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>> -       if (IS_ERR(wdt->clk)) {
>> -               dev_warn(&adev->dev, "Clock not found\n");
>> -               ret = PTR_ERR(wdt->clk);
>> -               goto err;
>> +       if (adev->dev.of_node) {
>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>> +               if (IS_ERR(wdt->clk)) {
>> +                       dev_err(&adev->dev, "Clock not found\n");
>> +                       return PTR_ERR(wdt->clk);
>> +               }
>> +               wdt->rate = clk_get_rate(wdt->clk);
>> +       } else if (has_acpi_companion(&adev->dev)) {
>> +               /*
>> +                * When Driver probe with ACPI device, clock devices
>> +                * are not available, so watchdog rate get from
>> +                * clock-frequency property given in _DSD object.
>> +                */
>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>> +                                        &wdt->rate);
>> +               if (!wdt->rate) {
>> +                       dev_err(&adev->dev, "no clock-frequency
>> property\n");
>> +                       return -ENODEV;
>> +               }
>>         }
>>         wdt->adev = adev;
>>
>
