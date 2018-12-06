Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822D4C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3F20879
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i6T4SG6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE3F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeLFBAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:00:49 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35179 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFBAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:00:49 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so9807263ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnjHZKhyAx3sksD1sr0ATyG8f0Nyf47H3LTdhjZMYFg=;
        b=i6T4SG6jtxuH0WKI9P5a0SCWCpZx+0qDN1d8GHRmi0+Lzp8Bnxj8yeZkrK7SJh/AwU
         r2kyZBqBdWSm9m+FmFCR1QAFy8rBATqaS7a1gR8eU0kBk6tLFp+FQ7HHRtQRRyw2IBI4
         5F946ajOEy1+wOUHljPQkssRfJh5gx8PaT85Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnjHZKhyAx3sksD1sr0ATyG8f0Nyf47H3LTdhjZMYFg=;
        b=XDWIwYzff5QIfqax4zC3KEZGj89NOm2rwfq5m+8Yc+5uWxEkqrcM30Mb4B8G9iX5G8
         Yuadqzq8gVUSwRGwy2H3nkBz5GhYI8i6cEg4shbr2lxoxd9LcEOLeX1x5Zks53LdJT+4
         z0JrsmbndadsUF3HKRjiDDq5M+v2sWINV5x5TC+0CSEjjrKyECoKsp8a43GWzuO3KrC9
         oQl32PdOZhUnY7XasZJr4nih3EuqPXapg5qlS39z1q0kJSsFcTSm7vd34aMkHqXUdnaU
         mBIOYqVL7A1Um8zgdLuUTBD2mlOFNW5jR46erPAFCZzSXezNrYm05OQqVEEoVrb3Ofxh
         kq2Q==
X-Gm-Message-State: AA+aEWYEObnhh8J7SGW5XqXq605DQlVk/0RR3LnVQNXRm3GqdWwN5HB0
        ZV0L6sUs7hvDitQIBnA4YZ9+eR3tayA=
X-Google-Smtp-Source: AFSGD/XEzWSGoaoUWBRgEXv0AyJRZejU84OL7Fg9TCzZs0tVoxpo1gqlEhkl0LdEbwnHTDCDliJlpA==
X-Received: by 2002:a0d:c306:: with SMTP id f6mr4315064ywd.101.1544058047754;
        Wed, 05 Dec 2018 17:00:47 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n4sm7051408ywc.89.2018.12.05.17.00.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 17:00:46 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id x144so5646194ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:00:46 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr27653659ywv.124.1544058045804;
 Wed, 05 Dec 2018 17:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco> <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com> <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com>
