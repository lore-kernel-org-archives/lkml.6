Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E86C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7101206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Wgzm8uwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7101206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeLEPkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:40:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37770 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEPkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:40:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so13328534wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=cRZh1Nu7vqEJtQo74H6TBhPnBTuHjZV7Sr4pkcbu+Es=;
        b=Wgzm8uwgpPfXNtvnplwdnw2sSFA4B7uC+ugodWqo0kFHyEbcYnQ7sHZ7n8mOjB2sYG
         obZV1m77xzN2kxzN57LRtvGteVj0Mlv0f1Rw0Dbbx6rZ28hBeJJA7OKz3Yj6SDnBkxwt
         QqPI4MdHttRpf8soHvY9L0hAhnCRUCxBXPtcvJ9PIXfj7LuZsvmJLE9tzZIcLO3q/1/K
         x9o354MrHVFtBq0QDAkIDRCZ+Bq8iHPF+vz8KveBAvDsO0IIxIq1ZWjdRx0c84DDQ00k
         orbe2wQufu9yyFNNMNLzPFhdYRwPvnKICwfRXVgxTEZHCfSCNhVsz1MDVyOHsqublBgj
         87Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=cRZh1Nu7vqEJtQo74H6TBhPnBTuHjZV7Sr4pkcbu+Es=;
        b=imCJRawiRm32kqzVfKxMmx8bIyQ+CA6q4iu8xjDS2FUUFqwmW4i6ca/9X02ymktasQ
         Cv4gMjjjzv9tNPj7+NH0O6cTr4u5HSX7M4ErkGYJhiiGJYrLycXZiQ3OkZTOXWnw2yYu
         LOqfGkk1icTEwHN1ykwK/US5sxYmzmHEnra6H0XPyRsyrdk1z2Y92RaOScoK0jh4SNvp
         nu6avevafIp7RVuzGO2S95NdpZgoNolCt4TJyEtiLaJ6OQpnw5EYXNk0YgKtA1sP1UmF
         eSZkOCTtVM6mWnRGctbvCDaFPZ+v86oNDc+O+5ZCmQVg4U9t8OzhkHx0MrHJc4dLkrco
         0JGA==
X-Gm-Message-State: AA+aEWYF8Cs5l4F3xqF4wAmH1KoKrdkeISSOno1LioMC1MjF2GJr0lh7
        CavJ9nMaf3++KgoWPexxGdM0itk8Gg4fdQ==
X-Google-Smtp-Source: AFSGD/UkCyke09gPcVcRIpKACkPk4oyBn3Z4mI07IpCTOLPOeLej5ahZWBe4meaAYv14YP1n0esyZw==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr16388744wmg.84.1544024452087;
        Wed, 05 Dec 2018 07:40:52 -0800 (PST)
Received: from [74.125.71.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id j8sm15838406wrt.40.2018.12.05.07.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:40:51 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
Date:   Wed, 5 Dec 2018 16:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RvVwhLGJR5KStavD1M5BS65DxOMkrsxrD"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RvVwhLGJR5KStavD1M5BS65DxOMkrsxrD
Content-Type: multipart/mixed; boundary="0TWQ9qg9x5W2c9yQU2nS8dvfBdZ2NwlMm";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>

--0TWQ9qg9x5W2c9yQU2nS8dvfBdZ2NwlMm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 8:50, Masahiro Yamada wrote:
> "make ARCH=3Dmicroblaze help" mentions simpleImage.<dt>.unstrip,
> but it never works because Makefile assumes "system.unstrip" is
> the name of DT.
>=20
> $ make ARCH=3Dmicroblaze CROSS_COMPILE=3Dmicroblaze-linux- simpleImage.=
system.unstrip
>   [ snip ]
> make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.un=
strip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
> make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
> make: *** Waiting for unfinished jobs....
>=20
> Rip off the never-working target.
>=20
> In my understanding, simpleImage.<dt> works like a phony target that
> generates multiple images. Reflect the behavior to the help message.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 0823d29..97e1384 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -89,9 +89,7 @@ define archhelp
>    echo '* linux.bin    - Create raw binary'
>    echo '  linux.bin.gz - Create compressed raw binary'
>    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
> -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dts =
linked in'
> -  echo '                   - stripped elf with fdt blob'
> -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
> +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt>.=
dts linked in'
>    echo '  *_defconfig      - Select default config from arch/microblaz=
e/configs'
>    echo ''
>    echo '  Targets with <dt> embed a device tree blob inside the image'=

>=20

I understand what you are trying to say but I would still like to keep
information about unstrip file.
It is correct that it is not build target. It is just generated file and
message above was used for description what it is.
Definitely agree that this should be the part of targets but it should
be in description.
The same is for missing description for simpleImage.<dt>.strip and
simpleImage.<dt>.ub files.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--0TWQ9qg9x5W2c9yQU2nS8dvfBdZ2NwlMm--

--RvVwhLGJR5KStavD1M5BS65DxOMkrsxrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH8X4ACgkQykllyylKDCE/EgCfdwk8ZvSbDnR0bg+6p7+pCprL
+4QAn2Fg2Mk9GMy8BR1PhSuGNeMUQBag
=PyP9
-----END PGP SIGNATURE-----

--RvVwhLGJR5KStavD1M5BS65DxOMkrsxrD--
