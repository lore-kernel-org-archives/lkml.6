Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E60C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5F320BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WpXHsceS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TfPPoEUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5F320BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeGKKkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:40:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKKkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:40:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 851C660591; Wed, 11 Jul 2018 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531305381;
        bh=B0AoWLUHxbP27BimviinUWlX+aoQV9JEDiBNdGGYtWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WpXHsceSZK7SC5E8rthLg+pam7J/wr0nVrAoXh275R4XvHqQSL9KMnhn8C+kYv3BR
         FnA7zzsD3/G4TFAhQ0XIiLTaqLohajOeRz7fmv8GBdyFbRN99VerRG2IMSR39WOKXj
         r+FzHBZF9a53HowR7MD3vMAE+0yCJOheRYfwfKd0=
Received: from [10.79.40.147] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 726386078C;
        Wed, 11 Jul 2018 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531305380;
        bh=B0AoWLUHxbP27BimviinUWlX+aoQV9JEDiBNdGGYtWc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TfPPoEUd+uGlFDNZKLvfcgtM1pC3MOLLlQYucjDG0XjBXNLu2pMBJy5GnXVgusHm8
         C9mBCYcM1gusEAqWwE2Ud78fdxeOU2KkVDQmaP/wcuMy3O1XFAK0mk3r/+gK44Dsvr
         t1Ag97/iGx7eXlp6B26MZz26J3AMtizwtrR4Ghjs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 726386078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v12 3/4] iommu/arm-smmu: Add the device_link between
 masters and smmu
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        robdclark@gmail.com, linux-pm@vger.kernel.org,
        freedreno@lists.freedesktop.org, sboyd@kernel.org,
        tfiga@chromium.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180708173413.1965-1-vivek.gautam@codeaurora.org>
 <20180708173413.1965-4-vivek.gautam@codeaurora.org>
 <5179668.PHK6S3sxLu@aspire.rjw.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <741cc78b-59a7-5289-e42f-1511ebedb15d@codeaurora.org>
Date:   Wed, 11 Jul 2018 16:06:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5179668.PHK6S3sxLu@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,


On 7/11/2018 3:23 PM, Rafael J. Wysocki wrote:
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
>>   - Change since v11
>>     * Replaced DL_FLAG_AUTOREMOVE flag with DL_FLAG_AUTOREMOVE_SUPPLIER.
>>
>>   drivers/iommu/arm-smmu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 09265e206e2d..916cde4954d2 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1461,8 +1461,20 @@ static int arm_smmu_add_device(struct device *dev)
>>   
>>   	iommu_device_link(&smmu->iommu, dev);
>>   
>> +	if (pm_runtime_enabled(smmu->dev) &&
> Why does the creation of the link depend on whether or not runtime PM
> is enabled for the MMU device?

The main purpose of this device link is to handle the runtime PM 
synchronization
between the supplier (iommu) and consumer (client devices, such as 
GPU/display).
Moreover, the runtime pm is conditionally enabled for smmu devices that 
support
such [1].
>
> What about system-wide PM and system shutdown?  Are they always guaranteed
> to happen in the right order without the link?

When there's no runtime PM, there's no clocks, and other resources to be 
handled.
So, we don't need device link for system-wide PM and system shutdown to 
work correctly.
That's the case with current arm-smmu driver.
Is it something that i am missing here?

[1] https://lkml.org/lkml/2018/3/8/775

Thanks
Vivek
>> +	    !device_link_add(dev, smmu->dev,
>> +			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
>> +		dev_err(smmu->dev, "Unable to add link to the consumer %s\n",
>> +			dev_name(dev));
>> +		ret = -ENODEV;
>> +		goto out_unlink;
>> +	}
>> +
>>   	return 0;
>>   
>> +out_unlink:
>> +	iommu_device_unlink(&smmu->iommu, dev);
>> +	arm_smmu_master_free_smes(fwspec);
>>   out_cfg_free:
>>   	kfree(cfg);
>>   out_free:
>>
>

