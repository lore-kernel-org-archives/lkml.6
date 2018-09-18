Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EEEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0B21508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iarDlblj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D0B21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeISA1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:27:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55161 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbeISA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:27:09 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so4785692ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dY8X6OV4q44GG3wekw0GrwlchSgK/28RKxFCRueXkSc=;
        b=iarDlbljU2cdsIF+p2739t3GyO5HDOvlCsRVg/JLn1AW7Qlcj960SjntpiLPJBJfTV
         6SqWHugvBdvSM5QkPfvJKekaz0uL7AJPITvEnIPQhB4CkmqaHDxZZ126388ZXaiO6ROX
         TdAMDQgHMyBp1gBmzqGI71bfmKy/PeOZTie1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dY8X6OV4q44GG3wekw0GrwlchSgK/28RKxFCRueXkSc=;
        b=T/8KM5YisA6xzZs0JQFNke8smTjC/6ynNMycNX/80w7sJbJCRxL/D1lBy5MV0LQOTa
         4lNksM0waB3RtwdyLykSuVsQup0KMX3WnJc4N3Ima40EntoyfQzLr9uNBla5b18Jz0b+
         PzBXi7ZdAavYxXeMH6zcCvUr2heeWjKI0D5Pjd8ztrFnikppD+Fzgl60KbpUPVb58kyd
         nMY9uFBM4Shj0W6Low3/9TQhdkL4VLRPYEFmJcBeaXL1yLoHGz4I5HLvFg1kJGbBcUJP
         15/aA1g6TI2IAxdogcsTBsQ987VAIR65u8Ja0Vo0Yw/4NAAZw9JW/AmLIhDeLhvu87kp
         Udww==
X-Gm-Message-State: APzg51DskCZl0a9+ujzeav7FEFpqdeH3kbWfpZ1Mg4S/7WaE5SfnouRk
        1x1odY5mshbdTEG1lobPFHYEsAyWbhDnweBIemHWLjF/xNHLXA==
X-Google-Smtp-Source: ANB0Vda+gatnX22ji4gkJGzizvIbopQZFtMAxTSp6sZdaH2OIpXwJaLNJsSPHKckwKpnrr10mOq4jdVd50gwdjj2Yb4=
X-Received: by 2002:a24:52cd:: with SMTP id d196-v6mr17518669itb.58.1537296792951;
 Tue, 18 Sep 2018 11:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 11:53:11
 -0700 (PDT)
In-Reply-To: <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com> <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 11:53:11 -0700
Message-ID: <CAKv+Gu8OKyVvvgLy48GDV2KJt-UmmHbf5x0qNxQC_SDiddb9-g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 08:52, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Ard,
>
> On Mon, Sep 17, 2018 at 7:26 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> OK, so let me summarize my remaining concerns as well. I may be a bit
>> more finicky than Andy, though.
>
> Yes, and generally hostile to this whole initiative since the
> beginning. But I am very grateful for your reviews nonetheless, and
> I'll do my best to incorporate as much as is reasonable.
>
>> I would like to urge Jason to
>> bear with us and bring this discussion to a close before resubmitting.
>
> What I fear is that either:
> - You don't like the Zinc initiative in one way or another, and the
> desire to "keep discussing" and adding more things is less out of
> their necessity and more out of a desire to stall it indefinitely.
> - You're going to bikeshed and bikeshed and waste tons of time until
> Zinc copies lots of the same design decisions from the present crypto
> API.
>

Given that you show no interest whatsoever in gaining an understanding
of the underlying requirements that we have to deal with in the crypto
API, the only way to get my point across is by repeatedly stating it
in response to your patches. Also, sending out a new series each time
with only half of the review comments addressed doesn't make me a
bikeshedder.

> I do sincerely hope these are only fears and not what actually is
> going on. I'll do my best to take into serious consideration what you
> say -- many are indeed extremely helpful --  but I certainly won't be
> wholesale accepting all the things you've mentioned.
>

I have pointed out to you numerous times (as has Eric) that the
ChaCha20 ARM code you are importing from the OpenSSL project has been
found to be slower on Cortex-A7, which represents the vast majority of
devices expected to be in the field in 1~2 years. Yet, we are at the
fifth revision now where you are replacing the existing code. Also, I
have asked you more than once to split out your changes to the
upstream OpenSSL code into separate patches so we can more easily
track them, but v5 now puts them in the commit log (again) [but in a
corrupted way - the preprocessor directives are filtered out by
git-commit], which means we cannot use git diff/blame etc to look at
them.

Upstreaming code is about taking an interest in other people's use
cases, and about choosing your battles. It is unfortunate that we have
spent all this time talking about a couple of crypto routines, while
the actual meat of your submission is in WireGuard itself, which I'm
sure you much rather talk about.



>> * simd_relax() is currently not called by the crypto routines
>> themselves. This means that the worst case scheduling latency is
>> unbounded, which is unacceptable for the -rt kernel. The worst case
>> scheduling latency should never be proportional to the input size.
>> (Apologies for not spotting that earlier)
>
> Good catch. I actually did this correct when porting the crypto API to
> use Zinc (in those later top commits in v4), but I hadn't in the Zinc
> code itself. I'll address this for v5.
>
>> maintainership
>> responsibilities
>
> Samuel and I intend to maintain Zinc in lib/zinc/ and send future
> updates to it through Greg's tree, as mentioned in the 00/ cover
> letter. The maintainership of the existing crypto API won't change.
>
>> * The current organization of the code puts all available (for the
>> arch) versions of all routines into a single module, which can only be
>> built in once we update random.c to use Zinc's chacha20 routines. This
>> bloats the core kernel (which is a huge deal for embedded systems that
>> have very strict boot requirements).
>
> I'll split each Zinc primitive into a separate module for v5, per your
> and Andy's desire. And the SIMD code is already toggle-able via a
> Kconfig menu option.
>
>> we should
>> work with Andy Polyakov (as I have done several times over the past 5+
>> years) to upstream the changes we apply to the kernel version of the
>> code.
>
> Indeed this is the intent.
>
>> The same applies to code from other sources, btw, but I am not
>> personally familiar with them.
>
> Good news on this front:
> - Rene wrote the MIPS code specifically for WireGuard, so that _is_ upstream.
> - Samuel wrote the BLAKE2 assembly, and he's the co-maintainer of Zinc with me.
> - I talk to Dan and Peter a decent amount about qhasm.
> - I'm in very close contact with the team behind HACL*, and they're
> treating Zinc as a target -- stylistically and with regards to kernel
> requirements -- which means they're looking at what's happening in
> this patchset and adjusting accordingly.
>
>
>> * If upstreaming the changes is not an option, they should be applied
>> as a separate patch and not hidden in a 5000 line patch without any
>> justification or documentation (but Jason is already working on that)
>
> Indeed this is already underway.
>
> Thanks again for your review.
>
> Jason
