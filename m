Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C487221A35
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rx/RoNAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C487221A35
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeHHTOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:14:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34751 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:14:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so1440490pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Glr5p75W8YssHNa8WJvH+WlPwlMeTuOlRWi4dk0hYXk=;
        b=rx/RoNAQbzQmlqJ0KLcWX88VGrNhNWSYDfDyHJ3NriymrPjsJ3HgeBGFjw9XBMLVjl
         B1batqiJMFSli1jGlrguJLXrTXR4dCFBVvvOYJ5BHl/n3B9csmT15Kx8uuwCp4efM4fq
         bck2X7iNj+FstOKkr+CBhxKEuQfC16Z1DW6sJP5+KjaRrd1b2YKDO8szAky+2PDDzRng
         DEK/4ZYrTo1/dAkGCEI3b1SPnIgTAUsj7zPS5r4zC3LOf6kxQlmkIcw2T/SAccIXalu/
         8okU8MFe34QhedyCw6VyiutwDWsf9V/PQaQ+8ZXI6Atf7IRn9C1wie1z6gaaI0lFGFum
         f/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Glr5p75W8YssHNa8WJvH+WlPwlMeTuOlRWi4dk0hYXk=;
        b=nyKbR53EsNYEj/vvTQvZsawcYHcKyGQS+OBRHBUD3xN7dboOUgisy9bpoWUm1jNdm7
         DywEibWAOFD1v/0YfugJcf9NWh+HkD/MCXr7kAPMnbaREcSHLxGXJShPzKD2E8dNK72g
         FtBU0JKFXzRJmkmZo/1IaeI5n9hABfP9DggfdzwWVLUk+KyO2ZrCupsndAoMJ81dWbDX
         FYqZTCjlZ2xA5y1OtExsg5Nh4H3/QOZzwvO7DRQxRy5RY39tH+U6UhVkfkD8Lnd2FyvF
         LIOuFYNkpN6FqHT1zGMAWf/p58WRVO3+wfgWSBAcsbmPH8t0r2yFhuikBBT6aSo24cFs
         t+Qg==
X-Gm-Message-State: AOUpUlFodBxjbXbpknaP4NByxALWdx6u9w3H0HR1SfN7kGulESVVog1J
        2f2MMdNiZy2Jryiz01X+r202t3SYmOkhWxYWtNNDlA==
X-Google-Smtp-Source: AA+uWPy7Ly//aV3at17SoIJxQgk1UjRM0nGKd1dx4YRn5gtfZZc1/z98/xR23K5VortykylSsi1YHhJGzRZsJ8f/jaw=
X-Received: by 2002:a62:d113:: with SMTP id z19-v6mr3780291pfg.98.1533747255377;
 Wed, 08 Aug 2018 09:54:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:53:54
 -0700 (PDT)
In-Reply-To: <20180808162752.GA26592@arm.com>
References: <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110709.GA17859@arm.com> <CAAeHK+wHd8B2nhat-Z2Y2=s4NVobPG7vjr2CynjFhqPTwQRepQ@mail.gmail.com>
 <20180703173608.GF27243@arm.com> <CAAeHK+wTcH+2hgm_BTkLLdn1GkjBtkhQ=vPWZCncJ6KenqgKpg@mail.gmail.com>
 <CAAeHK+xc1E64tXEEHoXqOuUNZ7E_kVyho3_mNZTCc+LTGHYFdA@mail.gmail.com>
 <20180801163538.GA10800@arm.com> <CACT4Y+aZtph5qDsLzTDEgpQRz4_Vtg1DD-cB18qooi6D0bexDg@mail.gmail.com>
 <20180803092312.GA17798@arm.com> <CACT4Y+bCen+ccU8awYyx_Tw14JNZhaP4D-jNq-WZy7itW+vpYg@mail.gmail.com>
 <20180808162752.GA26592@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Aug 2018 18:53:54 +0200
