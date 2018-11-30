Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51238C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A57D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A57D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeK3Tui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:50:38 -0500
Received: from verein.lst.de ([213.95.11.211]:48908 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeK3Tui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:50:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 74C7F68BDF; Fri, 30 Nov 2018 09:42:03 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:42:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@gmx.us>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Message-ID: <20181130084203.GA19812@lst.de>
References: <20181130035456.1586-1-cai@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130035456.1586-1-cai@gmx.us>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>  /* allow architectures to override this if absolutely required */
>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
> +/* amount of DMA mappings on this driver is huge. */
> +#ifdef	HNS_ENET
> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
> +#else
>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>  #endif
> +#endif

How would this be defined in a header that leaks into this file?

I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
selectable config options, as I really don't want to collect hacks like
this.
