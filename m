Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364AEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB522087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB522087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeILWSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:18:31 -0400
Received: from foss.arm.com ([217.140.101.70]:36232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeILWSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:18:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 716587A9;
        Wed, 12 Sep 2018 10:13:03 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C69173F557;
        Wed, 12 Sep 2018 10:13:01 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
To:     Will Deacon <will.deacon@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <20180912165700.GC16071@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d0775377-206f-ae3e-051d-3b829b499471@arm.com>
Date:   Wed, 12 Sep 2018 18:12:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912165700.GC16071@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/18 17:57, Will Deacon wrote:
> Hi all,
> 
> On Wed, Aug 15, 2018 at 09:28:25AM +0800, Zhen Lei wrote:
>> v4 -> v5:
>> 1. change the type of global variable and struct member named "non_strict" from
>>     "int" to "bool".
>> 2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
>>     in v4.
>> 3. change boot option "arm_iommu" to "iommu.non_strict".
>> 4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
>>     non-leaf unmaps still need to be synchronous.
>>
>> Thanks for Robin's review comments.
> 
> Since this is 90% of the way there now, I suggest Robin picks up what's here
> and incorporates his remaining review comments directly (especially since it
> sounded like Zhen Lei hasn't got much free time lately). With that, I can
> queue this lot via my smmu branch, which already has some stuff queued
> for SMMUv3 and io-pgtable.
> 
> Please shout if you have any objections, but I'm keen for this not to
> languish on the lists given how close it is!

Sure, having got this far I'd like to see it get done too. I'll make 
some time and give it a go.

Robin.
