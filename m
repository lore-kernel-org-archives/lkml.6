Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeFBDaH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:30:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751877AbeFBDaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:30:03 -0400
Date: Sat, 2 Jun 2018 11:29:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, Coly Li <colyli@suse.de>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RESEND PATCH V5 00/33] block: support multipage bvec
Message-ID: <20180602032941.GB2306@ming.t460p>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525045306.GB8740@kmo-pixel>
 <8aa4276d-c0bc-3266-aa53-bf08a2e5ab5c@kernel.dk>
 <20180527072332.GA18240@ming.t460p>
 <cc266632-497c-6849-e291-4f042c8d987a@kernel.dk>
 <20180601083557.GA30694@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601083557.GA30694@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 01:35:57AM -0700, Christoph Hellwig wrote:
> On Sun, May 27, 2018 at 07:44:52PM -0600, Jens Axboe wrote:
> > Yes, we discussed exactly this, which is why I'm surprised you went
> > ahead with the same approach. I told you I don't like tree wide renames,
> > if they can be avoided. I'd rather suffer some pain wrt page vs segments
> > naming, and then later do a rename (if it bothers us) once the dust has
> > settled on the interesting part of the changes.
> > 
> > I'm very well away of our current naming and what it signifies.  With
> > #1, you are really splitting hairs, imho. Find a decent name for
> > multiple segment. Chunk?
> 
> vec?
> 
> bio_for_each_segment (page)
> bio_for_each_vec (whole bvec)

IMO, either vec or chunk should be fine, but one thing is that
there isn't obvious difference between segment and vec/chunk,
especially the difference is much less obvious than between page
and vec/chunk/segment.

That is why I tried to suggest to introduce bio_for_each_page_*
before.

Thanks,
Ming
