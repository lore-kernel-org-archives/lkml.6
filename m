Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27183C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22E92080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D45NGXHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22E92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeKSFE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:04:56 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36762 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeKSFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:04:55 -0500
Received: by mail-vk1-f193.google.com with SMTP id u62so6314439vkb.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z7jWucpNbcARGImXzn3CViVjGpMa7ko5qvrz96R9Lrc=;
        b=D45NGXHGV/gmLWEgZmR5gFIPiCE/iTb/IQDIIwM9Wjf2n3Q8X7quL0uxGakZYcQj5b
         418dIf8jwjcm2e55wB2ilJClX9dbUFM1KfXizPfALL4Nkb4ID9V67CXdBFNWFQSkLZmu
         aDRzBF//TWaMKDElx/eAetE7xpHNLyVdvcT4xqhDdF8iJrqZABfjkHmE2Xp7KnYUlJn9
         kYmxSFnNip04I2qHh6ow+aa76czNRQM5ubNQoBSfXJxyLmL+KbKLartxUFpz8eA8BpNs
         jPh2dU3pwjIRHgkdWd46OFw4rGight/TG1/Th3cP8njQAW84GTcQvRG6zS69/mMxGsbF
         jXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z7jWucpNbcARGImXzn3CViVjGpMa7ko5qvrz96R9Lrc=;
        b=PaVC6299nhEYvscD6w4J+sswtiCmU/nCWwvqvieGgrwHcjo0MnU6wpav1beZFYhFBG
         vKivFd2hLxWRTufBgpslGpMfiQR0y3ruHYTW3dFGHZNrlytej7jDXEARBnNeY/D6eQRl
         mPKlbzkSDzCp57dGI4qA9k3QfDLDrHVzEy0rnO+ZNy8bsDFkyMo2yhn1lKeInw+Ld/zE
         PJhze818ctxOAq9mBcjqJA6lvmmQ/sLSlJy9Iphd6IEmv8gi689VxaAjbqkkZGQKYRo3
         Yo8eurqBFfuSCViw220dCAdLWQ3ISWpYo6T+LmPa7qUX0CR2xgkjYH/vYPOeasEZUhQP
         PXvQ==
X-Gm-Message-State: AGRZ1gIRF6IcKFV8P6bFLkbwPDqUZnZns4ALlJs7AqkAadjpKZTozZMe
        j7yxNBtiPXowISjNkEO7ZHIZKuA9wlK2jilO9SNz1QEkjeg=
X-Google-Smtp-Source: AJdET5exLbXnI+FAgaDkkU7vBzG+3SkWjiOAC6nxtNG1/b594Fc8hSfsTzvMMo/c+X75PYgLvl4fOulEglAMtHnvZVo=
X-Received: by 2002:a1f:f203:: with SMTP id q3mr7793280vkh.54.1542566633586;
 Sun, 18 Nov 2018 10:43:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 10:43:52
 -0800 (PST)
In-Reply-To: <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com> <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 10:43:52 -0800
Message-ID: <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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

On Sun, Nov 18, 2018 at 10:28 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 9:51 AM Daniel Colascione <dancol@google.com> wrote:
>>
>> > I'm not entirely sure that ship has sailed.  In the kernel, we already
>> > have a bit of a distinction between a pid (and tid, etc -- I'm
>> > referring to struct pid) and a task.  If we make a new
>> > process-management API, we could put a distinction like this into the
>> > API.
>>
>> It would be a disaster to have different APIs give callers a different
>> idea of process identity over its lifetime. The precedent is
>> well-established that execve and setreuid do not change a process's
>> identity. Invaliding some identifiers but not others in response to
>> supposedly-internal things a process might do under rare circumstances
>> is creating a bug machine..
>
> Here's my point: if we're really going to make a new API to manipulate
> processes by their fd, I think we should have at least a decent idea
> of how that API will get extended in the future.  Right now, we have
> an extremely awkward situation where opening an fd in /proc requires
> certain capabilities or uids, and using those fds often also checks
> current's capabilities, and the target process may have changed its
> own security context, including gaining privilege via SUID, SGID, or
> LSM transition rules in the mean time.  This has been a huge source of
> security bugs.  It would be nice to have a model for future APIs that
> avoids these problems.
>
> And I didn't say in my proposal that a process's identity should
> fundamentally change when it calls execve().  I'm suggesting that
> certain operations that could cause a process to gain privilege or
> otherwise require greater permission to introspect (mainly execve)
> could be handled by invalidating the new process management fds.
> Sure, if init re-execs itself, it's still PID 1, but that doesn't
> necessarily mean that:
>
> fd = process_open_management_fd(1);
> [init reexecs]
> process_do_something(fd);
>
> needs to work.

PID 1 is a bad example here, because it doesn't get recycled. Other
PIDs do. The snippet you gave *does* need to work, in general, because
if exec invalidates the handle, and you need to reopen by PID to
re-establish your right to do something with the process, that process
may in fact have died between the invalidation and your reopen, and
your reopened FD may refer to some other random process.

The only way around this problem is to have two separate FDs --- one
to represent process identity, which *must* be continuous across
execve, and the other to represent some specific capability, some
ability to do something to that process. It's reasonable to invalidate
capability after execve, but it's not reasonable to invalidate
identity. In concrete terms, I don't see a big advantage to this
separation, and I think a single identity FD combined with
per-operation capability checks is sufficient. And much simpler.

>> > setresuid() has no effect
>> > here -- if you have W access to the process and the process calls
>> > setresuid(), you still have W access.
>>
>> Now you've created a situation in which an operation that security
>> policy previously blocked now becomes possible, invaliding previous
>> designs based on the old security invariant. That's the definition of
>> introducing a security hole.
>
> I think you're overstating your case.  To a pretty good approximation,
> setresuid() allows the caller to remove elements from the set {ruid,
> suid, euid}, unless the caller has CAP_SETUID.  If you could ptrace a
> process before it calls setresuid(), you might as well be able to
> ptrace() it after, since you could have just ptraced it and made it
> call setresuid() while still ptracing it.

What about a child that execs a setuid binary?

> Similarly, it seems like
> it's probably safe to be able to open an fd that lets you watch the
> exit status of a process, have the process call setresuid(), and still
> see the exit status.

Is it? That's an open question.

>
> Regardless of how you feel about these issues, if you're going to add
> an API by which you open an fd, wait for a process to exit, and read
> the exit status, you need to define the conditions under which you may
> open the fd and under which you may read the exit status once you have
> the fd.  There are probably multiple valid answers, but the question
> still needs to be answered.

Yes. That's the point I made in that previous message of mine that I referenced.

> My POLLERR hack, aside from being ugly,
> avoids this particular issue because it merely lets you wait for
> something you already could have observed using readdir().

Yes. I mentioned this same issue-punting as the motivation behind
exithand, initially, just reading EOF on exit.
