Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75077C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30873216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30873216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeI0V5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:57:24 -0400
Received: from foss.arm.com ([217.140.101.70]:36474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbeI0V5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:57:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BCF7A9;
        Thu, 27 Sep 2018 08:38:34 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EA033F5B3;
        Thu, 27 Sep 2018 08:38:33 -0700 (PDT)
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-4-hch@lst.de>
 <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
 <20180927153028.GD10566@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b98d7b2-bf74-ccc9-881a-a91e2c9949c3@arm.com>
Date:   Thu, 27 Sep 2018 16:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927153028.GD10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 16:30, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>>    +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64
>>> dma_mask,
>>> +		u64 *phys_mask)
>>> +{
>>> +	if (force_dma_unencrypted())
>>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>>> +	else
>>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>>
>> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can
>> reuse it here?
> 
> This is a dma_to_phys and not a phys_to_dma.

Ugh, clearly it's time to stop reviewing patches for today... sorry :(

Robin.
