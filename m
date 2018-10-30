Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E5CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BE62082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BE62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJ3UNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:13:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48730 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeJ3UNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:13:11 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gHS47-0004UI-3v
        for linux-kernel@vger.kernel.org; Tue, 30 Oct 2018 11:20:07 +0000
Received: by mail-vs1-f71.google.com with SMTP id g13so541157vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sDuTsLiLT/HmT1tPv3oURZ2+zCFjuPhDiGlUQbk+nU=;
        b=KV4jW3qJAgRDRsv9nUCRWMYquRDh+ceefvD5nXJm+GMowl3fefsJEaZX77jJ1MbUiR
         oobMOH5HZ91tipF+PbGcAuTssJrgj40qEu8wagbejFVGMYVbpPnLS7UBuXL7AA6/elHq
         zR2eVcne+S+jUJrMrmbpdyOS76/B5os2nrWq9Vx1d1VJaYIucMxPprGFhoD0D0qkGJ94
         zzaSCmWwdhqjPb/s77sj0X6Of7jlEIHmMFWCML/9O/fKCfG/d3JeMk6k2MM+3IhEbr+T
         c/W/SexPEbmwtF2j3e39tK6pmm6n3UCh9F/P4Ev9HP7a2+qU6q4/Fi+SF8+YhehzE3xH
         xz1Q==
X-Gm-Message-State: AGRZ1gJpU7I6kHd+gfL0ny487bTOWdxgy85CIIe+2pJ/3lR9Fe+Nz/f0
        DTzOLXi0qln1xW5HycVMfCxWfCfILNX/otPffKfcRdmZiy6eS5Tix+B/ZAPRu5OcNciVUkrOwun
        KkMvdwctVgioiXzLFJslPO/SPfZDXtCFvOEoP5VcpVbErvo5P/XbG/KaLxA==
X-Received: by 2002:a67:f085:: with SMTP id i5mr2896673vsl.198.1540898402932;
        Tue, 30 Oct 2018 04:20:02 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dJlNElf1nzKQZUoUb0LqGsPZN9PbqGmMV9/Eu4AcfQMtkItLLZmZDgbi1ORnYzs9U69j/dCg9gV6oD9DE+ucA=
X-Received: by 2002:a67:f085:: with SMTP id i5mr2896660vsl.198.1540898402349;
 Tue, 30 Oct 2018 04:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com> <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
 <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
 <20181030103910.mnzot3zcoh6j7did@gmail.com> <20181030104037.73t5uz3piywxwmye@gmail.com>
 <CAKOZuesb4ns1dM7itX9uzvYBGp_aSgQXV1ONuV4eQRq0FiehYQ@mail.gmail.com>
 <CAPP7u0VE-4c10A7A+WO+rMFbNF42CROP7+xGttzU_3HWQk883Q@mail.gmail.com> <CAKOZueswuOTvkOeuipRwg5VCYGvpf=8j1ChJftAk_fJO6xPPtQ@mail.gmail.com>
In-Reply-To: <CAKOZueswuOTvkOeuipRwg5VCYGvpf=8j1ChJftAk_fJO6xPPtQ@mail.gmail.com>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Tue, 30 Oct 2018 12:19:51 +0100
Message-ID: <CAPP7u0X-FRgS0kGcL7dMEGzLys54UkXU3+drX76=NmMbCOLsxg@mail.gmail.com>
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

