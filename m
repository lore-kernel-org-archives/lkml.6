Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D483C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16815213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUJiV1sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16815213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeJFA1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:27:55 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36320 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeJFA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:27:55 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so3817008itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KeuwEIGLwIhFnp/zlZGqWtiTYKkJEMFiADynXUfL25E=;
        b=SUJiV1sbbTKmPc9HPG1slNKP6p5baYgdH3XkIvNxgRs4ZyKISmE9fT6fEB0CJTl/S5
         0ubY+Idg3BztaD8swEnk88xueIApSBYO2WkK04eHlOC81j2jOl1U1DuyQl8yMLQROAJy
         XUfuCNIMkrwNy9Z2/fTdHg1vmErnsGL1+zH60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KeuwEIGLwIhFnp/zlZGqWtiTYKkJEMFiADynXUfL25E=;
        b=kxyZ2OqMqb1UH3ag5JMgUoPF7Q1RzX1pHIL5pK6U9J5Twyisuw02kBzUQwyjExpGKu
         igNLbIeG22IPS8n8wGgTepFO8Kun8lJXsJf6TPxXGkIWcG5JCFFca1q3mHk90pIcdx9n
         6QjyB5cC3o/PImzXBvBjCXbiJOLewHyhIPK/20J8dQdLBruwLLeCCTwiPIAv5/CmuLZK
         rU3np73m9bWuITjKATk645++gOK6v04wh1ZUwZH/rXRHhTewyhEmJIi+wmBsbdZYajak
         9KsB03ce5TWyNKwZwHS2c95mPz6YALDWhZvWqvQ/fAmpekdD7aivcLBhgidVrxnmuiUo
         IanA==
X-Gm-Message-State: ABuFfohZAogCVWh1gBy/P27yC7dOL8wH2dc88MyHL+tLeWbpm2FdXRZs
        aDKcOTeQMkd3he1RiKFVDbSGU5trxIKBmvGsgh7iq1wD
X-Google-Smtp-Source: ACcGV63aGKMJpr5iTElN96TVtIJ9jMtEzfWpHyUa+ryt08/aiKtWkGo/CZ4zCA/Diby+Fed3Ee/KKUxJ3o4V2rqHq4s=
X-Received: by 2002:a24:a10b:: with SMTP id y11-v6mr5209852ite.148.1538760492849;
 Fri, 05 Oct 2018 10:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 10:28:12 -0700 (PDT)
In-Reply-To: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com> <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
 <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Oct 2018 19:28:12 +0200
Message-ID: <CAKv+Gu_fFvoXmWscnx=dF7ovc2qXJgBnDte3Z8Co9Y4TzDfwbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto routines
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 October 2018 at 19:26, Andy Lutomirski <luto@kernel.org> wrote:
> On Fri, Oct 5, 2018 at 10:15 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> ...
>> > Therefore, I think this patch goes in exactly the wrong direction. I
>> > mean, if you want to introduce dynamic patching as a means for making
>> > the crypto API's dynamic dispatch stuff not as slow in a post-spectre
>> > world, sure, go for it; that may very well be a good idea. But
>> > presenting it as an alternative to Zinc very widely misses the point and
>> > serves to prolong a series of bad design choices, which are now able to
>> > be rectified by putting energy into Zinc instead.
>> >
>>
>> This series has nothing to do with dynamic dispatch: the call sites
>> call crypto functions using ordinary function calls (although my
>> example uses CRC-T10DIF), and these calls are redirected via what is
>> essentially a PLT entry, so that we can supsersede those routines at
>> runtime.
>
> If you really want to do it PLT-style, then just do:
>
> extern void whatever_func(args);
>
> Call it like:
> whatever_func(args here);
>
> And rig up something to emit asm like:
>
> GLOBAL(whatever_func)
>   jmpq default_whatever_func
> ENDPROC(whatever_func)
>
> Architectures without support can instead do:
>
> void whatever_func(args)
> {
>   READ_ONCE(patchable_function_struct_for_whatever_func->ptr)(args);
> }
>
> and patch the asm function for basic support.  It will be slower than
> necessary, but maybe the relocation trick could be used on top of this
> to redirect the call to whatever_func directly to the target for
> architectures that want to squeeze out the last bit of performance.
> This might actually be the best of all worlds: easy implementation on
> all architectures, no inline asm, and the totally non-magical version
> works with okay performance.
>
> (Is this what your code is doing?  I admit I didn't follow all the way
> through all the macros.)

Basically
