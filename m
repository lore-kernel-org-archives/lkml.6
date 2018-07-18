Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B454BECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B802075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e7q2/Tfi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e9j+1uUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B802075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeGRKHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:07:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeGRKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:07:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3AA5F607DC; Wed, 18 Jul 2018 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531906243;
        bh=eSEfOCtvcSA4Bcx165YYFoM0xGxU1ra82iGYuDgHVbc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e7q2/TfiTG5QPPDvdJHxG6Nd/vwUdZJh9UqyfoIhzegcTdn2idiI5d4DgMUsuWq5K
         j2CWsnrTCn88CUCZ7fIfbPf/MXi3O2Z1csNffYkaxZ0QQUKH7fA97dNdEXoBgVgtwO
         ash6zqf+CAiwDJqyPB9jCBgRxDja/6QwnuxEi7Wg=
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com [209.85.220.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB0AC607DC;
        Wed, 18 Jul 2018 09:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531906240;
        bh=eSEfOCtvcSA4Bcx165YYFoM0xGxU1ra82iGYuDgHVbc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e9j+1uUwNLMH9c2XvbK+t8vRIEXv3n4aHc4pr9ScFs+Dml5k+iU5qXwKH0zLUAwrJ
         N9rYvl72TgvsvR9LQjP/d6K6olD2kBc69Jc8PIpX0lkmk80u8NtHdzo9RO0EqHQpjW
         pT5jn4z0rREGFiVu9donJTz/mNaDu0XCE975jfs4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB0AC607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f174.google.com with SMTP id c126-v6so2011098qkd.7;
        Wed, 18 Jul 2018 02:30:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlHPynnsach8qG0MdWP9brbBg8ge/rHyGDO+PVzAjruWD6ay9d9v
        L2sykWI1MjwYF6Ys60va7ZnlqfOH5OjfWBM6o7U=
X-Google-Smtp-Source: AAOMgpdKgaVNk/763g62p7vH5DShktnY0y8MkgXJIASLW12aCmsjSO09vlaM1THGihqX+BThR39CfYwHu8UDuTjjVek=
X-Received: by 2002:a37:5942:: with SMTP id n63-v6mr4747969qkb.28.1531906239918;
 Wed, 18 Jul 2018 02:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 02:30:39 -0700 (PDT)
In-Reply-To: <5179668.PHK6S3sxLu@aspire.rjw.lan>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org> <5179668.PHK6S3sxLu@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 18 Jul 2018 15:00:39 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com>
Message-ID: <CAFp+6iGcwdK=wyPf++u3B+ORghuB1YhYmnJLSwvt1efG9H4YeA@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Wed, Jul 11, 2018 at 3:23 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> Finally add the device link between the master device and
>> smmu, so that the smmu gets runtime enabled/disabled only when the
>> master needs it. This is done from add_device callback which gets
>> called once when the master is added to the smmu.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> ---
>>
>>  - Change since v11
>>    * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>
>>  drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 09265e206e2d..916cde4954d2 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>
>>       iommu_device_link(&smmu->iommu, dev);
>>
>> +     if (pm_runtime_enabled(smmu->dev) &&
>
> Why does the creation of the link depend on whether or not runtime PM
> is enabled for the MMU device?
>
> What about system-wide PM and system shutdown?  Are they always guaranteed
> to happen in the right order without the link?

Hi Robin,

As Rafael pointed, we should the device link creation should not depend on
runtime PM being enabled or not, as we would also want to guarantee
that system wide PM callbacks are called in the right order for smmu
and clients.

Does this change of removing the check for pm_runtime_enabled() from here
looks okay to you?

FYI, as discussed in the first patch [1] of this series, I will add a
system wide
suspend callback - arm_smmu_pm_suspend, that would do clock disable, and will
add corresponding clock enable calls in arm_smmu_pm_resume().

[1] https://lore.kernel.org/patchwork/patch/960460/


Best regards
Vivek

>
>> +         !device_link_add(dev, smmu->dev,
>> +                     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>> +             dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
>> +                     dev_name(dev));
>> +             ret = -ENODEV;
>> +             goto out_unlink;
>> +     }
>> +
>>       return 0;
>>
>> +out_unlink:
>> +     iommu_device_unlink(&smmu->iommu, dev);
>> +     arm_smmu_master_free_smes(fwspec);
>>  out_cfg_free:
>>       kfree(cfg);
>>  out_free:
>>
>
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
