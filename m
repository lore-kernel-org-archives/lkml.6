Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA16C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81872205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81872205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeK0G0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:26:34 -0500
Received: from foss.arm.com ([217.140.101.70]:45926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0G0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:26:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 699111A25;
        Mon, 26 Nov 2018 11:31:26 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 385ED3F5AF;
        Mon, 26 Nov 2018 11:31:26 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id ACD1D1AE0839; Mon, 26 Nov 2018 19:31:43 +0000 (GMT)
Date:   Mon, 26 Nov 2018 19:31:43 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, john.stultz@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Message-ID: <20181126193142.GA534@arm.com>
References: <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de>
 <20181114161239.GA29462@lst.de>
 <CALAqxLVMW2sYkaQvggZ-LhvkzpuF2rssQJ4thZkkAkROk=wVVw@mail.gmail.com>
 <20181120092516.GC7270@lst.de>
 <20181123182715.GA21183@arm.com>
 <1c782a3d-cac4-954f-21e7-ef89147f0d56@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c782a3d-cac4-954f-21e7-ef89147f0d56@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Nov 23, 2018 at 07:34:15PM +0000, Robin Murphy wrote:
> On 2018-11-23 6:27 pm, Will Deacon wrote:
> >On Tue, Nov 20, 2018 at 10:25:16AM +0100, Christoph Hellwig wrote:
> >>On Mon, Nov 19, 2018 at 03:22:13PM -0800, John Stultz wrote:
> >>>>+               sg->dma_address = dma_addr;
> >>>>                 sg_dma_len(sg) = sg->length;
> >>>>         }
> >>>
> >>>I know Robin has already replied with more detailed info, but just to
> >>>close the loop as I'm finally home, applying this patch didn't seem to
> >>>help with the IO hangs I'm seeing w/ HiKey960.
> >>
> >>If Robins observation is right this should fix the problem for you:
> >
> >Please could you give this diff a try and let us know whether the problem
> >persists with your board?
> 
> This is actually the exact same change that I ended up with in my fixes[1],
> which John has indeed confirmed.
> 
> (sorry, it's the thing I was telling you about the other day, but I
> neglected to include you on cc you when I sent the patches out the following
> morning)

Thanks, I missed that series. I'll forget all about this problem then!

Will
