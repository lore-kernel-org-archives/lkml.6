Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE0CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2613D20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDUeEFhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2613D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIMNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:45:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34457 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeIMNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:45:48 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so1168210ita.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Bb2A5n9HnIKxxiAYVSOIkWwld1KVWNHVDF2g+uXCCM=;
        b=pDUeEFhdU3zyhg1x/HiI0W40JAo8WB6SaePlNyo8Q0n0V/q7tljZewVt2zTb4bq/xI
         MeT4IY7fqyJhiSJ/gr44MUgCFAkCz/PWQuaE5JHdKHNfNZ0Y8wTo5s7okWcbHhdz6dVq
         Niu7d2qmciT/wAlXFO3kbI9Q8JDMcWEL90exZVIruYcyGk/x6GuQOG6L4y7ZD0L7fgB9
         IrhCzO38rx8QlFqc6Vz35yF7UO5w7bx3EKO69D99ARAyuEbRlmrFQMlJ6ekhVmQYywJM
         6wlYnlASoI34Qk5Ptf+olmJ4ka7wfm/zD4tQ2iPbFzDPq/lav+saA1jtaPkswb1CbIKr
         2T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Bb2A5n9HnIKxxiAYVSOIkWwld1KVWNHVDF2g+uXCCM=;
        b=RrJ9C4KglYHj+JaOCE7/h+ic5p2+P1GiP+gPQJ6AaHK/tV0oZIwf+C6lt0Ogls/cbe
         U6hXFDsbvEUiCVr5oN6jCtUGhz4JdSltPs9Fh3hx4HUTeKpOJAwMkqkRjDPbXgoqS/Un
         jAh+uuf58Soe2VdAF2hEuXP4x3BCcKo6iFRQOy4QpFNS0Rm2VU7ACGVDKZuVj1iszmOW
         fwarXgA3cdTEuk1F2DX8/2Z14xFPZEnX86Kg5W5hrM44h9968uBMAh+bmuEL9Ojkwz8M
         0SJsnQxROfe7xEw2f5JjVmqoeCBDajDGPSa44vRSop+l6tblRNC27mjc+NdOBwT3bdgZ
         ijKw==
X-Gm-Message-State: APzg51DRASuOkMcw8oFZFfoMc+kHfU3qv2/UnUPXQj5UbHQq4rf33ePi
        g/RHf781NNGR8BX4mmTh4DU0F4UAoBB47SWjMS8+1A==
X-Google-Smtp-Source: ANB0VdYcmxf7OZhQotgjLkFTdL4h4ljh5jDVkU/4X7vMHzZYyDFzjYTfm91uFkN3hCc9V3yXzXUXA9iH+sf/CAOba00=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr5701091jaa.19.1536827840777;
 Thu, 13 Sep 2018 01:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 01:37:00
 -0700 (PDT)
In-Reply-To: <CAG48ez2oT1dtDcH8SfPLnoX5F8d6Pd=M-eOKHhYJ83EuL_j6wQ@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <f5e73b5ead3355932ad8b5fc96b141c3f5b8c16c.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aEwYiaVN--RH_0VBh0wbCcrf-Ndz+_eOaBNi6nKxrfQA@mail.gmail.com> <CAG48ez2oT1dtDcH8SfPLnoX5F8d6Pd=M-eOKHhYJ83EuL_j6wQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Sep 2018 10:37:00 +0200
Message-ID: <CACT4Y+avu_68GoQcc32zpcOpAu-Pw7m71VmuKtEkOw=vKgxi7w@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] khwasan, arm64: add brk handler for inline instrumentation
To:     Jann Horn <jannh@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
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

On Wed, Sep 12, 2018 at 7:39 PM, Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 12, 2018 at 7:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> [...]
>> > +static int khwasan_handler(struct pt_regs *regs, unsigned int esr)
>> > +{
>> > +       bool recover = esr & KHWASAN_ESR_RECOVER;
>> > +       bool write = esr & KHWASAN_ESR_WRITE;
>> > +       size_t size = KHWASAN_ESR_SIZE(esr);
>> > +       u64 addr = regs->regs[0];
>> > +       u64 pc = regs->pc;
>> > +
>> > +       if (user_mode(regs))
>> > +               return DBG_HOOK_ERROR;
>> > +
>> > +       kasan_report(addr, size, write, pc);
>> > +
>> > +       /*
>> > +        * The instrumentation allows to control whether we can proceed after
>> > +        * a crash was detected. This is done by passing the -recover flag to
>> > +        * the compiler. Disabling recovery allows to generate more compact
>> > +        * code.
>> > +        *
>> > +        * Unfortunately disabling recovery doesn't work for the kernel right
>> > +        * now. KHWASAN reporting is disabled in some contexts (for example when
>> > +        * the allocator accesses slab object metadata; same is true for KASAN;
>> > +        * this is controlled by current->kasan_depth). All these accesses are
>> > +        * detected by the tool, even though the reports for them are not
>> > +        * printed.
>> > +        *
>> > +        * This is something that might be fixed at some point in the future.
>> > +        */
>> > +       if (!recover)
>> > +               die("Oops - KHWASAN", regs, 0);
>>
>> Why die and not panic? Die seems to be much less used function, and it
>> calls panic anyway, and we call panic in kasan_report if panic_on_warn
>> is set.
>
> die() is vaguely equivalent to BUG(); die() and BUG() normally only
> terminate the current process, which may or may not leave the system
> somewhat usable, while panic() always brings down the whole system.
> AFAIK panic() shouldn't be used unless you're in some very low-level
> code where you know that trying to just kill the current process can't
> work and the entire system is broken beyond repair.
>
> If KASAN traps on some random memory access, there's a good chance
> that just killing the current process will allow at least parts of the
> system to continue. I'm not sure whether BUG() or die() is more
> appropriate here, but I think it definitely should not be a panic().


Nick, do you know if die() will be enough to catch problems on Android
phones? panic_on_warn would turn this into panic, but I guess one does
not want panic_on_warn on a canary phone.
