Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeFAIgT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:36:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFAIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:36:13 -0400
Date: Fri, 1 Jun 2018 01:35:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, Coly Li <colyli@suse.de>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RESEND PATCH V5 00/33] block: support multipage bvec
Message-ID: <20180601083557.GA30694@infradead.org>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525045306.GB8740@kmo-pixel>
 <8aa4276d-c0bc-3266-aa53-bf08a2e5ab5c@kernel.dk>
 <20180527072332.GA18240@ming.t460p>
 <cc266632-497c-6849-e291-4f042c8d987a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc266632-497c-6849-e291-4f042c8d987a@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 07:44:52PM -0600, Jens Axboe wrote:
> Yes, we discussed exactly this, which is why I'm surprised you went
> ahead with the same approach. I told you I don't like tree wide renames,
> if they can be avoided. I'd rather suffer some pain wrt page vs segments
> naming, and then later do a rename (if it bothers us) once the dust has
> settled on the interesting part of the changes.
> 
> I'm very well away of our current naming and what it signifies.  With
> #1, you are really splitting hairs, imho. Find a decent name for
> multiple segment. Chunk?

vec?

bio_for_each_segment (page)
bio_for_each_vec (whole bvec)
