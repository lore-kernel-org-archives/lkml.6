Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4169591-1526659463-2-1892518292246085122
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
    1526659462; b=FFvo4q3eouV87pH5vkRdIdNiZep4oZhEEZba6A8cZqxf/4uuw1
    cXEb8rRIDo0yPCUkrqrqrb586+E2mDcvqggO/JdNgaj/aUgQKFmeKUxIwVsrapHY
    av2janU0HSUoGItXqBTVg72JI8i7/GZpnSX4VWfKZ79KdplGGXU+WlGxbzAKKoDl
    aAJv+8TNQBElgZj14z33nfmbab97kb1hX3opkYvp65aFurVHjDnb4FaRtHmMa2P8
    Kv7ucDQk3H79n+F8CeFODmLTigW07E29yu9VMTi1oolIY18GlcbApEw6DnyQbD/F
    PAYZ6ZD9mY9BR/L11pFVOg1ptkCzxheaS+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526659462; bh=8OcqLMs6f8SUQFD5R1cZfF48fR/Q0o
    y+FTVKDsOQZHQ=; b=l7qK8zsW4LU51pI3ylInuhIZVvWrYEN4s7vJ82JklC5Nnp
    xbyVH2oFNEuuYJPXGXi1jh6EQVW9lBxoCFWI4MvB5uawmRzFgvDxWnpNgtLtH6lN
    ExBd5XjI8tRof/a6uvKxH1At1hezHMm2qZw0GaRO95YO4GcsfYnqKixQmc+HMXrx
    0zdf7TgDLGk7MYt8dKV8x0TVd2dtdtzw0VxrbvRgUkXtrCrbF1Za0hkAnMIY21I0
    U11xfTy2dlJe893DPhnRMeoeLhikh4sAnxr3B5OmSRQ9Qf8re5YXSTDZyNw3hyOp
    9JcNDZIC9HOwVlRcZfleFeMXJWyzikQA75myPIow==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Vg3kNLwA
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Vg3kNLwA
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
X-CM-Envelope: MS4wfBFEO9d02OQgtJy2G+CTeNsdQkuPp5cOjlqAPpi6QHiHnSEPZbU1yQYzQQQ7kAdUxp6R6Gp51mLr1futRV4lcJz28Z/bBL9MvwCmYJ8aN7HaTtJvwv5U
    avoznCKNFNg+XydymTjNjUbYIswNUMzjW0cpZIHK33JCWwjh24xwBir7uR9vtfY1WcpjdTHxDc7hV7426y3Dr9NYDlkkr2/zwCR0Wu/RznwLW6dGfKi2GiCt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=SZYk79q30zLShwuLchAA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeERQEV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 12:04:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeERQER (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 May 2018 12:04:17 -0400
Date: Fri, 18 May 2018 09:04:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org, mingo@kernel.org,
        peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/3] block: add ioprio_check_cap function
Message-ID: <20180518160415.GF22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-2-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517203803.2664-2-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 01:38:01PM -0700, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> Aio per command iopriority support introduces a second interface between
> userland and the kernel capable of passing iopriority. The aio interface also
> needs the ability to verify that the submitting context has sufficient
> priviledges to submit IOPRIO_RT commands. This patch creates the
> ioprio_check_cap function to be used by the ioprio_set system call and also by
> the aio interface.
> 
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
