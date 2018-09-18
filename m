Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA9DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D752150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D752150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeISACX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:02:23 -0400
Received: from foss.arm.com ([217.140.101.70]:49270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbeISACX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:02:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F402ED1;
        Tue, 18 Sep 2018 11:28:33 -0700 (PDT)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD9C3F703;
        Tue, 18 Sep 2018 11:28:29 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1536935328.git.robin.murphy@arm.com>
 <20180918171000.GI16498@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <139139a7-a769-006c-2cb7-491cc69379c8@arm.com>
Date:   Tue, 18 Sep 2018 19:28:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918171000.GI16498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018-09-18 6:10 PM, Will Deacon wrote:
> Hi Robin,
> 
> Thanks for turning this around so quickly.

Cheers for a pretty rapid review too :)

> On Fri, Sep 14, 2018 at 03:30:18PM +0100, Robin Murphy wrote:
>> Since we'd like to get this polished up and merged and Leizhen has other
>> commitments, here's v7 of the previous series[1] wherein I address all
>> my own feedback :) This is a quick tweak of the v6 I sent yesterday
>> since I figured out slightly too late a much neater way of setting the
>> attribute at the appropriate time.
>>
>> The principal change is that I've inverted things slightly such that
>> it's now a generic domain attribute controlled by iommu-dma given the
>> necessary support from individual IOMMU drivers. That way we can easily
>> enable other drivers straight away, as I've done for SMMUv2 here (which
>> also allowed me to give it a quick test with MMU-401s on a Juno board).
>> Otherwise it's really just cosmetic cleanup and rebasing onto Will's
>> pending SMMU queue.
> 
> I've been through and had a look, leaving some small comments on the patches
> themselves. The only part I failed to figure out is how you tie the lifetime
> of the flush queue to the lifetime of the domain so that the timer callback
> can't fire after e.g. the DMA cookie has been freed. How does that work?

Er, to be honest I haven't looked or even considered it! Other than the 
parts I've massaged I kinda took the functionality of the previous 
series for granted. Let me cross-check the x86 code and figure it out.

Robin.
