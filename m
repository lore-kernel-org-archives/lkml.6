Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD269C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8895D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6uYP8Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJLFMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:12:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42376 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeJLFMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:12:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id w81-v6so8314998oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsLJxfor8wh4MP1uHMCLdtfsRIyiC2Ui82itUm8oErM=;
        b=k6uYP8IqARiSLR8v24cY7FEFXlHVydL7JOqgbY4sHM0Z5WMwXeKvEqR61P7gbYfMX/
         eAFwGTa2OlrlFSmeOHTo+GsCG8W02KsGTTXxlPdAzY1G4CNDBQQNSWe7Rgge5YtOV+RG
         X/KXe2QlOsRxxzshrpcipciuHKVbB5Qlf7ugX17Dd7VbJ5dFU5SW9e5PY/y+PnOH+lq3
         726jQiUFsJlvoIeKhaBcYrIax/WCwvnYScESzyAZhL8N3VleHbm1IlMGhV1RXTChAsSp
         x6D0ovDgMjZylpQuNLJqzhnzgypX3ZOSIvZ2GrpjUkz6huNoVukYMmQeBfOXKOH30d4X
         ouJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsLJxfor8wh4MP1uHMCLdtfsRIyiC2Ui82itUm8oErM=;
        b=RmPxpLHmq0ULkXnzkQRJQ9FMsr52+EYgmHMdQ+gXj/0aT2EXxg0hi1eHQgXKlsyeXI
         hvjTcTKG2j1Dcp5PZQPJXMlanOcWDl2eGTvx7KTpbcx2U7nRa3LWPeJ35XyZyWpPR4p+
         x7qzNys+1KvBo2P2Z2Y6yR0gEKlnWNk2BFed16cV1bmIaqNF43c5FGsU7H71ZJlP/nuo
         0NryQyLoOeVMZlrAH4IyyzrYxsLGrr/XqzwkBJj1mN+Xpkgrqxyy8IWmmvKe4d+Pp8E4
         hgi/zDXW4CCBJ85hgUAQsbZtxDeQnv9HELASQ3s1v76kPfG2xEv44TiyXPAwfqBD+pby
         dIHw==
X-Gm-Message-State: ABuFfohVpMpax6Yqn16IJ+eLcFSAqEReRVeRrrhAtDNg0l39xr/ip8mX
        55rh76AKKAeymm7hUphtHUW6EpIGkwmnR05DQtPqdA==
X-Google-Smtp-Source: ACcGV63IEKPpOimqOVOPBJYXJnA1Z+yjMT3K4W/XGtU4Q3iwchZSb483a3DiEHy47PXALeqQrbTTz50ZkyylI+GTT70=
X-Received: by 2002:aca:c045:: with SMTP id q66-v6mr1950543oif.22.1539294192530;
 Thu, 11 Oct 2018 14:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com> <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
In-Reply-To: <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 11 Oct 2018 23:42:46 +0200
Message-ID: <CAG48ez0P7dq+j7gy0dbbS8aLOPC-M3rsbNPuHwXHAMh_bfSQgw@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, kristen@linux.intel.com,
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

On Thu, Oct 11, 2018 at 10:56 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Oct 11, 2018 at 1:48 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
> > <kristen@linux.intel.com> wrote:
> >>
> >> This patch aims to make it harder to perform cache timing attacks on data
> >> left behind by system calls. If we have an error returned from a syscall,
> >> flush the L1 cache.
> >>
> >> It's important to note that this patch is not addressing any specific
> >> exploit, nor is it intended to be a complete defense against anything.
> >> It is intended to be a low cost way of eliminating some of side effects
> >> of a failed system call.
> >>
> >> A performance test using sysbench on one hyperthread and a script which
> >> attempts to repeatedly access files it does not have permission to access
> >> on the other hyperthread found no significant performance impact.
> >>
> >> Suggested-by: Alan Cox <alan@linux.intel.com>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> ---
> >>  arch/x86/Kconfig        |  9 +++++++++
> >>  arch/x86/entry/common.c | 18 ++++++++++++++++++
> >>  2 files changed, 27 insertions(+)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index 1a0be022f91d..bde978eb3b4e 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -445,6 +445,15 @@ config RETPOLINE
> >>           code are eliminated. Since this includes the syscall entry path,
> >>           it is not entirely pointless.
> >>
> >> +config SYSCALL_FLUSH
> >> +       bool "Clear L1 Cache on syscall errors"
> >> +       default n
> >> +       help
> >> +         Selecting 'y' allows the L1 cache to be cleared upon return of
> >> +         an error code from a syscall if the CPU supports "flush_l1d".
> >> +         This may reduce the likelyhood of speculative execution style
> >> +         attacks on syscalls.
> >> +
> >>  config INTEL_RDT
> >>         bool "Intel Resource Director Technology support"
> >>         default n
> >> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> >> index 3b2490b81918..26de8ea71293 100644
> >> --- a/arch/x86/entry/common.c
> >> +++ b/arch/x86/entry/common.c
> >> @@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
> >>         prepare_exit_to_usermode(regs);
> >>  }
> >>
> >> +__visible inline void l1_cache_flush(struct pt_regs *regs)
> >> +{
> >> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> >> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> >> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> >> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> >> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> >> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
> >
> > What about ax > 0?  (Or more generally, any ax outside the range of -1
> > .. -4095 or whatever the error range is.)  As it stands, it looks like
> > you'll flush on successful read(), write(), recv(), etc, and that
> > could seriously hurt performance on real workloads.
>
> Seems like just changing this with "ax == 0" into "ax >= 0" would solve that?

As spender points out on twitter
(https://twitter.com/grsecurity/status/1050497259937370118 - thanks,
spender!), struct pt_regs stores register values as "unsigned long",
and so you'll need to use something like IS_ERR_VALUE().
