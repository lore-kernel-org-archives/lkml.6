Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3377482-1527036567-2-6912545684356149715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527036567; b=hqQH9GkqdqgGtzPHJhyx0cDStsE2ESZYajbbOSHHaCer1s7Sya
    oDHPGzv1AfGGFpOAxeJDlnvkWTNH62cYlrhzVCSLq1PUqoGKlE8H0zuIDzeojwiY
    41FewGjnXuvHrf8WPeLNqMmv4OXJDi4w2Xx9fw6dHWZYaLF5ucBzj9UeQYGK8GkN
    zOnwYFnTGtdkdDYHH9/ou6EjK3FqT93BTf5KANiTBmuKm4i9sfUF+bj00fnYQ5I/
    72lrh8tofkNuwyuTz5A7BW+pyzxvcbqsFHXXaFqLEW5F+iBV9g0H/uox7w5cmh64
    oZnAXLygYF/flbmmd9pgDJ3ctNn+CIfCKz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527036567; bh=qDNR0Mx0X5JzwKZ5JrDtIuPqs/B70E
    UaPhnQPrehn40=; b=R3BF+woyFoKA0vwM4e18XLwsD4qYSlCctZdYtMRQweiriG
    gbzGeeHb1dY5TLDc1wLulNc5jFTPBP3KoClnrOIoXXxyH57x3BAyt64z4ByINDCn
    mLoL7raEcwTPJ9TCvP2/E/e4ekLGvqmoc/h031hTufl+Nj9iYkmO/9BR/jtU289p
    WtW48a8UtSQLDxo7P76IZ9AVeo9GVk5mXNbB+hcpzauMLl4egqA3+l5KAUBxv+xH
    NaLvAFRLRO4Mbobm/3wT7ci242MY1fsU1LF+aEY5NIl69TbCJThfdQIgru46PkoP
    Gs0KmJkfHPuzoV3t3OyQ9gMelOcgnNYsPtVf4OsQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJR01bSrdjMBdNKvF1y0mfDwu8wkLMx6ex8Ql/a7c+d5UvvDYIAVMZyvWnIL22dymqkEkJREU4t2dNLeHb+ejsWFZzQexGIrs7Yvi38tPaQ2xmvM9mA5
    2i86f+tXaI/3lYvMh33wh6lwzROvwdHLufYzUVNzmOtac3tUJWbFqUy4gaf/m/sJcsSHBCX14kgstYV94e8PptXa18HZVPrF9MBpL0SRHmaweWzREQcai8yY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=47cuo1_IehaNXlfTa_IA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeEWAtH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 20:49:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52978 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeEWAtG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 20:49:06 -0400
Date: Wed, 23 May 2018 01:49:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/31] aio: implement IOCB_CMD_POLL
Message-ID: <20180523004904.GH30522@ZenIV.linux.org.uk>
References: <20180522113108.25713-1-hch@lst.de>
 <20180522113108.25713-9-hch@lst.de>
 <20180522220524.GE30522@ZenIV.linux.org.uk>
 <20180523004530.GG30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523004530.GG30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 01:45:30AM +0100, Al Viro wrote:

> Oh, bugger...
> 
> wakeup
> 	removed from queue
> 	schedule __aio_poll_complete()
> 
> cancel
> 	grab ctx->lock
> 	remove from list
> work
> 	aio_complete()
> 		check if it's in the list
> 		it isn't, move on to free the sucker
> cancel
> 	call ->ki_cancel()
> 	BOOM
> 
> Looks like we want to call ->ki_cancel() *BEFORE* removing from the list,
> as well as doing fput() after aio_complete().  The same ordering, BTW, goes
> for aio_read() et.al.
> 
> Look:
> CPU1:	io_cancel() grabs ->ctx_lock, finds iocb and removes it from the list.
> CPU2:	aio_rw_complete() on that iocb.  Since the sucker is not in the list
> anymore, we do NOT spin on ->ctx_lock and proceed to free iocb
> CPU1:	pass freed iocb to ->ki_cancel().  BOOM.

BTW, it seems that the mainline is vulnerable to this one.  I might be
missing something, but...