On Tue, Oct 30, 2018 at 12:12 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Tue, Oct 30, 2018 at 11:04 AM, Christian Brauner
> <christian.brauner@canonical.com> wrote:
> > On Tue, Oct 30, 2018 at 11:48 AM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> On Tue, Oct 30, 2018 at 10:40 AM, Christian Brauner
> >> <christian.brauner@canonical.com> wrote:
> >> > On Tue, Oct 30, 2018 at 11:39:11AM +0100, Christian Brauner wrote:
> >> >> On Tue, Oct 30, 2018 at 08:50:22AM +0000, Daniel Colascione wrote:
> >> >> > On Tue, Oct 30, 2018 at 3:21 AM, Joel Fernandes <joelaf@google.com> wrote:
> >> >> > > On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
> >> >> > >>
> >> >> > >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> >> >> > >> write the signal number in base-10 ASCII to the kill file of the
> >> >> > >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> >> >> > >>
> >> >> > >> Semantically, /proc/pid/kill works like kill(2), except that the
> >> >> > >> process ID comes from the proc filesystem context instead of from an
> >> >> > >> explicit system call parameter. This way, it's possible to avoid races
> >> >> > >> between inspecting some aspect of a process and that process's PID
> >> >> > >> being reused for some other process.
> >> >> > >>
> >> >> > >> With /proc/pid/kill, it's possible to write a proper race-free and
> >> >> > >> safe pkill(1). An approximation follows. A real program might use
> >> >> > >> openat(2), having opened a process's /proc/pid directory explicitly,
> >> >> > >> with the directory file descriptor serving as a sort of "process
> >> >> > >> handle".
> >> >> > >
> >> >> > > How long does the 'inspection' procedure take? If its a short
> >> >> > > duration, then is PID reuse really an issue, I mean the PIDs are not
> >> >> > > reused until wrap around and the only reason this can be a problem is
> >> >> > > if you have the wrap around while the 'inspecting some aspect'
> >> >> > > procedure takes really long.
> >> >> >
> >> >> > It's a race. Would you make similar statements about a similar fix for
> >> >> > a race condition involving a mutex and a double-free just because the
> >> >> > race didn't crash most of the time? The issue I'm trying to fix here
> >> >> > is the same problem, one level higher up in the abstraction hierarchy.
> >> >> >
> >> >> > > Also the proc fs is typically not the right place for this. Some
> >> >> > > entries in proc are writeable, but those are for changing values of
> >> >> > > kernel data structures. The title of man proc(5) is "proc - process
> >> >> > > information pseudo-filesystem". So its "information" right?
> >> >> >
> >> >> > Why should userspace care whether a particular operation is "changing
> >> >> > [a] value[] of [a] kernel data structure" or something else? That
> >> >> > something in /proc is a struct field is an implementation detail. It's
> >> >> > the interface semantics that matters, and whether a particular
> >> >> > operation is achieved by changing a struct field or by making a
> >> >> > function call is irrelevant to userspace. Proc is a filesystem about
> >> >> > processes. Why shouldn't you be able to send a signal to a process via
> >> >> > proc? It's an operation involving processes.
> >> >> >
> >> >> > It's already possible to do things *to* processes via proc, e.g.,
> >> >> > adjust OOM killer scores. Proc filesystem file descriptors are
> >> >> > userspace references to kernel-side struct pid instances, and as such,
> >> >> > make good process handles. There are already "verb" files in procfs,
> >> >> > such as /proc/sys/vm/drop_caches and /proc/sysrq-trigger. Why not add
> >> >> > a kill "verb", especially if it closes a race that can't be closed
> >> >> > some other way?
> >> >> >
> >> >> > You could implement this interface as a system call that took a procfs
> >> >> > directory file descriptor, but relative to this proposal, it would be
> >> >> > all downside. Such a thing would act just the same way as
> >> >> > /pric/pid/kill, and wouldn't be usable from the shell or from programs
> >> >> > that didn't want to use syscall(2). (Since glibc isn't adding new
> >> >> > system call wrappers.) AFAIK, the only downside of having a "kill"
> >> >> > file is the need for a string-to-integer conversion, but compared to
> >> >> > process killing, integer parsing is insignificant.
> >> >> >
> >> >> > > IMO without a really good reason for this, it could really be a hard
> >> >> > > sell but the RFC was worth it anyway to discuss it ;-)
> >> >> >
> >> >> > The traditional unix process API is down there at level -10 of Rusty
> >> >> > Russel's old bad API scale: "It's impossible to get right". The races
> >> >> > in the current API are unavoidable. That most programs don't hit these
> >> >> > races most of the time doesn't mean that the race isn't present.
> >> >> >
> >> >> > We've moved to a model where we identify other system resources, like
> >> >> > DRM fences, locks, sockets, and everything else via file descriptors.
> >> >> > This change is a step toward using procfs file descriptors to work
> >> >> > with processes, which makes the system more regular and easier to
> >> >> > reason about. A clean API that's possible to use correctly is a
> >> >> > worthwhile project.
> >> >>
> >> >> So I have been disucssing a new process API With David Howells, Kees
> >> >> Cook and a few others and I am working on an RFC/proposal for this. It
> >> >> is partially inspired by the new mount API. So I would like to block
> >> >> this patch until then. I would like to get this right very much and
> >>
> >> It's good to hear that others are thinking about this problem.
> >>
> >> >> I
> >> >> don't think this is the way to go.
> >
> > Because we want this to be generic and things like getting handles on
> > processes via /proc is just a part of that
>
> The word "generic" is like the word "secure": it's hard to tell what

Ha, trolling hard but true. :)

> it means in isolation. :-) Over what domain do we need to be generic?
> Procfs file descriptors already work on processes generally, and they
> allow for race-free access to anything that's reachable via a procfs
> pid directory. In what way would an alternate approach be even more
> generic?
>
> >> Why not?
> >>
> >> Does your proposed API allow for a race-free pkill, with arbitrary
> >> selection criteria? This capability is a good litmus test for fixing
> >> the long-standing Unix process API issues.
> >
> > You'd have a handle on the process with an fd so yes, it would be.
>
> Thanks. That's good to hear.
>
> Any idea on the timetable for this proposal? I'm open to lots of
> alternative technical approaches, but I don't want this capability to
> languish for a long time.

Latest end of year likely sooner depending on the feedback I'm getting
during LPC.
