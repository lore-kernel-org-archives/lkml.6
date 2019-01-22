Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA1DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7950120879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfAVFnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:43:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46442 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVFnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDD37A78;
        Mon, 21 Jan 2019 21:43:40 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C31E3F6A8;
        Mon, 21 Jan 2019 21:43:39 -0800 (PST)
Date:   Tue, 22 Jan 2019 05:43:28 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Message-ID: <20190122054326.GA6445@brain-police>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
 <20190120000117.GH26876@brain-police>
 <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:35:30AM +0530, Vivek Gautam wrote:
> On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > > Adding a device tree option for arm smmu to enable non-cacheable
> > > memory for page tables.
> > > We already enable a smmu feature for coherent walk based on
> > > whether the smmu device is dma-coherent or not. Have an option
> > > to enable non-cacheable page table memory to force set it for
> > > particular smmu devices.
> >
> > Hmm, I must be missing something here. What is the difference between this
> > new property, and simply omitting dma-coherent on the SMMU?
> 
> So, this is what I understood from the email thread for Last level
> cache support -
> Robin pointed to the fact that we may need to add support for setting
> non-cacheable
> mappings in the TCR.
> Currently, we don't do that for SMMUs that omit dma-coherent.
> We rely on the interconnect to handle the configuration set in TCR,
> and let interconnect
> ignore the cacheability if it can't support.

I think that's a bug. With that fixed, can you get what you want by omitting
"dma-coherent"?

Will
