Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE76C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE80320824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSNsmafb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE80320824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410238AbeKXHBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:01:38 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44506 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410222AbeKXHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:01:38 -0500
Received: by mail-vs1-f66.google.com with SMTP id g68so7804372vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cR54/n7KNZUihlscX6wIjCxZtCWGWQoq6nR0dzcOMhc=;
        b=LSNsmafbz/cqU1318m/c1DHeeuV8f3aYr84Ptd5U1aVzXab1qwqEcGpR5tcVtT1bOf
         5WKmNQVF1vFN9VSDS9V+aLtq2+3go2m2gQEwbjxDGMsFpdmwfThDLIuNwG4B+ikRudfw
         v6C6hIG9zL1TGPS7XAlb04JccRGv9ie97teXyspbIWl/kTegoiupIgsfO4eGkboznHhd
         w6H1Hm8RLKGITPQ2Xegw9uTAwuWtAXgsVn7lxBCNsze5PqpI6KEd670LYXZfzV9hwX6z
         jP6OqZTZbzlm7+Ou6pSgKrCqRVAzDFUejLH88e0JJlauCrOh+5Vy9aBdgp+AqvECA9Nw
         un7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cR54/n7KNZUihlscX6wIjCxZtCWGWQoq6nR0dzcOMhc=;
        b=CiH+pE2vXhY8RTQwhY8VbL5rmqrZlXX5aQgOZwOK9yhuRW7qpmTJDompF0KwRDa91r
         f8dLeN98P21ByGdRqRejcvgp98bHNo3li3hrePNiKWAoRzGP8Thvk6TSNe5Xda1guLF5
         mV74DdECJ279zVtLwGv+C4iYd+lbcVmrH7pKrXNOo7GPq+gBBb+SYimjtSCAet0TNfCx
         njpucszosZqlSi6GEtCZ7eo651N+unT83fZxr2p0RQjm3gitCnxgMZvHF3sCMRqAaP2H
         Wh2zT82R2XDXnu7tpIm6aV2GdwkGOvF5WDJEIYQeMk+nHtkT5eMekGiV7M7LArme7giY
         KQUQ==
X-Gm-Message-State: AGRZ1gL28SmSWPPhm14OdXti3742+KNtGk7QtDgTQAWkEj0VRsPFY4KM
        7+YjZ1K6+e88vgxBcpiD6FmrsRBio6G9Tmr9kiHVIw==
X-Google-Smtp-Source: AJdET5c/JkK5rZpn3O75Q4B7SzfhrQB6pxbcBOZifPPaaJ/nxqrcdeXG4mATLxO120ofSLMlgb/ZBKmH1D60tvVvhfs=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr7532640vsc.171.1543004152014;
 Fri, 23 Nov 2018 12:15:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <87efbbvrx9.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87efbbvrx9.fsf@oldenburg.str.redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 23 Nov 2018 12:15:39 -0800
Message-ID: <CAKOZuesFZqstO-9K2tLQ1sOOmYsN73QdTHNG0De0a=eq5BT99w@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Nov 23, 2018 at 5:34 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Daniel Colascione:
>
> > On Mon, Nov 12, 2018 at 12:11 AM, Florian Weimer <fweimer@redhat.com> wrote:
> >> * Daniel Colascione:
> >>
> >>> If the kernel provides a system call, libc should provide a C wrapper
> >>> for it, even if in the opinion of the libc maintainers, that system
> >>> call is flawed.
> >>
> >> It's not that simple, I think.  What about bdflush?  socketcall?
> >> getxpid?  osf_gettimeofday?  set_robust_list?
> >
> > What about them? Mentioning that these system calls exist is not in
> > itself an argument.
>
> But socketcall does not exist on all architectures.  Neither does
> getpid, it's called getxpid on some architectures.

So what? On systems on which a given system call does not exist,
attempts to link against that system call should fail, or attempts to
make that system call should fail at runtime with ENOSYS. That's
completely expected and unsurprising behavior, not some unavoidable
source of catastrophic confusion.

> >> There are quite a few irregularities
> >
> > So?
>
> I think it would be a poor approach to expose application developers to
> these portability issues.  We need to abstract over these differences at
> a certain layer, and applications are too late.

And glibc is too early. The purpose of the lowest-level user library
is not to provide an OS-agnostic portability layer. There are other
projects much better-suited to providing portability, including the
excellent GLib, Gnulib, and Qt. The purpose of the lowest-level user
library is to expose the interfaces of the underlying system, whatever
they are. That's a basic tenet of layered interface design.

Due to historical accident, the same library (on most Linux systems)
serves as both the lowest-level user library and an implementation of
some antiquated portability constructs from ANSI C and POSIX. That
this library provides these old portability interfaces is not a reason
for that library to neglect its responsibility as the lowest-level
system interface library. If people find that every attempt to expose
even trivial new kernel interfaces turns into an endless trek through
a swamp of specious objection (see the gettid debacle), then it
becomes perfectly reasonable to find an alternate route over firmer
ground.

Other glibc developers (e.g., Joseph Myers) have expressed support for
adding long-missing system call wrappers, like gettid, as long as the
functions are adequately documented. Would you make a sustained
objection to these additions?

> >> and some editorial discretion appears to be unavoidable.
> >
> > That's an assertion, not an argument, and I strongly disagree. *Why*
> > do you think "editorial discretion" is unavoidable?
>
> We do not want application authors to write code which uses socketcall,

That's an opinion on portability, not an argument for the necessity of
"editorial discretion". That you think an application calling
socketcall would somehow be a bad idea is not a justification for not
providing this interface. Low-level libraries must focus on mechanism,
not policy, if a system is to be flexible enough to accommodate
unanticipated needs.
