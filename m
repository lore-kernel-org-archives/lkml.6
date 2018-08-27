Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E90C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00401208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XxX2+M/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00401208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeH1Aa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:30:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63649 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1Aa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:30:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 528751072BA;
        Mon, 27 Aug 2018 16:42:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=B7n57maRS3Ps
        isb+OGLhXPCsm7w=; b=XxX2+M/LtzZZR91nQkLqtKIojNeCC7A/zEgfkdSMDWgv
        L854oDf+ogNSQRx7xQ0Dh+DlwS3Ke0cqhr2wl6R8azC3wllmZtIAsEiw6QTGfUDQ
        1x0lbe44GGbY1YAD1rk9DZyq6W0kQHz7wDrwsSDwYhFx/a2wcvnP+TNi1u0f4z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xo2RLd
        JYZg+9GhOjvUXXrsp/tI9vPYHz/hAZvRge1QiEVVhUymlM78i0FJ4Y7z4oRUMUOx
        ZZ4xsUJt19xRE3f4q97XBczqh1xyICVswH38xJM9GGj0sZ1hSM8SYavHqXRlsTA6
        MT87vJbuaq/9MigjlA6xbcq6oQLQALOHn7u5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A7871072B9;
        Mon, 27 Aug 2018 16:42:36 -0400 (EDT)
Received: from [192.168.1.127] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A33E1072B8;
        Mon, 27 Aug 2018 16:42:35 -0400 (EDT)
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com>
Date:   Mon, 27 Aug 2018 15:42:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: BAC16762-AA39-11E8-AECD-063AD72159A7-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
>> Now we're back to the question of "what do you mean by 'constant'"?  I=
f
>> you mean a C constant expression (as defined in the C standard) than
>> almost none of this code fits that criteria.  For these compile-time
>> assertions to work, we are concerned with the data flow analysis and
>> constant propagation performed by the compiler during optimization.  Y=
ou
>> will notice in include/linux/compiler.h that __compiletime_assert is a
>> no-op when __OPTIMIZE__ is not defined.
> Depending on optimizations for static assertions sounds problematic.

(with my best Palpatine voice) It is unavoidable.

Actually it's theoretically possible, but the compiler would have to do
something akin to copying it's control flow graph et. al, run -O2-ish
optimizations, perform the static assertions and then throw away the
optimized control flow graph and emit code based upon the original.


>>> As the comment in <linux/build_bug.h>
>>> says, GCC (and Clang as well) only emits the error for obvious cases.
>>>
>>> When '__cond' is a variable,
>>>
>>>     ((void)sizeof(char[1 - 2 * __cond]))
>>>
>>> ... is not obvious for the compiler to know the array size is negativ=
e.
>>>
>>> Reverting that commit would break BUILD_BUG() because negative-size-a=
rray
>>> is evaluated before the code is optimized out.
>>>
>>> Let's give up __compiletime_assert_fallback().  This commit does not
>>> change the current behavior since it just rips off the useless code.
>> Clang is not the only target audience of
>> __compiletime_assert_fallback().  Instead of ripping out something tha=
t
>> may benefit builds with gcc 4.2 and earlier, why not override its
> Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> version to 4.6") that gcc < 4.6 is irrelevant.

Ah, I guess I'm not keeping up, that's wonderful news!=C2=A0 Considering =
that
I guess I would be OK with its removal, but I still think it would be
better if a similar mechanism to break the Clang build could be found.

>> definition in compiler-clang.h with something that will break the buil=
d
>> for Clang?  It would need an #ifndef __compiletime_error_fallback here
>> though.
>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>> ---
>>>
>>> Changes in v2:
>>>   - Rebase
>>>
>>>  include/linux/compiler.h | 17 +----------------
>>>  1 file changed, 1 insertion(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>>> index 681d866..87c776c 100644
>>> --- a/include/linux/compiler.h
>>> +++ b/include/linux/compiler.h
>>> @@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *of=
f)
>>>  #endif
>>>  #ifndef __compiletime_error
>>>  # define __compiletime_error(message)
>>> -/*
>>> - * Sparse complains of variable sized arrays due to the temporary va=
riable in
>>> - * __compiletime_assert. Unfortunately we can't just expand it out t=
o make
>>> - * sparse see a constant array size without breaking compiletime_ass=
ert on old
>>> - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altog=
ether.
>>> - */
>>> -# ifndef __CHECKER__
>>> -#  define __compiletime_error_fallback(condition) \
>>> -     do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
>>> -# endif
>>> -#endif
>>> -#ifndef __compiletime_error_fallback
>>> -# define __compiletime_error_fallback(condition) do { } while (0)
>>>  #endif
>>>
>>>  #ifdef __OPTIMIZE__
>>>  # define __compiletime_assert(condition, msg, prefix, suffix)       =
         \
>>>       do {                                                           =
 \
>>> -             int __cond =3D !(condition);                           =
   \
>>>               extern void prefix ## suffix(void) __compiletime_error(=
msg); \
>>> -             if (__cond)                                            =
 \
>>> +             if (!(condition))                                      =
 \
>>>                       prefix ## suffix();                            =
 \
>>> -             __compiletime_error_fallback(__cond);                  =
 \
>>>       } while (0)
>>>  #else
>>>  # define __compiletime_assert(condition, msg, prefix, suffix) do { }=
 while (0)
>> To give any more meaningful feedback I think I will need to experiment
>> with Clang, older GCC versions and icc.  It occurred to me that I shou=
ld
>> probably clean up and publish my __builtin_constant_p test program and
>> also generate results for more recent compilers.  I can extend it to
>> test various negative sized array constructs and it could help inform
>> this decision.
>>
>> IMO, the most ideal solution would be a set of C2x (or future)
>> extensions providing something similar to C++'s constexpr, GCC's
>> __builtin_constant_p and our BUILD_BUG_ON.  This would cross deeply in=
to
> Note that __builtin_constant_p is a wild beast with lots of edge
> cases, and dependencies on compiler and optimization level.  I'm
> trying to sort out some of these differences right now with llvm
> developers.

Yes it is.=C2=A0 IIRC, I even found cases where __builtin_constant_p retu=
rned
false, but the emitted code replaced the value in question with a
constant.=C2=A0 So at least at one point, constant propagation and
__builtin_constant_p weren't always entirely coherent.

I was working on a GCC extension that would solve this problem earlier
this year but bills and paying work interrupted me. :)=C2=A0 The solution
involved adding a "const" attribute for function parameters and
variables that would simply create a warning or error if the value
wasn't compiled away at the time middle-end optimizations completed and
RTL emitted.=C2=A0 It isn't finished -- maybe for gcc10.

Daniel

>
>> territory traditionally considered to belong to the implementation, so
>> it's no small request.  A lot would have to be resolved for it to work
>> in the standard.
>>
>> Daniel


