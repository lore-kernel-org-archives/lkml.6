Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7618BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1814920820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piMmBGAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1814920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeKAUfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:35:18 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43398 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeKAUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:35:18 -0400
Received: by mail-ua1-f67.google.com with SMTP id c89so7085256uac.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 04:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vyldVe/tmwMDD3I69Ns05eabVxXWIBYjd/pDrNnXdv8=;
        b=piMmBGAdQE44Qb3u86+krG0RpMlW8SWLiMg596LJWi6o+rPxokVmGUvEDpzleZFFwP
         nOic0a0GRYbc5gxtM5Rh3KlgnIGwXGjMfd6PO9tXZFUNR49I9zvwhnPuBxghGLyiLWE7
         znfO0H731u5+hdMJbq65Odwie/BfiCfKRvxfCg2x/1fL2mtbOZlbcsR6FcBgC22Nx2oW
         8WecR6c1TYzWhbbzRLgta+ABbzTR/lYm27XRrlXg1k2iOQyR39pCaiGvuC4/CsPxc76V
         h0udRcjDvM2D9gcFTA3X4ft1+XqnawI3YC2hrUuRVjkgl+CiTh1AS/hc3wGjEbYvNZxY
         iP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vyldVe/tmwMDD3I69Ns05eabVxXWIBYjd/pDrNnXdv8=;
        b=PQ6PY0TC6KbzFlSnJlZViAovC9wUG6btrc8ctI4bfZRKyOEBUk0icWC5Er/1RlY2tC
         PTWuH07hw9ghLpFKKKYGFTd0hvlN3CBb6FWPWlz6nCOJtR6h+R10AEKnOkvSP+GkPBRk
         eJ3RkbWr+at/uZ81paLjqK+zXytvmfSo6p6jiY8z4ykh499EVBDmsMPnQ8x2I0RpQFib
         ihAePU5UbtE26sC7n8XBeiWCexh/iWZ2Y8kBEj7xYj3M5DEoI6URYOCz16js2FHjKxmO
         tdepteKwlrlAoEN0h39BpnXaXbVs9T1d6QlnYX6RKYjhdMXatQ2Q94Hh+RnHp3qyvcE/
         4oyQ==
X-Gm-Message-State: AGRZ1gIVDXpsl71N3RQgMnSQnU54kHLxBMAV62ek+nf8fsdnClkCgwqn
        ygmBbrQrafHHzIHszOpeukQT9LMCz2Z40o5tbTXb3g==
X-Google-Smtp-Source: AJdET5dqNfuAT2TVNyM4jjpgehfhzqDEdvlxHSQSMRiWBag3zgP6xQOfB2UUqCibvRX12eWg+qKcF8M0+z63uGY8lH0=
X-Received: by 2002:ab0:5648:: with SMTP id z8mr3099312uaa.126.1541071963488;
 Thu, 01 Nov 2018 04:32:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 04:32:42 -0700 (PDT)
In-Reply-To: <20181101104750.q23rb3hczx2tzakq@yavin>
References: <20181029175322.189042-1-dancol@google.com> <20181029192250.130551-1-dancol@google.com>
 <20181101070036.l24c2p432ohuwmqf@yavin> <CAKOZueszfoSM0pxhmuFLOuPmJqSfYXxgutstyCgqxAyoUi4h3w@mail.gmail.com>
 <20181101104750.q23rb3hczx2tzakq@yavin>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 1 Nov 2018 11:32:42 +0000
