Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD89C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CA20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNc03Un0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5CA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKJHBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:01:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45719 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJHBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:01:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so2373547ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uPTTTRfBBUmhrV7HkwLUyi9TvQ18jgLmCuRVixcUFM=;
        b=mNc03Un05t32DPuvTXCqgJ6zyMbgFSmMAwqTgC1oyfoNDZ3MLGeXDsDODxT/aAe67I
         aTNO6tL0ILk7e0omr8AxfaGr4cxTXqS5xEKQbSHeOYbtsmTZOVIV0rz0ttmkEAfJ3rx4
         KB54AvNoPRG3FomVb6qFLBA2eO+yuTSlaeTs3fnIJpdEn7AgoOJbYEMG60w5Y6Ym1NVb
         fKMOow4ysm7T9ze5myRedFfLa22lI52hpfKUx5dIN2BT77/rXAPd24OuUJ3TzEJZL7Ic
         SAreYwrV4LpH6RwP8Sc0xqYbuA4vRAf9ck26BIhOHqA3o4TMVxBWivs3cW3YqVqbgg08
         HGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uPTTTRfBBUmhrV7HkwLUyi9TvQ18jgLmCuRVixcUFM=;
        b=j/J7Nrg+MH6tkwKdN6fx+1J66DKON7WCKAs4sOF0fQyGEZfGmOiqUvgjoC4qNtviDy
         DtGypZBXbwSU3Lman9X2IlsSBHe48nqutKNgmIh2bWd0Wyr19V62b9hMSvBY+Zs3nvSA
         VC/Vuz7p9Je3cG2DfQjLQOlyL0pIENUoO82o1brmzDtIZJ/5NN8Ws73O2gJkCfbI3iKr
         jD85E8t9S66jUbYlpByNN3y2/2PgSVGpgrIdYO8EAD+lJAjhk+tEd29mG/GXmCgSmZet
         KK6N7HTcdRwgDmIsJY59IGJcBr9H1c+W8Ve1ZnhZ1ysEZaOF5AYb1aNN38mXvxRrrbDg
         Pc8w==
X-Gm-Message-State: AGRZ1gLM2FxXgSQKNtvZ41UCPAwQwomgznU82bLIcDMqiuj4ypgrSvjp
        0qBIoBOPmcLewUWeVrmCB735aqyi1slwXFTQzdXj2A==
X-Google-Smtp-Source: AJdET5e4sizQ9O4HQEyc1xGSEFRA5B+61hmiuXzL8KCZZs7Zxdr4O5MDH67JShltdhcd/8J1+ZdEPNR06LakTlj0NR0=
X-Received: by 2002:a9d:421a:: with SMTP id q26mr6703290ote.255.1541798370528;
 Fri, 09 Nov 2018 13:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
In-Reply-To: <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Nov 2018 22:19:03 +0100
Message-ID: <CAG48ez0kQ4d566bXTFOYANDgii-stL-Qj-oyaBzvfxdV=PU-7g@mail.gmail.com>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     joel@joelfernandes.org
Cc:     kernel list <linux-kernel@vger.kernel.org>, jreck@google.com,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Bruce Fields <bfields@fieldses.org>, jlayton@kernel.org,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, minchan@kernel.org,
        shuah@kernel.org, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:06 PM Jann Horn <jannh@google.com> wrote:
> On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > Android uses ashmem for sharing memory regions. We are looking forward
> > to migrating all usecases of ashmem to memfd so that we can possibly
> > remove the ashmem driver in the future from staging while also
> > benefiting from using memfd and contributing to it. Note staging drivers
> > are also not ABI and generally can be removed at anytime.
> >
> > One of the main usecases Android has is the ability to create a region
> > and mmap it as writeable, then add protection against making any
> > "future" writes while keeping the existing already mmap'ed
> > writeable-region active.  This allows us to implement a usecase where
> > receivers of the shared memory buffer can get a read-only view, while
> > the sender continues to write to the buffer.
> > See CursorWindow documentation in Android for more details:
> > https://developer.android.com/reference/android/database/CursorWindow
> >
> > This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> > To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> > which prevents any future mmap and write syscalls from succeeding while
> > keeping the existing mmap active.
>
> Please CC linux-api@ on patches like this. If you had done that, I
> might have criticized your v1 patch instead of your v3 patch...
>
> > The following program shows the seal
> > working in action:
> [...]
> > Cc: jreck@google.com
> > Cc: john.stultz@linaro.org
> > Cc: tkjos@google.com
> > Cc: gregkh@linuxfoundation.org
> > Cc: hch@infradead.org
> > Reviewed-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> [...]
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 2bb5e257080e..5ba9804e9515 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> [...]
> > @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
> >                 }
> >         }
> >
> > +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> > +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> > +               /*
> > +                * The FUTURE_WRITE seal also prevents growing and shrinking
> > +                * so we need them to be already set, or requested now.
> > +                */
> > +               int test_seals = (seals | *file_seals) &
> > +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> > +
> > +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> > +                       error = -EINVAL;
> > +                       goto unlock;
> > +               }
> > +
> > +               spin_lock(&file->f_lock);
> > +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> > +               spin_unlock(&file->f_lock);
> > +       }
>
> So you're fiddling around with the file, but not the inode? How are
> you preventing code like the following from re-opening the file as
> writable?
>
> $ cat memfd.c
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <printf.h>
> #include <fcntl.h>
> #include <err.h>
> #include <stdio.h>
>
> int main(void) {
>   int fd = syscall(__NR_memfd_create, "testfd", 0);
>   if (fd == -1) err(1, "memfd");
>   char path[100];
>   sprintf(path, "/proc/self/fd/%d", fd);
>   int fd2 = open(path, O_RDWR);
>   if (fd2 == -1) err(1, "reopen");
>   printf("reopen successful: %d\n", fd2);
> }
> $ gcc -o memfd memfd.c
> $ ./memfd
> reopen successful: 4
> $
>
> That aside: I wonder whether a better API would be something that
> allows you to create a new readonly file descriptor, instead of
> fiddling with the writability of an existing fd.

My favorite approach would be to forbid open() on memfds, hope that
nobody notices the tiny API break, and then add an ioctl for "reopen
this memfd with reduced permissions" - but that's just my personal
opinion.
