Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8424C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6738B20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="v7VCPbMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6738B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeJOWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:19:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42284 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeJOWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:19:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so9395436plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpZkYp1Yf6YBX/Aa7c+FCQ2Rb3agjYTIhO0baQKGCDY=;
        b=v7VCPbMjQgH/Vma5a8LLRjcJPzlcai9+lQisdF85II8koTl2IbBph0xYzr7/OqG0pX
         ewpDIPuasF9rDpbs7qFT/zkVyUCo1gMJcBJLIL22pIRsT4wBDYUkDOYaZr5aLWNPX9gC
         pq82HQZMCTF5uCPf/Dk4R/Cu5MA4HTVORKIsvqwIzOVxvF1VQA+6O+gFAuvPuOVXO39h
         cythAaxngsaJURCet7aMeIvXB15nwG9+BFVj4ZmEdBzntZAT2EgCnaEvEspm+0FhqCLW
         sCWUoONaKBMj9OdW5yh0mRuojGnr8b5GuSmBfW9qXSDaQFnvnwe2b0aTJnvz6/vzUMXe
         3KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpZkYp1Yf6YBX/Aa7c+FCQ2Rb3agjYTIhO0baQKGCDY=;
        b=CLIUTuo+GV17N6fx0C1C0k3tAsWWBoTUsmbs8ZO1u2ySXpi9aPYJVVgDz94ErZ28HL
         OJHocFwbNdAwybGg1OmIQNWymk40R704OEfhgEvUYbTTxIQFTMmFfrOLTRZi/HX+IrZh
         lYTgy2K9z5syToFaQamNGUmw0hPf4daVkI5ov7xPlTW3aA65I+4w8S/dJjSJpSdIoNmH
         vR77dc42HBWTeUw8P1SrR8OSvM/L277+uoNjUEPUZ3+z+XAkup/9XyVDfl9zT+4VPcfK
         rS3kBCx5IQ1TqJH+FCnzTzhW0QFa8YRBPW5zyXAEKkwfDM369BPxMCxIaSpbs9K9ldiP
         xqnw==
X-Gm-Message-State: ABuFfojj+Nkx0Ej5eTP7Df+emdaziQsNVvWnxAwr+giMnE5/ew+vPfRo
        3RBuUcapHrLamhXBG6MnXB7abA==
X-Google-Smtp-Source: ACcGV611/wGQjWj6GlEAw1jZi9sGocDG+BKSVi375rD04LCym2tYbVUMVPvrSeJH1BtaN2IOoqDElA==
X-Received: by 2002:a17:902:7142:: with SMTP id u2-v6mr17528297plm.154.1539614056020;
        Mon, 15 Oct 2018 07:34:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:256b:27ea:55f0:e526? ([2601:646:c200:7429:256b:27ea:55f0:e526])
        by smtp.gmail.com with ESMTPSA id x73-v6sm15333631pfk.139.2018.10.15.07.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 07:34:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/mm: annotate no_context with UNWIND_HINTS
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181015051705.GA20687@flashbox>
Date:   Mon, 15 Oct 2018 07:34:14 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, nick.desaulniers@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CCAF5D3-1B11-43BF-93E4-72C2603A184F@amacapital.net>
References: <20181015003726.29103-1-nick.desaulniers@gmail.com> <CALCETrUZoBtxoR9u=72CSmNa-793EZySMd7TjH_BmHcrNSvLZg@mail.gmail.com> <20181015051705.GA20687@flashbox>
To:     Nathan Chancellor <natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 14, 2018, at 10:17 PM, Nathan Chancellor <natechancellor@gmail.com>=
 wrote:
>=20
>> On Sun, Oct 14, 2018 at 08:43:18PM -0700, Andy Lutomirski wrote:
>> On Sun, Oct 14, 2018 at 5:37 PM Nick Desaulniers
>> <nick.desaulniers@gmail.com> wrote:
>>>=20
>>> Fixes the objtool warning:
>>> arch/x86/mm/fault.o: warning: objtool: no_context()+0x220: unreachable
>>> instruction
>>>=20
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/204
>>> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
>>> ---
>>> arch/x86/mm/fault.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index 47bebfe6efa7..057d2178fa19 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -760,9 +760,11 @@ no_context(struct pt_regs *regs, unsigned long erro=
r_code,
>>>                 * and then double-fault, though, because we're likely to=

>>>                 * break the console driver and lose most of the stack du=
mp.
>>>                 */
>>> -               asm volatile ("movq %[stack], %%rsp\n\t"
>>> +               asm volatile (UNWIND_HINT_SAVE
>>> +                             "movq %[stack], %%rsp\n\t"
>>>                              "call handle_stack_overflow\n\t"
>>> -                             "1: jmp 1b"
>>> +                             "1: jmp 1b\n\t"
>>> +                             UNWIND_HINT_RESTORE
>>>                              : ASM_CALL_CONSTRAINT
>>>                              : "D" ("kernel stack overflow (page fault)"=
),
>>>                                "S" (regs), "d" (address),
>>=20
>> NAK.  Just below this snippet is unreachable();
>>=20
>> Can you reply with objtool -dr output on a problematic fault.o?  Josh,
>> it *looks* like annotate_unreachable() should be doing the right
>> thing, but something is clearly busted.
>>=20
>> Also, shouldn't compiler-clang.h contain a reasonable definition of
>> unreachable()?
>>=20
>> --Andy
>=20
> Hi Andy,
>=20
> Did you mean 'objdump -dr'? If so, here you go (rather long, sorry if I
> should have pasted it here instead):
> https://gist.github.com/nathanchance/f038bb0a6653b975bb8a4e64fcd5503e
>=20
>=20

Hmm, -dr wasn=E2=80=99t quite enough to dump the .discard bits, assuming the=
y=E2=80=99re there at all. Can you just put the whole .o file somewhere?=
