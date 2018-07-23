Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A69ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED57420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKCx3cFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbeGWGek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:34:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40509 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeGWGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:34:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so31089609oie.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XYa2hDE81Ra9Azj5g9rpZpWVy/4Py4e5jLdkj7WFCNc=;
        b=aKCx3cFMrgGRbdPVDM0elHc2QR5p5/yUMkReNJx31hbu+0Sfc734YMxhHZUz71Jos4
         fXjnpBvGvFvHjZmZODKgnElVNG6aQ+BaVn4Pj1kvbQfwkc2dXeapQs30xVxQkP5lu5AT
         /MHdWX5K+3HdXxu2iU/3F6Wf11HTlr/yGaGp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XYa2hDE81Ra9Azj5g9rpZpWVy/4Py4e5jLdkj7WFCNc=;
        b=ZSFbIn5tH7h6z32rqjmI9BsxL8niVD8XoHR2pHdz3yym5k63H1qnL0Xa91VnCIGD1D
         wPk0H8uCkpRsQ39zWldyNKotPSmg48HM3Ae9H9idCFYtHJhlGyEjtKXttS0nnbijbtmt
         4QOM5h3qND00N658QQcvUbum2rKcYNuh5WcXf15VJ7ZNuJNRGtupyzpTNog8ouXYBC35
         CGrEt2MWa9XgYC+r5iSFmVBAEF76LnO7vj1v9cDbT9nf5jGvnArj5qHtdr5gXwO+i7UJ
         QCZeTtdP59dpM+A/8jSRX6hj2CNhrtcXuzF4CiFq7JUtzpF2OR/xHjg1UD3HXorkvNrl
         tD5g==
X-Gm-Message-State: AOUpUlHuTj5HFOzbAomRSWK7ofReRzW9upyO+V2yAY9qs27WLddZskNK
        0rUNft5mnMDjhwl/Dxwr8AYeArrxmRq9UVuBKePkXg==
X-Google-Smtp-Source: AAOMgpe0u0Gy6sMKfVXEhUfVqteiVx2HtFU0tQZP6BDZ/fxUpNOhA6EQsYqs/csqSlPwhRnEOOC6vxztp1mS8Ak7lfc=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr6841399oig.349.1532324113364;
 Sun, 22 Jul 2018 22:35:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 22:35:12
 -0700 (PDT)
In-Reply-To: <efe2211a-932d-fff8-ff82-2cda2e3a61ee@roeck-us.net>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com> <efe2211a-932d-fff8-ff82-2cda2e3a61ee@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 23 Jul 2018 11:05:12 +0530
Message-ID: <CABe79T78DYZTgfu3uPG6jKD+S5RGjH2rfCwaynaowMUiOHsXbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
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

I will send the updated patch..
Thank you.

Regards,
Srinath.

On Sat, Jul 21, 2018 at 8:08 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/10/2018 01:44 AM, Srinath Mannam wrote:
>>
>> When using ACPI node, binding clock devices are
>> not available as device tree, So clock-frequency
>> property given in _DSD object of ACPI device is
>> used to calculate Watchdog rate.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>
>
> Please resend as non-RFC and add a note in the description indicating
> that there is no formal review process for _DSD properties.
>
> Thanks,
> Guenter
>
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
