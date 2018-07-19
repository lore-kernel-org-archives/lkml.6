Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F5DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EC520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbeGSN4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:56:38 -0400
Received: from verein.lst.de ([213.95.11.211]:33357 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbeGSN4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:56:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5EFBE68D43; Thu, 19 Jul 2018 15:16:19 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:16:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geoff Levand <geoff@infradead.org>
Cc:     Fredrik Noring <noring@nocrew.org>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180719131619.GA13129@lst.de>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com> <20180705193613.GA28905@lst.de> <20180715122826.GB2342@localhost.localdomain> <20180717145725.GA22109@lst.de> <20180717163330.GE2342@localhost.localdomain> <ac14e13b-82fb-c623-6dcb-4c944120eb24@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac14e13b-82fb-c623-6dcb-4c944120eb24@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:55:59PM -0700, Geoff Levand wrote:
> Hi,
> 
> On 07/17/2018 09:33 AM, Fredrik Noring wrote:
> >>> Here are three other regressions related to the coherent mask WARN_ON_ONCE:
> >>
> >> They are a pretty strong indication that yes, you should really set
> >> the coherent mask if you ever do coherent allocations..
> > 
> > I'm unfortunately unfamiliar with the USB drivers for the PS3. Geoff, what
> > do you think about setting a coherent mask?
> 
> I guess we need to add a dma_set_coherent_mask() call in the driver
> probe routines.  I'll send out a patch.

Yes, exactly!
