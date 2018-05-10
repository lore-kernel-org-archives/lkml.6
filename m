Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeEJCNg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:13:36 -0400
Received: from ozlabs.org ([203.11.71.1]:44991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756076AbeEJCNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:13:34 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 10 May 2018 12:13:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180510121330.3b78a5a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nn9ni4/CUuW.SmmUnxG9wQo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nn9ni4/CUuW.SmmUnxG9wQo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/realtek/r8169.c

between commit:

  3148dedfe79e ("r8169: fix powering up RTL8168h")

from the net tree and commit:

  4f447d296982 ("r8169: drop member pll_power_ops from struct rtl8169_priva=
te")

from the net-next tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/realtek/r8169.c
index c7aac1fc99e8,6d99b141a7aa..000000000000
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@@ -4980,72 -4767,13 +4767,16 @@@ static void rtl_pll_power_down(struct r
 =20
  static void rtl_pll_power_up(struct rtl8169_private *tp)
  {
- 	rtl_generic_op(tp, tp->pll_power_ops.up);
-=20
- 	/* give MAC/PHY some time to resume */
- 	msleep(20);
- }
-=20
- static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
- {
- 	struct pll_power_ops *ops =3D &tp->pll_power_ops;
-=20
  	switch (tp->mac_version) {
- 	case RTL_GIGA_MAC_VER_07:
- 	case RTL_GIGA_MAC_VER_08:
- 	case RTL_GIGA_MAC_VER_09:
- 	case RTL_GIGA_MAC_VER_10:
- 	case RTL_GIGA_MAC_VER_16:
- 	case RTL_GIGA_MAC_VER_29:
- 	case RTL_GIGA_MAC_VER_30:
- 	case RTL_GIGA_MAC_VER_37:
- 	case RTL_GIGA_MAC_VER_39:
- 	case RTL_GIGA_MAC_VER_43:
- 	case RTL_GIGA_MAC_VER_47:
- 	case RTL_GIGA_MAC_VER_48:
- 		ops->down	=3D r810x_pll_power_down;
- 		ops->up		=3D r810x_pll_power_up;
- 		break;
-=20
- 	case RTL_GIGA_MAC_VER_11:
- 	case RTL_GIGA_MAC_VER_12:
- 	case RTL_GIGA_MAC_VER_17:
- 	case RTL_GIGA_MAC_VER_18:
- 	case RTL_GIGA_MAC_VER_19:
- 	case RTL_GIGA_MAC_VER_20:
- 	case RTL_GIGA_MAC_VER_21:
- 	case RTL_GIGA_MAC_VER_22:
- 	case RTL_GIGA_MAC_VER_23:
- 	case RTL_GIGA_MAC_VER_24:
- 	case RTL_GIGA_MAC_VER_25:
- 	case RTL_GIGA_MAC_VER_26:
- 	case RTL_GIGA_MAC_VER_27:
- 	case RTL_GIGA_MAC_VER_28:
- 	case RTL_GIGA_MAC_VER_31:
- 	case RTL_GIGA_MAC_VER_32:
- 	case RTL_GIGA_MAC_VER_33:
- 	case RTL_GIGA_MAC_VER_34:
- 	case RTL_GIGA_MAC_VER_35:
- 	case RTL_GIGA_MAC_VER_36:
- 	case RTL_GIGA_MAC_VER_38:
- 	case RTL_GIGA_MAC_VER_40:
- 	case RTL_GIGA_MAC_VER_41:
- 	case RTL_GIGA_MAC_VER_42:
- 	case RTL_GIGA_MAC_VER_44:
- 	case RTL_GIGA_MAC_VER_45:
- 	case RTL_GIGA_MAC_VER_46:
- 	case RTL_GIGA_MAC_VER_49:
- 	case RTL_GIGA_MAC_VER_50:
- 	case RTL_GIGA_MAC_VER_51:
- 		ops->down	=3D r8168_pll_power_down;
- 		ops->up		=3D r8168_pll_power_up;
+ 	case RTL_GIGA_MAC_VER_01 ... RTL_GIGA_MAC_VER_06:
+ 	case RTL_GIGA_MAC_VER_13 ... RTL_GIGA_MAC_VER_15:
  		break;
-=20
  	default:
- 		ops->down	=3D NULL;
- 		ops->up		=3D NULL;
- 		break;
+ 		r8168_pll_power_up(tp);
  	}
++
++	/* give MAC/PHY some time to resume */
++	msleep(20);
  }
 =20
  static void rtl_init_rxcfg(struct rtl8169_private *tp)

--Sig_/Nn9ni4/CUuW.SmmUnxG9wQo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzqsoACgkQAVBC80lX
0GwmSQgAgraBcMfkbUoAoHv8uYUWx/sSvmrDWF4rblJNt8wWxh26lCVhK6WDE9x1
/8Uq3HCYkQZeegApW1QwUCMLoBUqusN2+tvNkf1ON4qVX1/Cj1wMf8yWV6H0iQck
AtXAIKC6lrdOfGTSfzWMBzkS3Zsz3OvTqWHbs+9n/2PnUzw7C8Gsj05x2dFodylc
2FTE+MbQCu/65yQ5UR3bK+cYFPPqHIggwehbU3nqBpcocCtZYw8Hc9zuWqtg8yHT
CE4hoAtXs+8/9XhcyhUadMD1XVjqIfNu16JatgaaAtyEjNGwdoh7uSHQmrkysB1/
eHyoMW7iG99ViO/8mS8dafK4AQpKtA==
=XmWc
-----END PGP SIGNATURE-----

--Sig_/Nn9ni4/CUuW.SmmUnxG9wQo--
