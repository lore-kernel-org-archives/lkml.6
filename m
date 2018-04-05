Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeDEQPk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:15:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:15:38 -0400
Date: Thu, 5 Apr 2018 09:15:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: Christoph Hellwig <hch@infradead.org>, sgoutham@cavium.com,
        sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, dnelson@redhat.com,
        gustavo@embeddedor.com, Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH] net: thunderx: rework mac addresses list to u64 array
Message-ID: <20180405161534.GA18042@infradead.org>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180405150748.GA5716@infradead.org>
 <20180405160749.GB12703@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405160749.GB12703@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:07:49AM -0700, Vadim Lomovtsev wrote:
> > 
> > > +				mc_list = kmalloc(sizeof(*mc_list) +
> > > +						  sizeof(u64) * netdev_mc_count(netdev),
> > > +						  GFP_ATOMIC);
> > 
> > kmalloc_array(), please.
> 
> In this case it would require two memory allocation calls to kmalloc() for
> xcast_addr_list struct and to kmalloc_array() for 'mc' addresses, becasue of
> different data types and so two null-ptr checks .. this is what I'd like get rid off.
> 
> My idea of this was to keep number of array elements and themselves within the
> same memory block/page to reduce number of memory allocation requests, number
> of allocated pages/blocks and avoid possible memory fragmentation (however, I believe
> the latter is already handled at the mm layer).

Indeed, lets keep it as-is.
