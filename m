Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E456BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfBAQNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:13:08 -0500
Received: from verein.lst.de ([213.95.11.211]:35680 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727619AbfBAQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:13:07 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2209068D93; Fri,  1 Feb 2019 17:13:06 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:13:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Message-ID: <20190201161305.GI6532@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-3-hch@lst.de> <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:47:17PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
>> includes unconditionally so users can rely on it, and add a missing
>> comment describing the #else cpp statement.  Last but not least include
>> <linux/errno.h> instead of the asm version, which is frowned upon.
>
> I think the __KERNEL__ and asm/errno.h slip-ups are things I cargo-culted 
> from the arch code as a fresh-faced noob yet to learn the finer details, so 
> ack for those parts. The forward-declarations, though, were a deliberate 
> effort to minimise header dependencies and compilation bloat for includers 
> who absolutely wouldn't care, and specifically to try to avoid setting 
> transitive include expectations since they always seem to end up breaking 
> someone's config somewhere down the line. Admittedly this little backwater 
> is hardly comparable to the likes of the sched.h business, but I'm still 
> somewhat on the fence about that change :/

As far as I can tell almost all users of linux/dma-iommu.h require
CONFIG_DMA_IOMMU to be enabled anyway..
