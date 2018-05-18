Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77513-1526665764-2-14277618797899734722
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526665764; b=kzCrcttJLuFud00c/VOG5+NdWs9OCOMJso9byt68xBM/ScUVfb
    XWnZEBQcWG9yxuKz4YNWhqumJlo/PfISC8JN5hzKjczrUOgfQEYGBUl8n2TC28km
    Jhmf9iyNyTbPBZYVnWoo1B/lxFCIjOEqiu/7UxsUGaUKd5QikPB1RiRfQYdHW809
    ex16REuKjQ2nDYVeySREsYpzk6J2BlqSIGrFP6BJy3GDFJ8HI1qLt/w4CT5BV3KL
    HjZjxn3GJ2HUkmwb2mPEMdidX7qEI/fADj/PrJJwsKL4JIGQsgeYfS57CusNcrH5
    YIyyTWKm29hPzOKS25wwwNRm2F/oaOuhlRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526665764; bh=PBCiSGU4HP/TUmJQfIZknYCpkcR2ZY
    TdqF+miGFuuaI=; b=K4vLumRpbR5cLTlsz6lf0pTID+yMWJA0knAn8XUlRDjR4a
    c8pp0mB+zgi7eSs2mKtb+QuO6iZxpioowyGFxdVGtf8Y+5D2PICJpDRutQ3KXBLB
    vm1q7y+4HSYgf6RDkk5OPpXXri5E5S1VScwcgKZM2QDaeLdP5Y2L2QVLDXrgxMAt
    GaPXQO+++GrNwJSaOVe5eN/UVjg8vg6n6k8wR3MMWtivjWHO/qhazg+EP8kxU9tO
    rrPRxPCXdnurLzgEXIY/h67BwajzXQ83ohAnlJGp0RG4TT2264Zs4B0BEOEOVpVm
    5ChXOEaA+nVgeyhNUgN/SR6ykJ7zlOcWpsjmqh4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=LqCRCiRN x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=O/SYVF6/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=LqCRCiRN x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=O/SYVF6/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnlV9D6uWGoYsDtGdFbj+o3wVEq4JUz98jBGyZz1xY4+35bsLCMD+wDPKmtN/pWb0/y9QhsqQE/9FW2d/sNQ0M/+qUSWXzeh7wb0+GnRUvqgp+p5g9q
    oHHeKzvlNKi/bGIuIBi9mykF3L2KvjfRvjK54eLt06wrVfhRDHjYLiPL5khL9a+bRBxlvHTELrfr5KmSGD1fVDsaVUIkRoMtlcxCEWJchDaDo4SxhFkSFL1/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=NEAV23lmAAAA:8 a=P7TJjb7zcfGnpFTqTW0A:9
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeERRtT (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:49:19 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33952 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeERRtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 13:49:17 -0400
X-Google-Smtp-Source: AB8JxZqzpn7re22Mo1M+5jS4StkfsSsAmvAhtI2HmHsHiyS1Rh2Sx3evqu5dVO9g5/RJbE5TV9CKFQ==
Date: Fri, 18 May 2018 13:49:12 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, willy@infradead.org,
        peterz@infradead.org
Subject: Re: [PATCH 00/10] RFC: assorted bcachefs patches
Message-ID: <20180518174912.GE31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518174536.ai26bg3bhlvzq4pi@destiny>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518174536.ai26bg3bhlvzq4pi@destiny>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 01:45:36PM -0400, Josef Bacik wrote:
> On Fri, May 18, 2018 at 03:48:58AM -0400, Kent Overstreet wrote:
> > These are all the remaining patches in my bcachefs tree that touch stuff outside
> > fs/bcachefs. Not all of them are suitable for inclusion as is, I wanted to get
> > some discussion first.
> > 
> >  * pagecache add lock
> > 
> > This is the only one that touches existing code in nontrivial ways.  The problem
> > it's solving is that there is no existing general mechanism for shooting down
> > pages in the page and keeping them removed, which is a real problem if you're
> > doing anything that modifies file data and isn't buffered writes.
> > 
> > Historically, the only problematic case has been direct IO, and people have been
> > willing to say "well, if you mix buffered and direct IO you get what you
> > deserve", and that's probably not unreasonable. But now we have fallocate insert
> > range and collapse range, and those are broken in ways I frankly don't want to
> > think about if they can't ensure consistency with the page cache.
> > 
> > Also, the mechanism truncate uses (i_size and sacrificing a goat) has
> > historically been rather fragile, IMO it might be a good think if we switched it
> > to a more general rigorous mechanism.
> > 
> > I need this solved for bcachefs because without this mechanism, the page cache
> > inconsistencies lead to various assertions popping (primarily when we didn't
> > think we need to get a disk reservation going by page cache state, but then do
> > the actual write and disk space accounting says oops, we did need one). And
> > having to reason about what can happen without a locking mechanism for this is
> > not something I care to spend brain cycles on.
> > 
> > That said, my patch is kind of ugly, and it requires filesystem changes for
> > other filesystems to take advantage of it. And unfortunately, since one of the
> > code paths that needs locking is readahead, I don't see any realistic way of
> > implementing the locking within just bcachefs code.
> > 
> > So I'm hoping someone has an idea for something cleaner (I think I recall
> > Matthew Wilcox saying he had an idea for how to use xarray to solve this), but
> > if not I'll polish up my pagecache add lock patch and see what I can do to make
> > it less ugly, and hopefully other people find it palatable or at least useful.
> > 
> >  * lglocks
> > 
> > They were removed by Peter Zijlstra when the last in kernel user was removed,
> > but I've found them useful. His commit message seems to imply he doesn't think
> > people should be using them, but I'm not sure why. They are a bit niche though,
> > I can move them to fs/bcachefs if people would prefer. 
> > 
> >  * Generic radix trees
> > 
> > This is a very simple radix tree implementation that can store types of
> > arbitrary size, not just pointers/unsigned long. It could probably replace
> > flex arrays.
> > 
> >  * Dynamic fault injection
> > 
> 
> I've not looked at this at all so this may not cover your usecase, but I
> implemeted a bpf_override_return() to do focused error injection a year ago.  I
> have this script
> 
> https://github.com/josefbacik/debug-scripts/blob/master/inject-error.py
> 
> that does it generically, all you have to do is tag the function you want to be
> error injectable with ALLOW_ERROR_INJECTION() and then you get all these nice
> things like a debugfs interface to trigger them or use the above script to
> trigger specific errors and such.  Thanks,

That sounds pretty cool...

What about being able to add a random fault injection point in the middle of an
existing function? Being able to stick race_fault() in random places was a
pretty big win in terms of getting good code coverage out of realistic tests.
