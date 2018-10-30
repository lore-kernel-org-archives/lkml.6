Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FDA20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FDA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ3T6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:58:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48492 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeJ3T6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:58:06 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gHRpX-0003al-ID
        for linux-kernel@vger.kernel.org; Tue, 30 Oct 2018 11:05:03 +0000
Received: by mail-vs1-f71.google.com with SMTP id z73so2935817vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xD8uEpiSIMs93mm0jrRvaJ5Pldce2QKveGyTBtfPY4=;
        b=KlFzy+ZhnyMsWEOM0usKnrcs26aynx/vTYX5i/7QcCeAi3FkcvDP0itk69UUMsnIYU
         i6QRcGmTDDpsmoFkz3yQpciiaf+C/T1RqJNWP7RaCoSPy9uq3jz4BageAqr/Att/yo1w
         sxv2Bme/xGfv8DOa02+N/THPlzCjKvczs1GZAYDOLUgV1QgXoS48/kMeZdDHulhKiysf
         CuVJBdtlcYl4wcOSBX1Nvflw4R2P3MdoMai367vx583YHYI5EAX/FO/KSZ08HLKg2Nky
         um1UWq+7VeCPU00LICnIHcorfG73zKvMTv20vOkErkQeGnS/hCDOwW1n/ar8x/jBy53L
         jWXA==
X-Gm-Message-State: AGRZ1gIJHgvlV+3WAHYtATtiQkMu3cPPs6OnpovXmK/tNj0CBtbe6E+D
        ECjnQ/4hJHcv/VaX5vXnqz4S0ViEhUICB80EZxDgkusp1HIt1p53Je/hUKGwzsC9vcm1tTlIXxS
        RIpMoIZ5kya/RrvQnU+pRAzy9QygvUNQbGrLGzf2Mo9dMUYVl9hkCg6wAwg==
X-Received: by 2002:a9f:308a:: with SMTP id j10mr8033116uab.28.1540897502235;
        Tue, 30 Oct 2018 04:05:02 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fgzYiO3d8edkqSKozAQ6pdIFVeXEV23t7jZOni/bNkUwmVfvnWZ206oqzir1EvlYPs1BpTrWqz1B5WZIPGI1Y=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr8033094uab.28.1540897501579;
 Tue, 30 Oct 2018 04:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com> <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
 <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
 <20181030103910.mnzot3zcoh6j7did@gmail.com> <20181030104037.73t5uz3piywxwmye@gmail.com>
 <CAKOZuesb4ns1dM7itX9uzvYBGp_aSgQXV1ONuV4eQRq0FiehYQ@mail.gmail.com>
