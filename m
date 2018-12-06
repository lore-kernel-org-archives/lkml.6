Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8A5208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goKYJGD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8A5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLFUhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:37:34 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36716 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLFUhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:37:33 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so638427uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYCcIOJ2vsorXDM9ffiKrbhkYhg5hHBZSFNHW0W5e0c=;
        b=goKYJGD/FMVIO8VMYHjlKxo7cbQYR7+ESSWD6J9Q/TGpQcz+wpWgoRYWOoEZXS4MWn
         wyoXt4MTkEdrAGwlOs5TwyqARGT7Y+kBfE8foei1gGEd3Gv/i/b2l/vpOlNf/zVy8rn+
         XfTHAyooGh8Q5T/v671e8GSgC2mtJFAKTSe2k9h5M8hKmM0ZN92tDDLAYjJcrTH0jXoj
         BjatYU34HyJ5MvxQn2e4tVVdoiJoF3y1q8wCMuwBfM0p+3anDKredfvmzFY3ygley6a0
         zL6dxJCShCYYeOBkKwWRyAQpRtem6Amto7mhiExu2ss6ixCLOCBY6N1O5Yat56u8kP8Z
         dp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYCcIOJ2vsorXDM9ffiKrbhkYhg5hHBZSFNHW0W5e0c=;
        b=lBKv5EPW5gj62luSu8txDczfcnHvZa6I0ozatEAlAjIopX9KTs5wPP0EEiYhT9D8PH
         Br/UXxIjjZalV7Zpll6Vk2AOpY15/pYRCh8AOl8V1sAfQCi30WSxRA7/1fjD1vvk3nMa
         L7zWRcdIP5IqYsug38096iZfNbNEdTbeApdIdD/YJz9F1mzzGHAM4oIaphdcd7hrFzWT
         x2oCrjR575TfQRwoHq311lL7rWnd//v87l+ZuHTX3CLC5Lk1k0QtfdU3giClA8i0m7BY
         FOVqR9gPPL7ugI+yu7r7D36iOF2dglGKMw73rxGBQz6SYgmZp+xbP8A4rN7pFNUGzwf2
         E5uw==
X-Gm-Message-State: AA+aEWYzD5bL3kKeQ9Fn5v/DX6xRnbdcPIMHF18Acx28/4PV7majwPmE
        RLPJeM83KuNexKft+2IbaFIY0/p1a6paRkqYeGsjPSgj
X-Google-Smtp-Source: AFSGD/WKebAUh1arv4rpeFcmXN30D8j8vtkquus0DVNiEvvzWh9jlSBLc80l0viOgaAT4oNXwU2Jo10qyNgTgns7Rm8=
X-Received: by 2002:ab0:72a:: with SMTP id h39mr14021921uah.11.1544128651936;
 Thu, 06 Dec 2018 12:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io> <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io> <871s6u9z6u.fsf@xmission.com>
In-Reply-To: <871s6u9z6u.fsf@xmission.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 12:37:20 -0800
Message-ID: <CAKOZuevgPv1CbAZF-ha0njdq6rd6QkU7T8qmmERJLsL45CeVzg@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 12:29 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Christian Brauner <christian@brauner.io> writes:
>
> > On Thu, Dec 06, 2018 at 01:17:24PM -0600, Eric W. Biederman wrote:
> >> Christian Brauner <christian@brauner.io> writes:
> >>
> >> > On December 7, 2018 4:01:19 AM GMT+13:00, ebiederm@xmission.com wrote:
> >> >>Christian Brauner <christian@brauner.io> writes:
> >> >>
> >> >>> The kill() syscall operates on process identifiers (pid). After a
> >> >>process
> >> >>> has exited its pid can be reused by another process. If a caller
> >> >>sends a
> >> >>> signal to a reused pid it will end up signaling the wrong process.
> >> >>This
> >> >>> issue has often surfaced and there has been a push [1] to address
> >> >>this
> >> >>> problem.
> >> >>>
> >> >>> This patch uses file descriptors (fd) from proc/<pid> as stable
> >> >>handles on
> >> >>> struct pid. Even if a pid is recycled the handle will not change. The
> >> >>fd
> >> >>> can be used to send signals to the process it refers to.
> >> >>> Thus, the new syscall taskfd_send_signal() is introduced to solve
> >> >>this
> >> >>> problem. Instead of pids it operates on process fds (taskfd).
> >> >>
> >> >>I am not yet thrilled with the taskfd naming.
> >> >
> >> > Userspace cares about what does this thing operate on?
> >> > It operates on processes and threads.
> >> > The most common term people use is "task".
> >> > I literally "polled" ten non-kernel people for that purpose and asked:
> >> > "What term would you use to refer to a process and a thread?"
> >> > Turns out it is task. So if find this pretty apt.
> >> > Additionally, the proc manpage uses task in the exact same way (also see the commit message).
> >> > If you can get behind that name even if feeling it's not optimal it would be great.
> >>
> >> Once I understand why threads and not process groups.  I don't see that
> >> logic yet.
> >
> > The point is: userspace takes "task" to be a generic term for processes
> > and tasks. Which is what is important. The term also covers process
> > groups for all that its worth. Most of userspace isn't even aware of
> > that distinction necessarily.
> >
> > fd_send_signal() makes the syscall name meaningless: what is userspace
> > signaling too? The point being that there's a lot more that you require
> > userspace to infer from fd_send_signal() than from task_send_signal()
> > where most people get the right idea right away: "signals to a process
> > or thread".
> >
> >>
> >> >>Is there any plan to support sesssions and process groups?
> >> >
> >> > I don't see the necessity.
> >> > As I said in previous mails:
> >> > we can emulate all interesting signal syscalls with this one.
> >>
> >> I don't know what you mean by all of the interesting signal system
> >> calls.  I do know you can not replicate kill(2).
> >
> > [1]: You cannot replicate certain aspects of kill *yet*. We have
> > established this before. If we want process group support later we do
> > have the flags argument to extend the sycall.
>
> Then you have horrible contradiction in the API.
>
> Either the grouping is a property of your file descriptor or the
> grouping comes from the flags argument.
>
> If the grouping is specified in the flags argument then pidfd is the
> proper name for your file descriptors, and the appropriate prefix
> for your system call.

Yes and no. "taskfd" is fine, since even if we do add a
kill-process-group capability, the general facility under discussion
is still *about* tasks in general, so "taskfd" still tells you in a
general sense what the thing does. "pidfd" would be wrong, and for the
same reason that the kernel's "struct pid" is badly-named: the object
being named is a *task*, and signaling a particular task instead of
whatever task happens to be labeled with a particular numeric PID at
the time of all is the whole point of this change.

> If the grouping is a property of your file descriptor it does not make
> sense to talk about using the flags argument later.
>
> Your intention is to add the thread case to support pthreads once the
> process case is sorted out.  So this is something that needs to be made
> clear.  Did I miss how you plan to handle threads?
>
> And this fundamentally and definitely gets into all of my concerns about
> proper handling of pid_task and PIDTYPE_TGID etc.

To the extent that it's possible, this system call should mimic the
behavior of a signal-send to a positive numeric PID (i.e., a specific
task), so if we change one, we should change both.
