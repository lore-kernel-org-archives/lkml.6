Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BF208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NlaYi5Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9BF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeGIFjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:39:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36584 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeGIFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:39:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so33653401oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pCTZQmm+Y+aRQFrudKnzw0zf5wSFVRLgLpsHcyupNDo=;
        b=NlaYi5PnyAq1JfeVBKPY8cFAaAIIm3Hi/AXzasetjRASonpT2bj1C3Ymxm9c7/SVGm
         YLHSVoCeNOMX13VtNUiS8yYLoWTQzF6gHlm+9gkIL+8e20UF66lJfXE+vOZLiy4GPlK5
         WEWUx1P9USstZXDZfXfQ7wptRmA7HJFvF+lCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pCTZQmm+Y+aRQFrudKnzw0zf5wSFVRLgLpsHcyupNDo=;
        b=f+p3w9L0royZx1HvhzIs4J+ZSP7m6CTyYKUJ5s4Qt1+B1KeXqGDAC5h49xOfstKnbu
         9K3g8SEKifrrxtyYWDe+vQH0M3UtQQgstYUbHOA/YI/9HstN+ZR/hHDXtp1jQ1vNsAkO
         PBSZZtzqOFqFa1wXdBWaPGKa3a3jg87m8YRtQM5mh1FXyQbG3KbkTTBEaH2VxqTRawjB
         huuLAsfaQV4Bgefu88ADwWHaSQ3kVHeE/QeefMjxjzGTnq1duQopow1USaThpevmsuHP
         V01fOwc67AsiJpqF2C19HOFjpxmCxK8tG7FmO4v5Apuq/x1SEo5gctnvQ/JZwP/0T9Ej
         fIhA==
X-Gm-Message-State: AOUpUlEZS2qEd/E/rAex5YOatwZwyRPxir7FDw8YC8oNQMS6ikhFCcb9
        9Ht2U0/D9HGp8U4poFPcRT3tZAV7A6Fp36Fc0H/IxQ==
X-Google-Smtp-Source: AAOMgpehxfK1vOHkasIPWa+7XC0dBE9YO6Yxuc3GAR5zxnI0nZY4B3FHRO1qUnReduaHq2i7rN+9XR/waNj/mgHEakk=
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr2249580oia.280.1531114761944;
 Sun, 08 Jul 2018 22:39:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 22:39:21 -0700 (PDT)
In-Reply-To: <7cebc954-7118-ec5f-2f1c-d2e2291faed5@roeck-us.net>
References: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
 <f29c486a-2ac8-55e7-86ed-90e3cf71bcea@roeck-us.net> <CABe79T7wF461QA11BNkfBdtLtX5RpTHX3-WC7z0KtEPYKfzdOQ@mail.gmail.com>
 <7cebc954-7118-ec5f-2f1c-d2e2291faed5@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 9 Jul 2018 11:09:21 +0530
Message-ID: <CABe79T5Zb9PGJ0L_9e1kzzWTkxf-PkBcxANaOEsTfjdS1W6a3Q@mail.gmail.com>
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

Thank you for the clarification.. Please find my comments.

