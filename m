Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B9EC2C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505D20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKJR9tgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeFMIZN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:25:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33728 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeFMIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:25:10 -0400
Received: by mail-io0-f195.google.com with SMTP id d185-v6so2572221ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bCM/JrWt4RHOEqyvwlS4uP/fcaYEQ1lQc6zO98UMyt8=;
        b=jKJR9tgnr/hgZGfdD1JANiQfzk851smFblVYF7NRkJf0LFZx1aslBjrQNOkOBMjVWc
         Y8Z0BaKmjvUwZ00hpQyJx+Zn/MO+vSyQYRvCautCDTvN4vFb5OoUtRhft209LwrEoWuj
         HpN+hISQWm1iZXD2vTazY0gSqws25siRUKruc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bCM/JrWt4RHOEqyvwlS4uP/fcaYEQ1lQc6zO98UMyt8=;
        b=DLRCumTDp8uiw1Wu8wmNsFPUmfUCZg1oDuH08QmA4t1SsN/8zdipwBpMejHuUa878A
         IBV+sejSNYnACSecrygY0KHeNUQ37IVZNZ9DNQSaRqkOHkMh3LZAcVOMWdlEGBuy8hr9
         ge+jReILRrZT4jgIwqI+KYSnA9GrFawKBNizmRyUJpU9nH7wtujMvAJ0v/x0qsNTjlgi
         OmNlKJmgr+N/MMo4wfSIhtMzWrfDothYP2OlUdJXrN3hm8U5sPRMDjMwMQbcE5OKsh9D
         hlisQI29ohrK6aZfBrIYdtd/iIy571egaNlS3del0c6QbsBoUB/gcK7ojIz+vNgxOsQE
         wkHg==
X-Gm-Message-State: APt69E1ZULCh3xLC4GbPkcZFo7/REqDXLbm+NAD+XobGQXN+CRB5S8xb
        0b+WLb33Y4g77FtTmonciuR424pZAHmxdr2zYS6c+g==
X-Google-Smtp-Source: ADUXVKJl9S8fCkQIgJEKOkxA/N4DdUSi+lJoc20uq0yb9ZEzaV/Fr//OvWnavubR64Vshy4H7WfkifTymnwbcnkgMZQ=
X-Received: by 2002:a6b:c986:: with SMTP id z128-v6mr3889748iof.266.1528878309994;
 Wed, 13 Jun 2018 01:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:25:09
 -0700 (PDT)
In-Reply-To: <20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9~3pSVbThtx0723907239eucas1p2l@eucas1p2.samsung.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com> <20180613064258eucas1p2f8a082548d80bbc02f26aaa8773383b9~3pSVbThtx0723907239eucas1p2l@eucas1p2.samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jun 2018 10:25:09 +0200
Message-ID: <CAPDyKFpUE_nr3kxugTxAdxacB3e6KOi9ioa-zcVtd=VCyFL11Q@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 08:42, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Ulf,
>
> On 2018-06-12 21:43, Ulf Hansson wrote:
>> On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> On 2018-06-12 13:00, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> If a device link is added via device_link_add() by the driver of the
>>>> link's consumer device, the supplier's runtime PM usage counter is
>>>> going to be dropped by the pm_runtime_put_suppliers() call in
>>>> driver_probe_device().  However, in that case it is not incremented
>>>> unless the supplier driver is already present and the link is not
>>>> stateless.  That leads to a runtime PM usage counter imbalance for
>>>> the supplier device in a few cases.
>>>>
>>>> To prevent that from happening, bump up the supplier runtime
>>>> PM usage counter in device_link_add() for all links with the
>>>> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
>>>> time.  Use pm_runtime_get_noresume() for that as the callers of
>>>> device_link_add() who want the supplier to be resumed by it should
>>>> pass DL_FLAG_RPM_ACTIVE in flags to it anyway.
>>>>
>>>> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
>>>> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
>>>> reference counting of device link suppliers at probe) that is going
>>>> to be reverted.
>>> Thanks Rafael for the patch. I've applied it and now I'm a bit puzzled.
>>> Let's get back to my IOMMU and codec case, mentioned here:
>>> https://marc.info/?l=linux-pm&m=152878741527962&w=2
>>>
>>> Now, after applying your patch, when IOMMU creates a link with
>>> DL_FLAG_PM_RUNTIME to the jpeg device (this happens when jpeg device is
>>> being probed), it is not IOMMU is not runtime resumed anymore (that's
>>> because the patch changes pm_runtime_get_sync to pm_runtime_get_noresume).
>> According to your earlier replies, I thought this is what you wanted. No?
>>
>>> This means that until jpeg driver enables runtime pm for its device and
>>> finally performs runtime pm suspends/resume cycle, the supplier won't be
>>> resumed.
>> What's the problem with that?
>
> Wasted power. IOMMU device is left enabled until first use of JPEG device,
> what means that respective power domain is also turned on unnecessarily.

