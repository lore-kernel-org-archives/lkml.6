Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E91C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9313208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9313208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbeIUPRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:17:47 -0400
Received: from foss.arm.com ([217.140.101.70]:59488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUPRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:17:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5930ED1;
        Fri, 21 Sep 2018 02:29:47 -0700 (PDT)
Received: from [10.1.26.186] (desktop-vlo843j.cambridge.arm.com [10.1.26.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5573F5C0;
        Fri, 21 Sep 2018 02:29:45 -0700 (PDT)
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com
References: <cover.1537458163.git.robin.murphy@arm.com>
 <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
Date:   Fri, 21 Sep 2018 10:29:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018-09-21 10:20 AM, John Garry wrote:
> On 20/09/2018 17:10, Robin Murphy wrote:
>> Hi all,
>>
>> Hopefully this is the last spin of the series - I've now dropped my light
>> touch and fixed up all the various prose text, plus implemented the 
>> proper
>> quirk support for short-descriptor because it's actually just a trivial
>> cut-and-paste job.
>>
>> Robin.
>>
> 
> Hi Robin,
> 
> JFYI, I'm trying to test this patchset to get some figures and provide a 
> tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix race 
> handling in split_blk_unmap()" - more specifically, it seems to rely on 
> the version which Will rewrote in your patch review, and I am not sure 
> on what branch it exists on, if any.

Sorry, I should have said this is based on Will's iommu/devel branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel

Robin.

> 
> Thanks,
> John
> 
>>
>> Robin Murphy (2):
>>   iommu/io-pgtable-arm-v7s: Add support for non-strict mode
>>   iommu/arm-smmu: Support non-strict mode
>>
>> Zhen Lei (5):
>>   iommu/arm-smmu-v3: Implement flush_iotlb_all hook
>>   iommu/dma: Add support for non-strict mode
>>   iommu: Add "iommu.strict" command line option
>>   iommu/io-pgtable-arm: Add support for non-strict mode
>>   iommu/arm-smmu-v3: Add support for non-strict mode
>>
>>  .../admin-guide/kernel-parameters.txt         | 12 +++
>>  drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
>>  drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
>>  drivers/iommu/dma-iommu.c                     | 32 ++++++-
>>  drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
>>  drivers/iommu/io-pgtable-arm.c                | 14 ++-
>>  drivers/iommu/io-pgtable.h                    |  5 +
>>  drivers/iommu/iommu.c                         | 23 +++++
>>  include/linux/iommu.h                         |  1 +
>>  9 files changed, 225 insertions(+), 55 deletions(-)
>>
> 
> 
