Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E324B2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnQhawD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E324B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKSDiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:38:23 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34691 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSDiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:38:22 -0500
Received: by mail-ua1-f65.google.com with SMTP id z23so9708045uam.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=grI9evRjuC5Yl8ZpNx9BG0kKmO4Je6cBfn+q6L6JCzQ=;
        b=SnQhawD4Yb3zY7VcrJWpIrZvFs4Oj9ZshwDmewTdzGEqg/hD9eMMzxlw8Y1PfUMzrq
         IhYcmBQww7mYweEOPkCVaOjLzgcpRPqxkVceA5yKTqgiBOLSeK4Wt/ah7W1rExGxUAzX
         m0zNIfT7j5R5ZPBfJLgLSa4JYVNVBtcNT+4ytg57jvkiY1OKJgY844cPvo/s89TSnS6d
         9ID8bOMOaa0yLV37WCcSdlNgQv6TGH/wZAUiD2UAMwcvzsPeyBRiP3Mf5z1pJzhElNBO
         Ef41yBmfTF/d3ypiAIMjG0sEKdCWMMgVGrbW2kJDvR0STJcdSOntH9TRbiH5YPt1c++b
         zESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=grI9evRjuC5Yl8ZpNx9BG0kKmO4Je6cBfn+q6L6JCzQ=;
        b=aVUmP2zMsZKr/7SNQqRfiz1voXdyeITvjZtfEk8aQwVV9CyMpxGST+KjvNkUxsesQy
         J1awSATgAwGc/kg/zZXwiVJF4vYuyvltTq02/5b3v2bUeucmyk6yYf6NEj4ZKV/ASPIS
         UqIeOPi4gPJqwhV0fE9c/Wvw5uF9brUa0MlAec6GxBB3rHQyv/7fs2/RX//SS7uO87Wp
         BuSH0lVbwnNoPiPri/bVh0a4WjBOWIoXE5PdChZkPC0z8ZJqMkGP6wx+VHi0XguH/WkI
         sEHEYcE+PbVh6KG5fcontqTlZaQLTv7NbZVCCPZ0PAHLFHj/b6narYfDUtC35oQW3Lov
         rEMQ==
X-Gm-Message-State: AGRZ1gI/SqDKSlBVCXg2XDicPmiqZamW9iJyw3zTqTo1OqAUr3/P7vYp
        PttUbX8V2Xo5FQoihZLpsow+KzGbWcvcalKQzSM/kw==
X-Google-Smtp-Source: AJdET5dUhgJ/s0RPGV+fIfLJ3O2JOyUNNQTk/T+OIOaO2+RVyprJB+wlJqdLx0K31t6nofDAqVRdHqGPqIjPTSml844=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr8275891uau.13.1542561452731;
 Sun, 18 Nov 2018 09:17:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 09:17:31
 -0800 (PST)
In-Reply-To: <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com> <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 09:17:31 -0800
Message-ID: <CAKOZues3_uh1mnQr=VPCxoWiY0wfiUq0oFXcVuiHF7rPmUXsuw@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
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
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:13 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Sun, Nov 18, 2018 at 8:29 AM Daniel Colascione <dancol@google.com> wrote:
>>
>> On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> > On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>> >>
>> >> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> >> > I fully agree that a more comprehensive, less expensive API for
>> >> > managing processes would be nice.  But I also think that this patch
>> >> > (using the directory fd and ioctl) is better from a security
>> >> > perspective than using a new file in /proc.
>> >>
>> >> That's an assertion, not an argument. And I'm not opposed to an
>> >> operation on the directory FD, now that it's clear Linus has banned
>> >> "write(2)-as-a-command" APIs. I just insist that we implement the API
>> >> with a system call instead of a less-reliable ioctl due to the
>> >> inherent namespace collision issues in ioctl command names.
>> >
>> > Linus banned it because of bugs iike the ones in the patch.
>>
>> Maybe: he didn't provide a reason. What's your point?
>
> My point is that an API that involves a file like /proc/PID/kill is
> very tricky to get right.  Here are some considerations:

Moot. write(2) for this interface is off the table anyway. The right
approach here is a system call that accepts a /proc/pid directory file
descriptor, a signal number, and a signal information field (as in
sigqueue(2)).

> Now if we had an ioctlat() API, maybe it would make sense.  But we
> don't, and I think it would be a bit crazy to add one.

A process is not a driver. Why won't this idea of using an ioctl for
the kill-process-by-dfd thing just won't die? An ioctl has *zero*
advantage in this context.
