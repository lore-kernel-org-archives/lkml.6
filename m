Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-342653-1520994762-2-3030038683203686141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520994761; b=Ui4HGui/XwvHqwyN8Pp6rZDE3FRMrThw0NouiASMIcqX2UJ
    kCAMYdOJ+fkf+3XBBjqQV49stkzExuoeBiHVvSsEzHN0nBrO7hfYWrm864rHKNH4
    2Pw8J6atz68FT7yRaHknVHU0/JIt3r9uNAHQOSm5qrlM3YuHc2r+CNKjbPzuOGPI
    PFuRLiwxOw+V5tM3pusiqLuzXogIh3VJgyBWZDht+p8YPVq5nNLQfurAYEz6hgLV
    E+01EPGgvNgc+tCVsNmIzZGHtGewEhzoAYkcO8TZ1m6baGQkDfqDajnuzdTgWudw
    vlD/BhorL7jiZwzbKG43DqFqppxtEevYc6zlz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520994761; bh=Zm395As89t8DlLNFJsXUzaARZZQdpCq9M3HtPi
    IFEQ4=; b=VOZzC+0tFDwnkvPPRN7N0kF/x4YlPMFR1X7E+SMYz6B8rsKuvayQyr
    04GWJ991elwweg47xs7LfBOfNdfXf9GkWlFvI7W8R4hDMQK1IWaL6Gmld0evLmRY
    sLpoMiaDP2NV3dd/Iv7q35UT8gz66YzbW77IapO416bjSULmWR/D6yY5bhNAhckL
    Xvw8tgiw9CGXtKgBQAzTnCcT06WsdxTxLej6iytZL1DHXHbwTHGKxomMJFVhEzto
    /XNQ+4mCWEJLxqq0z9VVE5Gn1Q5RoLVhRkY9OkQV5wOg0PoRNJu2KSeLEiWxAyv0
    z2qsAvwDOKV/RKWWKItddcrolisSejcw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=VR5ZNgPe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=VR5ZNgPe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932809AbeCNCch (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 22:32:37 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61257 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeCNCcg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 22:32:36 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2E2WSrB026508
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AG47ELvwSGd4x/C3a4NXhnWxT59jHcB3CzVm6p+vEEO/+yavbuyWS37ZS0jVQLCjd0SajMHn3DLyA4gt6Xfg+0qeRr0=
MIME-Version: 1.0
In-Reply-To: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
References: <db77e20709db11b951a28c3303feb63990ef82d7.1520972030.git.leonard.crestez@nxp.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Mar 2018 11:31:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARF6vEXVxABcdQtcx0TxNaiX9_vWho1XVG0+51bu05RUg@mail.gmail.com>
Message-ID: <CAK7LNARF6vEXVxABcdQtcx0TxNaiX9_vWho1XVG0+51bu05RUg@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm,arm64 - Fix random regeneration of S_shipped
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-crypto@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 5:17 GMT+09:00 Leonard Crestez <leonard.crestez@nxp.com>:
> The decision to rebuild .S_shipped is made based on the relative
> timestamps of .S_shipped and .pl files but git makes this essentially
> random. This means that the perl script might run anyway (usually at
> most once per checkout), defeating the whole purpose of _shipped.
>
> Fix by skipping the rule unless explicit make variables are provided:
> REGENERATE_ARM_CRYPTO or REGENERATE_ARM64_CRYPTO.
>
> This can produce nasty occasional build failures downstream, for example
> for toolchains with broken perl. The solution is minimally intrusive to
> make it easier to push into stable.
>
> Another report on a similar issue here: https://lkml.org/lkml/2018/3/8/1379
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: <stable@vger.kernel.org>
> ---



Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



>  arch/arm/crypto/Makefile   | 2 ++
>  arch/arm64/crypto/Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> Not clear if this needs to go through crypto or arm but all commits in these
> directories start with "crypto:".
>
> My problems were only on arm64 because of a yocto toolchain which ships a version
> of perl which fails on "use integer;".
>
> CC stable because this can cause trouble for downstream packagers.
>
> diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
> index 30ef8e2..c9919c2 100644
> --- a/arch/arm/crypto/Makefile
> +++ b/arch/arm/crypto/Makefile
> @@ -47,20 +47,22 @@ sha256-arm-y        := sha256-core.o sha256_glue.o $(sha256-arm-neon-y)
>  sha512-arm-neon-$(CONFIG_KERNEL_MODE_NEON) := sha512-neon-glue.o
>  sha512-arm-y   := sha512-core.o sha512-glue.o $(sha512-arm-neon-y)
>  sha1-arm-ce-y  := sha1-ce-core.o sha1-ce-glue.o
>  sha2-arm-ce-y  := sha2-ce-core.o sha2-ce-glue.o
>  aes-arm-ce-y   := aes-ce-core.o aes-ce-glue.o
>  ghash-arm-ce-y := ghash-ce-core.o ghash-ce-glue.o
>  crct10dif-arm-ce-y     := crct10dif-ce-core.o crct10dif-ce-glue.o
>  crc32-arm-ce-y:= crc32-ce-core.o crc32-ce-glue.o
>  chacha20-neon-y := chacha20-neon-core.o chacha20-neon-glue.o
>
> +ifdef REGENERATE_ARM_CRYPTO
>  quiet_cmd_perl = PERL    $@
>        cmd_perl = $(PERL) $(<) > $(@)
>
>  $(src)/sha256-core.S_shipped: $(src)/sha256-armv4.pl
>         $(call cmd,perl)
>
>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv4.pl
>         $(call cmd,perl)
> +endif
>
>  .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
> diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
> index cee9b8d9..dfe651b 100644
> --- a/arch/arm64/crypto/Makefile
> +++ b/arch/arm64/crypto/Makefile
> @@ -60,20 +60,22 @@ obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
>  aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
>
>  AFLAGS_aes-ce.o                := -DINTERLEAVE=4
>  AFLAGS_aes-neon.o      := -DINTERLEAVE=4
>
>  CFLAGS_aes-glue-ce.o   := -DUSE_V8_CRYPTO_EXTENSIONS
>
>  $(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
>         $(call if_changed_rule,cc_o_c)
>
> +ifdef REGENERATE_ARM64_CRYPTO
>  quiet_cmd_perlasm = PERLASM $@
>        cmd_perlasm = $(PERL) $(<) void $(@)
>
>  $(src)/sha256-core.S_shipped: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
>
>  $(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
>         $(call cmd,perlasm)
> +endif
>
>  .PRECIOUS: $(obj)/sha256-core.S $(obj)/sha512-core.S
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
