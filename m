Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F41C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865F420823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865F420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJ3TcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:32:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ3TcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:32:12 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gHRQY-00029J-OC
        for linux-kernel@vger.kernel.org; Tue, 30 Oct 2018 10:39:14 +0000
Received: by mail-wm1-f72.google.com with SMTP id f3-v6so10307936wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMloEJ4IOd5zMN0uJTTwU/2/NtQw8oPjx/2S8AD6kPo=;
        b=YcKNm349uMKGMYf815caO6rrE7Xpt445TRg7q2LfmVcy5g9vm0C8bOT8XnY+1lxGSa
         nvWD29xwtxdEnSwn29Onktf8C53OxXhyOhnvfGw5H+nSNmY5kfuyGXSD4t/P1goguMjG
         hm4WpHiaZ4RtiV/ByKRv297jLKIk2cTqt8D9D1aHmaK1s8dcRipJqUbvPKUcQQh2X2Zc
         zs6V99JRHe40mgNNDRi1OQ41etb4y36+6eCK6U9wLr3l6xXZ2Fd0luXEEqtjTNZwkxCT
         vdMpuud+7/vor9tyNHINlaLDgD+WReJEkNqGtlgYfWtVjszm91QXGnkZ+4co95bYlXOX
         sZ1Q==
X-Gm-Message-State: AGRZ1gK++OH75iE6NawiqI90bjfl/j7Fk1EgPkh48IAK4I8rWjJtxlIq
        +9HzF0gxmxDN20ZVBjJ9v+svaqRPaWLyqxTvRRZMhUR9mMYMxlH+ewzIUzHk9Dqeo9iPp82UEt2
        vaUw5rxP6T2hsDQUjXEMeuz6CEmirEujrsYwYGHl3NQ==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr5451122wrv.113.1540895954120;
        Tue, 30 Oct 2018 03:39:14 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dQ+jEi0BWd4k3FIEiKiRiz5Jw27aLZ+8aY3vKsQWG5a8mAUq5IE2vWmeCUJhPpDS2GT8bldQ==
X-Received: by 2002:a5d:5685:: with SMTP id f5-v6mr5451089wrv.113.1540895953394;
        Tue, 30 Oct 2018 03:39:13 -0700 (PDT)
Received: from gmail.com ([2a02:8070:8895:9700:6d7a:7ba6:535c:106b])
        by smtp.gmail.com with ESMTPSA id 4-v6sm4736154wmg.21.2018.10.30.03.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:39:12 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Tue, 30 Oct 2018 11:39:11 +0100
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030103910.mnzot3zcoh6j7did@gmail.com>
References: <20181029221037.87724-1-dancol@google.com>
 <CAJWu+oquh1RXz+1tD91NzvicYAL3GP0KVi7RLR2cgouSgHXjOw@mail.gmail.com>
 <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueub941EHifyf7zEk_yvf=2P+HV-8esE1QPFypRoxtt1qQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:50:22AM +0000, Daniel Colascione wrote:
> On Tue, Oct 30, 2018 at 3:21 AM, Joel Fernandes <joelaf@google.com> wrote:
> > On Mon, Oct 29, 2018 at 3:11 PM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> Add a simple proc-based kill interface. To use /proc/pid/kill, just
> >> write the signal number in base-10 ASCII to the kill file of the
> >> process to be killed: for example, 'echo 9 > /proc/$$/kill'.
> >>
> >> Semantically, /proc/pid/kill works like kill(2), except that the
> >> process ID comes from the proc filesystem context instead of from an
> >> explicit system call parameter. This way, it's possible to avoid races
> >> between inspecting some aspect of a process and that process's PID
> >> being reused for some other process.
> >>
> >> With /proc/pid/kill, it's possible to write a proper race-free and
> >> safe pkill(1). An approximation follows. A real program might use
> >> openat(2), having opened a process's /proc/pid directory explicitly,
> >> with the directory file descriptor serving as a sort of "process
> >> handle".
> >
> > How long does the 'inspection' procedure take? If its a short
> > duration, then is PID reuse really an issue, I mean the PIDs are not
> > reused until wrap around and the only reason this can be a problem is
> > if you have the wrap around while the 'inspecting some aspect'
> > procedure takes really long.
> 
> It's a race. Would you make similar statements about a similar fix for
> a race condition involving a mutex and a double-free just because the
> race didn't crash most of the time? The issue I'm trying to fix here
> is the same problem, one level higher up in the abstraction hierarchy.
> 
> > Also the proc fs is typically not the right place for this. Some
> > entries in proc are writeable, but those are for changing values of
> > kernel data structures. The title of man proc(5) is "proc - process
> > information pseudo-filesystem". So its "information" right?
> 
> Why should userspace care whether a particular operation is "changing
> [a] value[] of [a] kernel data structure" or something else? That
> something in /proc is a struct field is an implementation detail. It's
> the interface semantics that matters, and whether a particular
> operation is achieved by changing a struct field or by making a
> function call is irrelevant to userspace. Proc is a filesystem about
> processes. Why shouldn't you be able to send a signal to a process via
> proc? It's an operation involving processes.
> 
> It's already possible to do things *to* processes via proc, e.g.,
> adjust OOM killer scores. Proc filesystem file descriptors are
> userspace references to kernel-side struct pid instances, and as such,
> make good process handles. There are already "verb" files in procfs,
> such as /proc/sys/vm/drop_caches and /proc/sysrq-trigger. Why not add
> a kill "verb", especially if it closes a race that can't be closed
> some other way?
> 
> You could implement this interface as a system call that took a procfs
> directory file descriptor, but relative to this proposal, it would be
> all downside. Such a thing would act just the same way as
> /pric/pid/kill, and wouldn't be usable from the shell or from programs
> that didn't want to use syscall(2). (Since glibc isn't adding new
> system call wrappers.) AFAIK, the only downside of having a "kill"
> file is the need for a string-to-integer conversion, but compared to
> process killing, integer parsing is insignificant.
> 
> > IMO without a really good reason for this, it could really be a hard
> > sell but the RFC was worth it anyway to discuss it ;-)
> 
> The traditional unix process API is down there at level -10 of Rusty
> Russel's old bad API scale: "It's impossible to get right". The races
> in the current API are unavoidable. That most programs don't hit these
> races most of the time doesn't mean that the race isn't present.
> 
> We've moved to a model where we identify other system resources, like
> DRM fences, locks, sockets, and everything else via file descriptors.
> This change is a step toward using procfs file descriptors to work
> with processes, which makes the system more regular and easier to
> reason about. A clean API that's possible to use correctly is a
> worthwhile project.

So I have been disucssing a new process API With David Howells, Kees
Cook and a few others and I am working on an RFC/proposal for this. It
is partially inspired by the new mount API. So I would like to block
this patch until then. I would like to get this right very much and I
don't think this is the way to go. I hope to have a more detailed
proposal out soon(ish). David and I were also thinking about an adhoc
session at the kernel summit but we aren't clear whether there's still a
slot.
