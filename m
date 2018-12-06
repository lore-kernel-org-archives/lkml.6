Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843A6208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Q69TCf6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843A6208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeLFNJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:09:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbeLFNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:09:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so417222wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=SkGYKmhrfZQzaNFaeWcIyd7ck2LV9j5pi64Ks0325pc=;
        b=Q69TCf6hvRWYs0L24ei/4Fkm3gDL3kbLqjtK20h3vDoki7tBAzugIaCS+5Pn4llS/M
         LqOUMDlO0Jli4VJ0ZE5Lu3bFWvtl1tMPRErcwO6CE0N0/Va6vpM8KE1zHYPCYgZYrSXV
         k2qsJAGBrLn+5HYi10F5TWxzwL8/Km7DgURzggP4jwzqnRePxOP5oltSiYOJ3NvwFy/M
         rQFTNbnWaA5NoMSDr0EXLPXhtqL7eSr5K94zBlCcTc51jG+5pEsPX51KGABZMAdaqP6g
         kgyGXrgEs4H6tgbXU+OptVZIP8M3am1OUVsvPpt/IQ7jPTRsZP4eUak7z4KLTkpfZR0L
         PLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=SkGYKmhrfZQzaNFaeWcIyd7ck2LV9j5pi64Ks0325pc=;
        b=DOz4Xs5HxWieZXyb079dhHl1JJZDhnIKGylzSy37hsjkpIFx5oIdaWY0y5Bmy8U3io
         4F80XM3rhfvhn4RSzfrWfOSoSJpV5I8nC1xZD/Hq7uBRVzvDE1/Cz2TA+U3zjOUvcOct
         uf60JUqAHuqlaufbQ3xP9/dQf7BO+MD3TQuy3wz/bqYY3qZVp3G9rCP6FHWJnjqBbWs8
         MUgsW2VCnlPxNsyY9oyM7I+JIlmXwpJ5bln17DhEMY2mm3MTZiuV6u0J6xX3pXtrK4b8
         XIJQ/uMB+O1+P+GRD9n7zLzr8XugpiCoqA9qB3ORrnX+vo8hsSUmrmw8A4NxPS9bfWME
         Ydkw==
X-Gm-Message-State: AA+aEWYhDQxwYIHQ9LRWusT/z61B0dS09tFenKlNF5dgrIaYCLKmLGWY
        KB5QBdfHVNpBLg343YT/Ly11zg==
X-Google-Smtp-Source: AFSGD/XQ/E/nGW1A7xFkLy+HkW9FoWeyXlxLefXp6uVWrylzimdL0Th7xARwdxuxDOkoHSt5EfbayA==
X-Received: by 2002:adf:be8d:: with SMTP id i13mr26327112wrh.235.1544101770911;
        Thu, 06 Dec 2018 05:09:30 -0800 (PST)
