Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3138558-1521736443-2-13535316171006685705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521736442; b=dEemIB1D35M4fBZczc+Txlf9EJn8ckOxtVAPJugeIIFTIeh
    X9TKJFR2cBL/cJzzdyQl2ZiXkeWlrYq/AkRaC418n3lKgR3M5Cm0PdjNVYJJteP7
    RMye9PN3xLiJOIsIXLXqBTCa/IUuuDyJtWo+djLYuCwrcNPHqXhMaYsxwqmbkWm+
    fiLf1wK2EDH+qm1tgfyK/pZ9fXkol3N+R4rnY1QE0Pqr+oA4QJjeap6gpINu6hOi
    iI5Qpir1s3ZFGwGw3bzp0jSF6UtLutHlFMNtrhgMFfH5suy0tSVNXn4lKE9YWgxP
    4zExy1FBJgo0SJFn8xz46QJH5wtLJRhBWYj0UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521736442; bh=xG1ANNrWq2El9743k5K21lKjdV
    OvcFXvKTAQujSKbSA=; b=e0JZN180VQBA2VmHblLnWVaV7QyTda8zxVoBpicIkL
    bTM8MjWlnzj6VIBuNexEhFZQKdveTDAsXs52pSeGCHre+flqqO/FzngWKq8YKRat
    S7hB7yjOI3pILfJ0Lw/PP5e4CKZpgZ8o4QH/hGbSweSyumOpOc2Vzluvm/U8rvVe
    YOxW/wno8cqHe4ecevdAC4CON8AK5FL6IkfVUMwPY8WgGU/cgwvLHgNfftcSoO2k
    Z8O5VXNiptPOPm9ro0ULEAbuxyI0ZEfqtPj0QBSX4Z6d+FrvQhD1rJC3D3k/PimW
    z2F3ORRjYYlwKJhCKtY+nusDfQ3PiH9apPS2QDXfyN5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeCVQeB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 12:34:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35302 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCVQeA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 12:34:00 -0400
Date: Thu, 22 Mar 2018 16:33:56 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] aio: add delayed cancel support
Message-ID: <20180322163356.GG30522@ZenIV.linux.org.uk>
References: <20180321073232.13366-1-hch@lst.de>
 <20180321073232.13366-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321073232.13366-8-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 08:32:30AM +0100, Christoph Hellwig wrote:
> The upcoming aio poll support would like to be able to complete the
> iocb inline from the cancellation context, but that would cause
> a lock order reversal.  Add support for optionally moving the cancelation
> outside the context lock to avoid this reversal.

Ouch...  Seeing that you've just taken out cmpxchg loop out of kiocb_cancel()
with "serialized on ->ctx_lock" for explanation of safety...  Let me check
the aio_poll side of it; this commit might be better off in the poll series,
*if* it is actually correct.

What's to prevent double completions there?  Suppose we have iocb sitting on
the wait queue; cancellation callback set, so's "delayed cancel" flag.

Now, somebody tries to cancel the fucker on CPU1.  With ctx->lock held the
sucker is found on the list and, just as we mark it "cancelled", driver sends
a wakeup, executing (on CPU2) aio_poll_wake(), calling aio_complete_poll()
(without ctx->lock, so no exclusion with io_cancel(2) on CPU1), which checks
AIO_IOCB_CANCELLED and does not notice the flag being set on CPU1, then
proceeds to __aio_complete_poll() and fput() in there.

In the meanwhile, CPU1 has taken the sucker off the list, dropped the    
lock and called kiocb_cancel() on it.  Now we get aio_poll_cancel()
and __aio_complete_poll() on CPU1, with *another* fput().

What am I missing here that would prevent such a race?
