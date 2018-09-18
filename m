Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F7ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CFF206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CFF206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeIRWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:12 -0400
Received: from foss.arm.com ([217.140.101.70]:48180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbeIRWnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11847A9;
        Tue, 18 Sep 2018 10:09:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1E4D3F5BD;
        Tue, 18 Sep 2018 10:09:41 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AC15F1AE1396; Tue, 18 Sep 2018 18:10:00 +0100 (BST)
Date:   Tue, 18 Sep 2018 18:10:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
Message-ID: <20180918171000.GI16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for turning this around so quickly.

On Fri, Sep 14, 2018 at 03:30:18PM +0100, Robin Murphy wrote:
> Since we'd like to get this polished up and merged and Leizhen has other
> commitments, here's v7 of the previous series[1] wherein I address all
> my own feedback :) This is a quick tweak of the v6 I sent yesterday
> since I figured out slightly too late a much neater way of setting the
> attribute at the appropriate time.
> 
> The principal change is that I've inverted things slightly such that
> it's now a generic domain attribute controlled by iommu-dma given the
> necessary support from individual IOMMU drivers. That way we can easily
> enable other drivers straight away, as I've done for SMMUv2 here (which
> also allowed me to give it a quick test with MMU-401s on a Juno board).
> Otherwise it's really just cosmetic cleanup and rebasing onto Will's
> pending SMMU queue.

I've been through and had a look, leaving some small comments on the patches
themselves. The only part I failed to figure out is how you tie the lifetime
of the flush queue to the lifetime of the domain so that the timer callback
can't fire after e.g. the DMA cookie has been freed. How does that work?

Cheers,

Will