In-Reply-To: <87k1ktqoe5.fsf@xmission.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 17:00:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
Message-ID: <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 7:04 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kees Cook <keescook@chromium.org> writes:
>
> > On Tue, Nov 27, 2018 at 8:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Kees Cook <keescook@chromium.org> writes:
> >>
> >> > On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
> >> >> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> >>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
> >> >>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
> >> >>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
> >> >>>>
> >> >>>> Ok, now I have,
> >> >>>>
> >> >>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
> >> >>>> global.syscall_restart: Test failed at step #22
> >> >>>
> >> >>> Seems like this is still happening on v4.20-rc4,
> >> >>>
> >> >>> [ RUN      ] global.syscall_restart
> >> >>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
> >> >>> global.syscall_restart: Test failed at step #22
> >> >>
> >> >> This fails every time for me -- is it still racey for you?
> >> >>
> >> >> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)
> >> >
> >> > This bisects to here for me:
> >> >
> >> > commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
> >> > Author: Eric W. Biederman <ebiederm@xmission.com>
> >> > Date:   Mon Sep 3 09:50:36 2018 +0200
> >> >
> >> >     signal: Never allocate siginfo for SIGKILL or SIGSTOP
> >> >
> >> >     The SIGKILL and SIGSTOP signals are never delivered to userspace so
> >> >     queued siginfo for these signals can never be observed.  Therefore
> >> >     remove the chance of failure by never even attempting to allocate
> >> >     siginfo in those cases.
> >> >
> >> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >> >     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> >
> >> > They are certainly visible via seccomp ;)
> >>
> >> Well SIGSTOP is visible via PTRACE_GETSIGINFO.
> >>
> >> I see what is happening now.  Since we don't have queued siginfo
> >> we generate some as:
> >>                 /*
> >>                  * Ok, it wasn't in the queue.  This must be
> >>                  * a fast-pathed signal or we must have been
> >>                  * out of queue space.  So zero out the info.
> >>                  */
> >>                 clear_siginfo(info);
> >>                 info->si_signo = sig;
> >>                 info->si_errno = 0;
> >>                 info->si_code = SI_USER;
> >>                 info->si_pid = 0;
> >>                 info->si_uid = 0;
> >>
> >> Which allows last_signfo to be set,
> >> so despite not really having any siginfo PTRACE_GET_SIGINFO
> >> has something to return so does not return -EINVAL.
> >>
> >> Reconstructing my context that was part of removing SEND_SIG_FORCED
> >> so this looks like it will take a little more than a revert to fix
> >> this.
> >>
> >> This is definitely a change that is visible to user space.  The logic in
> >> my patch was definitely wrong with respect to SIGSTOP and
> >> PTRACE_GETSIGINFO.  Is there something in userspace that actually cares?
> >> AKA is the idiom that the test seccomp_bpf.c is using something that
> >> non-test code does?
> >
> > I think this would be needed by any ptracer that handled multiple
> > threads. It needs to figure out which pid stopped. I think it's worth
> > fixing, yes.
> >
> >> The change below should restore the old behavior.  I am just wondering
> >> if this is something we want to do.  siginfo is allocated with
> >> GFP_ATOMIC so if your machine is under memory pressure there is a real
> >> chance the allocation can fail.  Which would cause whatever is breaking
> >> now to break less deterministically then.
> >
> > I think memory pressure that would block a 128 byte GFP_ATOMIC
> > allocation would mean the system was about to seriously fall over.
> > Given the user-facing behavior change and that an existing test was
> > already checking for this means we need to fix it.
>
> That sounds good but it is all rubbish.
> A) It doesn't matter for tracing multiple processes because ptrace
>    only works on a single signal at a time.  AKA if by the time you
>    are calling PTRACE_GETSIGINFO you already know which process you are
>    working against.
> B) Not every signal includes si_pid so even if you didn't know who you
>    were talking to this would be an issue.
> C) For a non-rt signal we only every try and queue up a signal signal.
>    We don't even attempt to queue siginfo otherwise.

Fair enough, all true.

> So what is the real world use case?

A quick search didn't show anything I could find (looking for
combinations of PTRACE_GETSIGINFO and si_pid use around a SIGSTOP).
That doesn't mean it doesn't exist, though. The reason seccomp's
selftests are so extensive is because we've had some very
corner-case[1] bugs in real-world software.

> The most useful I can think of is the whole check if this tracer was the
> one who sent SIGSTOP.  But that is fundamentally unreliable because we
> only queue a single signal anyway.  We must to that to preserve
> compatibility for non-rt signals as otherwise there are cases we could
> queue the same signal twice.  So with two simultaneous SIGSTOPs it is a
> race condition which siginfo is made available.

Understood. However, the point of the seccomp test is for making sure
that the ordering of the controlled test gets us the right pattern of
events across a syscall interruption when seccomp is filtering. This
is about making sure nothing around the restart changes since this
could impact seccomp filters in the wild.

> Right now we are on the edge of letting test cases for debug
> infrastructure prevent obvious optimizations/improvements to the code.
> So if we can find something other than our seccomp_bpf.c test case that
> fails I am happy to go with the change I posted.  Otherwise I think we
> just need to fix seccomp_bpf.c.

I wouldn't call this "debug infrastructure": they are behavioral test
cases for seccomp, syscall, and ptrace interaction, and even this one
has found bugs (see the "FIXME" note a few lines down, that remains
unsolved[2] in arm32).

If this actually doesn't count as breaking userspace, then okay, sure,
I'll drop the sanity check in the seccomp selftest. But it feels wrong
to me.

-Kees

[1] 485a252a5559 ("seccomp: Fix tracer exit notifications during fatal signals")
[2] http://lkml.kernel.org/r/CAGXu5jKzif=vp6gn5ZtrTx-JTN367qFphobnt9s=awbaafwoUw@mail.gmail.com

--
Kees Cook
