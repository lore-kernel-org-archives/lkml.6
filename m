Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F422320880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KUeV38Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F422320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIMXU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:20:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40681 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeIMXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:20:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so3028365pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgCd5KWNArSaahfEACcUksSlQesS/ri13zV231U9jh8=;
        b=KUeV38Lk7h/W/yeGS0gEvNKJfB2g2X3YSV+YfZ0ND7tzhFJYdha4at0RkOgei6BPI2
         4/D9P7W/yno4StkeGHe9JElnT/7+rO1Bmp6ysNMjIVSik+ziZ33ICqjilfYJWe7poqNn
         0ypPQzK9phiQp0113bkmaRbJ5I13UJC3QglTkSuG2OTax71w8HmvaXfsmE6xbIjbGNEW
         W7sAK2G9RGv+3t84N/uvvHxw//YhfKZYG6c3oCIadylUqOgI/W/jmpFJzmyiAwcTfgQz
         T6m0rBHM0blkyrI30WqVUGctf5ah0ls/eUfoycI25vI6MGmIKSrmQAlYTI+k/xLgXUDW
         +tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgCd5KWNArSaahfEACcUksSlQesS/ri13zV231U9jh8=;
        b=fF66McHWyqKHojDp2gxuq4e07z0jvc97Hf0AEFbh5ocxa8f+E63GsmJ1jaDeYYspE3
         9Xl41u6+SmT+dKBthk+LixWG00C/EmJqYp7tDqdkZQI2rWTqZC9/HmdgB25b77CqPZHF
         HQXGY1MgBNQR2ZoShVzhMy1Qgk9am0xZGDHyJMaUo4WbQrJq5NGh0f9rvzYwCxqfjEi7
         vzoWC7a+VvMww/iQxzUwzbk77xLGGIjJ8SNCMWLt1rDKFGXWf7pxxBK2mFwQbhjx9SBb
         m3VQPntblSs28suvAiGgJErprOzQgm4NnzehpO1E6ElE5fDeZuzmy1A/7WbQT0jGh4Ny
         Jmow==
X-Gm-Message-State: APzg51AWiX+FbpODRvkjj+y8LiMeSxSqXLhjTw5xFtOefF1lvBf/ByON
        E2IJ4BT1KxjGhLWgQUM/rI/RtdARY3sBDm+htMaz6Q==
X-Google-Smtp-Source: ANB0VdZVYOfoEqn4b+0RE3qYMSOLw0f4YUxskDFOkw818B2PU48bFUJ0jHS3C1tQNzJZWPjOfMtXir5WPrxIQ4W1vm0=
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr8623315pfd.32.1536862191311;
 Thu, 13 Sep 2018 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535462971.git.andreyknvl@google.com> <f5e73b5ead3355932ad8b5fc96b141c3f5b8c16c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aEwYiaVN--RH_0VBh0wbCcrf-Ndz+_eOaBNi6nKxrfQA@mail.gmail.com>
 <CAG48ez2oT1dtDcH8SfPLnoX5F8d6Pd=M-eOKHhYJ83EuL_j6wQ@mail.gmail.com> <CACT4Y+avu_68GoQcc32zpcOpAu-Pw7m71VmuKtEkOw=vKgxi7w@mail.gmail.com>
In-Reply-To: <CACT4Y+avu_68GoQcc32zpcOpAu-Pw7m71VmuKtEkOw=vKgxi7w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Sep 2018 11:09:39 -0700
Message-ID: <CAKwvOdns=3bktpXLEpo6o0J8OQPym6YE+x6Dvs_kYSBsuJKtSw@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] khwasan, arm64: add brk handler for inline instrumentation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 1:37 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Sep 12, 2018 at 7:39 PM, Jann Horn <jannh@google.com> wrote:
> > On Wed, Sep 12, 2018 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > [...]
> >> > +static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
> >> > +{
> >> > +       bool recover = esr & KHWASAN_ESR_RECOVER;
> >> > +       bool write = esr & KHWASAN_ESR_WRITE;
> >> > +       size_t size = KHWASAN_ESR_SIZE(esr);
> >> > +       u64 addr = regs->regs[0];
> >> > +       u64 pc = regs->pc;
> >> > +
> >> > +       if (user_mode(regs))
> >> > +               return DBG_HOOK_ERROR;
> >> > +
> >> > +       kasan_report(addr, size, write, pc);
> >> > +
> >> > +       /*
> >> > +        * The instrumentation allows to control whether we can proceed after
> >> > +        * a crash was detected. This is done by passing the -recover flag to
> >> > +        * the compiler. Disabling recovery allows to generate more compact
> >> > +        * code.
> >> > +        *
> >> > +        * Unfortunately disabling recovery doesn't work for the kernel right
> >> > +        * now. KHWASAN reporting is disabled in some contexts (for example when
> >> > +        * the allocator accesses slab object metadata; same is true for KASAN;
> >> > +        * this is controlled by current->kasan_depth). All these accesses are
> >> > +        * detected by the tool, even though the reports for them are not
> >> > +        * printed.
> >> > +        *
> >> > +        * This is something that might be fixed at some point in the future.
> >> > +        */
> >> > +       if (!recover)
> >> > +               die("Oops - KHWASAN", regs, 0);
> >>
> >> Why die and not panic? Die seems to be much less used function, and it
> >> calls panic anyway, and we call panic in kasan_report if panic_on_warn
> >> is set.
> >
> > die() is vaguely equivalent to BUG(); die() and BUG() normally only
> > terminate the current process, which may or may not leave the system
> > somewhat usable, while panic() always brings down the whole system.
> > AFAIK panic() shouldn't be used unless you're in some very low-level
> > code where you know that trying to just kill the current process can't
> > work and the entire system is broken beyond repair.
> >
> > If KASAN traps on some random memory access, there's a good chance
> > that just killing the current process will allow at least parts of the
> > system to continue. I'm not sure whether BUG() or die() is more
> > appropriate here, but I think it definitely should not be a panic().
>
>
> Nick, do you know if die() will be enough to catch problems on Android
> phones? panic_on_warn would turn this into panic, but I guess one does
> not want panic_on_warn on a canary phone.

die() has arch specific implementations, so looking at:

arch/arm64/kernel/traps.c:196#die

it looks like panic is invoked if in_interrupt() or panic_on_oops(),
which is a configure option.  So maybe the config for KHWASAN should
also enable that? Otherwise seems easy to forget.  But maybe that
should remain configurable separately?

Looking at the kernel configs for the Pixel 2, it does seem like
CONFIG_PANIC_ON_OOPS=y is already enabled.
https://android.googlesource.com/kernel/msm/+/android-msm-wahoo-4.4-pie/arch/arm64/configs/wahoo_defconfig#746

Specifically to catch problems on Android, our internal debug builds
can report on panics, but not oops, IIUC.
-- 
Thanks,
~Nick Desaulniers
