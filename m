Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77467C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2A20685
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC2A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeHAMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:05:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbeHAMFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:05:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 228AC80D;
        Wed,  1 Aug 2018 03:20:18 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3004A3F5BA;
        Wed,  1 Aug 2018 03:20:16 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA838755908@FRAEML521-MBX.china.huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2cd649f9-129c-84eb-aa85-bc7615409158@arm.com>
Date:   Wed, 1 Aug 2018 11:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838755908@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 01/08/18 09:52, Shameerali Kolothum Thodi wrote:
> Hi Lorenzo/Robin,
> 
> Just a  gentle ping on this series. This is a v2 for smmu pmcg support
> based on Neil Leeder's v1[1].

Thanks for picking this up - it's not gone unnoticed ;)

It'll take me a while to page all this stuff back in, so given where we 
are in the cycle I was planning to review it once rc1 is out, hope 
that's OK.

Cheers,
Robin.

> Main changes include,
> -an helper function to IORT to retrieve the associated SMMU info.
> -MSI support to the PMU driver.
> 
> Please take a look and let me know your thoughts.
> 
> Thanks,
> Shameer
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
> 
>> -----Original Message-----
>> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
>> Shameer Kolothum
>> Sent: 24 July 2018 12:45
>> To: lorenzo.pieralisi@arm.com; robin.murphy@arm.com
>> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
>> neil.m.leeder@gmail.com; pabba@codeaurora.org; will.deacon@arm.com;
>> rruigrok@codeaurora.org; Linuxarm <linuxarm@huawei.com>; linux-
>> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
>>
>> This adds a driver for the SMMUv3 PMU into the perf framework.
>> It includes an IORT update to support PM Counter Groups.
>>
>> This is based on the initial work done by Neil Leeder[1]
>>
>> SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
>> denotes the associated smmuv3 dev id(if any) and y denotes the
>> pmu dev id.
>>
>> Usage example:
>> For common arch supported events:
>> perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
>>   filter_span=1,filter_stream_id=0x42/ -a pwd
>>
>> For IMP DEF events:
>> perf stat -e arm_smmu_v3.0_pmcg.6/event=id/ -a pwd
>>
>> Sanity tested on HiSilicon platform. Further testing on supported
>> platforms are very much welcome.
>>
>> v1 --> v2
>>
>> - Addressed comments from Robin.
>> - Added an helper to retrieve the associated smmu dev and named PMUs
>>    to make the association visible to user.
>> - Added MSI support  for overflow irq
>>
>> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
>>
>> Neil Leeder (2):
>>    acpi: arm64: add iort support for PMCG
>>    perf: add arm64 smmuv3 pmu driver
>>
>> Shameer Kolothum (2):
>>    acpi: arm64: iort helper to find the associated smmu of pmcg node
>>    perf/smmuv3: Add MSI irq support
>>
>>   drivers/acpi/arm64/iort.c     | 179 +++++++--
>>   drivers/perf/Kconfig          |   9 +
>>   drivers/perf/Makefile         |   1 +
>>   drivers/perf/arm_smmuv3_pmu.c | 901
>> ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi_iort.h     |   4 +
>>   5 files changed, 1063 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/perf/arm_smmuv3_pmu.c
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> Linuxarm mailing list
>> Linuxarm@huawei.com
>> http://hulk.huawei.com/mailman/listinfo/linuxarm
