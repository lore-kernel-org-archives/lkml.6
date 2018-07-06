Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5752C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937572409B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fDUbhWhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937572409B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeGFISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:18:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42479 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:18:04 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so21928686oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ykZI2s+05xrvUd33CDKkHEEJqVF+SzUuk+QTn/Hhomo=;
        b=fDUbhWhfGdUughY22QorGhsRHX6zuxceABRYzjDAt2DpPho7KwaZYjDhOEB87VX6BN
         aqZdAzzMsdV6n3coT1EsFBebHB8Nwid+b8ben8cpWMCgXYbopH757qgeTj+Qx8yq+Zdj
         ALFJbyO+aVteiwgA1Tclh1+aXR6YoF9SBWuR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ykZI2s+05xrvUd33CDKkHEEJqVF+SzUuk+QTn/Hhomo=;
        b=JnjVP2ECwSfdOLSr9TmM9LZ+FfXt4U2vHJXEAxPy5tM7i/HBoccKhc4iWbF13eDkvc
         7ohhc6ZIcSGzTvy+potUA3RWU2//lnZehCYSuxpTmKcixbQhGpVbZo5/A5zSfeGeNpDn
         zFtwCpoCMlLn2lDhKwlfs6C0TP9xSHRtyiH3TmFg3jo/p+JLiHMa/L+1WRls0Fz6Q9zI
         9NnltL7Xs41ELBwyA1xr74KeUEA+kG67iZkV7rnTfUMF/VChCEkp18RrD1xpcECVI0T0
         u/iz/bhKzMlPr73DW1oGl78N14u5RshICnEEBwEhhdVfKxpEwX5caZ4Y4c2IF/i8vWlg
         qWOQ==
X-Gm-Message-State: APt69E1zEItMEQVnvWc56KO9DL+SStv4ekDoCHZKeRsm48hK3ZM7N9W5
        uvVeuqzK1J+b+kCbYM8bbpDLzu9RpsKPBFlGZ/c2OA==
X-Google-Smtp-Source: AAOMgpf4nObY9Tq6sv69ZWtO5KlOSreCABUZYJNHfBQFq4CxnzEBanXpcYN4sw1FTdL57bWnEYfpTfA2cKO2FImiEpU=
X-Received: by 2002:aca:d956:: with SMTP id q83-v6mr9693616oig.349.1530865083196;
 Fri, 06 Jul 2018 01:18:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:51d2:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:18:02 -0700 (PDT)
In-Reply-To: <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net>
References: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com> <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 6 Jul 2018 13:48:02 +0530
Message-ID: <CABe79T7wF461QA11BNkfBdtLtX5RpTHX3-WC7z0KtEPYKfzdOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] watchdog: sp805: Add clock-frequency property
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you very much for your feedback. Please find my comments.

On Thu, Jul 5, 2018 at 8:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/04/2018 08:22 PM, Srinath Mannam wrote:
>>
>> When using ACPI node, binding clock devices are
>> not available as device tree, So clock-frequency
>> property given in _DSD object of ACPI device is
>> used to calculate Watchdog rate.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>>   drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 9849db0..d830dbc 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/math64.h>
>>   #include <linux/module.h>
>>   #include <linux/moduleparam.h>
>> +#include <linux/of.h>
>>   #include <linux/pm.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>> @@ -65,6 +66,7 @@ struct sp805_wdt {
>>         spinlock_t                      lock;
>>         void __iomem                    *base;
>>         struct clk                      *clk;
>> +       u64                             rate;
>>         struct amba_device              *adev;
>>         unsigned int                    load_val;
>>   };
>> @@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd,
>> unsigned int timeout)
>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>         u64 load, rate;
>>   -     rate = clk_get_rate(wdt->clk);
>> +       if (wdt->rate)
>> +               rate = wdt->rate;
>> +       else
>> +               rate = clk_get_rate(wdt->clk);
>
>
> No. Get the rate once during probe and store it in wdt->rate.
clk_get_rate function was called multiple places in the driver.
so that we thought, there may be cases where clock rate can change at run-time.
That is the reason, I keep clk_get_rate function.
>
>>         /*
>>          * sp805 runs counter with given value twice, after the end of
>> first
>> @@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct
>> watchdog_device *wdd)
>>         struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>         u64 load, rate;
>>   -     rate = clk_get_rate(wdt->clk);
>> +       if (wdt->rate)
>> +               rate = wdt->rate;
>> +       else
>> +               rate = clk_get_rate(wdt->clk);
>
>
> Same here.
>
>>         spin_lock(&wdt->lock);
>>         load = readl_relaxed(wdt->base + WDTVALUE);
>> @@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const
>> struct amba_id *id)
>>         wdt->clk = devm_clk_get(&adev->dev, NULL);
>>         if (IS_ERR(wdt->clk)) {
>> -               dev_warn(&adev->dev, "Clock not found\n");
>> -               ret = PTR_ERR(wdt->clk);
>> -               goto err;
>> +               dev_warn(&adev->dev, "Clock device not found\n");
>
>
> "Clock _device_" ? Why this change ? And why retain that warning
> unconditionally ?
I mean, peripheral may have clock input but clock device node is not
available to this driver.
So I keep the warning.
I thought to handle this better, divide this part of code into two
parts based on device tree and ACPI.
But this driver implementation is independent of device tree and ACPI calls.
To get device-tree properties watch-dog framework APIs are called ex: timeout.
Can I add ACPI and device tree node availability check to get clock
device and clock-frequency properties. Please advice.
>
>> +               wdt->clk = NULL;
>> +               /*
>> +                * When Driver probe with ACPI device, clock devices
>> +                * are not available, so watchdog rate get from
>> +                * clock-frequency property given in _DSD object.
>> +                */
>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>> +                                        &wdt->rate);
>> +               if (!wdt->rate) {
>> +                       ret = -ENODEV;
>
>
> This unconditionally overrides the original error.
I accept, I will change.
>
>> +                       goto err;
>> +               }
>>         }
>>   +
>
>
> No whitespace changes, please.
I will remove.
>
> Does that mean that ACPI doesn't support the clock subsystem and that each
> driver
> supporting ACPI must do this ? That would be messy. Also, the above does not
> check
> if the device was probed through ACPI. It just tries to find an undocumented
> "clock-frequency" property which is quite different and would apply to
> (probably mis-configured) devicetree files as well.
>
> Either case, I would rather have this addressed through the clock subsystem.
> Otherwise, someone with subject knowledge will have to confirm that this is
> the
> appropriate solution. If so, the new property will have to be documented as
> an
> alternative to clock specifiers and accepted by devicetree maintainers.
>
I checked with ACPI maintainers, ACPI does not support common-clock
framework and also no plan.
AMBA framework also request for "apb_pclk" clock node to enable pclk.
But ACPI does not do the same.
So in device-tree use case, both apb_pclk and wdt clock nodes are
required properties, so passing
clock-frequency alone can not be alternative.
Because ACPI does not support clk node method, I came up with
alternate fixed-clock property clock-frequency.
clock-frequency is only specific to ACPI case, so we can't add in
binding document.
I will add device tree and ACPI specific check to read clock nodes and
clock-frequency properties separately.

If you are fine with this I will send the next patch with modifications.

> Guenter
>
>>         wdt->adev = adev;
>>         wdt->wdd.info = &wdt_info;
>>         wdt->wdd.ops = &wdt_ops;
>>
>
Thank you,

Regards,
Srinath.
