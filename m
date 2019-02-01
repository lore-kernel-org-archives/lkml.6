Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB09BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF202084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfBAJEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:04:04 -0500
Received: from verein.lst.de ([213.95.11.211]:33810 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfBAJEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:04:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5CE5268CEC; Fri,  1 Feb 2019 10:04:02 +0100 (CET)
Date:   Fri, 1 Feb 2019 10:04:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] dma: debug: no need to check return value of
 debugfs_create functions
Message-ID: <20190201090402.GA16244@lst.de>
References: <20190122152151.16139-39-gregkh@linuxfoundation.org> <2b974ef1-4336-8187-cbc5-ba2a14691837@arm.com> <20190122184847.GA32627@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122184847.GA32627@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:48:47PM +0100, Greg Kroah-Hartman wrote:
> > Does this actually need to be at file scope, or could it be punted to a
> > local in dma_debug_fs_init() while we're here?
> 
> It can be moved to the function scope if you want me to, I was trying to
> do the least needed here :)

I've folded the scope move in when applying the patch to the
dma-mapping for-next tree.

Thanks!
