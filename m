Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1374BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694D4206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbeLNSfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:35:13 -0500
Received: from verein.lst.de ([213.95.11.211]:49165 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeLNSfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:35:12 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EA32468DF1; Fri, 14 Dec 2018 19:35:09 +0100 (CET)
Date:   Fri, 14 Dec 2018 19:35:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Michal Simek <monstr@monstr.eu>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Message-ID: <20181214183509.GA5247@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de> <20181214181056.GA17941@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214181056.GA17941@ravnborg.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:10:56PM +0100, Sam Ravnborg wrote:
> Hi Christoph,
> 
> I stumbled upon this one:
> 
> #define __get_dma_pages(gfp_mask, order) \
>                 __get_free_pages((gfp_mask) | GFP_DMA, (order))

This isn't directly related to the dma mapping, but another place
that hides GFP_DMA allocations.  So no need for the treatment,
but we really should kill this obsfucating wrapper..
