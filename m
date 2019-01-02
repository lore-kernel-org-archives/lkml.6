Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E6EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3AC218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qpusOG32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfABWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:20:05 -0500
Received: from ozlabs.org ([203.11.71.1]:43633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfABWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:20:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43VQTY4t5Jz9rxp;
        Thu,  3 Jan 2019 09:20:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546467601;
        bh=sSiM09/ulTY4WwIZ+w2cm7d5/8jPeeVddoQkIWZfRqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qpusOG32Hn1EOxQR0FtwCukjupPtXCZH41kvJ5rfcOrufsxP09EgbgxsJMMFMpIEH
         5hbQWGX7D9EZrh1doXs9rMmC2jBwfkNlcPZlSXM/rRefi+qvU23nqhGUj7zelmFJQ8
         PBMxdI6EXJzG0IPKQO4ABzbCRnX3HD9MNVrmPXYiVBVTl8K+7jXQqbgwirJ2nJ24m4
         LYlDDeeC3NemjrAG8t/KW/Clj8+6EQ1rdE+zaO1NuwYoBZXXJW+9SZOjHp21CBTwrf
         v+pqAh24y7Qn+OKD8RdoPBby/KO+HWdBF8z/k48IAGoRGqxiUiDroNtvluVd/xXRWX
         9m067CS6emYwQ==
Date:   Thu, 3 Jan 2019 09:19:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Zhang Rui <rui.zhang@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: linux-next: manual merge of the thermal tree with the kbuild
 tree
Message-ID: <20190103091912.4fe2b2da@canb.auug.org.au>
In-Reply-To: <20181217105715.5da0b389@canb.auug.org.au>
References: <20181217105715.5da0b389@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BgvhUMfKshEZZG4L3ULlMrk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BgvhUMfKshEZZG4L3ULlMrk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Dec 2018 10:57:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the thermal tree got a conflict in:
>=20
>   drivers/thermal/Kconfig
>=20
> between commit:
>=20
>   17815cc6622c ("treewide: surround Kconfig file paths with double quotes=
")
>=20
> from the kbuild tree and commit:
>=20
>   3e8c4d31f8ed ("drivers: thermal: Move various drivers for intel platfor=
ms into a subdir")
>=20
> from the thermal tree.
>=20
> I fixed it up (I used the thermal tree version of this file and added
> the following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 17 Dec 2018 10:54:07 +1100
> Subject: [PATCH] drivers: thermal: fixup for Kconfig string parsing tight=
ening up
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/thermal/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index 9c06d4ad7c97..2e013eeb4a1d 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -55,7 +55,7 @@ config INTEL_QUARK_DTS_THERMAL
>  	  underlying BIOS/Firmware.
> =20
>  menu "ACPI INT340X thermal drivers"
> -source drivers/thermal/intel/int340x_thermal/Kconfig
> +source "drivers/thermal/intel/int340x_thermal/Kconfig"
>  endmenu
> =20
>  config INTEL_BXT_PMIC_THERMAL
> --=20
> 2.19.1

I am still applying that patch every day.  It could be applied directly
to the thermal tree as it does not depend on the kbuild tree change.

--=20
Cheers,
Stephen Rothwell

--Sig_/BgvhUMfKshEZZG4L3ULlMrk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwtOQwACgkQAVBC80lX
0Gx1OAf/TnTyVR9QqpMLlR8PR2m18JuT6gAY+ejftGfFN9bERusH+XSxdyYReseT
/MQaZ6AVejaYMRo6LzLN8qZd3sgJDu86GAjNlhg9wLpzUJqYXrrkmnjvb2wcNhgw
tyQQ/OQHZtdArkMvpEO9kfQHNhU9LaI5NowSuOo+wdO1vcvBofiguD5Q7IwKKWQs
dxYaH4aHiw70su1QYF8zzmDUwf8PpadaKQoLir01QoTE2/ZxqK1qzLsu89nmY6yz
TsdqRdZjA1om5NaBUY7V4k6jRHK3r3W0bmU/f6HoP4lv3nQHj1OnZXMUShSmYg34
Ydl4GDN9HoDWWgU83JwOMd3U48wmNw==
=B1RX
-----END PGP SIGNATURE-----

--Sig_/BgvhUMfKshEZZG4L3ULlMrk--
