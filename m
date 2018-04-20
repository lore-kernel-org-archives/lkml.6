Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbeDTIb5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:31:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeDTIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:31:56 -0400
Date: Fri, 20 Apr 2018 01:31:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, thomas.petazzoni@free-electrons.com,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180420083147.GC31275@infradead.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org>
 <20180418131314.GC3999@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418131314.GC3999@w540>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:13:14PM +0200, jacopo mondi wrote:
> As long as it goes for arch/sh, the only user of dma_alloc_coherent()
> is platform_resource_setup_memory(), and it has been fixed by this
> patch.

Great!

> 
> Unfortunately, as Thomas pointed out, there are drivers which calls
> into this with the wrong 'struct device' as the sh_eth one he had fixed.

Yes, we'll need fixes there.  Other DMA ops implementations also look
at struct device, so they generally are buggy.

> I would then say that as long as it goes for the NULL case, we should be
> fine now.

Then I'd say skil that part, please.
