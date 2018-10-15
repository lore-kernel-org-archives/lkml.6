Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19ACC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D73208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LDQPbA9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D73208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJOXtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:49:45 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52706 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:49:44 -0400
Received: by mail-wm1-f53.google.com with SMTP id 189-v6so19485784wmw.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oQgMQdrQGzXtmSBk07HhUnic5I/7MhYtrGTZQul9tJA=;
        b=LDQPbA9lG9xaCGb5wQcAh2HBFRVRv7CSW1MbPMCQ88NSSD4ZogrS/dEn1U5H2bq6o9
         dPa2/5CULgdfV5AkyHEVcVgLHigzAAkDI1/mYM/sraQBMP7Z/7aMsbdYHWta+XPrQ/CY
         AftWJSaj+HbGxmFlGi9Jn0fh0jhQipALjB/SrBizW/uull5206Sjj47p/+5t4Ja3eO1Z
         TSm9ZhD2qoL7SxgvwT5GIkW/zLnTFXHARfXsx3/SVGv6Xg0/b3u89JXGBGzyaZlI7PdG
         W1G16yvpu2k48kHJGwiVxe1sVzktual7JUJYukSbR9i6MIPRavUxs9A7/0Ku9hv/JPni
         miYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oQgMQdrQGzXtmSBk07HhUnic5I/7MhYtrGTZQul9tJA=;
        b=tx6cjbkIXhH6QkofGZYLAgryC+9PP07R1kd848XH9neps3v4WegevulwS5FhI7CXmQ
         i5wgYnJch0CMNArqh/SB+F4q5hm05sLOKc7R75LGWN69UA+2kLwSZIURTTirUpVoEPrg
         kvBB/TCePpjy5VWt1ONVPI6e6NXW6rNIN78FHCrEBURRSiRK9r2ytBwFKTT/IHIZK24Z
         /FaeOglkorqwDYcb584bAQ2SKCr0K+wganTQXCQ5S7yMQWzGeeaR/YYY+xMfgP57XLBv
         YRjWW75lZ7BFFEwd2yk+7uyjk3QEcY94jmK/CXYALOBZw1TjbUwNtOcACXNSV0OaO3jx
         fyQA==
X-Gm-Message-State: ABuFfoh0aPJ2d0X+dqr7T27pL8RbuCg/6vAQvhoE8+JUGUSV0XE2xMxG
        1hwvbhK+1Q6g7iyRJNxKG4FPITuvwEAFKS2zK5o1gQ==
X-Google-Smtp-Source: ACcGV60StXEvYcz+8A+Y/Jm2W7gIrJ3pNVMCKlXgwzp3I9gIic+gCOp5ZqQmVzpqi3DGU38mCRS1L3VMiVDA2Slu2xQ=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr13408872wmd.128.1539619431716;
 Mon, 15 Oct 2018 09:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox> <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox> <20181015153144.buuow3yof2njjzjm@treble>
In-Reply-To: <20181015153144.buuow3yof2njjzjm@treble>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 15 Oct 2018 09:03:40 -0700
Message-ID: <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     natechancellor@gmail.com, Andrew Lutomirski <luto@kernel.org>,
        nick.desaulniers@gmail.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:31 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Oct 15, 2018 at 08:22:21AM -0700, Nathan Chancellor wrote:
> > > >>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned lo=
ng error_code,
> > > >>>                 * and then double-fault, though, because we're li=
kely to
> > > >>>                 * break the console driver and lose most of the s=
tack dump.
> > > >>>                 */
> > > >>> -               asm volatile ("movq %[stack], %%rsp\n\t"
> > > >>> +               asm volatile (UNWIND_HINT_SAVE
> > > >>> +                             "movq %[stack], %%rsp\n\t"
> > > >>>                              "call handle_stack_overflow\n\t"
> > > >>> -                             "1: jmp 1b"
> > > >>> +                             "1: jmp 1b\n\t"
> > > >>> +                             UNWIND_HINT_RESTORE
> > > >>>                              : ASM_CALL_CONSTRAINT
> > > >>>                              : "D" ("kernel stack overflow (page =
fault)"),
> > > >>>                                "S" (regs), "d" (address),
> > > >>
> > > >> NAK.  Just below this snippet is unreachable();
> > > >>
> > > >> Can you reply with objtool -dr output on a problematic fault.o?  J=
osh,
> > > >> it *looks* like annotate_unreachable() should be doing the right
> > > >> thing, but something is clearly busted.
> > > >>
> > > >> Also, shouldn't compiler-clang.h contain a reasonable definition o=
f
> > > >> unreachable()?
> > > >>
> > > >> --Andy
> > > >
> > > > Hi Andy,
> > > >
> > > > Did you mean 'objdump -dr'? If so, here you go (rather long, sorry =
if I
> > > > should have pasted it here instead):
> > > > https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd550=
3e
> > > >
> > > >
> > >
> > > Hmm, -dr wasn=E2=80=99t quite enough to dump the .discard bits, assum=
ing they=E2=80=99re there at all. Can you just put the whole .o file somewh=
ere?
> >
> > Here you go: https://nathanchance.me/downloads/.tmp/fault.o
>
> $ eu-readelf -S /tmp/fault.o  |grep reachable
> [12] .discard.reachable   PROGBITS     0000000000000000 00002bc0 00000014=
  0        0   0  1
> [13] .rela.discard.reachable RELA         0000000000000000 00002bd8 00000=
078 24 I     32  12  8
>
> That confirms that you need a clang version of the unreachable() macro.
>

Duh.

That being said, the generic macro is:

# define unreachable() do { annotate_reachable(); do { } while (1); } while=
 (0)

I'm probably missing some subtlety here, but shouldn't that be
annotate_*un*reachable()?

Of course, there are any number of reasons why there should be a real
definition.  Nathan and Nick, does adding something like:

#define unreachable() \
        do {                                    \
                annotate_unreachable();         \
                __builtin_unreachable();        \
        } while (0)

to compiler-clang.h fix the problem?

--Andy
