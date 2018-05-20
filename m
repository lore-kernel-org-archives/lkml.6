Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3788130-1526856336-2-17959370233864220205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526856336; b=StxPQBbuI4PEXZkkT/tDDog1MoAxeoCzp+KHumNhgxfBhypjmE
    nVh85JCpJ8v7tUP76FjgKdR+AS4QLA3GGpSbwU6rJ7ExsPDLybOJC9qihc250d4j
    5qN5z0F732safA8Cym13hHznVcI1PJ2TDa7oIqfxMnP4fhvffycBYnyY8UB6P4o1
    ogMvPdPdgarSDOAFvKVtusX0CHEVpkfhl7aZx2Sxe3U05d8BvdlawRl4+zImDXI5
    R7EUAI19Q62cT2HI1Id5miMTzzCmtjo+qIbtjl7Lyhl8gCyWZWKSrOEMgU5T1kYX
    6ghEbzIs+Gg7PxTf7Ya+POOm/DAt5svgN+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526856336; bh=1ciRPcHyMqLf4nyrDF1N0hUJVV+Ahx
    z7OMlzkKDHXQg=; b=Rli8/zAzX6egkfYvWCaDqcdsSryV/d1WIDsl3VsEKvVfxE
    tBHXk9rTKJCaedfnC+vaLDALcul+cP9Yd9qX9/7O13mQx/50FhUMxJQuLA+a1idF
    RIR8yaa4uIU3cbqQtnWB6T51vidJGLCbESl+IuMozuXxQMKKfhFEfFJJB7rE6Yhk
    /JukAUW6any0ogWzoC4gdO+KwVPSKEspvTIbf06M7JajpBGg5QCRiQGmo9E5in/d
    3ZscSVLQfboSmKz1MOBdJxdFRchaXsxnerRfSO9a0PvO2EPjfUsknHwfE/ucG6qk
    MaHvijEhebNBiskc0eiHxGnZ8CHOvGoj3tgpXo2Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=bzBJaj7D x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=fKB0IRLi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=bzBJaj7D x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=fKB0IRLi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfyflesVNYSCubmtgE+aSLV4x2QMo1KHxnpgHAJi/BIwpVzE0WTbaOeiP/Sm55bF6RS5n/9CKgL94EnI1EalMwGApYP/2zC8lPqjMR9wmqidwHPCZf4
    FciXlszf/3J6WSdLRlKPBNO6MoivNkJDlc99KxJFN1NIuGcen8Wuvt+9QeALpVrQ3QfWIM2aIverc0Nw/q2DYILmFsBDjSEOcNQbH8hK+YCAXbmpiv3+ykl5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=N_HCUNHBxCwP2tgTqc4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeETWpb (ORCPT <rfc822;linux@kroah.com>);
        Sun, 20 May 2018 18:45:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44929 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeETWp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 May 2018 18:45:28 -0400
X-Google-Smtp-Source: AB8JxZpG4ywokXMQybLRcH2hva5bLSOExpuOSPOPFoCl9AH/i6Kr54enGbTJf/cQyG/paZJaCOHPDg==
Date: Sun, 20 May 2018 18:45:24 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH 01/10] mm: pagecache add lock
Message-ID: <20180520224524.GC11495@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
 <20180518131305.GA6361@bombadil.infradead.org>
 <20180518155330.GA16931@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518155330.GA16931@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 08:53:30AM -0700, Christoph Hellwig wrote:
> On Fri, May 18, 2018 at 06:13:06AM -0700, Matthew Wilcox wrote:
> > > Historically, the only problematic case has been direct IO, and people
> > > have been willing to say "well, if you mix buffered and direct IO you
> > > get what you deserve", and that's probably not unreasonable. But now we
> > > have fallocate insert range and collapse range, and those are broken in
> > > ways I frankly don't want to think about if they can't ensure consistency
> > > with the page cache.
> > 
> > ext4 manages collapse-vs-pagefault with the ext4-specific i_mmap_sem.
> > You may get pushback on the grounds that this ought to be a
> > filesystem-specific lock rather than one embedded in the generic inode.
> 
> Honestly I think this probably should be in the core.  But IFF we move
> it to the core the existing users of per-fs locks need to be moved
> over first.  E.g. XFS as the very first one, and at least ext4 and f2fs
> that copied the approach, and probably more if you audit deep enough.

I'm not going to go and redo locking in XFS and ext4 as a prerequisite to
merging bcachefs. Sorry, but that's a bit crazy.

I am more than happy to work on the locking itself if we can agree on what
semantics we want out of it. We have two possible approaches, and we're going to
have to pick one first: the locking can be done at the top of the IO stack (like
ext4 and I'm guessing xfs), but then we're adding locking overhead to buffered
reads and writes that don't need it because they're only touching pages that are
already in cache.

Or we can go with my approach, pushing down the locking to only when we need to
add pages to the page cache. I think if we started out by merging my approach,
it would be pretty easy to have it make use of Mathew's fancy xarray based range
locking when that goes in, the semantics should be similar enough.

If people are ok with and willing to use my approach, I can polish it up - add
lockdep support and whatever else I can think of, and attempt to get rid of the
stupid recursive part.

But that's got to be decided first, where in the call stack the locking should
be done.
