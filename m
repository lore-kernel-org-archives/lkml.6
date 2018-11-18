Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD617C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AC720815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQT8N2+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AC720815
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeKSHPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:15:31 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41571 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeKSHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:15:31 -0500
Received: by mail-vs1-f65.google.com with SMTP id t17so16616017vsc.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sfk5ZdXY2vuq/wJkpLW0WfUPfnM+sqQ55yswNlMabQM=;
        b=VQT8N2+Amv6glMz08WkLUyXyZdi8GCGX+/deOdeCrICjbfDGsCQ897Zs6ljYjjenSF
         NgprT73Hw8KTP3baibaEg2N+582jaAy4b3mmgwzyYm8hzxMDv38gGeKZn0hI4gWULfP6
         F8DePNLPs0RNqmvRaSwFGPdIqQ+h8m7XyKW7mmWhengavOvAmgEihCDby/z3xSdW0sc/
         Ij+StoAvNwfbN0p8iSmN/WuHeMDWlWgrMeNYq85K1QJfwpAxG0z7Ty4zJik8UpOIWaRU
         QNkK98nM6ZETpOiCKKRN67L+4tynxKvxXpdrQLDwny+/aFyifzCCe3dGzgmso5Tl9GZ6
         dpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sfk5ZdXY2vuq/wJkpLW0WfUPfnM+sqQ55yswNlMabQM=;
        b=T+ErhmmlF885Wt8te5EKHkvOs/gYDlxfG1/nW0OFVlpLVIue5UqIUm7HIqq5vG54bu
         z5vb2ZEBfxRB9mvuwBpYnwh+k2A4mFIaCgbN9eUGhyAV+ABu6NHYPwRpLvplFoEZbvV8
         Lgv4p0fUKKFrwMLLGACDpaNFdarVjvhjvWm+lnvv/vA5skLAu5h8I8o4eIAo2pwtSQKA
         2cTlfmvsZf7EUsZFrOIieDef6f90ACqfkpr6gDo9DdLeVPBZ33MB2WbyATlf15NR0MrE
         0MRepKUZVLQpQhBv6ONYPTzRknjQ2yfuiIBwgkmxcEQSiU0Q8O05iwWnf64AlnsB+C7m
         AGTw==
X-Gm-Message-State: AGRZ1gIpUUyVgo7qMXrT5+gB8njGiipo9VTvs+xMEQV7XNSUkdK3UKuz
        pCGBKYZy93kSKfbP7VJeX1QX2idEBi0oZzTpwvcdew==
X-Google-Smtp-Source: AJdET5fd5hsBm4gsvyhSmWG9zdxfw8LhRhNYKIF8b6hOJgVj0fPbLwbAXVV9OTQFKYPkQgp16GmNvAR1/WiyQwafV6w=
X-Received: by 2002:a67:105:: with SMTP id 5mr7880486vsb.183.1542574451277;
 Sun, 18 Nov 2018 12:54:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 12:54:10
 -0800 (PST)
In-Reply-To: <20181118204317.seaztq7fqmysucns@brauner.io>
References: <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <608F2959-800D-46EE-A7CD-8C972ACD2F02@amacapital.net> <20181118204317.seaztq7fqmysucns@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 12:54:10 -0800
Message-ID: <CAKOZueuWzu2GuJ-w3yb01P9uyO1WniKG+i=BUsweVdA-KgEjhw@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
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

On Sun, Nov 18, 2018 at 12:43 PM, Christian Brauner
<christian@brauner.io> wrote:
> On Sun, Nov 18, 2018 at 01:28:41PM -0700, Andy Lutomirski wrote:
>>
>>
>> > On Nov 18, 2018, at 12:44 PM, Daniel Colascione <dancol@google.com> wrote:
>> >
>>
>> >
>> > That is, I'm proposing an API that looks like this:
>> >
>> > int process_kill(int procfs_dfd, int signo, const union sigval value)
>> >
>> > If, later, process_kill were to *also* accept process-capability FDs,
>> > nothing would break.
>>
>> Except that this makes it ambiguous to the caller as to whether their current creds are considered.  So it would need to be a different syscall or at least a flag.  Otherwise a lot of those nice theoretical properties go away.
>
> I can add a flag argument
> int process_signal(int procfs_dfd, int signo, siginfo_t *info, int flags)
> The way I see it process_signal() should be equivalent to kill(pid, signal) for now.
> That is siginfo_t is cleared and set to:
>
> info.si_signo = sig;
> info.si_errno = 0;
> info.si_code = SI_USER;
> info.si_pid = task_tgid_vnr(current);
> info.si_uid = from_kuid_munged(current_user_ns(), current_uid());

That makes sense. I just don't want to get into a situation where
callers feel that they *have* to use the PID-based APIs to send a
signal because process_kill doesn't offer some bit of functionality.

Are you imagining something like requiring info t be NULL unless flags
contains some "I have a siginfo_t" value?

BTW: passing SI_USER to rt_sigqueueinfo *should* as long as the
passed-in si_pid and si_uid match what the kernel would set them to in
the kill(2) case. The whole point of SI_USER is that the recipient
knows that it can trust the origin information embedded in the
siginfo_t in the signal handler. If the kernel verifies that a signal
sender isn't actually lying, why not let people send SI_USER with
rt_sigqueueinfo?