Received: from [108.177.15.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id g188sm377902wmf.32.2018.12.06.05.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 05:09:28 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
 <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <8dd96009-976b-99a5-c8e5-8a2242a04371@monstr.eu>
Date:   Thu, 6 Dec 2018 14:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xVjJa22C8ZUdUVhqaibgSri8AbzwxfX5N"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xVjJa22C8ZUdUVhqaibgSri8AbzwxfX5N
Content-Type: multipart/mixed; boundary="q3oKDBuMMQBmesEffbWlXj9Y2IOPo3avY";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <8dd96009-976b-99a5-c8e5-8a2242a04371@monstr.eu>
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot
 images
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <dd726c23-7c37-2b38-5b9f-a4edc391511d@monstr.eu>
 <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>
In-Reply-To: <CAK7LNARtiP2xnB3hK92QJ_GadnViCG7kxXW73RmjzQAxJM4GKQ@mail.gmail.com>

--q3oKDBuMMQBmesEffbWlXj9Y2IOPo3avY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 06. 12. 18 6:08, Masahiro Yamada wrote:
> Hi Michal,
>=20
> On Thu, Dec 6, 2018 at 1:41 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>> On 03. 12. 18 8:50, Masahiro Yamada wrote:
>>> This patch set fixes various issues in microblaze Makefiles.
>>>
>>> BTW, "simpleImage.<dt>" works like a phony target to generate the
>>> following four images, where the first three are just aliases.
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>:
>>>          identical to arch/microblaze/boot/linux.bin
>>
>> It is not - fdt section should be empty.
>> simpleImage has this section filled.
>>
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>>>          identical to vmlinux
>>
>> The same here with filled section.
>=20
>=20
> vmlinux is built anyway
> for whatever target you are building.
>=20
> What is the point of making a copy of vmlinux?
> They are the same.
> You can confirm it by 'diff'
>=20
> $ export CROSS_COMPILE=3Dmicroblaze-linux-
> $ make ARCH=3Dmicroblaze  defconfig
> $ make -j8 ARCH=3Dmicroblaze   simpleImage.system
> $ diff arch/microblaze/boot/simpleImage.system.unstrip  vmlinux

I can't remember the reason for this. Maybe it was just a copy from
PowerPC which started to use this simpleImage format in past and MB just
copied it.

>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>>>          identical to arch/microblaze/boot/linux.bin.ub
>>
>> as above.
>>
>>>
>>>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>>>          stripped vmlinux
>>
>> And this is there because unstrip version is quite huge and for early
>> issues you need to know only some symbols that's why debugger is not
>> overflow with stuff which none needs.
>> Maybe this is not an issue now but that strip version is used a lot.
>>
>>
>>>
>>> I am not sure how much useful those copies are,
>>> but, I tried my best to keep the same behavior.
>>>
>>> IMHO, I guess DTB=3D<dt> would be more sensible,
>>> but it is up to Michal.
>>
>> What do you mean by this exactly?
>=20
>=20
> As I showed above,
> arch/microblaze/boot/simpleImage.system.unstrip
> is exactly the same as vmlinux.
>=20
> arch/microblaze/boot/simpleImage.<dt>
> is objcopy'ed binary of vmlinux.
>=20
> arch/microblaze/boot/simpleImage.<dt>.ub
> is objcopy'ed binary of vmlinux, with u-boot header prepended.
>=20
> You have already build-rules for them.
>=20
>=20
>=20
> It is true that the stripped image only exist in simpleImage,
> but I think "arch/microblaze/boot/vmlinux.strip"
> is a more sensible name.
>=20
>=20
>=20
> What I want to point out is:
>     "Which file should be compiled in",
>     is a part of the configuration.
>     We generally do not change the final
>     target name just for the difference of
>     configuration.
>     For example, ARM just uses "vmlinux", "Image", "zImage", etc.
>     Never duplicate target-specific copies depending on configuration.
>=20
>=20
> Why does microblaze create copies for each DT
> instead of using generic image like linux.bin, linux.bin.ub, etc. ?
>=20
> If using generic image names is acceptable,
> "make simpleImage.<dt>" is just a shorthand of
> "make DTB=3D<dt> vmlinux linux.bin linux.bin.ub vmlinux.strip"
>=20
>=20
> Only the benefit of this approach is,
> you can keep all images for multiple boards at the same time.
>=20
> $ make ARCH=3Dmicroblaze simpleImage.board1
> $ make ARCH=3Dmicroblaze simpleImage.board2
> $ make ARCH=3Dmicroblaze simpleImage.board3

yes that's one thing which came to my mind too.

>=20
>=20
>=20
>=20
> Since I do not know how many users rely on this usage,
> I said "it is up to you".

One thing is what it is sensible and the second thing is historical
connection to that names. Because Xilinx was having ppc405 and ppc440
and microblaze as big endian architecture at that time was taking a lot
of stuff from powerpc that's why we took also that targets just to be
the same in distributions.
PPC was using simpleImage format in the same way that's why we have
adopted that too.

Personally for me it is not a problem to remove that simpleImage format
but I have no idea how many people rely on that.

I can't see any problem not to generate/copy simpleImage.<dt>.unstrip
version but I would keep the rest same as before just to make sure that
we are not breaking anybody.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--q3oKDBuMMQBmesEffbWlXj9Y2IOPo3avY--

--xVjJa22C8ZUdUVhqaibgSri8AbzwxfX5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwJH4MACgkQykllyylKDCF0PwCfexX9N0AQnIULIDRhZ3o5g8j1
X4oAniiNfrqiexAPtyCl2bNBV+T0MGck
=xOyM
-----END PGP SIGNATURE-----

--xVjJa22C8ZUdUVhqaibgSri8AbzwxfX5N--