I understand the PM domain (genpd) gets powered on during probe, for
the respective device.

Now, that shouldn't be a problem, because, if the driver enables
runtime PM and leaves its device in runtime suspend state when probe
is complete, then when driver core invokes the dev->pm_domain->sync()
callback (set to genpd_dev_pm_sync()), genpd should be able to power
off the PM domain.

>
>> When does the IOMMU device needs to be
>> runtime resumed?
>
> I would like to have IOMMU (supplier) runtime active all the time the JPEG
> (consumer) device is runtime active AND all the time between probe() and
> remove() if JPEG (consumer) doesn't support runtime PM (if it doesn't
> enable runtime PM at all).

Right, that explains why you need the existing behavior. Thanks for clarifying!

I do see an opportunity for optimizations here, as clearly there are
cases when you don't need the supplier, the IOMMU device, to be
runtime resumed during link creation.

However, currently this seems not feasible, as
exynos_iommu_add_device() is called from a bus notifier, when the jpeg
device is added. The point is, exynos_iommu_add_device() has no clue
whether runtime PM is or will become enabled for the supplier device.
Thus using DL_FLAG_RPM_ACTIVE is needed. To address this, I think the
device link creation needs to be closer managed by the jpeg driver,
somehow.

>
>>> On the other hand, when I add DL_FLAG_RPM_ACTIVE flag to link
>>> creation, the supplier is properly resumed, but then, once the jpeg
>>> device probe finishes, the supplier is still in runtime active state
>>> until a next runtime suspend/resume cycle of jpeg device.
>> Could you elaborate on the what happens in jpeg driver during probe,
>> in regards to runtime PM. Perhaps you can also point me to what driver
>> it is?
>
> s5p_jpeg_probe() doesn't touch hardware at all and only calls
> pm_runtime_enable(),
> see drivers/media/platform/s5p-jpeg/jpeg-core.c

Thanks!

>
>>> If I understand
>>> right, the DL_FLAG_RPM_ACTIVE flag should be there from the beginning,
>>> but that time it runtime pm part of links worked in a bit different way
>>> than now.
>> Just to make sure, you also reverted 1e8378619841, before trying
>> Rafael's change on top?
>
> Yes

Great!

>
>>> Is there any way to keep old behavior?
>> I think the old behavior is sub-optimal. I am sure there are users
>> that really don't want the driver core to runtime resume the supplier
>> unconditionally.
>>
>> I would rather go and fix the few users of device_link_add(), to use
>> DL_FLAG_RPM_ACTIVE, in cases when they need it. Of course I am fine if
>> we do these changes in a step by step basis as well.
>
> I also agree that the old behavior is sub-optimal and there are use
> cases for the new (corrected) approach. I see no problems to add
> DL_FLAG_RPM_ACTIVE to exynos-iommu driver (and probably the 5 other
> drivers, which create links with DL_FLAG_PM_RUNTIME flag set to avoid
> regressions). The question is what else should be changed/fixed to get
> old behavior now.

I think Rafael's v2, may take care of the problem. No?

If not, then we need to investigate further.

Kind regards
Uffe
