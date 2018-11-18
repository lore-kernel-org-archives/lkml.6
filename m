Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01614C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48B62075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="K84DJMqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48B62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeKSHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:51:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42219 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKSHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:51:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so9355461pfr.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 13:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9QWVQkG8xu5JBngLSB8BjZo/0rFQ9qbvZS5VHtmbr0U=;
        b=K84DJMqfD0sck5ubA+jQizbpSI8xCcPm7lHutMyuPopl58bCYVSbhgBWsyQEGJ+Omi
         t/tvFxQDnK2Fndzs6+hbZQ/u3wSDsTMSv8dI9dX4LfZQWcKXZyLBRWMR6xhGX3SjzPzk
         gf2ScczT3rBYGYN0BKeTO9cCmHSm6B/tmXEzk+yFqf74pddxNa1WpTjJrtmiu+8LddZI
         PD0oJ97q3Bq97d6KflV4zx9/vAzvo9351V/NsEkD0hzmX0O/eLm2Jg/fcPxG8AqyN8Mt
         uQp/9L5fQ19aQnr6Vh0mYPEVinZsXAF2GIEq1ta7qyIfv8awkDhTsBocme0DZLMEk6jk
         aTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9QWVQkG8xu5JBngLSB8BjZo/0rFQ9qbvZS5VHtmbr0U=;
        b=lDjcR4MpuO89MybQAh4bTbovk/WeWGmaFRGExDazNjgE7jPIb/GWtMY88QYL7Gty1p
         tFJiTXD2qZmVwblDV3xyLf9AffmkIzlq9EAtnfWBchfAVKNw5GAnAoGxA3JK1BypiKn+
         SDF6x2Wk3l7sKpR9k4IlSroQrS5D+HFJazZ1wJADJBO0BIUR+Goe9TtV96DZg3qvmXzH
         iK7ZZ+IP7snDGe/Cny/TsdasuRRmmKjbbl7GoDNnusGsZ3sPqg0Eye+20o/t5SPGMB+A
         GcaKmUv0/5ungcdaOyRXXTavcLYuJyBlYDPWq3l/Ep52baYUlMNKbI7+QKvAFcG2FQxo
         oVzQ==
X-Gm-Message-State: AGRZ1gIeKp3bGR6UjWh4Ba8vUXt71g5/Rh/5y5i83q7ZqD6gcWffeAf5
        tjz9xLAYoAThtb8v1Z6x+URKsA==
X-Google-Smtp-Source: AJdET5f5DeFzCbYYwxWhNcOENRVl0PQOvXaXFtWGKx2JTmuRCsJtqbmw6y8Whpt2ldi2/FyiVStQYw==
X-Received: by 2002:aa7:818a:: with SMTP id g10-v6mr20188687pfi.153.1542576633773;
        Sun, 18 Nov 2018 13:30:33 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id u29sm45111789pgn.23.2018.11.18.13.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 13:30:32 -0800 (PST)
Date:   Sun, 18 Nov 2018 22:30:23 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181118213021.24asgwkci3do6oby@brauner.io>
References: <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin>
 <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
 <20181118204317.seaztq7fqmysucns@brauner.io>
 <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
 <20181118212336.53hh3qbjughrtc2l@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181118212336.53hh3qbjughrtc2l@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:23:36PM +0100, Christian Brauner wrote:
> On Sun, Nov 18, 2018 at 12:54:10PM -0800, Daniel Colascione wrote:
> > On Sun, Nov 18, 2018 at 12:43 PM, Christian Brauner
> > <christian@brauner.io> wrote:
> > > On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
> > >>
> > >>
> > >> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
> > >> >
> > >>
> > >> >
> > >> > That is, I'm proposing an API that looks like this:
> > >> >
> > >> > int process_kill(int procfs_dfd, int signo, const union sigval value)
> > >> >
> > >> > If, later, process_kill were to *also* accept process-capability FDs,
> > >> > nothing would break.
> > >>
> > >> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.
> > >
> > > I can add a flag argument
> > > int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
> > > The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
> > > That is siginfo_t is cleared and set to:
> > >
> > > info.si_signo = sig;
> > > info.si_errno = 0;
> > > info.si_code = SI_USER;
> > > info.si_pid = task_tgid_vnr(current);
> > > info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> > 
> > That makes sense. I just don't want to get into a situation where
> > callers feel that they *have* to use the PID-based APIs to send a
> > signal because process_kill doesn't offer some bit of functionality.
> 
> Yeah.
> 
> > 
> > Are you imagining something like requiring info t be NULL unless flags
> > contains some "I have a siginfo_t" value?
> 
> Well, I was actually thinking about something like:
> 
> /**
>  *  sys_process_signal - send a signal to a process trough a process file descriptor
>  *  @fd: the file descriptor of the process
>  *  @sig: signal to be sent
>  *  @info: the signal info
>  *  @flags: future flags to be passed
>  */
> SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
> 		int, flags)
> {
> 	struct pid *pid;
> 	struct fd *f;
> 	kernel_siginfo_t kinfo;
> 
> 	/* Do not allow users to pass garbage. */
> 	if (flags)
> 		return -EINVAL;
> 
> 	int ret = __copy_siginfo_from_user(sig, &kinfo, info);
> 	if (unlikely(ret))
> 		return ret;
> 
> 	/* For now, enforce that caller's creds are used. */
> 	kinfo.si_pid = task_tgid_vnr(current);
> 	kinfo.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> 
> 	if (signal_impersonates_kernel(kinfo))
> 		return -EPERM;
> 
> 	f = fdget(fd);
> 	if (!f.file)
> 		return -EBADF;
> 
> 	pid = f.file->private_data;
> 	if (!pid)
> 		return -EBADF;
> 
> 	return kill_pid_info(sig, kinfo, pid);
> }

Just jotted this down here briefly. This will need an fput and so on
obvs.

> 
> > 
> > BTW: passing SI_USER to rt_sigqueueinfo *should* as long as the
> > passed-in si_pid and si_uid match what the kernel would set them to in
> > the kill(2) case. The whole point of SI_USER is that the recipient
> > knows that it can trust the origin information embedded in the
> > siginfo_t in the signal handler. If the kernel verifies that a signal
> > sender isn't actually lying, why not let people send SI_USER with
> > rt_sigqueueinfo?
