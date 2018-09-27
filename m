Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370ECC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7B2172F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sf4QyFN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D7B2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI1F6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:58:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42058 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1F6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:58:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id w81-v6so2065161oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 16:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqJvNLwT6E7hF1ZOVnmSnSLRMEXZqYaKuyANFe9UirI=;
        b=Sf4QyFN+dGDESiDY1n8zmxXTv/7rfjgg+2S/Fed1jnQA/9JIg3G791VAMNYEYH/Plt
         VFv2sDMi4BzY3sO+QhXJfT/30zmFyuaxvOlbK22ViVTARX5Jzf+C9CMEpji+QhFSWWNs
         x0znLkgXdwpXp7e49nIfn8tgoQ3FUqR+j4BbZy4LOkgfMDEY6XNpnlRCp1OOHoY92bAX
         y3Y7gdkrsY7ac5V5MGFKA4WFi//tQK6MW9hC52/VFgfWwn30VU66w2farHSJ2RF0wwSa
         V5gpexn4Guu3NeflcGhK04tDyPFo1ChEqxDffv3Jj7b55gle+JMoY8b0o9plUSrWb4qs
         IJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqJvNLwT6E7hF1ZOVnmSnSLRMEXZqYaKuyANFe9UirI=;
        b=DLr4xxEaQZVZg9hbtuI1OVtgpZUmwLQU0MHA/Uwv33Frbjbz6FZvATqJTtMmIsze0H
         YBuZerbrQTlCNdy/S78TbBfD2d+UZMJ/WlzSeyFFO1jr7vahs7VGhTsdqTmjrCp/NEj7
         mwE9dvtl44yFDH6GJSqZJjp5lNzSNQQdwSqzVLyelpmDapfSFjQk1I2Ro7AQ1bVA7/jH
         NgHRHevbyMYp9m+Td4im4XHrwHfbBmmzJ+UBm4iERhE+yNMmB33xlt/02FGU/TkiPSgE
         hUnGh7XemJSY/i6rbSDIgCzv1aY4hni9Q0GqlcPjvdT4yqe+wgauUZrXTATPeInXUyY1
         jaKg==
X-Gm-Message-State: ABuFfojLy2cbQQAI/X+8tb1N7j2pTd8D05SbwkhBTqpwwMfoI6yISEZp
        Yhcsw37TvgeZ0k2/3QEbtZRlG+OF4A2UjPi9bbQs8A==
X-Google-Smtp-Source: ACcGV61e6YopQIuZHSelNsxeFCrGNJHPcQRYvz0ufxqEWHE4equ7BpS8bFXpftJs+nYhiy/YSkGTeyGsvmq5hjxBo8s=
X-Received: by 2002:aca:4d13:: with SMTP id a19-v6mr4063132oib.205.1538091487257;
 Thu, 27 Sep 2018 16:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180927151119.9989-1-tycho@tycho.ws> <20180927151119.9989-2-tycho@tycho.ws>
 <CAG48ez05LyQOb4pw5H74VhHdQFDEOPLoLuhDPMEqFG7W1hwA_Q@mail.gmail.com> <20180927230408.GH15491@cisco.cisco.com>
In-Reply-To: <20180927230408.GH15491@cisco.cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 01:37:40 +0200
Message-ID: <CAG48ez0Zs1FCjyQsXp5aDGVxBsF=EuaQc9xrq_OiRT6ScXb3WQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] seccomp: add a return code to trap to userspace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     hch@lst.de, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 1:04 AM Tycho Andersen <tycho@tycho.ws> wrote:
> On Thu, Sep 27, 2018 at 11:51:40PM +0200, Jann Horn wrote:
> > > +It is worth noting that ``struct seccomp_data`` contains the values of register
> > > +arguments to the syscall, but does not contain pointers to memory. The task's
> > > +memory is accessible to suitably privileged traces via ``ptrace()`` or
> > > +``/proc/pid/map_files/``.
> >
> > You probably don't actually want to use /proc/pid/map_files here; you
> > can't use that to access anonymous memory, and it needs CAP_SYS_ADMIN.
> > And while reading memory via ptrace() is possible, the interface is
> > really ugly (e.g. you can only read data in 4-byte chunks), and your
> > caveat about locking out other ptracers (or getting locked out by
> > them) applies. I'm not even sure if you could read memory via ptrace
> > while a process is stopped in the seccomp logic? PTRACE_PEEKDATA
> > requires the target to be in a __TASK_TRACED state.
> > The two interfaces you might want to use instead are /proc/$pid/mem
> > and process_vm_{readv,writev}, which allow you to do nice,
> > arbitrarily-sized, vectored IO on the memory of another process.
>
> Yes, in fact the sample code does use /proc/$pid/mem, but the docs
> should be correct :)

Please also mention the process_vm_readv/writev syscalls though, given
that fast access to remote processes is what they were made for.

> > > +#ifdef CONFIG_SECCOMP_FILTER
> > > +static int seccomp_notify_release(struct inode *inode, struct file *file)
[...]
> > > +       wake_up_all(&filter->notif->wqh);
> >
> > If select() is polling us, a reference to the open file is being held,
> > and this can't be reached; and I think if epoll is polling us,
> > eventpoll_release() will remove itself from the wait queue, right? So
> > can this wake_up_all() actually ever notify anyone?
>
> I don't know actually, I just thought better safe than sorry. I can
> drop it, though.

Let's see if any fs people have some insight...

> > > +               ret = -ENOENT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       /* Allow exactly one reply. */
> > > +       if (knotif->state != SECCOMP_NOTIFY_SENT) {
> > > +               ret = -EINPROGRESS;
> > > +               goto out;
> > > +       }
> >
> > This means that if seccomp_do_user_notification() has in the meantime
> > received a signal and transitioned from SENT back to INIT, this will
> > fail, right? So we fail here, then we read the new notification, and
> > then we can retry SECCOMP_NOTIF_SEND? Is that intended?
>
> I think so, the idea being that you might want to do something
> different if a signal was sent. But Andy seemed to think that we might
> not actually do anything different.

If you already have the proper response ready, you'd probably want to
just go through with it, no? Otherwise you'll just end up re-emulating
the syscall afterwards for no good reason. If you noticed the
interruption in the middle of the emulated syscall, that'd be
different, but since this is the case where we're already done with
the emulation and getting ready to continue...
