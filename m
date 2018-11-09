Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15884C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DF820892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UcSfkIkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DF820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeKJGtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:49:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35706 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:49:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so2657637oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuNsoCL6TY9N8reORgaap3+lQJ+Lj5HeljDywqjigV8=;
        b=UcSfkIknGPT26FPfW5mofZrobvMAm+toKikUBNEnJZ/uoVb19qVjIwZZHnGBJ6skCf
         AJ+gW5lAsfsWT/aMojx6QvqWUxgO9mvJL2KpWDqZUyfgtL7qwi2bJusHQxg/ca0/6Z+z
         rCkZ1sINqR1W1uvIr7epvTSIGC6MS3OCrCAVQZ7GtzB36MQFuHBcsM2wmM2oETy2cS76
         4RlDs65OJb9H7MKajpHJaFKuhk+iVXSIbX9RlflLs6UIr/bcba/r62jywrUzjOI4ijSq
         H+rfk1zjLMdQ/BMLwE1own1wN+Y9halERGTj2gAwio80guTZ6oXiNszfwWNrj6lEPA/J
         WUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuNsoCL6TY9N8reORgaap3+lQJ+Lj5HeljDywqjigV8=;
        b=Yi0xSQxbA/Ea9TJ5psctGvm2EO5vtTQDPmamexsF42rOk5feQZPP7PC5JsRetN5Zfh
         o/YIVX9EkC0xoWPcVqXnxIx8BRG6qARle31TkUEU+DtNbRqoDDn/SrcQj8ATXAd3QZyr
         CwZROFR9e18A4A2+VykK1Mr/3LFV3/aXnIe9DSoSASLs+ZS+n7ibeptuOha3InDS00pr
         0kmLrTTEJiCerAadMqyW8CrpXeCBKgkAMO2XwRq7kexjktKqEMQdpj45V1DEFwK1iEIa
         6PDov0OS79S2LTQIeSpzitJQeJMLt6MRrABken5Fej9S02lG8H9E+00r4uQW2Gpy5/Pj
         P4mw==
X-Gm-Message-State: AGRZ1gL1Nol+bFnEFrHd62os52w9nw+1n0MsKHgQQ2i+JNw2zSZBNrc+
        e4h0f4Yn/n76VHrA3aEGc34tiERHlra4wBhGwSKwJQ==
X-Google-Smtp-Source: AJdET5evI5RfRqJGlKQ7UsU2lwyhoz3I0XwFn+3Zssez0Ir2BUDAGKtC/m1B23k/og9y7D2xtf32G5Z9D48YZVzQ4Jk=
X-Received: by 2002:aca:fd12:: with SMTP id b18-v6mr6173719oii.337.1541797619210;
 Fri, 09 Nov 2018 13:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20181108041537.39694-1-joel@joelfernandes.org>
In-Reply-To: <20181108041537.39694-1-joel@joelfernandes.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 9 Nov 2018 22:06:31 +0100
Message-ID: <CAG48ez1h=v-JYnDw81HaYJzOfrNhwYksxmc2r=cJvdQVgYM+NA@mail.gmail.com>
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

+linux-api for API addition
+hughd as FYI since this is somewhat related to mm/shmem

On Fri, Nov 9, 2018 at 9:46 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> Android uses ashmem for sharing memory regions. We are looking forward
> to migrating all usecases of ashmem to memfd so that we can possibly
> remove the ashmem driver in the future from staging while also
> benefiting from using memfd and contributing to it. Note staging drivers
> are also not ABI and generally can be removed at anytime.
>
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then add protection against making any
> "future" writes while keeping the existing already mmap'ed
> writeable-region active.  This allows us to implement a usecase where
> receivers of the shared memory buffer can get a read-only view, while
> the sender continues to write to the buffer.
> See CursorWindow documentation in Android for more details:
> https://developer.android.com/reference/android/database/CursorWindow
>
> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FUTURE_WRITE seal
> which prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active.

Please CC linux-api@ on patches like this. If you had done that, I
might have criticized your v1 patch instead of your v3 patch...

> The following program shows the seal
> working in action:
[...]
> Cc: jreck@google.com
> Cc: john.stultz@linaro.org
> Cc: tkjos@google.com
> Cc: gregkh@linuxfoundation.org
> Cc: hch@infradead.org
> Reviewed-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
[...]
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 2bb5e257080e..5ba9804e9515 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
[...]
> @@ -219,6 +220,25 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>                 }
>         }
>
> +       if ((seals & F_SEAL_FUTURE_WRITE) &&
> +           !(*file_seals & F_SEAL_FUTURE_WRITE)) {
> +               /*
> +                * The FUTURE_WRITE seal also prevents growing and shrinking
> +                * so we need them to be already set, or requested now.
> +                */
> +               int test_seals = (seals | *file_seals) &
> +                                (F_SEAL_GROW | F_SEAL_SHRINK);
> +
> +               if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
> +                       error = -EINVAL;
> +                       goto unlock;
> +               }
> +
> +               spin_lock(&file->f_lock);
> +               file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> +               spin_unlock(&file->f_lock);
> +       }

So you're fiddling around with the file, but not the inode? How are
you preventing code like the following from re-opening the file as
writable?

$ cat memfd.c
#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <printf.h>
#include <fcntl.h>
#include <err.h>
#include <stdio.h>

int main(void) {
  int fd = syscall(__NR_memfd_create, "testfd", 0);
  if (fd == -1) err(1, "memfd");
  char path[100];
  sprintf(path, "/proc/self/fd/%d", fd);
  int fd2 = open(path, O_RDWR);
  if (fd2 == -1) err(1, "reopen");
  printf("reopen successful: %d\n", fd2);
}
$ gcc -o memfd memfd.c
$ ./memfd
reopen successful: 4
$

That aside: I wonder whether a better API would be something that
allows you to create a new readonly file descriptor, instead of
fiddling with the writability of an existing fd.
