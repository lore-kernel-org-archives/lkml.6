Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeEaMKr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:10:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754943AbeEaMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:10:43 -0400
Date: Thu, 31 May 2018 08:10:42 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20180531121041.GB8456@redhat.com>
References: <20180531142302.5f7b4302@canb.auug.org.au>
 <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A669939D-1AC5-48AA-AAE2-92694FB25B11@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31 2018 at 12:35am -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On May 30, 2018, at 10:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > Hi all,
> > 
> > After merging the device-mapper tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/md/dm-writecache.c: In function 'writecache_dtr':
> > drivers/md/dm-writecache.c:1799:3: error: implicit declaration of function 'bioset_free'; did you mean 'bvec_free'? [-Werror=implicit-function-declaration]
> >   bioset_free(wc->bio_set);
> >   ^~~~~~~~~~~
> >   bvec_free
> > drivers/md/dm-writecache.c: In function 'writecache_ctr':
> > drivers/md/dm-writecache.c:1929:17: error: implicit declaration of function 'bioset_create'; did you mean 'bioset_exit'? [-Werror=implicit-function-declaration]
> >   wc->bio_set = bioset_create(BIO_POOL_SIZE,
> >                 ^~~~~~~~~~~~~
> >                 bioset_exit
> > drivers/md/dm-writecache.c:1929:15: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> >   wc->bio_set = bioset_create(BIO_POOL_SIZE,
> >               ^
> > 
> > Caused by commit
> > 
> >  2105231db61b ("dm: add writecache target")
> > 
> > interacting with commit
> > 
> >  dad08527525f ("block: Drop bioset_create()")
> > 
> > from the block tree.
> > 
> > Can we please consider not immediately dropping APIs if at all
> > possible. :-(
> 
> I’ll drop the last patch, we can do that at the end of the merge window instead. 
> 

FYI, I've since updated dm-writecache to use the new APIs

Mike
