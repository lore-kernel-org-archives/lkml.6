Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ7aDH2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC0720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeKATCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:02:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40374 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeKATCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:02:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id n7so4855216uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Q3GFHtJAa/QXVlB3GzYdkGdrgx31+hcp7sDivvzWCE=;
        b=uQ7aDH2CFGSAgm7tBLYl69NkB8RKpueB0jOzc3Trh9wvq8J6O/NsodDUmGvgyH2dM0
         lig8YZwbo4AgPbG6RVV2WAa4+cGAf6U/Oc/mURG4jmfPMt2MVWpQe9IIk/K43U+z5UP1
         I0mu+fvt9m/LGYMc6b2Bpq8ktg2mep+coxAuBVM98O0FXS2uyCDkaNR9vAhcA1L5P1mG
         WMSdR/Hf1Y+GkGUu9NR5Xlr3E+MZDoK3g8EZiUqNfha/jFa9otpx8yMUoWzxDY9AxEhz
         gVH6d/DnD0JZxFuQTn5JvaLNJenszwwTrNDH0rRTzRSaEexFwEZjPYTu/UDdz0cbHol3
         eBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Q3GFHtJAa/QXVlB3GzYdkGdrgx31+hcp7sDivvzWCE=;
        b=kF1ub0mONS71rcAx5F7zeTBA+2egK6n0wl+RgqIjtu356i7w4GMnIZrhKMuhN62RrP
         ZwczZkgljyLP2Th2ieR1bb/2I45HoQuzjsE9mzEw94UhL0NSIAUuuwewvp00IUyPjmDT
         qvKDP8PbzIp+wwc5/jJAVZ/Fg4ovyjJUKXdCcB6meQM3iFV0He8PKHcxtA96bSmuDFWQ
         KsKqJ+EMNDS4iXgkFpPiGWCF0VfgXE3c2DVi6g+ybQUGwWCLFxoO4z75ju8ObCeMa01/
         6si1oRB8DI15UUDtzmBTRpSjYFm+AyiQidRWCyngtmEMrGSTCzLCQrM8zRpa9+YXG7te
         L9CQ==
X-Gm-Message-State: AGRZ1gKkfLJOD8wxLFhKh3JkUkmiZ/kq7b/1/yu+avlVS/kvvrGJE+mo
        zp24eMQFXOUKl35+gWKYqXKoJl2v4xOFDZNqXfHqcw==
X-Google-Smtp-Source: AJdET5eji9QyckyUdg+21ynm19pd95f7J7yEoVqXG82oZxNoUgWUl7oZHnpzqyIHaZIm2iHCsM6R//jQft03cwcWL1Y=
X-Received: by 2002:ab0:648b:: with SMTP id p11mr3204279uam.128.1541066382633;
 Thu, 01 Nov 2018 02:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 02:59:40 -0700 (PDT)
In-Reply-To: <20181101070036.l24c2p432ohuwmqf@yavin>
References: <20181029175322.189042-1-dancol@google.com> <20181029192250.130551-1-dancol@google.com>
 <20181101070036.l24c2p432ohuwmqf@yavin>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 1 Nov 2018 09:59:40 +0000
Message-ID: <CAKOZueszfoSM0pxhmuFLOuPmJqSfYXxgutstyCgqxAyoUi4h3w@mail.gmail.com>
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

On Thu, Nov 1, 2018 at 7:00 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-10-29, Daniel Colascione <dancol@google.com> wrote:
>> This patch adds a new file under /proc/pid, /proc/pid/exithand.
>> Attempting to read from an exithand file will block until the
>> corresponding process exits, at which point the read will successfully
>> complete with EOF.  The file descriptor supports both blocking
>> operations and poll(2). It's intended to be a minimal interface for
>> allowing a program to wait for the exit of a process that is not one
>> of its children.
>>
>> Why might we want this interface? Android's lmkd kills processes in
>> order to free memory in response to various memory pressure
>> signals. It's desirable to wait until a killed process actually exits
>> before moving on (if needed) to killing the next process. Since the
>> processes that lmkd kills are not lmkd's children, lmkd currently
>> lacks a way to wait for a process to actually die after being sent
>> SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>> entry. This interface allow lmkd to give up polling and instead block
>> and wait for process death.
>
> I agree with the need for this interface (with a few caveats), but there
> are a few points I'd like to make:
>
>  * I don't think that making a new procfile is necessary. When you open
>    /proc/$pid you already have a handle for the underlying process, and
>    you can already poll to check whether the process has died (fstatat
>    fails for instance). What if we just used an inotify event to tell
>    userspace that the process has died -- to avoid userspace doing a
>    poll loop?

