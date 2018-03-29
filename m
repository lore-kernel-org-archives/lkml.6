Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeC2SPu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:15:50 -0400
Received: from verein.lst.de ([213.95.11.211]:51632 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeC2SPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:15:46 -0400
Date: Thu, 29 Mar 2018 20:15:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: James Smart <james.smart@broadcom.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for
        requests
Message-ID: <20180329181545.GA16116@lst.de>
References: <20180329160721.4691-1-logang@deltatee.com> <20180329160721.4691-5-logang@deltatee.com> <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com> <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 11:02:10AM -0600, Logan Gunthorpe wrote:
> Per the bug in the previous patch, I don't think that was ever a valid
> assumption. It doesn't have anything to do with the sgl_alloc change
> either. The dma_map interface is allowed to merge SGLs and that's why it
> can return fewer nents than it was passed. I'm not sure how many or
> which DMA ops actually do this which is why it hasn't actually
> manifested itself as a bug; but it is part of how the interface is
> specified to work.

Most iommus can, it just is very unlikely do happen in block drivers
given that the block layer already merges segments higher up.
