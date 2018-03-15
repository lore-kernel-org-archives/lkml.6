Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCOFdL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 01:33:11 -0400
Received: from ozlabs.org ([103.22.144.67]:36225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbeCOFdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 01:33:08 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 16:32:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marc Zyngier <marc.zyngier@arm.com>, Greentime Hu <green.hu@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Archana Sathyakumar <asathyak@codeaurora.org>
Subject: linux-next: manual merge of the irqchip tree with the nds32 tree
Message-ID: <20180315163238.3a257f86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W9JEON=u4+pdO8EdsSkghqa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W9JEON=u4+pdO8EdsSkghqa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

Today's linux-next merge of the irqchip tree got a conflict in:

  drivers/irqchip/Makefile

between commit:

  abe45fd9f1b0 ("irqchip: Andestech Internal Vector Interrupt Controller dr=
iver")

from the nds32 tree and commit:

  f55c73aef890 ("irqchip/pdc: Add PDC interrupt controller for QCOM SoCs")

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

diff --cc drivers/irqchip/Makefile
index 110de02bb215,c35ee5345a53..000000000000
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@@ -83,4 -85,4 +83,5 @@@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+=3D irq
  obj-$(CONFIG_ARCH_SYNQUACER)		+=3D irq-sni-exiu.o
  obj-$(CONFIG_MESON_IRQ_GPIO)		+=3D irq-meson-gpio.o
  obj-$(CONFIG_GOLDFISH_PIC) 		+=3D irq-goldfish-pic.o
 +obj-$(CONFIG_NDS32)			+=3D irq-ativic32.o
+ obj-$(CONFIG_QCOM_PDC)			+=3D qcom-pdc.o

--Sig_/W9JEON=u4+pdO8EdsSkghqa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqBXYACgkQAVBC80lX
0Gyc7wf/Q09ahH0VRTsWGi5ylxSt2+B1DG19qfRgwdFNItpQeYTcE6UkSplT/U4o
wj+6CaMK7X0tts8Ff3zD61hF3CgDPm9c7n8b5u9ThIPJnPhbXjk6SPz3ghotQCMh
j9uq75iZmkzgA2XZEikUqRfIF3xXRix9Cq6FLb4GbR5rfvkXS+Rl5KEHA1gal0do
PRdJmTrF/AIuXAzDMj6XEgHCftR+zgr/FrT9dCz3ONmjVEyOH4+qKqtJngh7TX4m
HVa+VoWaTe2pfqZVuH2h3VhMKErsA9Qi9iIcnZiZNvKX467nCZ9bzupfv7UaueTE
KFAoKBD8iPwfCnN0Umm2CFNeMLQAUw==
=aBjd
-----END PGP SIGNATURE-----

--Sig_/W9JEON=u4+pdO8EdsSkghqa--
