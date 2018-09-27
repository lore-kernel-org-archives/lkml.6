Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1B216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EayIhUrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeI1Bse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:48:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44350 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeI1Bse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:48:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so3517569ljq.11;
        Thu, 27 Sep 2018 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auLuB8uXCRK/MMWVNLUAYtXdgKBzwKolnyd+KGtVbMM=;
        b=EayIhUrGqord+4HOepEU9H1NRUjqmh3rpWIyj0WpkE5E0rUQdrM8LNSSLkk1wG3kmw
         mHHNMa4RhCWfnvTgFis4AZbXAFDGEUIVihPF6b22f95I88q6mbTCQc/ErCUPl0DZrK7n
         f++NhcZrb2e1bPGqRaacP66g/+KjK4VxdxAN3kIIiOx3v+OHgOywlzzNUlOH7JgGo0TL
         4Dxqsmv49J+PvrL3Y6krWncGGfBlmv9ZzY2ySFJk1sSuhC3f3/EjJvKkUXs0VWumuKS+
         1Fz5bIEYANWpFHyb/PQTQom9vn/44S+iTvs4rZForVf6sfzJCd1ydap3fXwAkF9aWA3O
         2Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auLuB8uXCRK/MMWVNLUAYtXdgKBzwKolnyd+KGtVbMM=;
        b=eSyRIiCaO0hht7oSWLOkc4TxspWL15c0TlREaDXopa29pSZrbAJ7XaDKUaFDiYhAjS
         NzX7ccEuNW3Qdd0ikEd3Q6lXEstpHevK9Dpg2bOBddxsbSi8pWGlJwJkWeJ6qMdW8lFd
         qlprTQPqHxGLkwW8N1RWcHOGEFrbWwPTa6uMOE3KwQu1LEJAdvsAmvFTbosF/uus54zO
         mZfJ3Wx1FEHygQQi0DTpZzk+/8TAkwUm3fqMZagFFwzeTJpr6hC1Ob/YW5hzO7xCfbUn
         J8ReIlXHgthGLifzo+cuTWwIv4eNhKj4NaFvuHSNY/NzlQ6AOdBTXcsc6IMcIrkrbY73
         l/ZA==
X-Gm-Message-State: ABuFfoic2n4r/ge1glHPz/pAkUx96vx5jekHLz2ALSrmG2iqh4MYBJTm
        sjweaY1oT68wgWxpqL8bklBdwVG+2jpFDo7uzK4=
X-Google-Smtp-Source: ACcGV617ppSI7CZ+Eu+6yT9Q9jaYblH2ZBdJS5TLllikBRGi/4/M9+cBNWpgQcKZsUfItjr0ktzrb0igqDa0rRqbzJ4=
X-Received: by 2002:a2e:3211:: with SMTP id y17-v6mr3297138ljy.149.1538076523547;
 Thu, 27 Sep 2018 12:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <113445.1538002178@turing-police.cc.vt.edu>
In-Reply-To: <113445.1538002178@turing-police.cc.vt.edu>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Thu, 27 Sep 2018 21:28:32 +0200
Message-ID: <CAAUqJDtaa-ABP9pRKPzG-qOSzFJShF7J8gZzDThi5Jrf87UAXA@mail.gmail.com>
Subject: Re: [PATCH] crypto/morus(640,1280) - make crypto_...-algs static
To:     valdis.kletnieks@vt.edu
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=A1t 27. 9. 2018 o 0:50 <valdis.kletnieks@vt.edu> nap=C3=ADsal(a):
> sparse complains thusly:
>
>   CHECK   arch/x86/crypto/morus640-sse2-glue.c
> arch/x86/crypto/morus640-sse2-glue.c:38:1: warning: symbol 'crypto_morus6=
40_sse2_algs' was not declared. Should it be static?
>   CHECK   arch/x86/crypto/morus1280-sse2-glue.c
> arch/x86/crypto/morus1280-sse2-glue.c:38:1: warning: symbol 'crypto_morus=
1280_sse2_algs' was not declared. Should it be static?
>   CHECK   arch/x86/crypto/morus1280-avx2-glue.c
> arch/x86/crypto/morus1280-avx2-glue.c:38:1: warning: symbol 'crypto_morus=
1280_avx2_algs' was not declared. Should it be static?
>
> and sparse is correct - these don't need to be global and polluting the n=
amespace.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Indeed, this should be fixed, thanks!

Acked-by: Ondrej Mosnacek <omosnacek@gmail.com>

> ---
> diff --git a/include/crypto/morus1280_glue.h b/include/crypto/morus1280_g=
lue.h
> index b26dd70efd9a..ba782e10065e 100644
> --- a/include/crypto/morus1280_glue.h
> +++ b/include/crypto/morus1280_glue.h
> @@ -82,7 +82,7 @@ void cryptd_morus1280_glue_exit_tfm(struct crypto_aead =
*aead);
>         { \
>         } \
>         \
> -       struct aead_alg crypto_morus1280_##id##_algs[] =3D {\
> +       static struct aead_alg crypto_morus1280_##id##_algs[] =3D {\
>                 { \
>                         .setkey =3D crypto_morus1280_glue_setkey, \
>                         .setauthsize =3D crypto_morus1280_glue_setauthsiz=
e, \
> diff --git a/include/crypto/morus640_glue.h b/include/crypto/morus640_glu=
e.h
> index 90c8db07e740..27fa790a2362 100644
> --- a/include/crypto/morus640_glue.h
> +++ b/include/crypto/morus640_glue.h
> @@ -82,7 +82,7 @@ void cryptd_morus640_glue_exit_tfm(struct crypto_aead *=
aead);
>         { \
>         } \
>         \
> -       struct aead_alg crypto_morus640_##id##_algs[] =3D {\
> +       static struct aead_alg crypto_morus640_##id##_algs[] =3D {\
>                 { \
>                         .setkey =3D crypto_morus640_glue_setkey, \
>                         .setauthsize =3D crypto_morus640_glue_setauthsize=
, \
>
