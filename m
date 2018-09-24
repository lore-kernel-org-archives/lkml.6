Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27E2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AD4214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbeIXUiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:38:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728466AbeIXUiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:38:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 681935E8B92DA;
        Mon, 24 Sep 2018 22:35:34 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 24 Sep 2018
 22:35:27 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will.deacon@arm.com>, <thunder.leizhen@huawei.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1537458163.git.robin.murphy@arm.com>
 <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
 <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
 <61fb0f8f-a353-8ab6-f03d-b261da435c94@arm.com>
CC:     <linuxarm@huawei.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>, chenxiang <chenxiang66@hisilicon.com>
Message-ID: <796e20eb-a0bd-f559-6cf2-f97fddf0114e@huawei.com>
Date:   Mon, 24 Sep 2018 15:35:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <61fb0f8f-a353-8ab6-f03d-b261da435c94@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 12:03, Robin Murphy wrote:
> On 21/09/18 10:29, Robin Murphy wrote:
>> Hi John,
>>
>> On 2018-09-21 10:20 AM, John Garry wrote:
>>> On 20/09/2018 17:10, Robin Murphy wrote:
>>>> Hi all,
>>>>
>>>> Hopefully this is the last spin of the series - I've now dropped my
>>>> light
>>>> touch and fixed up all the various prose text, plus implemented the
>>>> proper
>>>> quirk support for short-descriptor because it's actually just a trivial
>>>> cut-and-paste job.
>>>>
>>>> Robin.
>>>>
>>>
>>> Hi Robin,
>>>
>>> JFYI, I'm trying to test this patchset to get some figures and
>>> provide a tested-by tag, but 4/8 seems to rely on
>>> "iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()" - more
>>> specifically, it seems to rely on the version which Will rewrote in
>>> your patch review, and I am not sure on what branch it exists on, if
>>> any.
>>
>> Sorry, I should have said this is based on Will's iommu/devel branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel
>
>
> FWIW I've now pushed out a complete branch here:
>
>   git://linux-arm.org/linux-rm iommu/non-strict
>

Cheers

So for my network test scenario I was getting a boost @ 250K vs 160K 
packet(s)/second with strict off/on

For NVMe single disk performance, I was getting a boost @ 582K vs 370K 
IOPS with strict off/on.

I wasn't seeing such a boost for other storage controller scenario 
(that's with 6 SSDs), with 776K vs 740K IOPS for strict off/on, but SMMU 
off was ~800K IOPS.

FWIW:
Tested-by: John Garry <john.garry@huawei.com>

Thanks,
John

>
> Robin.
>
> .
>


