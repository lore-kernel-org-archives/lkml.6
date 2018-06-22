Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF923C00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBt1ZoMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AF923C00
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbeFVB2j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:28:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42570 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeFVB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:28:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id k190-v6so4699418oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kgqu9VYT1TaU24pZjye+OB8Bvfsz1IZnru2Dr8kYFKM=;
        b=bBt1ZoMlkG3cH/sUG773e5Ba1lz16T4UPjjlfdJXXBkfPQf1NIJZNQNnmP1Up0UQi8
         3C2k23drGUtzH9iG2NKOQT6d158sVjqYHzy3fwzt9HVSEGA6BxIkUnaDxoziArCu2WrZ
         Y22NpP15vlIKRImebpbZ7rKU0dYmetishxlwqIJwL4yJNFuw/DL7pXr92xorezhpaRZa
         H9ebVCZOFf/PbHumwWUwAGzR3PKrCeVE6BcewcOKDc+w5PQPvYErOLeBaMhSuqmu5aic
         XvLNFkSwsqNEyTO+NbxxzjfTfJ6o5jLrEzMnI2pSTTzOVO6E+vzyQP/uN0Pf9hcjL76n
         fPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kgqu9VYT1TaU24pZjye+OB8Bvfsz1IZnru2Dr8kYFKM=;
        b=ccXN57cZ6pm86cS2l0UTT24EpYO7cklFXGR+IrdSxz7lXp6SaqNcR05Ai7DmZz6hrm
         q6+lRe/J6I6xslphUD0THxt+R237inokZxuhVppt/BvxccBDX8JiQoXf8R4Cn19s+L8V
         Zn7dB5Z4ceqKu5x3A5GeFE3b3vqXGdqC04pvV2DwmX6kBsHTUZL+5wy9/QyGn7CFdQGt
         UJv31PC8UPB8JVB0VnvioZN9ulYzPyU/+UkgFhLj19HwLR3qniz2isWeY3Bn/FhkO9aG
         XPBWb3uhEvy7F9uyBEJBDBwdxB7ePl6M551WbbORGn0rQrXVl+rIe/JIDsb0FM5dhP9k
         h8Qg==
X-Gm-Message-State: APt69E3Rtn+7DDJUl42sqjJcC8bcIEr9+3Z0j/xUk+Z6khR+CUJkCbGT
        4JYCIEgcam/VD//Lip+S4nMBl9WJ6BIs2EHvwGbGLg==
X-Google-Smtp-Source: ADUXVKIjbF+2DX2d6Tt+T4fs+1exglv2jE2GEjk8Edh4nXa4VHyH+JBdzVvaJnK+4gGldKpjoo11ndxNlXpUQHYxf4U=
X-Received: by 2002:aca:3048:: with SMTP id w69-v6mr14543733oiw.29.1529630916681;
 Thu, 21 Jun 2018 18:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez2-vK57HfbRs94YLiz3SVJ7u4tTrxtAmbRepDqk6m-c_A@mail.gmail.com> <20180622005829.GK3992@cisco>
In-Reply-To: <20180622005829.GK3992@cisco>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jun 2018 03:28:24 +0200
Message-ID: <CAG48ez1Wob-CrbrPfgP_OBoG7zas4bJwFdLFFQLtgQAkj+HEOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
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

On Fri, Jun 22, 2018 at 2:58 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Fri, Jun 22, 2018 at 01:21:47AM +0200, Jann Horn wrote:
> > On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > This patch introduces a means for syscalls matched in seccomp to notify
> > > some other task that a particular filter has been triggered.
> > [...]
> > > +Userspace Notification
> > > +======================
> > > +
> > > +The ``SECCOMP_RET_USER_NOTIF`` return code lets seccomp filters pass a
> > > +particular syscall to userspace to be handled. This may be useful for
> > > +applications like container managers, which whish to intercept particular
> >
> > typo: "wish"
> >
> > [...]
> > > +passed around via ``SCM_RIGHTS`` or similar. Alternativley, a filter fd can be
> >
> > typo: "Alternatively"
> >
> > [...]
> > > +It is worth noting that ``struct seccomp_data`` contains the values of register
> > > +arguments to the syscall, but does not contain pointers to memory. The task's
> > > +memory is accessiable to suitably privileged traces via via ``ptrace()`` or
> >
> > Typo: "accessible"
>
> Thanks!
>
> > [...]
> > > +
> > > +static void seccomp_do_user_notification(int this_syscall,
> > > +                                        struct seccomp_filter *match,
> > > +                                        const struct seccomp_data *sd)
> > > +{
> > > +       int err;
> > > +       long ret = 0;
> > > +       struct seccomp_knotif n = {};
> > > +
> > > +       mutex_lock(&match->notify_lock);
> > > +       err = -ENOSYS;
> > > +       if (!match->has_listener)
> > > +               goto out;
> > > +
> > > +       n.pid = task_pid(current);
> > > +       n.state = SECCOMP_NOTIFY_INIT;
> > > +       n.data = sd;
> > > +       n.id = seccomp_next_notify_id(match);
> > > +       init_completion(&n.ready);
> > > +
> > > +       list_add(&n.list, &match->notifications);
> > > +       wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
> > > +
> > > +       mutex_unlock(&match->notify_lock);
> > > +       up(&match->request);
> > > +
> > > +       err = wait_for_completion_interruptible(&n.ready);
> > > +       mutex_lock(&match->notify_lock);
> > > +
> > > +       /*
> > > +        * Here it's possible we got a signal and then had to wait on the mutex
> > > +        * while the reply was sent, so let's be sure there wasn't a response
> > > +        * in the meantime.
> > > +        */
> > > +       if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > > +               /*
> > > +                * We got a signal. Let's tell userspace about it (potentially
> > > +                * again, if we had already notified them about the first one).
> > > +                */
> > > +               if (n.state == SECCOMP_NOTIFY_SENT) {
> > > +                       n.state = SECCOMP_NOTIFY_INIT;
> > > +                       up(&match->request);
> > > +               }
> > > +               mutex_unlock(&match->notify_lock);
> > > +               err = wait_for_completion_killable(&n.ready);
> >
> > Does this mean that when you get a signal that isn't SIGKILL,
> > wait_for_completion_interruptible() will bail out with -ERESTARTSYS,
> > but then you hang on this wait_for_completion_killable()? I don't
> > understand what's going on here. What's the point of using
> > wait_for_completion_interruptible() when you'll just hang on another
> > wait on the same "struct completion"?
>
> This is the implementation of this suggestion by Andy:
> https://lkml.org/lkml/2018/3/15/1122
>
> The idea is to alert the listener that there was a signal exactly
> once, in case it's in the middle of processing a request it could bail
> out and do something else. So the killable wait is intended to ignore
> other (non-fatal) signals after the first one and wait for whatever
> the handler decides to do with the signal it received.

How can the listener tell that a signal arrived? When the first
non-fatal signal comes in, you just set the state to
SECCOMP_NOTIFY_INIT if it was SECCOMP_NOTIFY_SENT, right? So the
listener will potentially see the request twice, but with no
additional indicator that a signal arrived? And in particular, if the
listener doesn't read the request before the signal arrives, it will
only see the request once, just as if it was a normal request with no
signals involved?

Would it perhaps make sense to add a field to struct seccomp_notif
that indicates whether the notification is for a normal syscall or a
canceled syscall?
