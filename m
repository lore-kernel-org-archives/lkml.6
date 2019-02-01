Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8260204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfBAIML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:12:11 -0500
Received: from verein.lst.de ([213.95.11.211]:33572 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBAIMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:12:10 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C788668CEC; Fri,  1 Feb 2019 09:12:08 +0100 (CET)
Date:   Fri, 1 Feb 2019 09:12:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Message-ID: <20190201081208.GB15512@lst.de>
References: <20190131162424.10477-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131162424.10477-1-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 05:24:24PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The only reason why swiotlb_init_with_tbl() can fail is an
> allocation failure in the memblock_alloc() function. But
> this function just calls panic() in case it can't fulfill
> the request and never returns an error, therefore
> swiotlb_init_with_tbl() also never actually returns an
> error.

Please use up all 72 characters per line available in the commit log
format.

> -	io_tlb_list = memblock_alloc(
> +	io_tlb_list = memblock_alloc_nopanic(
>  				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
>  				PAGE_SIZE);

Mike just killed the _nopanic versions and made the normal ones not
panic.
