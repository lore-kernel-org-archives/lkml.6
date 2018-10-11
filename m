Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A954EC67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517F62087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="motUVxQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517F62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJLFlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:41:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40889 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLFlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:41:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so8364543oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//OURvPaW5q0j/SlQTkXfgB0hxyBnM0nx3QuhykYVU4=;
        b=motUVxQBrDYBI6922YGu5RCZT3ndjaqWv2Kiddu0Kpe/3LBCo4q2wLQZUUlxvownNL
         buLdVAucWDzuOjPScF4RbwqE5tBgrI2Mf2t9tyebb3+/nZb/SjhG+2JCBXG0w+FAtxw6
         OV0FvpC1OAgfEQgCOAh07UU50bkl7YS4HgEW12xS/BFL9USKKIYjztV/T+uTku4TuIpi
         +ZnFMZ7d6xfvZrA1X2uuh3eFAesU+1nzO0EW4ZoPphGsVbfHWwr51R4XsPb01EyKppiA
         NmJMOhjGDsWpfJdliqDXBPk9defMKSAuwgEP8ikCaRcl+nAqJZz+wpkse4Ar8aaDVd5F
         xbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//OURvPaW5q0j/SlQTkXfgB0hxyBnM0nx3QuhykYVU4=;
        b=g1juWLoD0Ndx+cY1Gsts0CcXHAJCuTgxOuML34c/TJ+/DTkqvtPKATVFHj3pv5wcwX
         OoxqUliYIv74nm+nWZa2bjCVaedc11n2wJcJ5K0KdFiZTiJPJ/PRSvH7WCklpxmu43ET
         vFojRWOs+ARbzkIaJ27LWC+aYyJ4vsACbwkO3uqt4TI6lu2SKmbWQg9fLAWpfQC+yACz
         CC/V4meEIGXY0inPtbtU+e3l4IBwyZkQH1fIQ0zzt4vP7a/hlU66dOhr9KBPRpJKIXDr
         YUsHHJFM0/VBm2I4Pbl0wcJ1h2NNOiA6FB4/n0S16n0JEfI+toJ+O8pqwEj5gbJrsCW5
         /qug==
X-Gm-Message-State: ABuFfoiYGwTqwnnnkmUO/ODL5tAS+p0UYXyw/RdjMNtI4+lEV6sbX4Ck
        wEoVXkXtk5+UF1oL0+kovyTTE2JSzdtTUtsblQfrnA==
X-Google-Smtp-Source: ACcGV61sfoIUms5H+SczEAO1K1zrokC3V+RXQJPCxyo1rDwcYnrR7SUBsW+0yP9OfLee7hJKdGwfxlFpxi9iZpHS+rM=
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr1852992oih.3.1539295905729;
 Thu, 11 Oct 2018 15:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
 <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com> <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
In-Reply-To: <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 12 Oct 2018 00:11:19 +0200
Message-ID: <CAG48ez1TNd5eJCE=x6LeqGO3x2E1rn244xqc2ccnZ3wmeP05XA@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, kristen@linux.intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:17 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Oct 11, 2018 at 1:55 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Oct 11, 2018 at 1:48 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
> > > <kristen@linux.intel.com> wrote:
> > >>
> > >> This patch aims to make it harder to perform cache timing attacks on data
> > >> left behind by system calls. If we have an error returned from a syscall,
> > >> flush the L1 cache.
> > >>
> > >> It's important to note that this patch is not addressing any specific
> > >> exploit, nor is it intended to be a complete defense against anything.
> > >> It is intended to be a low cost way of eliminating some of side effects
> > >> of a failed system call.
> > >>
> > >> A performance test using sysbench on one hyperthread and a script which
> > >> attempts to repeatedly access files it does not have permission to access
> > >> on the other hyperthread found no significant performance impact.
> > >>
> > >> Suggested-by: Alan Cox <alan@linux.intel.com>
> > >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > >> ---
> > >>  arch/x86/Kconfig        |  9 +++++++++
> > >>  arch/x86/entry/common.c | 18 ++++++++++++++++++
> > >>  2 files changed, 27 insertions(+)
> > >>
> > >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > >> index 1a0be022f91d..bde978eb3b4e 100644
> > >> --- a/arch/x86/Kconfig
> > >> +++ b/arch/x86/Kconfig
> > >> @@ -445,6 +445,15 @@ config RETPOLINE
> > >>           code are eliminated. Since this includes the syscall entry path,
> > >>           it is not entirely pointless.
> > >>
> > >> +config SYSCALL_FLUSH
> > >> +       bool "Clear L1 Cache on syscall errors"
> > >> +       default n
> > >> +       help
> > >> +         Selecting 'y' allows the L1 cache to be cleared upon return of
> > >> +         an error code from a syscall if the CPU supports "flush_l1d".
> > >> +         This may reduce the likelyhood of speculative execution style
> > >> +         attacks on syscalls.
> > >> +
> > >>  config INTEL_RDT
> > >>         bool "Intel Resource Director Technology support"
> > >>         default n
> > >> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > >> index 3b2490b81918..26de8ea71293 100644
> > >> --- a/arch/x86/entry/common.c
> > >> +++ b/arch/x86/entry/common.c
> > >> @@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
> > >>         prepare_exit_to_usermode(regs);
> > >>  }
> > >>
> > >> +__visible inline void l1_cache_flush(struct pt_regs *regs)
> > >> +{
> > >> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> > >> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> > >> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> > >> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> > >> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> > >> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
> > >
> > > What about ax > 0?  (Or more generally, any ax outside the range of -1
> > > .. -4095 or whatever the error range is.)  As it stands, it looks like
> > > you'll flush on successful read(), write(), recv(), etc, and that
> > > could seriously hurt performance on real workloads.
> >
> > Seems like just changing this with "ax == 0" into "ax >= 0" would solve that?
>
> I can easily imagine that there are other errors for which performance
> matters.  EBUSY comes to mind.
>
> >
> > I think this looks like a good idea. It might be worth adding a
> > comment about the checks to explain why those errors are whitelisted.
> > It's a cheap and effective mitigation for "unknown future problems"
> > that doesn't degrade normal workloads.
>
> I still want to see two pieces of information before I ack a patch like this:
>
>  - How long does L1D_FLUSH take, roughly?

(Especially if L1D is dirty and you can't just wipe it all.)

>  - An example of a type of attack that would be mitigated.
>
> For the latter, I assume that the goal is to mitigate against attacks
> where a syscall speculatively loads something sensitive and then
> fails.  But, before it fails, it leaks the information it
> speculatively loaded, and that leak ended up in L1D but *not* in other
> cache levels.  And somehow the L1D can't be probed quickly enough in a
> parallel thread to meaningfully get the information out of L1D.

And the attacker can't delay the syscall return somehow, e.g. on a
fully-preemptible kernel by preempting the syscall, or by tarpitting a
userspace memory access in the error path.

> Or
> maybe it's trying to mitigate against the use of failing syscalls to
> get some sensitive data into L1D and then using something like L1TF to
> read it out.
>
> But this really needs to be clarified.  Alan said that a bunch of the
> "yet another Spectre variant" attacks would have been mitigated by
> this patch.  An explanation of *how* would be in order.
>
> And we should seriously consider putting this kind of thing under
> CONFIG_SPECULATIVE_MITIGATIONS or similar.  The idea being that it
> doesn't mitigate a clear known attack family.
