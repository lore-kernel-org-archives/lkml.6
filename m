Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C98C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1027125
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgcK8N6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC1027125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbeF1JEs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:04:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36591 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbeF1JEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:04:46 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so11462292itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WQZwzbg5n+ULun/r8CQNaXQY+FTDClMScJzvEeplxYE=;
        b=KgcK8N6izdDlWb3xJU12NM3OVwiVMaixIVpeN7ggD1iaYjFB4O1c8YK0t6uVuhacKl
         Z9dO8/Te0Bw7VA3oNBOfSVbKv/tfDAHpqN6yHGIP34M7gIY3BVyArGl1+5RrTFb999uK
         7FKa/rOQLgpDbIlHq58OyoMcCpMUBSv4sh6FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WQZwzbg5n+ULun/r8CQNaXQY+FTDClMScJzvEeplxYE=;
        b=e0IBfE5l//uLWjJetqUaEk6TqRRnYAty8zFAYoZBUHp00CSMZSI/W5W2NdLVJnwjxL
         dl85+iplrbYu1+hvzHdcCIx1S6OWjcnErMCh7X3toGZG+O/5H0SwvrRvRFdOJUbDGCJM
         Tc9yLI9B2INwj4zGuWtr+TQSwUR5EzoiH47WTNAIhy3y7eqHc6nNB18E/ivG5VTnfUKQ
         YPKYoQo/iCRLQIXLhdFWLv2KosrNJAi1Bj0vdw11KSfTiWUQmVFWOh9MiHdFn6vDDCov
         pbECAKClK61T4ezia7S70bp+1ZKIG8qLzf2TQ8naI3X1L5IFkMnImAhhegDopgwo34+A
         yS4Q==
X-Gm-Message-State: APt69E07xVA3clJWO3hObb9tsfKzDfm9VTkkU31RVbgCrp6ZSz3vwd/r
        2bQMrXCZ1twK6qPD/NY1mRbtqdAhAyGmBLo7l+KyMg==
X-Google-Smtp-Source: ADUXVKJgSBCPQT7bn57JHO0zH9zjafFB4Ppe8RDaJpsoJwSy9w3aZqIz9brwra75tGlIW19TlQgyFezfFczvnQEUkP4=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr7745802itc.68.1530176685940;
 Thu, 28 Jun 2018 02:04:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:04:45
 -0700 (PDT)
In-Reply-To: <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org> <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Jun 2018 11:04:45 +0200
Message-ID: <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
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

On 28 June 2018 at 11:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 28 June 2018 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
>> On Wed, Jun 27, 2018 at 06:06:01PM +0200, Ard Biesheuvel wrote:
>>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>>> index 86ec0652d3b1..aa203dffe72c 100644
>>> --- a/include/linux/jump_label.h
>>> +++ b/include/linux/jump_label.h
>>> @@ -121,6 +121,32 @@ struct static_key {
>>>  #include <asm/jump_label.h>
>>>
>>>  #ifndef __ASSEMBLY__
>>> +#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>>> +
>>> +struct jump_entry {
>>> +     int code;
>>> +     int target;
>>> +     int key;
>>> +};
>>
>> I much prefer you use 'u32' there.
>>
>
> Actually, they are signed so that would be s32. But yeah, I can change that.
>
>>
>>> +static void jump_label_swap(void *a, void *b, int size)
>>> +{
>>> +     long delta = (unsigned long)a - (unsigned long)b;
>>> +     struct jump_entry *jea = a;
>>> +     struct jump_entry *jeb = b;
>>> +     struct jump_entry tmp = *jea;
>>> +
>>> +     jea->code       = jeb->code - delta;
>>> +     jea->target     = jeb->target - delta;
>>> +     jea->key        = jeb->key - delta;
>>> +
>>> +     jeb->code       = tmp.code + delta;
>>> +     jeb->target     = tmp.target + delta;
>>> +     jeb->key        = tmp.key + delta;
>>> +}
>>> +
>>>  static void
>>>  jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>>  {
>>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>>
>>>       size = (((unsigned long)stop - (unsigned long)start)
>>>                                       / sizeof(struct jump_entry));
>>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
>>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
>>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
>>> +                                                           : NULL);
>>>  }
>>
>> That will result in jump_label_swap being an unused symbol for some
>> compile options.
>>
>
> No, and isn't that the point of IS_ENABLED()? The compiler sees a
> reference to jump_label_swap(), so it won't complain about it being
> unused.
>
>> Would it not be much nicer to write that like:
>>
>> static void jump_label_swap(void *a, void *b, int size)
>> {
>>         struct jump_entry *jea = a, *jeb = b;
>>
>> #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>>         long delta = a - b;
>>
>>         jea->code += delta;
>>         jea->target += delta;
>>         jea->key += delta;
>>
>>         jeb->code -= delta;
>>         jeb->target -= delta;
>>         jeb->key -= delta;
>> #else
>>
>>         swap(*jea, *jeb);
>> }
>>
>> And then unconditionally use jump_label_swap().
>
> Meh. I thought IS_ENABLED() was preferred over #ifdef, no? That way,
> the compiler always sees the code, and simply discards it without
> complaining if it ends up left unused.

... and it means the sort() routine will unconditionally perform an
indirect function call even if the arch does not require it.
