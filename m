Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F8E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QqZdBu/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfBKDmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:42:39 -0500
Received: from ozlabs.org ([203.11.71.1]:36651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfBKDmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:42:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43yWnk0gjLz9s5c;
        Mon, 11 Feb 2019 14:42:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549856556;
        bh=mIAzwWQFY/oHAvTc5ET7WklKxIjPBd5gqcZH9BfkMwI=;
        h=Date:From:To:Cc:Subject:From;
        b=QqZdBu/eCRGczsHVxUjuDuFpAyjxT7e91tDK4t0r6qpUK4j2NOycA7P2sMocb4RQw
         rsxOLgcWmBIV3fyslZWnKjfYDnBJffslvXICm4Vw5n6nSPsmqnpqun5t0GqoUPxh4v
         SiK9kCvZkcV/upucTkVH+qGIaz5LKEOgSi/jZDScjjmoTsW3wdy8RczbStIkG962Yn
         MQuBS77VLIxGoLcahXfaWqkQmZ6PnYIXPwrYs8zFRqQKx5Jvb3Fzt/nREf6cHZg6pr
         JPn6MBmwEI+XHG1pxfMvVYgmy3AQ3rDQFZOoZLrtbD0xwiEVPKDVbu6ZE3YL6/7HhM
         uhhOADmUFyJ0g==
Date:   Mon, 11 Feb 2019 14:42:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Igal Liberman <igall@marvell.com>,
        Evan Wang <xswang@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: linux-next: manual merge of the phy-next tree with the net-next
 tree
Message-ID: <20190211144222.56663b44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8TI7ikn2bMGd=VjdQLYPBZ0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8TI7ikn2bMGd=VjdQLYPBZ0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got conflicts in:

  drivers/phy/marvell/Kconfig
  drivers/phy/marvell/Makefile

between commit:

  14dc100b4411 ("phy: armada38x: add common phy support")

from the net-next tree and commit:

  9695375a3f4a ("phy: add A3700 COMPHY support")
  cc8b7a0ae866 ("phy: add A3700 UTMI PHY driver")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/phy/marvell/Kconfig
index 224ea4e6a46d,b8e9dd38ad0d..000000000000
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@@ -21,16 -21,27 +21,37 @@@ config PHY_BERLIN_US
  	help
  	  Enable this to support the USB PHY on Marvell Berlin SoCs.
 =20
+ config PHY_MVEBU_A3700_COMPHY
+ 	tristate "Marvell A3700 comphy driver"
+ 	depends on ARCH_MVEBU || COMPILE_TEST
+ 	depends on OF
+ 	depends on HAVE_ARM_SMCCC
+ 	default y
+ 	select GENERIC_PHY
+ 	help
+ 	  This driver allows to control the comphy, a hardware block providing
+ 	  shared serdes PHYs on Marvell Armada 3700. Its serdes lanes can be
+ 	  used by various controllers: Ethernet, SATA, USB3, PCIe.
+=20
+ config PHY_MVEBU_A3700_UTMI
+ 	tristate "Marvell A3700 UTMI driver"
+ 	depends on ARCH_MVEBU || COMPILE_TEST
+ 	depends on OF
+ 	default y
+ 	select GENERIC_PHY
+ 	help
+ 	  Enable this to support Marvell A3700 UTMI PHY driver.
+=20
 +config PHY_MVEBU_A38X_COMPHY
 +	tristate "Marvell Armada 38x comphy driver"
 +	depends on ARCH_MVEBU || COMPILE_TEST
 +	depends on OF
 +	select GENERIC_PHY
 +	help
 +	  This driver allows to control the comphy, an hardware block providing
 +	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
 +	  used by various controllers (Ethernet, sata, usb, PCIe...).
 +
  config PHY_MVEBU_CP110_COMPHY
  	tristate "Marvell CP110 comphy driver"
  	depends on ARCH_MVEBU || COMPILE_TEST
diff --cc drivers/phy/marvell/Makefile
index 59b6c03ef756,82f291cf59ee..000000000000
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@@ -2,7 -2,8 +2,9 @@@
  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+=3D phy-armada375-usb2.o
  obj-$(CONFIG_PHY_BERLIN_SATA)		+=3D phy-berlin-sata.o
  obj-$(CONFIG_PHY_BERLIN_USB)		+=3D phy-berlin-usb.o
+ obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+=3D phy-mvebu-a3700-comphy.o
+ obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+=3D phy-mvebu-a3700-utmi.o
 +obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+=3D phy-armada38x-comphy.o
  obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+=3D phy-mvebu-cp110-comphy.o
  obj-$(CONFIG_PHY_MVEBU_SATA)		+=3D phy-mvebu-sata.o
  obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+=3D phy-pxa-28nm-hsic.o

--Sig_/8TI7ikn2bMGd=VjdQLYPBZ0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxg7x4ACgkQAVBC80lX
0GzBIgf+IfI1WpbCKVbRMA2wC01SNGAG4oOI2wk6oo2EHuvD5o/24dnaDJLnuHVp
Kx120GT3wW+ybOldhxvsuHOV7FjSAK9JvakggIxijWFxSW1Wn75wLl5E0294h3ar
hrnYZxXLVdBEBKg1ucTuloiwxn4hzUSxMNBIBkkDXPyHbaAGTllf30NHB4o1jwd9
M8eQfxIG8ZdDPipeZ59/f7pE+0rDchv+b/L4XO5Cdx29TAqE/zB2FRdmsbeGIfDL
3c9h+QGDWwoluc+CHO3fR3RyxS5/VSk+5asrmyUJViu4iu8IOqfCsvez3S38oALh
VeSmi5TJh+/BD0E5Zt770KhZ3KuePg==
=7Cwj
-----END PGP SIGNATURE-----

--Sig_/8TI7ikn2bMGd=VjdQLYPBZ0--
