Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA6D208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NSt5uu5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA6D208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGKDRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:17:01 -0400
Received: from ozlabs.org ([203.11.71.1]:53089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbeGKDRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:17:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41QPLw0G36z9rxs;
        Wed, 11 Jul 2018 13:14:46 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531278891;
        bh=FvU7G6yO+5rESc2PPkwR1MDwUFD+9aWM+kFtdRIYfGY=;
        h=Date:From:To:Cc:Subject:From;
        b=NSt5uu5NyNPK93O7ogWs/frH4MLF9ncGe8SdymDdxiRQYTWLGNuFzu5LPVLiIzTDt
         E4Ke744q3f4uo89e+OafB9lj6M/wy2LCwC+vI7S6wOOIjEYyJtfhR+cLZG+Xkv2de5
         iH6iXiRUSvswQ1XV1aRr6ZCLDGjiNjez/SiV2fMPreGIaHr4r21+uNGxgGYuSSLHlC
         2t5i8zcOkcd1QwfsFa+YBhLWCpT1BnI3X0ZL5E/AiuxryRYVeGUeQK/7oo+ypvVudP
         UKZICIeKv8x0Dy5MAvl6pGXEiRtvlp8EvmlIzHi7zxGOeu21idjR/ssUxByGYuX1xT
         b1LqWBNX5fsrw==
Date:   Wed, 11 Jul 2018 13:14:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Joerg Roedel <jroedel@suse.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <damm+renesas@opensource.se>
Subject: linux-next: manual merge of the driver-core tree with the iommu
 tree
Message-ID: <20180711131445.7e1e211b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZB_EV=/VOo4LV+5uIju_jPU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZB_EV=/VOo4LV+5uIju_jPU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/iommu/ipmmu-vmsa.c

between commits:

  0b8ac1409641 ("iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code")
  3701c123e1c1 ("iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code")
  98dbffd39a65 ("iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code")

from the iommu tree and commit:

  ac6bbf0cdf42 ("iommu: Remove IOMMU_OF_DECLARE")

from the driver-core tree.

I fixed it up (I removed the new IOMMU_OF_DECLARE() lines) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZB_EV=/VOo4LV+5uIju_jPU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltFdiUACgkQAVBC80lX
0GwyGQgAgumIwKcl83UyqhQ47y1sbnT5VKpE+SMWaoYqmGtSzDmA2daouViyoBA/
8ZGxSoqGqNA28k/RUJ7AQ+NI5H+DIG1Lp2+YniSRKUDDTMSFg35IeYaQwRhloPUL
EQ+O+poHFFjVrB2kkm5zOIwN82c1t09E/8GMavPrs3Fiod5mcs9HDtOr1DZxNH0o
MygnAOvqWc+P7ygyojBWkMWlaDVi2O3xmWULiGiE5Ri2NVMwnZmtnA8/cFrCfAVP
hfTAVtj11eEomuFxTWRjWfS9hoh333G6hAuf/7oy8Xah/46t0kOTiFYkdmo3nOFo
EwbtFi4tNJ9ubJl6YMh475DsQGVfRA==
=PPHf
-----END PGP SIGNATURE-----

--Sig_/ZB_EV=/VOo4LV+5uIju_jPU--
