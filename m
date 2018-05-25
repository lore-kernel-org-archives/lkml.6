Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935358AbeEYExN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:53:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38340 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933717AbeEYExL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:53:11 -0400
X-Google-Smtp-Source: ADUXVKKNO8k95O/hbZonf6rMnDyXBVpqv2kyalc3iiDnr+2o7lrcF4tAK+9zhCdcmn0/vylAot2H2w==
Date: Fri, 25 May 2018 00:53:06 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>, Coly Li <colyli@suse.de>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RESEND PATCH V5 00/33] block: support multipage bvec
Message-ID: <20180525045306.GB8740@kmo-pixel>
References: <20180525034621.31147-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525034621.31147-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:45:48AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset brings multipage bvec into block layer:

patch series looks sane to me. goddamn that's a lot of renaming.

Things are going to get interesting when we start sticking compound pages in the
page cache, there'll be some interesting questions of semantics to deal with
then but I think getting this will only help w.r.t. plumbing that through and
not dealing with 4k pages unnecessarily - but I think even if we were to decide
that merging in bio_add_page() is not the way to go when the upper layers are
passing compound pages around already, this patch series helps because
regardless at some point everything under generic_make_request() is going to
have to deal with segments that are more than one page, and this patch series
makes that happen. So incremental progress.

Jens, any objections to getting this in?
