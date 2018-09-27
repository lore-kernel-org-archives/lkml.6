Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD20FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B25216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B25216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI0WAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:00:09 -0400
Received: from verein.lst.de ([213.95.11.211]:45978 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbeI0WAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:00:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E6D8B68B02; Thu, 27 Sep 2018 17:41:17 +0200 (CEST)
Date:   Thu, 27 Sep 2018 17:41:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Message-ID: <20180927154117.GA10956@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-4-hch@lst.de> <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com> <20180927153028.GD10566@lst.de> <2b98d7b2-bf74-ccc9-881a-a91e2c9949c3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b98d7b2-bf74-ccc9-881a-a91e2c9949c3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:38:31PM +0100, Robin Murphy wrote:
> On 27/09/18 16:30, Christoph Hellwig wrote:
>> On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>>>    +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64
>>>> dma_mask,
>>>> +		u64 *phys_mask)
>>>> +{
>>>> +	if (force_dma_unencrypted())
>>>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>>>> +	else
>>>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>>>
>>> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can
>>> reuse it here?
>>
>> This is a dma_to_phys and not a phys_to_dma.
>
> Ugh, clearly it's time to stop reviewing patches for today... sorry :(

I actually made the same mistake when writing it..

ALthough I'd really like to see some feedback from you on the arm64
swiotlb series once you had more cofee ;-)
