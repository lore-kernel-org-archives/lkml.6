Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D867BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BFA218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sdU21v4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBFWv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:51:58 -0500
Received: from ozlabs.org ([203.11.71.1]:38813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfBFWv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:51:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vxXC2Y1xz9sLw;
        Thu,  7 Feb 2019 09:51:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549493515;
        bh=4GLOM1TwxR3SOK76vXsP2ac3gquqflMobVXl/Tu1z5c=;
        h=Date:From:To:Cc:Subject:From;
        b=sdU21v4YII6Zyd2WUw9vrwhxfXgFH/dzPQoBUt26WEWY2e87GpesqKjAyN1jMhTqL
         OG+0XkfZ7+zm2qHOy9463TvotBSB3dWbIkvZ4Yf0gKQnEfuYL2fPnY7ZBdqUyK+dNJ
         EsUBcS/uxYaUoHG4MAQZFBFq53xDET+LqbpScDy1vkMP7h1KNSEpBGw+STRlB0xF3Q
         y2sVPvQAZXigNeG3WCzja3moVmw/MOQK6qFTzEOq873WhzYHZIjf37WQGhnYMiysw/
         R0MFzu60UeWX6h6doejB5EJtOryxdFJlqf4lFNYkrHVrAaD9SAVxcVTMOUPpk8BCtF
         1YYAV3ycUhy+g==
Date:   Thu, 7 Feb 2019 09:51:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stephen Warren <swarren@nvidia.com>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: linux-next: manual merge of the tegra tree with the imx-mxs tree
Message-ID: <20190207095142.5ccc4a8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WT+k+ePHoTcu=Rq6DTBR8a4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WT+k+ePHoTcu=Rq6DTBR8a4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  9bd01e74c715 ("arm64: defconfig: Add i.MX8MQ boot necessary configs")

from the imx-mxs tree and commit:

  bc72bed682a9 ("arm64: defconfig: Enable Tegra TCU")

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
index e82bc8cf1253,ad8f3dea0a74..000000000000
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

--Sig_/WT+k+ePHoTcu=Rq6DTBR8a4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbZP4ACgkQAVBC80lX
0Gxg1gf/TVpU60x2w77NkepYpjEhutbNqhFgZkB8I4+txLylVckQ42g9LJe38j3Z
SBqeHI12IgZQPhWVPg7FHkm5i4cKQ52aL0KkxQeAmMSLefUl1mP4iwnVWJQ92PhJ
a7nEAqRyQ2HfOkJciG5hdYyRaj4Qn8ba9hLlFG+0MTkQ31Fk9YcQkipOzkyTr21p
iUB3jnsQQQeto+s/22buRY0unu+yB3V0koppc0ECMQ+XyM5W4A0LQaXh9cLaloRj
F4umJHcjYnU6FiRcem+ZEDEV2D1koU9FztSmo4q+h50FNgiYk2lQ1MXE24Ny2YC4
3/ir4oKjhHswah6coflg8YtxMIlzTw==
=gSE1
-----END PGP SIGNATURE-----

--Sig_/WT+k+ePHoTcu=Rq6DTBR8a4--
