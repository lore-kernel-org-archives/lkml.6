Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF9C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD932083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJw0yAL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD932083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIARIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:08:18 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37261 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeIARIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:08:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so17479717qtl.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S0FTQX6kRiRrZHrH4HqQkEvbgBClX1Md+QOaVczeHPk=;
        b=TJw0yAL8AyLbXMXA1SdPypW1olHc35uvmv9fW8Uh89a4+qDCQsQCkNHMdX3C+I9XFD
         eH7x7dNzHZIpYyMVOMfysENYNotfi9x+F7fC/nhDpSDQUQvcUGbrTxl8YfJpipXC/7MO
         fyZX0BKUDz0Xnm7oPE0CUA59PLf//OK4iXvuN7gsWKb4gRKZMomHLK4CpSo3641E1hLy
         8GaSB/0r7gHlqUJkOU/OF92ktgJbpdKr/AWAfZBFSahXV7gEl9hY34j/cRqNsALbRHGN
         xcBtQgN7ALT/e6TShT18ZdaWyFnd3DhSJJP7mClSt40TV/AZGtQsVEf8abDUx8ud5kIO
         T4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S0FTQX6kRiRrZHrH4HqQkEvbgBClX1Md+QOaVczeHPk=;
        b=ucU6i0xM6FyIpndPJj+nd1aBGt8MbdxcBcGT6CiBWmfgiC2rRy1LPDXS5EVFoXYLcR
         yWH5kRSOJt7OnRu/2EG6XVGTEXXLR/RspN1vB8sO3UMOCML3XUZhtgHAxr5FY6cBIvh2
         aUom9vk/g0Ubh884uAF3sGNuOmwD46wTqC3D4aq3oG9Ey1n3n+Ozh6n9k+zc09yVpxjQ
         Nm2nqL+W+AzBj861Ch1SpnOoOVF6BGjvnxKG3olJZR6XuRgSn6k9UdzKd8gO48QStzcQ
         U/uZd8LzIwMhx/E9qXXyQPoFoPOReMMIr1UhlGqmn2ATCmPQ1D97+4Fckic6BSYlG7gz
         oj5Q==
X-Gm-Message-State: APzg51DCdbvUWIw9SZNTkWS0vclAVYC6eQmHnIDj64H1gBcY7okTiv9M
        2vyw9r7aaLMLUBiiO13+JZiTG7xeV/tE3uEX09c=
X-Google-Smtp-Source: ANB0VdYI4FSOO2BCzI1u4RnL+0e54B8epkBtFg73Hs1J7d1gRxPzA07izq9fhcFW8rkqgfrArbnd7lqoo6eTuR0G6+I=
X-Received: by 2002:a0c:aac9:: with SMTP id g9-v6mr19565913qvb.78.1535806578971;
 Sat, 01 Sep 2018 05:56:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 05:55:58 -0700 (PDT)
In-Reply-To: <20180901101430.GA21877@nautica>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com> <20180901101430.GA21877@nautica>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 14:55:58 +0200
Message-ID: <CANiq72=pMSOaY5rYvJFgWKjiqAMjEVFu8GXRHx=Tz4sXqP-SSw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On Sat, Sep 1, 2018 at 12:14 PM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Miguel Ojeda wrote on Fri, Aug 31, 2018:
>> Instead of using version checks per-compiler to define (or not)
>> each attribute, use __has_attribute to test for them, following
>> the cleanup started with commit 815f0ddb346c
>> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>>
>> All the attributes that are fairly common/standard (i.e. those that
>> do not require extra logic to define them) have been moved
>> to a new file include/linux/compiler_attributes.h.
>>
>> In an effort to make the file as regular as possible, comments
>> stating the purpose of attributes have been removed. Instead,
>> links to the compiler docs have been added (i.e. to gcc and,
>> if available, to clang as well). In addition, they have been sorted.
>>
>> Finally, if an attribute is optional (i.e. if it is guarded
>> by __has_attribute), the reason has been stated for future reference.
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
>
> Nice work!
> Since I'm being Cc'd I took the time to test this as well, and have no
> problem with libbcc-building-with-clang (or native x86 gcc build)

Thanks a lot for testing! :-)

>
> Nick already made many comments so I only have one more.
>
>> [...]
>> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
>> new file mode 100644
>> index 000000000000..a9dfafc8fd19
>> --- /dev/null
>> +++ b/include/linux/compiler_attributes.h
>> [...]
>> +/*
>> + * To check for optional attributes, we use __has_attribute, which is supported
>> + * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
>> + * 4.6 <= gcc < 5, we implement __has_attribute by hand.
>> + */
>> +#ifndef __has_attribute
>> +#define __has_attribute(x) __GCC4_has_attribute_##x
>> +#define __GCC4_has_attribute_externally_visible 1
>> +#define __GCC4_has_attribute_noclone 1
>> +#define __GCC4_has_attribute_optimize 1
>> +#if __GNUC_MINOR__ >= 8
>> +#define __GCC4_has_attribute_no_sanitize_address 1
>> +#endif
>> +#if __GNUC_MINOR__ >= 9
>> +#define __GCC4_has_attribute_assume_aligned 1
>> +#endif
>> +#endif
>
> Hmm, if this is in this file and not compiler-gcc, I am not sure about
> using GNUC_MINOR without checking the major -- I have no idea what kind
> of versions e.g. icc will use (or what attributes ancients version of
> clang or old icc support, actually)

The idea here is that all non-gcc recent compilers that we may care
about support __has_attribute,so if we are inside the #ifndef, we
*have* to be gcc < 5 (see https://godbolt.org/z/NQFdsK).

>
>
> It's a bit of research work but I think it'd be cleaner to define
> similar macros for all three compilers, if we care about the old
> versions... Or actually..
>
> For clang you've implicitely required clang >= 3.0 in patch 3 of this
> serie, so presumabely it wouldn't need this compat macro at all.
>
> For icc I think icc 17 is still fairly recent... But I just abused work
> to test and linux fails to compile with icc 15/17/18 for other reasons
> (unrelated to this patch), so unless anyone helps with this I'm tempted

Thanks a lot for testing it! I agree that icc 17 is fairly recent, but
is there anybody using it on a regular basis to compile the kernel --
I guess your tests confirm that there isn't, but you never know... :-)
As for clang < 2.9, I doubt anybody is using it for anything
meaningful.

Also, we should note that this is about compiling the latest greatest
kernel release, which someone with older compilers is less likely to
be doing with clang and icc than gcc, I guess.

As for the failures: indeed, if anyone is actually doing it, they
probably need to apply quite some third-party patches anyway, so they
can also patch this file as well. Otherwise, they can always speak up
and ask for support. If nobody says anything though, then we have
proof nobody cares about it...

> to suggest leaving it at it, and whoever that is will probably have a
> better idea of how far back they want to make icc work / what attributes
> are defined there.
> It's a bit of a shame there's no linux-compilers list to reach out to :)
>
> (this would need to move the include of this file after the
> compiler-specific headers, but from what I can see there is no problem
> with that)

I included it as soon as possible so that other code (e.g. the
compiler-specific headers) can depend on the common attributes for
anything they need (in this way, the compiler_attributes.h can be
considered like it defines some extensions to the C language that we
allow all code in the kernel to use -- as if it was not there to begin
with).

By the way, do you know if there are some public docs on the
attributes supported by icc that we can link to? I couldn't find
anything in a quick search, both in google and in the icc's
"Compatibility" pages...

Cheers,
Miguel
