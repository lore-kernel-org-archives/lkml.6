Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78393C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3AC2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3AC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeLGOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:09:13 -0500
Received: from verein.lst.de ([213.95.11.211]:35490 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeLGOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:09:12 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D3DD468AA6; Fri,  7 Dec 2018 15:09:10 +0100 (CET)
Date:   Fri, 7 Dec 2018 15:09:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
Message-ID: <20181207140910.GA23609@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org> <87sgz9jzsl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgz9jzsl.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > Ben / Michael,
> >
> > can we get this one queued up for 4.21 to prepare for the DMA work later
> > on?
> 
> I was hoping the PASEMI / NXP regressions could be solved before
> merging.
> 
> My p5020ds is booting fine with this series, so I'm not sure why it's
> causing problems on Christian's machine.
> 
> The last time I turned on my PASEMI board it tripped some breakers, so I
> need to investigate that before I can help test that.
> 
> I'll see how things look on Monday and either merge the commits you
> identified or the whole series depending on if there's any more info
> from Christian.

Christian just confirmed everything up to at least
"powerpc/dma: stop overriding dma_get_required_mask" works for his
setups.
