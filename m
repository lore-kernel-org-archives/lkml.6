Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D23ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AEE20844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hkwYLzXh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fm3skR9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AEE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeGPMNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:13:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeGPMNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:13:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8FD7606DB; Mon, 16 Jul 2018 11:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531741603;
        bh=jI/CjfNc2b+a913AMSyXTFA4nrLp6Jw7Yx2ZSUBlV7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hkwYLzXhn/qk1RMcjYNfdV5+g+7Uy6900Xb3zf9a+4g0E0r4GqhkU9QF6IT8GYPwj
         SgJVIW+crThVE26vwWqYMNWeRAACYqFd9XA+G58XUbYvg82VxOyaq8uaUSfqXo467z
         Og7Hzpb/KO7Refxwm6L39k/riltq4Y24oxF3Y+oU=
Received: from [10.79.40.153] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0887606DB;
        Mon, 16 Jul 2018 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531741600;
        bh=jI/CjfNc2b+a913AMSyXTFA4nrLp6Jw7Yx2ZSUBlV7s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fm3skR9oqFKy1vzEcvwL8rAvkL73lHeRk50M8ccSiZAG80u2Qfa8/Gn/VKksr59v6
         +bg6ywuQl/iYUrzTZ9hW93qH0YZm8c7xnSkO/d87Hz9wJlg2DSwdXEsLP4Yc3hoqFV
         SfwMbBgTb7UYKXc6sS2rmLUgzrs6TI7+w0vKsTHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0887606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        robh+dt <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
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
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org>
 <5179668.PHK6S3sxLu@aspire.rjw.lan>
 <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org>
 <CAFp+6iFTgEhPLYQEyBX_Fb0k3n0OzGhKuSoBNV5XzpD01+V8qw@mail.gmail.com>
 <CAJZ5v0iQ2wxsXvuaLK2M9a_Jwe_fnwR2Afrq_Oa8h0--Ch7-5g@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <93d16301-4bef-203f-24de-4d010de84b22@codeaurora.org>
Date:   Mon, 16 Jul 2018 17:16:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iQ2wxsXvuaLK2M9a_Jwe_fnwR2Afrq_Oa8h0--Ch7-5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2018 2:25 PM, Rafael J. Wysocki wrote:
> On Thu, Jul 12, 2018 at 2:41 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Hi Rafael,
>>
>>
>> On Wed, Jul 11, 2018 at 4:06 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> Hi Rafael,
>>>
>>>
>>>
>>> On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
>>>> On Sunday, July 8, 2018 7:34:12 PM CEST Vivek Gautam wrote:
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> Finally add the device link between the master device and
>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>> master needs it. This is done from add_device callback which gets
>>>>> called once when the master is added to the smmu.
>>>>>
>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>>> ---
>>>>>
>>>>>    - Change since v11
>>>>>      * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>>>>
>>>>>    drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>>>>    1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>> index 09265e206e2d..916cde4954d2 100644
>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>>>          iommu_device_link(&smmu->iommu, dev);
>>>>>    +     if (pm_runtime_enabled(smmu->dev) &&
>>>> Why does the creation of the link depend on whether or not runtime PM
>>>> is enabled for the MMU device?
>>>
>>> The main purpose of this device link is to handle the runtime PM
>>> synchronization
>>> between the supplier (iommu) and consumer (client devices, such as
>>> GPU/display).
>>> Moreover, the runtime pm is conditionally enabled for smmu devices that
>>> support
>>> such [1].
>> Is there something you would like me to modify in this patch?
> Not really, as long as you are sure that it is correct. :-)
>
> You need to remember, however, that if you add system-wide PM
> callbacks to the driver, the ordering between them and the client
> device callbacks during system-wide suspend matters as well.  Don't
> you need the link the ensure the correct system-wide suspend ordering
> too?

The fact that currently we handle clocks only through runtime pm callbacks,
would it be better to call runtime pm put/get in system-wide PM callbacks.
This would be same as i mentioned in the other thread.

Best regards
Vivek

> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

