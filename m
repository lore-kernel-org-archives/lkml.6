Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A608218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jCZ0jWsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfBKWBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:01:39 -0500
Received: from ozlabs.org ([203.11.71.1]:49427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfBKWBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:01:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43z09r4Pwhz9sCh;
        Tue, 12 Feb 2019 09:01:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549922496;
        bh=AsyEXtC8weYLVwj4ZBkNBOBIk3Bxolv4klBIKHoeOs8=;
        h=Date:From:To:Cc:Subject:From;
        b=jCZ0jWsYWpbaOFjeulm9MXl4E8nBFYTJpOgSocKC7GYqp57ESi36A9MMrzLOOflOy
         RFcYDNXJAVmhIAmUwSy/DsYsyLBElr6mNbuStLcDwgY6WT6+UkrX0QQ4EMWMzI6Nj9
         Y+IQn9tWAM776075h3KqsP4cSNR06iMfnMFMk2UKKyue+crc6ZvOpV/37tNApmwuvF
         9g5h8JXZQcHKsgkWRylvdes8v7zlkYbLkjevuB8Tngmw3mzKz31oi8BZN+Eu0WsNnF
         1X4hYTYpoYT7ebiXpIuiClFgCiLtdJ2bTFOg43XRY7/QtYJz6nxReujEYflzKlDjCc
         I/Nfrvy1eZafw==
Date:   Tue, 12 Feb 2019 09:01:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>
Subject: linux-next: manual merge of the tegra tree with the imx-mxs tree
Message-ID: <20190212090115.69bc5891@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4m3zFkKOm50f0EXg2j9mM.B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4m3zFkKOm50f0EXg2j9mM.B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  28cfe2434529 ("arm64: defconfig: Enable PFUZE100 regulator")

from the imx-mxs tree and commit:

  2b5d2c92c29d ("arm64: defconfig: Enable MAX8973 regulator")

from the tegra tree.

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
index 3317d85fa8a3,ad8f3dea0a74..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -323,8 -319,7 +323,9 @@@ CONFIG_SERIAL_MESON_CONSOLE=3D
  CONFIG_SERIAL_SAMSUNG=3Dy
  CONFIG_SERIAL_SAMSUNG_CONSOLE=3Dy
  CONFIG_SERIAL_TEGRA=3Dy
+ CONFIG_SERIAL_TEGRA_TCU=3Dy
 +CONFIG_SERIAL_IMX=3Dy
 +CONFIG_SERIAL_IMX_CONSOLE=3Dy
  CONFIG_SERIAL_SH_SCI=3Dy
  CONFIG_SERIAL_MSM=3Dy
  CONFIG_SERIAL_MSM_CONSOLE=3Dy
@@@ -451,7 -438,7 +452,8 @@@ CONFIG_REGULATOR_GPIO=3D
  CONFIG_REGULATOR_HI6421V530=3Dy
  CONFIG_REGULATOR_HI655X=3Dy
  CONFIG_REGULATOR_MAX77620=3Dy
+ CONFIG_REGULATOR_MAX8973=3Dy
 +CONFIG_REGULATOR_PFUZE100=3Dy
  CONFIG_REGULATOR_PWM=3Dy
  CONFIG_REGULATOR_QCOM_RPMH=3Dy
  CONFIG_REGULATOR_QCOM_SMD_RPM=3Dy

--Sig_/4m3zFkKOm50f0EXg2j9mM.B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxh8LkACgkQAVBC80lX
0Gzupgf/X8ZQhsCIII364APt7lOTefhR8gN/8NvjrJYMbcI6W8OkFCIFar7+6zqE
+gcdLkO8yTDUzf3I8VKifTJXhlJ+gYV011bSZx2WwdOEYhb0kiVzVLj3DcbmFZKm
bbbK88hgh92LOIax23Xa4TqfhXUD6GNUuHbQpXsosqCw0V2ChIXHn1rPjXmL+zh/
thZkHPSEF/UsmY3/IruU1bb7DAW6OzlsWkJmsc5q+TT6G4sP1W/S5EXM5ASbu+s/
cEgbuymnHeK0xTWATH/AfPGzsm5b4f74W78oAebqCAkPH2PinvLqLTCov2iONkTI
Kb9yrkAATN3SxYrnCczXQ47klza7Wg==
=MTyt
-----END PGP SIGNATURE-----

--Sig_/4m3zFkKOm50f0EXg2j9mM.B--
