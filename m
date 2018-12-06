Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5436C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B891020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLFSqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:46:30 -0500
Received: from verein.lst.de ([213.95.11.211]:58889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeLFSqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:46:30 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 856C468AA6; Thu,  6 Dec 2018 19:46:28 +0100 (CET)
Date:   Thu, 6 Dec 2018 19:46:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Message-ID: <20181206184628.GA30345@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com> <20181206142326.GA24642@lst.de> <9accc5fe-4aae-ff7d-a234-f27167c49614@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9accc5fe-4aae-ff7d-a234-f27167c49614@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:10:47PM +0000, Robin Murphy wrote:
> AFAICS the tmp list wasn't about locking as much as meaning that if 
> kzalloc() failed at any point, we can free the partial allocation and back 
> out without disturbing free_entries at all - that still makes sense to me 
> up until patch #8 where we embrace the "never free anything" paradigm and 
> rip out the final traces.
>
> That said, maybe I should just drop the refactoring of 
> dma_debug_resize_entries() now that I'm deleting it as part of the same 
> series anyway - then I guess I squash what's left of this patch into #4 and 
> bring forward some of the simplification from #8 to start with. Would that 
> be more agreeable?

Yes, I just noticed all this goes away toward the end anyway.  We can
either keep it as is, or just drop the intermediate step if that is
easy enough for you.
