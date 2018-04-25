Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeDYHJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:09:51 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:41545 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeDYHJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:09:47 -0400
X-Google-Smtp-Source: AIpwx48BYy2SVcIa550ZcPzkcugiNGbA74kbQPMGBGcGUSWLEaBSXNcUwU9NdZgHz02WLg2zBzzFeg==
Date: Wed, 25 Apr 2018 00:09:45 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] dma mapping fixes for 4.17-rc3
In-Reply-To: <20180425065930.GA16791@infradead.org>
Message-ID: <alpine.DEB.2.21.1804250009400.51102@chino.kir.corp.google.com>
References: <20180425052225.GA2350@infradead.org> <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com> <20180425065930.GA16791@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Christoph Hellwig wrote:

> On Tue, Apr 24, 2018 at 11:54:26PM -0700, David Rientjes wrote:
> > Shouldn't that test for dev->coherent_dma_mask < DMA_BIT_MASK(32) be more 
> > accurately <=? 
> 
> No, it should really be <.  The exactly 32-bit case is already covered
> with GFP_DMA32.  Eventualy it should be < 24-bit with a separate
> GFP_DMA32 case for > 32-bit && < 64-bit.  Takashi has been working on
> that, but it is 4.18 material.
> 

Ack, thanks.
