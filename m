Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E242075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGO3PmuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E242075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKSEMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:12:44 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35981 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeKSEMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:12:43 -0500
Received: by mail-vk1-f193.google.com with SMTP id u62so6298591vkb.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xTjVAx0do3pXXWBiYgW/+NRCAEmlW2RHRdHODaxIQh4=;
        b=cGO3PmuP2vOCp5Xvn7EWC1EYResJaQ+OJ3EjPqKA5yTnHroEL7QqFGEY37GUstT0+P
         xiISJRZ4mt7HEoafZBI5ZOUtgHEVEPnkLawJUTRvkHdr2iKHjISECQ5gdRzRCEmvz45T
         CVJmgKUbBbXd1T7R47T4N03OoJGXfyvvDzHUX1vREHq5l4SOO4QjBbJh+9YMT/OnR871
         QhYnE069pFdN/tDXSa7m6Xfs+jsx8DEEUVa7zBCPn6JQdwpMpLG9gup8RT/IDStLyj25
         lh21LtMppIJLLzM3t5iszWsn83QnMGFBXATl79EpkqfbBjRSKnYqKqieAVCwDrMzYEue
         BgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xTjVAx0do3pXXWBiYgW/+NRCAEmlW2RHRdHODaxIQh4=;
        b=S5OKO5HBAWSSbJoVVz24Gz9wxTzmFTegsTz325OGZpBUEDefuz7K/oqt/j+I96Ns/2
         XRavubqG0CalouBQCHc9OWHdxLJpalpHeE6u1k6Zdw+ppaoBfh8ZK3De+ff/QMM01kTq
         wXTh8GwMqx5b7aFpBuhM+vIo0vFHf/lt4zx+kZLG5O00d2CeMxJAug8Jsl4FOZjERBfV
         vM6s9l9R+DxZthnNLK9HmfK34V9o4HD4O29+oQEq7H3hwVTB/jWG4Gsqfx6xpYuQFlTc
         Xkx/BVMKOiw1hQ50/+3RaKUfBobKYKqqrKKYLmp9RU38ZAHdd18m+wxa03XisBdv7b94
         L3nQ==
X-Gm-Message-State: AA+aEWamxAqPie7AOkEzBWwrgMFYh0Sm2XxGjfQVFfrdgnEoc4cMty2W
        We9RqBgmgHvuVeNQxfptFX9wPutj+Ou3dlTqxAiWQQ==
X-Google-Smtp-Source: AFSGD/U8pJnRiG5v7DwHUtz/l6o1FmfRuwoFBbM9kGGIto80lHiq/bUawLqiQxFmMfzEUvpEsDmVPshrB21H680Ut+M=
X-Received: by 2002:a1f:c4d:: with SMTP id 74mr2691827vkm.50.1542563509001;
 Sun, 18 Nov 2018 09:51:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 09:51:48
 -0800 (PST)
In-Reply-To: <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com> <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 09:51:48 -0800
Message-ID: <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
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

On Sun, Nov 18, 2018 at 9:42 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 9:24 AM Daniel Colascione <dancol@google.com> wrote:
>> Assuming we don't broaden exit status readability (which would make a
>> lot of things simpler), the exit notification mechanism must work like
>> this: if you can see a process in /proc, you should be able to wait on
>> it. If you learn that process's exit status through some other means
>> --- e.g., you're the process's parent, you can ptrace the process, you
>> have CAP_WHATEVER_IT_IS_ --- then you should be able to learn the fate
>> of the process. Otherwise you just be able to learn that the process
>> exited.
>
> Sounds reasonable to me.  Except for the obvious turd that, if you
> open /proc/PID/whatever, and the process calls execve(), then the
> resulting semantics are awkward at best.

A process calling execve does not give up its logical identity. Lots
of programs exec themselves, e.g., to reload configuration.

>> >  Windows has an easy time of it because
>>
>> Windows has an easier time of it because it doesn't use an ad-hoc
>> ambient authority permission model. In Windows, if you can open a
>> handle to do something, that handle lets you do the thing. Period.
>> There's none of this "well, I opened this process FD, but since I
>> opened it, the process called setuid, so now I can't get its exit
>> status" nonsense. Privilege elevation is always accomplished via a
>> separate call to CreateProcessWithToken, which creates a *new* process
>> with the elevated privileges. An existing process can't suddenly and
>> magically become this special thing that you can't inspect, but that
>> has the same PID and identity as this other process that you used to
>> be able to inspect. The model is just better, because permission is
>> baked into the HANDLE. Now, that ship has sailed. We're stuck with
>> setreuid and exec. But let's be clear about what's causing the
>> complexity.
>
> I'm not entirely sure that ship has sailed.  In the kernel, we already
> have a bit of a distinction between a pid (and tid, etc -- I'm
> referring to struct pid) and a task.  If we make a new
> process-management API, we could put a distinction like this into the
> API.

It would be a disaster to have different APIs give callers a different
idea of process identity over its lifetime. The precedent is
well-established that execve and setreuid do not change a process's
identity. Invaliding some identifiers but not others in response to
supposedly-internal things a process might do under rare circumstances
is creating a bug machine..

> setresuid() has no effect
> here -- if you have W access to the process and the process calls
> setresuid(), you still have W access.

Now you've created a situation in which an operation that security
policy previously blocked now becomes possible, invaliding previous
designs based on the old security invariant. That's the definition of
introducing a security hole.
