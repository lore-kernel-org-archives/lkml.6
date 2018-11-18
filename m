Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCF520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhckfhPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCF520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeKSEtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbeKSEtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:49:22 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5409E2089F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542565702;
        bh=Vwss4soWhguhGo9DAqnWYTzn8piXNCMnRF+M5eFiLJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rhckfhPFIMVeCxeCNnU+AELALIvXCNhF1b7EiE4qF0mX1isIrlHzuZsglGfpy9gxK
         jzRdLb0yTfPbcuVnqx0cwQMZcqnEAAwdCoBS+npQk295A+OYbdl59RMjm5vRQcETXd
         cp9Fv9Q8U6z3wjSDaSwd4gstu1QBvZA+N9PeDW0s=
Received: by mail-wm1-f52.google.com with SMTP id w7-v6so3166256wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:28:22 -0800 (PST)
X-Gm-Message-State: AA+aEWZduyrD+BX4e481dOictpjZhJNdPd6+CXqrSDOlKSc0DZEpUja5
        WJ5S4PbpHrKq+cdlFDLJt52wfvtZuNHMttGht7KSPQ==
X-Google-Smtp-Source: AJdET5e2Z939jyXs5eQu5ctb5YRlAzV4EceFr4zHcE22rvqO684TRmvdYU91MJc/dgpM93l5GEoZMVZH5NMOIcZGdMA=
X-Received: by 2002:a1c:110b:: with SMTP id 11mr2052879wmr.83.1542565700692;
 Sun, 18 Nov 2018 10:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com> <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
In-Reply-To: <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 10:28:08 -0800
X-Gmail-Original-Message-ID: <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
Message-ID: <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
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

On Sun, Nov 18, 2018 at 9:51 AM Daniel Colascione <dancol@google.com> wrote:
>
> > I'm not entirely sure that ship has sailed.  In the kernel, we already
> > have a bit of a distinction between a pid (and tid, etc -- I'm
> > referring to struct pid) and a task.  If we make a new
> > process-management API, we could put a distinction like this into the
> > API.
>
> It would be a disaster to have different APIs give callers a different
> idea of process identity over its lifetime. The precedent is
> well-established that execve and setreuid do not change a process's
> identity. Invaliding some identifiers but not others in response to
> supposedly-internal things a process might do under rare circumstances
> is creating a bug machine..

Here's my point: if we're really going to make a new API to manipulate
processes by their fd, I think we should have at least a decent idea
of how that API will get extended in the future.  Right now, we have
an extremely awkward situation where opening an fd in /proc requires
certain capabilities or uids, and using those fds often also checks
current's capabilities, and the target process may have changed its
own security context, including gaining privilege via SUID, SGID, or
LSM transition rules in the mean time.  This has been a huge source of
security bugs.  It would be nice to have a model for future APIs that
avoids these problems.

And I didn't say in my proposal that a process's identity should
fundamentally change when it calls execve().  I'm suggesting that
certain operations that could cause a process to gain privilege or
otherwise require greater permission to introspect (mainly execve)
could be handled by invalidating the new process management fds.
Sure, if init re-execs itself, it's still PID 1, but that doesn't
necessarily mean that:

fd = process_open_management_fd(1);
[init reexecs]
process_do_something(fd);

needs to work.

>
> > setresuid() has no effect
> > here -- if you have W access to the process and the process calls
> > setresuid(), you still have W access.
>
> Now you've created a situation in which an operation that security
> policy previously blocked now becomes possible, invaliding previous
> designs based on the old security invariant. That's the definition of
> introducing a security hole.

I think you're overstating your case.  To a pretty good approximation,
setresuid() allows the caller to remove elements from the set {ruid,
suid, euid}, unless the caller has CAP_SETUID.  If you could ptrace a
process before it calls setresuid(), you might as well be able to
ptrace() it after, since you could have just ptraced it and made it
call setresuid() while still ptracing it.  Similarly, it seems like
it's probably safe to be able to open an fd that lets you watch the
exit status of a process, have the process call setresuid(), and still
see the exit status.

Regardless of how you feel about these issues, if you're going to add
an API by which you open an fd, wait for a process to exit, and read
the exit status, you need to define the conditions under which you may
open the fd and under which you may read the exit status once you have
the fd.  There are probably multiple valid answers, but the question
still needs to be answered.  My POLLERR hack, aside from being ugly,
avoids this particular issue because it merely lets you wait for
something you already could have observed using readdir().
