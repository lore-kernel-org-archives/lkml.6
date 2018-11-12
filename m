Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25305C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0844223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uA1jdZZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0844223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeKLXMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:12:31 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36095 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbeKLXMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:12:31 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so5073547vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WEmDd1nOC2Tjev8A8LCkJgx1PVq+TddUsR2aA/QUBL4=;
        b=uA1jdZZ4Uyji8hNSnzRNHxJuWVvAyWMcNgtcd73PLqq95IYMTY6dve693fLffG9jgT
         sdWas7ZnO1AoMn+3qAUQJV/dcirJEFVrleYyWSMq6PZBcSCBlXiP2u+h2opfMQaoXB/b
         wL2/VQufUnIGq3gs9cPxBsVK5aarUi1i3Ht8AEzZczyCqlLkq6jcdZoHFESQvw+l3ECq
         imGhrBiZVf1y1mtGxDWWMLLt6knK8T4D6w6A6ZXTwAwW/hMqjvT/KcEKiJ3cK0y50S2W
         3kwzjv472L+B5ryJ20LXlnMrVulJ+XxVxRxK5moOsCao2QOi/yHoEAwdD4Cni5YCRlzY
         xovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WEmDd1nOC2Tjev8A8LCkJgx1PVq+TddUsR2aA/QUBL4=;
        b=JH5NIdwjcGZseTcm4F/jnQRDzV/TekPGf+H8s1naM6RUl9PYj0elWNTy83038COXB2
         LR8CWOaJcw6wIydWWWWWdbRs5WuWathanbUFLeKdA9ofdtGw4Qd45ZCTlwEuEVNO14ge
         zELBrNcE9bdXpKFSOjWc7Ty5gZd9B3GRL+YfTYf+yqIN0CsxIk5fxwnJYSHj+yyjE/x+
         3kJAiXeG8HZ6Alwgc+0U+P98x9clqNOX1Rs8CyHHcdhWL3m5QJVdF0+pxJYa5IuhRh4c
         Tn3grR9q/T1b8Bx5CIKf2qAjJdAycvCJAGWYADqEAeVLcNawS8yUlP49DNYBubMR277K
         JEfg==
X-Gm-Message-State: AGRZ1gKDvCn2FxXVGRkIJAvNYKhSuStUBbogAfjFtVPT4UapcVeK5s4x
        eKUSw0e7LVQNvqIWk7A2H7sTWYFPsrER2/aPowkQng==
X-Google-Smtp-Source: AJdET5fk+vqmdsSZ2/oScsng3/YkhOW8IvC/rw0h/f3NQYQgvJjXFn5p1N+Djd020DQVnz2FJQQHPtxP4Cs9WH4I1tM=
X-Received: by 2002:a67:6346:: with SMTP id x67mr385356vsb.114.1542028755303;
 Mon, 12 Nov 2018 05:19:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 05:19:14
 -0800 (PST)
In-Reply-To: <875zx2vhpd.fsf@oldenburg.str.redhat.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com> <875zx2vhpd.fsf@oldenburg.str.redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 12 Nov 2018 05:19:14 -0800
Message-ID: <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:11 AM, Florian Weimer <fweimer@redhat.com> wrote:
> * Daniel Colascione:
>
>> If the kernel provides a system call, libc should provide a C wrapper
>> for it, even if in the opinion of the libc maintainers, that system
>> call is flawed.
>
> It's not that simple, I think.  What about bdflush?  socketcall?
> getxpid?  osf_gettimeofday?  set_robust_list?

What about them? Mentioning that these system calls exist is not in
itself an argument.

> There are quite a few
> irregularities

So?

> and some editorial discretion appears to be unavoidable.

That's an assertion, not an argument, and I strongly disagree. *Why*
do you think "editorial discretion" is unavoidable? What privileges
glibc's judgement here? What would go wrong if socketcall and
set_robust_list and so on had wrappers? If applications chose to use
these lower-level wrappers instead of higher-level facilities, they
take on responsibility for using the APIs properly.

> Even if we were to provide perfectly consistent system call wrappers
> under separate names, we'd still expose different calling conventions
> for things like off_t to applications, which would make using some of
> the system calls quite difficult and surprisingly non-portable.

We can learn something from how Windows does things. On that system,
what we think of as "libc" is actually two parts. (More, actually, but
I'm simplifying.) At the lowest level, you have the semi-documented
ntdll.dll, which contains raw system call wrappers and arcane
kernel-userland glue. On top of ntdll live the "real" libc
(msvcrt.dll, kernel32.dll, etc.) that provide conventional
application-level glue. The tight integration between ntdll.dll and
the kernel allows Windows to do very impressive things. (For example,
on x86_64, Windows has no 32-bit ABI as far as the kernel is
concerned! You can still run 32-bit programs though, and that works
via ntdll.dll essentially shimming every system call and switching the
processor between long and compatibility mode as needed.) Normally,
you'd use the higher-level capabilities, but if you need something in
ntdll (e.g., if you're Cygwin) nothing stops your calling into the
lower-level system facilities directly. ntdll is tightly bound to the
kernel; the higher-level libc, not so.

We should adopt a similar approach. Shipping a lower-level
"liblinux.so" tightly bound to the kernel would not only let the
kernel bypass glibc's "editorial discretion" in exposing new
facilities to userspace, but would also allow for tighter user-kernel
integration that one can achieve with a simplistic syscall(2)-style
escape hatch. (For example, for a long time now, I've wanted to go
beyond POSIX and improve the system's signal handling API, and this
improvement requires userspace cooperation.) The vdso is probably too
small and simplistic to serve in this role; I'd want a real library.