In-Reply-To: <CAKOZuesb4ns1dM7itX9uzvYBGp_aSgQXV1ONuV4eQRq0FiehYQ@mail.gmail.com>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Tue, 30 Oct 2018 12:04:50 +0100
Message-ID: <CAPP7u0VE-4c10A7A+WO+rMFbNF42CROP7+xGttzU_3HWQk883Q@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:48 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Oct 30, 2018 at 10:40 AM, Christian Brauner
> <christian.brauner@canonical.com> wrote:
> > On Tue, Oct 30, 2018 at 11:39:11AM +0100, Christian Brauner wrote:
> >> On Tue, Oct 30, 2018 at 08:50:22AM +0000, Daniel Colascione wrote:
> >> > On Tue, Oct 30, 2018 at 3:21 AM, Joel Fernandes <joelaf@google.com> wrote:
> >> > > On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
> >> > >>
> >> > >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> >> > >> write the signal number in base-10 ASCII to the kill file of the
> >> > >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> >> > >>
> >> > >> Semantically, /proc/pid/kill works like kill(2), except that the
> >> > >> process ID comes from the proc filesystem context instead of from an
> >> > >> explicit system call parameter. This way, it's possible to avoid races
> >> > >> between inspecting some aspect of a process and that process's PID
> >> > >> being reused for some other process.
> >> > >>
> >> > >> With /proc/pid/kill, it's possible to write a proper race-free and
> >> > >> safe pkill(1). An approximation follows. A real program might use
> >> > >> openat(2), having opened a process's /proc/pid directory explicitly,
> >> > >> with the directory file descriptor serving as a sort of "process
> >> > >> handle".
> >> > >
> >> > > How long does the 'inspection' procedure take? If its a short
> >> > > duration, then is PID reuse really an issue, I mean the PIDs are not
> >> > > reused until wrap around and the only reason this can be a problem is
> >> > > if you have the wrap around while the 'inspecting some aspect'
> >> > > procedure takes really long.
> >> >
> >> > It's a race. Would you make similar statements about a similar fix for
> >> > a race condition involving a mutex and a double-free just because the
> >> > race didn't crash most of the time? The issue I'm trying to fix here
> >> > is the same problem, one level higher up in the abstraction hierarchy.
> >> >
> >> > > Also the proc fs is typically not the right place for this. Some
> >> > > entries in proc are writeable, but those are for changing values of
> >> > > kernel data structures. The title of man proc(5) is "proc - process
> >> > > information pseudo-filesystem". So its "information" right?
> >> >
> >> > Why should userspace care whether a particular operation is "changing
> >> > [a] value[] of [a] kernel data structure" or something else? That
> >> > something in /proc is a struct field is an implementation detail. It's
> >> > the interface semantics that matters, and whether a particular
> >> > operation is achieved by changing a struct field or by making a
> >> > function call is irrelevant to userspace. Proc is a filesystem about
> >> > processes. Why shouldn't you be able to send a signal to a process via
> >> > proc? It's an operation involving processes.
> >> >
> >> > It's already possible to do things *to* processes via proc, e.g.,
> >> > adjust OOM killer scores. Proc filesystem file descriptors are
> >> > userspace references to kernel-side struct pid instances, and as such,
> >> > make good process handles. There are already "verb" files in procfs,
> >> > such as /proc/sys/vm/drop_caches and /proc/sysrq-trigger. Why not add
> >> > a kill "verb", especially if it closes a race that can't be closed
> >> > some other way?
> >> >
> >> > You could implement this interface as a system call that took a procfs
> >> > directory file descriptor, but relative to this proposal, it would be
> >> > all downside. Such a thing would act just the same way as
> >> > /pric/pid/kill, and wouldn't be usable from the shell or from programs
> >> > that didn't want to use syscall(2). (Since glibc isn't adding new
> >> > system call wrappers.) AFAIK, the only downside of having a "kill"
> >> > file is the need for a string-to-integer conversion, but compared to
> >> > process killing, integer parsing is insignificant.
> >> >
> >> > > IMO without a really good reason for this, it could really be a hard
> >> > > sell but the RFC was worth it anyway to discuss it ;-)
> >> >
> >> > The traditional unix process API is down there at level -10 of Rusty
> >> > Russel's old bad API scale: "It's impossible to get right". The races
> >> > in the current API are unavoidable. That most programs don't hit these
> >> > races most of the time doesn't mean that the race isn't present.
> >> >
> >> > We've moved to a model where we identify other system resources, like
> >> > DRM fences, locks, sockets, and everything else via file descriptors.
> >> > This change is a step toward using procfs file descriptors to work
> >> > with processes, which makes the system more regular and easier to
> >> > reason about. A clean API that's possible to use correctly is a
> >> > worthwhile project.
> >>
> >> So I have been disucssing a new process API With David Howells, Kees
> >> Cook and a few others and I am working on an RFC/proposal for this. It
> >> is partially inspired by the new mount API. So I would like to block
> >> this patch until then. I would like to get this right very much and
>
> It's good to hear that others are thinking about this problem.
>
> >> I
> >> don't think this is the way to go.

Because we want this to be generic and things like getting handles on
processes via /proc is just a part of that.

>
> Why not?
>
> Does your proposed API allow for a race-free pkill, with arbitrary
> selection criteria? This capability is a good litmus test for fixing
> the long-standing Unix process API issues.

You'd have a handle on the process with an fd so yes, it would be.
