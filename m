Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9DC49C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E9E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueMp/be8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E9E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935968AbeFMPdM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:33:12 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37395 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935763AbeFMPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:33:10 -0400
Received: by mail-ot0-f194.google.com with SMTP id 101-v6so3450526oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOVFGr/A6uEbe9tpOQgpfijFBNIefmHUTc0AZcN9yzs=;
        b=ueMp/be83KxISy9xh9Vr6R3bdFwRQbytSzcf59TOOJwxCF6W36rLa7Du/LQ8P319jk
         7XHvRba6/rtW0hcPPXvN73hjADQ1xv7xu5fIjdR8DzCKPn++SA9HUjz/8gmwzlJCM/jq
         aJ/0y8dWThboZjS3CPCgztuszRQWtQUiSUCxnL4B9QjjFoNO1qfm6srwI3tW+R56+0FH
         YwehRjM7mlaBGitZepI62fw+YsbWxjTl0bOsfntJp7LWswvWNXhHJUv0nzT5OdScYOlu
         uycK3p7eSW9HY7EaP+3/yUgmiquRaPbCDEhKikS/jkLOUdDE03RkTdAhdI8+I7i/DDcv
         wyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOVFGr/A6uEbe9tpOQgpfijFBNIefmHUTc0AZcN9yzs=;
        b=rthwlMW1uPRUzRULD94uGBr0iuit3x107wluFZAd03a0cZoCk9Q07r6DxQnCxPeFof
         XOkmwrE39eVQ+T6deIFoWPMzMiqJ4jnDEE1g8Phme//5BnuiK7PbfbIsDuhB+/ezeV/Q
         fnOp4KTLUW5a/dzkC5kHU4drmd84YTuB7jrIG7giimHKY+mlsIHQabygiCMi7W6QadOj
         soUrGYb4QmA9O7HjT5qmjqxKrPmZ7KXErbdNYK3F6IsHQS0YdnnvQi0qRU5/xJ7KSQI2
         4TmjGUOptw3rmWM2cftvo6wpd0fQrM/8YRQWINdpzyMSFMuUspsWGgqU+28NIomX/uzv
         epcA==
X-Gm-Message-State: APt69E2/hF9SL26pXo191y+be26kYNhFUCo3k/LezpWNQbAWVLTeDQAW
        F0CjVpMy6Yts3EqhmMBeMFf0GcY0Mt9TWzBaXsGtZg==
X-Google-Smtp-Source: ADUXVKIXT/tcQHUXfsc0OfryXnTHfrn3LCpF90h9mMAT7wfcilI4T9/mCxgXjMOA0SLbOJvV2/b8yGpwYB4o2PJ0GQw=
X-Received: by 2002:a9d:2115:: with SMTP id i21-v6mr3252502otb.72.1528903989568;
 Wed, 13 Jun 2018 08:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180531144949.24995-1-tycho@tycho.ws> <20180531144949.24995-2-tycho@tycho.ws>
 <CAG48ez3x9HSkLZc-da6zjPbckyfdPvwyQa3p9P6EzQ5sGk53eg@mail.gmail.com> <20180604001812.GE15998@cisco>
In-Reply-To: <20180604001812.GE15998@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Jun 2018 17:32:57 +0200
Message-ID: <CAG48ez2ZD1fMFcTfro-axUzC7g2Nb4ACnHPKXgr2q=_BchJuYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 2:18 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> Hi Jann,
>
> On Sun, Jun 03, 2018 at 08:41:01PM +0200, Jann Horn wrote:
> > On Sun, Jun 3, 2018 at 2:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > This patch introduces a means for syscalls matched in seccomp to notify
> > > some other task that a particular filter has been triggered.
> > >
> > > The motivation for this is primarily for use with containers. For example,
> > > if a container does an init_module(), we obviously don't want to load this
> > > untrusted code, which may be compiled for the wrong version of the kernel
> > > anyway. Instead, we could parse the module image, figure out which module
> > > the container is trying to load and load it on the host.
> > >
> > > As another example, containers cannot mknod(), since this checks
> > > capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> > > /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> > > coding some whitelist in the kernel. Another example is mount(), which has
> > > many security restrictions for good reason, but configuration or runtime
> > > knowledge could potentially be used to relax these restrictions.
> > >
> > > This patch adds functionality that is already possible via at least two
> > > other means that I know about, both of which involve ptrace(): first, one
> > > could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> > > Unfortunately this is slow, so a faster version would be to install a
> > > filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> > > Since ptrace allows only one tracer, if the container runtime is that
> > > tracer, users inside the container (or outside) trying to debug it will not
> > > be able to use ptrace, which is annoying. It also means that older
> > > distributions based on Upstart cannot boot inside containers using ptrace,
> > > since upstart itself uses ptrace to start services.
> > >
> > > The actual implementation of this is fairly small, although getting the
> > > synchronization right was/is slightly complex.
> > >
> > > Finally, it's worth noting that the classic seccomp TOCTOU of reading
> > > memory data from the task still applies here, but can be avoided with
> > > careful design of the userspace handler: if the userspace handler reads all
> > > of the task memory that is necessary before applying its security policy,
> > > the tracee's subsequent memory edits will not be read by the tracer.
> > [...]
> > > @@ -857,13 +1020,28 @@ static long seccomp_set_mode_filter(unsigned int flags,
> > >         if (IS_ERR(prepared))
> > >                 return PTR_ERR(prepared);
> > >
> > > +       if (flags & SECCOMP_FILTER_FLAG_GET_LISTENER) {
> > > +               listener = get_unused_fd_flags(O_RDWR);
> >
> > I think you want either 0 or O_CLOEXEC here?
>
> Do we? I suppose it makes sense to be able to set CLOEXEC, but I could
> imagine a case where a handler wanted to fork+exec to handle
> something. I'm happy to make the change, but it's not obvious to me
> that it's what we want by default.

I said "either 0 or O_CLOEXEC" - I just meant that O_RDWR doesn't make
much sense to me here, given that that's not a property of the fd and
will be ignored by the function you're calling.

On whether 0 or O_CLOEXEC is better: If you look at
get_unused_fd_flags() calls in e.g. various ioctl handlers, it's a mix
of places that hardcode 0, places that hardcode O_CLOEXEC, and places
that allow the caller to specify the flag. Either should work - but
personally, I believe that if the caller can't pass a flag,
get_unused_fd_flags(O_CLOEXEC) is the better choice because you can
still clear the O_CLOEXEC flag using fcntl() if necessary, while
setting the flag using fcntl() is potentially racy in a multi-threaded
context.