Message-ID: <CAKOZueussVwABQaC+O9fW+MZayccvttKQZfWg0hh-cZ+1ykXig@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Minimal non-child process exit notification support
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:47 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-11-01, Daniel Colascione <dancol@google.com> wrote:
>> On Thu, Nov 1, 2018 at 7:00 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>> > On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
>> >> This patch adds a new file under /proc/pid, /proc/pid/exithand.
>> >> Attempting to read from an exithand file will block until the
>> >> corresponding process exits, at which point the read will successfully
>> >> complete with EOF.  The file descriptor supports both blocking
>> >> operations and poll(2). It's intended to be a minimal interface for
>> >> allowing a program to wait for the exit of a process that is not one
>> >> of its children.
>> >>
>> >> Why might we want this interface? Android's lmkd kills processes in
>> >> order to free memory in response to various memory pressure
>> >> signals. It's desirable to wait until a killed process actually exits
>> >> before moving on (if needed) to killing the next process. Since the
>> >> processes that lmkd kills are not lmkd's children, lmkd currently
>> >> lacks a way to wait for a process to actually die after being sent
>> >> SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>> >> entry. This interface allow lmkd to give up polling and instead block
>> >> and wait for process death.
>> >
>> > I agree with the need for this interface (with a few caveats), but there
>> > are a few points I'd like to make:
>> >
>> >  * I don't think that making a new procfile is necessary. When you open
>> >    /proc/$pid you already have a handle for the underlying process, and
>> >    you can already poll to check whether the process has died (fstatat
>> >    fails for instance). What if we just used an inotify event to tell
>> >    userspace that the process has died -- to avoid userspace doing a
>> >    poll loop?
>>
>> I'm trying to make a simple interface. The basic unix data access
>> model is that a userspace application wants information (e.g., next
>> bunch of bytes in a file, next packet from a socket, next signal from
>> a signal FD, etc.), and tells the kernel so by making a system call on
>> a file descriptor. Ordinarily, the kernel returns to userspace with
>> the requested information when it's available, potentially after
>> blocking until the information is available. Sometimes userspace
>> doesn't want to block, so it adds O_NONBLOCK to the open file mode,
>> and in this mode, the kernel can tell the userspace requestor "try
>> again later", but the source of truth is still that
>> ordinarily-blocking system call. How does userspace know when to try
>> again in the "try again later" case? By using
>> select/poll/epoll/whatever, which suggests a good time for that "try
>> again later" retry, but is not dispositive about it, since that
>> ordinarily-blocking system call is still the sole source of truth, and
>> that poll is allowed to report spurious readabilty.
>
> inotify gives you an event if a file or directory is deleted. A pid
> dying semantically is similar to the idea of a /proc/$pid being deleted.
> I don't see how a blocking read on a new procfile is simpler than using
> the existing notification-on-file-events infrastructure -- not to
> mention that the idea of "this file blocks until the thing we are
> indirectly referencing by this file is gone" seems to me to be a really
> strange interface.

There's another subtlety: we don't want to wait until a process's proc
entry is *gone*. We want to wait until the process is *dead* (since
that's when its resources are released). If a process becomes a zombie
instead of going TASK_DEAD immediately, than it dies before its
/proc/pid directory disappears, so any API that talks about /proc/pid
directory presence will do the wrong thing. inotify gets this subtlety
wrong because a process is an object, not a file, and not a directory.
Using filesystem monitoring APIs to monitor process state is simply
the wrong approach, because you're mixing up some interface label for
an object with the object itself. Confusing objects and labels is how
we got the F_SETLK mess, among other things.

In other words, a process has an entire lifecycle in its own right
independent of whatever procfs is doing. Procfs is just an interface
for learning things about processes and doesn't control process
lifetime, so basing the "source of truth" for process notifications on
whatever is happening over in procfs is going to cause problems sooner
or later. We care about the process. (That's not the same as struct
task for various reasons, but logically, a process is a coherent
entity.)

> Sure, it uses read(2) -- but is that the only constraint on designing
> simple interfaces?

No, but if an interface requires some kind of setup procedure,
listener registration, event queue draining, switching on event queue
notification types, and scan-on-queue-overflow behavior, chances are
that it's not a simple interface.

>> The event file I'm proposing is so ordinary, in fact, that it works
>> from the shell. Without some specific technical reason to do something
>> different, we shouldn't do something unusual.
>
> inotify-tools are available on effectively every distribution.

Linux is more than the big distributions. What about embedded systems?
What about Android? What about minimal containers? We're talking about
a fundamental improvement in the process management system, and that
shouldn't depend on inotify.

>> Given that we *can*, cheaply, provide a clean and consistent API to
>> userspace, why would we instead want to inflict some exotic and
>> hard-to-use interface on userspace instead? Asking that userspace poll
>> on a directory file descriptor and, when poll returns, check by
>> looking for certain errors (we'd have to spec which ones) from fstatat
>> is awkward. /proc/pid is a directory. In what other context does the
>> kernel ask userspace to use a directory this way?
>
> I'm not sure you understood my proposal. I said that we need an
> interface to do this, and I was trying to explain (by noting what the
> current way of doing it would be) what I think the interface should be.

In what way is inotify *better* than a waitable FD? It's worse in a lot of ways:

1) inotify's presence is optional
2) inotify requires a lot of code to set up and use
3) inotify events fire at the wrong time, because they're tied to
/proc filesystem entries and not to underlying process state
4) inotify can't provide process exit status information, even in
principle, because inotify_event isn't big enough

