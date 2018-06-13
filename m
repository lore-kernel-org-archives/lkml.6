Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D2C5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE75208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="v8rxT0YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE75208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935510AbeFMSQb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:16:31 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61321 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935219AbeFMSQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:16:30 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w5DIGQHY023114;
        Thu, 14 Jun 2018 03:16:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w5DIGQHY023114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528913787;
        bh=W9O7KWJDFVwC0wesIEzoAzjYrkRU36MlGpIGVH65VBc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=v8rxT0YPedcf0Ts011X4R8v6UO0PdPAfh5vl2KFZXVMpAo8veXql9sTRZQTlrJscF
         tUm5vKbfI7tvs9xVH5tQGgNFxnjZEteNpjm4wIi98qwICYDuVU0G2khWRISL0qnn/u
         HViVVVUkPt2ZN/kdVxN/KnMxK9u+EvrXxYs2+RzvAEjTxzAwFMuoSZg74KicHqHO6g
         MDuNQmLz8kTFCD4uB5+SNzsG2jnuBtXacD8ccyHju+fTgOTQrIDveRIiG3Rr1xK6K5
         e1CoDU6bJv91iEZCmprokMVCR5iSdBWJCvZq57iEpi6sW/s5QJXhnBWgmdvVI5kU9H
         guk9ELp6ufD1w==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id o138-v6so2099823vkd.3;
        Wed, 13 Jun 2018 11:16:27 -0700 (PDT)
X-Gm-Message-State: APt69E28J9pRVEnkmzo38sKIjLj6D0bOcyq6msoE+3TpSi33A33TG0Mp
        d5xsCq9ubWsjR5uGlqJdIEyhQHAajLigKWB/zdc=
X-Google-Smtp-Source: ADUXVKJOZfSTNw8HaILNBaK56nHNEkSJQz6TJHGXPSfxYn2QI6AV8yc2cRH95Z7kThAPtHqyljcsBTWyuI4WA5X3zts=
X-Received: by 2002:a1f:a945:: with SMTP id s66-v6mr3902661vke.54.1528913785839;
 Wed, 13 Jun 2018 11:16:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 11:15:45
 -0700 (PDT)
In-Reply-To: <CA+55aFz7KGMcvABxJfYs719ySyt2JouDX9t0SAV4Qu9yY9tfPA@mail.gmail.com>
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com>
 <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
 <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com> <CA+55aFz7KGMcvABxJfYs719ySyt2JouDX9t0SAV4Qu9yY9tfPA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 03:15:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4m8JgOttC5D16ALKqvMtt-6Vi4nFUdVaTMQSQPwYN-w@mail.gmail.com>
Message-ID: <CAK7LNAT4m8JgOttC5D16ALKqvMtt-6Vi4nFUdVaTMQSQPwYN-w@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for 4.18 (2nd round)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

2018-06-14 2:49 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Jun 13, 2018 at 10:29 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> I cannot come up with a name better than CC_STACKPROTECTOR_STRONG.
>
> How about just calling it STACKPROTETOR_STRONG and leaving it at that?

Good idea!

> Make the "CC_HAVE_xyz" model for compiler feature tests, but when
> actually picking an actual option, it's not really about the compiler
> any more, except in the sense that it depends on it.

I agree.

I just respected the original naming,
but CC_ is not sensible any more.


> I guess we could leave the CC_STACKPROTECTOR option as-is, just
> because it apparently has a lot of small uses in actual code too, but
> there is absolutely nothing that uses CONFIG_CC_STACKPROTECTOR_STRONG
> outside of the actual compiler option choice (and config files)

I agree to rename CC_STACKPROTECTOR_STRONG to STACKPROTECTOR_STRONG.
But, I'd like to rename CC_STACKPROTECTOR to STACKPROTECTOR as well.

I guess 30 lines or so in the C code usage.

Could you run sed directly in your tree?



-- 
Best Regards
Masahiro Yamada
