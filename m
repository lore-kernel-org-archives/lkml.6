Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3147645-1522942810-2-18371103734177417163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522942810; b=f7QtqmVD0YBDC7Wa07cVB9Pn68/PmTVbtTuB6LVVWDNH4EbOJk
    LazaBy3t1j97YBf+BzbjBvepw0EN0bCQda3FESfMCktUEhPXbpG3cDmNDYZsdW4g
    Lr2aGfpBT8aIJiqNsuQo4oNA/OVxKoq1CRheKYfzvWQT6cHcEp/QWm738/WhzEO+
    1CwFg0MQvT9HXRPqheDasYdzudwrzlTetb+m4yQdPAZu755a//K6xNU9LLXb3NVd
    5lDFx9ZJe549z9iha50menXu7cb3KVh9dMifpbUk+S4zMD87x5goVY0EFeWzrYLy
    xUyUS2xyYztR6OsNgzEOu6yNDu3Q7Nyaw+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522942810; bh=V1iMT86t3f7cVH8gxJA2Jujtn55VxGYxQNqx4EWKhx
    k=; b=biRoDtoF2gOsbH0ZkL6QtfQZBe3S6FOPnCZKTNvOy35uoCL15mnl2nA9h7
    6mMvMusFSxU7cLDr45qoUm+0DBwUZcdooFS+zTKpMduRZy/5PoxRb52SfK7zSP0G
    jP+aaiVvklzRr+JlCyAJ9j4iNyLyPS7gohjvl5eA5SV3qU63YDkjajHEH7TOma3u
    nqFmQzcOYs2s+wrneY6rY33du4D9ZsURzQG+zSSFNL/TPek2d0rqSL5urdW2tBxw
    5XZLPIU2C4I8u+igKxc3qLaDMIw3TqHGV02NybSK3XeHnb32fxw4G25Y8sECeK7s
    KqJj0k+UhZuF/rg47YcOnrnbPM/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iL61lSzw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LUbhtONv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ron1Lu3n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iL61lSzw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=LUbhtONv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ron1Lu3n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDQuGBp1jRxatW9qP/dFoGKirrOW+YQElDY/HglpYaXIoo81jvWPaHQ7vQ9p8T3dRmjOLKYogd2tJhX25J+ftwfOUo9lh+TRRH0fylGvWG+5lukCabUC
    Q9SB7mq7sD8zg2RWm2JWOfVYK/Du+o1mVqSqR/0gDUbqJfhN1RvPDMZPY4GsQDcASsnI6aZZEhQM/FX4WEqi3igk3fKiYjHGqtmOqo2Rr7zZAFDcU3qVdWyJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=UmvJPMm-ZRykjxscwo8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDEPkI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 11:40:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43618 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEPkH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 11:40:07 -0400
X-Google-Smtp-Source: AIpwx49rJlRzCvQP04Nrd8woo84YQB4iF3tAXuzXhlSaCws/tZuXa8Tlc7jb09lXI5wfWYZctetlW802Uib4snTZX44=
MIME-Version: 1.0
In-Reply-To: <20180405171009-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
 <20180405045231-mutt-send-email-mst@kernel.org> <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
 <20180405171009-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 08:40:05 -0700
X-Google-Sender-Auth: kPY2nTktOeYOwjUGH7RrS07UZbk
Message-ID: <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 7:17 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> I wonder however whether all the following should be changed then:
>
> static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>
> ...
>
>                         if (!vma || check_vma_flags(vma, gup_flags))
>                                 return i ? : -EFAULT;
>
> is this a bug in __get_user_pages?

Note the difference between "get_user_pages()", and "get_user_pages_fast()".

It's the *fast* versions that just return the number of pages pinned.

The non-fast ones will return an error code for various cases.

Why?

The non-fast cases actually *have* various error cases. They can block
and get interrupted etc.

The fast cases are basically "just get me the pages, dammit, and if
you can't get some page, stop".

At least that's one excuse for the difference in behavior.

The real excuse is probably just "that's how it worked" - the fast
case just walked the page tables and that was it.

                 Linus
