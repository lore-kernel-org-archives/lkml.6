Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20CDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB02081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEWXr1tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAB02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKJKLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:11:55 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39559 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:11:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id 192-v6so2987172oii.6;
        Fri, 09 Nov 2018 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSGiimb4wwQ0/s+NRUDVwpBe1mUBs+4hLpom055mtdg=;
        b=dEWXr1tWeu1cFQXd1B+yz7BpPPlcUXnx0ludlx5wd1xf7YrDsYtWK6vybi28WTs/kX
         HYkf/AKePyd941zdHQJN3Nh/UmZu0pp9QUxIUhvxae/x0JuQL/G/uwAwBB7Ahz0CDC/8
         lml/9GE9KlpcVb/Qu4mvHCjj9ZK/H84GyMTfVK+bacI649qreHi2wxjw19Zda+g98ybt
         WDXMAcA8K7w8fbqNWKZ3Qw3qLkzJgOT2nq1/FoPJ+/J2NDy9KydfSYrepwjF1KS9qn4V
         oIsIdrxQ0Lg2OqwXsoG+OIeT1Ga3SJ8WUsAkoMLSU8SUdWfOw2AuoT9tspQBJ3THg9UZ
         t4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSGiimb4wwQ0/s+NRUDVwpBe1mUBs+4hLpom055mtdg=;
        b=mjdx2ESrsSS1iwp14ahj1bGbnc0KZ0WgNrfYZ0xMZwDk014AzI/OjVZ7cTXMSLWD8H
         uXia5AyiYfw87x+4hpnA4hS0f9u6OdSPtUQQO97shY+YQgIKjQJYK5Orfq8rZuC5Rc9C
         MizbuC/Dhr8lRyqAttlCmBdv8jyQ7fM5z4kjVinZM/YueRaDyhIxB3DQhJhVhibqdSzN
         vICa100w6h7gkxFPShVPvUhE4/AFYtNTe5LkXYsYhy+cIsrMgbO6Y8NgxGW7lBAE0HlV
         BO2BV3QFeuNFmAvm+4C6Ktkte9hK4sLm8sonPc8IfcX0NPwucpG+0cM9VUGxiiLpha4+
         AASg==
X-Gm-Message-State: AGRZ1gIYlxNzEcmNIAep75q+GwYW+4Y9rxBcDivvaxxvySPPSnHs1297
        5x366jhOzuibtO3aVfpE7RUyG/9CcwjRT+5axrk=
X-Google-Smtp-Source: AJdET5dAxt0VGTQ817Nft1SQAofiOcGqspbOmKmHmdbjCXNi0PWr2HraTESBNJID37SjYVXCcJuOm+mXaFzmJqyEeZc=
X-Received: by 2002:aca:d886:: with SMTP id p128-v6mr6289558oig.346.1541809733286;
 Fri, 09 Nov 2018 16:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20181108041537.39694-1-joel@joelfernandes.org>
 <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com> <A7EC46BC-441A-4A06-9E2F-A26DA88B5320@amacapital.net>
In-Reply-To: <A7EC46BC-441A-4A06-9E2F-A26DA88B5320@amacapital.net>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Fri, 9 Nov 2018 20:02:14 +0000
Message-ID: <CAMkWEXOLJ=ymbVjQfA2MD8XA7Y9Lu3ByJYUY-JvpnYKJ5gkY1w@mail.gmail.com>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, joel@joelfernandes.org,
        LKML <linux-kernel@vger.kernel.org>, jreck@google.com,
        john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org, hch@infradead.org,
        viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        dancol@google.com, bfields@fieldses.org, jlayton@kernel.org,
        khalid.aziz@oracle.com, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, marcandre.lureau@redhat.com,
        mike.kravetz@oracle.com, minchan@kernel.org, shuah@kernel.org,
        valdis.kletnieks@vt.edu, hughd@google.com,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 9:41 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Nov 9, 2018, at 1:06 PM, Jann Horn <jannh@google.com> wrote:
> >
> > +linux-api for API addition
> > +hughd as FYI since this is somewhat related to mm/shmem
> >
> > On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> >> Android uses ashmem for sharing memory regions. We are looking forward
> >> to migrating all usecases of ashmem to memfd so that we can possibly
> >> remove the ashmem driver in the future from staging while also
> >> benefiting from using memfd and contributing to it. Note staging drivers
> >> are also not ABI and generally can be removed at anytime.
> >>
> >> One of the main usecases Android has is the ability to create a region
> >> and mmap it as writeable, then add protection against making any
> >> "future" writes while keeping the existing already mmap'ed
> >> writeable-region active.  This allows us to implement a usecase where
> >> receivers of the shared memory buffer can get a read-only view, while
> >> the sender continues to write to the buffer.

Oh I remember trying this years ago with a new seal, F_SEAL_WRITE_PEER,
or something like that.

> >
> > So you're fiddling around with the file, but not the inode? How are
> > you preventing code like the following from re-opening the file as
> > writable?
> >
> > $ cat memfd.c
> > #define _GNU_SOURCE
> > #include <unistd.h>
> > #include <sys/syscall.h>
> > #include <printf.h>
> > #include <fcntl.h>
> > #include <err.h>
> > #include <stdio.h>
> >
> > int main(void) {
> >  int fd = syscall(__NR_memfd_create, "testfd", 0);
> >  if (fd == -1) err(1, "memfd");
> >  char path[100];
> >  sprintf(path, "/proc/self/fd/%d", fd);
> >  int fd2 = open(path, O_RDWR);
> >  if (fd2 == -1) err(1, "reopen");
> >  printf("reopen successful: %d\n", fd2);
> > }
> > $ gcc -o memfd memfd.c
> > $ ./memfd
> > reopen successful: 4
> > $
> >

The race condition between memfd_create and applying seals in fcntl?
I think it would be possible to block new write mappings from peer processes if
there is a new memfd_create api that accepts seals. Allowing caller to
set a seal
like the one I proposed years ago, though in a race-free manner. Then
also consider
how to properly handle blocking inherited +W mapping through
clone/fork. Maybe I'm
forgetting some other pitfalls?



> > That aside: I wonder whether a better API would be something that
> > allows you to create a new readonly file descriptor, instead of
> > fiddling with the writability of an existing fd.
>
> Every now and then I try to write a patch to prevent using proc to reopen a file with greater permission than the original open.
>
> I like your idea to have a clean way to reopen a a memfd with reduced permissions. But I would make it a syscall instead and maybe make it only work for memfd at first.  And the proc issue would need to be fixed, too.

IMO the best solution would handle the issue at memfd creation time by
removing the race condition.
