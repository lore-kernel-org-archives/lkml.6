Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CA421104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPdoRPS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CA421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeK1Him (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1Him (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:38:42 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D21E2086B;
        Tue, 27 Nov 2018 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543351175;
        bh=yLd2nfy4qtwb2SdXct2fRtVjJ2pcy5XMOMinZalk3eY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HPdoRPS6CtlRe5kzFGvZjFxAOcwZszT422tLyVBoKz2xsK8lJ4SCMtQQDcLiRrPWI
         2lbZk+nR18wln6Sbl5nD9yKKSLAqsHo4oI/bcbA9Ntn1xihHv/usklqcGKfxXqgXyu
         nlQuaGD83jVME/SRTjkh50AaG2qWAInCZbyELiXA=
Date:   Tue, 27 Nov 2018 12:39:33 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Stefano Stabellini <sstabellini@kernel.org>
cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
In-Reply-To: <alpine.DEB.2.10.1811271106460.4577@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1811271239080.4577@sstabellini-ThinkPad-X260>
References: <cover.1542722463.git.robin.murphy@arm.com> <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com> <20181121130331.GA1373@lst.de> <20181121151133.GC26925@char.us.oracle.com>
 <alpine.DEB.2.10.1811271106460.4577@sstabellini-ThinkPad-X260>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Stefano Stabellini wrote:
> On Wed, 21 Nov 2018, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > Konrad, are you ok with me picking up both through the dma-mapping
> > > > > tree?
> > > > 
> > > > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> > > 
> > > Stefano, can you take a look asap?  This is a pretty trivial fix for
> > > a nasty bug that breaks boot on real life systems.  I'd like to merge
> > > it by tomorrow so that I can send it off to Linus for the next rc
> > > (I will be offline for about two days after Friday morning)
> > 
> > It is Turkey Day in US so he may be busy catching those pesky turkeys.
> > How about Tuesday? And in can also send the GIT PULL.
> 
> I have just come back to the office. I'll give it a look today.

Everything looks good to me, thanks for keeping me in the loop.
