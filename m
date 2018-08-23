Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123F8208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123F8208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeHWRdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:33:23 -0400
Received: from verein.lst.de ([213.95.11.211]:54842 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbeHWRdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:33:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 52AF268E4C; Thu, 23 Aug 2018 16:05:25 +0200 (CEST)
Date:   Thu, 23 Aug 2018 16:05:25 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Message-ID: <20180823140525.GA26121@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com> <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com> <1534180089.3962.68.camel@synopsys.com> <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com> <1534963226.3962.215.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534963226.3962.215.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, given that I assume this is 4.20 material now, any chance we
could merge it through the dma-mapping tree?  I have some major changes
pending that would clash if done in a different tree, so I'd rather
get it all together.

> We check this flag in arch_dma_alloc (which are used in non-coherent case) to
> skip MMU mapping if we are advertised that consistency is not required.
> 
> So, actually we can get rid of this flag checking in arch_dma_alloc and 
> simply always do MMU mapping to enforce non-cachability and return
> non-cacheable memory even if DMA_ATTR_NON_CONSISTENT is passed.
> But I don't sure we want to do that.

I plan to kill this flag for 4.20 (or 4.20 at latest) in favor
of a better interface.  But your implementation looks ok, so I'm
fine with keeping it for now.
