Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351BC2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4BzzVmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351BC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKSERj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:17:39 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34985 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeKSERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:17:39 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so6292882vke.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JptqXnmsgFsqWNAtAkQ5nrQ1W0QSPp8s9Ut6D+P7WKY=;
        b=W4BzzVmjeWM68kIKG0Vh009HMHQqr57lv/4ldR+tJy/4hNfIJEtNovO+UUMxoCag7F
         rZIW7LumlsKM1QIrf+PA6BYLkXEihuIQ1o30YAcoDxK/jPhMIO0rXsfqftetIpM5+CCh
         xxqxZwp/K0D/xlYHCluaafS7W809kiUKmxbcplLZ/rfCJwtLSFLbRb6LMICIqSyL2oEW
         XgLWekR1Be9EeIrIpL6w2tbsRpiiFvKaK9eo4kQtvk1nA4VWRSyo8t7TcI8fwVyCZx68
         t4PEgMTjQicYUVcqCNz9FFFTQjr4IteSJOwT3RDElRwskpBdWjsrIu3BGxrVgY33Znky
         THzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JptqXnmsgFsqWNAtAkQ5nrQ1W0QSPp8s9Ut6D+P7WKY=;
        b=QYZrqYailLLIQxIEWml6XG5JVjwavqis4qy92yDabhSvA5pUMSO2dOsMOnTnWznVT3
         okeN53RAxUPf0Tc0v72O7X5BCh3ABTmQbvqqRPlNx6jGPRvd4Wqs5FDXg8o4bxJvTbHI
         tyEjOBECteTejs0M6VKzTx4fiJFi2vTveCU6m3L8FFBqRujh7WgvR8jnG44DndStFPFh
         3R1rM5bvh0OZSokzs1Mkz7KZv1nojz75C/dkkNleHYnRCujwHlCOvYDkT7iGy2KLAVLA
         pc1QV7UQYo5siLIJWrINz2uK+NzQX18qWV9O1DANAnb8XQR8GV2bSjmgjSSrHbkHgihD
         NrLw==
X-Gm-Message-State: AGRZ1gLWBv5Jl3Rbed7pGqYNJqfj9Zp/Iphe/JfQR4TSjsmolEg9Ukd0
        3gg8uZoF9B8l/tgsKGBgOnFRitV7CDO7q6nxan7xSw==
X-Google-Smtp-Source: AJdET5dZAsclmsfm2xrV+J64EqejjG9TvplM10PbuwtRto1MdIN0AsHLyyAx/8UC7efHeipjQpxRPkFRWIhCOZy1NSc=
X-Received: by 2002:a1f:34c7:: with SMTP id b190mr7612314vka.55.1542563803672;
 Sun, 18 Nov 2018 09:56:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 09:56:42
 -0800 (PST)
In-Reply-To: <875zwu46z1.fsf@xmission.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
 <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
 <CAKOZues3_uh1mnQr=VPCxoWiY0wfiUq0oFXcVuiHF7rPmUXsuw@mail.gmail.com> <875zwu46z1.fsf@xmission.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 09:56:42 -0800
Message-ID: <CAKOZues_ePV5h-6C1hwWcHvcbB8Lni5yP_YPw=ey4Q31j4TMjA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:43 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Daniel Colascione <dancol@google.com> writes:
>
>> On Sun, Nov 18, 2018 at 9:13 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On Sun, Nov 18, 2018 at 8:29 AM Daniel Colascione <dancol@google.com> wrote:
>>>>
>>>> On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>>> > On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>>>> >>
>>>> >> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>>> >> > I fully agree that a more comprehensive, less expensive API for
>>>> >> > managing processes would be nice.  But I also think that this patch
>>>> >> > (using the directory fd and ioctl) is better from a security
>>>> >> > perspective than using a new file in /proc.
>>>> >>
>>>> >> That's an assertion, not an argument. And I'm not opposed to an
>>>> >> operation on the directory FD, now that it's clear Linus has banned
>>>> >> "write(2)-as-a-command" APIs. I just insist that we implement the API
>>>> >> with a system call instead of a less-reliable ioctl due to the
>>>> >> inherent namespace collision issues in ioctl command names.
>>>> >
>>>> > Linus banned it because of bugs iike the ones in the patch.
>>>>
>>>> Maybe: he didn't provide a reason. What's your point?
>>>
>>> My point is that an API that involves a file like /proc/PID/kill is
>>> very tricky to get right.  Here are some considerations:
>>
>> Moot. write(2) for this interface is off the table anyway. The right
>> approach here is a system call that accepts a /proc/pid directory file
>> descriptor, a signal number, and a signal information field (as in
>> sigqueue(2)).
>
> If we did not have the permission check challenges and could perform
> the permission checks in open, write(2) would be on the table.
> Performing write(2) would only be concrend about data.
>
> Unfortunately we have setresuid and exec which make that infeasible
> for the kill operations.
>
>>> Now if we had an ioctlat() API, maybe it would make sense.  But we
>>> don't, and I think it would be a bit crazy to add one.
>>
>> A process is not a driver. Why won't this idea of using an ioctl for
>> the kill-process-by-dfd thing just won't die? An ioctl has *zero*
>> advantage in this context.
>
> An ioctl has an advantage in implementation complexity.  An ioctl is
> very much easier to wire up that a system call.
>
> I don't know if that outweighs ioctls disadvantages in long term
> maintainability.

It's not just maintainability. It's safety. We want to expose the new
kill interface to userspace via some kill(1) extension, probably. So
you should be able to write something like `cd /proc/12345 && kill
--by-handle .`. How does kill --by-handle know that it's safe to
perform the kill-by-proc-dfd operation on the file descriptor that it
opens? If the kill operation is an ioctl, you could pass it
/proc/self/fd/whatever of a completely different type; kill would call
ioctl on whatever FD it got, and potentially do a completely random
thing instead of killing a process. In the same situation, a new
system call would fail reliably. Yes, kill could check that the device
numbers of the file it opened matched proc's somehow, but that's
annoying and error-prone and nobody's going to bother in practice. A
new system call, by contrast, fails safe.

I really don't want to give up safety and fail-safe behavior forever
just because it's annoying, today, to wire up a new system call. (The
new table-driven system call stuff, if it ever lands, would make
things easier.)
