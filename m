Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC7BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RiplUGAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfBEJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:38:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37189 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:38:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id n23so2118364lfl.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cM0kn6MnsrT8z72e1c01iW56nqsaQV+n33IhqGeNyaQ=;
        b=RiplUGAydGfe2p0ha/NzoOS+6Im1hkIazc66M04XdUCsG0u3ghXkOtB9UqwVFvRmul
         yDL5H8xCwvO9EDArZmis5TBntAvJWnBfySKz8SLDUSBhTeLPhux+A3uuRmt3f4zN01gZ
         qZnN7TYVIXKn6cFvR7r3y7aAqgsuNjkmVuKZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cM0kn6MnsrT8z72e1c01iW56nqsaQV+n33IhqGeNyaQ=;
        b=q2nf0DHijCtTW/SY4UQoJh2W6uDS65EnFs+jz+4DKNJjZYUoeFel+HERqm3pEa3ow7
         pavqtVg1qOgnujeysx81vtiszr3QpFah3RfxYWNND/zeJkQQRoKsf7Y/j0Du/s0EWSgQ
         wHNJlYMigU/jzjpUWxcCuzZjXqeBJJ7VjiXOSU4jNKBv8LaTC4IQsrvd2yEdrLjVKzEp
         UrqS26QlM8fwLNjvCh2BPQVoqURFDzbZmiKQ0OV1So3PjtUUbVV0afjgiMv9Q9RS291J
         cgBLk8+Mw5+1NjVPlFkh3qXeR0GmAT7GHBsB6O29w5pD3gBywC70KEGeZLzuBNVV83bn
         RtTg==
X-Gm-Message-State: AHQUAubNk5AN7F7zM+0Zl0oJ10YJoPmqfuLjVFWoW3cko2Gb4JE5h5jG
        PsKpRRJdrvMCD5tmEaUa+0l6mgWhhO5eFQJU
X-Google-Smtp-Source: AHgI3Iab+oC+/rQuG8eGH6wXfSD+A0iIgkw8qPSngsUIYMvFr2SFsQXPIt0rPuFbJTPPzQxpAFCz/g==
X-Received: by 2002:a19:5e54:: with SMTP id z20mr832385lfi.148.1549359502732;
        Tue, 05 Feb 2019 01:38:22 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f123sm2984440lff.41.2019.02.05.01.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:38:22 -0800 (PST)
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e1e125b5-71b4-3694-d7d8-789dfef7a9f5@rasmusvillemoes.dk>
Date:   Tue, 5 Feb 2019 10:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2019 09.05, Masahiro Yamada wrote:
> On Mon, Feb 4, 2019 at 4:24 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> BUILD_BUG_ON() is a little annoying, since it cannot be used outside
>> function scope. So one cannot put assertions about the sizeof() a
>> struct next to the struct definition, but has to hide that in some
>> more or less arbitrary function.
>>
>> Since gcc 4.6 (which is now also the required minimum), there is
>> support for the C11 _Static_assert in all C modes, including gnu89. So
>> add a simple wrapper for that.
>>
>> _Static_assert() requires a message argument, which is usually quite
>> redundant (and I believe that bug got fixed at least in newer C++
>> standards), but we can easily work around that with a little macro
>> magic, making it optional.
>>
>> For example, adding
>>
>>   static_assert(sizeof(struct printf_spec) == 8);
>>
>> in vsprintf.c and modifying that struct to violate it, one gets
>>
>> ./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct printf_spec) == 8"
>>  #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")
>>
>> godbolt.org suggests that _Static_assert() has been support by clang
>> since at least 3.0.0.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  include/linux/build_bug.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
>> index faeec7433aab..4bf9ba847b44 100644
>> --- a/include/linux/build_bug.h
>> +++ b/include/linux/build_bug.h
>> @@ -58,4 +58,23 @@
>>   */
>>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>
>> +/**
>> + * static_assert - check integer constant expression at build time
>> + *
>> + * static_assert() is a wrapper for the C11 _Static_assert, with a
>> + * little macro magic to make the message optional (defaulting to the
>> + * stringification of the tested expression).
>> + *
>> + * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
>> + * scope, but requires the expression to be an integer constant
>> + * expression (i.e., it is not enough that __builtin_constant_p() is
>> + * true for expr).
>> + *
>> + * Also note that BUILD_BUG_ON() fails the build if the condition is
>> + * true, while static_assert() fails the build if the expression is
>> + * false.
>> + */
>> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>> +#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")
> 
> What is the "" "" for?

Good point. It's a leftover from when I had a fallback-implementation of
_Static_assert for gcc < 4.6, where I wanted to ensure that the second
argument was a string literal, even if my fallback implementation
ignored that argument. Now it's actually a little harmful, because

foobar.c:5:34: error: expected string literal before ‘expected’
 static_assert(sizeof(long) == 8, expected 64 bit machine);

is better than

foobar.c:4:34: error: expected ‘)’ before ‘expected’
 static_assert(sizeof(long) == 8, expected 64 bit machine);

> Bikeshed:
> 
> There might be room for argument about
> where this macro should go.
> 
> Another possible place is <linux/compiler.h>
> where compiletime_assert() is defined.

I'd rather move compiletime_assert to build_bug.h, and rename it so that
it becomes an implementation detail of BUILD_BUG. There are not that
many direct users of compiletime_assert(), and I think we should
standardize on fewer ways of achieving the same thing. static_assert()
for checking ICEs, usable at any scope, and BUILD_BUG_* for checking
that the optimizer is sufficiently smart.

This would also be a step towards another cleanup I'd like to do: make
build_bug.h not depend on compiler.h, because we already have a
dependency in the other direction (ARRAY_SIZE using BUILD_BUG_ON_ZERO).

Rasmus
