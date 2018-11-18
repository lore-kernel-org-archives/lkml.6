Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB84EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDEF2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHAokVmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDEF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeKSDp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:45:28 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33659 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:45:28 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so16494475vsc.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wytjs4fpH0VD9nKliwqpD+0su5qcPR+2gu7HKTH97n4=;
        b=UHAokVmiVyoDk/BeC3n4nE1ZmTfQwlityg+VMPmH7l9m7l5dzORebTki/1mZZx2XM5
         Kx4kz4Ca8Tw1NEtSFySoIVnFyqRpswTZXZWZZnfoAJj5/9Blxagq2kSBvY6sIJ6xidF0
         +kUe2dGYAi9bu5JcDVZ5+YrVBcpPPrOq/GtZe+SF8whQyyhBKclyOiI/lx6+5uUQxV1u
         JQHwEPjLR5iVZGT/fK8ZbtC9vt9PGftkPcTLuxKNyg/1koID3jNPurh6lR2Ro7Nb9Zcf
         B57uTV+qV2qkxJLSRq2wAJ+JoNphZyc8uexXmixKl7sIW8AIt30vS5yaFdfKSRWVzser
         VbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wytjs4fpH0VD9nKliwqpD+0su5qcPR+2gu7HKTH97n4=;
        b=OgqYmMAlTaoFsTPDPU2wuGrWOkw44074ZoQ+KtwLLzdde2ERTqR/kXSrc5ZE4enKhl
         M2hiR9f/DZl8vbmceP5S8Y54SFApl4br0mtRQgGwTWyRWwATnCXLQYlQCfxYCIb+zfxK
         C9rNfWtL5yVMCcK83oozf+6milwtywcs0IxBPI0hxDBmDYshY/tG2fALq3AbAXusr0+a
         1wbHIoGZDjgtuXw7h2Xi9XqI+3fcH0pJxTvGdliNtpMwCmXz6waW5jyBcTChNdW2DAn7
         jm4xbaWCtsCmG+vgMMT7l2By+StcP2xjZePk5ou6T9O0YXz8euNEd3HMnYh+OigK0YKv
         Hbaw==
X-Gm-Message-State: AGRZ1gJqMzlPg1nkgWMr0kIlIQlt3Ud9SgQOmSyD3+01aoCgEtevQkFb
        oVq7Ozj8A063ZEUPgZ6TshyJgNRmr1xyiGxpT6yCBQ==
X-Google-Smtp-Source: AJdET5daWxf4xgmeEWbkDf2VYXZ4xESotBXY/nezqGizEoXG8jOjJSS+VOYBpUxhfq/NdfpaLfvbVQzzBsEIZqRbzFQ=
X-Received: by 2002:a67:b44:: with SMTP id 65mr7763131vsl.77.1542561877422;
 Sun, 18 Nov 2018 09:24:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 09:24:36
 -0800 (PST)
In-Reply-To: <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 09:24:36 -0800
Message-ID: <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
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

On Sun, Nov 18, 2018 at 9:09 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 8:49 AM Daniel Colascione <dancol@google.com> wrote:
>>
>> On Sun, Nov 18, 2018 at 8:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> > On 11/18/18 8:17 AM, Andy Lutomirski wrote:
>> >> On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>> >>>
>> >>> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> >>>> I fully agree that a more comprehensive, less expensive API for
>> >>>> managing processes would be nice.  But I also think that this patch
>> >>>> (using the directory fd and ioctl) is better from a security
>> >>>> perspective than using a new file in /proc.
>> >>>
>> >>> That's an assertion, not an argument. And I'm not opposed to an
>> >>> operation on the directory FD, now that it's clear Linus has banned
>> >>> "write(2)-as-a-command" APIs. I just insist that we implement the API
>> >>> with a system call instead of a less-reliable ioctl due to the
>> >>> inherent namespace collision issues in ioctl command names.
>> >>
>> >> Linus banned it because of bugs iike the ones in the patch.
>> >>
>> >>>
>> >>>> I have an old patch to make proc directory fds pollable:
>> >>>>
>> >>>> https://lore.kernel.org/patchwork/patch/345098/
>> >>>>
>> >>>> That patch plus the one in this thread might make a nice addition to
>> >>>> the kernel even if we expect something much better to come along
>> >>>> later.
>> >>>
>> >>> I've always commented on that patch. You never addressed my technical
>> >>> objections. Why are you bringing up this patch again as if that
>> >>> discussion had never happened? To review, that patch has various race
>> >>> conditions
>> >>
>> >> I don't think I ever saw that review.
>> >>
>> >>> and even if it were technically correct, it'd be an abuse
>> >>> of directory objects (in what other circumstance do we poll
>> >>> directories?) and not logically generalizable to a model in which we
>> >>> expose process exit status via the exit-monitoring API.
>> >>
>> >> I agree it's weird.  It might be better to have /proc/PID/exit_status
>> >> and make *that* pollable.
>> >>
>> >
>> > If there is a new exit_status file, it could even be more than
>> > 8 bits of exit status:
>> >
>> > See https://lore.kernel.org/lkml/alpine.LSU.2.20.1507091257010.9602@nerf40.vanv.qr/T/#u
>> > and http://austingroupbugs.net/view.php?id=594#c1317
>>
>> First of all, as I discussed in [1], we need to first figure out *who*
>> should have access to the process exit information. FreeBSD appears to
>> make it public without disaster, and if we make exit status public, a
>> lot of problems just disappear.
>
> I kind of want to go in the other direction of making a lot of process
> information (especially cmdline) less publicly accessible.

Okay. That has nothing to do with exit status. Please address the
points related to the API we're discussing and that I raised in the
other thread.

Assuming we don't broaden exit status readability (which would make a
lot of things simpler), the exit notification mechanism must work like
this: if you can see a process in /proc, you should be able to wait on
it. If you learn that process's exit status through some other means
--- e.g., you're the process's parent, you can ptrace the process, you
have CAP_WHATEVER_IT_IS_ --- then you should be able to learn the fate
of the process. Otherwise you just be able to learn that the process
exited.

>  Windows has an easy time of it because

Windows has an easier time of it because it doesn't use an ad-hoc
ambient authority permission model. In Windows, if you can open a
handle to do something, that handle lets you do the thing. Period.
There's none of this "well, I opened this process FD, but since I
opened it, the process called setuid, so now I can't get its exit
status" nonsense. Privilege elevation is always accomplished via a
separate call to CreateProcessWithToken, which creates a *new* process
with the elevated privileges. An existing process can't suddenly and
magically become this special thing that you can't inspect, but that
has the same PID and identity as this other process that you used to
be able to inspect. The model is just better, because permission is
baked into the HANDLE. Now, that ship has sailed. We're stuck with
setreuid and exec. But let's be clear about what's causing the
complexity.
