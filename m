Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7784721470
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCgYNp60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeJBRVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:21:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38007 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeJBRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:21:54 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so2922282ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ea9SXhHUzm/a89JkR9gBbWg+QeaocdDvJibIvKKnlaM=;
        b=TCgYNp60VQTCjrGS8h8/MrKd72y5KW8gBAyRJ7rvjlcY9HeDRwUG+6pSphWB6f715U
         /E+apfYzoaKrhkZWA+h1hx3NCMncYhbw4+jUE9GSr+lvS60WFY9s5NC3i39bN3pGoN6N
         +G0ywiMI84eLQBC7gdhDWyaBkXhl4pMnnHpzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ea9SXhHUzm/a89JkR9gBbWg+QeaocdDvJibIvKKnlaM=;
        b=Crl1pNf76Qi0l0cwzmGDuw7BjxeUuM4lWDPB/6P1bPOVH8R2A+wGelOe7urS+lLkae
         Wl3t8cc5B5ruxuQPmgG8XshT9M8KkXXPvxIA/MYA9JIMq37x0WGIC6k9C4y/4qVF5hOm
         YH5DvOTc5X6MUaWR8+xyUoHqdik31SkBCZO61xcKSMwHSjUuwrK+B2l06yraw9alOF84
         SS3RMFcpHxgodViUG/3l3hgkh82BD4o63wwQTr0eW6SKkB0P7blX0oZjBVgZDQ9+0PpY
         gS/ggmFea/nJq6g6RK3R10BpbhEpkFc0K297bSpEosQn3960Fj2T0lco86CRCE8YVQeH
         2htw==
X-Gm-Message-State: ABuFfojb+tPx7GqobWrfV40ER0muiepufBcQdaDt9agn/MJK4sgfRxG7
        g5qZtSgBfPK7xE5BFVNwvgQNCrZhCPDI5SKzGxDwNg==
X-Google-Smtp-Source: ACcGV62gzH/7msovgySac5oy/jxdIz24HUquDll4mJ4+SXcyFvtYuzFmgRe39GFBlH42UO0w+RWfYknyyaAIyQpmiXw=
X-Received: by 2002:a24:e48e:: with SMTP id o136-v6mr1374965ith.58.1538476756080;
 Tue, 02 Oct 2018 03:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 03:39:15 -0700 (PDT)
In-Reply-To: <20181002100223.GA2398@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141648.1DBED68BDF@newverein.lst.de>
 <CAKv+Gu8ji7fz_-THmvd-wvod3LqrtBQq4g38UTuo+ke+NZfE9w@mail.gmail.com> <20181002100223.GA2398@lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 12:39:15 +0200
