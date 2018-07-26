Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E493C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1849220891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EdvIcStm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1849220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeGZGuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:50:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35743 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbeGZGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:50:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so857221oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LXfnoQT26Efb8iF/xj1e9YrRlriJTfUgbu6cPpOBv9Q=;
        b=EdvIcStm3zWPBFMwG9IynKVcDNXOnM5Ibr9KwqurjCj97DhwJVQufb610pumMvB7YT
         YGi2GgShFtlfWi4iAo4j96gDga4UJUjet7KrUtVeTvWe+XLa/zuQl2YTZid/6cH9MQBc
         2ntBSqvRYmkI3USZ8Xr06/glA7wccsDwqZnMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LXfnoQT26Efb8iF/xj1e9YrRlriJTfUgbu6cPpOBv9Q=;
        b=thP24+RQctMF2i5gs7MFLwuCaLrQt8hbOo07djP3BGgGewrZp5reBSlLY5lWYgAqgn
         5/03PROh+OishoKIa757MbEATjAwndH4A/28Y9jWTBm9Yfse81GV2qUl+/rkIW/av4OK
         Z8eH+p0nZo/v62M1WIyphCLFiBjv2ywyj53eK2KvfF9tknhULJ9CKh+8v2kQ9uthorbg
         lclVe7zR8PcIyk5wFHtJdQZy8lVggLWE8kmJKbLZsqpLz5rEsjoYFdU7US8K9s4bT2pZ
         uHkxMre/txPJX0rz59n/czHIIVJAaFg+apRBNsUn8aYPCk8BW8WtFLufxtg+i763OXr+
         RPaw==
X-Gm-Message-State: AOUpUlGs8NnqoV8i3WS6dZcWyL57y0mPGKRywZ+MgF/dPpbmoWblK8x8
        /DglJGbGa2BNcUqH/Nv52N96cnShXYDgn6Rpjwwq4Q==
X-Google-Smtp-Source: AAOMgpdq28gF0WYlgBtnfuh04M6WasntufG2h0/dmh48cZ107VsYRF7ew1S60mTm/5ynLjVHwQxcWiQed31JK42/TiE=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr508311oia.326.1532583299645;
 Wed, 25 Jul 2018 22:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 22:34:58
 -0700 (PDT)
In-Reply-To: <ca37de93-4079-4270-aa91-8411a07b168f@roeck-us.net>
References: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
 <f6095ab0-5916-99c7-09eb-0bfde335bc38@roeck-us.net> <CABe79T5cDBwi2A-yYXfRcVMPYQdhpHqzsNFdgA_m2CuQNjZ6Kg@mail.gmail.com>
 <ca37de93-4079-4270-aa91-8411a07b168f@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 26 Jul 2018 11:04:58 +0530
Message-ID: <CABe79T7=1eBfmD4xxAJQrKx0wj=njuhLn-fvwCjwkBJK+TH+vQ@mail.gmail.com>
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

Thank you.. I sent next version patch with modification.

Regards,
Srinath.

