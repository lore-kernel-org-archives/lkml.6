Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1208887-1526322498-2-12383024991029350583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526322497; b=LhiEQyinQq0VPLF2TvjxTbXVpaLDXXrRkgPhmmmEdzXFRf6EJc
    eUz3OhOQmlGNeCwCCfQNYGD/vKgSjrc583KpqNE/kTylIAX/Ec7X1Tf9SqM0UyXH
    Zw11YzYZzfp7ytp800UFvMv2uREgJP21WpNpAwSZrrLcaOmb6IKEjbfzTdwW9Zcj
    PZHgb+NmcUQGpmZmvbJRqRlwBCMLmyy5Rsg/CSrmSp36RLgHY1fW8gxxqfNnfr9I
    Hpdbro06jr+JgEA49UYgsLQORdWhNXtdHX88uC5iSi2I+kjFl0LRduU+vLuzXmt8
    1jh/e/vN/CdHAMsMzyEiTOswR9ElNKzyeSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526322497;
    bh=5QVanLjjcZGdGt7jK85tm/7yL7FshO101u1mQ8VarbQ=; b=hm1mhpX/ueg4
    J3Tw6ldX7X0xSs6OLZo78tA+wKYfKkYKfylyY+m0YgbTvMb9l4Sc/mA2T1sqtlK/
    EnuPeiY1NvWsx66Mzn/htmRh1Rq3nhM0pCd89d2jK8fUpI8Fl6fhpZ5UwAB83iN7
    jqaJJECoZhHbaCCyqOHJCRsOOeh2IdEA7xZDkWRCmrfBDahvPzYi1llTPxt7TxjO
    cx7jrU02gFn9uTIRvN9lTPN3zkxfaK7S3nHLWIEb1YCiIOODeMED6E9TCtY/uhlh
    kcrOYczFHUni3z9OGst7ovnUQ0R9xejTRR48fn+rMpiQa8aBQC+N67opNWmpTsGX
    rJSFXJl2bw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=KD6rjFnz
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=eiUisaxB x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=k/jH6uA3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=KD6rjFnz
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=eiUisaxB x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=k/jH6uA3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhbO7cTVpUG16Zb8ZyC/GWUraa+o/dtGVQ3fmljhif1ZBLW0WTYnelFMyQJHiwJ4hoC6UW/aLbcdW2D7P/YE7HQ9mxqr+L1bP3vYgHSSPc/gLF6tOQ+
    T9OaURpotB+pKw2YE9aZr6J39AFHyDYBuIPboY0SER91L38kiv4+nQOfFFgylo14udez8VzU0ELG1qOnTZ8ubIlgs43WyJgptTcv/WtM+lXkIpAeBILdJHeR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=ZwWzS1e9TrTYFEMpdfAA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENS2P (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 14:28:15 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35828 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENS2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 14:28:13 -0400
X-Google-Smtp-Source: AB8JxZrNZKUwkwzydYy/iDaWQIlE3llRXWsuCq83eLQPKQvWKQuch4i3k2yL+6wIXOZ8W3ORLwoXVA51ZM6gkNkpv8k=
MIME-Version: 1.0
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 14 May 2018 11:28:11 -0700
X-Google-Sender-Auth: X5emqKj_1N0K0sroZBDvfxFpMns
Message-ID: <CAGXu5j+5n278z-+V3yOPyqyqqwRGGf4zkXzbGjhq9FQ6JgqZRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] prctl: Modernise wiring for optional prctl() calls
To: Dave Martin <Dave.Martin@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Hogan <jhogan@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 10:14 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> [Reviewer note: this is a cross-arch series.  To reduce spam, I have
> tried not to Cc people on patches they aren't likely to care about.
> The complete series can be found in the LKML or linux-arch archives.]
>
> The core framework for the prctl() syscall is unloved and looking
> rather crusty these days.  It also relies on defining ancillary
> boilerplate macros for each prctl() in order to control conditional
> compilation of the different prctl calls.  We have better ways to
> do this now.

This is a nice clean-up series, thanks! Some thoughts/comments below...

> This series attempts to modernise the code by defining a couple of new
> Kconfig variables HAVE_PRCTL_ARCH and HAVE_ARCH_PR_SET_GET_UNALIGN to
> allow architectures to provide hooks for arch-dependent prctls.
>
>
> For now this series has had minimal testing: some basic testing of
> arch-specific prctls using PR_SVE_SET_VL on arm64; build-tested on
> x86; otherwise untested.
>
> This is not polished yet... but I'm interested to know what people
> think about the approach.

I'm not entirely convinced the removal of the "task not current"
interface is very useful as I've found myself needing to adjust other
interfaces like this to _add_ the "task not current" logic, but ... I
can't really argue very hard for keeping the task args since nothing
is using them... meh.

I dislike this being named "prctl_arch" when everything else like this
is "arch_foo...", but I do see the collision with the x86-specific
"arch_prctl" syscall. Perhaps it might be better to wire things up
differently, since x86's arch_prctl is actually "sys_arch_prctl" so I
don't think there would be a symbol collision, and maybe the 9 options
could be added to the global prctl list, with the x86 syscall getting
called at the end of the new "arch_prctl"? Then the syscall could get
deprecated in favor of just using prctl directly?

Your new x86 arch_prctl (ne=C3=A9 prctl_arch) could be something like:

int arch_prctl(int option, unsigned long arg2, unsigned long arg3,
                     unsigned long arg4, unsigned long arg5)
{
... existing stuff in your series ...
    case ARCH_SET_GS:
    case ARCH_SET_FS:
    case ARCH_GET_GS:
    case ARCH_GET_FS:
    case ARCH_MAP_VDSO_X32:
    case ARCH_MAP_VDSO_32:
    case ARCH_MAP_VDSO_64:
        if (arg3 || arg4 || arg5)
            return -EINVAL;
        return do_arch_prctl_64(current, option, arg2);
    case ARCH_GET_CPUID:
    case ARCH_SET_CPUID:
        if (arg3 || arg4 || arg5)
            return -EINVAL;
        return do_arch_prctl_common(current, option, arg2);
    default:
        return -EINVAL;
    }
}

Or maybe all the logic could get ripped out of
arch/x86/kernel/process*.c and put in arch/x86/kernel/sys.c directly?

Perhaps this is all overkill, but I find it rather annoying that one
arch's weird syscall would block "expected" naming of a cross-arch
interface...

-Kees

--=20
Kees Cook
Pixel Security
