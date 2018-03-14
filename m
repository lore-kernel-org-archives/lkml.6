Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1132802-1521013549-2-3231033058421470826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521013548; b=KMYHNUolobNDbq1g8S7/cwEwNQ391zvwlsup9CBF7wEyPZO
    KbeyGziR3rCi+X9bD8rIEyH6ktByYaqY23LWWpG7nhJVif50+Afh1cj376HbfTqF
    dwib8rl4zUK+V7YrZemeGjm4z40IS/uIuvBMxbZxVag2uqN0QA4lEzt5YQHq05LJ
    w4IBtKMXLWfKm6nGuRLIFFrvmvyRpdqIf0KiCEdlK5dyNkdx9L/vw5qDeZ43tX78
    4wCzdgVtiLIfh+eGVHZDqW+q3Ovi80riLPiBEyu/Pv7UizNtacbLtZ0mJj7ADne6
    NbmGNZtpnOwCwgiehte1+dkrEjvNf93m/A4UHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521013548; bh=9pBsCllQaicXKAdkicb4FHSYtCysE5fNuLye3X
    4AwSw=; b=vB4OILSdaKfj6i7Pr576X+wH8labjI7A5f6RXBJNtQCq2lnFaVxJgG
    h73T4Wie/HYinIVuwhVTdVkenWNvW3jiu4FeJ55H2VAxJJmCCLyfg/LIE51znMoY
    PppXrj3EezvZBs7dywxLDXWbTlqSO24ccwUwffXKKPgP2z2WrHkov0iibA8BFSys
    cNDFJgDKaZdcmP/JVndvuzvLuNP6oAxE2S1o1BorjUHPXpq3m2b99DonX0LvRIpl
    9xfdfXQoDXv0L9M6fnlfD9GEZOxStL3xOZAp2jfcuUzwdeyM9M3WDq8N0bSFq6mY
    Xy5Foz24KflOXwoxSHnXlJC+pqh8xYnQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kyGmoalw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HTuO9Bae;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kyGmoalw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HTuO9Bae;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeCNHpq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 03:45:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33115 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbeCNHpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 03:45:46 -0400
X-Google-Smtp-Source: AG47ELthdcbMV1TGtsEo3ZeVC08211IPTqkeVMyAmFaapYmG1KgEhRNu6z1RaQSb0WxWLwYy9tdhPfiY11l9+OUw7g0=
MIME-Version: 1.0
In-Reply-To: <CAK7LNARF6vEXVxABcdQtcx0TxNaiX9_vWho1XVG0+51bu05RUg@mail.gmail.com>
References: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
 <CAK7LNARF6vEXVxABcdQtcx0TxNaiX9_vWho1XVG0+51bu05RUg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 14 Mar 2018 07:45:44 +0000
Message-ID: <CAKv+Gu85AQPLezV3vs7Nzpd=kOgFrYm9MVY3Axtn6onOtW9WGA@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm,arm64 - Fix random regeneration of S_shipped
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 March 2018 at 02:31, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-14 5:17 GMT+09:00 Leonard Crestez <leonard.crestez@nxp.com>:
>> The decision to rebuild .S_shipped is made based on the relative
>> timestamps of .S_shipped and .pl files but git makes this essentially
>> random. This means that the perl script might run anyway (usually at
>> most once per checkout), defeating the whole purpose of _shipped.
>>
>> Fix by skipping the rule unless explicit make variables are provided:
>> REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.
>>
>> This can produce nasty occasional build failures downstream, for example
>> for toolchains with broken perl. The solution is minimally intrusive to
>> make it easier to push into stable.
>>
>> Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379
>>
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>
>
>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>
>
>>  arch/arm/crypto/Makefile   | 2 ++
>>  arch/arm64/crypto/Makefile | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> Not clear if this needs to go through crypto or arm but all commits in these
>> directories start with "crypto:".
>>
>> My problems were only on arm64 because of a yocto toolchain which ships a version
>> of perl which fails on "use integer;".
>>
>> CC stable because this can cause trouble for downstream packagers.
>>
>> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
>> index 30ef8e2..c9919c2 100644
>> --- a/arch/arm/crypto/Makefile
>> +++ b/arch/arm/crypto/Makefile
>> @@ -47,20 +47,22 @@ sha256-arm-y        := sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
>>  sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
>>  sha512-arm-y   := sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
>>  sha1-arm-ce-y  := sha1-ce-core.o sha1-ce-glue.o
>>  sha2-arm-ce-y  := sha2-ce-core.o sha2-ce-glue.o
>>  aes-arm-ce-y   := aes-ce-core.o aes-ce-glue.o
>>  ghash-arm-ce-y := ghash-ce-core.o ghash-ce-glue.o
>>  crct10dif-arm-ce-y     := crct10dif-ce-core.o crct10dif-ce-glue.o
>>  crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
>>  chacha20-neon-y := chacha20-neon-core.o chacha20-neon-glue.o
>>
>> +ifdef REGENERATE_ARM_CRYPTO
>>  quiet_cmd_perl = PERL    $@
>>        cmd_perl = $(PERL) $(<) > $(@)
>>
>>  $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
>>         $(call cmd,perl)
>>
>>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
>>         $(call cmd,perl)
>> +endif
>>
>>  .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
>> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
>> index cee9b8d9..dfe651b 100644
>> --- a/arch/arm64/crypto/Makefile
>> +++ b/arch/arm64/crypto/Makefile
>> @@ -60,20 +60,22 @@ obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
>>  aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
>>
>>  AFLAGS_aes-ce.o                := -DINTERLEAVE=4
>>  AFLAGS_aes-neon.o      := -DINTERLEAVE=4
>>
>>  CFLAGS_aes-glue-ce.o   := -DUSE_V8_CRYPTO_EXTENSIONS
>>
>>  $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
>>         $(call if_changed_rule,cc_o_c)
>>
>> +ifdef REGENERATE_ARM64_CRYPTO
>>  quiet_cmd_perlasm = PERLASM $@
>>        cmd_perlasm = $(PERL) $(<) void $(@)
>>
>>  $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
>>         $(call cmd,perlasm)
>>
>>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>>         $(call cmd,perlasm)
>> +endif
>>
>>  .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
>> --
>> 2.7.4
>>
>
>
>
> --
> Best Regards
> Masahiro Yamada
