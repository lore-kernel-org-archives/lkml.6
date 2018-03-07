Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1520386189-2-5067419976201880460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520386188; b=HGNJ0pZD1Bqc8f0MW5LrF53m7/yaeY5HA7fPb5M4q/vAl7G
    TIbWPr50QCG+/nyZg9D7klDi3y4H4La58ye4E0RHwygZ1XVIL4Ai6T7PR7+Il048
    RkPdrt52ZGah0inABCtJpef0LX2W2lnC5o+1LG/KhOpP3CJQLy0oWW7Tasl5oC5Z
    W13Hl7bSEoFH71/1HiaDKE+wAlvQefA4VAKHwVOk8kOIh7KAqmu9HLMV4SpSDNxo
    ZCbeFRvsS/mNW8alIiQj4QHYY5VOs0gSRK3jmOsohoLpR4tN669OloG85QOgsj5T
    pwu8fne1isF89hOYUBUfoJr9/DVVMCvD1g+Qx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520386188; bh=uOk8do5UUkU7au5Ni3qbz4lejy
    K2hbBtzcmulr66/Vc=; b=XX6jUsCTMZkRxATXPGg0zrpVCYBgelE9oss6O4JAiU
    cujKtwJ6vGISrbfKQXpm2VnvSHB0qbZCETFG0vaKzRIP0k9UVhyppDmQHpnW52UZ
    ca4WzO5gOvJc/zkeb2POc8G9lvF3NVDGhTlKBxPxbxzzJ4sirk1S1wkdO+gX6d+j
    0CdWWmeGQ0rHaK/mw1Uj6ZsS0Mpq4kkwonRe+REq1L8nOC8HVr5WW78MUu8w08ix
    36g6C0ZBCRznJhNdq+ExyluJgZABYe9clsxXrIVYfRSLtQmjI8pkALXJmnmMcIPt
    RaVz9qE+bvIfN520A4Xuyc1xAtZPQ1oYsufty8CKDO5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeCGB3q (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 20:29:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933036AbeCGB3p (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 20:29:45 -0500
Date: Tue, 6 Mar 2018 20:29:42 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: dm-bufio: avoid false-positive Wmaybe-uninitialized warning
Message-ID: <20180307012941.GA27250@redhat.com>
References: <20180222155627.1800948-1-arnd@arndb.de>
 <20180222160432.GA16971@redhat.com>
 <CAK8P3a1jpj0ZCs81YJu0Dx3QFSypQ+VBr348UfEaagcuvM_1gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1jpj0ZCs81YJu0Dx3QFSypQ+VBr348UfEaagcuvM_1gA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06 2018 at  4:33pm -0500,
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Feb 22, 2018 at 5:04 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> > On Thu, Feb 22 2018 at 10:56am -0500,
> > Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >
> > Mikulas already sent a fix for this:
> > https://patchwork.kernel.org/patch/10211631/
> >
> > But I like yours a bit better, though I'll likely move the declaration
> > of 'noio_flag' temporary inside the conditional.
> >
> > Anyway, I'll get this fixed up shortly, thanks.
> 
> I see the fix made it into linux-next on the same day, but the build bots still
> report the warning for mainline kernels and now also for stable kernels
> that got a backport of the patch that introduced it on arm64.
> 
> I assume you had not planned to send it for mainline, any chance you
> could change that and send it as a bugfix with a 'Cc:
> stable@vger.kernel.org' tag to restore a clean build?

I did/do plan to send to Linus this week.

But I've updated the commit header to include the CC: stable like you
asked.

Thanks,
Mike
