Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755581AbeEHRo3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:44:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:58509 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755122AbeEHRo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:44:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="56988514"
Date: Tue, 8 May 2018 11:44:24 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
Message-ID: <20180508174424.GA12638@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 01:24:25PM -0600, Ross Zwisler wrote:
> The following series gets the radix tree test suite compiling again in
> the current linux/master, adds a unit test which exposes a race in the
> radix tree multi-order iteration code, and then fixes that race.
> 
> This race was initially hit on a v4.15 based kernel and results in a GP
> fault.  I've described the race in detail in patches 4 and 5.
> 
> The fix is simple and necessary, and I think it should be merged for
> v4.17.
> 
> This tree has gotten positive build confirmation from the 0-day bot,
> passes the updated radix tree test suite, xfstests, and the original
> test that was hitting the race with the v4.15 based kernel.
> 
> Ross Zwisler (5):
>   radix tree test suite: fix mapshift build target
>   radix tree test suite: fix compilation issue
>   radix tree test suite: add item_delete_rcu()
>   radix tree test suite: multi-order iteration race
>   radix tree: fix multi-order iteration race
> 
>  lib/radix-tree.c                      |  6 ++--
>  tools/include/linux/spinlock.h        |  3 +-
>  tools/testing/radix-tree/Makefile     |  6 ++--
>  tools/testing/radix-tree/multiorder.c | 63 +++++++++++++++++++++++++++++++++++
>  tools/testing/radix-tree/test.c       | 19 +++++++++++
>  tools/testing/radix-tree/test.h       |  3 ++
>  6 files changed, 91 insertions(+), 9 deletions(-)
> 
> -- 
> 2.14.3
> 

Ping on this series.  Does anyone have any feedback?  Matthew?

I'd really like to get it into v4.17.

We can take it through the libnvdimm tree, if that's easiest.
