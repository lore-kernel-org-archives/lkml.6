Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeDTIar (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:30:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeDTIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:30:45 -0400
Date: Fri, 20 Apr 2018 01:30:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, thomas.petazzoni@free-electrons.com,
        robin.murphy@arm.com, geert@linux-m68k.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-ID: <20180420083032.GB31275@infradead.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180417155407.49c981b3@windsurf.numericable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417155407.49c981b3@windsurf.numericable.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 03:54:07PM +0200, Thomas Petazzoni wrote:
> 
>   dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
> 
> and one to switch to the WARN_ON + if(dev) model. But I don't really
> care either way, so:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Yes, these should be separate patches.  And I actually hope we can
do with the NULL dev check, but that is a different sub-thread.
