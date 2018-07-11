Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C6220652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WE++S9oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C6220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbeGKN1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:27:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37601 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbeGKN1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:27:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so49175249oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QhVTkzbwCT3RtWFB8UdfVw5N/go9nXIBH3n1C2C3Zi8=;
        b=WE++S9ohXoWtyo/RMv13Ey5ZkxaHtFJl+1k/75JUx1uhSV79CwdCOb8Gvd7h5oGQ+K
         IT71xf6Vmyy4udSjdL/693RP/ErTvRjC2hO6g69c5H/+gqMdr36s6AdvuWDwbe/YTluB
         sc8VGbjPE1raPZrbJgzXF/N11yEL5q05QmBWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QhVTkzbwCT3RtWFB8UdfVw5N/go9nXIBH3n1C2C3Zi8=;
        b=AFah2inO412ISaXniCvv2rcZ3k5KdPCwJihRpGI2SKZyTiIEUbuI1iBmZCOVQBDMpp
         x+o/Ga7DYH/z2auxTviwouKEP2pcAdl3xfsbZLDrjFf2z+HMHkrxB/muDt0L4zjZijOr
         Zm62eGOOgEZC2C1h1oBecJcgxZHhQEZDN28/PtJsra2nAmyAHG7A3x8Opvo+QO8iP56H
         ZFi8enf/3GvB7mVuGogsN8cALo7Jo1M6IYPmRl9tacp/hEaD4toeC5Lw90gL3uAV1n+k
         SqxPknnY2JaPdmvgULRiXJeIkJ2ggd5QOOD2JlerTrM4giMLo6gHkY+S1OsesOiCmIEc
         fOcg==
X-Gm-Message-State: APt69E1lkak1SDe645yaJc54zgpk44gBbuwKoh3THf2aUixqyLYAAg/d
        SPYLTqQ2+GlzcI+CqpvbUdG+HP+A8ittph54Nvk1YA==
X-Google-Smtp-Source: AAOMgpfS+BFzNYzbcK0FL3+HfYqT+MVUdTPop05HiAkAYMjvxrsUD4BdpUh3UdcqXm3fcfxqG6WWgIv7T4bL+WDuNuI=
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr33866249oie.322.1531315372148;
 Wed, 11 Jul 2018 06:22:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 06:22:51
 -0700 (PDT)
In-Reply-To: <20180710213557.GC27827@roeck-us.net>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com> <20180710213557.GC27827@roeck-us.net>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 11 Jul 2018 18:52:51 +0530
Message-ID: <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
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

Thank you very much for all the help with your feedback and review
comments to complete the changes very fast.

About the documentation..
I have gone through few similar patches available in the kernel are
listed in the mail of previous version.
No documentation available in Linux for the properties used in those
patches also.
For example,
1: "src-clock-hz" property added in the part of ACPI support with the
below patch.
Patch details: commit 515da746983bc6382e380ba8b1ce9345a9550ffe
Author: Naveen Kaje <nkaje@codeaurora.org>
Date:   Tue Oct 11 10:27:56 2016 -0600

    i2c: qup: add ACPI support
2: "amd,dma-freq" property added in the part of ACPI support with the
below patch
commit 82a19035d000c8b4fd7d6f61b614f63dec75d389
Author: Lendacky, Thomas <Thomas.Lendacky@amd.com>
Date:   Fri Jan 16 12:47:16 2015 -0600

    amd-xgbe: Add ACPI support

Regards,
Srinath.




On Wed, Jul 11, 2018 at 3:05 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jul 10, 2018 at 02:14:39PM +0530, Srinath Mannam wrote:
>> When using ACPI node, binding clock devices are
>> not available as device tree, So clock-frequency
>> property given in _DSD object of ACPI device is
>> used to calculate Watchdog rate.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>
> I am ok with the patch itself. All that is missing now is a
> reference to the _DSD property documentation. Is that published
> somewhere or is it all wild-wild-west ?
>
> Thanks,
> Guenter
>
>> ---
>>  drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>  1 file changed, 25 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>> index 9849db0..a896b1c 100644
>> --- a/drivers/watchdog/sp805_wdt.c
>> +++ b/drivers/watchdog/sp805_wdt.c
>> @@ -11,6 +11,7 @@
>>   * warranty of any kind, whether express or implied.
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/device.h>
>>  #include <linux/resource.h>
>>  #include <linux/amba/bus.h>
>> @@ -22,6 +23,7 @@
>>  #include <linux/math64.h>
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/of.h>
>>  #include <linux/pm.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>       spinlock_t                      lock;
>>       void __iomem                    *base;
>>       struct clk                      *clk;
>> +     u64                             rate;
>>       struct amba_device              *adev;
>>       unsigned int                    load_val;
>>  };
>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>       struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>       u64 load, rate;
>>
>> -     rate = clk_get_rate(wdt->clk);
>> +     rate = wdt->rate;
>>
>>       /*
>>        * sp805 runs counter with given value twice, after the end of first
>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>  static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>  {
>>       struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>> -     u64 load, rate;
>> -
>> -     rate = clk_get_rate(wdt->clk);
>> +     u64 load;
>>
>>       spin_lock(&wdt->lock);
>>       load = readl_relaxed(wdt->base + WDTVALUE);
>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>               load += wdt->load_val + 1;
>>       spin_unlock(&wdt->lock);
>>
>> -     return div_u64(load, rate);
>> +     return div_u64(load, wdt->rate);
>>  }
>>
>>  static int
>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>       if (IS_ERR(wdt->base))
>>               return PTR_ERR(wdt->base);
>>
>> -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>> -     if (IS_ERR(wdt->clk)) {
>> -             dev_warn(&adev->dev, "Clock not found\n");
>> -             ret = PTR_ERR(wdt->clk);
>> -             goto err;
>> +     if (adev->dev.of_node) {
>> +             wdt->clk = devm_clk_get(&adev->dev, NULL);
>> +             if (IS_ERR(wdt->clk)) {
>> +                     dev_err(&adev->dev, "Clock not found\n");
>> +                     return PTR_ERR(wdt->clk);
>> +             }
>> +             wdt->rate = clk_get_rate(wdt->clk);
>> +     } else if (has_acpi_companion(&adev->dev)) {
>> +             /*
>> +              * When Driver probe with ACPI device, clock devices
>> +              * are not available, so watchdog rate get from
>> +              * clock-frequency property given in _DSD object.
>> +              */
>> +             device_property_read_u64(&adev->dev, "clock-frequency",
>> +                                      &wdt->rate);
>> +             if (!wdt->rate) {
>> +                     dev_err(&adev->dev, "no clock-frequency property\n");
>> +                     return -ENODEV;
>> +             }
>>       }
>>
>>       wdt->adev = adev;
>> --
>> 2.7.4
>>
