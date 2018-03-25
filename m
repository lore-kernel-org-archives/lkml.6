Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeCYX4K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 19:56:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCYX4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 19:56:07 -0400
Date: Sun, 25 Mar 2018 16:56:03 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] mm: Add free()
Message-ID: <20180325235603.GA18737@bombadil.infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
 <20180322195819.24271-4-willy@infradead.org>
 <6fd1bba1-e60c-e5b3-58be-52e991cda74f@virtuozzo.com>
 <20180323151421.GC5624@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323151421.GC5624@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 08:14:21AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 23, 2018 at 04:33:24PM +0300, Kirill Tkhai wrote:
> > > +	page = virt_to_head_page(ptr);
> > > +	if (likely(PageSlab(page)))
> > > +		return kmem_cache_free(page->slab_cache, (void *)ptr);
> > 
> > It seems slab_cache is not generic for all types of slabs. SLOB does not care about it:
> 
> Oof.  I was sure I checked that.  You're quite right that it doesn't ...
> this should fix that problem:

This patch was complete rubbish.  The point of SLOB is that it mixes
sizes within the same page, and doesn't store the size when allocating
from a slab.  So there is no way to tell.  I'm going to think about this
some more.
