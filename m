Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18350C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C913921565
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXQ3lg0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C913921565
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeJHWqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:46:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42577 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJHWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:46:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so20261040otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 08:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2GhA41ZNFQoEzR9m3CGS9nPF38UxfyF0briK4TsgnQ=;
        b=MXQ3lg0D7ZVSkdQvLsmfjg2ncirw/EuemHAKMYwGvtGzvvVdUu9FxUwc7t6GCKMfix
         R1GfAEefvazctBA20sOj3vLVUetwLnCpMfy79PPhB2ihziHYSxZXhHlTLaMkFi4KPmjp
         Zc6qSZ7tTv2+DJt5MJkP8xmjqSQcTHKxQIXNDGIPRa+avDcLFvLcoqf4Puq/wP27K/kO
         TUzv8VIaYfe0YktcEyjs1ogUhHLYm8sTKByryay5jSokFXwT++yZcWsqk/yAasw066T/
         hj7fHssEY0xV6/aFGIyHuWkJfvuqZMDdvZ/zlA2nabm3lTe7UqYgRvyKWYk7/T0wGT3h
         mtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2GhA41ZNFQoEzR9m3CGS9nPF38UxfyF0briK4TsgnQ=;
        b=Wgfnt+S42Efm0DLjo4l2u0LNQZ5tRZJ3bSgGk+Vu2mIY8/x0LUwl5dqBgy/ekmXQt4
         xw9HNOJwo0Kp3/8cIdUnvFvHKHFKzXGZWH7Np8j1mbQkhQX7kIhN2ag1mhij1pwkRjqK
         gSZ7RbkoirjyTszhChQusYfIv2vcGAS3XciqcBJj0MTcz/5lUkHkurEKW3/P1p7aMo6e
         fbpHJAiLkW4SEUS8ik2BQu0d5LdTO96lBP/2pRfmCf6rfhYCresj2lE3lCPdKn/+QF0J
         +S5fgKTgzBwWqO0q6cFPcFAA+KcC27K/D6ZumfXDJEwukLHzmllBHrJ+MsybIZ+vCGEA
         HPwg==
X-Gm-Message-State: ABuFfojXPaD2yU8H1LJfxt6g12aMwWwIeqwu+sRAJ7QzZO/LejQBE/iD
        SJBaenMPHBnVMPMEbrR1D1Z5mgOvXzKTOnuns/wTnQ==
X-Google-Smtp-Source: ACcGV61sfIFb5TqL2ihObRfdHDseI87oXMdf/kMbq6JCU2dmIMhBjq3+BkPtrqYoGi+6EfWfJZf3NhOxRHvFh7ideag=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr13563095otb.230.1539012828707;
 Mon, 08 Oct 2018 08:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
In-Reply-To: <20181008151629.hkgzzsluevwtuclw@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 8 Oct 2018 17:33:22 +0200
Message-ID: <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from ptrace
To:     christian@brauner.io
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:16 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
>
> So for the slow of mind aka me:
> I'm not sure I completely understand this problem. Can you outline how
> sendmsg() and socket() are involved in this?
>
> I'm also not sure that this holds (but I might misunderstand the
> problem) afaict, you could do try to get the fd out via CLONE_FILES and
> other means so something like:
>
> // let's pretend the libc wrapper for clone actually has sane semantics
> pid = clone(CLONE_FILES);
> if (pid == 0) {
>         fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
>
>         // Now this fd will be valid in both parent and child.
>         // If you haven't blocked it you can inform the parent what
>         // the fd number is via pipe2(). If you have blocked it you can
>         // use dup2() and dup to a known fd number.
> }
>
> >
> > v2: fix a bug where listener mode was not unset when an unused fd was not
> >     available
> > v3: fix refcounting bug (Oleg)
> > v4: * change the listener's fd flags to be 0
> >     * rename GET_LISTENER to NEW_LISTENER (Matthew)
> > v5: * add capable(CAP_SYS_ADMIN) requirement
> > v7: * point the new listener at the right filter (Jann)
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Oleg Nesterov <oleg@redhat.com>
> > CC: Eric W. Biederman <ebiederm@xmission.com>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
> > CC: Christian Brauner <christian.brauner@ubuntu.com>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> > ---
> >  include/linux/seccomp.h                       |  7 ++
> >  include/uapi/linux/ptrace.h                   |  2 +
> >  kernel/ptrace.c                               |  4 ++
> >  kernel/seccomp.c                              | 31 +++++++++
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
> >  5 files changed, 112 insertions(+)
> >
> > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > index 017444b5efed..234c61b37405 100644
> > --- a/include/linux/seccomp.h
> > +++ b/include/linux/seccomp.h
> > @@ -83,6 +83,8 @@ static inline int seccomp_mode(struct seccomp *s)
> >  #ifdef CONFIG_SECCOMP_FILTER
> >  extern void put_seccomp_filter(struct task_struct *tsk);
> >  extern void get_seccomp_filter(struct task_struct *tsk);
> > +extern long seccomp_new_listener(struct task_struct *task,
> > +                              unsigned long filter_off);
> >  #else  /* CONFIG_SECCOMP_FILTER */
> >  static inline void put_seccomp_filter(struct task_struct *tsk)
> >  {
> > @@ -92,6 +94,11 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
> >  {
> >       return;
> >  }
> > +static inline long seccomp_new_listener(struct task_struct *task,
> > +                                     unsigned long filter_off)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif /* CONFIG_SECCOMP_FILTER */
> >
> >  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > index d5a1b8a492b9..e80ecb1bd427 100644
> > --- a/include/uapi/linux/ptrace.h
> > +++ b/include/uapi/linux/ptrace.h
> > @@ -73,6 +73,8 @@ struct seccomp_metadata {
> >       __u64 flags;            /* Output: filter's flags */
> >  };
> >
> > +#define PTRACE_SECCOMP_NEW_LISTENER  0x420e
> > +
> >  /* Read signals from a shared (process wide) queue */
> >  #define PTRACE_PEEKSIGINFO_SHARED    (1 << 0)
> >
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 21fec73d45d4..289960ac181b 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
> >               ret = seccomp_get_metadata(child, addr, datavp);
> >               break;
> >
> > +     case PTRACE_SECCOMP_NEW_LISTENER:
> > +             ret = seccomp_new_listener(child, addr);
> > +             break;
> > +
> >       default:
> >               break;
> >       }
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 44a31ac8373a..17685803a2af 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1777,4 +1777,35 @@ static struct file *init_listener(struct task_struct *task,
> >
> >       return ret;
> >  }
> > +
> > +long seccomp_new_listener(struct task_struct *task,
> > +                       unsigned long filter_off)
> > +{
> > +     struct seccomp_filter *filter;
> > +     struct file *listener;
> > +     int fd;
> > +
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EACCES;
>
> I know this might have been discussed a while back but why exactly do we
> require CAP_SYS_ADMIN in init_userns and not in the target userns? What
> if I want to do a setns()fd, CLONE_NEWUSER) to the target process and
> use ptrace from in there?

See https://lore.kernel.org/lkml/CAG48ez3R+ZJ1vwGkDfGzKX2mz6f=jjJWsO5pCvnH68P+RKO8Ow@mail.gmail.com/
. Basically, the problem is that this doesn't just give you capability
over the target task, but also over every other task that has the same
filter installed; you need some sort of "is the caller capable over
the filter and anyone who uses it" check.