Message-ID: <CAKv+Gu8QO1V=k_51EsFS7BuQiHM=5Dpta2mt-vboJ=H6uPjeHA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 12:02, Torsten Duwe <duwe@lst.de> wrote:
> On Mon, Oct 01, 2018 at 05:57:52PM +0200, Ard Biesheuvel wrote:
>> > --- a/arch/arm64/include/asm/ftrace.h
>> > +++ b/arch/arm64/include/asm/ftrace.h
>> > @@ -16,6 +16,17 @@
>> >  #define MCOUNT_ADDR            ((unsigned long)_mcount)
>> >  #define MCOUNT_INSN_SIZE       AARCH64_INSN_SIZE
>> >
>> > +/* DYNAMIC_FTRACE_WITH_REGS is implemented by adding 2 NOPs at the beginning
>> > +   of each function, with the second NOP actually calling ftrace. In contrary
>> > +   to a classic _mcount call, the call instruction to be modified is thus
>> > +   the second one, and not the only one. */
>>
>> OK, so the first slot will be patched unconditionally to do the 'mov x9, x30' ?
>
> Right.
>
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +#define ARCH_SUPPORTS_FTRACE_OPS 1
>> > +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
>> > +#else
>> > +#define REC_IP_BRANCH_OFFSET 0
>> > +#endif
>
> The main reason for above comment was that a previous reviewer wondered
> about a magic value of "4" for the REC_IP_BRANCH_OFFSET, which is actually
> an insn size. The comment should leave no doubt. I'd leave the LR save
> explanation elsewhere.
>
>> >         mcount_exit
>> >  ENDPROC(ftrace_caller)
>> > +#else /* CC_USING_PATCHABLE_FUNCTION_ENTRY */
>> > +
>> > +/* Since no -pg or similar compiler flag is used, there should really be
>> > +   no reference to _mcount; so do not define one. Only a function address
>> > +   is needed in order to refer to it. */
>> > +ENTRY(_mcount)
>> > +       ret     /* just in case, prevent any fall through. */
>> > +ENDPROC(_mcount)
>> > +
>> > +ENTRY(ftrace_regs_caller)
>> > +       sub     sp, sp, #S_FRAME_SIZE
>> > +       stp     x29, x9, [sp, #-16]     /* FP/LR link */
>> > +
>>
>> You cannot write below the stack pointer. So you are missing a
>> trailing ! here. Note that you can fold the sub
>>
>> stp x29, x9, [sp, #-(S_FRAME_SIZE+16)]!
>
> Very well, but...
>
>> > +       stp     x10, x11, [sp, #S_X10]
>> > +       stp     x12, x13, [sp, #S_X12]
>> > +       stp     x14, x15, [sp, #112]
>> > +       stp     x16, x17, [sp, #128]
>> > +       stp     x18, x19, [sp, #144]
>> > +       stp     x20, x21, [sp, #160]
>> > +       stp     x22, x23, [sp, #176]
>> > +       stp     x24, x25, [sp, #192]
>> > +       stp     x26, x27, [sp, #208]
>> > +
>>
>> All these will shift by 16 bytes though
>>
>> I am now wondering if it wouldn't be better to create 2 stack frames:
>> one for the interrupted function, and one for this function.
>>
>> So something like
>>
>> stp x29, x9, [sp, #-16]!
>> mov x29, sp
>
> That's about the way it was before, when you criticised it was
> the wrong way ;-)
>

Really? With two stack frames?

In any case, the important thing is that you call into the next
function with fp/lr on the top of the stack, and fp pointing to the
next fp/lr pair.

I think it would be an improvement to add the second fp/lr for the
interrupted function first, or the *caller* of that function will not
be visible from the state of the stack (since x9 is the only register
that points into that function)

So in summary:

ftraced_function():
  mov x9, x30
  bl  ftrace_regs_caller

ftrace_regs_caller():
  stp  x29, x9, [sp, #-16]!
  mov x29, sp

* At this point, we have a fp/lr pair on the top of the stack that
links the call to ftraced_function() into its caller.

stp x29, x30, [sp, #-(S_FRAME_SIZE+16)]!

(note the x30 instead of x9 - my mistake)

* At this point we have a fp/lr pair on the top of the stack that
links the call to ftrace_regs_caller() into ftraced_function()

You can now populate the pt_regs structure with the various register value.

mov x29, sp

* Now fp points to the top of the stack, where a fp/lr pair lives, so
you can proceed to call other functions.

I hope this helps.





>> stp x29, x30, [sp, #-(S_FRAME_SIZE + 16]!
>>
>> ... store all registers including x29 ...
>>
>> and do another mov x29, sp before calling into the handler. That way
>> everything should be visible on the call stack when we do a backtrace.
>
> I'm not 100% sure, but I think it already is visible correctly. Note
> that the callee has in no way been called yet; control flow is
> immediately diverted to the ftrace_caller.
>

Yes but the link register lives in x9 so there is no way the normal
backtrace logic can see where the ftraced_function() has been called
from.

> About using SP as a pt_regs pointer: maybe I can free another register
> for that purpose and thus achieve conformance *and* pretty code.
>

Sure.

>>
>> > +       b       ftrace_common
>> > +ENDPROC(ftrace_regs_caller)
>> > +
>> > +ENTRY(ftrace_caller)
>> > +       sub     sp, sp, #S_FRAME_SIZE
>> > +       stp     x29, x9, [sp, #-16]     /* FP/LR link */
>> > +
>>
>> Same as above
>
> Yes, Steven demanded 2 entry points :)
>
>> >  /*
>> > --- a/arch/arm64/kernel/ftrace.c
>> > +++ b/arch/arm64/kernel/ftrace.c
>> > @@ -65,18 +65,66 @@ int ftrace_update_ftrace_func(ftrace_fun
>> >         return ftrace_modify_code(pc, 0, new, false);
>> >  }
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +/* Have the assembler generate a known "mov x9,x30" at compile time. */
>> > +static void notrace noinline __attribute__((used)) mov_x9_x30(void)
>> > +{
>> > +       asm(" .global insn_mov_x9_x30\n"
>> > +                    "insn_mov_x9_x30: mov x9,x30\n" : : : "x9");
>> > +}
>>
>> You cannot rely on the compiler putting the mov at the beginning. I
>
> As you can see from the asm inline, I tried the more precise assembler
> label, but it didn't work out. With enough optimisation, the mov _is_
> first; but you're right, it's not a good idea to rely on that.
>

Ah right, I missed that. Still pretty nasty though :-)

>> think some well commented #define should do for the opcode (or did you
>> just remove that?)
>
> Alas, yes I did. I had a define, then run-time generation, and now this
> assembler hack. Looking at the 3, the define would be best, I'd say.
>

I tend to agree with that.
