Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1722532-1521560346-2-358291713821875593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521560345; b=XcjtCqM/4O/NzAyvB590PfFLoF55aAUZl7hqFA8FMqOxF7c
    kHsaZtwHNz8yBrD8/bhg7gI0W2/yz/Xh2ycyRTte9OrgmBjjhnTlXPo63tFd9pT8
    LcNvBb9z7m5MqlOKH2UUEeT1Ai6P3fxQGOHcht/FmdPnwJJbiFNt/LBXW82xv/he
    YCzpzwMmRmZplPNXuGTp3mGmqGBbl5H3S4x4OISqlXVczNGRsv8QZf5ff+qx23Tr
    LsY5kd87A/zfNITKsKgLsUjUTb2IjBhBC9a3wP/mJtrVdEJ6Z6o0ct+gDgPaOfGk
    9KcZbo0egsIPTcKyvCqmHI1fEHxhOLZqT7bCz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521560345; bh=+rk5jYJ+akbSxItmNX3FCrRxV8
    oZFU96yMCmmPX68Mc=; b=PZWtNDKSy0cMdiMJZSnlfPtScFdjkzze5njvaTSX4U
    Cp2+StHM8zuUusKxdLbHuerJ7zlxwOTNowJv1bq5EMWUCju67WnWDOo+ubolYTe/
    NUD9UTnnHr887gacQlHZXXXaIVaw5e0AVGxOYO0PtsjLVRm1ViN3z15W476WnPYv
    OYF8KglJL2ONkIJIrk6YxRTJrUDsb8NOkw4WUv19SxavAPh9G4SfUkMpXMMa5AKe
    ujabzMHZkesdR2vdp4XSUhULjUtE//83hgstbDkk9HRAh/YyqZ1nN0VegWO+2c+Y
    mzxoge0WgKYdPl4hLchA0LkgO9TajqPxGp4yiKSwZM1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeCTPjD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:39:03 -0400
Received: from verein.lst.de ([213.95.11.211]:37798 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbeCTPjC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:39:02 -0400
Date: Tue, 20 Mar 2018 16:39:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/36] fs: introduce new ->get_poll_head and
        ->poll_mask methods
Message-ID: <20180320153900.GA24355@lst.de>
References: <20180305212743.16664-1-hch@lst.de> <20180305212743.16664-14-hch@lst.de> <20180320032938.GK7282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320032938.GK7282@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 08:29:38PM -0700, Darrick J. Wong wrote:
> On Mon, Mar 05, 2018 at 01:27:20PM -0800, Christoph Hellwig wrote:
> > ->get_poll_head returns the waitqueue that the poll operation is going
> > to sleep on.  Note that this means we can only use a single waitqueue
> > for the poll, unlike some current drivers that use two waitqueues for
> > different events.  But now that we have keyed wakeups and heavily use
> > those for poll there aren't that many good reason left to keep the
> > multiple waitqueues, and if there are any ->poll is still around, the
> > driver just won't support aio poll.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I've been wondering, how does a regular filesystem connect with this?

In general, it doesn't.  In Unix regular files aren't pollable.

> Also, does anything implement get_poll_head?  It looks to me like an aio
> poll provider has to provide both...

Yes.  Everyone who implements ->poll_mask also needs to implement
get_poll_head.  For sockets we just happen to be able to use a generic
implementation in net/socket.c for most of them.
