Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819BAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0441321547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tQ/XDCnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0441321547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbeIUIFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:05:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbeIUIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:05:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so11251842wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9WL9J5rOq3WHqwkwEDjpGGkXVe04pWZ0POWTuuCDe8=;
        b=tQ/XDCnUedGw1WBl+5s32I9t/aLuXTH/i23LHAcqyiRO5yICQpCSCrl+flnBtEKX4m
         HbmdOc+DPcANiRWqq/oSF3ThEgUx7GT3J1dooP6RIF+2u6YlSu485nUSjXdDPk6W6kQQ
         oayph8qFVqd4LbQ0Scw037UznkU7m/c+MWTXjtwZmvkYI7WFfccd6SRMNnOhZnDWwWhO
         C5jnPcS4h95t8MQ/cm1H2CvXJJJOW5Foxbiv/xfG1qJlpEPb4BuSaDjZ6a9jadSM+l36
         TvpVLeDLGHF061qW3Lffk5NPuUoe1nOQ7fAZXoX3lYe/elpMOITsUzwEdy0qxDjJcCc5
         IwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9WL9J5rOq3WHqwkwEDjpGGkXVe04pWZ0POWTuuCDe8=;
        b=EJodLWNvnHGflXLWasi2M4xkGE2dRDGhc2BWskji/FiekNg/TbP288qs63/GohCg6m
         UlyUsnGojW/mmKlxac2wagCPRrCGDj0n/it9L3Ko2N3M3yvT6QhuAaxN0c1T7SlDBo3B
         fqPWX6GtDjS2K+x/h2fuW4mHYTEb7OnGtC4q2sm/RIKcbNVdPhkT9c1jvnL5+tSRiiCt
         /NmFPaSoLeC8dZHXnkPWq9/cKhpRsflq8UWjrj//UkxvOECfBf+Xr99vZDXSpJvJyC29
         pj8TGpaFFneSY6I3D0B3Rx0jyM8PhXFx51feItwsX1Vzlg0Q+0QfXEaiEWYgAvluV6i2
         OrrA==
X-Gm-Message-State: APzg51A702f6KfR/lP9Bbglnl5g/YxxEDR16eFDNIv0iY+EeRqeY5Xky
        c/qJ474SFlKjX2ITgLao/88Rfyhu6Hg6pQyxokAg9w==
X-Google-Smtp-Source: ANB0Vda6C1dCpfvDGae/r9UCmMULrCEIQsQ19LLrxUU6X7OXyUpX7UgSIurpZQb5YMQtxx4NFTUsHDZ338zgx9B+4/8=
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr34091430wrf.46.1537496336984;
 Thu, 20 Sep 2018 19:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco> <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
 <20180919143842.GN4672@cisco> <CALCETrVuP0nQ5B01-iWrcQ87hisz7=jA08-Uisqud_r+zc74NQ@mail.gmail.com>
 <20180920234240.GR4672@cisco>
In-Reply-To: <20180920234240.GR4672@cisco>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 20 Sep 2018 19:18:45 -0700
Message-ID: <CALCETrWEr_VAtJu1mm1akTigsRUXAA7_7RHb-WGHqnyNy=j17Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 4:42 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Wed, Sep 19, 2018 at 12:58:20PM -0700, Andy Lutomirski wrote:
> > On Wed, Sep 19, 2018 at 7:38 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > > On Wed, Sep 19, 2018 at 07:19:56AM -0700, Andy Lutomirski wrote:
> > >>
> > >>
> > >> > On Sep 19, 2018, at 2:55 AM, Tycho Andersen <tycho@tycho.ws> wrote=
:
> > >> >
> > >> >> On Wed, Sep 12, 2018 at 04:52:38PM -0700, Andy Lutomirski wrote:
> > >> >>> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> =
wrote:
> > >> >>> The idea here is that the userspace handler should be able to pa=
ss an fd
> > >> >>> back to the trapped task, for example so it can be returned from=
 socket().
> > >> >>>
> > >> >>> I've proposed one API here, but I'm open to other options. In pa=
rticular,
> > >> >>> this only lets you return an fd from a syscall, which may not be=
 enough in
> > >> >>> all cases. For example, if an fd is written to an output paramet=
er instead
> > >> >>> of returned, the current API can't handle this. Another case is =
that
> > >> >>> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If =
netlink
> > >> >>> ever decides to install an fd and output it, we wouldn't be able=
 to handle
> > >> >>> this either.
> > >> >>
> > >> >> An alternative could be to have an API (an ioctl on the listener,
> > >> >> perhaps) that just copies an fd into the tracee.  There would be =
the
> > >> >> obvious set of options: do we replace an existing fd or allocate =
a new
> > >> >> one, and is it CLOEXEC.  Then the tracer could add an fd and then
> > >> >> return it just like it's a regular number.
> > >> >>
> > >> >> I feel like this would be more flexible and conceptually simpler,=
 but
