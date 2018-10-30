Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C37C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5220823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbNFZ/bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJ3Tlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:41:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40309 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeJ3Tlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:41:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id s9so6936549vsk.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tLoX9lWR78Alw2tj+4jNhQyjvygMILgRJVtMbnvQl24=;
        b=lbNFZ/buM5y2rerBvQQTg3w6dcmFsqXFnHgjjywPktRQoIaNTf2LYKK5eDIpp5+Ruf
         NEHiKyjh0W5Y4aNBD0xcR51AVcT86tdYiuyGfajeFiQBMX2BOk9L/nILegNdFVdNQFny
         vzueydSv9JA80wN+OGik8IIws8XSdagsaD0vTAFgkclTdNHP6fjy3CDnOGH2Xti1WBxT
         43uQkyoGghKIDfyyzzHg363bO04DBPZrJIQx7u5Gkk0EnYdNHwHbJ1jhrH1gREroVJwl
         6BsN/ly0RQoN9JFye7eCA5UtNhSlKBbZa62NLFSWhoiHNeF2XH4F9VzRABTg7JO7+D1y
         dSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tLoX9lWR78Alw2tj+4jNhQyjvygMILgRJVtMbnvQl24=;
        b=uDJUDDlvavbAjHk9nIcdmypvdgUjwpELWkfMc5x1tg8Nt0+n/otR33l9qKsXVROQAN
         BQYZstUxivREoOFMB5nuYEtTx1Zp59tSnr1XpXleycvfSCF3MPx7K3/pAQQDbE4La/C0
         2onkvF49IdDf0Gv+EvPZfKW3xR+w2sEAPtKbWjZutKkRWYosARGMJY1PfZ/m6RMFHczo
         YoJ/x+iXQRxXhiRGW3pOQSfcv2vlkGJZc3w2U21d0Rqo1SbChCA5h7tExe0zpwvsMJuE
         8xwcoQeXRMknlrIK3HZipycXDm1cdPv683zUGEMmBAJ37+V03/d0jovPggx9Z+8lsLHA
         WUtQ==
X-Gm-Message-State: AGRZ1gJSJBVyi/4jMIxEpb1tR+UhiR+mT3PvOhA1FUrSnlnZlY2sNMKB
        uLS5df+esRg7PRFYXALb6xGhbOjcQmJMTZT3RvrBnA==
X-Google-Smtp-Source: AJdET5duM+6c6LHrbDxJ88d+dH1YoIRh6uIDIUJqaaVqj3Pw95HA3keslfV6nsFQZ3c5BZVMaEVZejhniYiiKWkBSgk=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr2673374vsc.171.1540896532356;
 Tue, 30 Oct 2018 03:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 03:48:51
 -0700 (PDT)
In-Reply-To: <20181030104037.73t5uz3piywxwmye@gmail.com>
References: <20181029221037.87724-1-dancol@google.com> <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
 <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
 <20181030103910.mnzot3zcoh6j7did@gmail.com> <20181030104037.73t5uz3piywxwmye@gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 30 Oct 2018 10:48:51 +0000
