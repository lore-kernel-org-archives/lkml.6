Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84820818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayerToHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeKJIDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:03:01 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37383 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbeKJIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:03:00 -0500
Received: by mail-vs1-f65.google.com with SMTP id h18so1955300vsj.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zucEkTnEnReQSNzGX3ud7pupDV2EMGlTBiWx6dB58Ww=;
        b=ayerToHqG4XyqeHnAEnaw1Bef6MszHcjhOcMr1dbBg+1X1op9RoAVjYjqyMQ+uACGe
         MvbtxjmkwXCxU58kc+ZNqkQ3YuMX0yvO04U1ekKpqMa/itCVsI9VmSwVYGka1Z5JepL9
         BhzRtyNp60HPp1TUqdFYuJOdB3732ZYspNV4es+YZQcJs5qRzVSzJFmFvPCBVyDEQ/Xh
         pxgnmucrOdONIW5f/n5iM5siW+vFPmLFpgdzBPyrHq72Rq8EeLsNtuT6QfSWfMBHLg+D
         //WLDLIxjpgcSmJQ47tEdmcrP8mJ3Kqy0MZul3sujs6sLOd77cSFhQxTyIORFutrKGP0
         qx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zucEkTnEnReQSNzGX3ud7pupDV2EMGlTBiWx6dB58Ww=;
        b=oAXVXU+q1FGsVJJEMxMrBUNC9twIRndpKd7/b0uI41Tf4tEQwmdSUAesCXiYYapLuH
         9HZTIm/okCVQkckgsnsjMwh0IBGKHGsrSfmRXBYovkY9NZlAiSjB24BtjCuvqkTSRk6B
         JANBSpNQxi/9oQh4+d/lrXfJbn4tydHyKIs+3bXsUjRwFSQS3BuOD/ad/0R4NgfZFUnT
         cH/1gGnjWHueiw/QftQoUE+cNQMbtAFZEc4utSn6pHJiO7ivPdBoQJQYwqgINXSYK89i
         7WA5aNrDETPgdya8gyWko/VHRiMjBxnizM3NQ7azQJ7Jawbs0JF2ZHZBT7oR3WAmTHR+
         l60Q==
X-Gm-Message-State: AGRZ1gLTO45MBbz/fwA/Z054S5Ur8/TRErjgaXGmWaB6/xew6mTJOP1G
        PoGMjcmM9jjZ9/n7b1rjI5sJN8+QakaUgjA6Zlisgw==
X-Google-Smtp-Source: AJdET5c84DHPkoZes7Jz6rS5AC/9f2TvrAhXJxhbxNMqN1pffEvfbqiDUtQsH9JY6lTq20ZKWs+USiCzD81xzZSRE20=
X-Received: by 2002:a67:105:: with SMTP id 5mr4495582vsb.183.1541802019264;
 Fri, 09 Nov 2018 14:20:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 14:20:18 -0800 (PST)
In-Reply-To: <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
References: <20181108041537.39694-1-joel@joelfernandes.org> <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 9 Nov 2018 14:20:18 -0800
Message-ID: <CAKOZuesw1wG-YynWL7bVb+4BWtYp0Ei62vweWF+mqF1Ln-_2Tg@mail.gmail.com>
Subject: Re: [PATCH v3 resend 1/2] mm: Add an F_SEAL_FUTURE_WRITE seal to memfd
To:     Jann Horn <jannh@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        John Reck <jreck@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>, Lei.Yang@windriver.com,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, marcandre.lureau@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Shuah Khan <shuah@kernel.org>, valdis.kletnieks@vt.edu,
        Hugh Dickins <hughd@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 1:06 PM, Jann Horn <jannh@google.com> wrote:
>
> +linux-api for API addition
> +hughd as FYI since this is somewhat related to mm/shmem
>
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

Good catch. That's fixable too though, isn't it, just by fiddling with
the inode, right?

Another, more general fix might be to prevent /proc/pid/fd/N opens
from "upgrading" access modes. But that'd be a bigger ABI break.

> That aside: I wonder whether a better API would be something that
> allows you to create a new readonly file descriptor, instead of
> fiddling with the writability of an existing fd.

That doesn't work, unfortunately. The ashmem API we're replacing with
memfd requires file descriptor continuity. I also looked into opening
a new FD and dup2(2)ing atop the old one, but this approach doesn't
work in the case that the old FD has already leaked to some other
context (e.g., another dup, SCM_RIGHTS). See
https://developer.android.com/ndk/reference/group/memory. We can't
break ASharedMemory_setProt.
