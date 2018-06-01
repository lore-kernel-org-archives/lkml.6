Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeFAInS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:43:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeFAInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:43:16 -0400
Date: Fri, 1 Jun 2018 01:43:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20180601084302.GB30694@infradead.org>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525045306.GB8740@kmo-pixel>
 <8aa4276d-c0bc-3266-aa53-bf08a2e5ab5c@kernel.dk>
 <20180527072332.GA18240@ming.t460p>
 <cc266632-497c-6849-e291-4f042c8d987a@kernel.dk>
 <20180528023042.GC26790@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528023042.GC26790@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 10:30:43AM +0800, Ming Lei wrote:
> I hate the conversion too, but looks it can't be avoided since
> bio_for_each_segment_all() has to be changed.

I guess you mean what is currently bio_for_each_page_all in your
tree which now takes a bvec_iter_all agument?  We could just
try to hide the bia variable initially under an unlike to be used
name, and then slowly move to the proper bio_for_each_page_all
API unhiding it with the rename.

But I think your current bio_for_each_segment_all should just
go away.  All three users really should be using better abstractions.
