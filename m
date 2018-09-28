Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CADC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000D2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vI13q0x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000D2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeI1JIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:08:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33252 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1JIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:08:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so4085549oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW7NN9PdF8Bhzhl1yD2glQ+K46HI7lE2i7BL23tLIK4=;
        b=vI13q0x0tFwJClbfYoHmAx1MyNazWl4+uDj2nQKLXoCP3NQZA9dk60vOyYJljUOd77
         jWZ5EHiHANywgZl0shlo4Yr0Xw3V/BeeLRypIXn0+lWvferg79yeHUwpSsxyIdSk2rwR
         vlUDnm9Jh2rbO4vZj/KhiTyiI4K4ULabUsWyTzixLYZ0FISb6YMFcnVhCiTLDBFflz5U
         qQz5Lvkf/LH0mNOmtjCWtgadoFOgvR7HnVZuRfcj3waaPkxsRucTNZ1BCJeNuI795IOH
         Tt1vH59AW34dyEWBVXYON0U4P1OMCQaxsgGE5n+VrXEM7duDTTQRQA9lTTKuFa1uEHVJ
         Kljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW7NN9PdF8Bhzhl1yD2glQ+K46HI7lE2i7BL23tLIK4=;
        b=Fsw9C+QFXvK5bUQlf0UHaO2UGR3/04AJq4caOoR/iEt5jyoZ+wm1i5H+lkkORqulUS
         sRbHbzqd+CH6/MIzsIAtn72QaOqydmPZpijy2sFLXxnvmPNAcY1Vb2Lh3bQKDtnXeX2P
         1u6nTmhhpKbY/Bi+aoYfgvVBr6m9z0eZtYWMq3ZI3rMDm9gVBqHjiRnSsBmGY4OIB8ZB
         ZdK/+mRrXJxb902yajuEymHD+IDo9cbjBiYc6ODaM/gZyl2j6GdBaIXe1jjXS7XyjiHw
         y3NTzJ8xfkXX3QtAMzQL/sV/umvHt58lYCdajGraPKe49Q/tYWnXdLNdyrWqgFINeUrf
         tZrA==
X-Gm-Message-State: ABuFfoiTjuUDcfBQUuySS21Z4fcXyAyYt11ls4Bna0fLPR/QWUSEfmTJ
        N4ZBDQVyOn23Iagmu/HwV51l3Swm5ChBp0h2lW7k/Q==
X-Google-Smtp-Source: ACcGV60rJnbZ2agtlpwaWRca3hyRiAwIfy9XlmC1ZH7KBj/IAT07x3/gxxPzBKlZDTFZqBymH8U1lraufbsz+T6Irg4=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr4383782oif.177.1538102813990;
 Thu, 27 Sep 2018 19:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-5-tycho@tycho.ws>
 <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com> <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
