Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC70C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BAA20870
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BAA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441419AbeKXGUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:20:05 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388920AbeKXGUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:20:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BAC13618;
        Fri, 23 Nov 2018 11:34:25 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3A73F5CF;
        Fri, 23 Nov 2018 11:34:22 -0800 (PST)
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
To:     Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@lst.de>,
        john.stultz@linaro.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de> <20181114161239.GA29462@lst.de>
 <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
 <20181120092516.GC7270@lst.de> <20181123182715.GA21183@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c782a3d-cac4-954f-21e7-ef89147f0d56@arm.com>
Date:   Fri, 23 Nov 2018 19:34:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123182715.GA21183@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018-11-23 6:27 pm, Will Deacon wrote:
> Hi John,
> 
> On Tue, Nov 20, 2018 at 10:25:16AM +0100, Christoph Hellwig wrote:
>> On Mon, Nov 19, 2018 at 03:22:13PM -0800, John Stultz wrote:
>>>> +               sg->dma_address = dma_addr;
>>>>                  sg_dma_len(sg) = sg->length;
>>>>          }
>>>
>>> I know Robin has already replied with more detailed info, but just to
>>> close the loop as I'm finally home, applying this patch didn't seem to
>>> help with the IO hangs I'm seeing w/ HiKey960.
>>
>> If Robins observation is right this should fix the problem for you:
> 
> Please could you give this diff a try and let us know whether the problem
> persists with your board?

This is actually the exact same change that I ended up with in my 
fixes[1], which John has indeed confirmed.

(sorry, it's the thing I was telling you about the other day, but I 
neglected to include you on cc you when I sent the patches out the 
following morning)

Robin.

[1] https://lore.kernel.org/lkml/cover.1542812807.git.robin.murphy@arm.com/
