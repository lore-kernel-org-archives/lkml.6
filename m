Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00114C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4572175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="O2c4Ycl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBGBZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:25:15 -0500
Received: from ozlabs.org ([203.11.71.1]:38417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBGBZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 20:25:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w0x225wsz9sLw;
        Thu,  7 Feb 2019 12:25:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549502711;
        bh=gGbamqHJf6wbfaPtlgZc1h5BSkkx9aFe/q3/FUo6vrc=;
        h=Date:From:To:Cc:Subject:From;
        b=O2c4Ycl217latYdMpF8rxD0ul6zmH+n+obEyMpr40l09iteH51C2QCL2/1xFAPlFV
         MTfobSLC/1IeIbp59RUvgdIiJcyNnIkh3u0qpUqLO7pELdDowD8bxo0oWwXp3C/YuW
         KabPgFszMkrWPtoi3UgO/Ae5h2YPrUc9XeH2omw5isrcOwpSm4fsMxxnSeJsk1Xl9r
         6x5KkWGn1DxViahXEPXNry8tYLEwFceFm1MQkCaGzrcVPfeqT3awcf4Ls0BTnY5nPK
         ZQADE/LBpQfwKKJyoOTQSMIL5wm3T5f+RdGCDq8G3IfKnjMaITM8NCz6v32/oHyJpV
         WrBuykLBVol/w==
Date:   Thu, 7 Feb 2019 12:25:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Jianxin Pan <jianxin.pan@amlogic.com>
Subject: linux-next: manual merge of the nand tree with the mvebu tree
Message-ID: <20190207122509.68144d86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/erH/6b8z4jz=/2fEeJwtDsJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  MAINTAINERS

between commit:

  2e73bb33366d ("arm64: dts: marvell: Add device tree for uDPU board")

from the mvebu tree and commit:

  0f416a463ecc ("MAINTAINERS: Add entry for Amlogic NAND controller driver")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 2d958beee76f,e6b902c7c828..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9887,11 -9849,13 +9887,18 @@@ F:	drivers/media/platform/meson/ao-cec.
  F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
  T:	git git://linuxtv.org/media_tree.git
 =20
+ MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
+ M:	Liang Yang <liang.yang@amlogic.com>
+ L:	linux-mtd@lists.infradead.org
+ S:	Maintained
+ F:	drivers/mtd/nand/raw/meson_*
+ F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+=20
 +METHODE UDPU SUPPORT
 +M:	Vladimir Vid <vladimir.vid@sartura.hr>
 +S:	Maintained
 +F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 +
  MICROBLAZE ARCHITECTURE
  M:	Michal Simek <monstr@monstr.eu>
  W:	http://www.monstr.eu/fdt/

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbiPUACgkQAVBC80lX
0GyH1gf/a6LAWUFi6kZSTqxMHXZFZj1xcglu51VmEcCgrCh9ooQvqF510dVdr9LS
21FvQrp7TvudZRef3PrL+dGX4HJGP7tT+5HlGID3f1mmrR1xnA6lOhY4ecThx8GY
Vk9yYxFFbuL3u7mCKlfevDmh1nw3kuGPfHcyLnkKEYgDKsQTNnuHUvBiwdtGhFq+
Fc12gV7BvSmrWt8OstFGO89sx1unQMJV9O2faWykT4OHhrO7ZDHFblUDEyVQH8IW
Gn82LWyi5RbjUpVi3nt4p8rDqTXVoQMm5q3ChMYVF1o68CO5NT2JVTIX9A4rOfVu
X8LhnLJp3iieUYLa71DsaL7MHujp4g==
=tYPF
-----END PGP SIGNATURE-----

--Sig_/erH/6b8z4jz=/2fEeJwtDsJ--
