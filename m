Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2806492-1522256770-2-16098620726568042445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522256769; b=bt2V/HljRB0XLGrSTCDkk9qcAkpP32a8F3z0U3Iz3YWwKtV
    SmA1nbtKmLBsiypTu4W+1vjfGaTYxt867b58e3V9liThd36c/CjciXZXwMfDFe/a
    qVgYZTvcWNmfC9aD5iEqu19VRH4QMCo/YGaYioRyExsTRKisuv5TuqHJNLGBB6nw
    Gp0TrDh27GJDEAYuAzlCGLhmml9uyI25mRoUZ4e9QWO0O6KSCbxpq/3gJ/oO4OlO
    reR5D9gXgfUauLn/L0Io/Am2oM4m/AyRr2IDawoP0X2/vcah6N9yeG+u23tnnUfq
    RO9rzCRFGPDw2SDyN59vmYXLnLaL491DG02OpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522256769; bh=4n3z6H5XY8waQT5WQbDRVUP4+P
    ZySogAfa8QsW6zhXU=; b=rll15qNWbFjXTbHgNkU0Ppzf5aoZls+K6jEUZ/7pX5
    brpTzGrwekm8g1daQeKOuo0UqNoFY7eFSvYIHX3H+XFLrBQQ1xpb+Cb9uh9kVdQx
    hSnx67s3OnImrygHOLRq/rp//5rKGKU5u/ismKq1q4jC1KOgLjM+t0D92SAsu9J4
    X+IweC8RmD+u7edeVS14eR4NrnC/3x5p6XQlnsmglepqx/78Fne574lt9HOPK01A
    G/ZTtSZQx1mOGxScniZz63XEbQCxQmMP2O2sQ7ZfVpFAESNwKIB4afvWy1s1KgOx
    t6LLCJ58/k3sjkCocZJ+H+wNxsR0zawcQQl4BdTlYN6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=na8nLnLb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=na8nLnLb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTBpusisFaEjIiWsRibfCEtLcoXz+Nycb0IfRTHsx6Y5QSz4Qz5VRwZKv0OpJrqis4uHqgKcin+2103wdzwiww5TqJc6wEQKzDxkhZnFSiokfH5ORd6
    8eIIkFszTHjruML5I8D/xEqircnDBulZ5OsygVzta6FlWCVziCKzkbpsNCCrZsQnU4t12s8AX+hiUnj1lXO/jkcPEuIxEm6pWFJFefqlTveRfKfzvaux1VdY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=_CPULhhq7qT-WIy-ZT0A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeC1RFp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:05:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752859AbeC1RFo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 13:05:44 -0400
Date: Wed, 28 Mar 2018 10:05:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] aio: remove an outdated comment in aio_complete
Message-ID: <20180328170540.GC639@bombadil.infradead.org>
References: <20180328072639.16885-1-hch@lst.de>
 <20180328072639.16885-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072639.16885-3-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:26:35AM +0200, Christoph Hellwig wrote:
> These days we don't treat sync iocbs special in the aio completion code as
> they never use it.  Remove the old comment and BUG_ON given that the
> current definition of is_sync_kiocb makes it impossible to hit.
> iocb to the top of the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like you have a stray line of text in the changelog here ...
