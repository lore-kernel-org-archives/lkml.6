Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-865074-1527119719-2-14579119874601043887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527119718; b=PLVK8r6D5BJiYJwNAfxgFhABeGcpZOBl63Rx2P3QjtmgvGH3kr
    rsa6tV0P2bUfhN5C1i5eO8mQ2KU0NjGU32j5CNmL3RLvdA0Zd8zBjTpQBoffyOxw
    G/rq01kQeo1marIGqYXHDuo5/HSzbxf0n9gvGW+eyj23OjhVYm6g95kVYOIwfPe9
    1sH8DiTpiLvPux94zcqckJAYixRGvbMsH0RwpQLtUElSzyhG+w0UCWRQN0OVVl2w
    +g71J7QH/jVb7viY/jiFMQQnez0yKvTRugr4gSReyVrQXqnqqfZm47/hveCAVWp8
    2NEw3vbj5CA6/yXU2T157NUG40IX1ee1IndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527119718; bh=sICVO8J9NVNObdvWZdbvgrBNBsd2XM
    TX6MWdedo3epA=; b=bn7ao9Nm+NHn7Surkgvasyn/ogui2A0ytsoEgmSb2SfSQa
    7ma69nNxRqaa4DYUFzDlFpokhJg7/MxZDVkipfDGthJR21Hx7TqzeQrI3xvR29fQ
    BmbsqCRvOKeFLXTfJKUpbtSYv/22xecOUUUhwU7ybPVRr6qvBWfkQeRnsy50tMyr
    nwqFMikFWYpKDIvHJBqiRvroXSwDLxl4VuhVk3iAvHakeLKiDKMgWeUfxVHPkT1u
    JnIuWE7yqFjmnrSgQtkCg6T313wH2tJLftWeSA38kO2ZnGoadYo2Sh50QEcpCu3c
    DRCqN1xuzp9x24y7J74OmXW0TrkjBKsqCP04vNhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=KMJ4FHKT x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=oAwJ5ewX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=KMJ4FHKT x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=oAwJ5ewX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH3u4uP4O7CQcZ82aOwNSfCyKA7EVMwPp8OlZ1W4QrIWQWzUQ6GTfKLaCWnvW2y1t/ltW4HXVwyAPzUS/EgyCavAU4WDi46hCOW8b1qMj7FhXxCscOVl
    shm2/rYeV7OPJLJ63jwvzgOQVxYgz9e5w7evkayelItVRAPCFf3fgY6rVbK9/Q6NDbx6FgX5FcHVAaevTTsPdrg+D5sfFWqQae6v7HFwqxcYwsEZ3ReoxJPN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=EcpiphFs1HYcErPpwpcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935121AbeEWXzP (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 19:55:15 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40170 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbeEWXzN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 19:55:13 -0400
X-Google-Smtp-Source: AB8JxZrdeuUZMhXmn8qIGTUAeyXh54BQYDsZRLZCWOhXza7Qur+f36AxF0Y8L4BGCxU8kSLPOt++ew==
Date: Wed, 23 May 2018 19:55:09 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, peterz@infradead.org,
        bcrl@kvack.org, Christoph Hellwig <hch@infradead.org>,
        zach.brown@ni.com
Subject: Notes on locking for pagacache consistency (was: [PATCH 01/10] mm:
 pagecache add lock)
Message-ID: <20180523235509.GD23040@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
 <20180518131305.GA6361@bombadil.infradead.org>
 <20180518155330.GA16931@infradead.org>
 <20180518174549.GD31737@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518174549.GD31737@kmo-pixel>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 01:45:49PM -0400, Kent Overstreet wrote:
> On Fri, May 18, 2018 at 08:53:30AM -0700, Christoph Hellwig wrote:
> > On Fri, May 18, 2018 at 06:13:06AM -0700, Matthew Wilcox wrote:
> > > > Historically, the only problematic case has been direct IO, and people
> > > > have been willing to say "well, if you mix buffered and direct IO you
> > > > get what you deserve", and that's probably not unreasonable. But now we
> > > > have fallocate insert range and collapse range, and those are broken in
> > > > ways I frankly don't want to think about if they can't ensure consistency
> > > > with the page cache.
> > > 
> > > ext4 manages collapse-vs-pagefault with the ext4-specific i_mmap_sem.
> > > You may get pushback on the grounds that this ought to be a
> > > filesystem-specific lock rather than one embedded in the generic inode.
> > 
> > Honestly I think this probably should be in the core.  But IFF we move
> > it to the core the existing users of per-fs locks need to be moved
> > over first.  E.g. XFS as the very first one, and at least ext4 and f2fs
> > that copied the approach, and probably more if you audit deep enough.
> 
> I didn't know about i_mmap_sem, thanks
> 
> But, using a rw semaphore wouldn't work for dio writes, and I do need dio writes
> to block pagecache adds in bcachefs since the dio write could overwrite
> uncompressed data or a reservation with compressed data, which means new writes
> need a disk reservation.
> 
> Also I'm guessing ext4 takes the lock at the top of the read path? That sucks
> for reads that are already cached, the generic buffered read path can do cached
> reads without taking any per inode locks - that's why I pushed the lock down to
> only be taken when we have to add a page to the pagecache.
> 
> Definitely less ugly doing it that way though...

More notes on locking design: Mathew, this is very relevant to any sort of range
locking, too.

There's some really tricky issues related to dio writes + page faults. If your
particular filesystem doesn't care about minor page cache consistency issues
caused by dio writes most of this may not be relevant to you, but I honestly
would find it a little hard to believe this isn't an issue for _any_ other
filesystems.

Current situation today, for most filesystems: top of the dio write path shoots
down the region of the pagecache for the file it's writing to, with
filemap_write_and_wait_range() then invalidate_inode_pages2_range().

This is racy though and does _not_ gurarantee page cache consistency, i.e. we
can end up in a situation where the write completes, but we have stale data -
and worse, potentially stale metadata, in the buffer heads or whatever your
filesystem uses.

Ok, solving that is easy enough, we need a lock dio writes can take that
prevents pages from being added to a mapping for their duration (or alternately,
range locks, but range locks can be viewed as just an optimization).

This explains my locking design - if you have a lock that can be taken for "add"
or "block", where multiple threads can take it for add or block, but it can't be
in both states simultaneously then it does what we want, you can have multiple
outstanding dio writes or multiple buffered IO operations bringing pages in and
it doesn't add much overhead.

This isn't enough, though.

 - calling filemap_write_and_wait_range then invalidate_inode_pages2_range can
   race - the call to invalidate_inode_pages2_range will fail if any of the
   pages have been redirtied, and we'll have stale pages in the page cache.

   The ideal solution for this would be a function to do both, that removes
   pages from the page cache atomically with clearing PageDirty and kicking off
   writeback. Alternately, you can have .page_mkwrite and the buffered write
   path take the pagecache add lock when they have to dirty a page, but that
   kind of sucks.

 - pagefaults, via gup()
   
   this is the really annoying one, if userspace does a dio write where the buf
   they're writing is mmapped and overlaps with the part of the file they're
   writing to, yay fun

   we call gup() after shooting down the part of the pagecache we're writing
   to, so gup() just faults it back in again and we're left with stale data in
   the page cache again.

   the generic dio code tries to deal with this these days by calling
   invalidate_inode_pages2_range() again after the dio write completes. Again
   though, invalidate_inode_pages2_range() will fail if the pages are dirty, and
   we're left with stale data in the page cache.

   I _think_ (haven't tried this yet) it ought to be possible to move the second
   call to invalidate_inode_pages2_range() to immediately after the call to
   gup() - this change wouldn't make sense in the current code without locking,
   but it would make sense if the dio write path is holding a pagecache add lock
   to prevent anything but its own faults via gup() from bringing pages back in.

   Also need to prevent the pages gup() faulted in from being dirtied until they
   can be removed again... 

   Also, one of the things my patch did was change filemap_fault() to not kick
   off readahead and only read in single pages if we're being called with
   pagecache block lock held (i.e. from dio write to the same file). I'm pretty
   sure this is unnecessary though, if I add the second
   invalidate_inode_pages2_range() call to my own dio code after gup() (which I
   believe is the correct solution anyways).

 - lock recursion

   my locking approach pushes down the locking to only when we're adding pages
   to the radix tree, unlike, I belive, the ext4/xfs approach.

   this means that dio write takes page_cache_block lock, and page faults take
   page_cache_add lock, so dio write -> gup -> fault is a recursive locking
   deadlock unless we do something about it.

   my solution was to add a pointer to a pagecache_lock to task_struct, so we
   can detect the recursion when we go to take pagecache_add lock. It's ugly,
   but I haven't thought of a better way to do it.

   I'm pretty sure that the xarray based range locking Matthew wants to do will
   hit the same issue, it's just inherent to pushing the locking down to where
   we manipulate the radix tree - which IMO we want to do, so that buffered
   reads/writes to cached data aren't taking these locks unnecessarily; those
   are the fast paths.

If anyone has any better ideas than what I've come up with, or sees any gaping
holes in my design, please speak up...

Even if you don't care about dio write consistency, having this locking in the
core VFS could mean converting truncate to use it, which I think would be a
major benefit too.
