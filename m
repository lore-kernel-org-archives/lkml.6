Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF46C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040182245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rAV39Scw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040182245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbeKMEXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:23:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45539 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbeKMEXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:23:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so2175775vke.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=11/wTjcHLuYFAncO8Jd3+kuLG5NsXlYTTFxAWm6bKIs=;
        b=rAV39ScwxJZ3gG+D5YaUeP2LjivVxjQSiaZqEkYFfZOD63bm1YBzOuNl4YjP4H+bp3
         rVkzSwIxCD28VhElVukXHUZo6Wp6iHtAnxx7vjhzUY7Q3cnl7MYGJXl3aQV30iHoEHI4
         mrqdmZx2kwnQhei9iKUjZwF2QScNSs6FQoe7JZko4TEreemXMblmXJeglCVaooJa5dcf
         5pnHN2OKhaMZIZjBwHyyMZb0dSJnCopzOf+xpNjrxluOAp+rwnHjBfz7aQ+zlV94uBkZ
         7ImULbmRFwxOE6QizGBN+LFyXyUUkse/0u6oX1j79TRhsASvAQONAzf/G5cz+1Y88YEq
         XluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=11/wTjcHLuYFAncO8Jd3+kuLG5NsXlYTTFxAWm6bKIs=;
        b=V/xVLwHwnX6oECIxCLCcFFYjGDHM7LPypoGHspoLm3/cbQPgR1CvNcpAnleofgFKtj
         4QVA9Wx6TDrPtILMNbgnY1AucKi+s42Rgi2dRX3Giwj0cnnFMpEbT8xuB6am8NcJ+eD7
         iUXaCvk2VwhUIwRpghkRv6snoFfLMVjGFlzK90p6o39K6tEidOnQnylDgQsR6edAPPLp
         SChu0hGJaUOSr7V2eXKVIzjMIgTB0+YYFxQvUdo/m4aWASPXHwxk97+74xsPY5QVvoB0
         RSRjSTPqJr8+l4gByCDEAwxzOz6ISH55ssRZi8NeeCd/6xTO0xLh7E/iA3yctDswigPx
         jnEA==
X-Gm-Message-State: AGRZ1gKRTAZxRvlZfu/RJCqydjlGtSuDFvXLX0c37K+HsK7chk+kuda9
        bihuYig5WU3kAII7362TpvvpuNj9ZJi+/bEKLX2q6A==
X-Google-Smtp-Source: AJdET5c4UlitQp3WqOM1YN+jdyhhiScb+JW0gs7YEhN4ivGWlWJzkExwcnd05Gh9UfD58lbHunGuojMKEgQbNUnB8bY=
X-Received: by 2002:a1f:cd3:: with SMTP id 202mr873433vkm.50.1542047337767;
 Mon, 12 Nov 2018 10:28:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 10:28:56
 -0800 (PST)
In-Reply-To: <CAKCAbMiHC9r54h=XeW7CkBZ1Z5eHr9MPH3Rn7KTc9DjoHG=8UA@mail.gmail.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <CAKCAbMiHC9r54h=XeW7CkBZ1Z5eHr9MPH3Rn7KTc9DjoHG=8UA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 12 Nov 2018 10:28:56 -0800
Message-ID: <CAKOZuev7zqq+xpjyDA2mSdy-zwyNjECCzLsBELF6_v1rwar_mA@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Zack Weinberg <zackw@panix.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 9:24 AM, Zack Weinberg <zackw@panix.com> wrote:
> Daniel Colascione <dancol@google.com> wrote:
>> >> If the kernel provides a system call, libc should provide a C wrapper
>> >> for it, even if in the opinion of the libc maintainers, that system
>> >> call is flawed.
>
> I would like to state general support for this principle; in fact, I
> seriously considered preparing patches that made exactly this change,
> about a year ago, posting them, and calling for objections.  Then
> $dayjob ate all my hacking time (and is still doing so, alas).
>
> Nonetheless I do think there are exceptions, such as those that are
> completely obsolete (bdflush, socketcall) and those that cannot be
> used without stomping on glibc's own data structures (set_robust_list
> is the only one of these I know about off the top of my head, but
> there may well be others).

If people want to stomp over glibc's data structures, let them. Maybe
a particular program, for whatever reason, wants to avoid glibc
mutexes entirely and do its own synchronization. It should be possible
to cleanly separate the users on a per-thread basis.

Besides, adhering to the principle that all system functionality is
provided is worth it even if (in the case of bdflush) there's not a
compelling use right now.

Consider bdflush: in kernel debugging, hijacking "useless" system
calls and setting breakpoints on them or temporarily wiring them to
custom functionality is sometimes useful, and there's no particular
reason to *prevent* a program from calling one of these routines,
especially since there's little cost to providing a wrapper and
noticeable value in completeness itself.