Message-ID: <CACT4Y+bQxwz2fcuGqtQYkCCV75chtLvOAfM9W-HBSjkTS1q=-w@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 6:27 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> > Thanks for tracking these cases down and going through each of them. The
>> >> > obvious follow-up question is: how do we ensure that we keep on top of
>> >> > this in mainline? Are you going to repeat your experiment at every kernel
>> >> > release or every -rc or something else? I really can't see how we can
>> >> > maintain this in the long run, especially given that the coverage we have
>> >> > is only dynamic -- do you have an idea of how much coverage you're actually
>> >> > getting for, say, a defconfig+modules build?
>> >> >
>> >> > I'd really like to enable pointer tagging in the kernel, I'm just still
>> >> > failing to see how we can do it in a controlled manner where we can reason
>> >> > about the semantic changes using something other than a best-effort,
>> >> > case-by-case basis which is likely to be fragile and error-prone.
>> >> > Unfortunately, if that's all we have, then this gets relegated to a
>> >> > debug feature, which sort of defeats the point in my opinion.
>> >>
>> >> Well, in some cases there is no other way as resorting to dynamic testing.
>> >> How do we ensure that kernel does not dereference NULL pointers, does
>> >> not access objects after free or out of bounds? Nohow. And, yes, it's
>> >> constant maintenance burden resolved via dynamic testing.
>> >
>> > ... and the advantage of NULL pointer issues is that you're likely to see
>> > them as a synchronous exception at runtime, regardless of architecture and
>> > regardless of Kconfig options. With pointer tagging, that's certainly not
>> > the case, and so I don't think we can just treat issues there like we do for
>> > NULL pointers.
>>
>> Well, let's take use-after-frees, out-of-bounds, info leaks, data
>> races is a good example, deadlocks and just logical bugs...
>
> Ok, but it was you that brought up NULL pointers, so there's some goalpost
> moving here.

I moved it only because our views on bugs seems to be somewhat
different. I would put it all including NULL derefs into the same
bucket of bugs. But the point I wanted to make holds if we take NULL
derefs out of equation too, so I took them out so that we don't
concentrate on "synchronous exceptions" only.

> And as with NULL pointers, all of the issues you mention above
> apply to other architectures and the majority of their configurations, so my
> concerns about this feature remain.
>
>> > If you want to enable khwasan in "production" and since enabling it
>> > could potentially change the behaviour of existing code paths, the
>> > run-time validation space doubles as we'd need to get the same code
>> > coverage with and without the feature being enabled.
>>
>> This is true for just any change in configs, sysctls or just a
>> different workload. Any of this can enable new code, exiting code
>> working differently, or just working with data in new states. And we
>> have tens of thousands of bugs, so blindly deploying anything new to
>> production without proper testing is a bad idea. It's not specific to
>> HWASAN in any way. And when you enable HWASAN you actually do mean to
>> retest everything as hard as possible.
>
> I suppose I'm trying to understand whether we have to resort to testing, or
> whether we can do better. I'm really uncomfortable with testing as our only
> means of getting this right because this is a non-standard, arm64-specific
> option and I don't think it will get very much testing in mainline at all.
> Rather, we'll get spurious bug reports from forks of -stable many releases
> later and we'll actually be worse-off for it.
>
>> And in the end we do not seem to have any action points here, right?
>
> Right now, it feels like this series trades one set of bugs for another,
> so I'd like to get to a position where this new set of bugs is genuinely
> more manageable (i.e. detectable, fixable, preventable) than the old set.
> Unfortunately, the only suggestion seems to be "testing", which I really
> don't find convincing :(
>
> Could we do things like:
>
>   - Set up a dedicated arm64 test farm, running mainline and with a public
>     frontend, aimed at getting maximum coverage of the kernel with KHWASAN
>     enabled?

FWIW we could try to setup a syzbot instance with qemu/arm64
emulation. We run such combination few times, but I am not sure how
stable it will be wrt flaky timeouts/stalls/etc. If works, it will
give instant coverage of about 1MLOC.

>   - Have an implementation of KHWASAN for other architectures? (Is this even
>     possible?)
>
>   - Have a compiler plugin to clear out the tag for pointer arithmetic?
>     Could we WARN if two pointers are compared with different tags?
>     Could we manipulate the tag on cast-to-pointer so that a mismatch would
>     be qualifier to say that pointer was created via a cast?
>
>   - ...
>
> ?
>
> Will
