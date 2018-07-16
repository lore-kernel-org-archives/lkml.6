Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F93ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH1eaVM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B6E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeGPKt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:49:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34632 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeGPKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:49:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so73768726ois.1;
        Mon, 16 Jul 2018 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nTqpGmU8kuqxTbhRDqaClGdv9ylIhoy/Qnv+PsLP8mo=;
        b=UH1eaVM5YseVeZn9rl0afpt8BmONiUZPi7QcVja6rvpL7jpC/wP2e60VO658PSdjFI
         ZgieDUqOTnIvtVt1Jl4Z5TQGRyHmyy0wYHbe9WKDOQSsE2KPxViOHJ0mhaamuh/ljLk0
         rFCPO8+MdoJLNdo6SJzoU9KZH818j9ShRRT8mGfH4rDuAVpvGXOEeXUsZamLwjZ4Sf7R
         /T2gAxsS/GaWIuKkSZZEJe6etW3hE8JeOp8IGYt8HMF0pfIAS02fuX6yh6Fc3AHjZ158
         Mc1q7vThjTxD7D9mw8lI2k1muZurLyHspWHA+envqfBAcv2VjND24/FQ61bO3hQI30hv
         AsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nTqpGmU8kuqxTbhRDqaClGdv9ylIhoy/Qnv+PsLP8mo=;
        b=sZwQTWco09uPvQBB3kEi8TMmI/MsZjWL6diGatN0+IGcD6+mo7EDwQWggi1khNGWX3
         cr4Yx5m70+1PPR+fHK3X1iOC9if5/5mn6yZAwci6Ab8Pn7jCbCZcWLl0jGOGEn6jltuf
         UC3wxWFzywijhn8ND+kDrBDH8i5MCwxZ+o/k6Uk7wVkDss2LaT74GQlk3HRUqIcbW1Ov
         mtjsHVRSD2W6TpZwVuMjqE7smo74n8AsuFKuxxvXKJMOBJ/FNQQpcWlWGhXDtjNyVJjZ
         QnQWALCT0msEypfaymEL/wLJCGMZx7KBgUXIgfIQqzgrw2DJCJ285C1LNGLV2SM8utNx
         0hWw==
X-Gm-Message-State: AOUpUlFRuc8DVa7DPkMJo1GnGzpWuRNE/1omxglm8CL/5B+isdsSdkfr
        Ltmwocvi/GmFB3NnnXxaEzOYmknORnJKwvNppnM=
X-Google-Smtp-Source: AAOMgpe2aWR36y6x+FgCv9Vww9BQb/6+3vW5yp2Uab3xFtlQ6Zt85DiC7VAdI1mlZuMyvMfV0CJM7HQ0p1a/4N/uhAE=
X-Received: by 2002:aca:ef44:: with SMTP id n65-v6mr16501435oih.120.1531736592651;
 Mon, 16 Jul 2018 03:23:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 03:23:12
 -0700 (PDT)
In-Reply-To: <010cb56a-36e8-e729-1fe7-738048eb551d@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-2-vivek.gautam@codeaurora.org> <17407514.unFVTGoGrn@aspire.rjw.lan>
 <CAFp+6iHxJucfzJJeEvSToG4p2zADjDb9F0L8h053x-JKAy55mg@mail.gmail.com>
 <CAJZ5v0gbkdkx_+oHYiPz=SFdFCLm38hsi1TmJ2Jdc7j73TNtzg@mail.gmail.com>
 <CAAFQd5Cqd=J+_nqRc_sx=sq2ayxwSRMgygvffuHH9nC5R_LjdA@mail.gmail.com>
 <CAFp+6iFxiM0DDnRqUameH6XOYjgdAF8ysuXXAjkc8zsod-dVcQ@mail.gmail.com>
 <CAJZ5v0hq3bLUbXNsr_ig7D72td_wqRP063x1AseP85F5UWs8VA@mail.gmail.com> <010cb56a-36e8-e729-1fe7-738048eb551d@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Jul 2018 12:23:12 +0200
X-Google-Sender-Auth: tuPiBTnbA989LSn13gfPaXiVI70
Message-ID: <CAJZ5v0irayU5cWBHtE=YVVqK_4gnue9bGopLkPY9P7-bEsixCA@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] iommu/arm-smmu: Add pm_runtime/sleep ops
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 16, 2018 at 12:11 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> HI Rafael,
>
>
>
> On 7/16/2018 2:21 PM, Rafael J. Wysocki wrote:
>>
>> On Thu, Jul 12, 2018 at 12:57 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:

[cut]

>>>> Although, given the PM
>>>> subsystem internals, the suspend function wouldn't be called on SMMU
>>>> implementation needed power control (since they would have runtime PM
>>>> enabled) and on others, it would be called but do nothing (since no
>>>> clocks).
>>>>
>>>>> Honestly, I just don't know. :-)
>>>>>
>>>>> It just looks odd the way it is done.  I think the clock should be
>>>>> gated during system-wide suspend too, because the system can spend
>>>>> much more time in a sleep state than in the working state, on average.
>>>>>
>>>>> And note that you cannot rely on runtime PM to always do it for you,
>>>>> because it may be disabled at a client device or even blocked by user
>>>>> space via power/control in sysfs and that shouldn't matter for
>>>>> system-wide PM.
>>>>
>>>> User space blocking runtime PM through sysfs is a good point. I'm not
>>>> 100% sure how the PM subsystem deals with that in case of system-wide
>>>> suspend. I guess for consistency and safety, we should have the
>>>> suspend callback.
>>>
>>> Will add the following suspend callback (same as
>>> arm_smmu_runtime_suspend):
>>>
>>>   static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
>>>   {
>>>           struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>>>
>>>           clk_bulk_disable(smmu->num_clks, smmu->clks);
>>>
>>>           return 0;
>>>   }
>>
>> I think you also need to check if the clock has already been disabled
>> by runtime PM.  Otherwise you may end up disabling it twice in a row.
>
>
> Should I rather call a pm_runtime_put() in suspend callback?

That wouldn't work as runtime PM may be effectively disabled by user
space via sysfs.  That's one of the reasons why you need the extra
system-wide suspend callback in the first place. :-)

> Or an expanded form something similar to:
> https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/slimbus/qcom-ctrl.c#L695

Yes, you can do something like that, but be careful to make sure that
the state of the device after system-wide resume is consistent with
its runtime PM status in all cases.
