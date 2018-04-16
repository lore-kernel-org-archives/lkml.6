Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754383AbeDPI4Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:56:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754217AbeDPI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:56:22 -0400
Date: Mon, 16 Apr 2018 01:56:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Thelen <gthelen@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Subject: Re: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Message-ID: <20180416085620.GA30363@infradead.org>
References: <20180413070644.11974-1-gthelen@google.com>
 <20180415120636.GA10759@infradead.org>
 <CAHH2K0ZKqDt2OS1RN7i6qqc=VyPfhzC5sfSSb4ktDdtZnzAhCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHH2K0ZKqDt2OS1RN7i6qqc=VyPfhzC5sfSSb4ktDdtZnzAhCA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 04:02:12AM +0000, Greg Thelen wrote:
> I think I've identified the set of options which use
> INFINIBAND_ADDR_TRANS without a kconfig depends:
> * CIFS_SMB_DIRECT
> * INFINIBAND_SRPT
> * NVME_RDMA
> * NVME_TARGET_RDMA
> 
> I have patches for the above, but need to finish the commit logs.  Let me
> know if they'll be nacked and I'll just patch my kernel and forget
> upstreaming.

I think those are what is needed.  But better do a full cycle through
the build bot first..

Btw, should we rename the config symbol to something containing
RDMACM?  The current name seems rather confusing?
