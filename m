Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDYCDH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 22:03:07 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35013 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeDYCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 22:03:02 -0400
X-Google-Smtp-Source: AIpwx4//d13D0aXVh+IjMIGwaRu4eGEFe3+x6le/8hsZ2BEl2ODHmwMXY4O0dSACuNJ7WqOWdxjz+w==
Subject: Re: [PATCH 2/5] ide: kill ide_toggle_bounce
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20180424181625.22410-1-hch@lst.de>
 <20180424181625.22410-3-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5aaca0d3-417f-57f3-969f-b4c777c3fd48@kernel.dk>
Date: Tue, 24 Apr 2018 20:02:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180424181625.22410-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/18 12:16 PM, Christoph Hellwig wrote:
> ide_toggle_bounce did select various strange block bounce limits, including
> not bouncing at all as soon as an iommu is present in the system.  Given
> that the dma_map routines now handle any required bounce buffering except
> for ISA DMA, and the ide code already must handle either ISA DMA or highmem
> at least for iommu equipped systems we can get rid of the block layer
> bounce limit setting entirely.

Pretty sure I was the one to add this code, when highmem page IO was
enabled about two decades ago...

Outside of DMA, the issue was that the PIO code could not handle
highmem. That's not the case anymore, so this should be fine.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
