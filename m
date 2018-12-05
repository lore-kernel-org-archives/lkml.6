Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A140C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45518206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="wOyY6VQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45518206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeLEPlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:41:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:41:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so20198580wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=th2oJ1xcx+tBv0LRm5gkE+r8dQIB4QJlFQgiwpugA1g=;
        b=wOyY6VQvjHtqAEPDCSk7hXCP4AHwycQo9/22vGcMYFwCpQ5x4eetNk6rfUE2tZlQnS
         RTBUD42aOkULmRAAAtiF16RBDbsOvy/zOskNeS7oQgdVTyeRY2vmjVkocFtvlBeKm3Tt
         d9GLvpuPF/3CTYCY6TmhwUaJqhEOHL0qxvkXdj7Ck9Uy0pzOM1pKG91raRaoRuLUqf/P
         SylZABMaSgvgXbSRdieFDgRT5fMERumYPYkteT30euvNToFciwLjq2TUjOiIyMQ/jPZD
         aIdA3lbNCzltu2zI9Zq/S9nRrrZMfrAF6Tbsf03shh73BoLzNZTNTFmSsQcLZDKyDokM
         VO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=th2oJ1xcx+tBv0LRm5gkE+r8dQIB4QJlFQgiwpugA1g=;
        b=QC3JaVRWCupczraJvJCCMC1+AP2Sv4eiP/E3sHtLWfIa1tLPiVUIef8TaPYJs3R1Xm
         IRqtBy8iRKlcB96hZBmC3XryhilTdaoBGvtvxIH+xYU262meBAd2d7Lg0LcjlWPn1aD3
         c2bKE3iDUwD4uTxqkA46bImLaBaOYtUdsIm3hY9uvOr65yQt8n9/MG9BEu9SzwKsmCLF
         VzqJhjToeHOQOES36Mydvek047M7H+FKym7JdZRl6E/coS5gEQQp+BLFz19PkYbhpn2D
         OzrYPkxvz7g59a9ATgsAyIcekEbmDZCLP/kVh0ZHCKKN1td179Lfq2a5HkUn+HmVxqbk
         hRCg==
X-Gm-Message-State: AA+aEWaXVgrqiiNsQ1wy1QG5fNRbsReFQ4meQD8iWpWlvBjp4hh1Upj4
        FIyvv6+4Kxpr51TbWl0mUBtUNHGy8Lrufg==
X-Google-Smtp-Source: AFSGD/V5PtRihTn9qtIcDHNio5QDe7NS+PzXwQDW3rjlP+beAxdCD3gdUBplRmI/Xi72untOarbmEA==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr20925004wrs.86.1544024480173;
        Wed, 05 Dec 2018 07:41:20 -0800 (PST)
Received: from [74.125.71.109] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id b131sm17027655wma.21.2018.12.05.07.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 07:41:19 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 1/7] microblaze: fix cleaning of boot images
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-2-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <0e57c216-c85c-9cd4-7922-e4509e44858c@monstr.eu>
Date:   Wed, 5 Dec 2018 16:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543823457-32478-2-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cKZX7aCx9mliA3OoshTchzirzkI9C2Ccx"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cKZX7aCx9mliA3OoshTchzirzkI9C2Ccx
Content-Type: multipart/mixed; boundary="pOgLeTpw6oQKJ9s6ogOZuw1JoPb1xy7PW";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0e57c216-c85c-9cd4-7922-e4509e44858c@monstr.eu>
Subject: Re: [PATCH 1/7] microblaze: fix cleaning of boot images
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com>
 <1543823457-32478-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543823457-32478-2-git-send-email-yamada.masahiro@socionext.com>

--pOgLeTpw6oQKJ9s6ogOZuw1JoPb1xy7PW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03. 12. 18 8:50, Masahiro Yamada wrote:
> The simpleImage.<dt> target generates the following files:
>=20
>   arch/microblaze/boot/simpleImage.<dt>
>   arch/microblaze/boot/simpleImage.<dt>.ub
>   arch/microblaze/boot/simpleImage.<dt>.strip
>   arch/microblaze/boot/simpleImage.<dt>.unstrip
>=20
> However, "make ARCH=3Dmicroblaze clean" only cleans up the unstrip
> image. Fix the clean-files to take care of all the four.
>=20
> Adding linux.bin.ub to clean-files is redundant because it is
> already added into "targets".
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makef=
ile
> index 600e5a1..e8684a2 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -37,4 +37,4 @@ $(obj)/simpleImage.%: vmlinux FORCE
>  	$(call if_changed,strip,.strip)
>  	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
> =20
> -clean-files +=3D simpleImage.*.unstrip linux.bin.ub
> +clean-files +=3D simpleImage.*
>=20

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--pOgLeTpw6oQKJ9s6ogOZuw1JoPb1xy7PW--

--cKZX7aCx9mliA3OoshTchzirzkI9C2Ccx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlwH8ZkACgkQykllyylKDCGUaACeL0gfOxjRY+CCCb1pHuzBHccA
bVIAn1cQmBlttPk8lQMzk/44xCp/oDNn
=mdOg
-----END PGP SIGNATURE-----

--cKZX7aCx9mliA3OoshTchzirzkI9C2Ccx--
