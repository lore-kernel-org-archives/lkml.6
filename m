Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC093C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C420C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOJOsC/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0C420C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbeGKNwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:52:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45820 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbeGKNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:52:18 -0400
Received: by mail-pl0-f66.google.com with SMTP id a17-v6so3351777plm.12;
        Wed, 11 Jul 2018 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XBF27R11Dwm68WG9DLpn0B02TtPQTGNAknacUy/Pwk4=;
        b=IOJOsC/fBY/16cFhQ6eJKfAw+liEWOq1D0AhhVDfzM0UnOFY6ZLqnac1+do2IhmTLd
         CxIqLA9XiL7LUxD2PFiTWYBzbyK1d9kZ6JLVvFVLfvxpFfgTsM04O4OfyQONrBSVERfP
         CT8NshFMFv7X8tmH5FpeyARQr+bCrnaElT/IQe0sWuisHiQ+S6YnTnTSy2X+iiz1fAtU
         wqtmKJXquU4s8Cuh69GU8g9LIAYbbaPuyGK81Ty4QoHy104jlT5GTaxrtS/ViJ9bGjjX
         nXz2VFGbFNV/BEYHLMttZi67MRi7IlWcbSRP1tnYpfMv+DyqcdY4L4IxHwLDXDR33IKD
         HJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XBF27R11Dwm68WG9DLpn0B02TtPQTGNAknacUy/Pwk4=;
        b=pGDMOkQ1Nbf8u91ZaNZBVk7v+mfiYyjlnca1CG8p+Bw1FEwDiVo9f0PG2NoqO3JW0u
         HK6aZxYjank2TAQn+szWWPxYajZors16Ipv1o3NUG5BrY3Gngjc+Y6S+MwfyC3yiGETP
         nq+liha/0r/CEW8ZNOi8suXXTKSjI884jaOCslHl4okU0k621xMInIpFVYCErbLwFaF6
         m4blkpZV4ADECd0ZXW39mylxIHkTLkI7+hMYUPfL303DN50cPmWfjShOb6NLDWWmabEu
         /reF0GMM3mOGJLMnLyt9so8fozmxrrJZCWjUu1A1BqsnKFjzKSXy5qxJH57qO8jopWJz
         Xi0g==
X-Gm-Message-State: APt69E1lrrHEKGRUiHW1vofJT57+NWIdcm2oVByxKL5CMaQTRiKQKCgb
        QE1SNFGr7V4V8YAWGMPL3O6+tQ==
X-Google-Smtp-Source: AAOMgpev5KLF+FhWGTvPPLMxX1EpFbO+ZVn8GuCx4Zmvf+jc4VWR1HJlsIwVTd1J6xaYop+dhmFf6A==
X-Received: by 2002:a17:902:e00a:: with SMTP id ca10-v6mr28769844plb.224.1531316871629;
        Wed, 11 Jul 2018 06:47:51 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z4-v6sm19935143pfl.11.2018.07.11.06.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:47:50 -0700 (PDT)
Subject: Re: [RFC PATCH v3] watchdog: sp805: Add clock-frequency property
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     wim@linux-watchdog.org, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1531212279-24953-1-git-send-email-srinath.mannam@broadcom.com>
 <20180710213557.GC27827@roeck-us.net>
 <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3868f0c7-e45e-d3b4-5365-12a6a0646f6f@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABe79T4+S2vxx8RoNkEtY7ncaKGvXVf0n_yqN81gmtHnhgqg9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 06:22 AM, Srinath Mannam wrote:
> Hi Guenter,
> 
> Thank you very much for all the help with your feedback and review
> comments to complete the changes very fast.
> 
> About the documentation..
> I have gone through few similar patches available in the kernel are
> listed in the mail of previous version.
> No documentation available in Linux for the properties used in those
> patches also.

" No documentation available _in Linux_"

Emphasis mine. Yes, I noticed this as well. I was asking for a reference
to documentation _outside_ Linux. Sorry for not being more specific.

Guenter

