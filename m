Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF620652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kss740Fb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E3U3zOYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDF620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeGROJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:09:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbeGROJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:09:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A354607C6; Wed, 18 Jul 2018 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531920699;
        bh=O8qbacYd7wyHTriR5CYEZ5rA4Lva0BrVWMiygXVaW1Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Kss740Fb20feINQn2FcPLviGQvYlPXlBLpwsvJ83FYMAggIHP7HzfYxKlc/kwIsQ2
         idfjMj2AeO8HVRZ4/8drJ2KcjD5JnNU4MAil20UudjAoSTyydJg0PcqJrd17nyiFBD
         o+gOgP/hFhgkyQM3VxS7CuncJNvQAVme8S7BeYOo=
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 245486078C;
        Wed, 18 Jul 2018 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531920690;
        bh=O8qbacYd7wyHTriR5CYEZ5rA4Lva0BrVWMiygXVaW1Y=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=E3U3zOYF4O/d+EQlLdSvCbVQdBtGYb+2nUcbFUYrqQYkdV6WFQbma4+5pJLIcHsGV
         TzaIL/W+uq4plgi0g5Rp/33E8N+SPPxwQVD5FhJQGSrthtdajFPNVwNP522Ysv4pzo
         B9Yr5v7sYEdNRsQPDHqTWaHDJC3i8BI1tk4HsvE8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 245486078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f170.google.com with SMTP id h4-v6so3973006qtj.7;
        Wed, 18 Jul 2018 06:31:30 -0700 (PDT)
X-Gm-Message-State: AOUpUlFPE4f9g0DLHURAinBemcmJQp0J3f4M/Y3Y744ffOMdlEYZ4Ow3
        /9fJoe1SX+o5hEloyO0c4ggD0wrNvx+m8ieFrNg=
X-Google-Smtp-Source: AAOMgpe2emM36vsxMd8J06FVQ5JQKuMva9Zl6NWryVWjVixgf51IBeRPyUg55dk0VL4cVOvgCHlLJgPonDbu5AmAgWQ=
X-Received: by 2002:a0c:c489:: with SMTP id u9-v6mr6412035qvi.11.1531920689404;
 Wed, 18 Jul 2018 06:31:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 06:31:28 -0700 (PDT)
In-Reply-To: <48139f68-5a79-8531-00fa-fbdd787f50f5@arm.com>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org> <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com> <48139f68-5a79-8531-00fa-fbdd787f50f5@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 18 Jul 2018 19:01:28 +0530
X-Gmail-Original-Message-ID: <CAFp+6iF3vihGYLVkALmGa4USLcUaUOtpKD0EDC8CALv6Ch6VrQ@mail.gmail.com>
Message-ID: <CAFp+6iF3vihGYLVkALmGa4USLcUaUOtpKD0EDC8CALv6Ch6VrQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        sboyd@kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:13 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 18/07/18 10:30, Vivek Gautam wrote:
>>
>> On Wed, Jul 11, 2018 at 3:23 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
>> wrote:
>>>
>>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>>
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> Finally add the device link between the master device and
>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>> master needs it. This is done from add_device callback which gets
>>>> called once when the master is added to the smmu.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>> ---
>>>>
>>>>   - Change since v11
>>>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>>
>>>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index 09265e206e2d..916cde4954d2 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device
>>>> *dev)
>>>>
>>>>        iommu_device_link(&smmu->iommu, dev);
>>>>
>>>> +     if (pm_runtime_enabled(smmu->dev) &&
>>>
>>>
>>> Why does the creation of the link depend on whether or not runtime PM
>>> is enabled for the MMU device?
>>>
>>> What about system-wide PM and system shutdown?  Are they always
>>> guaranteed
>>> to happen in the right order without the link?
>>
>>
>> Hi Robin,
>>
>> As Rafael pointed, we should the device link creation should not depend on
>> runtime PM being enabled or not, as we would also want to guarantee
>> that system wide PM callbacks are called in the right order for smmu
>> and clients.
>>
>> Does this change of removing the check for pm_runtime_enabled() from here
>> looks okay to you?
>
>
> FWIW the existing system PM ops make no claim to be perfect, and I wouldn't
> be at all surprised if it was only by coincidence that my devices happened
> to put on the relevant lists in the right order to start with. If we no
> longer need to worry about explicit device_link housekeeping in the SMMU
> driver, then creating them unconditionally sounds like the sensible thing to
> do. I'd be inclined to treat failure as non-fatal like we do for the sysfs
> link, though, since it's another thing that correct SMMU operation doesn't
> actually depend on (at this point we don't necessarily know if this consumer
> even has a driver at all).

Thanks. I will then respin the patch taking care of treating failure
as non-fatal.

>> FYI, as discussed in the first patch [1] of this series, I will add a
>> system wide
>> suspend callback - arm_smmu_pm_suspend, that would do clock disable, and
>> will
>> add corresponding clock enable calls in arm_smmu_pm_resume().
>
>
> OK, I still don't really understand the finer points of how system PM and
> runtime PM interact, but if making it robust is just a case of calling the
> runtime suspend/resume hooks as appropriate from the system ones, that
> sounds reasonable.

Sure. Thanks.

Best regards
Vivek

>
> Robin.
>
>>
>> [1] https://lore.kernel.org/patchwork/patch/960460/
>>
>>
>> Best regards
>> Vivek
>>
>>>
>>>> +         !device_link_add(dev, smmu->dev,
>>>> +                     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER))
>>>> {
>>>> +             dev_err(smmu->dev, "Unable to add link to the consumer
>>>> %s\n",
>>>> +                     dev_name(dev));
>>>> +             ret = -ENODEV;
>>>> +             goto out_unlink;
>>>> +     }
>>>> +
>>>>        return 0;
>>>>
>>>> +out_unlink:
>>>> +     iommu_device_unlink(&smmu->iommu, dev);
>>>> +     arm_smmu_master_free_smes(fwspec);
>>>>   out_cfg_free:
>>>>        kfree(cfg);
>>>>   out_free:
>>>>
>>>
>>>
>>
>>
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
