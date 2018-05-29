Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeE2FxF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:53:05 -0400
Received: from ozlabs.org ([203.11.71.1]:40763 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751591AbeE2FxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:53:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 15:52:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: linux-next: manual merge of the irqchip tree with the arm-soc tree
Message-ID: <20180529155257.5ae48830@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xukjiupTS1RFg90FaSqfu5U"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xukjiupTS1RFg90FaSqfu5U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the irqchip tree got a conflict in:

  arch/arm/boot/dts/stm32mp157c.dtsi

between commit:

  3c00436fdb20 ("ARM: dts: stm32: add USBPHYC support to stm32mp157c")

from the arm-soc tree and commit:

  5f0e9d2557d7 ("ARM: dts: stm32: Add exti support for stm32mp157c")

from the irqchip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673b5038,4fa0df853c8a..000000000000
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@@ -777,26 -183,13 +777,33 @@@
  			status =3D "disabled";
  		};
 =20
 +		usbphyc: usbphyc@5a006000 {
 +			#address-cells =3D <1>;
 +			#size-cells =3D <0>;
 +			compatible =3D "st,stm32mp1-usbphyc";
 +			reg =3D <0x5a006000 0x1000>;
 +			clocks =3D <&rcc USBPHY_K>;
 +			resets =3D <&rcc USBPHY_R>;
 +			status =3D "disabled";
 +
 +			usbphyc_port0: usb-phy@0 {
 +				#phy-cells =3D <0>;
 +				reg =3D <0>;
 +			};
 +
 +			usbphyc_port1: usb-phy@1 {
 +				#phy-cells =3D <1>;
 +				reg =3D <1>;
 +			};
 +		};
 +
+ 		exti: interrupt-controller@5000d000 {
+ 			compatible =3D "st,stm32mp1-exti", "syscon";
+ 			interrupt-controller;
+ 			#interrupt-cells =3D <2>;
+ 			reg =3D <0x5000d000 0x400>;
+ 		};
+=20
  		usart1: serial@5c000000 {
  			compatible =3D "st,stm32h7-uart";
  			reg =3D <0x5c000000 0x400>;

--Sig_/xukjiupTS1RFg90FaSqfu5U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsM6rkACgkQAVBC80lX
0Gyyrgf/Uzj5K4V0odofg90cZLU5BBR0op2JpGmfWEdUctcuj9mILMwn5ftvppTk
4mwEF0qxo2rDujnzxCKdcXloDqeQUw6sowIXaMlTA+FabTerfGUSBhwxCfIoWeVC
h6eKgcxiwRjv79b8H0n8vYEGuapCxmOH05G+x/VIHtoyPo9sntmLczGsZpML7m3q
Kacv83kGEN6Tm+MAYODI1e94WhLZjFMgN0Ae3tWGGf567d1J+pVxw4KuFRJ53koa
GXzO4/yAERheiP/4PmFikvF69FtnYYE0e2NDVXV7nmafNf7G5S5Ftnk99JKMPlxY
z9h04HbmsqO7wLk/jkOjcH0nrvIeEA==
=g9L9
-----END PGP SIGNATURE-----

--Sig_/xukjiupTS1RFg90FaSqfu5U--
