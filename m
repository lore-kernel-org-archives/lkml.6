Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C635DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7713720685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaewYvxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7713720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeI2AL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:11:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39397 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeI2AL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:11:58 -0400
Received: by mail-io1-f66.google.com with SMTP id l7-v6so4787407iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cWEVbY7aBPyP9M9/Gswzu0SFwq+n21mwaQFIP6ZlxV0=;
        b=UaewYvxTd1TnyKeshekQCLlKQlaM87hELBYz0Iz9p7+nfRhtekUu25QgH5MsJf8owW
         9NQIOILDZahi7hMEjzE1j6WlYT03fj+Wvb3gbvcTobOIqf2j8tlNf225Xp10qiWKxWL9
         t3ky1CdoggrowhlT8/TkqgebsifgnkUiXuC90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cWEVbY7aBPyP9M9/Gswzu0SFwq+n21mwaQFIP6ZlxV0=;
        b=YloT9ewUFPE/Mdnr/U3kEzEsrfdpqyk2SJ/I1dkxGVarA+khmPEQSJFoJNJ7JWcGoh
         40h4wWrh83Ga5/Weuq3s0R48sQwkfPq3M3NaN3MgmK7s0zKR2tOsHAIcQEuYSz+CNC7O
         S0kSkeoulhGmjlR7A6wkLNkvUauYVlBmZvTIQ1v8Jl2/Nx5z/p+B90S0Hh6kDGN30it7
         NnOe3YxP24Fx+uWn8HvrLp9xlFd9UorQd5yaaGPYpaPB2TnOQiAS4ht4/ygUAfl9Dg3r
         ezJP+ezMBzofttcnyVzz81UUQsUhJYNMjeODxPwcCbQMUu+kDOfjD1454zFvUT/beQeK
         qKVw==
X-Gm-Message-State: ABuFfojbO3NZJwq2MGjgCtKLO7VhnYmQn60qNJgmwNkG6yT2cxvFDL0h
        59UfOp2MLFjH70FgdlC8PSYN3Tcu1+BaxSUbOjxGJQ==
X-Google-Smtp-Source: ACcGV60Qotq0XmUa0w1CrKrWXXPbk9nnafWhJRlM4naQ8tZCbpjV75B6vpx1K6dGuFfh2s22DzLakbTLxsI3ptxk8Cg=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr12430515iob.170.1538156826191;
 Fri, 28 Sep 2018 10:47:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 10:47:05
 -0700 (PDT)
In-Reply-To: <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180927182944.GA22921@gmail.com>
 <20180927213537.GA27576@zx2c4.com> <20180928011726.GA98113@gmail.com>
 <20180928023546.GA20765@zx2c4.com> <20180928045542.GA545@zzz.localdomain> <CAHmME9rJ4CewfDEqWh00ZowjWg9TaYpksVSzKSSxoKya-M8_LA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 19:47:05 +0200
Message-ID: <CAKv+Gu-8eiMkrJtpnMKzT=m9zGvY5qHVAmLM_rFA3gxk2gV-zw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 at 07:46, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Eric,
>
> On Fri, Sep 28, 2018 at 6:55 AM Eric Biggers <ebiggers@kernel.org> wrote:
>> And you still haven't answered my question about adding a new algorithm that is
>> useful to have in both APIs.  You're proposing that in most cases the crypto API
>> part will need to go through Herbert while the implementation will need to go
>> through you/Greg, right?  Or will you/Greg be taking both?  Or will Herbert take
>> both?
>
> If an implementation enters Zinc, it will go through my tree. If it
> enters the crypto API, it will go through Herbert's tree. If there
> wind up being messy tree dependency and merge timing issues, I can
> work this out in the usual way with Herbert. I'll be sure to discuss
> these edge cases with him when we discuss. I think there's a way to
> handle that with minimum friction.
>
>> A documentation file for Zinc is a good idea.  Some of the information in your
>> commit messages should be moved there too.
>
> Will do.
>
>> I'm not trying to "politicize" this, but rather determine your criteria for
>> including algorithms in Zinc, which you haven't made clear.  Since for the
>> second time you've avoided answering my question about whether you'd allow the
>> SM4 cipher in Zinc, and you designed WireGuard to be "cryptographically
>> opinionated", and you were one of the loudest voices calling for the Speck
>> cipher to be removed, and your justification for Zinc complains about cipher
>> modes from "90s cryptographers", I think it's reasonable for people to wonder
>> whether as the Zinc (i.e. Linux crypto library) maintainer you will restrict the
>> inclusion of crypto algorithms to the ones you prefer, rather than the ones that
>> users need.  Note that the kernel is used by people all over the world and needs
>> to support various standards, protocols, and APIs that use different crypto
>> algorithms, not always the ones we'd like; and different users have different
>> preferences.  People need to know whether the Linux kernel's crypto library will
>> meet (or be allowed to meet) their crypto needs.
>
> WireGuard is indeed quite opinionated in its primitive choices, but I
> don't think it'd be wise to apply the same design to Zinc. There are
> APIs where the goal is to have a limited set of high-level functions,
> and have those implemented in only a preferred set of primitives. NaCl
> is a good example of this -- functions like "crypto_secretbox" that
> are actually xsalsapoly under the hood. Zinc doesn't intend to become
> an API like those, but rather to provide the actual primitives for use
> cases where that specific primitive is used. Sometimes the kernel is
> in the business of being able to pick its own crypto -- random.c, tcp
> sequence numbers, big_key.c, etc -- but most of the time the kernel is
> in the business of implementing other people's crypto, for specific
> devices/protocols/diskformats. And for those use cases we need not
> some high-level API like NaCl, but rather direct access to the
> primitives that are required to implement those drivers. WireGuard is
> one such example, but so would be Bluetooth, CIFS/SMB, WiFi, and so
> on. We're in the business of writing drivers, after all. So, no, I
> don't think I'd knock down the addition of a primitive because of a
> simple preference for a different primitive, if it was clearly the
> case that the driver requiring it really benefited from having
> accessible via the plain Zinc function calls. Sorry if I hadn't made
> this clear earlier -- I thought Ard had asked more or less the same
> thing about DES and I answered accordingly, but maybe that wasn't made
> clear enough there.
>

CRC32 is another case study that I would like to bring up:
- the current status is a bit of a mess, where we treat crc32() and
crc32c() differently - the latter is exposed by libcrc32.ko as a
wrapper around the crypto API, and there is some networking code (SCTP
iirc) that puts another kludge on top of that to ensure that the code
is not used before the module is loaded
- we have C versions, scalar hw instruction based versions and
carryless multiplication based versions for various architectures
- on ST platforms, we have a synchronous hw accelerator that is 10x
faster than C code on the same platform.

AFAICT none of its current users rely on the async interface or
runtime dispatch of the 'hash'.

CRC32/c is an area that I would *really* like to clean up (and am
already doing for arm64) - just having a function call interface would
be a huge improvement but it seems to me that the choice for
monolithic modules per algo/architecture implies that we will have to
leave ST behind in this case.

On the one hand, disregarding this seems fair, at least for the
moment. On the other hand, fixing this in the crypto API, e.g., by
permitting direct function calls to synchronous hashes and without the
need to allocate a transform/request etc, blurs the line even more
where different pieces should live.

Any thoughts?
