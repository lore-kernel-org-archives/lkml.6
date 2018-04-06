Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1291772-1523017745-2-8761663779378939874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523017745; b=iokwkUEw+C9SE5wsPifj5RN+b9nqxJk9L6fdhwdCI2MSHGe0Pw
    JUPC3n5/05Mn/IVYdj9c6f6TpkmgRahSEa3jsWqdYSVCLQXTsmnwx4XXFk/Hh/wo
    qmhU7BTQwrdg86ACcMrCHxRCEfqKb7nD9Ogxw42F11pkBA1LgG4WjIpL8Fb6tnGl
    zBY5PypvnvM1evL11mAchJje9x3Fb8loS5b19lAchS05FAEi8h/A2MJuTWYwZncc
    eT1as2PjOlR++Q0ZlSOkS4SqoyiEd6qvi3wx9noQigC8cqH3QNQ9QAGuQRYJ2bwR
    Z6W8EqwBZa5RpFkemAbEFPNMp+R1Y10B+o1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523017745; bh=9d82opI7mgbVyHr4Fs18emB4CTaFZ7
    5K/BBB49RWFz4=; b=EMf5zOFxHGj1WQeMocfG/0+AEtTKkG+vIWp8cn8k0w9qS7
    TS6V9vRVuEiYeUjF8M9ujOq4QJ+NdD+N0lNTEx+7YQAbv2KeT+8JWcMXjFo4qbI2
    65l/D1SndM7qY82/E54yvPJy9H95/0UC66DHvZrD6FNWERuua328jdk1xBU8tsL5
    xlyypb/wgY5pA+QU/xAt5XAVz6u9ALQOlmIFn45GGLmAKpmeUE9L5Oo81xrSShdC
    qaRv8i4xl+dLGSAK3hhXDf16xIaMwLbZjiBlR2w5oSpN8w9w+gawVk0uUHj71Mlm
    StSfgd/VTL6qH+54bHmgJWw987JZe62DG34uvT4Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC1+3o66lUDs1jVfQn4VM2epyWHf3tWAt21AXhf8eGmk4T/B5/ey5K3vOw6BDNt4IGidW9Y08SitDUkgCF5sGaOvP0dixw+yQjBZ++nwe2TvyyHlI3Mz
    +poaxRg/TgQar3G+hEKVUYfb6RVdFhXfbJB54X08FN8z0ZQfZwLWr6g3wD83yS8BJcCzz4f1fv2SBTGx5gbZOg8lFkUgPI7mvvW65LBE142jwCraTxgl0DIe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=LJFpoY2_ZRb07_Zo_YIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeDFM2x (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 08:28:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56808 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeDFM2w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Apr 2018 08:28:52 -0400
Date: Fri, 6 Apr 2018 13:28:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] aio: refactor read/write iocb setup
Message-ID: <20180406122848.GA30522@ZenIV.linux.org.uk>
References: <20180328072639.16885-1-hch@lst.de>
 <20180328072639.16885-4-hch@lst.de>
 <20180406032146.GV30522@ZenIV.linux.org.uk>
 <20180406071011.GA21308@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406071011.GA21308@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 09:10:11AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 06, 2018 at 04:21:46AM +0100, Al Viro wrote:
> > On Wed, Mar 28, 2018 at 09:26:36AM +0200, Christoph Hellwig wrote:
> > > +		struct inode *inode = file_inode(file);
> > > +
> > >  		req->ki_flags |= IOCB_WRITE;
> > >  		file_start_write(file);
> > > -		ret = aio_ret(req, call_write_iter(file, req, &iter));
> > > +		ret = aio_rw_ret(req, call_write_iter(file, req, &iter));
> > >  		/*
> > > -		 * We release freeze protection in aio_complete().  Fool lockdep
> > > -		 * by telling it the lock got released so that it doesn't
> > > -		 * complain about held lock when we return to userspace.
> > > +		 * We release freeze protection in aio_complete_rw().  Fool
> > > +		 * lockdep by telling it the lock got released so that it
> > > +		 * doesn't complain about held lock when we return to userspace.
> > >  		 */
> > > -		if (S_ISREG(file_inode(file)->i_mode))
> > > -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > > +		if (S_ISREG(inode->i_mode))
> > 
> > ... and that's another use-after-free, since we might've already done fput() of
> > that sucker by that point.
> 
> Indeed.  Not in any way new in this patch, this is an existing issue
> dating way back that needs to be fixed, which will be rather annoying
> without taking an extra reference to the inode or at least sb.

New, actually - mainline has get_file()/fput() around the equivalent area.