I don't understand _why_ you want to use this worse interface instead
of a conventional blocking interface that works like eventfd and that
integrates into every event processing library out there without any
special tricks. What's so bad about a blocking read() model that
justifies the use of some kind of monitoring API?

>> > I'm really not a huge fan of the "blocking read" semantic (though if we
>> > have to have it, can we at least provide as much information as you get
>> > from proc_connector -- such as the exit status?).
>> [...]
>> The exit status in /proc/pid/stat is zeroed out for readers that fail
>> do_task_stat's ptrace_may_access call. (Falsifying the exit status in
>> stat seems a privilege check fails seems like a bad idea from a
>> correctness POV.)
>
> It's not clear to me what the purpose of that field is within procfs for
> *dead* proceses -- which is what we're discussing here. As far as I can
> tell, you will get an ESRCH when you try to read it. When testing this
> it also looked like you didn't even get the exit_status as a zombie but
> I might be mistaken.

exit_status becomes nonzero on transition to either a zombie or a
fully dead process.

> So while it is masked for !ptrace_may_access, it's also zero (or
> unreadable) for almost every case outside of stopped processes (AFAICS).
> Am I missing something?

The exit field is /proc/pid/stat is largely useless for exactly this
reason, but that's not my point.

My point is that nobody's ever made it clear who should have access to
a process's exit status. A process's exit status might communicate
privileged information, after all.

Should a process's parent be able to learn its child's exit status?
Certainly. Should a fully privileged unconstrained root be able to
learn any process's exit status? Certainly. Should a different process
be able to learn the exit status of an unrelated process running under
the same user? I think so, but I suspect the YAMA people might
disagree. Should "nobody" be able to learn the exit status of a
process running as root? Eh, maybe? *My* preference is that we just
declare the exit status public information, like comm, but that may
not be feasible.

But we don't need to figure out who should be able to learn a
process's exit status to add an API that blocks and waits for a
process to exit. That's why my initial patch doesn't provide exit
status. What I want to do is this:

1) provide a non-status-providing /proc/pid/exithand now
2) when we figure out who should have access to exit status
information, provide a /proc/pid/exithand_full whose read() returns a
siginfo_t with exit information

Having both /proc/pid/exithand and /proc/pid/exithand_full is useful
because we can make the former available to more processes than the
latter.

If everyone is comfortable with process exit status being globally
visible (as it apparently is on FreeBSD --- see below), then let's
skip #1 above and just have exithand's read() unconditionally return a
siginfo_t.

>> Should open() on exithand perform the same ptrace_may_access privilege
>> check? What if the process *becomes* untraceable during its lifetime
>> (e.g., with setuid). Should that read() on the exithand FD still yield
>> a siginfo_t? Just having exithand yield EOF all the time punts the
>> privilege problem to a later discussion because this approach doesn't
>> leak information. We can always add an "exithand_full" or something
>> that actually yields a siginfo_t.
>
> I agree that read(2) makes this hard. I don't think we should use it.

It's not the use of read that makes this hard. It's that nobody's
figured out what the right access model should be. The same problem
arises if you want to make process_connector unprivileged. And your
inotify proposal sidesteps the problem because it doesn't provide exit
status either.

> But if we have to use it, I would like us to have feature parity with
> features that FreeBSD had 18 years ago.

And I want parity with a feature Windows NT had in 1989: opening a
process and blocking until it exits. It shouldn't be hard to code, it
shouldn't require optional kernel features, and it shouldn't require
exotic wait operations.

>> Another option would be to make exithand's read() always yield a
>> siginfo_t, but have the open() just fail if the caller couldn't
>> ptrace_may_access it. But why shouldn't you be able to wait on other
>> processes? If you can see it in /proc, you should be able to wait on
>> it exiting.
>
> I would suggest looking at FreeBSD's kevent semantics for inspiration
> (or at least to see an alternative way of doing things). In particular,
> EVFILT_PROC+NOTE_EXIT -- which is attached to a particular process. I
> wonder what their view is on these sorts of questions.

What does FreeBSD do about privileged exit status communicated with
NOTE_EXIT? The FreeBSD 11 man page for kqueue states that "If a
process can normally see another process, it can attach an event to
it.". Does this mean that a process running as "nobody" can
EVFILT_PROC a process running as root and learn its exit status? If
so, that's an argument, I think, for just making exit status public
knowledge.
