Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B759FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590792483E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnLfJr6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590792483E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeF1JCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:02:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37015 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeF1JCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:02:37 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so6501897itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N837V8s17hZoWhQ1OUVPVoWNbJUo+w9UaZNebt1VuYE=;
        b=EnLfJr6MB/cj0pGt8CJcZE+rs+SNsPZwSH3VKHj1G8xWFlS+3DR5pijdmUBvR5QAFJ
         JI77oP0mXoDzPYHNmhHUrDYNahnjiKCq+mBNbHLp7QlXni6jSJNp49kVmiPLJZUmt0/c
         OQE4cJ/1tKI+MM2NyJdonRJDxhidkHgLFXMpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N837V8s17hZoWhQ1OUVPVoWNbJUo+w9UaZNebt1VuYE=;
        b=Ys569/RBl2XGhhbt5O6Yv4UihOLmDxLx0VS3kimcCWikcdW2TMlQ+7lLuHfzKmU7AO
         77klrYISC8VyxId0vhdItnCm2BgAlZxF4F8kzP7/Iys84+JUX+/duMx7/asVzwGMMI/K
         wNgfWdTwmuHwhGbGPiXVGoam9vebbKySD+MbjK5C4K2B/McG2YrjXf8SVKgIatXGtabT
         YaPAaKQQ7MehLHYvTOuDQlN9lWa2uN0UaslCMcV/uSFyWMc9BPSj9+njgBtI11PEcZuX
         slG+muuuGtBmFLsqRHT0P86dvY779zN+abv5CUELZoWO+Ws8vlKWwZwcaHyb9LRRQF92
         pJ7g==
X-Gm-Message-State: APt69E0Ih7twW2Q1kV4cum0kYZLLgQFggn1TBkR4o3pgRi/UpDumr7NG
        FKOV8nHMvVxxhqydNgB6PtyMPtWxe8tiQ65GPsaIkg==
X-Google-Smtp-Source: ADUXVKJiIfE8YVSzTuE2ygKVguP6PQ8l8HBNqC4V4gBWHFmqO5RwhtDYN7rSgkd0AEVQ6PWku1v42gax/Y64R8RSd5k=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr7740673itc.68.1530176556683;
 Thu, 28 Jun 2018 02:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:02:36
 -0700 (PDT)
In-Reply-To: <20180628085003.GA2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org> <20180628085003.GA2494@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Jun 2018 11:02:36 +0200
Message-ID: <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
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

On 28 June 2018 at 10:50, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 27, 2018 at 06:06:01PM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index 86ec0652d3b1..aa203dffe72c 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -121,6 +121,32 @@ struct static_key {
>>  #include <asm/jump_label.h>
>>
>>  #ifndef __ASSEMBLY__
>> +#ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>> +
>> +struct jump_entry {
>> +     int code;
>> +     int target;
>> +     int key;
>> +};
>
> I much prefer you use 'u32' there.
>

Actually, they are signed so that would be s32. But yeah, I can change that.

>
>> +static void jump_label_swap(void *a, void *b, int size)
>> +{
>> +     long delta = (unsigned long)a - (unsigned long)b;
>> +     struct jump_entry *jea = a;
>> +     struct jump_entry *jeb = b;
>> +     struct jump_entry tmp = *jea;
>> +
>> +     jea->code       = jeb->code - delta;
>> +     jea->target     = jeb->target - delta;
>> +     jea->key        = jeb->key - delta;
>> +
>> +     jeb->code       = tmp.code + delta;
>> +     jeb->target     = tmp.target + delta;
>> +     jeb->key        = tmp.key + delta;
>> +}
>> +
>>  static void
>>  jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>  {
>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>>
>>       size = (((unsigned long)stop - (unsigned long)start)
>>                                       / sizeof(struct jump_entry));
>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
>> +                                                           : NULL);
>>  }
>
> That will result in jump_label_swap being an unused symbol for some
> compile options.
>

No, and isn't that the point of IS_ENABLED()? The compiler sees a
reference to jump_label_swap(), so it won't complain about it being
unused.

> Would it not be much nicer to write that like:
>
> static void jump_label_swap(void *a, void *b, int size)
> {
>         struct jump_entry *jea = a, *jeb = b;
>
> #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
>         long delta = a - b;
>
>         jea->code += delta;
>         jea->target += delta;
>         jea->key += delta;
>
>         jeb->code -= delta;
>         jeb->target -= delta;
>         jeb->key -= delta;
> #else
>
>         swap(*jea, *jeb);
> }
>
> And then unconditionally use jump_label_swap().

Meh. I thought IS_ENABLED() was preferred over #ifdef, no? That way,
the compiler always sees the code, and simply discards it without
complaining if it ends up left unused.
