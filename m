Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6FAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D48820578
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FveyYHr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeLPX5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:57:19 -0500
Received: from ozlabs.org ([203.11.71.1]:54901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeLPX5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:57:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J1Rc0X8Pz9sDN;
        Mon, 17 Dec 2018 10:57:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545004636;
        bh=Pxcqezk0hlkGO7Is3YFHOdCZsD+6//981F3ztDCEL/M=;
        h=Date:From:To:Cc:Subject:From;
        b=FveyYHr9fpNFYHn+wlVHtvapuOS9fGkYY8ESYuCmT8v6bI49YdrWcY+O2fApKhtHW
         YXrBLxr3oQJcUORROx31xRma7w/eMFV1MR1PTfRiSglkJVs9i7czl6e4taJt2xVQzD
         YzkeynCLDMJAYxFoXWTtgATJE6dxGnko1ov1RMWFMv6syFV8urB4piV7aSI2hHDArm
         gG4+yt1Y/uj65MBalZ8BhgVMR2XTi+Jpuap6wlEdf+enUnN4la6zyVT1XqyIaioCrL
         ZbSiOsAnnLfIoKHGFaYGSNSt4XeWfUhuDCnp1W7jJNzljoDOyjvtpFsKtQemoVHl3c
         aK+uadcPPOgRg==
Date:   Mon, 17 Dec 2018 10:57:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Zhang Rui <rui.zhang@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: linux-next: manual merge of the thermal tree with the kbuild tree
Message-ID: <20181217105715.5da0b389@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WQXhQ.z3uvrgIA0yf=AzGEV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WQXhQ.z3uvrgIA0yf=AzGEV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/Kconfig

between commit:

  17815cc6622c ("treewide: surround Kconfig file paths with double quotes")

from the kbuild tree and commit:

  3e8c4d31f8ed ("drivers: thermal: Move various drivers for intel platforms=
 into a subdir")

from the thermal tree.

I fixed it up (I used the thermal tree version of this file and added
the following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 17 Dec 2018 10:54:07 +1100
Subject: [PATCH] drivers: thermal: fixup for Kconfig string parsing tighten=
ing up

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/thermal/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 9c06d4ad7c97..2e013eeb4a1d 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -55,7 +55,7 @@ config INTEL_QUARK_DTS_THERMAL
 	  underlying BIOS/Firmware.
=20
 menu "ACPI INT340X thermal drivers"
-source drivers/thermal/intel/int340x_thermal/Kconfig
+source "drivers/thermal/intel/int340x_thermal/Kconfig"
 endmenu
=20
 config INTEL_BXT_PMIC_THERMAL
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/WQXhQ.z3uvrgIA0yf=AzGEV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW5lsACgkQAVBC80lX
0Gx+Wwf+Md4shsec2H6PMWmjwdCEbRfmgXe/a/jQThjPcPMBzrxOUA5uFQRsKhu/
7AoJFxEpNhBFAEYgS7TZlASPokpN3zbqte0i+KoGCKtFoXNd1spBI0BYT7cqD4EP
+QSEcVOrB2jPvRT+ujhLGmAhgul2jKlQya6btFYk5/ZP1eAdQoZ+r0ugu4qmudzt
WvEEV+FtmNn7NqPWb5ScAtuyb1Q3SOauGFZqi4OklveZAWd9UfTgcX32eSSLOb1p
f1KPOQxeR9i8SgNGsrNuHRdOY1gWPNRirAZ+L06jCYwr+QqcnndAc6ij/ORp1Wno
1gjZSO0xmDjttEUwzPHqXE9mmDM9JQ==
=7kxA
-----END PGP SIGNATURE-----

--Sig_/WQXhQ.z3uvrgIA0yf=AzGEV--
