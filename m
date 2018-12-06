Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4511C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAA2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fG5VY4b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CAA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLFVco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:32:44 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33986 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLFVcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:32:09 -0500
Received: by mail-pl1-f172.google.com with SMTP id w4so774390plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SQGgSb/KnMtoG4jQJN1PfQ9jFVjQzn4lSqrAShZGfPc=;
        b=fG5VY4b1Jj+02ynTkkJlhLNJ5mOWWC2oEPd0XbfgVFWPLunFfJ+1t9Rt6I118mngnM
         GIGOotAraCLPxrjGqJEX+N/6fJSrl0AMiVpKOblJcGDjxH0xR2plVonZb/pvyE6jIPUE
         lHWWiKnq5dLaBfIDppJ6FDaeCpq+qT6T7rfsxv+KKHuIs1tQ93tQADHrgoDujBj/8Ycl
         /Nh1w5VZu30UF5ZRNk9K3TbemXwq5/yRy4rVqyAiZoJzivv/r40waWQ2OoajJ18FS7we
         N1G5PWQjgrpdecnG2JvLiJv1fPlA8aNS1Krv2P5/uqsEdH3FPSZqpEHPnqWmQQyX9mPe
         vvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SQGgSb/KnMtoG4jQJN1PfQ9jFVjQzn4lSqrAShZGfPc=;
        b=ORoasb4XCF0T1CmSymjLd1dgQTVocouxWwavuH0bmgIdhmdZbJoLN6BQj4KolANt1r
         FIgPJDqLobP2MkGPeNy5yhmFriRIO6WXRNwdGU5Qh/fyFGefjoc8tKJUuVs/g9wQm3MH
         0pvvVfkn5FoZP1qN5UwkzT69Qc8zgzGKFLbo5vQ1INlkgjxuX6RnGy594AEwPirE3wSn
         1TetVu0WqcgyYSkGABfbm4ir6KBdKesGX0XuyNBtlJ5fL68dqQN/CcEzkDG+9m7G85kM
         w1z3OIQozzrmLI/bFQkvNMpIDEC27x8QsQApquCuqvAHyIaecTHXBwcVkVWCNtV8FHRG
         O2NA==
X-Gm-Message-State: AA+aEWY9vkGavOgYXBFVEaWPCto8ssOKXo1I5HqdULfW4EYAwNa3atp9
        QDD7crLycYoUsUO7+emcZbTzyxOx5FGZQw==
X-Google-Smtp-Source: AFSGD/X+exnoI51REF40RGArGEdD14EJuN4S8BZVYIr34h3VJs5qKXikeU3h0QH6jtbINCf9kXXN6A==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr29404714pll.33.1544131928434;
        Thu, 06 Dec 2018 13:32:08 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id m20sm1147218pgv.93.2018.12.06.13.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 13:32:07 -0800 (PST)
Date:   Thu, 6 Dec 2018 22:31:57 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206213152.gvci7ijr3dokew7w@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
 <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
 <871s6u9z6u.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s6u9z6u.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:29:13PM -0600, Eric W. Biederman wrote:
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

See the first part of Daniel's answer in [1] answer which makes sense to
me. I won't repeat it here.
[1]: https://lore.kernel.org/lkml/CAKOZuevgPv1CbAZF-ha0njdq6rd6QkU7T8qmmERJLsL45CeVzg@mail.gmail.com/

> 
> If the grouping is specified in the flags argument then pidfd is the
> proper name for your file descriptors, and the appropriate prefix
> for your system call.
> 
> If the grouping is a property of your file descriptor it does not make
> sense to talk about using the flags argument later.
> 
> Your intention is to add the thread case to support pthreads once the
> process case is sorted out.  So this is something that needs to be made
> clear.  Did I miss how you plan to handle threads?

Yeah, maybe you missed it in the commit message [2] which is based on a
discussion with Andy [3] and Arnd [4]:

[2]: https://lore.kernel.org/lkml/20181206121858.12215-1-christian@brauner.io/
     /* taskfd_send_signal() replaces multiple pid-based syscalls */
    The taskfd_send_signal() syscall currently takes on the job of the
    following syscalls that operate on pids:
    - kill(2)
    - rt_sigqueueinfo(2)
    The syscall is defined in such a way that it can also operate on thread fds
    instead of process fds. In a future patchset I will extend it to operate on
    taskfds from /proc/<pid>/task/<tid> at which point it will additionally
    take on the job of:
    - tgkill(2)
    - rt_tgsigqueueinfo(2)
    Right now this is intentionally left out to keep this patchset as simple as
    possible (cf. [4]). If a taskfd of /proc/<pid>/task/<tid> is passed
    EOPNOTSUPP will be returned to give userspace a way to detect when I add
    support for such taskfds (cf. [10]).

[3]: https://lore.kernel.org/lkml/CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com/
     > Yes, I see no reason why not. My idea is to extend it - after we have a
     > basic version in - to also work with:
     > /proc/<pid>/task/<tid>
     > If I'm not mistaken this should be sufficient to get rt_tgsigqueueinfo.
     > The thread will be uniquely identified by the tid descriptor and no
     > combination of /proc/<pid> and /proc/<pid>/task/<tid> is needed. Does
     > that sound reasonable?
    
     Yes. So it would currently replace rt_gsigqueueinfo() but
     not rt_tgsigqueueinfo(), and could be extended to do both
     afterwards, without making the interface ugly in any form?
     
     I suppose we can always add more flags if needed, and you
     already ensure that flags is zero for the moment.

[4]: https://lore.kernel.org/lkml/CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com/
     "Is the current procfd_signal() proposal (under whichever name)
     sufficient to correctly implement both sys_rt_sigqueueinfo() and
     sys_rt_tgsigqueueinfo()?"

> 
> And this fundamentally and definitely gets into all of my concerns about
> proper handling of pid_task and PIDTYPE_TGID etc.
> 
> >> Sending signals to a process group the "kill(-pgrp)" case with kill
> >> sends the signals to an atomic snapshot of processes.  If the signal
> >> is SIGKILL then it is guaranteed that then entire process group is
> >> killed with no survivors.
> >
> > See [1].
> >
> >> 
> >> > We succeeded in doing that.
> >> 
> >> I am not certain you have.
> >
> > See [1].
> >
> >> 
> >> > No need to get more fancy.
> >> > There's currently no obvious need for more features.
> >> > Features should be implemented when someone actually needs them.
> >> 
> >> That is fair.  I don't understand what you are doing with sending
> >> signals to a thread.  That seems like one of the least useful
> >> corner cases of sending signals.
> >
> > It's what glibc and Florian care about for pthreads and their our
> > biggest user atm so they get some I'd argue they get some say in this. :)
> 
> Fair enough.  If glibc could use this then we certainly have users and a
> user case.

Florian was asking specifically in [5]:

[5]: https://lore.kernel.org/lkml/87in0g5aqo.fsf@oldenburg.str.redhat.com/
     "Looking at the rt_tgsigqueueinfo interface, is there a way to implement
     the “tg” part with the current procfd_signal interface?"

> 
> Eric
