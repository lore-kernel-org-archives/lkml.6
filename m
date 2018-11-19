Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA4EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC152080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 00:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMnhyVtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC152080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeKSKxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 05:53:15 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38609 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeKSKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 05:53:14 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so16794140vsa.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 16:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J9jWcfM1lf5Nw19hr8EfJaBkuFiDFUVblfNS2Vd9O1k=;
        b=EMnhyVtK1+EPIhTkuWH9jZquX1YryPdAH9BWE8aur4SQcSI0IkTrrItGCjdc5IhHOB
         8TtW3lp7UbMF7NJ6SAcCzvcMXFfDsALslnGlXnk2m52JPSHYAw5jw57xI0LnoyNaRsKo
         woRpIVcDgBrRzjxtx7atH22htgAi62juqUP2nLfWn4hyBdanZGe8L4BpvsBFDEuxmvls
         1EJAQcT34pU5ug6GbgZlir0lVY5uBavTh4JpkElbUhUvlqeQr8tPf15fdl655RnblSQw
         mrDI3eisWxS1JvyE2lCiq+S1qQMJtKrKAuv8d1VEUGS+0PQhkHjrxU3Ax4E1YwaQlekJ
         2E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J9jWcfM1lf5Nw19hr8EfJaBkuFiDFUVblfNS2Vd9O1k=;
        b=BhYhJayixe9NJ3BBV+mESrTxBjiydpDSYl6tZLpxn1njZHzYZB9ysdRri8ZeMK2eR8
         nS9sXKiFhR1yt9xsCelPfklQjoOq98bU/vDgcm7ZlGkjLiZ384P+dhWu3IAg9CGZzUBC
         RkJyTbYbMrf+GJE9ooWGHftaiNIqz7TEkvE/JHXcEfNyYrE8S6WdvaZjLFMJnF0p/liK
         5kvAqKsIQXp6IXB2HNJXtRYwSoy2dyqK/FSV1xmZJG/5nHfh9KwkUwLEJuE7MOV1jKcW
         IICaO0jQc90odt0O0LH6fumKJQrgpsAAPcuz+8m2trv7NGNbik4OjKlw3JmEqPjGvTvE
         oURQ==
X-Gm-Message-State: AGRZ1gLK3z1S+2OtTRTvM1wfulF9nIl7T+2vEVZswSQCLryuP8LuIwgQ
        vcuTZad38BWVuw38bLs7RzEpIadr1CHipvJVEGiLDw==
X-Google-Smtp-Source: AJdET5d4cO8y4XUvAwxeaidLZktke8D25cB8GIS9nmIQp+3wKAUiM8Ry8TI+aepTmjj0rXKYg7Xv/BlOs0+5Ct/9F/E=
X-Received: by 2002:a67:b44:: with SMTP id 65mr8165388vsl.77.1542587483477;
 Sun, 18 Nov 2018 16:31:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 16:31:22
 -0800 (PST)
In-Reply-To: <20181118213021.24asgwkci3do6oby@brauner.io>
References: <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net> <20181118204317.seaztq7fqmysucns@brauner.io>
 <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
 <20181118212336.53hh3qbjughrtc2l@brauner.io> <20181118213021.24asgwkci3do6oby@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 16:31:22 -0800
Message-ID: <CAKOZuetT8mzZJR-K_W0VM7Dg1c1SnH8tW-HXxMT77yS0DE453w@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 1:30 PM, Christian Brauner <christian@brauner.io> wrote:
> On Sun, Nov 18, 2018 at 10:23:36PM +0100, Christian Brauner wrote:
>> On Sun, Nov 18, 2018 at 12:54:10PM -0800, Daniel Colascione wrote:
>> > On Sun, Nov 18, 2018 at 12:43 PM, Christian Brauner
>> > <christian@brauner.io> wrote:
>> > > On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
>> > >>
>> > >>
>> > >> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
>> > >> >
>> > >>
>> > >> >
>> > >> > That is, I'm proposing an API that looks like this:
>> > >> >
>> > >> > int process_kill(int procfs_dfd, int signo, const union sigval value)
>> > >> >
>> > >> > If, later, process_kill were to *also* accept process-capability FDs,
>> > >> > nothing would break.
>> > >>
>> > >> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.
>> > >
>> > > I can add a flag argument
>> > > int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
>> > > The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
>> > > That is siginfo_t is cleared and set to:
>> > >
>> > > info.si_signo = sig;
>> > > info.si_errno = 0;
>> > > info.si_code = SI_USER;
>> > > info.si_pid = task_tgid_vnr(current);
>> > > info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
>> >
>> > That makes sense. I just don't want to get into a situation where
>> > callers feel that they *have* to use the PID-based APIs to send a
>> > signal because process_kill doesn't offer some bit of functionality.
>>
>> Yeah.
>>
>> >
>> > Are you imagining something like requiring info t be NULL unless flags
>> > contains some "I have a siginfo_t" value?
>>
>> Well, I was actually thinking about something like:
>>
>> /**
>>  *  sys_process_signal - send a signal to a process trough a process file descriptor
>>  *  @fd: the file descriptor of the process
>>  *  @sig: signal to be sent
>>  *  @info: the signal info
>>  *  @flags: future flags to be passed
>>  */
>> SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
>>               int, flags)
>> {
>>       struct pid *pid;
>>       struct fd *f;
>>       kernel_siginfo_t kinfo;
>>
>>       /* Do not allow users to pass garbage. */
>>       if (flags)
>>               return -EINVAL;
>>
>>       int ret = __copy_siginfo_from_user(sig, &kinfo, info);
>>       if (unlikely(ret))
>>               return ret;
>>
>>       /* For now, enforce that caller's creds are used. */
>>       kinfo.si_pid = task_tgid_vnr(current);
>>       kinfo.si_uid = from_kuid_munged(current_user_ns(), current_uid());

How about doing it this way? If info is NULL, act like kill(2);
otherwise, act like rt_sigqueueinfo(2).

(Not actual working or compiled code.)

SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
              int, flags)
{
        struct fd f = { 0 };
        kernel_siginfo_t kinfo;
        int ret;

        /* Make API extension possible.  */
        ret = -EINVAL;
        if (flags)
                goto out;

        ret = -EBADF;
        f = fdget(fd);
        if (!f.file)
                goto out;

        ret = mumble_mumble_check_real_proc_file(f.file);
        if (ret)
                goto out;

        /* Act like kill(2) or rt_sigqueueinfo(2) depending on whether
         * the user gave us a siginfo structure.
         */
        if (info) {
                ret = __copy_siginfo_from_user(sig, &kinfo, info);
                if (ret)
                        goto out;
                /* Combine this logic with rt_sigqueueinfo(2) */
                ret = -EPERM;
                if ((info->si_code >= 0 || info->si_code == SI_TKILL) &&
                    (task_pid_vnr(current) != pid))
                        goto out;

        } else {
                /* Combine this logic with kill(2) */
                clear_siginfo(&kinfo);
                kinfo.si_signo = sig;
                kinfo.si_errno = 0;
                kinfo.si_code = SI_USER;
                kinfo.si_pid = task_tgid_vnr(current);
                kinfo.si_uid = from_kuid_munged(current_user_ns(),
current_uid());
        }

        ret = kill_pid_info(sig, &kinfo, proc_pid(file_inode(f.file)));

out:
        if (f.file)
                fput(f);
        return ret;
}
