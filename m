Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0582075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U2BGPfQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0582075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeKSHpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:45:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeKSHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:45:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so543600pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rE62Ef+4dHkuH75TyOH6t0fLDXeniDPQYQgw6wqiYFY=;
        b=U2BGPfQQdFHJ3dfzOuZViQfrZ8z0uRhPzrK5Ql/HgGhjZDX88KPGbRoJ3ekfKIJdZN
         uiyff2CkYyokP8PRY0uX4CwpXuX56mqj2+3xTm8a872dTiTWFqMkTnR9dWGMQGUZ1WGg
         K/n3JeySc/lO9ZK91Ewpf+88Ei/bYWKnIW8OHswz8xsxlCdb2chMZZulHX291zhTUIlC
         uMoapM7qTFrzxXmXLolwN8x/SLQ1YRdFTCJxfskJmXLmrp8P+OvtMQriRkPTgaaenJLb
         WYCCcRsQaZfEL4np59TQeifPyVRsnbcDK6gITeaVS4o+qSUKtWoh4dUeHs2ZCJkDJeZN
         vtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rE62Ef+4dHkuH75TyOH6t0fLDXeniDPQYQgw6wqiYFY=;
        b=UnBIiZ46rqWXNXx7/+yteVbv8k8Mz5G83XiOXYpi/B8T+XE6SsEjsqvmGHrn+8JbmZ
         ueHqthS0n5eI/KHCrEU7nEJbEMTZ5Ox0efE83ExP+jvjYd80fw82FnzkEsH7myfW0Xlu
         Jtx/Ba8nJ8NxH8jq/WAf6/VK9TCmZeDl1+3UPorCajQYkN324SUMxDvyPtkSH8J1h/MQ
         69F/PupOZU/Oi45sVERR4PiO6L4kvjuqC+htGimssuEtY82t10ODgGykA4HzdyUTAnLG
         txDXt10LhO2uT5U0J1khNJuM4SI0c4A+NN/OjPH5ZEj33A5Us8nWNMnwgfkz9a6CXzcw
         9/cg==
X-Gm-Message-State: AGRZ1gKnrHK8M3Kt2Z+YKtqKIm7crTUlBYv3IOEb6tk7QlADq5nslW74
        V9ww+7shzqhl98ZA3pP66zBj4Q==
X-Google-Smtp-Source: AJdET5cF+VBv9MeR6yyJv5vI+tBcew6H8eTWvjqkSV7y0dxlKOyJKPomYJVcTej7I6zqElv1yLcF7w==
X-Received: by 2002:a62:4194:: with SMTP id g20-v6mr16104848pfd.44.1542576227746;
        Sun, 18 Nov 2018 13:23:47 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id d65-v6sm57082110pfc.144.2018.11.18.13.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 13:23:46 -0800 (PST)
Date:   Sun, 18 Nov 2018 22:23:37 +0100
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
Message-ID: <20181118212336.53hh3qbjughrtc2l@brauner.io>
References: <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin>
 <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net>
 <20181118204317.seaztq7fqmysucns@brauner.io>
 <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 12:54:10PM -0800, Daniel Colascione wrote:
> On Sun, Nov 18, 2018 at 12:43 PM, Christian Brauner
> <christian@brauner.io> wrote:
> > On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
> >>
> >>
> >> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
> >> >
> >>
> >> >
> >> > That is, I'm proposing an API that looks like this:
> >> >
> >> > int process_kill(int procfs_dfd, int signo, const union sigval value)
> >> >
> >> > If, later, process_kill were to *also* accept process-capability FDs,
> >> > nothing would break.
> >>
> >> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.
> >
> > I can add a flag argument
> > int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
> > The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
> > That is siginfo_t is cleared and set to:
> >
> > info.si_signo = sig;
> > info.si_errno = 0;
> > info.si_code = SI_USER;
> > info.si_pid = task_tgid_vnr(current);
> > info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
> 
> That makes sense. I just don't want to get into a situation where
> callers feel that they *have* to use the PID-based APIs to send a
> signal because process_kill doesn't offer some bit of functionality.

Yeah.

> 
> Are you imagining something like requiring info t be NULL unless flags
> contains some "I have a siginfo_t" value?

Well, I was actually thinking about something like:

/**
 *  sys_process_signal - send a signal to a process trough a process file descriptor
 *  @fd: the file descriptor of the process
 *  @sig: signal to be sent
 *  @info: the signal info
 *  @flags: future flags to be passed
 */
SYSCALL_DEFINE4(process_signal, int, fd, int, sig, siginfo_t __user *, info,
		int, flags)
{
	struct pid *pid;
	struct fd *f;
	kernel_siginfo_t kinfo;

	/* Do not allow users to pass garbage. */
	if (flags)
		return -EINVAL;

	int ret = __copy_siginfo_from_user(sig, &kinfo, info);
	if (unlikely(ret))
		return ret;

	/* For now, enforce that caller's creds are used. */
	kinfo.si_pid = task_tgid_vnr(current);
	kinfo.si_uid = from_kuid_munged(current_user_ns(), current_uid());

	if (signal_impersonates_kernel(kinfo))
		return -EPERM;

	f = fdget(fd);
	if (!f.file)
		return -EBADF;

	pid = f.file->private_data;
	if (!pid)
		return -EBADF;

	return kill_pid_info(sig, kinfo, pid);
}

> 
> BTW: passing SI_USER to rt_sigqueueinfo *should* as long as the
> passed-in si_pid and si_uid match what the kernel would set them to in
> the kill(2) case. The whole point of SI_USER is that the recipient
> knows that it can trust the origin information embedded in the
> siginfo_t in the signal handler. If the kernel verifies that a signal
> sender isn't actually lying, why not let people send SI_USER with
> rt_sigqueueinfo?
