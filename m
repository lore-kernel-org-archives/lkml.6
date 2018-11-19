Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnxKAR54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeKSLiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:38:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34183 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeKSLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:38:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so16869060vsi.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EPU6gbT3pzQrwTTd8Uz3Co5fUAroN8ixZhgPdxLuYjM=;
        b=rnxKAR54MFMWcCZ1EtHph8FbuJdVh1C/lit2WN2VLiiewXNRmfF9BywkMpvlOCU63c
         DwVoZUohnofTzUAk5S6nNzJpRkn4ItiHP32XFtELs0Ag424jZAr4f+YU/O7NdxK1g6QI
         hhgXF902usEZFCEZJjoLrROf9qvzcn9bIVe+3279kDWM07xeqWFWEI/mISZTa16Xhgwx
         Pk8XwJ8hxLMlu1wKRkpEYKS5MLSST/W20CALCJHXie0mHK4dwEMgJGSy6NuJFQXPuIT0
         J4CeyI5PMWybiW74J3j6cxuReUpCI9gUbVMZSZux85uU9ASSu/mCvJ9jrPtxMoZgn0Vd
         4kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EPU6gbT3pzQrwTTd8Uz3Co5fUAroN8ixZhgPdxLuYjM=;
        b=Xr5K7gya19S6A3HNzgLjtU3qGOAreKrEktsKOZoFWmdYaPT+Waz7yIn9J46483SmvP
         yQHfdl4lTJ+81u656aXgey+fAx2cnGnmJXiy2tfxrxDyd6zVQuZVGhgVAAQNoVRvtpG2
         dBfLITT4pCXvshPcpkj0hfKriQ5jG1lUqan7Q4c7aFckwoVchtgQR56Y/KjxervqaVFr
         a9+QOwA61/hCKsE/Gk5FjmDSGecbly4/dXE94ONFBi9AHDQOc0DAAfwtkhkN2Y4Cjq13
         TNmHDAy4M7916Oj8wd66EGS8Z7ZJDYXb2bxu6NB5yH2xL4JrXV6lyyVF79kfOsulvjNo
         IVwQ==
X-Gm-Message-State: AGRZ1gIZoHnXohqXhKTxoGuKrVUiBWqgaPneDhkNTI/y4aS0R28GCwCw
        1GhjnbtGVzS6CgQ1B4V24QMt8kFDAV9VyB69AjHgxw==
X-Google-Smtp-Source: AJdET5errPWpIE/JthOrrstbJtQyA8+nm9GHPN4CToIkKsFWo2Tir/rd58YMee8U+rdl9kyMPS28n8b6+aNKPXJQ4Sw=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr8412454vsc.171.1542590184754;
 Sun, 18 Nov 2018 17:16:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 17:16:23
 -0800 (PST)
In-Reply-To: <CAKOZueve_r5h9_B2YV5RzJYjTf-yS5uZfAbz+Ftqy5jFSk6Xdw@mail.gmail.com>
References: <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
 <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin> <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
 <20181119000928.h2wp2rn2pnlfysp7@yavin> <CAKOZueve_r5h9_B2YV5RzJYjTf-yS5uZfAbz+Ftqy5jFSk6Xdw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 17:16:23 -0800
Message-ID: <CAKOZuevHoEAZdnQmuGiwpLcfxSBq3M8T0ZeQFG+Do2aCFcZfQQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
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

On Sun, Nov 18, 2018 at 4:53 PM, Daniel Colascione <dancol@google.com> wrote:
>> Sure, I'd propose that ptrace_may_access() is what we should use for
>> operation permission checks.
>
> The tricky part is that ptrace_may_access takes a struct task. We want
> logic that's *like* ptrace_may_access, but that works posthumously.
> It's especially tricky because there's an LSM hook that lets
> __ptrace_may_access do arbitrary things. And we can't just run that
> hook upon process death, since *after* a process dies, a process
> holding an exithand FD (or whatever we call it) may pass that FD to
> another process, and *that* process can read(2) from it.
>
> Another option is doing the exithand access check at open time. I
> think that's probably fine, and it would make things a lot simpler.
> But if we use this option, we should understand what we're doing, and
> get some security-conscious people to think through the implications.

A ptrace check is also probably too strict. Yama's ptrace_scope
feature will block ptrace between unrelated processes within a single
user context, but applying this restriction to exit code monitoring
seems too severe to me.