Message-ID: <CAKOZuesb4ns1dM7itX9uzvYBGp_aSgQXV1ONuV4eQRq0FiehYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:40 AM, Christian Brauner
<christian.brauner@canonical.com> wrote:
> On Tue, Oct 30, 2018 at 11:39:11AM +0100, Christian Brauner wrote:
>> On Tue, Oct 30, 2018 at 08:50:22AM +0000, Daniel Colascione wrote:
>> > On Tue, Oct 30, 2018 at 3:21 AM, Joel Fernandes <joelaf@google.com> wrote:
>> > > On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
>> > >>
>> > >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
>> > >> write the signal number in base-10 ASCII to the kill file of the
>> > >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
>> > >>
>> > >> Semantically, /proc/pid/kill works like kill(2), except that the
>> > >> process ID comes from the proc filesystem context instead of from an
>> > >> explicit system call parameter. This way, it's possible to avoid races
>> > >> between inspecting some aspect of a process and that process's PID
>> > >> being reused for some other process.
>> > >>
>> > >> With /proc/pid/kill, it's possible to write a proper race-free and
>> > >> safe pkill(1). An approximation follows. A real program might use
>> > >> openat(2), having opened a process's /proc/pid directory explicitly,
>> > >> with the directory file descriptor serving as a sort of "process
>> > >> handle".
>> > >
>> > > How long does the 'inspection' procedure take? If its a short
>> > > duration, then is PID reuse really an issue, I mean the PIDs are not
>> > > reused until wrap around and the only reason this can be a problem is
>> > > if you have the wrap around while the 'inspecting some aspect'
>> > > procedure takes really long.
>> >
>> > It's a race. Would you make similar statements about a similar fix for
>> > a race condition involving a mutex and a double-free just because the
>> > race didn't crash most of the time? The issue I'm trying to fix here
>> > is the same problem, one level higher up in the abstraction hierarchy.
>> >
>> > > Also the proc fs is typically not the right place for this. Some
>> > > entries in proc are writeable, but those are for changing values of
>> > > kernel data structures. The title of man proc(5) is "proc - process
>> > > information pseudo-filesystem". So its "information" right?
>> >
>> > Why should userspace care whether a particular operation is "changing
>> > [a] value[] of [a] kernel data structure" or something else? That
>> > something in /proc is a struct field is an implementation detail. It's
>> > the interface semantics that matters, and whether a particular
>> > operation is achieved by changing a struct field or by making a
>> > function call is irrelevant to userspace. Proc is a filesystem about
>> > processes. Why shouldn't you be able to send a signal to a process via
>> > proc? It's an operation involving processes.
>> >
>> > It's already possible to do things *to* processes via proc, e.g.,
>> > adjust OOM killer scores. Proc filesystem file descriptors are
>> > userspace references to kernel-side struct pid instances, and as such,
>> > make good process handles. There are already "verb" files in procfs,
>> > such as /proc/sys/vm/drop_caches and /proc/sysrq-trigger. Why not add
>> > a kill "verb", especially if it closes a race that can't be closed
>> > some other way?
>> >
>> > You could implement this interface as a system call that took a procfs
>> > directory file descriptor, but relative to this proposal, it would be
>> > all downside. Such a thing would act just the same way as
>> > /pric/pid/kill, and wouldn't be usable from the shell or from programs
>> > that didn't want to use syscall(2). (Since glibc isn't adding new
>> > system call wrappers.) AFAIK, the only downside of having a "kill"
>> > file is the need for a string-to-integer conversion, but compared to
>> > process killing, integer parsing is insignificant.
>> >
>> > > IMO without a really good reason for this, it could really be a hard
>> > > sell but the RFC was worth it anyway to discuss it ;-)
>> >
>> > The traditional unix process API is down there at level -10 of Rusty
>> > Russel's old bad API scale: "It's impossible to get right". The races
>> > in the current API are unavoidable. That most programs don't hit these
>> > races most of the time doesn't mean that the race isn't present.
>> >
>> > We've moved to a model where we identify other system resources, like
>> > DRM fences, locks, sockets, and everything else via file descriptors.
>> > This change is a step toward using procfs file descriptors to work
>> > with processes, which makes the system more regular and easier to
>> > reason about. A clean API that's possible to use correctly is a
>> > worthwhile project.
>>
>> So I have been disucssing a new process API With David Howells, Kees
>> Cook and a few others and I am working on an RFC/proposal for this. It
>> is partially inspired by the new mount API. So I would like to block
>> this patch until then. I would like to get this right very much and

It's good to hear that others are thinking about this problem.

>> I
>> don't think this is the way to go.

Why not?

Does your proposed API allow for a race-free pkill, with arbitrary
selection criteria? This capability is a good litmus test for fixing
the long-standing Unix process API issues.
