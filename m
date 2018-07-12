Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF40C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8648D20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nz1Is7rr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mI/4plUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8648D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeGLMvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:51:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeGLMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:51:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8173360B10; Thu, 12 Jul 2018 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531399305;
        bh=DTinPSsSGzlPAtJq/Fabe6YFPFlRfPRGQXU9TXwYoQ4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nz1Is7rrFUUtSNIV3oUvWscWmhtTxvd41qYNk0OiMwAvTitKp/JvZCUo39TFizmwH
         WvSGogBmr+rEAHh3a0i6GtydWT1xc6vdDcY8HVWWUMhwleUjYYOoxDGFwqOPIFcOM4
         ht8EChlujvZIpvODxDTCscd0QpcUiS3AR+9g7d80=
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com [209.85.216.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7B3760B77;
        Thu, 12 Jul 2018 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531399303;
        bh=DTinPSsSGzlPAtJq/Fabe6YFPFlRfPRGQXU9TXwYoQ4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mI/4plUUnBGVd5W1vBdMbJlxhGv3dLsOasz3+N3XTlQgocGGffSdghF+pbCbZ7r6f
         x2fkGpsALfXx+O7r3qqpeiY/e3rIyrHHLmgCl6dIxyFhU8v+QKiVw/o+sb+x+KshSq
         C2Y5d7UCaum7mggIm4dmYcLUR+dSuNuidCpdhG+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7B3760B77
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f170.google.com with SMTP id q12-v6so23882794qtp.6;
        Thu, 12 Jul 2018 05:41:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlHxooB+7ZOPsWNPLPvRg4rrduPXlPFXIW9vSccqXYnrm6assgHd
        bFOnrb6R3t5XJuG/6GqWXpOSuoey2+otrBwGvRs=
X-Google-Smtp-Source: AAOMgped+vtvPIsBOsw759o+yl4tRMMgUbO+1Wjab1eEn8UGSOTu6MySC8BQiTQWs9QaSvjsQMEk4+wNt74RbyeA12Y=
X-Received: by 2002:ac8:3525:: with SMTP id y34-v6mr1538625qtb.241.1531399302909;
 Thu, 12 Jul 2018 05:41:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 05:41:42
 -0700 (PDT)
In-Reply-To: <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org> <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 12 Jul 2018 18:11:42 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
Message-ID: <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>, sboyd@kernel.org,
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

Hi Rafael,


On Wed, Jul 11, 2018 at 4:06 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Rafael,
>
>
>
> On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
>>
>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Lukas Wunner <lukas@wunner.de>
>>> ---
>>>
>>>   - Change since v11
>>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>
>>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 09265e206e2d..916cde4954d2 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>         iommu_device_link(&smmu->iommu, dev);
>>>   +     if (pm_runtime_enabled(smmu->dev) &&
>>
>> Why does the creation of the link depend on whether or not runtime PM
>> is enabled for the MMU device?
>
>
> The main purpose of this device link is to handle the runtime PM
> synchronization
> between the supplier (iommu) and consumer (client devices, such as
> GPU/display).
> Moreover, the runtime pm is conditionally enabled for smmu devices that
> support
> such [1].

Is there something you would like me to modify in this patch?

Best regards
Vivek

>>
>>
>> What about system-wide PM and system shutdown?  Are they always guaranteed
>> to happen in the right order without the link?
>
>
> When there's no runtime PM, there's no clocks, and other resources to be
> handled.
> So, we don't need device link for system-wide PM and system shutdown to work
> correctly.
> That's the case with current arm-smmu driver.
> Is it something that i am missing here?
>
> [1] https://lkml.org/lkml/2018/3/8/775
>
> Thanks
> Vivek
>>>
>>> +           !device_link_add(dev, smmu->dev,
>>> +                       DL_FLAG_PM_RUNTIME |
>>> DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>>> +               dev_err(smmu->dev, "Unable to add link to the consumer
>>> %s\n",
>>> +                       dev_name(dev));
>>> +               ret = -ENODEV;
>>> +               goto out_unlink;
>>> +       }
>>> +
>>>         return 0;
>>>   +out_unlink:
>>> +       iommu_device_unlink(&smmu->iommu, dev);
>>> +       arm_smmu_master_free_smes(fwspec);
>>>   out_cfg_free:
>>>         kfree(cfg);
>>>   out_free:
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
