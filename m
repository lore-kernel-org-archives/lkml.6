Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF004C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09F0206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09F0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeLDO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:27:32 -0500
Received: from verein.lst.de ([213.95.11.211]:44068 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeLDO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:27:32 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 27AF868BF4; Tue,  4 Dec 2018 15:27:31 +0100 (CET)
Date:   Tue, 4 Dec 2018 15:27:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH 2/4] dma-debug: Refactor dma_debug_entry allocation
Message-ID: <20181204142731.GB2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:28:07PM +0000, Robin Murphy wrote:
> Make prealloc_memory() a little more general and robust so that it
> serves for runtime reallocations too. The first thing we can do with
> that is clean up dma_debug_resize_entries() quite a bit.

Maybe also renamed it to dma_debug_alloc_entries or something like
that?

Otherwise this looks fine to me.
