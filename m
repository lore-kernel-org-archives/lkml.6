Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2517EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90815208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sGcu0uR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90815208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935327AbeFMR3k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:29:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28929 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeFMR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:29:39 -0400
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com [209.85.217.178]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5DHTIKa032596;
        Thu, 14 Jun 2018 02:29:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5DHTIKa032596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528910958;
        bh=9a7uAMKj+IsHobLYy3wc4dYcVXbWgQH9yHozJMoMZYw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sGcu0uR1dFb5Uh4IDQNskCbjhAQI1EjTfBgO9VbSBGutmebahpbp4CWjYS34so/BN
         6MxpqP9kp4G8ria8u1/s/7xJyC88d+7/inuz9F7Nue6FLI+Qva+qZ1cCPxI/TxY87s
         lXyJ1ngtAeLKFeUhTPYIkZrNGLlkfSwGPEBWCFOtPnfbk8M/tJfiTj9Wz0CErnuy/2
         fLWxS/T2vv65iyKBU0LnNmSiHsibm97ATR2KSfQ8Zqqds8vO05zmHMz8OCFr8eaB9E
         P9N7EwNQ5QVJphSL4AdnV38V1ygY1fHVc2xEnity1t7jd6/ERMTgYr4hWXU05dBMyX
         6DyzFnTOj2CWQ==
X-Nifty-SrcIP: [209.85.217.178]
Received: by mail-ua0-f178.google.com with SMTP id c23-v6so2268085uan.3;
        Wed, 13 Jun 2018 10:29:18 -0700 (PDT)
X-Gm-Message-State: APt69E3TjaVsS1FbwUh0MLG3phgzU6E0+1uGhuMF2Nd71ukr7NDpvZ5s
        g6nzdNED2sSOgpubcNS0x6M1I/ohVhK6SCqauZY=
X-Google-Smtp-Source: ADUXVKIsYhxwOUaGhFdKx0XYVoKLvEBSf3E2yi30yraH4B7IOtSPvPjIul4qMKzDX+nA9gETX5g8VdK3YcWpi8pHios=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr3875835uae.199.1528910957303;
 Wed, 13 Jun 2018 10:29:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:28:36
 -0700 (PDT)
In-Reply-To: <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
References: <CAK7LNARDLbEhbJGrKY6HGwfxL8ebAMBDa_2A+s2QkzQGEKyFHQ@mail.gmail.com>
 <CA+55aFyxY9f9_eGv3CvA0zwzo8K5WeNbNPDFuyhtCrzRyic85A@mail.gmail.com> <CA+55aFy2KEzTiF=0nG8_RFoPpycaqc=n-hf-mQSbKotMzYJG-w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Jun 2018 02:28:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
Message-ID: <CAK7LNASd7Mc8eU76L24ZC0OFdUf566adNGVvX9Ou987cT3CCWw@mail.gmail.com>
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

2018-06-14 1:03 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Wed, Jun 13, 2018 at 8:55 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Wed, Jun 13, 2018 at 7:47 AM Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>> >
>> > Please pull more Kbuild updates.
>>
>> Pulled. However, I notice a few oddities.
>
> Oh, and one actual bug: "make oldconfig" doesn't work right.
>
> I used to have
>
>   CONFIG_HAVE_CC_STACKPROTECTOR=y
>   # CONFIG_CC_STACKPROTECTOR_NONE is not set
>   # CONFIG_CC_STACKPROTECTOR_REGULAR is not set
>   # CONFIG_CC_STACKPROTECTOR_STRONG is not set
>   CONFIG_CC_STACKPROTECTOR_AUTO=y
>
> which means that since my compiler supports -fstack-protector-strong,
> I should get CONFIG_CC_STACKPROTECTOR_STRONG.
>
> But that's not at all what I get. I get
>
>   CONFIG_HAVE_CC_STACKPROTECTOR=y
>   CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
>   CONFIG_CC_STACKPROTECTOR=y
>   # CONFIG_CC_STACKPROTECTOR_STRONG is not set
>   CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
>
> ie CONFIG_CC_STACKPROTECTOR_STRONG basically went away.
>
> The reason for that is that it takes the *old* value of
> CONFIG_CC_STACKPROTECTOR_STRONG, which was "no", but that's wrong.
>
> The meaning of the config option has changed, but it took the default
> from the old meaning, and decided that I shouldn't get strong stack
> protection any more.
>
> This is a pretty dangerous silent change.
>
>                Linus


Sorry, I did not notice this case.


I cannot come up with a name better than CC_STACKPROTECTOR_STRONG.


Another solution might be,
to add _AUTO back again for the backward-compatibility.


config CC_STACKPROTECTOR_AUTO
       bool "Stack Protector Auto (backward compatibility)"
       select CC_STACKPROTECTOR_STRONG if $(cc-option,-fstack-protector-strong)
       select CC_STACKPROTECTOR if $(cc-option,-fstack-protector)
       depends on HAVE_CC_STACKPROTECTOR
       help
         This option is here to not break "make oldconfig". If the old .config
         file enabled CC_STACKPROTECTOR_AUTO, CC_STACKPROTECTOR_STRONG should
         be enabled when compiler supports it.
         This will be removed after v4.19.



If a user previously chose _AUTO
and the compiler supports -fstack-protector-strong,
CC_STACKPROTECTOR_STRONG is forcibly enabled.

Of course, this is ugly.
I do not want to carry it for a long time
even if we decide this is necessary.

-- 
Best Regards
Masahiro Yamada
