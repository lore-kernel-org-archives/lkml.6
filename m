Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521624571-2-789346862011064313
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
    t=1521624570; b=O8tqyZE5IRAb9MX+rqnIBvceM5vxqsza99xTmsaEArcNplH
    xioQmnQvoNnO/8/NW1hoqrr7HHedbYBpBXFZFG6snm0jwfOMMLPykIbNAHo5qcIK
    AegpH5PNfKlBg9g5fDnfwv3aJ/zftpQzNkqd5iQd74NIZgPN2tP1ZANdpLwYUYY5
    W+8tIcEnmmLjKPhbUR9hqnw37iaeq2YYWiROwZfCQKqQKPUTw5D7NFKOI+KUJCeP
    Lijgdf04H/L1V/AobTnZVytv90/iYrwIaTrjqYilHnjNkBIvNJalxoQjLfrjI4ZO
    ryuuHnTEmuH9sV6r/lHIrI34p8S+p1EqGz2N7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521624570; bh=tf3VOgBzIe3JavLdOwFK9Ed34+
    saLJQdiByu9hs7zNw=; b=HYIFUepBMAxfUrM0v3qFO8Q0Rrr6sQ1swZFRc2GK4b
    A3nAGZHKIuIPQjvHq2YHOhSzO6S8HKUtkbdtl/d6SMPYX0AEjYiVKfdnnNNT5leo
    w67rxpl2GXsKqSbugGPQvY94sDLZsxZN8Af8k4jcL1mTJxVmPtU6cz3T/eKHMmy/
    dwr1yda0vmiu1I/+aTtp8YloNfxn/GvmiOqC74djEM0EHvWi9x4FBiJTy5BP2+q9
    q4w2pf5UIZxPGX9kh2HgBRJvgbPe0udQtHQ8Own0lr0TCiClPUV6kubfl4hWQOOo
    Uc37NAj5BrbJR/trxkxLwr8LqM5ibKbc+DzFGh+T3Fag==
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
        id S1751539AbeCUJ32 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:29:28 -0400
Received: from verein.lst.de ([213.95.11.211]:41286 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbeCUJ31 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 21 Mar 2018 05:29:27 -0400
Date: Wed, 21 Mar 2018 10:29:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] aio: implement io_pgetevents
Message-ID: <20180321092925.GA7265@lst.de>
References: <20180321073232.13366-1-hch@lst.de> <20180321073232.13366-9-hch@lst.de> <20180321092443.GQ14085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321092443.GQ14085@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:24:43AM +0100, Greg KH wrote:
> On Wed, Mar 21, 2018 at 08:32:31AM +0100, Christoph Hellwig wrote:
> > This is the io_getevents equivalent of ppoll/pselect and allows to
> > properly mix signals and aio completions (especially with IOCB_CMD_POLL)
> > and atomically executes the following sequence:
> > 
> > 	sigset_t origmask;
> > 
> > 	pthread_sigmask(SIG_SETMASK, &sigmask, &origmask);
> > 	ret = io_getevents(ctx, min_nr, nr, events, timeout);
> > 	pthread_sigmask(SIG_SETMASK, &origmask, NULL);
> > 
> > Note that unlike many other signal related calls we do not pass a sigmask
> > size, as that would get us to 7 arguments, which aren't easily supported
> > by the syscall infrastructure.  It seems a lot less painful to just add a
> > new syscall variant in the unlikely case we're going to increase the
> > sigset size.
> 
> Do we have a manpage for this new syscall and maybe a test program for
> it so we can exercise it as part of the kselftests?

The man page and test cases where submitted to libaio:

http://git.infradead.org/users/hch/libaio.git/shortlog/refs/heads/aio-poll

In the meantime the man page apparently moved to man-pages, I'll do that
work once we make some forward progress.

> And do we really need a compat thunk for a new syscall?  Ugh, I guess
> it's needed due to the long mess, right?  No way to just define it the
> same way for both arch sizes?

Not without making it a pain to use.  It should be a drop-in enhancement
to the existing aio abis, which all work on these types.
