Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0255AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A399520858
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="d/VXd+PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A399520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbeGQPPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:15:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46537 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbeGQPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:15:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so1508898wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=v5ncRrf8HRTKs3DcplUkUrghsOUSNnl9vzQFwCPS/Xk=;
        b=d/VXd+PDEOKi2XqtRyJKBXe2KrfGmBB+xeNKDeRpJ/CwQKrtAMy2f3mP0pyItghp7U
         Ypmvwcrk1ixlmSGgwzQGuyPvAuzf+bz5YtTLZFOvmMMBdINHobjOl9yXSEk9FgKe/Fct
         FIxAiOjEJRDJ6RfuFz0Tq0TRsNLKUrssAfuUxdD0doYqF5PFQGVfEkYdo/YiktLD3ntm
         u0XpXhCFNi1jChE/fsiHhFkVaeLih5On6lTiuxvTmrNegRZI2m3HYuoNn7h/AvlTH7jd
         cM1hZNGh9UlX2qQdLynsP93e9BjUJF+7bj/i7w3z+DS68EkEm0+4jkDdyiG89gAqVc5p
         4BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=v5ncRrf8HRTKs3DcplUkUrghsOUSNnl9vzQFwCPS/Xk=;
        b=sfavabh43XE/aQoGMyaJFASbryTsQ0ux7Nml2+K5O4PtvTbOJfbggBdG1JpnmaXcyS
         yeDsLEBKOtjhBeNWC75rhYELJxwwaa9QlJFOp1XLoc8gNU5IkLUsFGBFF6Q+H4iMHDa+
         KOgIfZlQ/mL+/RQsSztUiu0pJRTCLkDmVMmFVfukC11aFY70hYpdk9JgWabg+jSvFFck
         OJUfBXUGK9urQMBtHIC2OL0zeD4eDhaZISx7ICkEOOoTRkdO3YhCLsOTSR0N/d7ZGoDe
         jreQgCnRWhHhlKYXxEOftLsYdrbtoJhKAWHYdA+S3OF+gY/R+mQ8Av9Z1D+UxiJJ9hVM
         ZLUg==
X-Gm-Message-State: AOUpUlG6fhBS5Slm5b1KDbfYsST6BZwxnz/tPmTgZ7Y0HRMYzRS2pqKV
        aiQVxxkdhRsLfzqnZk9UKUan2V6Ykd4=
X-Google-Smtp-Source: AAOMgpffTFsghZyQyoOLds5/Lnp9wxdmlTpPajFdK2EWVTIVYtIPY3iSAjdRWG0niZHIanEPtDcYxQ==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr1564614wri.42.1531838533032;
        Tue, 17 Jul 2018 07:42:13 -0700 (PDT)
Received: from [173.194.76.109] ([149.199.62.254])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1338692wrp.55.2018.07.17.07.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:42:12 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] arm64: zynqmp: Remove #address/#size-cells from gpio-keys
To:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
 RmzhqoTJlA==
Message-ID: <50a270ad-93e6-5be2-ab57-bd4cbd9fe49a@monstr.eu>
Date:   Tue, 17 Jul 2018 16:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rNj6OcjYfbJvEiaEta93scPgEff3uU0w7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNj6OcjYfbJvEiaEta93scPgEff3uU0w7
Content-Type: multipart/mixed; boundary="bpAOc0hM4YirHXmYmS6kfcoRqLeshgDHH";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org
Message-ID: <50a270ad-93e6-5be2-ab57-bd4cbd9fe49a@monstr.eu>
Subject: Re: [PATCH] arm64: zynqmp: Remove #address/#size-cells from gpio-keys
References: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
In-Reply-To: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>

--bpAOc0hM4YirHXmYmS6kfcoRqLeshgDHH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2.5.2018 13:34, Michal Simek wrote:
> dts reports incorrect usage of these properties in gpio-keys node.
> Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary
>=20
> The patch is removing these useless properties.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 --
>  4 files changed, 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index c7f713c8e69e..eb5e8bddb610 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -44,8 +44,6 @@
> =20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>  		autorepeat;
>  		sw4 {
>  			label =3D "sw4";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 5b4ffe646a9b..25dd57485323 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -41,8 +41,6 @@
> =20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>  		autorepeat;
>  		sw19 {
>  			label =3D "sw19";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 668f7f26716a..259f21b0c001 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -41,8 +41,6 @@
> =20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>  		autorepeat;
>  		sw19 {
>  			label =3D "sw19";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/a=
rm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 9a9dd6a0142b..a61b3cc6f4c9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -41,8 +41,6 @@
> =20
>  	gpio-keys {
>  		compatible =3D "gpio-keys";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
>  		autorepeat;
>  		sw19 {
>  			label =3D "sw19";
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



--bpAOc0hM4YirHXmYmS6kfcoRqLeshgDHH--

--rNj6OcjYfbJvEiaEta93scPgEff3uU0w7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltOAD0ACgkQykllyylKDCFJ9gCfR4xAncQz6PzgQ/+BVn7ZWP3d
1mgAoIjY4vHuoCrBpcTsKJL1IT5Vbju3
=dHkX
-----END PGP SIGNATURE-----

--rNj6OcjYfbJvEiaEta93scPgEff3uU0w7--
