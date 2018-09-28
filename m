Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5106C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7211B21755
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="B3oqWtqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7211B21755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1Lps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:45:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55155 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeI1Lps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:45:48 -0400
Received: by mail-it1-f193.google.com with SMTP id f14-v6so1232574ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 22:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C8l/NdNU70ldu1eZDyHhwFKeWFHIqn4FyYC2IvbfJGE=;
        b=B3oqWtqFzxKAJ55AGGxrWWaCtmb+Hp7wsVRkv6gPLdk288kdevERoBicsxfQwg7mE/
         lKr/9/1AvdDyeN37dbbYlTh1oqyQHEl6docE5zhWLu3+e6mqEEYYboF+KZkHTLkq5p7n
         andwMRyp4ZApMPXxatI9BYzYlMZfIEsPUwYdHpsLxrj3z5SS88uwOu8vpOIHmzZNq6sG
         dO5PU3FJrEAi4QF2MpvBFaKtAZKclNu76YfwrwScajsQe2jMbQ0eZT927L3mYb4o3xbs
         EFpw9q32I/zFUR6lFMQE+f/dY/rpKYBnOsF+qgxqSn5oiEFkq3xdQDm9OKl+JaOJH7ph
         HITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C8l/NdNU70ldu1eZDyHhwFKeWFHIqn4FyYC2IvbfJGE=;
        b=ldirP2TX9s0H2rbWvrVwn7U3P4ffjlvXcN0PoEmZrBBYFHJ+Xxn9iweIK1SCCNf2en
         db+S2z9QVzYlCcGzTgwdHt461DT5eerlo4yTr4/ywZNmeIc414To+89JcT160konie3B
         oGf9eOATHXlzSQUzPGB9Kac9p38/6kOhp9k2j60iFo7qGSABqZKQW71Xytp2BrucN4Ty
         DOk1j2iCqYy6Fh5p8fO6n/i8sKVEaVbBhVSYgy5WhFDlESFOc+cQ1pUJQDH0iNG76iGJ
         P2zYsP25CwMqxIwd60nKbRXwFNzxHP7lW4zyPBN333qUXOVQYzID5oyWJx5wtcYo2aA8
         +aEA==
X-Gm-Message-State: ABuFfojLRHpYV/C09A6+0kihfaydUw+imuedOJt3oWVPKFULWuvTG/qN
        +tAWSFA7IuDjL8m2NerUqYPwtg==
X-Google-Smtp-Source: ACcGV62vvKUBfGjMMpnBgLpks6lV4vf1JhiCKV3XOMuVbXHUQJqTu5uURfhvQ3aLDavOTvtJT9K7FA==
X-Received: by 2002:a24:6fc6:: with SMTP id x189-v6mr500528itb.149.1538112230552;
        Thu, 27 Sep 2018 22:23:50 -0700 (PDT)
Received: from cisco.lan (71-218-141-49.hlrn.qwest.net. [71.218.141.49])
        by smtp.gmail.com with ESMTPSA id k9-v6sm1326914iop.1.2018.09.27.22.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 22:23:49 -0700 (PDT)
Date:   Thu, 27 Sep 2018 23:23:46 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/6] files: add a replace_fd_files() function
Message-ID: <20180928052346.GA18045@cisco.lan>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-5-tycho@tycho.ws>
 <CAGXu5jLOe0izpGoB8c-hAeH2SzA51dF1BuMcXbk-d=QwqfjxxQ@mail.gmail.com>
 <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJvkkNNsGj=MK+=Dg0=nauANRkp=b1MrvOOzxkpb+DVkg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:20:50PM -0700, Kees Cook wrote:
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

So this is pretty much what we had in v6 (a one fd version, but the
idea is the same). The biggest issue is that in the case of e.g.
socketpair(), the fd values need to be written somewhere in the task's
memory, which means they need to be known before the response is sent.
If we have to wait until we're back in the task's context to install
them, we can't know the fd values.

V6 implementation: https://lkml.org/lkml/2018/9/6/773

Tycho
