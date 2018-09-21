Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CBECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310642086B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310642086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbeIUQwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:52:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389651AbeIUQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:52:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B452480D;
        Fri, 21 Sep 2018 04:03:55 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1155A3F557;
        Fri, 21 Sep 2018 04:03:53 -0700 (PDT)
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
From:   Robin Murphy <robin.murphy@arm.com>
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, huawei.libin@huawei.com, guohanjun@huawei.com
References: <cover.1537458163.git.robin.murphy@arm.com>
 <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
 <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
Message-ID: <61fb0f8f-a353-8ab6-f03d-b261da435c94@arm.com>
Date:   Fri, 21 Sep 2018 12:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/18 10:29, Robin Murphy wrote:
> Hi John,
> 
> On 2018-09-21 10:20 AM, John Garry wrote:
>> On 20/09/2018 17:10, Robin Murphy wrote:
>>> Hi all,
>>>
>>> Hopefully this is the last spin of the series - I've now dropped my 
>>> light
>>> touch and fixed up all the various prose text, plus implemented the 
>>> proper
>>> quirk support for short-descriptor because it's actually just a trivial
>>> cut-and-paste job.
>>>
>>> Robin.
>>>
>>
>> Hi Robin,
>>
>> JFYI, I'm trying to test this patchset to get some figures and provide 
>> a tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix 
>> race handling in split_blk_unmap()" - more specifically, it seems to 
>> rely on the version which Will rewrote in your patch review, and I am 
>> not sure on what branch it exists on, if any.
> 
> Sorry, I should have said this is based on Will's iommu/devel branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel 

FWIW I've now pushed out a complete branch here:

   git://linux-arm.org/linux-rm iommu/non-strict


Robin.
