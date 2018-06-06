Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2isFgtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A93260290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeFFPVk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:21:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39381 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbeFFPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:21:37 -0400
X-Google-Smtp-Source: ADUXVKJxgxHWs9B+MxiAZNfK0YwTtyJl0szkULm7YKvcX+6Fic2JV5IKrLnNWsC4P0AnqLnMO9dUKQ==
Date: Wed, 6 Jun 2018 17:21:34 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Helge Eichelberg <kernelorg@elchenberg.name>
Cc: Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13 9333
Message-ID: <20180606152134.sw77aborznfy6mrj@pali>
References: <20180605173833.27003-1-kernelorg@elchenberg.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7xpsbcfufzx2oz5z"
Content-Disposition: inline
In-Reply-To: <20180605173833.27003-1-kernelorg@elchenberg.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xpsbcfufzx2oz5z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 June 2018 19:38:32 Helge Eichelberg wrote:
> Calling fan related SMM functions implemented by Dell BIOS firmware on De=
ll
> XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
> disable fan support for Dell XPS13 9333.

Hi! Have you reported this firmware bug to Dell?

Also we should probably match also BIOS version and do not apply this
blacklist quirk for BIOS versions in which Dell fixed it.

> Via "force" module param fan support can be enabled.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D195751
> Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmo=
n.c
> index bf3bb7e1adab..9d3ef879dc51 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_supp=
ort_dmi_table[] __initdata =3D {
>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
>  		},
>  	},
> +	{
> +		.ident =3D "Dell XPS13 9333",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
> +		},
> +	},
>  	{ }
>  };
> =20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7xpsbcfufzx2oz5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWxf7+wAKCRCL8Mk9A+RD
UrpHAKC5z51uDFci3hpJ1e0ZKW3U5hgnJwCfcYZuBb+bhE8fXAk/fUIn3xzIzgI=
=Y8iZ
-----END PGP SIGNATURE-----

--7xpsbcfufzx2oz5z--