On Sun, Jul 8, 2018 at 11:36 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/06/2018 01:18 AM, Srinath Mannam wrote:
>>
>> Hi Guenter,
>>
>> Thank you very much for your feedback. Please find my comments.
>>
>> On Thu, Jul 5, 2018 at 8:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 07/04/2018 08:22 PM, Srinath Mannam wrote:
>>>>
>>>>
>>>> When using ACPI node, binding clock devices are
>>>> not available as device tree, So clock-frequency
>>>> property given in _DSD object of ACPI device is
>>>> used to calculate Watchdog rate.
>>>>
>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> ---
>>>>    drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
>>>>    1 file changed, 24 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>>> index 9849db0..d830dbc 100644
>>>> --- a/drivers/watchdog/sp805_wdt.c
>>>> +++ b/drivers/watchdog/sp805_wdt.c
>>>> @@ -22,6 +22,7 @@
>>>>    #include <linux/math64.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/moduleparam.h>
>>>> +#include <linux/of.h>
>>>>    #include <linux/pm.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/spinlock.h>
>>>> @@ -65,6 +66,7 @@ struct sp805_wdt {
>>>>          spinlock_t                      lock;
>>>>          void __iomem                    *base;
>>>>          struct clk                      *clk;
>>>> +       u64                             rate;
>>>>          struct amba_device              *adev;
>>>>          unsigned int                    load_val;
>>>>    };
>>>> @@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd,
>>>> unsigned int timeout)
>>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>>          u64 load, rate;
>>>>    -     rate = clk_get_rate(wdt->clk);
>>>> +       if (wdt->rate)
>>>> +               rate = wdt->rate;
>>>> +       else
>>>> +               rate = clk_get_rate(wdt->clk);
>>>
>>>
>>>
>>> No. Get the rate once during probe and store it in wdt->rate.
>>
>> clk_get_rate function was called multiple places in the driver.
>> so that we thought, there may be cases where clock rate can change at
>> run-time.
>> That is the reason, I keep clk_get_rate function.
>
>
> This is not an argument. A changing clock rate without notifying the driver
> would be fatal for a watchdog driver, since it would affect the timeout and
> - if the clock rate is increased - result in arbitrary reboots. If that can
> happen with the clock used by this watchdog, some notification would have to
> be implemented to let the driver know.
>
As you said, I will keep wdt->rate and remove the clk_get_rate call. Thank you.
>>>
>>>>          /*
>>>>           * sp805 runs counter with given value twice, after the end of
>>>> first
>>>> @@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct
>>>> watchdog_device *wdd)
>>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>>          u64 load, rate;
>>>>    -     rate = clk_get_rate(wdt->clk);
>>>> +       if (wdt->rate)
>>>> +               rate = wdt->rate;
>>>> +       else
>>>> +               rate = clk_get_rate(wdt->clk);
>>>
>>>
>>>
>>> Same here.
>>>
>>>>          spin_lock(&wdt->lock);
>>>>          load = readl_relaxed(wdt->base + WDTVALUE);
>>>> @@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const
>>>> struct amba_id *id)
>>>>          wdt->clk = devm_clk_get(&adev->dev, NULL);
>>>>          if (IS_ERR(wdt->clk)) {
>>>> -               dev_warn(&adev->dev, "Clock not found\n");
>>>> -               ret = PTR_ERR(wdt->clk);
>>>> -               goto err;
>>>> +               dev_warn(&adev->dev, "Clock device not found\n");
>>>
>>>
>>>
>>> "Clock _device_" ? Why this change ? And why retain that warning
>>> unconditionally ?
>>
>> I mean, peripheral may have clock input but clock device node is not
>> available to this driver.
>> So I keep the warning.
>
>
> There is now a warning even though everything is fine, if the clock rate
> is provided with the "clock-frequency" property instead of the documented
> properties. That is unacceptable. I don't want to get flooded with messages
> from people asking what this message is about.
>
>> I thought to handle this better, divide this part of code into two
>> parts based on device tree and ACPI.
>> But this driver implementation is independent of device tree and ACPI
>> calls.
>> To get device-tree properties watch-dog framework APIs are called ex:
>> timeout.
>> Can I add ACPI and device tree node availability check to get clock
>> device and clock-frequency properties. Please advice.
>
>
> Sorry, I fail to parse what you are trying to say.
>
This wdt driver is AMBA framework based driver.
AMBA framework itself expects apb_pclk clock device node from device tree
to enable pclk. So we must add apb_pclk property in device tree node.
For example, In our platform which is based on device tree,
we pass clock nodes to sp805 driver as
                 clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
                 clock-names = "wdogclk", "apb_pclk";
hsls_div4_clk is abp_pclk, and hsls_25m_div2_clk is wdogclk which is
the first node.
AMBA driver get the clock node using clock_get API with "apb_pclk" string.
In wdt driver clk_get api called with NULL string so first clock node
is taken as its clock node.
few other vendor platforms take same clock for both apb_pclk and wdt clocks.
In that case only one clock node in dt node and clock-name must be
given as apb_pclk.
then the same clock node taken to wdt clock also because wdt driver
call clock_get API with NULL.

So we can't use clock-frequency as alternative to clock nodes in
device tree system.
If we want to use.
we need to pass apb_pclk node and clock-frequency properties in dt node.
In that case apb_pclk node is taken as wdt clock because clk_get API
called with NULL string.
To avoid this, we need to call clk_get function in wdt driver with
valid string instead of NULL
Then clk_get failed and go for clock-frequency property.
If valid string we used for wdt clock in the driver, then it will be
problem for few platforms
where only one clock node used for both apb_pclk and wdt clock.
To solve this we need to pass same clock node for both apb_pclk and wdt clock.
So it causes changes in their DTS files.
I have a different approach to use clock-frequency support in only ACPI systems.
I will push those changes in next patch set.


> Lets summarize: You are introducing a new means for this driver to obtain
> the clock rate used by the watchdog. This is quite independent of the
> instantiation method, since it works for both ACPI and non-ACPI systems.
> This change needs to be documented and approved by devicetree maintainers.
> Its implementation must then accept all valid methods to obtain the clock
> rate without warning or error message.
>
> Thanks,
> Guenter
>
>>>
>>>> +               wdt->clk = NULL;
>>>> +               /*
>>>> +                * When Driver probe with ACPI device, clock devices
>>>> +                * are not available, so watchdog rate get from
>>>> +                * clock-frequency property given in _DSD object.
>>>> +                */
>>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>>> +                                        &wdt->rate);
>>>> +               if (!wdt->rate) {
>>>> +                       ret = -ENODEV;
>>>
>>>
>>>
>>> This unconditionally overrides the original error.
>>
>> I accept, I will change.
>>>
>>>
>>>> +                       goto err;
>>>> +               }
>>>>          }
>>>>    +
>>>
>>>
>>>
>>> No whitespace changes, please.
>>
>> I will remove.
>>>
>>>
>>> Does that mean that ACPI doesn't support the clock subsystem and that
>>> each
>>> driver
>>> supporting ACPI must do this ? That would be messy. Also, the above does
>>> not
>>> check
>>> if the device was probed through ACPI. It just tries to find an
>>> undocumented
>>> "clock-frequency" property which is quite different and would apply to
>>> (probably mis-configured) devicetree files as well.
>>>
>>> Either case, I would rather have this addressed through the clock
>>> subsystem.
>>> Otherwise, someone with subject knowledge will have to confirm that this
>>> is
>>> the
>>> appropriate solution. If so, the new property will have to be documented
>>> as
>>> an
>>> alternative to clock specifiers and accepted by devicetree maintainers.
>>>
>> I checked with ACPI maintainers, ACPI does not support common-clock
>> framework and also no plan.
>> AMBA framework also request for "apb_pclk" clock node to enable pclk.
>> But ACPI does not do the same.
>> So in device-tree use case, both apb_pclk and wdt clock nodes are
>> required properties, so passing
>> clock-frequency alone can not be alternative.
>> Because ACPI does not support clk node method, I came up with
>> alternate fixed-clock property clock-frequency.
>> clock-frequency is only specific to ACPI case, so we can't add in
>> binding document.
>> I will add device tree and ACPI specific check to read clock nodes and
>> clock-frequency properties separately.
>>
>> If you are fine with this I will send the next patch with modifications.
>>
>>> Guenter
>>>
>>>>          wdt->adev = adev;
>>>>          wdt->wdd.info = &wdt_info;
>>>>          wdt->wdd.ops = &wdt_ops;
>>>>
>>>
>> Thank you,
>>
>> Regards,
>> Srinath.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
Regards,
Srinath.
