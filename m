Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5953ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A20F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A20F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbeIUPIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:08:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeIUPIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:08:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2B44CE2CE362C;
        Fri, 21 Sep 2018 17:20:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 17:20:29 +0800
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will.deacon@arm.com>, <thunder.leizhen@huawei.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1537458163.git.robin.murphy@arm.com>
CC:     <linuxarm@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
Date:   Fri, 21 Sep 2018 10:20:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2018 17:10, Robin Murphy wrote:
> Hi all,
>
> Hopefully this is the last spin of the series - I've now dropped my light
> touch and fixed up all the various prose text, plus implemented the proper
> quirk support for short-descriptor because it's actually just a trivial
> cut-and-paste job.
>
> Robin.
>

Hi Robin,

JFYI, I'm trying to test this patchset to get some figures and provide a 
tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix race 
handling in split_blk_unmap()" - more specifically, it seems to rely on 
the version which Will rewrote in your patch review, and I am not sure 
on what branch it exists on, if any.

Thanks,
John

>
> Robin Murphy (2):
>   iommu/io-pgtable-arm-v7s: Add support for non-strict mode
>   iommu/arm-smmu: Support non-strict mode
>
> Zhen Lei (5):
>   iommu/arm-smmu-v3: Implement flush_iotlb_all hook
>   iommu/dma: Add support for non-strict mode
>   iommu: Add "iommu.strict" command line option
>   iommu/io-pgtable-arm: Add support for non-strict mode
>   iommu/arm-smmu-v3: Add support for non-strict mode
>
>  .../admin-guide/kernel-parameters.txt         | 12 +++
>  drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
>  drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
>  drivers/iommu/dma-iommu.c                     | 32 ++++++-
>  drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
>  drivers/iommu/io-pgtable-arm.c                | 14 ++-
>  drivers/iommu/io-pgtable.h                    |  5 +
>  drivers/iommu/iommu.c                         | 23 +++++
>  include/linux/iommu.h                         |  1 +
>  9 files changed, 225 insertions(+), 55 deletions(-)
>


