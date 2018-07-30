Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1EC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A7920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="BzCMzauu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A7920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeG3IIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:08:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50938 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeG3IIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:08:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so11799541wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Is6dV8LyJ7Ha5Q2DAAVmLX4zbCwOEMrHEmyFcnEKJyQ=;
        b=BzCMzauuIWQtOSaHxWii5K5Y9F2AHHnB4YIKF2qwU9Zh1LO9q3I+K1K6ufGsksh93Y
         o6aJK3KKPFVll2K2ioqxxxcUMhpAudrmg670JUICYIl4mQSD8bzkSLvwDKM8QBKHZ0rr
         ZOZ2XMV/pkHOQLLwbA8HQDe4/gDXwA3kR5S7nenHvng1AnXSMK5bTalXKuQ3abLKSWXi
         OCJCnoSCpG9q18xl3RWqCT8mRnDOYy2q12l2zqrqhZpIIoqG/w5x/pbnsOWV8ybv6xRd
         dSinFTTwaYoYFjCMIVLuvyJxjJQjMr1m4KUbBVHKK6IDRift87fFopRYVRIfuyDu7Xgu
         uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Is6dV8LyJ7Ha5Q2DAAVmLX4zbCwOEMrHEmyFcnEKJyQ=;
        b=njOtCyYQ4vpxJAbABBYcaIPJi4YORA0A853RP81hbCmiaUXOqeTtcOWv5hXvCnBzz/
         cEQqQQJe8K6uiQsvv5famtnQl+6ZMGBZYGwScD8R5uTK4Jem/B47yYZLiDoO5ForFNyL
         f0NYa7i9QOS2Qjedhh6esNEvDzXkaz7ZpUKSNjcOECkJGmlDT/tHt41+KChDO/smXQYg
         AY1jk29iQ//ndfSwyG+BAgBm4wUxcqwEdR/cWh023upFPLWnXUduA+PKe52RZSG5iswO
         SB9+Jq/Xcu4CfZAVZZYFVGzKsh36kCbBcjdNvjQEFdGw9gsp2UXbFmthpSbHLtQn5tOo
         YmPg==
X-Gm-Message-State: AOUpUlEYr4FhKjqG96ngyxLIHC1PxyQq395Cv4t8LIm+fhM3+IXGtMI5
        bnzvJJ2KuajQz4sV7i4glhLVcmpy6LF8Ug==
X-Google-Smtp-Source: AAOMgpewhE+6YQgXPapo8+/4DuYpCcnZz8oKPOqvGIe7b5jJxT4W7p0hRi+n6AxmAWnxOLsjBgvj1g==
X-Received: by 2002:a1c:810e:: with SMTP id c14-v6mr747809wmd.60.1532932492247;
        Sun, 29 Jul 2018 23:34:52 -0700 (PDT)
Received: from [74.125.133.108] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id e141-v6sm18450523wmd.32.2018.07.29.23.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 23:34:51 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] microblaze: delete wrong comment about machine_early_init
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
References: <1532828293-20074-1-git-send-email-yamada.masahiro@socionext.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <762d7365-9fa2-a21d-84fb-27bb0f8bef3c@monstr.eu>
Date:   Mon, 30 Jul 2018 08:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532828293-20074-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="f8pHI32p1HeoHPSjtaWH7aUW8B6rvURex"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8pHI32p1HeoHPSjtaWH7aUW8B6rvURex
Content-Type: multipart/mixed; boundary="jXPsZDXwUW4AKnuqdOWFse8D4nmD8KsCn";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <762d7365-9fa2-a21d-84fb-27bb0f8bef3c@monstr.eu>
Subject: Re: [PATCH] microblaze: delete wrong comment about machine_early_init
References: <1532828293-20074-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1532828293-20074-1-git-send-email-yamada.masahiro@socionext.com>

--jXPsZDXwUW4AKnuqdOWFse8D4nmD8KsCn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.7.2018 03:38, Masahiro Yamada wrote:
> machine_early_init is defined in arch/microblaze/kernel/setup.c
> I do not see mach-* directory for MicroBlaze.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/kernel/head.S | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/hea=
d.S
> index 4655ff3..f264fdc 100644
> --- a/arch/microblaze/kernel/head.S
> +++ b/arch/microblaze/kernel/head.S
> @@ -341,11 +341,6 @@ start_here:
>  	/* Initialize r31 with current task address */
>  	addik	r31, r0, init_task
> =20
> -	/*
> -	 * Call platform dependent initialize function.
> -	 * Please see $(ARCH)/mach-$(SUBARCH)/setup.c for
> -	 * the function.
> -	 */
>  	addik	r11, r0, machine_early_init
>  	brald	r15, r11
>  	nop
>=20

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--jXPsZDXwUW4AKnuqdOWFse8D4nmD8KsCn--

--f8pHI32p1HeoHPSjtaWH7aUW8B6rvURex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltesYYACgkQykllyylKDCGMVgCeJvMdZh+5t7fhufMkCpMFVdU8
JcwAnj1AY3EsLO7jgJsCW+3hddu2AJVL
=6lLp
-----END PGP SIGNATURE-----

--f8pHI32p1HeoHPSjtaWH7aUW8B6rvURex--
