Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D7F20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D7F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeLBDtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:49:53 -0500
Received: from verein.lst.de ([213.95.11.211]:56673 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeLBDtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:49:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DE3DC67358; Sat,  1 Dec 2018 17:36:57 +0100 (CET)
Date:   Sat, 1 Dec 2018 17:36:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Qian Cai <cai@gmx.us>, hch@lst.de, m.szyprowski@samsung.com,
        netdev@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Message-ID: <20181201163657.GA19557@lst.de>
References: <20181130175449.2625-1-cai@gmx.us> <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 07:39:50PM +0000, Robin Murphy wrote:
> I was assuming the point was to also add something like
>
> 	default 131072 if HNS_ENET
>
> so that DMA debug doesn't require too much thought from the user. If they 
> still have to notice the overflow message and empirically figure out a 
> value that does work, rebuilding the kernel each time is far less 
> convenient than simply adding "dma_debug_entries=..." to their kernel 
> command line and rebooting, which they can do today. If they do already 
> know up-front that the default will need overriding and what the 
> appropriate value is, then the command line still seems seems just as 
> convenient.

I'm not so fond of random drivers changing the defaults.  My idea
was rather to have the config option so that the defconfig files for
the Hisilicon SOCs with this hardware could select a larger number
without making a total mess of the kernel configuration.

If we really have to we could do different defaults, but I'd still
much rather do this on a arch/platform basis than specific drivers.
