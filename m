Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC37ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378ED20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIrg90RG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378ED20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeGQIR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:17:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34154 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeGQIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:17:28 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so324777ois.1;
        Tue, 17 Jul 2018 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tkhsxH4/DiwBBp3CvloSXR3/NQGaINKcUHbQsP/eVi0=;
        b=iIrg90RGyXORqwipnU6DIaHhUBFuVSnYBhn7ec86R3+UTvFOOnlaZgwPhKIdgWnxsM
         72I3MmBSroO6vpnnspx3OB2ZFBx79rExzll061yQU95+fXq3jLGz3UiT5lo69kg1crkU
         QDO1W2lxxGfRlH6Y6hmDrAf8Cj8rXgzV+FTNJ85koq4PkD2PT8jEL65/gppzxcTrOu88
         S3UAJd2GodFv8BIW3xNxRu7hhzFjpOsIH0TwlBIGUbMjo9kIcN4jJ+zMi5Ft5m8GauEh
         QUaSYVy0P3gcdeMrDxrj1LxS6smybYN8UX3VUepiaitof8F+M0vKvRP6hYUlgiX7EmRV
         tFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tkhsxH4/DiwBBp3CvloSXR3/NQGaINKcUHbQsP/eVi0=;
        b=S94WvKwS+nG+mSwfrkDBiyUj6G+1VcuPxrUhAV0HeC8Xt9e99+a2Vra4caoWmNqRek
         R1pGtQP5Z2Jc6RPrECwzyHS0D+tJfokwvGsbJ4drhSpLS/v1CTBVYE9a4hAWxoUSmKju
         QwjXJ9TUmu45lDJ0ZQ/RAPtqU9PJsdVQUVSyCjbD0r4bp2jTCIcuWgvN9lRqO5XTcwld
         IXC1XOi3TSfdLNvagKjBfEjllNTBEnWW4aieocW6pWqwKUYsr992nOMi3mzbJEhASuZY
         UhZgVcrf9tK97LEm4XvlIcn/+eiunu8G2x6uB5/Kvdavb589wiZPunXsvvqcJBSNQMbC
         NvRQ==
X-Gm-Message-State: AOUpUlHkwq0TUja6wwg8I3bPdtFpA//X6nWCQk2VkqgXYVY7KBhREKUr
        FNIsuMeUvXWMHSfg2avdSSZzFnJbIScg/kERDzw=
X-Google-Smtp-Source: AAOMgpc3npG9s2CumGlpkKjjVlvPuU5uniVUW4wkdDnzY0M4oSY6bYC1PjJVj7oirfiJtiaE53DPOl5ZX8VvuC4+hZk=
X-Received: by 2002:aca:ef44:: with SMTP id n65-v6mr508222oih.120.1531813570946;
 Tue, 17 Jul 2018 00:46:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 00:46:10
 -0700 (PDT)
In-Reply-To: <93d16301-4bef-203f-24de-4d010de84b22@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org> <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org> <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
 <CAJZ5v0iQ2wxsXvuaLK2M9a_Jwe_fnwR2Afrq_Oa8h0--Ch7-5g@mail.gmail.com> <93d16301-4bef-203f-24de-4d010de84b22@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 09:46:10 +0200
X-Google-Sender-Auth: hM5-n0UiJLheczrHWNmH36uIMNo
Message-ID: <CAJZ5v0ijB6ZX9q0i+YrkWg1-nQBx+FuTjbGq1xRoJS113uoA-g@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 1:46 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
>
> On 7/16/2018 2:25 PM, Rafael J. Wysocki wrote:
>>
>> On Thu, Jul 12, 2018 at 2:41 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>>
>>> Hi Rafael,
>>>
>>>
>>> On Wed, Jul 11, 2018 at 4:06 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>
>>>>
>>>> On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>>>>
>>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>>
>>>>>> Finally add the device link between the master device and
>>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>>> master needs it. This is done from add_device callback which gets
>>>>>> called once when the master is added to the smmu.
>>>>>>
>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>>>> ---
>>>>>>
>>>>>>    - Change since v11
>>>>>>      * Replaced DL_FLAG_AUTOREMOVE flag with
>>>>>> DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>>>>
>>>>>>    drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>>>>    1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>> index 09265e206e2d..916cde4954d2 100644
>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device
>>>>>> *dev)
>>>>>>          iommu_device_link(&smmu->iommu, dev);
>>>>>>    +     if (pm_runtime_enabled(smmu->dev) &&
>>>>>
>>>>> Why does the creation of the link depend on whether or not runtime PM
>>>>> is enabled for the MMU device?
>>>>
>>>>
>>>> The main purpose of this device link is to handle the runtime PM
>>>> synchronization
>>>> between the supplier (iommu) and consumer (client devices, such as
>>>> GPU/display).
>>>> Moreover, the runtime pm is conditionally enabled for smmu devices that
>>>> support
>>>> such [1].
>>>
>>> Is there something you would like me to modify in this patch?
>>
>> Not really, as long as you are sure that it is correct. :-)
>>
>> You need to remember, however, that if you add system-wide PM
>> callbacks to the driver, the ordering between them and the client
>> device callbacks during system-wide suspend matters as well.  Don't
>> you need the link the ensure the correct system-wide suspend ordering
>> too?
>
>
> The fact that currently we handle clocks only through runtime pm callbacks,
> would it be better to call runtime pm put/get in system-wide PM callbacks.
> This would be same as i mentioned in the other thread.

Well, my point is that there's no reason for system-wide suspend to
depend directly on runtime PM (which can be effectively disabled by
user space as mentioned for multiple times in this thread).

It simply is not efficient to let the clock run while the system as a
whole is sleeping (even if power/control has been set to "on" for this
particular device) and it should not be too hard to prevent that from
happening.  You may need an additional flag in the driver for that or
similar, but it definitely should be doable.

Now, that's my advice and I'm not the maintainer of that code, so it
is your call (as long as the maintainer agrees with it).

Thanks,
Rafael
