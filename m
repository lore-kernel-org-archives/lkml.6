Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614EDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE920854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxMRXNq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCE920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGIJrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:47:33 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:35553 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:47:32 -0400
Received: by mail-lj1-f173.google.com with SMTP id p10-v6so8202596ljg.2;
        Mon, 09 Jul 2018 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZkugPRsLKgV8uirldx2wHWuvr8i1cObrx5wrGG80Yt0=;
        b=qxMRXNq5vB0it6Wh80bYYbKSMJ1Wtlu/Ap4hwB1YmlQdWPqnaD1DAGsZ+a0U2Ikzix
         oZPIdoDo1CsPo1AO588KtPNhBAihfbH+j4ylCkUZftd1b2kpXPaLr5arZ6Eu8x90J2+1
         ZPQ2BUn77AtKKgLY2vsfDxpC3UsOwl2LPNZQGzmo4+9w7hx4ob+GhiUIEOEv/Vy/pEif
         2Ol02WkOnynprp82H30pg5PVFm2xNDLQZddK7xZmByFQVKBT0lfMbWk4q/ADmMCT7IjJ
         QfQjg2bCzXyO/f+Wg6jaYB0DD9JZTH1ADP5Jo7oZeUvC8Lad0/fgFIChDQAsbSt6HQwI
         3W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZkugPRsLKgV8uirldx2wHWuvr8i1cObrx5wrGG80Yt0=;
        b=H2rWew8GgKpOJZ0f79nhuH3j+eM1G6R3D9cminEVk0TPGW2q24PAjUshE8ufFi+5OS
         RmZcdklthimNt5iB8AwmRNJXYvBIBSAxJzSet4lhbqqq/MQ2Lw6aLUj/ed1KCcASpP4P
         FxQmkEMtShAXl4wlgrJ2Gsg10bcYzytime4yh4qT9xp0ob4vdLTmKEoJFRBVeEW8YOrN
         20DwffFOkLbjtpr6ytyJXAX1rehvRtV1zJTxoGpxsJQZXjcZDPNKurlyHAAAvVQgoC1N
         TlYCMSTmvBJMHZhq66nia4K80RehzrEPuB7Kgk5actCpegI6SQhmRBUB1jP56lZGeFHc
         bmag==
X-Gm-Message-State: APt69E3wEjmfVmbZ9P5rQuJgzkk9eVF90Q2TG55IqsFv2+22v1p/5FWV
        oZ9J6Kgj3bqAUzjyt3bnY+CdTOjWjyRaZRy4sFw=
X-Google-Smtp-Source: AAOMgpdcLloJy5uVPW2B7a/8oN9lP2/7XMbzifFlXJgvujUSdK7KqJ/eGt+PVqLJuRzjL6z/IYVlZeRyC3tHkr8kVMM=
X-Received: by 2002:a2e:30a:: with SMTP id 10-v6mr11963680ljd.63.1531129650235;
 Mon, 09 Jul 2018 02:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20161213132414.GA7898@gondor.apana.org.au> <20170223125141.GA17400@gondor.apana.org.au>
 <20170714141855.GA29426@gondor.apana.org.au> <20170922084401.GA15541@gondor.apana.org.au>
 <20171128230929.GA17783@gondor.apana.org.au> <20171222064931.GA27068@gondor.apana.org.au>
 <20180105073808.GA14405@gondor.apana.org.au> <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au> <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180708162035.zunfeflnq5hgwq6n@gondor.apana.org.au> <CA+55aFwe3HrgMBUhyHC7kAOCvp31S4kpAqDSFQ+BQY6r=WBiiA@mail.gmail.com>
In-Reply-To: <CA+55aFwe3HrgMBUhyHC7kAOCvp31S4kpAqDSFQ+BQY6r=WBiiA@mail.gmail.com>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= 
        <omosnacek+linux-crypto@gmail.com>
Date:   Mon, 9 Jul 2018 11:47:42 +0200
Message-ID: <CAAUqJDsHzgGZTpYCAxAy=b3P0bq7dGrw6St68SkwjqwHpusN+A@mail.gmail.com>
Subject: Re: Crypto Fixes for 4.18
To:     torvalds@linux-foundation.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org,
        =?UTF-8?Q?Milan_Bro=C5=BE?= <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

ne 8. 7. 2018 o 20:32 Linus Torvalds <torvalds@linux-foundation.org> nap=C3=
=ADsal(a):
>
> On Sun, Jul 8, 2018 at 9:20 AM Herbert Xu <herbert@gondor.apana.org.au> w=
rote:
> >
> > - Add missing RETs in x86 aegis/morus.
>
> Side note - I queried earlier during the discussion about this: how
> was this code taken despite having clearly never tested on _anything_?
>
> That's a serious question. Code that simply has never had any testing
> AT ALL should not have gotten in.

I did test the code using the included test vectors (and I found and
resolved lots of issues before submitting the patches thanks to that).
A good deal of the test vectors actually do trigger the code path that
calls the buggy function, so somehow it must have been working despite
the bug (see below).

> The use of 'int3' in padding showed the issue, but I don't believe the
> code could possibly have worked with the nops and fallthroughs.

I just looked at the disassembly of the function and its surroundings
(as compiled by my testing environment) and it seems that by a curious
but logical coincidence, the code actually *did* work and without any
side effects (other than executing a few useless instructions before
returning).

This is what the C signatures of the relevant functions look like (for
aegis128, the other cases are analogical):

asmlinkage void crypto_aegis128_aesni_enc_tail(
        void *state, unsigned int length, const void *src, void *dst);

asmlinkage void crypto_aegis128_aesni_dec(
        void *state, unsigned int length, const void *src, void *dst);

Notice that these two functions have identical signatures, this will
be important later. Now, the disassembly for
crypto_aegis128_aesni_enc_tail looks roughly like this:

0000000000000950 <crypto_aegis128_aesni_enc_tail>:
 [some code...]
 9c3:   0f 1f 00                nopl   (%rax)
 9c6:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
 9cd:   00 00 00

00000000000009d0 <crypto_aegis128_aesni_dec>:
 9d0:   48 83 fe 10             cmp    $0x10,%rsi
 9d4:   0f 82 c3 03 00 00       jb     d9d <crypto_aegis128_aesni_dec+0x3cd=
>
 [some code...]
 d9d:   c3                      retq    # <---
<crypto_aegis128_aesni_dec+0x3cd> is here
 d9e:   66 90                   xchg   %ax,%ax

So... thanks to the NOP padding, the control after the end of the
_enc_tail function walks right into the _dec function. This looks
scary at first glance, but here we are "saved" by the combination of
the following:
1. The second argument of the _enc_tail function (length; passed via
%rsi) is implictly always less than the block size (16 or 32 bytes).
2. The second argument of the _dec function (length; also passed via
%rsi) is checked to be greater than or equal to the block size (16 or
32 bytes); if it is less, then the function does nothing and just
returns.
3. _enc_tail does not modify the value in %rsi.

In conclusion, the bug remained undiscovered not because of lack of
testing, but because by sheer luck it was "working" anyway...

Sorry for introducing this (and other) bugs that had to be fixed
post-merging (I am the one who wrote the code). It is a lot of new
code that is hard to review, as it contains a lot of repetitive
boilerplate and assembly code.

Cheers,
Ondrej
