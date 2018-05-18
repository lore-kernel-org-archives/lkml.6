Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4167094-1526659637-2-946219885257044616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659636; b=cY0YgS+tQ7UnsQrgKZBESvl0QNkg/mMoMQeeMTe05IsdR7ffB2
    MWOVzKt0GI8f82t6CaKiyDEmrwYY/fijdwi6huzBpn5IBPTPX+MpZNjN7i+J63tP
    crL8QpP/+YPtCJMl4j8/XjmDuPEGVc7mcmI9mrFl2NPOzW6FkpXNReyBQlB583QL
    ohO+KRCnE5Kn1wyuUNb6yxEUN4s1+uugjz2rUacvLUJ4MerMCUfHQ5nFMR+bfLia
    xeSzg7Ds2iF1un84d4jf10cQw9zKx1JaKmfdDY2zH5hhYHY3U9J3hfK4itfOvPWV
    8uAVRa5pqYmKhGdDMs9yVCa9Wv7NO5QsnSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526659636; bh=FLMoZQzg1dJi88VNLZG0yX2wEFGyAh
    z7nfeQUfmC2/o=; b=iEOZPscYe5khgq8R/gMx7hUtBHtv5m/CUTm/v6/ZRdyzOG
    AtcyYWrPdySVo2ITkjCoPutBtPuZh9qTLOrfEvRk3O139q3H/WjFZt+xy9SM/j48
    xrfebluQkluHY7Bof67vMJTld1rItV2bNVC+KUrbZLU43bBbB2H0PHHy2l04rv7m
    n2fMk0qBEvO2QqAeR6BbbD4csrj6lVPzNPmEZLO/859PQq16/+GzAZR/YyePEJwY
    E5aPlz3rBJg7wU9fjjHqvRaF91s8L9Ly/p7Vvu8CcB3y6OIVpRembon10wwxKYXk
    Yp+D5HqsHLpcT0Tgqrc48RiUVGQxf03feszFTRZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=szAUdiIq
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=szAUdiIq
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAqe+hUIseKm4ildVNyhOKoAjFLZGypuQVzxeIItxlcqarTRaxeBpiLtRcKLkVZkYVovpifFlknIGAWVcPOdofVC1Ou7aaTdKbIP+zJ6GNCQ0SH4nkNn
    Lajf4SMduIU41kF+i5+TbnPcnaWIXQXHbagBU+exrtD60Jwjh7GHdDDmGjkJKu7bdpIClzxAycL+andKq1rfyIo6H80qWM7tf5qWMJ5St6ZNuHppIvgiu1n8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeERQGj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERQGi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 12:06:38 -0400
Date: Fri, 18 May 2018 09:06:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, mingo@kernel.org,
        peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Message-ID: <20180518160636.GH22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517203803.2664-4-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks fine, although I'd split it into a aio and block_dev patch.

Also please wire this up for the fs/iomap.c direct I/O code, it should
be essentially the same sniplet as in the block_dev.c code.
