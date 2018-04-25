Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeDYGyc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:54:32 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:43331 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeDYGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:54:28 -0400
X-Google-Smtp-Source: AIpwx48L4cb7rrKkcYrVw2cBhocZ683jlGv2ekkQjY781nnO7gkqPaBPZj36W2eeIYzKX9DJz5dgiw==
Date: Tue, 24 Apr 2018 23:54:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] dma mapping fixes for 4.17-rc3
In-Reply-To: <20180425052225.GA2350@infradead.org>
Message-ID: <alpine.DEB.2.21.1804242352290.51102@chino.kir.corp.google.com>
References: <20180425052225.GA2350@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Christoph Hellwig wrote:

> The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:
> 
>   Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-3
> 
> for you to fetch changes up to 60695be2bb6b0623f8e53bd9949d582a83c6d44a:
> 
>   dma-mapping: postpone cpu addr translation on mmap (2018-04-23 14:44:24 +0200)
> 
> ----------------------------------------------------------------
> A few small dma-mapping fixes for Linux 4.17-rc3:
> 
>  - don't loop to try GFP_DMA allocations if ZONE_DMA is not actually
>    enabled (regression in 4.16)

Shouldn't that test for dev->coherent_dma_mask < DMA_BIT_MASK(32) be more 
accurately <=? 