In-Reply-To: <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 04:46:26 +0200
Message-ID: <CAG48ez0RybWLS_o4NmSiKEfK=3EFbBzPQ9HoaMS3U_AM5NrUuQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] files: add a replace_fd_files() function
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 4:20 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 27, 2018 at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 27, 2018 at 8:11 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> Similar to fd_install/__fd_install, we want to be able to replace an fd of
> >> an arbitrary struct files_struct, not just current's. We'll use this in the
> >> next patch to implement the seccomp ioctl that allows inserting fds into a
> >> stopped process' context.
> >>
> >> v7: new in v7
> >>
> >> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> >> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> >> CC: Kees Cook <keescook@chromium.org>
> >> CC: Andy Lutomirski <luto@amacapital.net>
> >> CC: Oleg Nesterov <oleg@redhat.com>
> >> CC: Eric W. Biederman <ebiederm@xmission.com>
> >> CC: "Serge E. Hallyn" <serge@hallyn.com>
> >> CC: Christian Brauner <christian.brauner@ubuntu.com>
> >> CC: Tyler Hicks <tyhicks@canonical.com>
> >> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> >> ---
> >>  fs/file.c            | 22 +++++++++++++++-------
> >>  include/linux/file.h |  8 ++++++++
> >>  2 files changed, 23 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/file.c b/fs/file.c
> >> index 7ffd6e9d103d..3b3c5aadaadb 100644
> >> --- a/fs/file.c
> >> +++ b/fs/file.c
> >> @@ -850,24 +850,32 @@ __releases(&files->file_lock)
> >>  }
> >>
> >>  int replace_fd(unsigned fd, struct file *file, unsigned flags)
> >> +{
> >> +       return replace_fd_task(current, fd, file, flags);
> >> +}
> >> +
> >> +/*
> >> + * Same warning as __alloc_fd()/__fd_install() here.
> >> + */
> >> +int replace_fd_task(struct task_struct *task, unsigned fd,
> >> +                   struct file *file, unsigned flags)
> >>  {
> >>         int err;
> >> -       struct files_struct *files = current->files;
> >
> > Same feedback as Jann: on a purely "smaller diff" note, this could
> > just be s/current/task/ here and all the other s/files/task->files/
> > would go away...
> >
> >>
> >>         if (!file)
> >> -               return __close_fd(files, fd);
> >> +               return __close_fd(task->files, fd);
> >>
> >> -       if (fd >= rlimit(RLIMIT_NOFILE))
> >> +       if (fd >= task_rlimit(task, RLIMIT_NOFILE))
> >>                 return -EBADF;
> >>
> >> -       spin_lock(&files->file_lock);
> >> -       err = expand_files(files, fd);
> >> +       spin_lock(&task->files->file_lock);
> >> +       err = expand_files(task->files, fd);
> >>         if (unlikely(err < 0))
> >>                 goto out_unlock;
> >> -       return do_dup2(files, file, fd, flags);
> >> +       return do_dup2(task->files, file, fd, flags);
> >>
> >>  out_unlock:
> >> -       spin_unlock(&files->file_lock);
> >> +       spin_unlock(&task->files->file_lock);
> >>         return err;
> >>  }
> >>
> >> diff --git a/include/linux/file.h b/include/linux/file.h
> >> index 6b2fb032416c..f94277fee038 100644
> >> --- a/include/linux/file.h
> >> +++ b/include/linux/file.h
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/posix_types.h>
> >>
> >>  struct file;
> >> +struct task_struct;
> >>
> >>  extern void fput(struct file *);
> >>
> >> @@ -79,6 +80,13 @@ static inline void fdput_pos(struct fd f)
> >>
> >>  extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
> >>  extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
> >> +/*
> >> + * Warning! This is only safe if you know the owner of the files_struct is
> >> + * stopped outside syscall context. It's a very bad idea to use this unless you
> >> + * have similar guarantees in your code.
> >> + */
> >> +extern int replace_fd_task(struct task_struct *task, unsigned fd,
> >> +                          struct file *file, unsigned flags);
> >
> > Perhaps call this __replace_fd() to indicate the "please don't use
> > this unless you're very sure"ness of it?
> >
> >>  extern void set_close_on_exec(unsigned int fd, int flag);
> >>  extern bool get_close_on_exec(unsigned int fd);
> >>  extern int get_unused_fd_flags(unsigned flags);
> >> --
> >> 2.17.1
> >>
> >
> > If I can get an Ack from Al, that would be very nice. :)
>
> In out-of-band feedback from Al, he's pointed out a much cleaner
> approach: do the work on the "current" side. i.e. current is stopped
> in __seccomp_filter in the case SECCOMP_RET_USER_NOTIFY. Instead of
> having the ioctl-handing process doing the work, have it done on the
> other side. This may cause some additional complexity on the ioctl
> return path, but it solves both this problem and the "ptrace attach"
> issue: have the work delayed until "current" gets caught by seccomp.

Can you elaborate on this? Are you saying you want to, for every file
descriptor that should be transferred, put a reference to the file
into the kernel's seccomp notification data structure, wake up the
task that's waiting for a reply, let the task install an fd, send back
a response on whether installing the FD worked, and then return that
response back to the container manager process? That sounds
like a pretty complicated dance that I'd prefer to avoid.
