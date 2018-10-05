Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA5EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E1120875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E1120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeJEOPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:15:01 -0400
Received: from verein.lst.de ([213.95.11.211]:59321 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbeJEOPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:15:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 351C767357; Fri,  5 Oct 2018 09:17:36 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:17:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        alexander.h.duyck@linux.intel.com,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Message-ID: <20181005071736.GA24011@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain> <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com> <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:13:26AM -0700, Alexander Duyck wrote:
> Thanks for the review.
> 
> - Alex
> 
> P.S. It looks like I forgot to add Christoph to the original mail
> since I had just copied the To and Cc from the original submission, so
> I added him to the Cc for this.

Yes, there was some oddness with replies appearing out of nowhere that
I couldn't understand in my jetlagged state yesterday.   Now thay I've
caught up on iommu list traffic it all makes sense now.  I've applied
this with an Acked-by for Robin added based on his reply.
