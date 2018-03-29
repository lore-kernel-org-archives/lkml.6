Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-387209-1522313590-2-9469578184969883197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522313589; b=Si26YOH0TDKiPdX3FLE1lbCF89AJpaD1ft3cIrIWzHpkM81ouS
    Lh+CZHeXIL4jIW2M7qjY4WiBMYvY3cj0f1ExoP76uQqYY2u8NXE7rQhp9HliO9IY
    XXN7Ct4QnffmLUbpStOXz0OwMDnT4WH6bBPFW0HuYz6RhvSb2tLSgPTCfnQuDF88
    9OMgKlM9onwc/f5ci1Mo3AGW1nV9W/kxW+QMnlh2alaqjTKLY5A7H3oPR2i6b9e3
    Umx4GPdrK57wuJxw+dSdiZNbI+yCOdR/XFhyAvhelywCwtaChbMp3l6jg7rPhZGm
    u9cKonXUVzAq/f0bqVugwNSSfDpbgbfO3ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522313589; bh=msVXc3UBrPpN2lWeY2xbfEseVVjomH
    f1A6D+6m7/UH8=; b=Leh3B0JORjLNuCS5WfjflSarSYtt2UsK+LcUhodI8txRXU
    D0HEx8ZMjJUQKHV7DpQM0LN6UDCOkwlepb6ySo8O+cvEhQ181VZoJ/t93TRjq+lM
    6c7OpUHUWFdFdEIeKSxPz+2YNPo3z4qk4HQTeT01Om0Ze7BX3pZhW7Qpw/ZG0vBq
    DvTRQE0088+sCMjtX2w6m5mGmkGdDbfJb/1ZqwLgPRNOppWLHMdlpNltthVBDmtK
    yEfg0SQfbHYNGk6fLnt5iOrNvYWx3EfsTec9rbCLgGMz4W9L8Ws6N0Fr/etgLVAU
    gaPmNvvG6/X3ak588HvLH/UOgF79ydwFnEsoMmmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfEt5vR4QlRdFjr8S8nGdX9xl0j8NLB199sj9x8//Bt5fuZxVjizAZuMHGjftXYhpBCI0FqcKpt0ho5FQpC7WXsHkC6PtC/z2GbvCN+qYgB39rCoidjyg
    I0m+vb1x4punzpnusrGPSW7FUAB9E6x9UPRS/Q1HDu0cc2ygAxN1CNlGQYsi7zuqcJDfPCE3/+f6mMp9FVwXHlYIw1eY06iyGV36Q1R7y4MrmjCD1e5PIypf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=6rnCn8PeDZxWnYrfHDoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbeC2IxI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 04:53:08 -0400
Received: from verein.lst.de ([213.95.11.211]:49386 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeC2IxH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 29 Mar 2018 04:53:07 -0400
Date: Thu, 29 Mar 2018 10:53:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] aio: add delayed cancel support
Message-ID: <20180329085305.GA22215@lst.de>
References: <20180328072926.17131-1-hch@lst.de> <20180328072926.17131-8-hch@lst.de> <20180328163526.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328163526.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 05:35:26PM +0100, Al Viro wrote:
> >  	ret = vfs_fsync(req->file, req->datasync);
> > -	fput(req->file);
> > -	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
> > +	if (aio_complete(iocb, ret, 0, 0))
> > +		fput(file);
> 
> IDGI.
> 	1) can aio_complete() ever return false here?

It won't.  But sometimes checking the return value and sometimes not
seems like a bad pattern.

> 	2) do we ever have aio_kiocb that would not have an associated
> struct file * that needs to be dropped on successful aio_complete()?  AFAICS,
> rw, fsync and poll variants all have one, and I'm not sure what kind of
> async IO *could* be done without an opened file.

All have a file assoiated at least right now.  As mentioned last time
finding a struct to pass that file would be rather annoying, so we'd either
have to pass it explicitly, or do something nasty like duplicating the
pointer in the aio_kiocb in addition to struct kiocb.  Which might not
be that bad after all, as it would only bloat the aio_kiocb and not
struct kiocb used on stack all over.
