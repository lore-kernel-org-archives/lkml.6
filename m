Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEPW5k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:57:40 -0400
Received: from ozlabs.org ([203.11.71.1]:46885 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeEPW5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:57:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 17 May 2018 08:57:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Simon Horman <horms@verge.net.au>, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: linux-next: manual merge of the renesas tree with the mvebu tree
Message-ID: <20180517085728.680dd1bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wspZCVMZBK1pehs9ntEVrs5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wspZCVMZBK1pehs9ntEVrs5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the renesas tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  873edb2930ef ("ARM: multi_v7_defconfig: Update with current configuration=
")

from the mvebu tree and commits:

  57eec170e954 ("ARM: multi_v7_defconfig: Disable CONFIG_FB_SH_MOBILE_MERAM=
")
  eedd7902366b ("ARM: multi_v7_defconfig: Enable RENESAS_WDT")

from the renesas tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/multi_v7_defconfig
index 8bcf3be58047,374a40945b0f..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -463,23 -489,20 +464,24 @@@ CONFIG_XILINX_WATCHDOG=3D
  CONFIG_ARM_SP805_WATCHDOG=3Dy
  CONFIG_AT91SAM9X_WATCHDOG=3Dy
  CONFIG_SAMA5D4_WATCHDOG=3Dy
 +CONFIG_DW_WATCHDOG=3Dy
 +CONFIG_DAVINCI_WATCHDOG=3Dm
  CONFIG_ORION_WATCHDOG=3Dy
  CONFIG_RN5T618_WATCHDOG=3Dy
 -CONFIG_ST_LPC_WATCHDOG=3Dy
  CONFIG_SUNXI_WATCHDOG=3Dy
  CONFIG_IMX2_WDT=3Dy
 +CONFIG_ST_LPC_WATCHDOG=3Dy
  CONFIG_TEGRA_WATCHDOG=3Dm
  CONFIG_MESON_WATCHDOG=3Dy
 -CONFIG_DW_WATCHDOG=3Dy
  CONFIG_DIGICOLOR_WATCHDOG=3Dy
+ CONFIG_RENESAS_WDT=3Dm
 -CONFIG_BCM2835_WDT=3Dy
  CONFIG_BCM47XX_WDT=3Dy
 -CONFIG_BCM7038_WDT=3Dm
 +CONFIG_BCM2835_WDT=3Dy
  CONFIG_BCM_KONA_WDT=3Dy
 +CONFIG_BCM7038_WDT=3Dm
 +CONFIG_BCMA_HOST_SOC=3Dy
 +CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
 +CONFIG_BCMA_DRIVER_GPIO=3Dy
  CONFIG_MFD_ACT8945A=3Dy
  CONFIG_MFD_AS3711=3Dy
  CONFIG_MFD_AS3722=3Dy

--Sig_/wspZCVMZBK1pehs9ntEVrs5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr8t1gACgkQAVBC80lX
0Gw7uggAgZFIj8Uu1wcbJYYfQIQbTafhhW7KLFqfmvqWaFkzX54PtlASNxq92QY0
M31bVDct2r8OCZ03I0VsYtpaDMpbpphq4rZiwJnA3qpZPMz9JPCD80bwJaKfGPDF
9G084MpComkDKZptNtDnhsNQJRBGp9b5Uaf1Y0GD2un/OmllsMoo6Yg6nsxiKFfh
2+uJ+PCYH2LuLfpPOWgjzdzGB6xeiaECByzDC/YBauhUc/acG/Jr/N9Vo1T6ba8v
1EBunbfSs8BGPxEen+neCBGuDfN5FWZWF0Y2SUPkcJLdS3R/3xzoWjiCLxKAMqIW
/z1snNUNQbbJ2LhOsAjgGhzY57sLIQ==
=vaWe
-----END PGP SIGNATURE-----

--Sig_/wspZCVMZBK1pehs9ntEVrs5--
