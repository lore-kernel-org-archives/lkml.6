Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeEJWsr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:48:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeEJWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:48:46 -0400
Date: Thu, 10 May 2018 15:48:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
Message-Id: <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
In-Reply-To: <20180508174424.GA12638@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
        <20180508174424.GA12638@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2018 11:44:24 -0600 Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> On Thu, May 03, 2018 at 01:24:25PM -0600, Ross Zwisler wrote:
> > The following series gets the radix tree test suite compiling again in
> > the current linux/master, adds a unit test which exposes a race in the
> > radix tree multi-order iteration code, and then fixes that race.
> > 
> > This race was initially hit on a v4.15 based kernel and results in a GP
> > fault.  I've described the race in detail in patches 4 and 5.
> > 
> > The fix is simple and necessary, and I think it should be merged for
> > v4.17.
> > 
> > This tree has gotten positive build confirmation from the 0-day bot,
> > passes the updated radix tree test suite, xfstests, and the original
> > test that was hitting the race with the v4.15 based kernel.
> > 
> > Ross Zwisler (5):
> >   radix tree test suite: fix mapshift build target
> >   radix tree test suite: fix compilation issue
> >   radix tree test suite: add item_delete_rcu()
> >   radix tree test suite: multi-order iteration race
> >   radix tree: fix multi-order iteration race
> > 
> >  lib/radix-tree.c                      |  6 ++--
> >  tools/include/linux/spinlock.h        |  3 +-
> >  tools/testing/radix-tree/Makefile     |  6 ++--
> >  tools/testing/radix-tree/multiorder.c | 63 +++++++++++++++++++++++++++++++++++
> >  tools/testing/radix-tree/test.c       | 19 +++++++++++
> >  tools/testing/radix-tree/test.h       |  3 ++
> >  6 files changed, 91 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.14.3
> > 
> 
> Ping on this series.  Does anyone have any feedback?  Matthew?
> 
> I'd really like to get it into v4.17.
> 
> We can take it through the libnvdimm tree, if that's easiest.

There's a copy in Dan's linux-next tree which is missing

- The Link: tag
- The Fixes: tag
- The Reported-by
- Jan's reviewed-by
- the cc:stable tag

so I think I'll just ignore all that and send this series off to Linus next
week.
