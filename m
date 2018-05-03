Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2576527-1525355868-2-10661104312688745079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525355868; b=e6x89QMyxBYWDanXTdLu9gB6zBagvohQp3VnM0Hvc+AoZsgmtH
    rH+c9Esmrz7RTwKHk4Oxss0b7PDQ8s8gFrFeUuFKBoOSx0TFNwCp1tMWOPVs275w
    4WJjE6eObTaL1U72JdQqQZ7HfIWi7k+HznuqVudL0R7UkmBQVOggJF3M5TPAU6Ch
    37k38bX2UbqHEbKq3e32htrfB8RW2T0ckBOrWJsd8PuPMIyFJmxnvsvGC8JXlo43
    Bbz/UcvzUtIOiuEScZ5sG82B5BXlj3w4ztsViPLlUWwVlOaY+8WputbMEzuNwGWr
    o7ix7QbqfcfzCiWfDW2Rhurs40SDX5I/cNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525355868; bh=n1XD4Y/kkmuw+MYfG0IpE/HyhCORR/l2TOv1AOSIIY
    c=; b=XOeFyrFeBhN6E6QnFQJt5BrOBVlyJBOurxMmiK3075zASAcjny3rvG64sa
    PU0SR5EpJo1Nza70kwgT7AAAKQhbKS0jIV8G8x9IaiFf9DlTw0cwLZQ0SViUhThV
    04RR1wHa2IMVQcb/QnCH5/JTm3ikbwaMuGl0kMhbiNabF2+gorUK8mf0/PkfO9iI
    elS9D7hY86gnOzDJdnR3qab25Ma/yI+EKSuLR9IjC1ltwohnT5gV9V6bnsiO5Y2k
    LFUJzEAB8SGaSEyDYg8Mpfdy17yd1IwXIArCARL16IPkuGai59zKhLGzFBlyMW0v
    Lo6eKmR5MrKfGQ6MIjWryzOp7UKw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YaB5tIr2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YaB5tIr2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK3XayYwhGLFSIqdufQ45Pgejj1yfkb1UoQ/2poRlsk3fq6Or9j/pUy5ErZ6NyFdnWyyDqjAxOWqAWGY8Gq33mtsrGZAt3LQc3hu0wKdyMb6Jd4S4q9M
    QtPaZX4oer/bgJfhOGwRv14Wx/G7h6zIDS2LAzk1ucr8JqUt1YWSRI4a1kf7A/zCI0r/h9VmLqvKLpj9vvZEPlpERIzi+ByQxuJGm7yyTGDPXsBVRjEGK705
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=J44m-dGE8RsdPS0nrs4A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeECN5p (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 09:57:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeECN5o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 09:57:44 -0400
X-Google-Smtp-Source: AB8JxZqhUhUDD2uL2tcwJc5zsg6bklIdmd7ujO6NBhIOCftFTPaszJMMlyi6A8aMRXkwCEtVkZztI/F7hX0h/aHdzkc=
MIME-Version: 1.0
In-Reply-To: <20180503134317.GA30522@ZenIV.linux.org.uk>
References: <20180502154239.14013-1-christian.brauner@ubuntu.com>
 <20180502160939.GU30522@ZenIV.linux.org.uk> <CAPP7u0VPyWAsL_kkb4JnJHMmK=kM0m4zRjVjst1iHDd6V=t0mQ@mail.gmail.com>
 <20180503134317.GA30522@ZenIV.linux.org.uk>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 3 May 2018 15:57:41 +0200
Message-ID: <CAPP7u0Vy8KL1GMSFuH4UYV5JFYLLz8iJvNtq2Pp84UjmvkuNYw@mail.gmail.com>
Subject: Re: [PATCH 0/6 resend] statfs: handle mount propagation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 02:43:17PM +0100, Al Viro wrote:
> On Thu, May 03, 2018 at 03:04:36PM +0200, Christian Brauner wrote:
>
> > >From a userspace perspective we often run into the case where we simply
> > want to know whether a given mountpoint is MS_SHARED or is MS_SLAVE.
> > If it is we remount it as MS_PRIVATE to prevent any propagation from
> > happening. We don't care about the peer relationship or how the
> > propagation is exactly setup. We only want to prevent any propagation
> > from happening.
>
> So what's to stop you from doing exactly that --
> mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL)
> without bothering with statfs() in the first place?  It's not like the
> damn thing had been costly - it's O(mounts in your namespace) with not
> to high constant, and in any case cheaper than allocating all of them
> back when you did clone(2).  Confused...

That's the case for the whole rootfs. But there are cases where I want
to leave the rootfs itself alone and only remount some paths.

>
> > The above case is what I see most often. A more specific use-case is to
> > differentiate between MS_SLAVE and MS_SHARED mountpoints.
> > Mountpoints that are MS_SLAVE are kept intact and mountpoints that are
> > MS_SHARED are made MS_PRIVATE.
> >
> > For both cases the only way to do this right now is by parsing
> > /proc/<pid>/mountinfo. Yes, it is doable but still it is somewhat costly
> > and annoying as e.g. those mount propagation fields are optional.
>
> Umm...  And how would you get the list of mountpoints to feed to statfs()
> if not by parsing mountinfo?  IDGI...

There are cases where you have list of known-mountpoints or paths to
check but you don't necessarily know whether they are MS_SHARED or
MS_SLAVE.

There's also a case where I send a list of fds via SCM_RIGHTS to an
isolated process that calls fstatvfs() on these fds to determine their
mount flags without changing them but cache this info.

Christian
