Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BA72086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIKLl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:41:29 -0400
Received: from verein.lst.de ([213.95.11.211]:41121 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeIKLl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:41:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED14D67357; Tue, 11 Sep 2018 08:48:02 +0200 (CEST)
Date:   Tue, 11 Sep 2018 08:48:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180911064802.GB6214@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com> <20180910154747.GA23578@lst.de> <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6f49f8-24ea-f166-9c58-aecb13df0418@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:06:40PM +0100, Robin Murphy wrote:
>>> Nits aside, this otherwise looks sane to me for factoring out the
>>> equivalent Xen and arm64 DMA ops cases.
>>
>> Like this? :)
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent
>
> Man, that's going to take me a *lot* of time to pick through. All those 
> horrendous subtleties that I barely remember!

The good thing is that if I remember correctly there is just a single
patch that (intentionally) changes behavior.  The rest is just
refactoring and moving code around.

Anyway, I want to get this series in now, and the kick off the swiotlb
discussion with Konread.  We might not even get to the iommu patches
for this merge window depending on how long it takes.
