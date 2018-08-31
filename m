Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7642F2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efl/iYfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7642F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIAAfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:35:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45138 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeIAAfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:35:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so15919813qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LNWbwQ1xiz3zlVQ6+AjLts6cYDeXgqB3PvKUhOBm/dg=;
        b=efl/iYfyem0X81bVbSE3S6StfAT/QB5GpyJnGpXgzc3usKqf7SXen/CnVHfcV+6zxV
         W1B3iZC9uPm7zF3UDCIocmukyizOXiascHby8V+YbjFOKD5XD929YnbaHL8TRISQNm0e
         p/zcnLbeqHVLofnPysNOpgsUOFQXBJNtwe54dQeF/DY1RV46kIw8B9mV462BEYgQVEiM
         wmCBpb90/uTE6BCroVW+NrJh2Xwy5sJf45T0kIv066k/zaEdTbfSzHMRYzqxQm1NN+4X
         F6KIYSGE/UuN3UT2ipNv87nqYgN+nqbgjkTyx2f6l8F4f/3TGA7o+yjF+p/crCTWSG74
         0MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LNWbwQ1xiz3zlVQ6+AjLts6cYDeXgqB3PvKUhOBm/dg=;
        b=YbPyZsMSxY0NbLqvZ/NzmBl//zaH/f5NaFznOgFDP5yct/pQSPxRNXIwb7bUlkSF9c
         7k0lTY8chNABpRK4fON9TV1FY0/LyiKuV/IKSFnIti766kqK3LiNaaHg7iI7lMan3vDJ
         EPWysjj1ebJIao5CMsvNq3gyk38HPbD85AHXElt5RJWefwlOoHAm8Ss3flc3suXRF/8U
         t2c7zppS3bzbc3xKfyqVXPmenlraeykIh7EoXhwcl8Ss2ksUwZIQqpto0QRHESMWnyEI
         OXKdh3sFSBM5aa4Qa73VSCg4KasDx5NFbaWBzson9Eg8I5CgzyyWSLq+a4rGsG46GUea
         6saA==
X-Gm-Message-State: APzg51DPEL6p/SfHvNcZ5+ZDoEujurDYN91Rz2SPpQMBygKNuICpFwP5
        nUkjY/GbaJPMrMjxhX1K+1eK+OQVD+niVulfmU4=
X-Google-Smtp-Source: ANB0VdZ6croGnaNGLyXMVbeoowh958qf/nQUNeX/3jg15o4vIwzRyH11e7SSjV/QyXdlnZdQ1u5IIpBkKiIsOdJQj0k=
X-Received: by 2002:a0c:abca:: with SMTP id k10-v6mr16780222qvb.140.1535747183289;
 Fri, 31 Aug 2018 13:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 13:26:02
 -0700 (PDT)
In-Reply-To: <CAK8P3a2N0pPvLvmERpHPZ5pmYQpNpd4Yqfq2d2cJZ96UHLd8VA@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-5-miguel.ojeda.sandonis@gmail.com> <CAK8P3a2N0pPvLvmERpHPZ5pmYQpNpd4Yqfq2d2cJZ96UHLd8VA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 22:26:02 +0200
Message-ID: <CANiq72nOOcumNJeZ7w=UXW5p9w82+FZGXGuwJ_SA-gPuFfctow@mail.gmail.com>
Subject: Re: [PATCH 5/7] Compiler Attributes: naked was fixed in gcc 4.6
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Aug 31, 2018 at 9:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Aug 31, 2018 at 7:05 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
>> and noinline on __naked functions") added noinline and noclone
>> as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.
>>
>> Since now the minimum gcc supported version is 4.6,
>> we can clean it up.
>>
>> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
>> and https://godbolt.org/z/h6NMIL
>>
>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index 66e1eb8822d9..fdf2fbe6d544 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -77,14 +77,8 @@
>>   * to trace naked functions because then mcount is called without
>>   * stack and frame pointer being set up and there is no chance to
>>   * restore the lr register to the value before mcount was called.
>> - *
>> - * The asm() bodies of naked functions often depend on standard calling
>> - * conventions, therefore they must be noinline and noclone.
>> - *
>> - * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
>> - * See GCC PR44290.
>>   */
>> -#define __naked                __attribute__((naked)) noinline __noclone notrace
>> +#define __naked                __attribute__((naked)) notrace
>>
>
> Good catch. Can this be moved into linux/compiler.h now so we
> don't need separate definitions for clang and gcc?

Yes, it can! :-) Actually I was writing that to Nick in the other
thread about clang, but you beat me to it. Good catch too!

Cheers,
Miguel
