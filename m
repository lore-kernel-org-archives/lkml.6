Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDCE2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDCE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeIKLkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:40:02 -0400
Received: from verein.lst.de ([213.95.11.211]:41115 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeIKLkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:40:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B854F67357; Tue, 11 Sep 2018 08:46:36 +0200 (CEST)
Date:   Tue, 11 Sep 2018 08:46:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180911064636.GA6214@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <20180910161350.GA10380@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910161350.GA10380@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 06:13:50PM +0200, Greg Kroah-Hartman wrote:
> > +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> > +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > +	bool			dma_coherent:1;
> > +#endif
> 
> It's just one bit, why not always have it enabled here?  If the arch
> uses it or doesn't, no big deal.
> 
> Or are you using this to "catch" arches that mess something up?

Yes, that is the intent - I don't want architectures to accidentally
set it while not selecting the non-coherent infrastructure, as it
won't have an effect.
