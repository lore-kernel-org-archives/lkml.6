Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EBC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CC520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpCWlLny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CC520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLFWnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:43:42 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42209 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLFWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:43:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so1329387vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGrQwYLmnukcpJtpUnCarc+d2xCO3T8JySHhNzbHxME=;
        b=KpCWlLny6xFNYYEcX+tPuJ03w3WwN4CBMahyco3AuS3D29w9169o53THH18x5sUj7+
         osxKGxHLOZtOmPan1/vbPUruyC4n5R6YbwRoUIMS30ka02uKdhyanPPV1M/9zlwXwmBs
         nerGKz0Up9XZtOAYVYwc2DslP7o4CL+psB4VZpfUOrcGG2uU2GG8eTvs23t66bAR6Naj
         K0cvo5lbnTxkz24ifqIsLZ3CRdsjxTNrPQF3Hl5CV8eo5Ne7rbVrlhp7wOTVwX0VRtUG
         Q/bK0K/4Xhs5C3TuRm/N2vG8FMkCvXscqGGO32Ej/GyaCRAkNQCa2G4CQRQjWAjflXHK
         XQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGrQwYLmnukcpJtpUnCarc+d2xCO3T8JySHhNzbHxME=;
        b=uDLG/LtOzsvNa9mQ8cQy5w+ez+2oPKAQQtVNO9avxwl8DOXcrbl4L1aD3x4ComzCmp
         1eCqxFl+108qLKJ+Y7MoEUW9j9r/nquJatqtPQTUdX+TGwC9fG+sKfSMy792uBh1uTqi
         Z2/i2zE4gChuRINToJDzJqWGq5uZ7Gw7Y37HvP6PqI6FJf45bkvsNW2uZWtH5WpitHbO
         o33jN1y2aUxoS8lzHrDC11oxxZnqhhsdvWtBrZgBlovPTqiLb5B7ELCAIEyP0jlILJGJ
         uYnFfcAercuEzykxkNR2OJene1CRd8Q9d7bsHNdELK8qTdI9mY77lhWQQlVU8gDHOTXx
         nIIA==
X-Gm-Message-State: AA+aEWY7o6Zj8zji09jMyOnpysZuRwvzVUHL9+Vam1B7/Y6bl8IzskwT
        uJtV0pVqC+WihrB7Kchk8wq7e2kXzZsPHAHWCC/D0Q==
X-Google-Smtp-Source: AFSGD/VwBtA3V+lysm+1qJc4OdKNSJ4CWYDjYMZXjbXiNXLRpv6y/UiPrBOHOYP4eumga0g2sJCLBQ1H2mckddJ/2Ec=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr13761958vsc.171.1544136220011;
 Thu, 06 Dec 2018 14:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io> <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io> <871s6u9z6u.fsf@xmission.com>
 <CAKOZuevgPv1CbAZF-ha0njdq6rd6QkU7T8qmmERJLsL45CeVzg@mail.gmail.com> <87in0647og.fsf@xmission.com>
In-Reply-To: <87in0647og.fsf@xmission.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 14:43:27 -0800
Message-ID: <CAKOZuevqbmww0Ep+3gM73bm6H=1kUp1od8--QctuardSCaJxvw@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 2:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Daniel Colascione <dancol@google.com> writes:
>
> > On Thu, Dec 6, 2018 at 12:29 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Christian Brauner <christian@brauner.io> writes:
> >>
> >> > [1]: You cannot replicate certain aspects of kill *yet*. We have
> >> > established this before. If we want process group support later we do
> >> > have the flags argument to extend the sycall.
> >>
> >> Then you have horrible contradiction in the API.
> >>
> >> Either the grouping is a property of your file descriptor or the
> >> grouping comes from the flags argument.
> >>
> >> If the grouping is specified in the flags argument then pidfd is the
> >> proper name for your file descriptors, and the appropriate prefix
> >> for your system call.
> >
> > Yes and no. "taskfd" is fine, since even if we do add a
> > kill-process-group capability, the general facility under discussion
> > is still *about* tasks in general, so "taskfd" still tells you in a
> > general sense what the thing does. "pidfd" would be wrong, and for the
> > same reason that the kernel's "struct pid" is badly-named: the object
> > being named is a *task*, and signaling a particular task instead of
> > whatever task happens to be labeled with a particular numeric PID at
> > the time of all is the whole point of this change.
>
> No.  The object being named by struct pid is an identifier.
>
> The same identifier can label processes, the same identifier can
> label threads, the same identifier can label process groups the
> same identifier can label sessions.
>
> That is fundamental to how that identifier works.
>
> Now the new file descriptor can either be a handle to the struct pid
> the general purpose identifier, or the file descriptor can be a handle
> to a process.  Other file descriptor types would be handles to different
> kinds of processes.

If you open /proc/pid, you get a file descriptor of type A. If you
pass that file descriptor to taskfd_signal, you signal the process. If
you open a file descriptor to /proc/pid/task/tid, you get a file
descriptor of type B, and if you pass that file descriptor to
taskfd_signal, you signal the thread. A and B are *already* distinct.
The only reason you'd want to require a flag for case B is to reduce
the probability of error. The flag wouldn't let you open /proc/pid,
yielding an A, and then pass it to taskfd_signal with a flag saying
"interpret as B".

I understand that it'd be inconsistent to later add a flag saying
"interpret this A as a reference to its whole process group", because
with respect to the difference between threads and processes, it's the
file descriptor type that controls the operation invoked, not the
flags. We can solve that by introducing a new FD type for a process
group or by just allowing the "casting" via flag, but we're not at the
point of having to decide that just yet, and I don't think the API is
particularly bad either way.

If you don't want to require a flag value when passing a B, then fine.
It'll work either with or without the flag. If, instead, you want the
flag to allow "casting" an A to a B or vice versa, that's fine too.

> When people tell me the new interface can handle process groups or
> sessions by just adding a flag.  I hear they want to have an handle
> to struct pid then general purpose identifier.  Because it doesn't make
> any sense at all to add a flag to when you need to add a new file
> descriptor type to keep the API consistent.
>
> Later when I hear people say that they want an identifier for a process
> and not have a handle to a general purpose identifier I think they need
> to think about differnt types of file descriptors for the different
> purposes.  The flags argument does not help at all there.
>
> >> If the grouping is a property of your file descriptor it does not make
> >> sense to talk about using the flags argument later.
> >>
> >> Your intention is to add the thread case to support pthreads once the
> >> process case is sorted out.  So this is something that needs to be made
> >> clear.  Did I miss how you plan to handle threads?
> >>
> >> And this fundamentally and definitely gets into all of my concerns about
> >> proper handling of pid_task and PIDTYPE_TGID etc.
> >
> > To the extent that it's possible, this system call should mimic the
> > behavior of a signal-send to a positive numeric PID (i.e., a specific
> > task), so if we change one, we should change both.
>
> There is a special case in kill(2) where we treat an identifier that
> only identifies a thread as an identifier of a process.  We should
> not copy that.

Sure.
