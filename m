Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219634-1522984925-2-10377939378214667450
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
    1522984924; b=aITtXUUlatJP48+i5XHqvCihQFODR+g4n/7OOYdjsVNkY+Q47P
    ZQrJq3metuNYljO2mqmVN1jJjL3HDnNr0E1oThzEbtnvmuIn3Bb1417rSEztRxf3
    adfnEatjQbC06igfAUzmEwj1dXs/6uhKeSz+VqGpMeyLtbEb6Xi1L/KCMyGsRhkp
    drBwuyBuXIORn4B+CzjRbmO4AzokO47LtActkaNuIxSlwl9OIz2Ewd/JcgPHfUKP
    old7vijy1m+SR9ia5LH4Ck9gdUtxN+nEPEf0FcA3QKWtjEMCIOHmL0nfdIHb+ZlM
    XruXgW9JzWuPKIwIjtCsvZYznE+SsMIOZw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522984924; bh=yWSu+nE6bjEnHHZTGcVO0qsjer5uaJ
    zemWbpcMVd0Hc=; b=TJqEmcXZGljek6bNAVKUX/LWw6tjZb11NwSSOExRdCvhpr
    eG97DZDlSQecedZB+avmgPZ/gLYgCdyZpFPOrG8fE24bRXBeS/7V+l8TIe/13I0i
    EXomoDkPXnyeMhA1exAb5MzQB1CD7Cfh7GcgNqGuZtIhxVUZ3cLZ8yVQCqU3xfAI
    MCOleFxQWIUrRgoxb089mp5hPCKqmlL3tZ8goMaebnJW047azjpQpTVb0XPxp7Wq
    H9pjYsg4M7nF2SQRvhppssCJKSoatXnoYzriytHReUB3bOeTjUXgidn9z3lPKwh4
    SYWK5JGZXj7h9io4qU+5v0FeJbdausbU3zKI070w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfM3GiLlJqyTL197ligIo5cWe60xn4J03Q1DjT5Hju4osnkjd1kbB5QvcAS1A+ah8qvlA5e/ZLXuKIGB5paqRdnIWtD5897HsFY7ThAC7UGSZKC0bgxbW
    8sFt7Iu8A31X5BZ57h1m3oJtzxNwHjccpgAyfCaDWL6ZSdnShC523H2jyxNI1jPpQqOQnJL18OMX7afpKbMSc2rSHXjVsYiPfgFI7UiUhc4e1hYmsfpxHm2z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=9sPvCzdGgorSyMU6kYgA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDFDVt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 23:21:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47390 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDFDVs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 23:21:48 -0400
Date: Fri, 6 Apr 2018 04:21:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] aio: refactor read/write iocb setup
Message-ID: <20180406032146.GV30522@ZenIV.linux.org.uk>
References: <20180328072639.16885-1-hch@lst.de>
 <20180328072639.16885-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072639.16885-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:26:36AM +0200, Christoph Hellwig wrote:
> +		struct inode *inode = file_inode(file);
> +
>  		req->ki_flags |= IOCB_WRITE;
>  		file_start_write(file);
> -		ret = aio_ret(req, call_write_iter(file, req, &iter));
> +		ret = aio_rw_ret(req, call_write_iter(file, req, &iter));
>  		/*
> -		 * We release freeze protection in aio_complete().  Fool lockdep
> -		 * by telling it the lock got released so that it doesn't
> -		 * complain about held lock when we return to userspace.
> +		 * We release freeze protection in aio_complete_rw().  Fool
> +		 * lockdep by telling it the lock got released so that it
> +		 * doesn't complain about held lock when we return to userspace.
>  		 */
> -		if (S_ISREG(file_inode(file)->i_mode))
> -			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> +		if (S_ISREG(inode->i_mode))

... and that's another use-after-free, since we might've already done fput() of
that sucker by that point.

> +			__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
