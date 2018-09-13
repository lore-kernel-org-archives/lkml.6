Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B594AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5329220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJsuZi25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5329220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIMXeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:34:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45942 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIMXeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:34:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so10318019oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSURC0PY0vgPVYHHz0YushTc1IoCAXgUire1vj3IPOU=;
        b=lJsuZi259B7Or1w9yNScC9CsdCIBXiLnRyijtiqrCvkgRT32lwzrfvv3BQZ6LoFeeS
         wl1X81cfMOkLOgU+2HstkVn72hfEojhFK/9RJrVCkUpmq6O18SG+LFgam6yBbYpQ+8cJ
         nxXRg6s109vm9ptxTs7J4EMKrM65Ubp5B8S7i3T+guAfwfBXDlzTnZq8Ooix9er57qH2
         NS2UBD4wWQacRdfFu/hfu5zreXmMNGiqJPZ97NTzFkXn47/2Lv8RqGmx8e6rfceFYLud
         tdHUEqeiwaH+qLYX2k7xtEhg9IlclcGgHHMnp/7scDU08ahfQu9Zla6fMmIAwAU8rlTW
         jGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSURC0PY0vgPVYHHz0YushTc1IoCAXgUire1vj3IPOU=;
        b=GfulI5ccvIGQM9S87Nc+ovba2mHZFnRHSK4vHp8DzUhASBdLT4T/1BqGIijHLzs10u
         GOOzqhYN2kdmYZBGGxfgtQrn4/PDmpZ9YVqbgplQe5cZBDgnTGQQdYtcvL/hCQZ+elUU
         XTAYTYr7Yneqb+igGUGH9iiYiFieUiQdQ9UjWi/82+kjvlwe2BWi3cH3AEMDzXav6Xbl
         kaA+nn5gr4Z9MiEnX5bjX2AmFtgU86yFJOTjHE8Wsb/nuYkPH1WtyyW6gCSDXo/BSJmY
         4ViQQIGleKcOe6dn9jTEfj0+c9ciEaWSiZGeix41cbb7l4JSsXvJGLLSaHO4Ddkm3Ry4
         iqIQ==
X-Gm-Message-State: APzg51Bkd1oCRjT8L5CrufmqmkYyYZhCaHnYGGnCzcZencpQJDIwrHho
        7OOMg6mwyShQaOj9bNuc3zo2ZkCg6jv4WVU6RmERmw==
X-Google-Smtp-Source: ANB0VdZGbcHNfl1f7VvRckQZ6vQGx+2dGiVi/NLDVcwfmiPxL0e0eclzaKa48Hm3/7+OsVDHvgA03xy8DmlUUaaioOQ=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr7402261oif.348.1536863009984;
 Thu, 13 Sep 2018 11:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535462971.git.andreyknvl@google.com> <f5e73b5ead3355932ad8b5fc96b141c3f5b8c16c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aEwYiaVN--RH_0VBh0wbCcrf-Ndz+_eOaBNi6nKxrfQA@mail.gmail.com>
 <CAG48ez2oT1dtDcH8SfPLnoX5F8d6Pd=M-eOKHhYJ83EuL_j6wQ@mail.gmail.com>
 <CACT4Y+avu_68GoQcc32zpcOpAu-Pw7m71VmuKtEkOw=vKgxi7w@mail.gmail.com> <CAKwvOdns=3bktpXLEpo6o0J8OQPym6YE+x6Dvs_kYSBsuJKtSw@mail.gmail.com>
In-Reply-To: <CAKwvOdns=3bktpXLEpo6o0J8OQPym6YE+x6Dvs_kYSBsuJKtSw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Sep 2018 20:23:03 +0200
Message-ID: <CAG48ez2AoEiFdLH2aLSjxdkdFbBT1PimOByaWbFykObTA2yqKg@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] khwasan, arm64: add brk handler for inline instrumentation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, dave.martin@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>, geert@linux-m68k.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kbuild@vger.kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>, Ramana.Radhakrishnan@arm.com,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben.Ayrapetyan@arm.com, Mark Brand <markbrand@google.com>,
        cpandya@codeaurora.org, Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 8:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 13, 2018 at 1:37 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Sep 12, 2018 at 7:39 PM, Jann Horn <jannh@google.com> wrote:
> > > On Wed, Sep 12, 2018 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > [...]
> > >> > +static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
> > >> > +{
> > >> > +       bool recover = esr & KHWASAN_ESR_RECOVER;
> > >> > +       bool write = esr & KHWASAN_ESR_WRITE;
> > >> > +       size_t size = KHWASAN_ESR_SIZE(esr);
> > >> > +       u64 addr = regs->regs[0];
> > >> > +       u64 pc = regs->pc;
> > >> > +
> > >> > +       if (user_mode(regs))
> > >> > +               return DBG_HOOK_ERROR;
> > >> > +
> > >> > +       kasan_report(addr, size, write, pc);
> > >> > +
> > >> > +       /*
> > >> > +        * The instrumentation allows to control whether we can proceed after
> > >> > +        * a crash was detected. This is done by passing the -recover flag to
> > >> > +        * the compiler. Disabling recovery allows to generate more compact
> > >> > +        * code.
> > >> > +        *
> > >> > +        * Unfortunately disabling recovery doesn't work for the kernel right
> > >> > +        * now. KHWASAN reporting is disabled in some contexts (for example when
> > >> > +        * the allocator accesses slab object metadata; same is true for KASAN;
> > >> > +        * this is controlled by current->kasan_depth). All these accesses are
> > >> > +        * detected by the tool, even though the reports for them are not
> > >> > +        * printed.
> > >> > +        *
> > >> > +        * This is something that might be fixed at some point in the future.
> > >> > +        */
> > >> > +       if (!recover)
> > >> > +               die("Oops - KHWASAN", regs, 0);
> > >>
> > >> Why die and not panic? Die seems to be much less used function, and it
> > >> calls panic anyway, and we call panic in kasan_report if panic_on_warn
> > >> is set.
> > >
> > > die() is vaguely equivalent to BUG(); die() and BUG() normally only
> > > terminate the current process, which may or may not leave the system
> > > somewhat usable, while panic() always brings down the whole system.
> > > AFAIK panic() shouldn't be used unless you're in some very low-level
> > > code where you know that trying to just kill the current process can't
> > > work and the entire system is broken beyond repair.
> > >
> > > If KASAN traps on some random memory access, there's a good chance
> > > that just killing the current process will allow at least parts of the
> > > system to continue. I'm not sure whether BUG() or die() is more
> > > appropriate here, but I think it definitely should not be a panic().
> >
> >
> > Nick, do you know if die() will be enough to catch problems on Android
> > phones? panic_on_warn would turn this into panic, but I guess one does
> > not want panic_on_warn on a canary phone.
>
> die() has arch specific implementations, so looking at:
>
> arch/arm64/kernel/traps.c:196#die
>
> it looks like panic is invoked if in_interrupt() or panic_on_oops(),
> which is a configure option.  So maybe the config for KHWASAN should
> also enable that? Otherwise seems easy to forget.  But maybe that
> should remain configurable separately?

In the upstream kernel, it is desirable to be able to discover bugs
and debug them from inside the running system. When you detect a bug
that makes it impossible for the current task to continue safely,
you're supposed to use something like BUG() to terminate the task; if
you can continue safely, you're supposed to use WARN(). Either way,
you should *not* just shoot down the whole kernel unless the system is
corrupted so badly that trying to keep running would be pointless.

You can configure the kernel such that it crashes the device when such
an event occurs, and doing so can sometimes be beneficial; but please
don't hardcode such policies into the upstream kernel.