> Daniel Colascione <dancol@google.com> wrote:
>> We can learn something from how Windows does things. On that system,
>> what we think of as "libc" is actually two parts. (More, actually, but
>> I'm simplifying.) At the lowest level, you have the semi-documented
>> ntdll.dll, which contains raw system call wrappers and arcane
>> kernel-userland glue. On top of ntdll live the "real" libc
>> (msvcrt.dll, kernel32.dll, etc.) that provide conventional
>> application-level glue.
>
> This is an appealing idea at first sight; there are several other
> constituencies for it besides frustrated kernel hackers, such as
> alternative system programming languages (Rust, Go) that want to
> minimize dependencies on legacy "C library" functionality.   If we
> could find a clean way to do it, I would support it.
>
> The trouble is that "raw system call wrappers and arcane
> kernel-userland glue" turns out to be a lot more code, with a lot more
> tentacles in both directions, than you might think.  If you compare
> the sizes of the text sections of `ntdll.dll` and `libc.so.6` you will
> notice that the former is _bigger_.  The reason for this, as far as I
> can determine (without any access to Microsoft's internal
> documentation or source code ;-) is that ntdll.dll contains the
> dynamic linker-equivalent, a basic memory allocator, the stack
> unwinder, and a good chunk of the core thread library. (It also has
> stuff in it that's needed by programs that run early during boot and
> can't use kernel32.dll, but that's not our problem.)  I don't think
> this is an accident or an engineering compromise.  It is necessary for
> the dynamic loader to understand threads, and the thread library to
> understand shared library semantics.

Sure, but I'm not proposing talking about including threads or dynamic
library loading in the minimal kernel glue library we're discussing.
That ntdll includes this functionality (and a thread pool, and various
other gunk) works for Windows, but it's not a necessary consequence of
our adopting a layering model that the lowest of *our* layers include
what the lowest layer on Windows includes. As I mentioned above,
there's room for a "minimal" kernel interface library that actually
touches relatively little of glibc's concerns.

> A hypothetical equivalent liblinuxabi.so.1 would
> have to do the same.

It depends on what you put into the library. Basic system call
wrappers and potential future userspace glue. The ABI I'm proposing
doesn't have to look like POSIX --- for example, it can indicate error
returns via a separate out parameter. (This approach is cleaner
anyway.) As for pthread cancelation? All there's required is to mark a
range of PC values as "after cancel check, before syscall
instruction". The Linux ABI library could export a function that libc
could use, passing in a program counter value, to determine whether PC
(extracted from ucontext_t in a signal handler) were immediately
before a cancellation check.

What about off_t differences? Again, it doesn't matter. From the
*kernel's* point of view, there's one width of offset parameter per
system call per architecture. The library I'm proposing would expose
this parameter literally. If a higher-level libc wants to use a
preprocessor switch to conditionally support different offset widths,
that's fine, but there's no reason that a more literal kernel
interface library would have to do that.

> And that means you wouldn't get as much
> decoupling from the C and POSIX standards -- both of which specify at
> least part of those semantics -- as you want, and we would still be
> having these arguments.  For example, it would be every bit as
> troublesome for liblinuxabi.so.1 to export set_robust_list as it would
> be for libc.so.6 to do that.

Why? Such an exported function would cause no trouble until called,
and there are legitimate reasons for calling such a function. Not
everyone, as mentioned, wants to write a program that relies on libc.

> You might be able to get out of most of the tangle by putting the
> dynamic loader in a separate process

I don't think that's a workable approach. The creation of a separate
process is a very observable side effect, and it seems unexpected that
something as simple as cat(1) would have this side effect. If
anything, parts of the dynamic linker should move into the *kernel* to
support things like applying relocations to clean pages, but that's a
separate discussion.

> and that's _also_ an appealing
> idea for several other reasons, but it would still need to understand
> some of the thread-related data structures within the processes it
> manipulated, so I don't think it would help enough to be worth it (in
> a complete greenfields design where I get to ignore POSIX and rewrite
> the kernel API from scratch, now, that might be a different story).
>
> On a larger note, the fundamental complaint here is a project process
> / communication complaint.  We haven't been communicating enough with
> the kernel team, fair criticism.  We can do better.  But the
> communication has to go both ways.  When, for instance, we tell you
> that membarrier needs to have its semantics nailed down in terms of
> the C++17 memory model, that actually needs to happen

I think you can think of membarrier as upgrading signal fences to thread fences.

> And, because this is a process / communication problem, you cannot
> expect there to be a purely technical fix.   Your position appears,
> from where I'm sitting, to be something like "if we split glibc into
> two pieces, then you and us will never have to talk to each other
> again" which, I'm sorry, I can't see that working out in the long run.
>
>> (For example, for a long time now, I've wanted to go
>> beyond POSIX and improve the system's signal handling API, and this
>> improvement requires userspace cooperation.)
>
> This is also an appealing notion, but the first step should be to
> eliminate all of the remaining uses for asynchronous signals: for
> instance, give us process handles already!  Once a program only ever
> needs to call sigaction() to deal with
> SIGSEGV/SIGBUS/SIGILL/SIGFPE/SIGTRAP, then we can think about
> inventing a better replacement for that scenario.

I too want process handles. (See my other patches.) But that's besides
the point.

This stance in the paragraph I've quoted is another example of glibc's
misplaced idealism. As I've elaborated elsewhere, people use signals
for many purposes today. The current signals API is extremely
difficult to use correctly in a process in which multiple unrelated
components want to take advantage of signal-handling functionality.
Users deserve a cleaner, modern, and safe API. It's not productive
withhold improvements to the signal API and gate them on unrelated
features like process handles merely because, in the personal
judgement of the glibc maintainers, developers should use signals for
fewer things. This attitude is an unwarranted imposition on the entire
ecosystem. It should be possible to innovate in this area without
these blockers, one way or another.
