Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58BFC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A125221019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfAURmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:42:15 -0500
Received: from verein.lst.de ([213.95.11.211]:59865 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfAURmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:42:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CF1D468DD6; Mon, 21 Jan 2019 18:42:13 +0100 (CET)
Date:   Mon, 21 Jan 2019 18:42:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
Message-ID: <20190121174213.GA31247@lst.de>
References: <20190119000559.12784-1-logang@deltatee.com> <20190119094002.GA21653@lst.de> <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:46:22AM -0700, Logan Gunthorpe wrote:
> > Instead of having two tiny wrappers I'd just revert
> > 964f2311a6862f1fbcc044d0828ad90030928b7f if we need to pass a real
> > physical address now.
> 
> Ok, I can resubmit this with that cleanup. Should I do it in two commits
> (1 revert + 1 new) or is one commit that just restores the original
> helper fine?

I think a single commit is fine.
