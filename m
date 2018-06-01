Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeFAX4R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:56:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750927AbeFAX4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:56:15 -0400
Date: Sat, 2 Jun 2018 07:55:54 +0800
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
Message-ID: <20180601235553.GB655@ming.t460p>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525045306.GB8740@kmo-pixel>
 <8aa4276d-c0bc-3266-aa53-bf08a2e5ab5c@kernel.dk>
 <20180527072332.GA18240@ming.t460p>
 <cc266632-497c-6849-e291-4f042c8d987a@kernel.dk>
 <20180528023042.GC26790@ming.t460p>
 <20180601084302.GB30694@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601084302.GB30694@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 01:43:02AM -0700, Christoph Hellwig wrote:
> On Mon, May 28, 2018 at 10:30:43AM +0800, Ming Lei wrote:
> > I hate the conversion too, but looks it can't be avoided since
> > bio_for_each_segment_all() has to be changed.
> 
> I guess you mean what is currently bio_for_each_page_all in your
> tree which now takes a bvec_iter_all agument?  We could just
> try to hide the bia variable initially under an unlike to be used
> name, and then slowly move to the proper bio_for_each_page_all
> API unhiding it with the rename.

I tried that way at the beginning, it will cause gcc warning, since
the variable will be defined in the middle of one function, and even
worse it might break nested iterator case.

Thanks,
Ming
