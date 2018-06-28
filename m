Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998AC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18327140
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTkftz5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A18327140
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964934AbeF1JOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:14:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32897 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeF1JOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:14:35 -0400
Received: by mail-io0-f193.google.com with SMTP id d185-v6so4563449ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+b2x6NOJBsTNfvowLR9oKe4yv1rod5vlgXxyu1++zv4=;
        b=gTkftz5zzxu7wYw+g9BQNSAwnpJZChf33asjRh3ZzEwZJrP46b6b9IeniFa2OH2OPj
         nw3FdKp/OkusxYgFfnEz+dRAeN4AmXw5NKl5TwrfqRjdfAKrjZdHTvKMv5bx4fhaxrdd
         aeSUTS03E+HUYehRa22V0I7oTNWcYX0HlFUnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+b2x6NOJBsTNfvowLR9oKe4yv1rod5vlgXxyu1++zv4=;
        b=e9oJCsNZZ24QxQxedQdv2WYRwOtUbt4wAS5L8t4eGpKsp2kUbd13SNlQFOWCwxzf1H
         aY0jf6jWbRgbQedxp0ark0uJ9lBvO74pFlKxlPOyNq7WlJMBaBU8oJdk2ag0XIc9/vgF
         opdFX3En56AOeTYusOeI+oGvI/CKGK+rqYWeginnONLvFfod1R1H99xNYW49eEPt0awv
         ngs70gSKN5Iuko6M9vupddgPGmqQhEWaDYiaE3txskHsYCdocIyrwq7XOzgGd/TkLfUH
         Akn2OcjE1Rlp5XaJyZgjA1d7zS0zQsvl7gOkSffPdgYCz/XdQpfxxRC2PeXghAVGdgMg
         hMUg==
X-Gm-Message-State: APt69E0MEouIdPh6ZUYnODoUnHApbS0mdMgSPNYJXtc8opd2Ez84yhXK
        kRrXwDMq4tMxQsVi6b4DXubul2vTzMyXfXom8xqzKDKl
X-Google-Smtp-Source: AAOMgpfXSWxYka8NwRO9utSUMLzlgFU/glNL9aR6lrVaukN+q8uDXfudikBoWm05ctk37OYobc7Xt1zfq1E841CTHvI=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr7750956ioc.173.1530177274936;
 Thu, 28 Jun 2018 02:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:14:34
 -0700 (PDT)
In-Reply-To: <20180628091135.GB2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-5-ard.biesheuvel@linaro.org> <20180628091135.GB2494@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Jun 2018 11:14:34 +0200
Message-ID: <CAKv+Gu8OuxSWEWA0o+b+DaPLW8tSx-R6K4_KfomZSBKxqSuukA@mail.gmail.com>
Subject: Re: [PATCH 4/5] x86: jump_label: switch to jump_entry accessors
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 11:11, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 06:06:03PM +0200, Ard Biesheuvel wrote:
>> In preparation of switching x86 to use place-relative references for
>> the code, target and key members of struct jump_entry, replace direct
>> references to the struct members with invocations of the new accessors.
>> This will allow us to make the switch by modifying the accessors only.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> That just makes horrible code worse.. can't we do something like so
> instead?
>

Sure, I will incorporate that for v2.

>
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -42,52 +42,37 @@ static void __jump_label_transform(struc
>                                    void *(*poker)(void *, const void *, size_t),
>                                    int init)
>  {
> -       union jump_code_union code;
> +       union jump_code_union jmp = {
> +               { .jump = 0xe9,
> +                 .offset = jump_entry_target(entry) -
> +                           (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE), }
> +       };
>         const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>         const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
> +       const unsigned char *expect, *code;
> +       int line;
>
>         if (type == JUMP_LABEL_JMP) {
>                 if (init) {
> -                       /*
> -                        * Jump label is enabled for the first time.
> -                        * So we expect a default_nop...
> -                        */
> -                       if (unlikely(memcmp((void *)entry->code, default_nop, 5)
> -                                    != 0))
> -                               bug_at((void *)entry->code, __LINE__);
> +                       expect = default_nop; line = __LINE__;
>                 } else {
> -                       /*
> -                        * ...otherwise expect an ideal_nop. Otherwise
> -                        * something went horribly wrong.
> -                        */
> -                       if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
> -                                    != 0))
> -                               bug_at((void *)entry->code, __LINE__);
> +                       expect = ideal_nop; line = __LINE__;
>                 }
>
> -               code.jump = 0xe9;
> -               code.offset = entry->target -
> -                               (entry->code + JUMP_LABEL_NOP_SIZE);
> +               code = &jmp.code;
>         } else {
> -               /*
> -                * We are disabling this jump label. If it is not what
> -                * we think it is, then something must have gone wrong.
> -                * If this is the first initialization call, then we
> -                * are converting the default nop to the ideal nop.
> -                */
>                 if (init) {
> -                       if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
> -                               bug_at((void *)entry->code, __LINE__);
> +                       expect = default_nop; line = __LINE__;
>                 } else {
> -                       code.jump = 0xe9;
> -                       code.offset = entry->target -
> -                               (entry->code + JUMP_LABEL_NOP_SIZE);
> -                       if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
> -                               bug_at((void *)entry->code, __LINE__);
> +                       expect = &jmp.code; line = __LINE__;
>                 }
> -               memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
> +
> +               code = ideal_nop;
>         }
>
> +       if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
> +               bug_at((void *)jump_entry_code(entry), line);
> +
>         /*
>          * Make text_poke_bp() a default fallback poker.
>          *
> @@ -96,11 +81,13 @@ static void __jump_label_transform(struc
>          * always nop being the 'currently valid' instruction
>          *
>          */
> -       if (poker)
> -               (*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
> -       else
> -               text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
> -                            (void *)entry->code + JUMP_LABEL_NOP_SIZE);
> +       if (poker) {
> +               (*poker)((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE);
> +               return;
> +       }
> +
> +       text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
> +                    (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>  }
>
>  void arch_jump_label_transform(struct jump_entry *entry,
