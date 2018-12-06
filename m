Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5E20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="RxyVmOyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbeLFMxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:53:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:53:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so364363wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=0V9j8FBjlIv/o4np8uDO/+zWj9v7ppn4cjjieNMYW/s=;
        b=RxyVmOyXSLEZs4/FhRN1TobJeaosXRImSP3FD5dTT0BC9MjoQ24czt9Z73B6SXBFTS
         /DvmZfwtFaaEv+MejSuNzJ/Z3/WWfuDKeiQ3cuD/xoSU4hwt9Ey6KwPQ4fhRGEVSpRSh
         9qHgLChbUE1pfAVZzsqABgMHPWWHNJv3sX8pfFBL3ANGEswNgW0tP4OHXbmVmm1IXZr5
         WSMunWcQUnBp2+6s4uP1X2JA4RF98D1KJzxJqgczBc5lae79GcVMuu/l4kiZfxE4oRRA
         iNCessqMhlmfH5tTzZTyLCxQdo2D7jskVSLc7SO/99aE4KxqCbfZvK60i7olor3It70M
         8m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=0V9j8FBjlIv/o4np8uDO/+zWj9v7ppn4cjjieNMYW/s=;
        b=Xh9CldSKJCaE72P2mD1XHi8Fgb4hMsBZrrbhEPYqfSM3w7FqzshS5CzvZQH0+hLpAM
         emg99MHUz9mta5NsO/sGUi1nQXD/vKoNdX6Od1lvP6RyM/Jo28GPMJ4kbwx3/QSFjwvx
         qOu5GL5gJsd3IJYXMi4arWAVU0yG0vC5OikNMiDXqHIYTlzW4URBad7XJsFgDnLqODIV
         QKfE/DZ9upLvKOUF9FofKDn+k0Vef/VRka84xLxG7F3JkeBsvppqzKpKIuruxB+2gBlh
         wX4vzqcIb47nGzn3W2xKmwiRnxOoiijzkFMvlWhVXsMcrNXTsZ3OBp5Q1d5VjwoJBWto
         LmAw==
X-Gm-Message-State: AA+aEWZNkK3qbX/M+U/OZ7UIZ+J8Vf6GljtpJ/W7bJysrvLoJWY9dcsd
        NigUL8vU8bQk8IvlGxPmZXsWPNUk5LC9lA==
X-Google-Smtp-Source: AFSGD/Vfc98tmk4sSJgPvdxIqc0x86lERBlUhvEPUBFFCSPsn+FVaUwWvtVVFQ/Mej2MrAE4KRXYxQ==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr25728563wru.152.1544100780887;
        Thu, 06 Dec 2018 04:53:00 -0800 (PST)
Received: from [173.194.76.109] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id y8sm1085466wmg.13.2018.12.06.04.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:52:59 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
 <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
 <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
Date:   Thu, 6 Dec 2018 13:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XhLnlO5rQel1C0IKrmcNm3vvWto4s6IIa"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XhLnlO5rQel1C0IKrmcNm3vvWto4s6IIa
Content-Type: multipart/mixed; boundary="4s1YDqlLOFzzUUEdBjGQo53mcbR8Op90C";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>
Message-ID: <c8283f39-2d68-f7f7-82ee-c0da75755e5b@monstr.eu>
Subject: Re: [PATCH 2/7] microblaze: adjust the help to the real behavior
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-3-git-send-email-yamada.masahiro@socionext.com>
 <80bf0f6e-8f1f-314e-b22d-6e786cf15e45@monstr.eu>
 <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>
In-Reply-To: <CAK7LNAQBFfaJbFXf5h9LX689RUwA4kSeqPrimVOWDWq0XAVJ_Q@mail.gmail.com>

