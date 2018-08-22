Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F998C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5D321480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wp4Ge/aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5D321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeHVNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:24:20 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39660 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbeHVNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:24:19 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so982222iok.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fy7GqoM1ck8wb133NC5Kx4vfJf8dh802rfZ25SpXDTo=;
        b=Wp4Ge/aJpctZRqk72TgdPRN3fUoloBDJPEhZVbKeDhkFoZMdOqj3uEm6Kz0hkGGQhq
         HG5dsoDEUcAiP6ILidbIrwPR7IoXNBW7uIc5krNnYtkYpCP1gSE9Fw4tHwQdIXdU8smb
         jRs2/Fp2jYPbIENUGHF5OqcNHc3Bt/JM809lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fy7GqoM1ck8wb133NC5Kx4vfJf8dh802rfZ25SpXDTo=;
        b=hxBHtFy+NGzeMY5mqwW4rMW3iWP4hATsKEvQnb+AKgKl6Yka7amWb+rL/xoSF/iw7t
         zmx3u+LWmliiBja8cXfW2pkRv+Va0Jiu27mMvMk8JIHyP+xGfQwK1ZeuG0cDVm3IUfVM
         fyQsIi5tYtW82mT+DmrKnRlGtWwqddJ5O7qSsrthNgHEzjUxwok+UAxbVZ6QuRbrAVom
         V0cUnv681HCG/jbb0UMAuzBvoQqtncDaoT0XslaOYBh1nOJ+1acRDCc5tLA77WVJlQJF
         lxkJDSDKKcZIB7cbZyIku+hQo1NNCAaGTxXRguxAcNAQHcQQ7bHsr9deBF4K58F3kEjO
         x4jA==
X-Gm-Message-State: AOUpUlFF+2/KKZV7weKQRvmmwBh4gK6P4Gq7FWsmr6RhxxblQNUJUZD/
        Ucnac3yqSuySHcpsnTZTcOmWcjdNpsD/jlGyl3fBEQ==
X-Google-Smtp-Source: AA+uWPxMJAs4hPYwv2d/zTSMA5Mbtk8kpI5W+JW30EXSqjj7a0LmnsGUIEIZtUIzQhbiJY7wRi3mcs36+wk/WLgZSVo=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr44895990iof.173.1534932005836;
 Wed, 22 Aug 2018 03:00:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 03:00:05
 -0700 (PDT)
In-Reply-To: <20180807231941.GC25300@gmail.com>
References: <20180806223300.113891-1-ebiggers@kernel.org> <20180806223300.113891-9-ebiggers@kernel.org>
 <CAKv+Gu_T+f=isb_dBF7icfTHApG+E8Y5njSQ=NmtyTHEN2VMgg@mail.gmail.com> <20180807231941.GC25300@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 22 Aug 2018 12:00:05 +0200
Message-ID: <CAKv+Gu8svYM+YdaJF+z2Q=ZYhfnLDybsiidz9UvevEaa=4U8TA@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] crypto: arm/poly1305 - add NEON accelerated
 Poly1305 implementation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 August 2018 at 01:19, Eric Biggers <ebiggers@kernel.org> wrote:
> Hi Ard,
>
> On Tue, Aug 07, 2018 at 02:09:05PM +0200, Ard Biesheuvel wrote:
>> On 7 August 2018 at 00:32, Eric Biggers <ebiggers@kernel.org> wrote:
>> > From: Eric Biggers <ebiggers@google.com>
>> >
>> > Add the Poly1305 code from OpenSSL, which was written by Andy Polyakov.
>> > I took the .S file from WireGuard, whose author has made the needed
>> > tweaks for Linux kernel integration and verified that Andy had given
>> > permission for GPLv2 distribution.  I didn't make any additional changes
>> > to the .S file.
>> >
>> > Note, for HPolyC I'd eventually like a Poly1305 implementation that
>> > allows precomputing powers of the key.  But for now this implementation
>> > just provides the existing semantics where the key and nonce are treated
>> > as a "one-time key" that must be provided for every message.
>> >
>> > Signed-off-by: Eric Biggers <ebiggers@google.com>
>>
>> Hi Eric,
>>
>> In the past, I worked with Andy on several occasions to get my kernel
>> changes incorporated into the upstream OpenSSL version of the
>> 'perlasm' .pl file.
>>
>> This achieves a number of things:
>> - we get a readable version of the code in the kernel tree,
>> - our changes are reviewed upstream
>> - upgrading involves grabbing the latest .pl file rather than merging
>> generated code (which requires careful review)
>> - GPLv2 permission is made explicit, rather than something someone
>> claims to have reached agreement on,
>> - no legal ambiguity whether the output of the perl script is covered
>> by the license (which is what we incorporate here)
>>
>> Note that the 'available under GPL depending on where you obtained the
>> code' in the CRYPTOGAMS license likely conflicts with the GPL itself,
>> but I am not a lawyer so I'd much prefer having the upstream copy
>> mention this explicitly.
>
> First, note that Jason is proposing adding this exact same .S file as part of
> his new "zinc" cryptography library, along with 7 other OpenSSL .S files.  So it
> may really be him you need to convince.
>

Interesting choice of wording :-) I thought it was usually the other
way around, i.e., it is the submitter who needs to convince the
reviewers/maintainers.

> But yes, I don't really like the approach of just including the .S output of the
> .pl script either, as it loses semantic information that was in the .pl script.
> Ideally the source should either be the .pl script, or else a real hand written
> .S file with the proper comments and macros to make it readable -- not something
> in-between.
>
> Getting the license clarification and possibly other changes upstream is a good
> idea too.  I noticed, though, that the actual wording used in some files
> upstream ("Permission to use under GPLv2 terms is granted") apparently still
> isn't considered sufficient by some, so a separate clarification from Andy was
> apparently still needed: see kernel commit c2e415fe75bbc83c1...
>

Yeah. In any case, I don't think we should consider an intermediate
solution of merging a chunk of generated asm now and work out these
details later. This should be done right from the start.
