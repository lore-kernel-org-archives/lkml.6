Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB1720658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qieeOq3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB1720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIACFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:05:38 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37343 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeIACFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:05:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so16189544qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dMitvLYzskrRB0I43H+w5BZe5/4w5SXXw6EA6mU8CwI=;
        b=qieeOq3icAkJCNgnn541Uu/jpdqOTlFYtQZIfHGaFQ+E591xxbJCCD2rRr9o5MaoPH
         MowdQgLG7TxNvpoBdP18gkWNDdTxfq1byntVm8ZP14oKY9JirGlGaQZk6WES/5AHbkUz
         rSntjY7NZM55g6bTyEKZOdie279vvJDW4ZQteJGZ9auotoL2IKN5dNx4EXz8U7NQHrK9
         /+Y/UEsoHv6YsJe9lDQtXcE6WSNef1bfIwZ0l7uyfhSK0vOruXKrkqDPuJnRngd8XQoZ
         Bl/T09Z9grhN9lEG+hBaU9+0RyB5tq7NsBu/uYlSX4s8BWz8GpTwplV3jev6M5P8PtdQ
         g5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dMitvLYzskrRB0I43H+w5BZe5/4w5SXXw6EA6mU8CwI=;
        b=o0PxZ9EtPIuC9BrRtUqP8QxkklC9ExH/VjN2GRQqwNX+raSBe7Krj84r/2h6hNniWl
         qKZOK41X1C3739VZrGrqwYVG9o+7N7E/pGdSmeuqr2wXUvZO+WA/KLVlMRJ+HncZAui3
         /SJO8ETSAQl5ORsjLOpHgmItRYoc+l73EYi3waU9r1zf6WtidgjJPpWwuGcc80NX9n8L
         Sgrchht5XD+/NGmqgEBPfObMqcrucuechhJkhaJI3BttR4bx1O3x7a6xBU15oCoFqGun
         3qiWEjMVNwWJ7268IqAhiDaOMzVnYlcVDz94gW7w8rabjT1cmcwaFK/PnYr6eorYZ2uh
         KzRg==
X-Gm-Message-State: APzg51B/HzmwNufTgXtrUTz1PLAT9Ket4CC67RZRxklVAIYpxTOKPXPZ
        f9Hdos6sNWCLfGvATQL2rIWMGAh/Un9ANyLoZZw=
X-Google-Smtp-Source: ANB0VdYH5h27vACVrqwig5sSNDIEsijbrWyAw2osWyGnivIr6Ahr2hfaj11bjCFebo9KS53G9SHnasSV3Dnv9OvuRoI=
X-Received: by 2002:ac8:34e1:: with SMTP id x30-v6mr18057976qtb.115.1535752571728;
 Fri, 31 Aug 2018 14:56:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 14:55:51
 -0700 (PDT)
In-Reply-To: <CAKwvOdkZeFj1QW8QBDSCet2Kv1jRka0DK_eSJwNmfG1Zqn2zcg@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-6-miguel.ojeda.sandonis@gmail.com> <CAKwvOdkZeFj1QW8QBDSCet2Kv1jRka0DK_eSJwNmfG1Zqn2zcg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 23:55:51 +0200
Message-ID: <CANiq72=2Q1+EoqSzvT3aHGWFAJds4ZHXVq_yT+JCYvUhiHtHGg@mail.gmail.com>
Subject: Re: [PATCH 6/7] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christopher Li <sparse@chrisli.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Aug 31, 2018 at 11:38 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Sparse knows about a few more attributes now, so we can remove
>> the __CHECKER__ conditions from them (which, in turn, allow us
>> to move some of them later on to compiler_attributes.h).
>>
>>   * assume_aligned: since sparse's commit ffc860b ("sparse:
>>     ignore __assume_aligned__ attribute"), included in 0.5.1
>>
>>   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
>>     to ignored attributes"), included in 0.5.0
>>
>>   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
>>     ignore hotpatch attribute"), included in 0.5.1
>>
>>   * warning: since sparse's commit 977365d ("Avoid "attribute
>>     'warning': unknown attribute" warning"), included in 0.4.2
>>
>> Cc: Eli Friedman <efriedma@codeaurora.org>
>> Cc: Christopher Li <sparse@chrisli.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Dominique Martinet <asmadeus@codewreck.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>>  include/linux/compiler-gcc.h   | 6 ++----
>>  include/linux/compiler_types.h | 2 +-
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index fdf2fbe6d544..32e6ce06163f 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -84,14 +84,12 @@
>>
>>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>>
>> -#ifndef __CHECKER__
>>  #define __compiletime_warning(message) __attribute__((warning(message)))
>>  #define __compiletime_error(message) __attribute__((error(message)))
>>
>> -#ifdef LATENT_ENTROPY_PLUGIN
>> +#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>>  #define __latent_entropy __attribute__((latent_entropy))
>>  #endif
>> -#endif /* __CHECKER__ */
>>
>>  /*
>>   * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
>> @@ -139,7 +137,7 @@
>>
>>  /* gcc version specific checks */
>>
>> -#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
>> +#if GCC_VERSION >= 40900
>>  /*
>>   * __assume_aligned(n, k): Tell the optimizer that the returned
>>   * pointer can be assumed to be k modulo n. The second argument is
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index 3662b19599fc..5dddc7e0c607 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -216,7 +216,7 @@ struct ftrace_likely_data {
>>  #define __must_check
>>  #endif
>>
>> -#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
>> +#if defined(CC_USING_HOTPATCH)
>>  #define notrace                        __attribute__((hotpatch(0, 0)))
>>  #else
>>  #define notrace                        __attribute__((no_instrument_function))
>> --
>> 2.17.1
>>
>
> Everything looks correct here.  It would be good for the sparse
> maintainer to triple check the commit sha's (as those are for sparse's
> code base, not the kernel's) and have their blessing.  If Chris is

Actually, nowadays it is very easy to check in sparse's
gcc-attr-list.h file, but since the file was not always there, I tried
to find out when the support for each attribute was added.

But indeed, Chris, please let us know. (Should have CC'd you).

> happy with it, then you can add my signoff:
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Also, do you need to put the cc list in the commit message? Some
> people do (hopefully in an automated fashion, because I'd imagine
> manually to be difficult) but don't this it's required.  Doesn't
> matter, just curious.

Hm... I thought it was supposed to be there for all patches,
considering different patches may have to be targeted to different
people. Also, one has to manage anyway the Acked-by and Reviewed-by
per-patch, so you have to manually go through. On top of that, it is
always handy to have in case you discard a patch into a separate
series or in case you send them through a tool that picks the Cc
individually (instead of something more advanced like git-send-email).
So... I guess? Not sure if it is strictly required, though.

Cheers,
Miguel
