Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE5C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566B32075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xviTRG/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566B32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935732AbeFRWEF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755347AbeFRWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:04:02 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDAC208B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529359442;
        bh=EgMUHLSiJ4/XpvIZGrIqYv8hCWRH6gxKr0Dd3LaUnx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xviTRG/o+1lvnwrUfjTKvdXhaIibw+YBMMPZT7dGST20FCItAhfxPUHgznhp6YvPf
         zRtqfTAp0RsEP+KhQ4nUhsnbnlS7p4AM74tWSF3zq9R/57geVTgHXVGv6NerF+ggi9
         H0E+hHl9E9MzI6iTZOKaRX8oqNdleEAzOZGtX3ZQ=
Received: by mail-wm0-f44.google.com with SMTP id j15-v6so18431128wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:04:01 -0700 (PDT)
X-Gm-Message-State: APt69E1dNmf8G0upOOTp6mjAFGqOgHrhKZSFWbefEcIaVyDxGoXUhh3f
        dCc6EN+HBpeazV0gXEBhv5iB+PEvW4DWnAKIHrKO/Q==
X-Google-Smtp-Source: ADUXVKJE5TBUk6GBto2ujStmxmBQTLmkrI2HejpsnH4zvQphIX7MFVYLIYx5krYDUNHV4/g1mGBWX/ejSuauKL+yOyg=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr10383654wma.21.1529359439972;
 Mon, 18 Jun 2018 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com> <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de> <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
In-Reply-To: <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 15:03:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
Message-ID: <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     "H. J. Lu" <hjl.tools@gmail.com>, Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 12:34 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Tue, Jun 12, 2018 at 11:59 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 12 Jun 2018, H.J. Lu wrote:
> >> On Tue, Jun 12, 2018 at 9:34 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > On Tue, Jun 12, 2018 at 9:05 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >> >> On Tue, Jun 12, 2018 at 9:01 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >> >> > On Tue, Jun 12, 2018 at 4:43 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >> >> >> On Tue, Jun 12, 2018 at 3:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >> >> > That works for stuff which loads all libraries at start time, but what
> >> >> >> > happens if the program uses dlopen() later on? If CET is force locked and
> >> >> >> > the library is not CET enabled, it will fail.
> >> >> >>
> >> >> >> That is to prevent disabling CET by dlopening a legacy shared library.
> >> >> >>
> >> >> >> > I don't see the point of trying to support CET by magic. It adds complexity
> >> >> >> > and you'll never be able to handle all corner cases correctly. dlopen() is
> >> >> >> > not even a corner case.
> >> >> >>
> >> >> >> That is a price we pay for security.  To enable CET, especially shadow
> >> >> >> shack, the program and all of shared libraries it uses should be CET
> >> >> >> enabled.  Most of programs can be enabled with CET by compiling them
> >> >> >> with -fcf-protection.
> >> >> >
> >> >> > If you charge too high a price for security, people may turn it off.
> >> >> > I think we're going to need a mode where a program says "I want to use
> >> >> > the CET, but turn it off if I dlopen an unsupported library".  There
> >> >> > are programs that load binary-only plugins.
> >> >>
> >> >> You can do
> >> >>
> >> >> # export GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK
> >> >>
> >> >> which turns off shadow stack.
> >> >>
> >> >
> >> > Which exactly illustrates my point.  By making your security story too
> >> > absolute, you'll force people to turn it off when they don't need to.
> >> > If I'm using a fully CET-ified distro and I'm using a CET-aware
> >> > program that loads binary plugins, and I may or may not have an old
> >> > (binary-only, perhaps) plugin that doesn't support CET, then the
> >> > behavior I want is for CET to be on until I dlopen() a program that
> >> > doesn't support it.  Unless there's some ABI reason why that can't be
> >> > done, but I don't think there is.
> >>
> >> We can make it opt-in via GLIBC_TUNABLES.  But by default, the legacy
> >> shared object is disallowed when CET is enabled.
> >
> > That's a bad idea. Stuff has launchers which people might not be able to
> > change. So they will simply turn of CET completely or it makes them hack
> > horrible crap into init, e.g. the above export.
> >
> > Give them sane kernel options:
> >
> >      cet = off, relaxed, forced
> >
> > where relaxed allows to run binary plugins. Then let dlopen() call into the
> > kernel with the filepath of the library to check for CET and that will tell
> > you whether its ok or or not and do the necessary magic in the kernel when
> > CET has to be disabled due to a !CET library/application.
> >
> > That's also making the whole thing independent of magic glibc environment
> > options and allows it to be used all over the place in the same way.
>
> This is very similar to our ARCH_CET_EXEC proposal which controls how
> CET should be enforced.   But Andy thinks it is a bad idea.
>

I do think it's a bad idea to have a new piece of state that survives
across exec().  It's going to have nasty usability problems and nasty
security problems.

We may need a mode by which glibc can turn CET *back off* even after a
program had it on if it dlopens() an old binary.  Or maybe there won't
be demand.  I can certainly understand why the CET_LOCK feature is
there, although I think we need a way to override it using something
like ptrace().  I'm not convinced that CET_LOCK is really needed, but
someone who understand the thread model should chime in.

Kees, do you know anyone who has a good enough understanding of
usermode exploits and how they'll interact with CET?

--Andy
