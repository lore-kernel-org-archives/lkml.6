Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-683775-1522998636-2-788252740350642799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522998636; b=OsA4W4wvfowZuZNkB3hA6Z6Z185lzt1KVWXtjVbLgELaMiDGWL
    cGPabbJB3VrsgTwSzpnwA+B3Nibwr7tW2jvKTWwomCGBkhkzgYvhCX/o1PiVdOTr
    i7TSXq+RnZxmrAuun+88402zpmr5Io27ijcNm7gb5bVppFabGs/x9N+xGkr7FxAY
    JMNmIsTx/g+FnCHo6r8M15ArBfRDxwo/XLYzT4c5T/Nm5/jrqmjxQ3E1nswc8ie2
    kxDlEsKmqub4e3AMYRC+KwuIKKgLmVL+Cm8dKnTAkVB08AeXgz2MVWkghQ76ZwGl
    zUB4sYZH3HZHBy935dkWobKKHHIncqknYEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522998636; bh=R7asjAX5kOTH7Agb0hA/HgX2B9tgs8
    sY66/VHxHEMaE=; b=ZWXU53uuHKUkpRPmRQdHU3yZEu7UYKnE+lB7mDZaAUJeDp
    l57TP5meNy3e3da6IepaSi4kzw/s69L8Edtqkg/u8L6rtULC6RdMP1fA9ZPCxPI1
    4sFJPTyU4GSVkLbKKToXcf3lgKy7vpFyPOPBButp1vKesFP9lMvBDdmqGHSv585i
    2ywC6+3uIzljGmDTRnIuZWwK8gucPJ8HO5/1wnYSfhoLTnZ6/FfowkfcZyS6/SY1
    Jw1jSM+t+NECwILRXIOrleOO9hyfs6Mn3uYVzUPaw6GDy9vsRbinQK7sSr7vR++X
    T76daSkgi20f2FSdgb6PJq321jUSio5oBo3l6CkA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/nS6AeUFjLgdNkjymk2m0No2+0uNjQB8qcoD9N+BJDCr8OCgXHpBXND7muQ7Bfn0Y5wBjkXrSYvNQptp5S+3iRDowdlCyLr6XK2PxrqgiC7BeMZnx8
    wvon+HdsaBr7llgaE2T961jtp2vyuchajmc51ZazMlANIP8xOD/NGz3zN5bIpSUjsWrIQ3Tc6e7XGlNxF4BUE4SURfa4mwg0uOVT3EFCY5bdehLVJPcaRes1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=qTmm3ATgxqVC_zR2hPQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDFHKU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 03:10:20 -0400
Received: from verein.lst.de ([213.95.11.211]:53765 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbeDFHKM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Apr 2018 03:10:12 -0400
Date: Fri, 6 Apr 2018 09:10:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] aio: refactor read/write iocb setup
Message-ID: <20180406071011.GA21308@lst.de>
References: <20180328072639.16885-1-hch@lst.de> <20180328072639.16885-4-hch@lst.de> <20180406032146.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406032146.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:21:46AM +0100, Al Viro wrote:
> On Wed, Mar 28, 2018 at 09:26:36AM +0200, Christoph Hellwig wrote:
> > +		struct inode *inode = file_inode(file);
> > +
> >  		req->ki_flags |= IOCB_WRITE;
> >  		file_start_write(file);
> > -		ret = aio_ret(req, call_write_iter(file, req, &iter));
> > +		ret = aio_rw_ret(req, call_write_iter(file, req, &iter));
> >  		/*
> > -		 * We release freeze protection in aio_complete().  Fool lockdep
> > -		 * by telling it the lock got released so that it doesn't
> > -		 * complain about held lock when we return to userspace.
> > +		 * We release freeze protection in aio_complete_rw().  Fool
> > +		 * lockdep by telling it the lock got released so that it
> > +		 * doesn't complain about held lock when we return to userspace.
> >  		 */
> > -		if (S_ISREG(file_inode(file)->i_mode))
> > -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > +		if (S_ISREG(inode->i_mode))
> 
> ... and that's another use-after-free, since we might've already done fput() of
> that sucker by that point.

Indeed.  Not in any way new in this patch, this is an existing issue
dating way back that needs to be fixed, which will be rather annoying
without taking an extra reference to the inode or at least sb.
