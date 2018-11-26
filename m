Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90171C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5371D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnT5TavK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5371D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbeK0IOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:14:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36916 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0IOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:14:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so7209507pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ET/r+ok3bQ8ZUYeeUeTpKiv1kIQw3fQzxI0dUQT7rm0=;
        b=QnT5TavKVQtMLSWitO5rb+LaXPR0IXvDqrkca3ZzR28Elp+eLcEdzYlIFZlZ3em7/6
         Xaqvl/STtBiyIgUfI8u5Q+4WRVRoB6hKe1wPtD74yI6nBXfXvzVxwSShLn9XQoEEgoul
         v5O8RrFFK1aehNr/jUzy7h24FwkQ5pFQW9huOqGz0u7LK4c1SNIsS2/dxRf9G0ghRkcr
         DG4yMDxX8/KBvJcwkzLI+KuNOMa6bURgrtYemFc8t/kJOUPS+gMfxIaGiNgyhqgsROxS
         2uKFJfyxFS94Wu6aHsqxVSJjlQMLE/DnruHUp429LzouSFnL2WDvSEQkR9roKpGTgsPJ
         24vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ET/r+ok3bQ8ZUYeeUeTpKiv1kIQw3fQzxI0dUQT7rm0=;
        b=tsCdL0MMjwqZYEtPAU92bmlGWSdFYliC6VyFrWoYf61KMaMEsFH4Zf1SdPFCuEEK8Z
         aPSzCVwtdqtqV+H1gj/d23CKL6JmCMREtVd7Ns7FwJZHfEMU2rwTwdZI1tQ6OuWw+Cav
         U5FJYnouFD8cUVUJgmKXQuj60u1V8h1R7cxRqLMmQD0mc6AyJM593fwgeVZQwbuJ5YM0
         MF4eZMYtqdPPf00Vlo2tb8+w/s3Y8fcw2kWTG9gVRPnI3j3AKPfoLpyMUU+Fuu52K4XC
         H7Rb2wP1OSzDrAoI4UDS0MknK9DDjBVYk8mEUbxqb/2rOMmovSSqXXpDcb9LmxdxyLSR
         q6sw==
X-Gm-Message-State: AGRZ1gKLg2BKaQqVqpcwjcogOYg47Djvh4tQb4JU7nihxGkMQARG3Ku5
        i7vf5hWiRNWZ69vRejNzE/E=
X-Google-Smtp-Source: AJdET5fqHywZ6FSPtWPcJ06IaP/2oT26qKe08UU+GF2s4g4YUZb1T6kZKx18J5sXhqRmpN6F0rPNqQ==
X-Received: by 2002:a62:4bc2:: with SMTP id d63-v6mr31225579pfj.170.1543267119110;
        Mon, 26 Nov 2018 13:18:39 -0800 (PST)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id v12sm1432560pgg.41.2018.11.26.13.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 13:18:38 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:18:35 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     David CARLIER <devnexen@gmail.com>
Cc:     joeypabalinas@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, aryabinin@virtuozzo.com
Subject: Re: Re: [PATCH] Little memset_explicit optimisation
Message-ID: <20181126211835.wdqiqszz6u65cbe3@gmail.com>
Mail-Followup-To: Joey Pabalinas <joeypabalinas@gmail.com>,
        David CARLIER <devnexen@gmail.com>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, aryabinin@virtuozzo.com
References: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
 <20181126113724.svbv6np25fzxkhrm@gmail.com>
 <CA+XhMqz9igfiZqRgwvfQ0c=FVyWf=ZUD0xjypEgzO27qwmBNeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p7fgi77jkdtgm5h"
Content-Disposition: inline
In-Reply-To: <CA+XhMqz9igfiZqRgwvfQ0c=FVyWf=ZUD0xjypEgzO27qwmBNeA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5p7fgi77jkdtgm5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 07:36:19PM +0000, David CARLIER wrote:
> Sorry I m not used yet at all to LKML rules.
>=20
> So here a slight difference in assembly generated between the two
> versions (amd64) :
> `
>      .loc 1 7 7
>      leaq    -12(%rbp), %rax
>      movq    %rax, -8(%rbp)
> -    .loc 1 11 2
> +    .loc 1 9 6
>      movq    -8(%rbp), %rax
>      movl    $4, %edx
>      movl    $0, %esi
>      movq    %rax, %rdi
>      call    memset@PLT
> +    movq    %rax, -8(%rbp)
>      .loc 1 13 23
>      movq    -8(%rbp), %rax
>      movl    (%rax), %eax

What is the advantage of having the added `movq %rax, -8(%rbp)` here?

The next instruction is `movq -8(%rbp), %rax` and nothing afterwords
uses the value stored in `-8(%rbp)`.

Also, is this compiled without optimization? Take a looks at the
assembly in a small test case with -O1 (making sure to use the target
variable so it isn't optimized out) and compare the assembly generated
with and without that assignment.

--=20
Cheers,
Joey Pabalinas

--5p7fgi77jkdtgm5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEENpTlWU2hUK/KMvHp2rGdfm9DtVIFAlv8YysACgkQ2rGdfm9D
tVKATw//Wwix4UmSG5SKowfLzD/VHgJ0WVGXQO7xd1K5npqdp2+jWZmeL7EQxB8U
zl4obOxOk83h54YXLxYy3AQhzo/jpBDQAypL039YErjE4G21ERvAs6oltOuKqrOI
VMOTM4C57iKhEYw8ZcRoOMmDNZmD8Q6fD6pkf2krfQcZe/v6qdSasaVbJXZ1PrNt
1JhUjLWHnHDWHSqM6erDiYRKjAqF/VsEzRkYDX6O8vpA4ckxJ4xe07cSd5XE4kjN
i1JSvV1mwv4Ed18GAkkRuvfKPo5wyLTdrWMYORXc22zUB2WmuGOA1cUm3Qrt6bcM
Uz7q316Lk5EFcwTU6EOxSmmVIKm6gcvaOzBxcCuq4ERimyQZ5sxoPYWBquQ7mapC
mMqTU8hh06hMTFeSec+AdOld1GTYF7W1gW/edkHXFJIL3KLlKNeC9lS4xx7I1C6z
puqKP+JViKUXBOpvFyN6WqNbbXfa1sU0f8F0sLuQYK5UCHnv+M7IvQS6JYWJpgnu
qyJMgh6v3ocvwj8sVB0p33MAIaC7paMvu23p8BtxTs0MdNLuAP4fCj+qQ+DmMIQ3
WTF7SLjKJJPPxMm7QBSlqIxbCnkhdj5W0PkSk4qixSp680iRM5p3jT1z2x6Db1Be
10KT10qKsIJjYCxWv7nvZpjplmmA5LnES0gicASfnCI6Za8b5Xs=
=0nC3
-----END PGP SIGNATURE-----

--5p7fgi77jkdtgm5h--