> For example,
> 1: "src-clock-hz" property added in the part of ACPI support with the
> below patch.
> Patch details: commit 515da746983bc6382e380ba8b1ce9345a9550ffe
> Author: Naveen Kaje <nkaje@codeaurora.org>
> Date:   Tue Oct 11 10:27:56 2016 -0600
> 
>      i2c: qup: add ACPI support
> 2: "amd,dma-freq" property added in the part of ACPI support with the
> below patch
> commit 82a19035d000c8b4fd7d6f61b614f63dec75d389
> Author: Lendacky, Thomas <Thomas.Lendacky@amd.com>
> Date:   Fri Jan 16 12:47:16 2015 -0600
> 
>      amd-xgbe: Add ACPI support
> 
> Regards,
> Srinath.
> 
> 
> 
> 
> On Wed, Jul 11, 2018 at 3:05 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Tue, Jul 10, 2018 at 02:14:39PM +0530, Srinath Mannam wrote:
>>> When using ACPI node, binding clock devices are
>>> not available as device tree, So clock-frequency
>>> property given in _DSD object of ACPI device is
>>> used to calculate Watchdog rate.
>>>
>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>
>> I am ok with the patch itself. All that is missing now is a
>> reference to the _DSD property documentation. Is that published
>> somewhere or is it all wild-wild-west ?
>>
>> Thanks,
>> Guenter
>>
>>> ---
>>>   drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
>>>   1 file changed, 25 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
>>> index 9849db0..a896b1c 100644
>>> --- a/drivers/watchdog/sp805_wdt.c
>>> +++ b/drivers/watchdog/sp805_wdt.c
>>> @@ -11,6 +11,7 @@
>>>    * warranty of any kind, whether express or implied.
>>>    */
>>>
>>> +#include <linux/acpi.h>
>>>   #include <linux/device.h>
>>>   #include <linux/resource.h>
>>>   #include <linux/amba/bus.h>
>>> @@ -22,6 +23,7 @@
>>>   #include <linux/math64.h>
>>>   #include <linux/module.h>
>>>   #include <linux/moduleparam.h>
>>> +#include <linux/of.h>
>>>   #include <linux/pm.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/spinlock.h>
>>> @@ -65,6 +67,7 @@ struct sp805_wdt {
>>>        spinlock_t                      lock;
>>>        void __iomem                    *base;
>>>        struct clk                      *clk;
>>> +     u64                             rate;
>>>        struct amba_device              *adev;
>>>        unsigned int                    load_val;
>>>   };
>>> @@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>>        struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>>        u64 load, rate;
>>>
>>> -     rate = clk_get_rate(wdt->clk);
>>> +     rate = wdt->rate;
>>>
>>>        /*
>>>         * sp805 runs counter with given value twice, after the end of first
>>> @@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>>>   static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>   {
>>>        struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
>>> -     u64 load, rate;
>>> -
>>> -     rate = clk_get_rate(wdt->clk);
>>> +     u64 load;
>>>
>>>        spin_lock(&wdt->lock);
>>>        load = readl_relaxed(wdt->base + WDTVALUE);
>>> @@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
>>>                load += wdt->load_val + 1;
>>>        spin_unlock(&wdt->lock);
>>>
>>> -     return div_u64(load, rate);
>>> +     return div_u64(load, wdt->rate);
>>>   }
>>>
>>>   static int
>>> @@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>>>        if (IS_ERR(wdt->base))
>>>                return PTR_ERR(wdt->base);
>>>
>>> -     wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> -     if (IS_ERR(wdt->clk)) {
>>> -             dev_warn(&adev->dev, "Clock not found\n");
>>> -             ret = PTR_ERR(wdt->clk);
>>> -             goto err;
>>> +     if (adev->dev.of_node) {
>>> +             wdt->clk = devm_clk_get(&adev->dev, NULL);
>>> +             if (IS_ERR(wdt->clk)) {
>>> +                     dev_err(&adev->dev, "Clock not found\n");
>>> +                     return PTR_ERR(wdt->clk);
>>> +             }
>>> +             wdt->rate = clk_get_rate(wdt->clk);
>>> +     } else if (has_acpi_companion(&adev->dev)) {
>>> +             /*
>>> +              * When Driver probe with ACPI device, clock devices
>>> +              * are not available, so watchdog rate get from
>>> +              * clock-frequency property given in _DSD object.
>>> +              */
>>> +             device_property_read_u64(&adev->dev, "clock-frequency",
>>> +                                      &wdt->rate);
>>> +             if (!wdt->rate) {
>>> +                     dev_err(&adev->dev, "no clock-frequency property\n");
>>> +                     return -ENODEV;
>>> +             }
>>>        }
>>>
>>>        wdt->adev = adev;
>>> --
>>> 2.7.4
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

