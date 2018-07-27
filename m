Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0CAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4611920862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CpTpDRE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4611920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeG0JT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:19:57 -0400
Received: from ozlabs.org ([203.11.71.1]:47351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeG0JT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:19:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41cLvh45Tcz9rxx;
        Fri, 27 Jul 2018 17:59:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532678354;
        bh=1vu8/tykk+LHzT/HoJRrI3lvcvWnf/hPVINo4hGhsRo=;
        h=Date:From:To:Cc:Subject:From;
        b=CpTpDRE59/MgqfABrCMcvrrArmuU5tdGLwIepRb1JpwQFy+RZNW+4S3fk46sq+zet
         QEWY0XtpKWiEksBugl1UD5lrLl8Zmp9QSjvLqkr+S6aGA/KBgcaDC0ZtuFVZsd+qQ+
         WjGclNIGU/MxASWBl8KdbHqIzgXJ9/r1mVH/Kq2VDSv668QjzX83Lis5IKYkrWvA6X
         e3A6MAbmxSha8C1DRr3sJjS7g1mcWldE7CA5jr8EGQtrU022/xX1MG2Wvh3FfP9cuV
         mc2xU/I5xODKgc6NOSYj3+rvIxzLS8D1bY5FRXOdUQ6m6lJba3UkLNpC06YvsQQZCr
         aWgPZHUwch5kw==
Date:   Fri, 27 Jul 2018 17:59:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: linux-next: manual merge of the staging tree with the powerpc tree
Message-ID: <20180727175911.76ed6d44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L97V92Xz7lZANjfkOVsej2B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L97V92Xz7lZANjfkOVsej2B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  MAINTAINERS

between commit:

  d69ccc00c497 ("MAINTAINERS: Remove the entry for the orphaned ams driver")

from the powerpc tree and commit:

  28d1a7ac2a0d ("iio: dac: Add AD5758 support")

from the staging tree.

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
index fc92aab3ca2a,b9503cefc42d..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -807,6 -791,19 +807,14 @@@ S:	Supporte
  F:	drivers/net/ethernet/amd/xgbe/
  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 =20
 -AMS (Apple Motion Sensor) DRIVER
 -M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 -S:	Supported
 -F:	drivers/macintosh/ams/
 -
+ ANALOG DEVICES INC AD5758 DRIVER
+ M:	Stefan Popa <stefan.popa@analog.com>
+ L:	linux-iio@vger.kernel.org
+ W:	http://ez.analog.com/community/linux-device-drivers
+ S:	Supported
+ F:	drivers/iio/dac/ad5758.c
+ F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
+=20
  ANALOG DEVICES INC AD5686 DRIVER
  M:	Stefan Popa <stefan.popa@analog.com>
  L:	linux-pm@vger.kernel.org

--Sig_/L97V92Xz7lZANjfkOVsej2B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlta0M8ACgkQAVBC80lX
0GzA1wf/SAWQBwpGl2//kv3uNZcfXQbHK1Igv2Ep82CgDzsyA6W2J34947rS9m9r
MokmbvEcac4BJWVRVismDosGNNFwYZiTxI1XHsmj5pZIUxzF9ejCAiN/R8wcy4Z2
bkHn3MAThP9HWVFYmT9VGXEpTHkhPuWNvgmmVfr+xre/PaSBrIs8gMAnotF/+0qB
cTRufaMJfEpgXatqE8sGvtx0WMsRwtP1hF8AOlHOKt0SRk1ibOOBQQ7uhROvZCCw
M755bev3wwaQ3C9YRR6lDrEy+33qa2h3Ohe1Lt6e3ozb+1wDgm1XvFEwbkkd73wS
DZ8cfYBeytGlYRmmX1ha4RWGM4U7rg==
=Rdb9
-----END PGP SIGNATURE-----

--Sig_/L97V92Xz7lZANjfkOVsej2B--
