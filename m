Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932865AbeCFAIl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932544AbeCFAIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:08:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C32621770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 6 Mar 2018 00:08:32 +0000
From: James Hogan <jhogan@kernel.org>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
Message-ID: <20180306000832.GL4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <20170927151527.25570-4-prasannatsmkumar@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 08:45:26PM +0530, PrasannaKumar Muralidharan wrote:
> Add initial Ingenic X1000 SoC support. Provide minimum necessary
> information to boot kernel to an initramfs userspace.
>=20
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 93 +++++++++++++++++++++++++++++=
++++++
>  arch/mips/jz4740/Kconfig              |  6 +++
>  arch/mips/jz4740/time.c               |  2 +-
>  3 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/ingenic/x1000.dtsi

arch/mips/jz4780/setup.c, specifically get_board_mach_type() and
get_system_type() will need updating too.

Does X1000 use a different PRID, or is it basically just a JZ4780 core
with different SoC peripherals?

> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/i=
ngenic/x1000.dtsi
> new file mode 100644
> index 0000000..abbb9ec
> --- /dev/null
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -0,0 +1,93 @@
> +/*
> + * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail=
=2Ecom>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

(these will need updating to use SPDX identifiers if you respin)

> +	cgu: jz4780-cgu@10000000 {

not sure jz4780 is appropriate here.

> +		compatible =3D "ingenic,x1000-cgu";
> +		reg =3D <0x10000000 0x100>;
> +
> +		clocks =3D <&ext>, <&rtc>;
> +		clock-names =3D "ext", "rtc";
> +
> +		#clock-cells =3D <1>;
> +	};

Cheers
James

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqd2/8ACgkQbAtpk944
dnpAlw/+MjVXePpEgRTo/x44QOaJLfHn945fI+988C3mMlcVg2kUqCRp0b0U+7ZD
ozPBJYreFQvJXWJM0dAyf34A/9PxdZGDHtcv7bn/BG+EY05F7XWqyQwfAO4zmBhG
IMmhra1XLX4b0XwnFMUXz2OBndGJPJkOQ/iJY5viIdVZR+98dQMZP3a6q21H/Nhs
mZkrjVJ0Eq8CuYCuDxxeX1d8nkuutFgq77MvbEXHkTB2OI1eRQ8IkuwOIUJ9+7g3
uqi3LhzWR+DtpPHTDqY+AwBM+wrRx9YcDj3XPg03waefBm8c7wRKdmZb20zDLLxV
G14KvwVaiMIcEKDhyYi4Z21X6gZwEUPJUJJ5qmSN/DGj3a0EzFpZrYRnuGEjRUUU
u/R0o9c3mg8MeYzmPrz+ckVMe2z4IgezOd3QrYzPvDa8HUrrKfK++/Wvr6TN3Gu3
sy9zp0hyg9+zArF90hYznChoam9ePPoUZjM7Ao3eXLLggohMWeEvRiFOPkyICQt9
flD7d/Tom/i00YO3LTMpicIfNnWCGGaBcXuDZzwMXIwXBiHpEjPZ7CKSzbHTlzjx
/vsnemhVAHxvKRayAzdUm6gML/jvpYi/EpJzDW7zeWI+18oDXvdN80tsVYSNGtbK
V6PGb7j4MWsBNNquEbU8H0DM96OkqhNFFBtMf3tniVxRv2iAz/k=
=eDtH
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
