Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8975204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd7QEylc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8975204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJPAnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:43:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46499 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJPAnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:43:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id k64-v6so15616526oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U15UCWqeHrXpD32qORNBO3YAafTTCD25I7l7dRG+9Kw=;
        b=rd7QEylceDOP38EQkHleqnfZghKqxc1KIcOKw7vev+zEbd4lwSX3TpSnaEA8TKmQSD
         F7KxvJ0HHbuEcs4SZ2IxqLX//aQNXMQed1ezCZpibOHXqoM8PLF8N07dPelqxTcNwGk1
         d954XW9mnZ9ualKzn8v8/S19GxbBEIPZgVacCpLOn/ma4oJY1EUxRDKkqqSZVtPRTCx+
         KZ/zGMhMyIvj9ryjU9p3Oiv85kCdeRlhVSdTRnBeeIgJ5TnU+HJFawqS3k1czz3maACw
         NuuLvDLKAyw+2tx4zM2+4DybiJmHBO2M7ZUHV9vXdZDUFm409mdqRdQctdI8wqQeJTTA
         sTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U15UCWqeHrXpD32qORNBO3YAafTTCD25I7l7dRG+9Kw=;
        b=MIGSKpvOdvXYqy9kVnt83zuNGCbgX0c/NtK/glHxkKQqsQ21zfVLEgyYUu+JuNBw5c
         9HgWK2QLhZya1yIy8V9NGl3Xha761B6wql8bE3Wa669NqfRiOlPbO25JkHzZwBiQ4cBa
         LzxV5z2rfg/2j93OAfNeCaJgjApAu/aeZ9XoWsDT5zWrchzUJRuhTWojiR6bZlvyYeFH
         hcxCeZBIGfGyZ6zE6qwZX5IdbdQkds4BEV3eUwOcEs0BnexUSGnRwlUiPq7tXJ5m06gp
         dR1ggaeAss5Th51ERS9dqJoTInbIHkr0XLBkSGbn9XIOBaVL0qW3qMU3tqvYJy/EBd1+
         xl4g==
X-Gm-Message-State: ABuFfohxUtf41nx9RSZcpXxx6JN43pcsvze7BhDZNoTK1DAtZewWBVYp
        22JVTs+vyTtB2letY/646IuDN6O2F8z7MZx0eaU=
X-Google-Smtp-Source: ACcGV63zfUG5XnofDmrbiisz9eH12OtNM2i20tpB8JnzU8eG7RpS6AOxPeXFewPCec11OOGOdixShXUT/5kSPJKT7kc=
X-Received: by 2002:aca:6b45:: with SMTP id g66-v6mr10103273oic.273.1539622647971;
 Mon, 15 Oct 2018 09:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox> <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox> <20181015153144.buuow3yof2njjzjm@treble> <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
In-Reply-To: <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
Date:   Mon, 15 Oct 2018 09:57:16 -0700
Message-ID: <CAH7mPvhgVgt+N=5pi-tGNWbitzcteSp5JOvNuMYoKFgxyrqRTQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
To:     luto@amacapital.net
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>, luto@kernel.org,
        dave.hansen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 9:03 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> On Mon, Oct 15, 2018 at 8:31 AM Josh Poimboeuf <jpoimboe@redhat.com> wrot=
e:
> >
> > On Mon, Oct 15, 2018 at 08:22:21AM -0700, Nathan Chancellor wrote:
> > > > >>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned =
long error_code,
> > > > >>>                 * and then double-fault, though, because we're =
likely to
> > > > >>>                 * break the console driver and lose most of the=
 stack dump.
> > > > >>>                 */
> > > > >>> -               asm volatile ("movq %[stack], %%rsp\n\t"
> > > > >>> +               asm volatile (UNWIND_HINT_SAVE
> > > > >>> +                             "movq %[stack], %%rsp\n\t"
> > > > >>>                              "call handle_stack_overflow\n\t"
> > > > >>> -                             "1: jmp 1b"
> > > > >>> +                             "1: jmp 1b\n\t"
> > > > >>> +                             UNWIND_HINT_RESTORE
> > > > >>>                              : ASM_CALL_CONSTRAINT
> > > > >>>                              : "D" ("kernel stack overflow (pag=
e fault)"),
> > > > >>>                                "S" (regs), "d" (address),
> > > > >>
> > > > >> NAK.  Just below this snippet is unreachable();
> > > > >>
> > > > >> Can you reply with objtool -dr output on a problematic fault.o? =
 Josh,
> > > > >> it *looks* like annotate_unreachable() should be doing the right
> > > > >> thing, but something is clearly busted.
> > > > >>
> > > > >> Also, shouldn't compiler-clang.h contain a reasonable definition=
 of
> > > > >> unreachable()?
> > > > >>
> > > > >> --Andy
> > > > >
> > > > > Hi Andy,
> > > > >
> > > > > Did you mean 'objdump -dr'? If so, here you go (rather long, sorr=
y if I
> > > > > should have pasted it here instead):
> > > > > https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5=
503e
> > > > >
> > > > >
> > > >
> > > > Hmm, -dr wasn=E2=80=99t quite enough to dump the .discard bits, ass=
uming they=E2=80=99re there at all. Can you just put the whole .o file some=
where?
> > >
> > > Here you go: https://nathanchance.me/downloads/.tmp/fault.o
> >
> > $ eu-readelf -S /tmp/fault.o  |grep reachable
> > [12] .discard.reachable   PROGBITS     0000000000000000 00002bc0 000000=
14  0        0   0  1
> > [13] .rela.discard.reachable RELA         0000000000000000 00002bd8 000=
00078 24 I     32  12  8
> >
> > That confirms that you need a clang version of the unreachable() macro.
> >
>
> Duh.
>
> That being said, the generic macro is:
>
> # define unreachable() do { annotate_reachable(); do { } while (1); } whi=
le (0)
>
> I'm probably missing some subtlety here, but shouldn't that be
> annotate_*un*reachable()?
>
> Of course, there are any number of reasons why there should be a real
> definition.  Nathan and Nick, does adding something like:
>
> #define unreachable() \
>         do {                                    \
>                 annotate_unreachable();         \
>                 __builtin_unreachable();        \
>         } while (0)
>
> to compiler-clang.h fix the problem?

I broke this myself in commit 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
Thanks for the suggestion, will verify then send a patch with your
suggested by tag.  Thanks everyone for helping us sort this out!