--4s1YDqlLOFzzUUEdBjGQo53mcbR8Op90C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06. 12. 18 6:27, Masahiro Yamada wrote:
> Hi Michal,
>=20
> On Thu, Dec 6, 2018 at 12:41 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>> "make ARCH=3Dmicroblaze help" mentions simpleImage.<dt>.unstrip,
>>> but it never works because Makefile assumes "system.unstrip" is
>>> the name of DT.
>>>
>>> $ make ARCH=3Dmicroblaze CROSS_COMPILE=3Dmicroblaze-linux- simpleImag=
e.system.unstrip
>>>   [ snip ]
>>> make[1]: *** No rule to make target 'arch/microblaze/boot/dts/system.=
unstrip.dtb', needed by 'arch/microblaze/boot/dts/system.dtb'.  Stop.
>>> make: *** [Makefile;1060: arch/microblaze/boot/dts] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>
>>> Rip off the never-working target.
>>>
>>> In my understanding, simpleImage.<dt> works like a phony target that
>>> generates multiple images. Reflect the behavior to the help message.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  arch/microblaze/Makefile | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>>> index 0823d29..97e1384 100644
>>> --- a/arch/microblaze/Makefile
>>> +++ b/arch/microblaze/Makefile
>>> @@ -89,9 +89,7 @@ define archhelp
>>>    echo '* linux.bin    - Create raw binary'
>>>    echo '  linux.bin.gz - Create compressed raw binary'
>>>    echo '  linux.bin.ub - Create U-Boot wrapped raw binary'
>>> -  echo '  simpleImage.<dt> - ELF image with $(arch)/boot/dts/<dt>.dt=
s linked in'
>>> -  echo '                   - stripped elf with fdt blob'
>>> -  echo '  simpleImage.<dt>.unstrip - full ELF image with fdt blob'
>>> +  echo '  simpleImage.<dt> - Create images with $(arch)/boot/dts/<dt=
>.dts linked in'
>>>    echo '  *_defconfig      - Select default config from arch/microbl=
aze/configs'
>>>    echo ''
>>>    echo '  Targets with <dt> embed a device tree blob inside the imag=
e'
>>>
>>
>> I understand what you are trying to say but I would still like to keep=

>> information about unstrip file.
>> It is correct that it is not build target. It is just generated file a=
nd
>> message above was used for description what it is.
>> Definitely agree that this should be the part of targets but it should=

>> be in description.
>> The same is for missing description for simpleImage.<dt>.strip and
>> simpleImage.<dt>.ub files.
>>
>> Thanks,
>> Michal
>>
>=20
> If we want to be precise to the current behavior,
> we could describe more.
> (Is it too much?)
>=20
>=20
> Architecture specific targets (microblaze):
> * linux.bin    - Create raw binary
>   linux.bin.gz - Create compressed raw binary
>   linux.bin.ub - Create U-Boot wrapped raw binary
>   simpleImage.<dt> - Create the following images with
> arch/macroblaze/boot/dts/<dt>.dts linked in

type - microblaze
maybe <dtb> here.

>                      simpleImage.<dt>        : raw image
>                      simpleImage.<dt>.ub     : raw image with U-Boot he=
ader
>                      simpleImage.<dt>.unstrip: ELF (identical to vmlinu=
x)
>                      simpleImage.<dt>.strip  : stripped ELF
>   *_defconfig      - Select default config from arch/microblaze/configs=

>=20
>=20
>=20
>=20
> If you want to modify as you like,
> I will not touch it though.

what you have above is fine for me.

>=20
>=20
>=20
>=20
>=20
> BTW, "make ARCH=3Dmicroblaze help" looks like follows:
>=20
> * linux.bin    - Create raw binary
>   linux.bin.gz - Create compressed raw binary
>   linux.bin.ub - Create U-Boot wrapped raw binary
>   simpleImage.<dt> - ELF image with /boot/dts/<dt>.dts linked in
>                    - stripped elf with fdt blob
>   simpleImage.<dt>.unstrip - full ELF image with fdt blob
>   *_defconfig      - Select default config from arch/microblaze/configs=

>=20
>=20
>=20
>=20
> Since "arch" is not set anywhere, $(arch) is empty,
> "ELF image with /boot/dts/<dt>.dts linked in" looks strange.

As I said good to fix it in a way you have above.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--4s1YDqlLOFzzUUEdBjGQo53mcbR8Op90C--

--XhLnlO5rQel1C0IKrmcNm3vvWto4s6IIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwJG6UACgkQykllyylKDCFG0wCdFaOySdaGtiKgunnsBtCKqcRa
4twAn17bVP52XUKPS4xARzOsfE25hF8+
=NNt/
-----END PGP SIGNATURE-----

--XhLnlO5rQel1C0IKrmcNm3vvWto4s6IIa--
