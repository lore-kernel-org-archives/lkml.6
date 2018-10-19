Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E11721476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E11721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJSOJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:09:01 -0400
Received: from verein.lst.de ([213.95.11.211]:43404 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbeJSOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:09:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D0D1468C76; Fri, 19 Oct 2018 08:04:25 +0200 (CEST)
Date:   Fri, 19 Oct 2018 08:04:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
Message-ID: <20181019060425.GA28108@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-4-hch@lst.de> <20181019001714.GD1251@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019001714.GD1251@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:17:14PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 08, 2018 at 10:02:39AM +0200, Christoph Hellwig wrote:
> > All properly written drivers now have error handling in the
> > dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> > prints a useful warning when running out of swiotlb pool swace we can
> 
> s/swace/space/
> 
> > also remove swiotlb_full entirely as it serves no purpose now.
> 
> The panic albeit was useful for those drivers that didn't handle it.
> 
> Thoughts? I am kind of thinking screw them but then I am not too thrilled
> about silent data corruption errors.

I can add an (optional) panic back in common code so that the different
mapping types are covered.

Btw, are you fine with taking this through the dma mapping tree for
this merge window?  I'd probably leave it in linux-next for another
week or so and don't send it with the first pull request on Monday.
