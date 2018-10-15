Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD9C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AB82089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h80M5mmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AB82089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOXxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:53:33 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43103 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeJOXxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:53:33 -0400
Received: by mail-wr1-f51.google.com with SMTP id n1-v6so22004282wrt.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4xyGCUgRtTRSPXV7Q4n7nLnDvP62TxhiFCNIh1ZlZyA=;
        b=h80M5mmyHy9GSyFgcuEkYV0Fuv7Jk306wwMhhgyA40ddRBXLoLEmMJYas+hjfB2Tvt
         UOf7c2Ty+twEvZF1UbBHjJ7GYm5j4+i3qq4P0cQFNn2MLblz/BfopXE/zJSvXn3bwaSm
         QayPL1gdVM14a3qO6QRTJ1GqxEkfs7vGDUt5v+1XmlWWK8ptRQQ0ETdeRSRmrIcOufCF
         RvblfMYgTUloVEtPlDqKkHCohUtCHni5jqEGkxOYy0ZidwNNnfzVGjTUii61Ko8JCBTH
         Fu7IU/pviZkFq7IJquuz0XpwLjkY2MAtvwY65qNYCTbvjtkVo4wuA0QWl8FIsll012/W
         XPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4xyGCUgRtTRSPXV7Q4n7nLnDvP62TxhiFCNIh1ZlZyA=;
        b=OG551sdGu8r3MAeLdwKhJ56bYUWgnwBfuooHec+MfMa6SSqM0s+Bph8uoMFzbP+VTE
         yf1tQ950vRGBl63jXfy7wLa69z10WvR7ecFdHJOXnMCoILA+H/IekFmdkDMR0ye1K0qo
         BSt6UhvEgiln3xM8Upr4zSYWbwJXG7jlaIwSXYhOE6/vRZpOusjIg2fav9hIH9NB2WaE
         eczwL1tHCyOxk15EoRQj+ZBMTsmUuj80h4ueqwPfdmedouAo8nc1VPSGW55h/+BtVLUb
         Q/Nun2YrYXjegmTph2vYJAkEMV8+3HWS+WBuy6RlJGSVXf2q+yr3aqi+nwxhncACtKjP
         Qx2Q==
X-Gm-Message-State: ABuFfoiRZHYRjnlh4MHtQ1V+/CqLnd+l5KikxJukcbzzDaaOfPk7waZX
        ekujbfgzqtGNZzx/ubp4vj8=
X-Google-Smtp-Source: ACcGV62k9CAmDQ3SKlcs2qm5ofZkfeK4qejPrLn1cxoLCmOHF6oePDLhbMP49ku9ml5z+5pHeTOHng==
X-Received: by 2002:adf:bf11:: with SMTP id p17-v6mr2440514wrh.235.1539619659256;
        Mon, 15 Oct 2018 09:07:39 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z185-v6sm16361347wmz.47.2018.10.15.09.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:07:38 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:07:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        nick.desaulniers@gmail.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015160736.GA20997@flashbox>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox>
 <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
 <20181015152221.GA16375@flashbox>
 <20181015153144.buuow3yof2njjzjm@treble>
 <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWtgjxSZOg=hqGe3hDDvpuBDZtjptHFDAuHYOaxs1CO_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 09:03:40AM -0700, Andy Lutomirski wrote:
> On Mon, Oct 15, 2018 at 8:31 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Oct 15, 2018 at 08:22:21AM -0700, Nathan Chancellor wrote:
> > > > >>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > > > >>>                 * and then double-fault, though, because we're likely to
> > > > >>>                 * break the console driver and lose most of the stack dump.
> > > > >>>                 */
> > > > >>> -               asm volatile ("movq %[stack], %%rsp\n\t"
> > > > >>> +               asm volatile (UNWIND_HINT_SAVE
> > > > >>> +                             "movq %[stack], %%rsp\n\t"
> > > > >>>                              "call handle_stack_overflow\n\t"
> > > > >>> -                             "1: jmp 1b"
> > > > >>> +                             "1: jmp 1b\n\t"
> > > > >>> +                             UNWIND_HINT_RESTORE
> > > > >>>                              : ASM_CALL_CONSTRAINT
> > > > >>>                              : "D" ("kernel stack overflow (page fault)"),
> > > > >>>                                "S" (regs), "d" (address),
> > > > >>
> > > > >> NAK.  Just below this snippet is unreachable();
> > > > >>
> > > > >> Can you reply with objtool -dr output on a problematic fault.o?  Josh,
> > > > >> it *looks* like annotate_unreachable() should be doing the right
> > > > >> thing, but something is clearly busted.
> > > > >>
> > > > >> Also, shouldn't compiler-clang.h contain a reasonable definition of
> > > > >> unreachable()?
> > > > >>
> > > > >> --Andy
> > > > >
> > > > > Hi Andy,
> > > > >
> > > > > Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
> > > > > should have pasted it here instead):
> > > > > https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e
> > > > >
> > > > >
> > > >
> > > > Hmm, -dr wasn’t quite enough to dump the .discard bits, assuming they’re there at all. Can you just put the whole .o file somewhere?
> > >
> > > Here you go: https://nathanchance.me/downloads/.tmp/fault.o
> >
> > $ eu-readelf -S /tmp/fault.o  |grep reachable
> > [12] .discard.reachable   PROGBITS     0000000000000000 00002bc0 00000014  0        0   0  1
> > [13] .rela.discard.reachable RELA         0000000000000000 00002bd8 00000078 24 I     32  12  8
> >
> > That confirms that you need a clang version of the unreachable() macro.
> >
> 
> Duh.
> 
> That being said, the generic macro is:
> 
> # define unreachable() do { annotate_reachable(); do { } while (1); } while (0)
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
> 
> --Andy

Ha, I was just typing out a message summarizing that that exact
definition fixed this warning.

Nathan
