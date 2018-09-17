Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C565E214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jd4FM5IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C565E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIRALN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:11:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36292 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:11:13 -0400
Received: by mail-io1-f65.google.com with SMTP id q5-v6so12350226iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O5u7wMaeEk5fXb1J01fxLI6QHGCxyT5enhFPS6rHyRY=;
        b=jd4FM5IS7f0vh3csEHwSv5NUA9rtXE8KD/0+x/dX+blaJ/pXqQWvnWocszCWRJZBXi
         hndcTDC2awQIUnUZ1MTmL+mMNOQeAfV+izh37HjkSQikTpg2Uo5/17R4Ewx2avfgt1wt
         fHTsZ1b+jqs6ayOY0OrEyRGl8lttRhvBtheJh1c0bj8sfhmEbkEPZSlm2UJtnzQ2FW6H
         KaSDYmij4gIw28uvGEAJ1DkwDMj4pp0BKH3feLAgNIS252NtcFAqD6/QiW7ec2qZG59w
         5nKdbV95/DByG5Qk1YlSh1RsHBaRiG1TPf/kvBlxPuZRZQy7VSPOPTWb8VnttqG/Nd4t
         G5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O5u7wMaeEk5fXb1J01fxLI6QHGCxyT5enhFPS6rHyRY=;
        b=CreVpwvzUeTiaFLEfMKPtwII+rkXphHD6oVZ4AQ4faC/4vlTF1b7XnukgK4CAxT0mu
         eBZZOvvbpK+2EKQXAD0Bc00u0mbTMcZkliQOwQ38+5oevrfwHKPnb9prUizbiqneWHpV
         5/7QOOoQd7JG3qOFaNjPNfyS579faHijz5NY8Z6V460QMJ/R8IT1nL3B+tecPOazY2hR
         pamLM7Bf9Gn5yNeHyOPHJMqbN7DTZifN970FqD885RjhnASJ3kSYKkND7IHjsMzbr1oZ
         PwxGe+nUmQxy7jSuL7JJ6jTmea3zs7uQibGvWsY1s6Jwo9HT/p1lsD9OGVn/wxva9ewV
         dFTg==
X-Gm-Message-State: APzg51AV/LD7zPEX06yva1W6vZpI84mGIRuIsF6in60DHTYjrxuOlKC5
        yl2d6QLEwxK0rHxOp09tqksTnN8ZUuwbSx/S+v26/A==
X-Google-Smtp-Source: ANB0Vda9zHAY8xmHgUHbwXkczsykCuIOYRyirwb3bmL+ueoCcJnoaS2qc01BLkxqLf9gMfP9X77u+IXTvbF74xI/lqc=
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr21760951ioh.192.1537209757392;
 Mon, 17 Sep 2018 11:42:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 11:42:36
 -0700 (PDT)
In-Reply-To: <CACT4Y+baDKvmpKJ4SKoEuZG4ir2xRGscQ7Ro4hkVAX3jwiWnFg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <868c9168481ff5103034ac1e37b830d28ed5f4ee.1535462971.git.andreyknvl@google.com>
 <CACT4Y+baDKvmpKJ4SKoEuZG4ir2xRGscQ7Ro4hkVAX3jwiWnFg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Sep 2018 20:42:36 +0200
Message-ID: <CAAeHK+yvVgV6LA8PgJz6ysCo+X38tCyLrMVhKOe08tFyZP_F0Q@mail.gmail.com>
Subject: Re: [PATCH v6 03/18] khwasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_HW
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 4:47 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>
>>  #define __no_sanitize_address __attribute__((no_sanitize("address")))
>> +#define __no_sanitize_hwaddress __attribute__((no_sanitize("hwaddress")))
>
> It seems that it would be better to have just 1 attribute for both types.
> Currently __no_sanitize_address is used just in a single place. But if
> it ever used more, people will need to always spell both which looks
> unnecessary, or, worse will only fix asan but forget about khwasan.
>
> If we do just:
>
> #define __no_sanitize_address __attribute__((no_sanitize("address",
> "hwaddress")))
>
> Then we don't need any changes in compiler-gcc.h nor in compiler.h,
> and no chance or forgetting one of them.

Will do in v7.

>>  config KASAN
>> -       bool "KASan: runtime memory debugger"
>> +       bool "KASAN: runtime memory debugger"
>> +       help
>> +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
>> +         designed to find out-of-bounds accesses and use-after-free bugs.
>
> Perhaps also give link to Documentation/dev-tools/kasan.rst while we are here.

Will do in v7.

>
>> +
>> +choice
>> +       prompt "KASAN mode"
>> +       depends on KASAN
>> +       default KASAN_GENERIC
>> +       help
>> +         KASAN has two modes: KASAN (a classic version, similar to userspace
>
> In these few sentences we call the old mode with 3 different terms:
> "generic", "classic" and "KASAN" :)
> This is somewhat confusing. Let's call it "generic" throughout (here
> and in the docs patch). "Generic" as in "supported on multiple arch
> and not-dependent on hardware features". "Classic" makes sense for
> people who knew KASAN before, but for future readers in won't make
> sense.

Will use "generic" in v7.

>>
>> +if HAVE_ARCH_KASAN_HW
>
> This choice looks somewhat weird on non-arm64. It's kinda a choice
> menu, but one can't really choose anything. Should we put the whole
> choice under HAVE_ARCH_KASAN_HW, and just select KASAN_GENERIC
> otherwise? I don't know what't the practice here. Andrey R?

I think having one option that is auto selected is fine.

>> +config KASAN_HW
>> +       bool "KHWASAN: the hardware assisted mode"

Do we need a hyphen here? hardware-assisted?

Yes, will fix in v7.
