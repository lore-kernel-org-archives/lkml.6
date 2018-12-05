Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03026C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B143A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="qNMLCOeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B143A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeLEP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:57:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeLEP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:57:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so20248748wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=4NXw887chQRoabO02HsWs+ax0iCGKLUtt8S88sudDxY=;
        b=qNMLCOeSOzKNHlRdnEKYIRDKRG8RQ/mkfow9B4dqY1uy2XSNopubt6dgEpf0YI0tKJ
         GYU4S28eLzrYU5Kjz0nxdGxvFOeV/lf/xkRHEFdbGQ81+QDtB/n0HwguUOOhdOj/jTlF
         0UJEA3S9IR2G2wGDWmCFR8RgqBlWIlV/Mdi2UjSrf5+Y8AYv06qwhTe7qaFiiS67sq8g
         H2QjdX12tGZOHZrCZg6NhRvcbtFkf8VvKXKvRIN3E1JVgA5N5CMzSljhRzAv+RcQkgn0
         IkDOopgEiLvR38KSaRLTRYKAQVbpx0dGqGpOqaqDZefcCZOf9+yqYwd2qphc2tHCbAyY
         ltCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=4NXw887chQRoabO02HsWs+ax0iCGKLUtt8S88sudDxY=;
        b=X4nWcklbvPdzpIo/hYSPAqnxLhCL/r3VlLZ4kYOuYD/zdHo5JJ3w3yJUfqSzICCded
         kgBxmERrv20QSh5zJkBaErwHkGlg78xr62vw3fYvGtbi6tdnfwb0Rhy5Kk8kuxkJvXfY
         doDFK+YMaP+l7FjiHZgiPJGTZZV9SGiqOq0jZCLxDj02wPsq15md7PpgtmsBv5CLDgZB
         f1DaCoCMBZtBQAeN2udypwfoCV0anItjKvyXFWLCLuj2kbHO8Em4FibkAPBPMj7hHAw2
         +8vT//QejMI1wfoZ4kCKyBOZfdrfRs/sIIcsSNaAMfGZMPwajof2BX6lTG253LBkaSf+
         f2og==
X-Gm-Message-State: AA+aEWZvt9rWUvmh4xD/fcw4pPM9nZ26iC3GNOQv1BjHQvIH6rtq9Kn+
        ZbtOfZ7Whe2FZwandyWogR/hOIiyDmpkRQ==
X-Google-Smtp-Source: AFSGD/W3bm55qqUQkPN+aylTLBpJV4MH3a7cDJDKeKQ1UxFigxyKNzoHjn74CIhp/uHulhu0ko35vQ==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr22039502wrq.38.1544025432978;
        Wed, 05 Dec 2018 07:57:12 -0800 (PST)
Received: from [74.125.71.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id f187sm11590246wma.4.2018.12.05.07.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:57:12 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 4/7] microblaze: fix multiple bugs in
 arch/microblaze/boot/Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-5-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <16f2f621-d051-a2e3-c2f3-e69c82140c46@monstr.eu>
Date:   Wed, 5 Dec 2018 16:57:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543823457-32478-5-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BnUkCeNLXoVlnWtd6lIn4oDFv7lu0YjFw"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BnUkCeNLXoVlnWtd6lIn4oDFv7lu0YjFw
Content-Type: multipart/mixed; boundary="PCP2oxlQHJk1kGZWltWivnfGenSpx3ymf";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <16f2f621-d051-a2e3-c2f3-e69c82140c46@monstr.eu>
Subject: Re: [PATCH 4/7] microblaze: fix multiple bugs in
 arch/microblaze/boot/Makefile
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-5-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543823457-32478-5-git-send-email-yamada.masahiro@socionext.com>

--PCP2oxlQHJk1kGZWltWivnfGenSpx3ymf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 8:50, Masahiro Yamada wrote:
> This Makefile is wrong in multiple ways.
>=20
> The first issue is the breakage of 'linux.bin.ub' target since commit
> ece97f3a5fb5 ("microblaze: Fix simpleImage format generation")
> because the addition of UIMAGE_{IN,OUT} obviously affected it.
>=20
> make ARCH=3Dmicroblaze CROSS_COMPILE=3Dmicroblaze-linux- linux.bin.ub
>   [ snip ]
>   OBJCOPY arch/microblaze/boot/linux.bin
>   UIMAGE  arch/microblaze/boot/linux.bin.ub.ub
> /usr/bin/mkimage: Can't open arch/microblaze/boot/linux.bin.ub: No such=
 file or directory
> make[1]: *** [arch/microblaze/boot/Makefile;14: arch/microblaze/boot/li=
nux.bin.ub] Error 1
> make: *** [arch/microblaze/Makefile;83: linux.bin.ub] Error 2
>=20
> The second issue is the use of the "if_changed" multiple times for
> the same target.
>=20
> As commit 92a4728608a8 ("x86/boot: Fix if_changed build flip/flop bug")=

> pointed out, this never works properly. Moreover, generating multiple
> images as a side-effect is extremely confusing and wrong.
>=20
> As far as I understood, "simpleImage.<dt>" works like a phony target
> to generate the following four images.
>=20
>  - arch/microblaze/boot/simpleImage.<dt>:
>        identical to arch/microblaze/boot/linux.bin
>=20
>  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
>        identical to vmlinux
>=20
>  - arch/microblaze/boot/simpleImage.<dt>.ub:
>        identical to arch/microblaze/boot/linux.bin.ub
>=20
>  - arch/microblaze/boot/simpleImage.<dt>.strip:
>        stripped vmlinux

Your understanding is correct. It always worked like that
simpleImage.<dt> was generating 4 files.
I have wired that long time ago because I wanted to boot image in U-Boot
that's why .ub was also generated.
Definitely simpleImage.<dt>.ub can be another target and not
automatically generated by simpleImage.<dt>

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--PCP2oxlQHJk1kGZWltWivnfGenSpx3ymf--

--BnUkCeNLXoVlnWtd6lIn4oDFv7lu0YjFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH9VQACgkQykllyylKDCGLuwCgmViAYSvhdEOBuYUZqq0/eRcY
RSgAnA8W8k7xFoUbE5vFy6JD1ipy3BbV
=qR2K
-----END PGP SIGNATURE-----

--BnUkCeNLXoVlnWtd6lIn4oDFv7lu0YjFw--
