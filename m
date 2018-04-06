Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219634-1522984595-2-5829119805322677482
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
    1522984595; b=P1mYgCwA2gJitakgcWfC9BA6p1Yg/BOzjLvDIzrYOWoIqtymFa
    y0uakablUfT4Hk5UPE9XOKwEC5wnEOuZ6XggCJjCaCfRZ5VdnKLUNlWdkT0MIL80
    8iGzXA1Onh8O3Cg6IP+OQEjvFgKFwhPYqaUOaMq3ixVtREbYIHDSFoVJDkWA6r8A
    SwDq7Mcsu1bxMW4YZOpp81UD9TSNoPNAsUw7PZWzyIDNa8/aa09Jy8xPrFrCoewe
    wZTrvNgf97uxf0p+Edva+iPb/dHERwuAkUYh8HJVOwRjxULBv5iVBYhLvm6P8Fk6
    llen+yDR6sx9+1RFEovaG0ZBtIhrCYlRwfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522984595; bh=2a5rfmd8ci4K0vitRgnNb3X/GZmBz2
    a2XG5Iya7WPNE=; b=U/sM2X4H6PmYhDRCTW9GkUIrgxJd5xMvjBj7IUs44/9/zl
    br/ai0swXC85c6DNpOJ4k3CBBlMCK7MFnS/UhR0Gw//7QYm9a/zRkVKBOFq72CKx
    rDCPpO7Wlz4jiY8RlUqfAirt81BVVfkFmImGFw8sjlmA/szLMSypV4eoWZJc5+h/
    Q5aTmcJfrY7axqLhWjwSRiVCG5tG1D2gc/PNW9nOxgiSOPPD/GTrO+bffIgwt/N2
    Sroy8vKsbZ//HzXRdu2il4GjmZSFeTgi1plsnUrXNo0qKieBJdOLCdD7hu3tadlt
    meskCnvzSaPhn4LB0uhEF0KpPvz+f+RTnw9DHpUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKoipxtZwr2n8Pr8vOYxmqjMhih/K9oZpOlH1dMd0M4w4ZwJkZjq3rBsEG6+O2AZ79DCKrT7oRi58KHkjSe3I1nIEQbEFqGtzoo2LIv9y56epXiRsBI3
    KgurNyNMlupnZ8rJ5gk6rYNwNOYvRfBizFschUkpLiA1pAzOZE6zjPL2ifyiQtaxgbWEUpjJjDJqOByrOCce8RzylPpO1eYFmg9y+xkPtiacx+UqFMQZ4JWh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=zH6iRZEe8hjVWzGeBnIA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDFDQd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 23:16:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47308 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDFDQd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Apr 2018 23:16:33 -0400
Date: Fri, 6 Apr 2018 04:16:30 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: io_pgetevents & aio fsync V2
Message-ID: <20180406031630.GU30522@ZenIV.linux.org.uk>
References: <20180328072639.16885-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072639.16885-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:26:33AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this patch adds workqueue based fsync offload.  Version of this
> patch have been floating around for a couple years, but we now
> have a user with seastar used by ScyllaDB (who sponsored this
> work) that really wants this in addition to the aio poll support.
> More details are in the patch itself.
> 
> Because the iocb types have been defined sine day one (and probably
> were supported by RHEL3) libaio already supports these calls as-is.
> 
> This also pulls in the aio cleanups and io_pgetevents support previously
> submitted and review as part of the aio poll series.  The aio poll
> series will be resubmitted on top of this series

BTW, this is only tangentially related, but... does *anything* call
io_submit() for huge amounts of iocb?  Check in do_io_submit() is
insane - "no more than MAX_LONG total of _pointers_".  Compat variant
goes for "no more than a page worth of pointers" and there's
a hard limit in ioctx_alloc() - we can't ever get more than
8M slots in ring buffer...
