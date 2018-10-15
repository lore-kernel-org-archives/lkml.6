Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3524C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6622089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGPBK2mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6622089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOXII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:08:08 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36699 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeJOXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:08:08 -0400
Received: by mail-wm1-f48.google.com with SMTP id a8-v6so20008420wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y1VfnFGwCv0ySMyMdQcTkAYnhJ4OYown2fCIIp61nbY=;
        b=ZGPBK2mKffyL7uPrhO70FBP/TDHvMfeLwKRMlK5hd+DslhBGFcmUdq8hqJtF8hWuxQ
         Vxxn3pPI87Y+CeCF+j04EBr4Kzyz8LR5+B5QwlC9oV5NL/kMphIF9D071MYpMLRJxecQ
         hY2h02PFNfETuTgsm8nD4oQ/ZcvCt0aWL5zr9LmPDDmdX2oHSttiQXqYgfDpnNCEwH0O
         OwywMNG1DtLeFfm2aVC84mCeM79iEeO5xt41Dvb1MyFDafYTzHTPOWTcEBTan4qH5V3Y
         ueRjWlgU1jEmwk6C6XZTmcPvTvS/opo/QxENcbqFLOrrqYNCPqoPgsqdlOTIP08XxlOR
         ZTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y1VfnFGwCv0ySMyMdQcTkAYnhJ4OYown2fCIIp61nbY=;
        b=XdTOFEC+5l0GcGqKC4l2vXyMZIxP9I8xZTRdPhEnltBTzLFr1m+J1dezKYgm9hj5U6
         USAtc4PyQpEYAKao515+dR1lqZI45eCUJKiKeQRC1WnHZ000tcGxApEWjQ1Hl1FrSFR5
         rCsZyWYny0kcoBUemL0ZwjfkXGXnTd4yllEi3tCd4cvt3GGuJDMKTH9GB9yV2kSQmrjA
         4/1JAaD98sVf2EpklmWO23Mh8iuIyFM1uDR/8FU9+qDJdSO5wowadj/Ro9hfDSKo8T8E
         nl2X4cBTmRdLGvLjII8dsFG1NgY/lcl3ZyGsk/L6JU7M15WT0UIwW/UgJ7bIGjmJrvlR
         e0QQ==
X-Gm-Message-State: ABuFfoiTTCG2RXGCJCvlbAOWMSGPFqbCMk5RAzvy7NTRs9tvosdACQi2
        j6zy2zbhm1FdFj/YsgVAlnE=
X-Google-Smtp-Source: ACcGV60NzSLY/S6wAMQlYugkMSr2ZGpd7tIU++3Au8y8JhU1wHthPCVGbHQq8QXslTphH5+casI92A==
X-Received: by 2002:a1c:d04e:: with SMTP id h75-v6mr14003619wmg.92.1539616944228;
        Mon, 15 Oct 2018 08:22:24 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l140-v6sm11099199wmb.24.2018.10.15.08.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 08:22:23 -0700 (PDT)
Date:   Mon, 15 Oct 2018 08:22:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, nick.desaulniers@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
Message-ID: <20181015152221.GA16375@flashbox>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com>
 <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com>
 <20181015051705.GA20687@flashbox>
 <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:34:14AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Oct 14, 2018, at 10:17 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > 
> >> On Sun, Oct 14, 2018 at 08:43:18PM -0700, Andy Lutomirski wrote:
> >> On Sun, Oct 14, 2018 at 5:37 PM Nick Desaulniers
> >> <nick.desaulniers@gmail.com> wrote:
> >>> 
> >>> Fixes the objtool warning:
> >>> arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
> >>> instruction
> >>> 
> >>> Link: https://github.com/ClangBuiltLinux/linux/issues/204
> >>> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> >>> ---
> >>> arch/x86/mm/fault.c | 6 ++++--
> >>> 1 file changed, 4 insertions(+), 2 deletions(-)
> >>> 
> >>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> >>> index 47bebfe6efa7..057d2178fa19 100644
> >>> --- a/arch/x86/mm/fault.c
> >>> +++ b/arch/x86/mm/fault.c
> >>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> >>>                 * and then double-fault, though, because we're likely to
> >>>                 * break the console driver and lose most of the stack dump.
> >>>                 */
> >>> -               asm volatile ("movq %[stack], %%rsp\n\t"
> >>> +               asm volatile (UNWIND_HINT_SAVE
> >>> +                             "movq %[stack], %%rsp\n\t"
> >>>                              "call handle_stack_overflow\n\t"
> >>> -                             "1: jmp 1b"
> >>> +                             "1: jmp 1b\n\t"
> >>> +                             UNWIND_HINT_RESTORE
> >>>                              : ASM_CALL_CONSTRAINT
> >>>                              : "D" ("kernel stack overflow (page fault)"),
> >>>                                "S" (regs), "d" (address),
> >> 
> >> NAK.  Just below this snippet is unreachable();
> >> 
> >> Can you reply with objtool -dr output on a problematic fault.o?  Josh,
> >> it *looks* like annotate_unreachable() should be doing the right
> >> thing, but something is clearly busted.
> >> 
> >> Also, shouldn't compiler-clang.h contain a reasonable definition of
> >> unreachable()?
> >> 
> >> --Andy
> > 
> > Hi Andy,
> > 
> > Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
> > should have pasted it here instead):
> > https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e
> > 
> > 
> 
> Hmm, -dr wasn’t quite enough to dump the .discard bits, assuming they’re there at all. Can you just put the whole .o file somewhere?

Here you go: https://nathanchance.me/downloads/.tmp/fault.o

Thanks,
Nathan
