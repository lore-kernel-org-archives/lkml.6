Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEBWhC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:37:02 -0400
Received: from ozlabs.org ([203.11.71.1]:40051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeEBWhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:37:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 3 May 2018 08:36:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Heiko Stuebner <heiko@sntech.de>, Simon Horman <horms@verge.net.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: linux-next: manual merge of the rockchip tree with the renesas tree
Message-ID: <20180503083654.625b1f9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DAM6OskVOpE_cG+0dRV6M.9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DAM6OskVOpE_cG+0dRV6M.9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

Today's linux-next merge of the rockchip tree got a conflict in:

  arch/arm64/configs/defconfig

between commits:

  93f7bfd930c0 ("arm64: defconfig: makes SND_SIMPLE_CARD to module")
  ddf3fa8b8a16 ("arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD")

from the renesas tree and commit:

  e9cfce4195ec ("arm64: defconfig: Enable HID over I2C drivers")

from the rockchip tree.

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
index 7930caf5dde4,34037d24fbf4..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -158,9 -157,9 +158,10 @@@ CONFIG_BT_HIDP=3D
  # CONFIG_BT_LE is not set
  CONFIG_BT_LEDS=3Dy
  # CONFIG_BT_DEBUGFS is not set
+ CONFIG_BT_HCIBTUSB=3Dm
  CONFIG_BT_HCIUART=3Dm
  CONFIG_BT_HCIUART_LL=3Dy
 +CONFIG_BT_HCIUART_BCM=3Dy
  CONFIG_CFG80211=3Dm
  CONFIG_MAC80211=3Dm
  CONFIG_MAC80211_LEDS=3Dy
@@@ -443,8 -447,8 +451,9 @@@ CONFIG_SND_BCM2835_SOC_I2S=3D
  CONFIG_SND_SOC_SAMSUNG=3Dy
  CONFIG_SND_SOC_RCAR=3Dm
  CONFIG_SND_SOC_AK4613=3Dm
 -CONFIG_SND_SIMPLE_CARD=3Dy
 +CONFIG_SND_SIMPLE_CARD=3Dm
 +CONFIG_SND_AUDIO_GRAPH_CARD=3Dm
+ CONFIG_I2C_HID=3Dm
  CONFIG_USB=3Dy
  CONFIG_USB_OTG=3Dy
  CONFIG_USB_XHCI_HCD=3Dy

--Sig_/DAM6OskVOpE_cG+0dRV6M.9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrqPYYACgkQAVBC80lX
0GxQxAf9GfkYqauShdhR2gInMpLHiCACafgyuVZWYoIMmQjghzZr3i5n+8SAzliz
WcvFEK20CHzkB8FMORWbnd/g5842xPxS1oRaSDweHqdm7MHbRtKXwUXtr+rGQAjp
s1o4m4WNGKd8yDf50RsDS0ntKVkjTfl6ayft5UKonNak4jxogHermgVWWHe+51Yb
LO1Ko+TSg+d4VyK/ZKwJKhvYhk5pvckka4r/CxojTy3V7C6Yl21N/utJbRv21du+
K1EibhjZI5Ym3eladZ5ryFEp652H8HR3Lww+Kk5zv4KFdrgzquu7D2bSbC3bhq9x
GZKfkI2nDMFs2JQop9FcMhcCbe/aCw==
=7JFj
-----END PGP SIGNATURE-----

--Sig_/DAM6OskVOpE_cG+0dRV6M.9--
