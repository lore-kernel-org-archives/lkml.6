Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeDRG7v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 02:59:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35752 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752786AbeDRG7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 02:59:48 -0400
X-Google-Smtp-Source: AIpwx481jZA+5fthzhOq+uD+TAIw6zxJgySWFshYQLDxqmuI9GYZQeE+fHq7j4tbPfuTgsxz+m8Edg==
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Subject: Re: [v5,08/13] ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
Date: Wed, 18 Apr 2018 08:59:40 +0200
Message-ID: <1724020.V9x0kZZp2B@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.14.0-0.bpo.3-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-9-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3149418.CWxpNlAdMz"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3149418.CWxpNlAdMz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 23. M=E4rz 2018 15:48:51 CEST Sricharan R wrote:
> Add the common data for all dk07 based boards.
>=20
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi | 69 +++++++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

The no-map reserved-memory for tz and smem are missing. Linux doesn't have=
=20
control over these regions and they are placed in the middle of the ram bef=
ore=20
Linux even starts. And u-boot is also not adding these ranges automatically.

    	reserved-memory {
    		#address-cells =3D <0x1>;
    		#size-cells =3D <0x1>;
    		ranges;
   =20
    		smem@87e00000 {
    			reg =3D <0x87e00000 0x080000>;
    			no-map;
    		};
   =20
    		tz@87e80000 {
    			reg =3D <0x87e80000 0x180000>;
    			no-map;
    		};
    	};

This can either (depending on HW/SW configuration) lead to a failed boot [1=
]=20
or to runtime crashes like:

    root@OpenWrt:/# /tmp/memory-allocator-test
    main 0
    [  571.758058] Unhandled fault: imprecise external abort (0xc06) at 0x0=
1715ff8
    [  571.758099] pgd =3D cebec000
    [  571.763826] [01715ff8] *pgd=3D8e7fa835, *pte=3D87e7f75f, *ppte=3D87e=
7fc7f
    Bus error

I would not know how to disable QSEE on these boards and thus would assume=
=20
that it should be part of this dtsi.

Kind regards,
	Sven

[1] https://www.spinics.net/lists/linux-arm-msm/msg21536.html
--nextPart3149418.CWxpNlAdMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrW7NwACgkQXYcKB8Em
e0YjBRAApz1LT5s+FDpjPcHxGXVgTFUBV4sVKerHkJ3tJlIMxchv+ejAaEG3xaSZ
bik2ISjlRDL+6RCR3AC3JT0BBLj1oIIQH9ARxQECGu5YPk0lEDpUpasHfVvA5WXd
CjsA/aNGeaXGcPNRXiVhBsteJKa9zwqMfSzyi/H67r6WML4c+1DbxCYus+ksqnXF
C7D7tukGmsGEA+MCigJ7m6eRqW5TbL9SzWiO8dUXYU1M+Nx3TIzbY9Y0cRE2w4aT
/0tNuVMpFwpH0y0DFzKDwton4z3hvVMlJ/ts7XYneUgfEAXFWi9mjxsBi7mvb3xc
AlzVmGjaxVFU1wONiDs9/IjDFZyHC7VJoUqH/NMRPoHWHZ5FYgRP8c77jffa9/xV
ivtl4RYefDgwrC9LkgptvXF5AUSnDuQThGR6C2VajetZvygi9VSI598LXW1eYr4c
188Gw/bQsW2SRN+n0U7dDswLOlO4L1MZENphOCxcX8p1E/OgKS5ONFr8lTMOB7Cy
MGBN2nZ2uNuhbzOhPAxq/2yt2T6CWpCu/TZLXOOU2gQqIAuKJjJf/YpEz9ggazf6
5w2y+vrbAHtEGMOYsrMOO7uPClCJEXD7e66vJzzWMpun6MTLiHV3YWcnZueIF5Rv
2lKqnlg4udUf9Ep0XJPkxFFNCkmUNBINUfdZLNJEvBfPmQnbCHw=
=2ax+
-----END PGP SIGNATURE-----

--nextPart3149418.CWxpNlAdMz--
