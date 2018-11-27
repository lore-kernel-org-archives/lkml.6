Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE31213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T//K40lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE31213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeK1GF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbeK1GF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:05:59 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA46208E4;
        Tue, 27 Nov 2018 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543345627;
        bh=EFbUX/+QbKlmImNyhvR4virVWpme3C9XerBHJvkUqxc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=T//K40lQ0unSDia43k0tL33STeLit2UU8xWYe+z57CEggQ5BkHIe2lCjX6rbOjVFM
         ZywjIfV8tJBlQxqWZ2HxY2DrMtom0sG+4CffVLy+MUY3DQ/DKe1B50y07CjDTyhXMd
         UnSWT8qe/FHS/ho7Q80Ibux+5sb/8NVA4U9CUPI8=
Date:   Tue, 27 Nov 2018 11:07:04 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
In-Reply-To: <20181121151133.GC26925@char.us.oracle.com>
Message-ID: <alpine.DEB.2.10.1811271106460.4577@sstabellini-ThinkPad-X260>
References: <cover.1542722463.git.robin.murphy@arm.com> <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com> <20181121130331.GA1373@lst.de> <20181121151133.GC26925@char.us.oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Konrad Rzeszutek Wilk wrote:
> On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > > Konrad, are you ok with me picking up both through the dma-mapping
> > > > tree?
> > > 
> > > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> > 
> > Stefano, can you take a look asap?  This is a pretty trivial fix for
> > a nasty bug that breaks boot on real life systems.  I'd like to merge
> > it by tomorrow so that I can send it off to Linus for the next rc
> > (I will be offline for about two days after Friday morning)
> 
> It is Turkey Day in US so he may be busy catching those pesky turkeys.
> How about Tuesday? And in can also send the GIT PULL.

I have just come back to the office. I'll give it a look today.
