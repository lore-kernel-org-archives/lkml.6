Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F23A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="GYrGLK/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F23A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeGQOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:15:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33342 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbeGQOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:15:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so1338465wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Iw23yyuugrmGx5lPI0/oR3zNAvACKUQj+cQNLtLMQ+U=;
        b=GYrGLK/85NLIJepH5W4ysV0YqFWjUiKPtMTKaEJuoPvtqjspaAoIZGIqd834GJl9Vf
         H5LY/dfmn0s0wqqfDtSb+WCw88frFK77xJ/RM3qGF7Okmn5kNa+rqpGKOsOKGpCkuFH8
         jTrkATTB9FOI4WAxSp2YkQxL4+32l4yOFyZnpQ5LZ19X758EHUekp4oQSZVolMVXy3k+
         PzLSGQCu5FtrDh8x1TUqeG84aiFbMiawXD2QfYY179FmT2fJulH5dBXOtmjXIc2kLort
         buZGqmUXTKwpE4mVaxuJYC6MvjpNll/FMD9Bh/1TSsizNl0BcN+b6XEdmBBPDRqzt5g2
         G/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=Iw23yyuugrmGx5lPI0/oR3zNAvACKUQj+cQNLtLMQ+U=;
        b=kjuCgjb52W4GwaNPSLP1A+QbEJj8Vb9LWr/NABI/1MevBmwGORRxXgBOAn5CZ924VI
         FZ3n2mZFh5Rsp+YKNFIxS1eC0gaEftwb5G8xw2zHCL2ywtAMb0p7TRX7WPz3msCUJy+T
         m3rREFCMC97wtwSukIiwCnsoLXsjaQcnTFrE/RbPZ/BBa7gVAPXrHM1zEsc9LZclTtcz
         kernSIixv4MZcfRM7WGuviimJvwUyWkJRx0ch8ajT48+Vlq1w246b+lzevUYQyAq876o
         DeYXn2yahTKIFS8Q9lqz7aqUZC3ORpM+yhRiPIA3YiNNX5OWv6nZ8V+q4U7eglyF6XGa
         qKXQ==
X-Gm-Message-State: AOUpUlG+Jv5i8DABcKHgRYXrPsTbnfKyG6phElaFXxpC1PKFzXxsTwfu
        pjP7yTsp88RlXEzmcFLNbRnJAw==
X-Google-Smtp-Source: AAOMgpfyOFEYV2ro1VtS4qVdFmd4eD0MLrUdiGulUo6JT2FI3hGRrGizcvviZo0GtVO+RW87i27PBw==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr1437319wrd.218.1531834943285;
        Tue, 17 Jul 2018 06:42:23 -0700 (PDT)
Received: from [66.102.1.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id 127-v6sm2144558wmd.18.2018.07.17.06.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 06:42:22 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm: zynq: Add mmc alias for zc702/zc706/zed/zybo
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <56003f03e66edecb64298317120d4a37b9944a3f.1516199896.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <deacca38-6626-a1fe-f158-fc0d58acfbce@monstr.eu>
Date:   Tue, 17 Jul 2018 15:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <56003f03e66edecb64298317120d4a37b9944a3f.1516199896.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VGDL6YPY5rto5H3s2HWSo80eIfn5r3mu7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VGDL6YPY5rto5H3s2HWSo80eIfn5r3mu7
Content-Type: multipart/mixed; boundary="OucNRNKXVUYI61Qx977wOpVMb2IcdGp2B";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 linux-kernel@vger.kernel.org,
 Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
 Rob Herring <robh+dt@kernel.org>, Rob Herring <robherring2@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, Josh Cartwright
 <josh.cartwright@ni.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <deacca38-6626-a1fe-f158-fc0d58acfbce@monstr.eu>
Subject: Re: [PATCH] arm: zynq: Add mmc alias for zc702/zc706/zed/zybo
References: <56003f03e66edecb64298317120d4a37b9944a3f.1516199896.git.michal.simek@xilinx.com>
In-Reply-To: <56003f03e66edecb64298317120d4a37b9944a3f.1516199896.git.michal.simek@xilinx.com>

--OucNRNKXVUYI61Qx977wOpVMb2IcdGp2B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.1.2018 15:38, Michal Simek wrote:
> Add missing mmc alias.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/arm/boot/dts/zynq-zc702.dts | 1 +
>  arch/arm/boot/dts/zynq-zc706.dts | 1 +
>  arch/arm/boot/dts/zynq-zed.dts   | 1 +
>  arch/arm/boot/dts/zynq-zybo.dts  | 1 +
>  4 files changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-=
zc702.dts
> index dd1a731ae24c..46f14422b2e7 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -23,6 +23,7 @@
>  		ethernet0 =3D &gem0;
>  		i2c0 =3D &i2c0;
>  		serial0 =3D &uart1;
> +		mmc0 =3D &sdhci0;
>  	};
> =20
>  	memory@0 {
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-=
zc706.dts
> index 8a0c2ff4c5eb..9224b45f9418 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -23,6 +23,7 @@
>  		ethernet0 =3D &gem0;
>  		i2c0 =3D &i2c0;
>  		serial0 =3D &uart1;
> +		mmc0 =3D &sdhci0;
>  	};
> =20
>  	memory@0 {
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-ze=
d.dts
> index 1015edd69ff3..c8fad19e07dd 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -22,6 +22,7 @@
>  	aliases {
>  		ethernet0 =3D &gem0;
>  		serial0 =3D &uart1;
> +		mmc0 =3D &sdhci0;
>  	};
> =20
>  	memory@0 {
> diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-z=
ybo.dts
> index c131dc45e4eb..b0ad94cb9e4a 100644
> --- a/arch/arm/boot/dts/zynq-zybo.dts
> +++ b/arch/arm/boot/dts/zynq-zybo.dts
> @@ -22,6 +22,7 @@
>  	aliases {
>  		ethernet0 =3D &gem0;
>  		serial0 =3D &uart1;
> +		mmc0 =3D &sdhci0;
>  	};
> =20
>  	memory@0 {
>=20

Applied.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--OucNRNKXVUYI61Qx977wOpVMb2IcdGp2B--

--VGDL6YPY5rto5H3s2HWSo80eIfn5r3mu7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltN8jUACgkQykllyylKDCEqRwCeK6AnYIgeyUFXPCbUe7Py7/Sg
takAoJ1c/Fc6DAXs/cmeoNqRAKR8ON1I
=oupD
-----END PGP SIGNATURE-----

--VGDL6YPY5rto5H3s2HWSo80eIfn5r3mu7--
