Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCLVp5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:45:57 -0400
Received: from ozlabs.org ([103.22.144.67]:54157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbeCLVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:45:56 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 08:45:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@codeaurora.org>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: linux-next: manual merge of the qcom tree with the amlogic tree
Message-ID: <20180313084516.49718221@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5XX3mInVEPgUs6+wuJ2GbmB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5XX3mInVEPgUs6+wuJ2GbmB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Today's linux-next merge of the qcom tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  266c157de3b2 ("arm64: defconfig: enable MESON EFUSE")

from the amlogic tree and commit:

  52fe48c2b9bb ("arm64: defconfig: enable thermal sensor on QCOM platforms")

from the qcom tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index df2b08b1554f,a37130b54fae..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -565,7 -572,7 +575,8 @@@ CONFIG_PHY_XGENE=3D
  CONFIG_PHY_TEGRA_XUSB=3Dy
  CONFIG_QCOM_L2_PMU=3Dy
  CONFIG_QCOM_L3_PMU=3Dy
 +CONFIG_MESON_EFUSE=3Dm
+ CONFIG_QCOM_QFPROM=3Dy
  CONFIG_UNIPHIER_EFUSE=3Dy
  CONFIG_TEE=3Dy
  CONFIG_OPTEE=3Dy

--Sig_/5XX3mInVEPgUs6+wuJ2GbmB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqm9OwACgkQAVBC80lX
0GxOdQf/ZvQsipdh+fg8zd4azJ2CuMwF9J7LGXRIsaCoL/pTwxg3pRroH9G6970B
t2wuBNkjqa4jqhLDb7tgqIdnF6GqutbqhlWNtFi9sxyq8iG7KDp78yO9iOJaWmwo
/4D1vxSnwrsmqvRfMb6W1E472IBVBm8zUa3kjw4IOzxIgSf+ttcDbuSgeyYMXycw
+KqFyvgcBayaWPAEdkg+yrKqZD6j9A+7PWssDm34V0oPmCYW3LsCgpvBBLD+Do4p
T2r051BInb+oCIsLIuISAJnCOpFHB81NzW8WeFzOdIe+32TdyR3XeJQsXueqp2Ti
Hb3LjywFIFrPnRfvZjQ0C5zM+Hrs9A==
=mdCv
-----END PGP SIGNATURE-----

--Sig_/5XX3mInVEPgUs6+wuJ2GbmB--