> > >> >> maybe a little slower for the common cases.  What do you think?
> > >> >
> > >> > I'm just implementing this now, and there's one question: when do =
we
> > >> > actually do the fd install? Should we do it when the user calls
> > >> > SECCOMP_NOTIF_PUT_FD, or when the actual response is sent? It feel=
s
> > >> > like we should do it when the response is sent, instead of doing i=
t
> > >> > right when SECCOMP_NOTIF_PUT_FD is called, since if there's a
> > >> > subsequent signal and the tracer decides to discard the response,
> > >> > we'll have to implement some delete mechanism to delete the fd, bu=
t it
> > >> > would have already been visible to the process, etc. So I'll go
> > >> > forward with this unless there are strong objections, but I though=
t
> > >> > I'd point it out just to avoid another round trip.
> > >> >
> > >> >
> > >>
> > >> Can you do that non-racily?  That is, you need to commit to an fd *n=
umber* right away, but what if another thread uses the number before you ac=
tually install the fd?
> > >
> > > I was thinking we could just do an __alloc_fd() and then do the
> > > fd_install() when the response is sent or clean up the case that the
> > > listener or task dies. I haven't actually tried to run the code yet,
> > > so it's possible the locking won't work :)
> >
> > I would be very surprised if the locking works.  How can you run a
> > thread in a process when another thread has allocated but not
> > installed an fd and is blocked for an arbitrarily long time?
>
> I think the trick is that there's no actual locking required (except
> for a brief locking of task->files). I've run the patch below and it
> seems to work. But perhaps that's abusing __alloc_fd a little too
> hard, I don't really know.
>

Hmm.  This makes me highly nervous.  If nothing else, what releases
the busy-but-not-open fd if the whole process aborts?

> > >
> > >> Do we really allow non-=E2=80=9Ckill=E2=80=9D signals to interrupt t=
he whole process?  It might be the case that we don=E2=80=99t really need t=
o clean up from signals if there=E2=80=99s a guarantee that the thread dies=
.
> > >
> > > Yes, we do, because of this: https://lkml.org/lkml/2018/3/15/1122
> > >
> >
> > I'm still not sure I see the problem.  Suppose I'm implementing a user
> > notifier for a nasty syscall like recvmsg().  If I'm the tracer, by
> > the time I decide to install an fd, I've committed to returning
> > something other than -EINTR, even if a non-fatal signal is sent before
> > I finish.  No rollback should be necessary.
>
> I don't understand why this is true. Surely you could stop a handler
> on receipt of a new signal, and have it do something else entirely?

I think you *could*, but I'm not sure why you would.  In general,
syscalls never execute signal handlers mid-syscall.  There is a very
small number of syscalls that use sys_restart_syscall(), but I don't
think any of them allocate fds, and I'm not sure we need or want to
support them with user notifiers.  The rest of the syscalls will, if
they're behaving correct, either do *something* (like reading some or
all of a buffer) and return success or they'll do nothing and return
-EINTR.  Or they return an -ERESTARTSYS variant.  And then, only
*after* the syscall logically returns (i.e. completely finishes
processing and puts its return code into the relevant register) will a
signal be delivered.  In other words, the case where something like
recv() gets interrupted but still returns a success code does not mean
that a signal handler was called and then recv() resumed.  It means
that recv() noticed the signal, stopped receiving, returned the number
of bytes read, and then allowed the signal to be delivered.

In the -ERESTARTSYS case, the syscall returns -ERESTARTSYS (or a
variant) and returns without doing anything.  But it returns in a
special case where, after the signal returns, the syscall will happen
again.

So, for user notifiers, I think that any sane handler that notices a
non-fatal signal will do one of these things:

 - Return -EINTR without changing any tracee state.

 - Return success, possibly without blocking as long as it would have
without the signal.

 - Return -ERESTARTSYS without changing any tracee state.

 - Kill the tracee.

None of these would involve backing out an fd that was already
installed.  I suppose another way of looking at this is that.

Although... now that I think about it, there are some special cases,
like socketpair().  Look for put_unused_fd().  So maybe we need to
expose get_unused_fd_flags() and put_unused_fd(), but I think that
these are exceptions and will be very uncommon in the context of
seccomp user notifiers.  (For example, socketpair() can be implemented
almost correctly without put_unused_fd().)

Hmm.  This does mean that we need a test case for a user notifier
returning -ERESTARTSYS.  It should Just Work (tm), but those are
famous last words.

-ERESTARTSYS_RESTARTBLOCK is the case that I don't think we need to worry a=
bout.

>
> > In the (unlikely?) event that some tracer needs to be able to rollback
> > an fd installation to return -EINTR, a SECCOMP_NOTIF_CLOSE_FD
> > operation should be good enough, I think.  Or maybe PUT_FD can put -1
> > to delete an fd.
>
> Yes, I think even with something like what I did below we'd need some
> sort of REMOVE_FD option, because otherwise there's no way to change
> your mind and send -EINTR without the fd you just PUT_FD'd.
>

I think we just want the operation to cover all the cases.  Let PUT_FD
take a source fd and a dest fd.  If the source fd is -1, the dest is
closed.  If the source is -1 and the dest is -1, return -EINVAL.  If
the dest is -1, allocate an fd.  If the dest is >=3D 0, work like
dup2().  (The latter could be necessary to emulate things like, say,
dup2 :))
