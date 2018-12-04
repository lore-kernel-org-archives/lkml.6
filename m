Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD2DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBE82082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBE82082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeLDORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:17:46 -0500
Received: from verein.lst.de ([213.95.11.211]:43980 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbeLDORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:17:45 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BF60C68BDB; Tue,  4 Dec 2018 15:17:43 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:17:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, hch@lst.de,
        m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Message-ID: <20181204141743.GA2618@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com> <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com> <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70336fdc-abe8-2cea-8d8c-170b4863d884@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:11:37PM +0000, Robin Murphy wrote:
> In fact, having got this far in, what I'd quite like to do is to get rid of 
> dma_debug_resize_entries() such that we never need to free things at all, 
> since then we could allocate whole pages as blocks of entries to save on 
> masses of individual slab allocations.

Yes, we should defintively kill dma_debug_resize_entries.  Allocating
page batches might sound nice, but is that going to introduce additional
complexity?
