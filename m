Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA96C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EC721916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mFPajnUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBHChm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:37:42 -0500
Received: from ozlabs.org ([203.11.71.1]:55939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBHChl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:37:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wfVC00cCz9sML;
        Fri,  8 Feb 2019 13:37:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549593459;
        bh=ewyxE2YYKEN0Jrc4WKKSnv6aoaIosPyA75IKKzjoj8o=;
        h=Date:From:To:Cc:Subject:From;
        b=mFPajnUNYBe4f9oFB3mTX1cjqSvoFlV9Y1x8vivU49xfch1j4gHaIR2asnlwQVLFU
         Es6iTB+RAtw2TLwDaUzAEIKQqnvymZ1b9N1y5yskbHR7I+CecBwuYIKlWxtlFfKalw
         Sq4y1QHLHVMMpKfYChB2oy9fijBrUlNd4oH1UlpkYZDGshH0EkbZY88lP/MFVLTqYp
         jrpASYhU0x/+wD4ydQNE9baQem7rHPLt6f7+Uhsr4AHGXtvc3pYuVP87eIjn7/XBp1
         kEsPa64w6cFtNnczubJCRbZ+HUzju+jD4WAnGnYCCligvsZdXqE/DaLaiLw+hjxCTA
         ojyZydFvyHn3Q==
Date:   Fri, 8 Feb 2019 13:37:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20190208133737.7e754345@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RYFxXftXKhJ.WhDx6NNvdM1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RYFxXftXKhJ.WhDx6NNvdM1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/mfd/Kconfig

between commit:

  9baddb61dfec ("mfd: Fix unmet dependency warning for MFD_TPS68470")

from Linus' tree and commit:

  09fdc9857712 ("mfd: Kconfig: Fix I2C_DESIGNWARE_PLATFORM dependencies")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mfd/Kconfig
index 76f9909cf396,f38f8741c68e..000000000000
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@@ -1419,10 -1419,10 +1419,10 @@@ config MFD_TPS6521
 =20
  config MFD_TPS68470
  	bool "TI TPS68470 Power Management / LED chips"
 -	depends on ACPI && I2C=3Dy
 +	depends on ACPI && PCI && I2C=3Dy
+ 	depends on I2C_DESIGNWARE_PLATFORM=3Dy
  	select MFD_CORE
  	select REGMAP_I2C
- 	select I2C_DESIGNWARE_PLATFORM
  	help
  	  If you say yes here you get support for the TPS68470 series of
  	  Power Management / LED chips.

--Sig_/RYFxXftXKhJ.WhDx6NNvdM1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxc63EACgkQAVBC80lX
0GwF7Qf/b0JvOMzx6xHaTPm+jt9f5xJArw/OpfqpgM2hgrNnOs3aNyF9/r0HaFCE
dVAPbcASOZG2W7zUNz26dluCTxeUBl7LSk4SrJShx7CqHJkPKul3tVVAUtMdZ1NI
GzuNgi7AxVHuMv5awzVrjx/FHb4jYjyps19mlHWcfHzTGNG/TFuQS36+yd5Uwzc4
OQpRV34ViusApRFCRtfTXplTLjbP1/+O/e79A/mJr6Q9YT3Jo0Jmn0jmLmgBFvds
1h4fBa4IkAGWlV7gS6exRi4VsaoKg1QFfoop0/E1HQ+2GfL7Y7ps+IsH9CHvAr6N
ksevTALRBPXaMoYzUVnW6Sn9vMHBlg==
=VcQB
-----END PGP SIGNATURE-----

--Sig_/RYFxXftXKhJ.WhDx6NNvdM1--
