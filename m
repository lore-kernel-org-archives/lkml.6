Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-427704-1527095533-2-4194198840458709610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527095533; b=cwhzbJOL0dBzFXMahz9lqrJOdb695kz5N8ji1zescGepkPmSmz
    7Xr6N/+d4RlYVvINeHwiZg6LICDCGefe78PeVt+EYs68T4Pgkq1SNCURPqKlgGOk
    AWLgxnLQBxCoH24EIZKXKAIFHn+6BuAUVyxrySNVVB9eavzgn80e9xmy95cxWoQV
    riAj0H0fRcDnntwZ90kpDdq8RgHAsL1+8rnbjU5WIOlZaMBnF5oyD/rvCw7+QbT0
    PlYSvcJo+D6CwWL9ifTYJcMHNCYW5MJqCsis1T2NOv0uuP6o0sDPwZsZCqi3AFKA
    RasU3bl9BdkD9RQfJwHbXPD6ZE2k8UYYmldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527095533; bh=OzN6a3DkweSgfwbppktyMXQhsxjzou
    M2wZbcPpLYIyw=; b=SGmz1VVlpnpRJB4jjrccV8PSCr13Mt8ehP0+7esN02IS2K
    dSLiJRwk5oQKggbtCTa6oEHcRFpsxLHEQV367HHuxc3m/Tvw10bpKp5W3YnVF4BH
    jpvt1g1keb3KNEHpveYcWEiTGAg/dMNa3FEsoA7pLxp34rEnfXd8II/wrWUOb/YD
    FXVGtPgbxdRsQGj32WSV/feq6O2/UI9IF2KjtJNSwFZiOVrFmfyuH1syLyZzd/Bm
    jLVHc/DwbBXYow5K50nHslZQI6A+ZoaM87edygEds/JBQS7jb4FOKsAjU2r6RJ+c
    jLGpCnCRnoAzeFVWsl7dwhVpkSkFF3nHNx8wzxUQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=G9A1fLdz x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=YaqkOxWv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=G9A1fLdz x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=YaqkOxWv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJXnb3109EdxCJX0vlWFLP75FridxQwBpJwZzXBYq72N+FAYN/kuTvthVIR6eN/wcUafT31o0QXXWKj6gOZ2JXcnwDi4qOOF9FgG978pDQUk6PkbvYUa
    C85MiHtJ9C0/iV5w33kdqxtpcqID5x7A6jdNv86ngbsWxXUhuHQipxsTyd573yczRuoM3aNDXnUJMoUPEOXPVMsRMrSTLa51AI+wAniAHomfqoNGTqkOBl7H
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=X4QjQfKnsHYA:10 a=VUJBJC2UJ8kA:10 a=O6gDU49s6lMXWFxsZvsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeEWRMJ (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 13:12:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42335 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWRMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 13:12:08 -0400
X-Google-Smtp-Source: ADUXVKKdOTu47rJWeSwY18IG8MV8IAQjRd1rBue+73PSCbrG6eJTPQ1kEvSTw7yCiTxpwRaXqb+uLw==
Date: Wed, 23 May 2018 13:12:04 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com,
        jbacik@fb.com, viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH 01/10] mm: pagecache add lock
Message-ID: <20180523171204.GA20772@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
 <20180518131305.GA6361@bombadil.infradead.org>
 <20180518155330.GA16931@infradead.org>
 <20180520224524.GC11495@kmo-pixel>
 <20180523152239.GA2425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523152239.GA2425@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 08:22:39AM -0700, Christoph Hellwig wrote:
> On Sun, May 20, 2018 at 06:45:24PM -0400, Kent Overstreet wrote:
> > > 
> > > Honestly I think this probably should be in the core.  But IFF we move
> > > it to the core the existing users of per-fs locks need to be moved
> > > over first.  E.g. XFS as the very first one, and at least ext4 and f2fs
> > > that copied the approach, and probably more if you audit deep enough.
> > 
> > I'm not going to go and redo locking in XFS and ext4 as a prerequisite to
> > merging bcachefs. Sorry, but that's a bit crazy.
> 
> It isn't crazy at all.  In general we expect people to do their fair
> share of core work to get their pet feature in.  How much is acceptable
> is a difficult question and not black and white.
> 
> But if you want to grow a critical core structure you better take a stab
> at converting existing users.  Without that the tradeoff of growing
> that core structure is simply not given.
> 
> Or to put it in words for this exact feature:  unless your new field
> is also used by mainstream file systems it is not going to be added.

Christoph, I'm really not someone you can accuse of avoiding my share of core
work and refactoring and you know it.

When are you going to get around to converting existing users of fs/direct-io.c
to iomap so it can be deleted? The kernel is carrying around two dio
implementations right now thanks to you. Not a good situation, is it?