I'm trying to make a simple interface. The basic unix data access
model is that a userspace application wants information (e.g., next
bunch of bytes in a file, next packet from a socket, next signal from
a signal FD, etc.), and tells the kernel so by making a system call on
a file descriptor. Ordinarily, the kernel returns to userspace with
the requested information when it's available, potentially after
blocking until the information is available. Sometimes userspace
doesn't want to block, so it adds O_NONBLOCK to the open file mode,
and in this mode, the kernel can tell the userspace requestor "try
again later", but the source of truth is still that
ordinarily-blocking system call. How does userspace know when to try
again in the "try again later" case? By using
select/poll/epoll/whatever, which suggests a good time for that "try
again later" retry, but is not dispositive about it, since that
ordinarily-blocking system call is still the sole source of truth, and
that poll is allowed to report spurious readabilty.

This model works fine and has a ton of mental and technical
infrastructure built around it.  It's the one the system uses for
almost every bit of information useful to an application. I feel very
strongly that process exit should also adhere to this model. It's
consistent, robust, and simple to use. That's why I added a procfile
that adheres to this model. It lets processes deal with exits in
exactly the same way they do any other event, with bit of userspace
code that works with possibly-blocking file descriptors generally
(e.g. libevent) without special logic in any polling loop. The event
file I'm proposing is so ordinary, in fact, that it works from the
shell. Without some specific technical reason to do something
different, we shouldn't do something unusual.

Given that we *can*, cheaply, provide a clean and consistent API to
userspace, why would we instead want to inflict some exotic and
hard-to-use interface on userspace instead? Asking that userspace poll
on a directory file descriptor and, when poll returns, check by
looking for certain errors (we'd have to spec which ones) from fstatat
is awkward. /proc/pid is a directory. In what other context does the
kernel ask userspace to use a directory this way?

I don't want to get bogged down in a discussion of a thousand exotic
ways we could provide this feature when there's one clear approach
that works everywhere else and that we should just copy.

>  * There is a fairly old interface called the proc_connector which gives
>    you global fork+exec+exit events (similar to kevents from FreeBSD
>    though much less full-featured). I was working on some patches to
>    extend proc_connector so that it could be used inside containers as
>    well as unprivileged users. This would be another way we could
>    implement this.

Both netlink and the *notify APIs are intended for broad monitoring of
system activity, not for waiting for some specific event. They require
a substantial amount of setup code, and since both are event-streaming
APIs with buffers that can overflow, both need some logic for
userspace to detect buffer overrun and fall back to explicit scanning
if that happens. They're also optional part of the kernel, and as you
note, there's a lot of work needed before either is usable with /proc,
most of that work being unrelated to the race-free process management
operations I'd like to support. We don't need work on either to fix
these longstanding problems with the process API.

Ideally it wouldn't require /proc at all, but /proc is how we ask
about non-child processes generally, so we're stuck with it.

> I'm really not a huge fan of the "blocking read" semantic (though if we
> have to have it, can we at least provide as much information as you get
> from proc_connector -- such as the exit status?).

That a process *exists* is one bit of information. You can get it
today by hammering /proc, so the current exithand patch doesn't leak
information.

You're asking for the kernel to communicate additional information to
userspace when a process dies. Who should have access to that
information? If the answer is "everyone", then yes, we can just have
the read() yield a siginfo_t, just like for waitid. That's simple and
useful. But if the answer is "some users", then who? The exit status
in /proc/pid/stat is zeroed out for readers that fail do_task_stat's
ptrace_may_access call. (Falsifying the exit status in stat seems a
privilege check fails seems like a bad idea from a correctness POV.)
Should open() on exithand perform the same ptrace_may_access privilege
check? What if the process *becomes* untraceable during its lifetime
(e.g., with setuid). Should that read() on the exithand FD still yield
a siginfo_t? Just having exithand yield EOF all the time punts the
privilege problem to a later discussion because this approach doesn't
leak information. We can always add an "exithand_full" or something
that actually yields a siginfo_t.

Another option would be to make exithand's read() always yield a
siginfo_t, but have the open() just fail if the caller couldn't
ptrace_may_access it. But why shouldn't you be able to wait on other
processes? If you can see it in /proc, you should be able to wait on
it exiting.

> Also maybe we should
> integrate this into the exit machinery instead of this loop...

I don't know what you mean. It's already integrated into the exit
machinery: it's what runs the waitqueue.
