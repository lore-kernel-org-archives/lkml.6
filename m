Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1751440-1524711448-2-10063625205860466389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524711447; b=ZUKvdxYeFbgpwzgr9RgOpTbdFPvH4mG0T+GJBSDMMzbeKSIrkJ
    1oU0+Wp8yVq6WeAt+xpAh4QXWE1057CsK6C55j4chbySXz2C6uu1aJYkZaLhUwfI
    kDqkr9YFGFG7WTGPPBhezJOvIqV16m4jgGilPo7EgbDVPMDhU/hNI+B+2tCnTdER
    2l8nQ2M45sfYPRBVqb2V7AQdP7z2ceWLZ7sjK0HLSJSSvBMOOrjo3PLhurRSq8FW
    FEH06d0++cbQ+vXYUqjSnKk9wlOgO9BoxMd7E3avT9aW/aDU1NY46mXJnILLtuXv
    VQTUgsMMrDipoWG+luXpKgAICY9SJrX0KYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524711447; bh=MS3o+u2SF28Mk8/Q2lC/N1k43zIyiH
    YNFPBFeEgUeCA=; b=wUGlbEWHPgpLwtVeA7QKftYkbaHLAtEhYU2VxSkqGWJygN
    F61DlzP/QU66U+ooMTQWHfG/kSYQHtHe+46Ri5WQEd0LdbN5rdw15PTtbPuySZTy
    BYTFqvRqv+HE1XpePSNz6vYNIxrgmFLzasisceqhGgyuACpd86/dE2hTuPHCF2Fs
    dNCeAE2QiVREHMm1uIS7JE04of6P/K37fRxl1zkxFUZtVhxyt1Pzv3xAolFj2DEI
    npiOP59Yws0RVKtQqHgHm0xM6lPWqQOXmeyhBOqnsPcb7XULdLIwPEn/j/U9rN/j
    fw3pNbXNx7Dqf7GpRVFydFugLIm5apTNDGwWTT+g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=M5Mw4/xc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=M5Mw4/xc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH9renO3NpJENlfNo9Tp/snimoW99aYLhDLaODuTHL4l+nAPqn92byRotulWcC/FjQ4HocMMbFO9fIi3M4qyQWnJ1ItO2Nc58ifs8VR6zyuf4MSBwaJ7
    qPxcsYS02u24p+E5//E83zDFEavO3luJiBIw3+ZwtAJ+v1rJCs//Y2yBvxUfnkUyzNV6JwBUCTvWWSmqZdA+ckMQjE4j3EiIK3APR6Jgp5ydpbchBCx3d5N2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=bmzYRPLgCNMw_Vb5bs8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeDZC5T (ORCPT <rfc822;linux@kroah.com>);
        Wed, 25 Apr 2018 22:57:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDZC5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:57:19 -0400
Date: Wed, 25 Apr 2018 19:57:17 -0700
From: Matthew Wilcox <willy@infradead.org>
To: dsterba@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180426025717.GA32430@bombadil.infradead.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425203029.GQ21272@twin.jikos.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:30:29PM +0200, David Sterba wrote:
> I had similar toughts some time ago while browsing the fs/ directory.
> Access to the filesystem images can be reimplemented in FUSE, but other
> than that, I don't think the in-kernel code would be missed.
> 
> It's hard to know how many users are there. I was curious eg. about bfs,
> befs, coda or feevxfs, looked at the last commits and searched around
> web if there are any mentions or user community. But as long as there's
> somebody listed in MAINTAINERS, the above are not candidates for moving
> to staging or deletion.

Yeah, it's pretty sad how few commits some of these filesystems have
had in recent years.  One can argue that they're stable and don't need
to be fixed because they aren't broken, but I find it hard to believe
that any of them were better-implemented than ext2 which still sees
regular bugfixes.

As long as there's someone who can be pestered with bugs, I don't see
the need to push their baby out of the tree.  I'm a bit more nervous
about hfsplus; if it has users and no maintainer, those users are at risk.

Perhaps we could advertise on Craigslist or something ... maintainer
wanted for LTR.