On Thu, Jul 26, 2018 at 10:39 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/25/2018 09:47 PM, Srinath Mannam wrote:
>>
>> Hi Guenter,
>>
>> It was my mistake sorry for that. I thought to add as Rivewed-by your
>> name..
>> Many changes are made based on your review comments and suggestions.
>> So, Can I add your name in Reviewed list?
>
>
> You did that already below, and I am ok with that.
>
> Guenter
>
>> I will modify and send next patchset.
>>
>> thank you.
>>
>> Regards,
>> Srinath.
>>
>> On Thu, Jul 26, 2018 at 10:12 AM, Guenter Roeck <linux@roeck-us.net>
>> wrote:
>>>
>>> On 07/23/2018 01:37 AM, Srinath Mannam wrote:
>>>>
>>>>
>>>> Use clock-frequency property given in _DSD object
>>>> of ACPI device to calculate Watchdog rate as binding
>>>> clock devices are not available as device tree.
>>>>
>>>> Note: There is no formal review process for _DSD
>>>> properties
>>>>
>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>>
>>>
>>> I just noticed this. This is completely inappropriate. It is
>>> the equivalent of forging a signature on a check.
>>>
>>> _Never_ add a Signed-off-by: statement for anyone but yourself.
>>>
>>> Guenter
>>>
>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>>>    drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>>>    1 file changed, 25 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>>> index 9849db0..a896b1c 100644
>>>> --- a/drivers/watchdog/sp805_wdt.c
>>>> +++ b/drivers/watchdog/sp805_wdt.c
>>>> @@ -11,6 +11,7 @@
>>>>     * warranty of any kind, whether express or implied.
>>>>     */
>>>>    +#include <linux/acpi.h>
>>>>    #include <linux/device.h>
>>>>    #include <linux/resource.h>
>>>>    #include <linux/amba/bus.h>
>>>> @@ -22,6 +23,7 @@
>>>>    #include <linux/math64.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/moduleparam.h>
>>>> +#include <linux/of.h>
>>>>    #include <linux/pm.h>
>>>>    #include <linux/slab.h>
>>>>    #include <linux/spinlock.h>
>>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>>          spinlock_t                      lock;
>>>>          void __iomem                    *base;
>>>>          struct clk                      *clk;
>>>> +       u64                             rate;
>>>>          struct amba_device              *adev;
>>>>          unsigned int                    load_val;
>>>>    };
>>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>>> unsigned int timeout)
>>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>>          u64 load, rate;
>>>>    -     rate = clk_get_rate(wdt->clk);
>>>> +       rate = wdt->rate;
>>>>          /*
>>>>           * sp805 runs counter with given value twice, after the end of
>>>> first
>>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd,
>>>> unsigned int timeout)
>>>>    static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>>    {
>>>>          struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>> -       u64 load, rate;
>>>> -
>>>> -       rate = clk_get_rate(wdt->clk);
>>>> +       u64 load;
>>>>          spin_lock(&wdt->lock);
>>>>          load = readl_relaxed(wdt->base + WDTVALUE);
>>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct
>>>> watchdog_device *wdd)
>>>>                  load += wdt->load_val + 1;
>>>>          spin_unlock(&wdt->lock);
>>>>    -     return div_u64(load, rate);
>>>> +       return div_u64(load, wdt->rate);
>>>>    }
>>>>      static int
>>>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const
>>>> struct amba_id *id)
>>>>          if (IS_ERR(wdt->base))
>>>>                  return PTR_ERR(wdt->base);
>>>>    -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>>> -       if (IS_ERR(wdt->clk)) {
>>>> -               dev_warn(&adev->dev, "Clock not found\n");
>>>> -               ret = PTR_ERR(wdt->clk);
>>>> -               goto err;
>>>> +       if (adev->dev.of_node) {
>>>> +               wdt->clk = devm_clk_get(&adev->dev, NULL);
>>>> +               if (IS_ERR(wdt->clk)) {
>>>> +                       dev_err(&adev->dev, "Clock not found\n");
>>>> +                       return PTR_ERR(wdt->clk);
>>>> +               }
>>>> +               wdt->rate = clk_get_rate(wdt->clk);
>>>> +       } else if (has_acpi_companion(&adev->dev)) {
>>>> +               /*
>>>> +                * When Driver probe with ACPI device, clock devices
>>>> +                * are not available, so watchdog rate get from
>>>> +                * clock-frequency property given in _DSD object.
>>>> +                */
>>>> +               device_property_read_u64(&adev->dev, "clock-frequency",
>>>> +                                        &wdt->rate);
>>>> +               if (!wdt->rate) {
>>>> +                       dev_err(&adev->dev, "no clock-frequency
>>>> property\n");
>>>> +                       return -ENODEV;
>>>> +               }
>>>>          }
>>>>          wdt->adev = adev;
>>>>
>>>
>>
>
