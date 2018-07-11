Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A686EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE020883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aVElWrKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDE020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeGKEHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:07:18 -0400
Received: from ozlabs.org ([203.11.71.1]:54633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeGKEHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:07:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41QQSq1y4Dz9s01;
        Wed, 11 Jul 2018 14:04:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531281899;
        bh=2+gBjgbFAa8o6/i5pWF5PyDmxdlVuMwssnkXf/voS8U=;
        h=Date:From:To:Cc:Subject:From;
        b=aVElWrKRLN8wy5JLTBPw9dYkMvUbMPkkdeNE6bLdp52JhYQIGWLqFKoJih3RUlllR
         r8rlISV3KnYceIwrR/uNmQBuD9q5jq2dNPhztX4dpujaZgyobVVY8EtIBhcpPg0+mm
         Zh0fKjM0B56Xb/eRlZAGt06NKsJHjcT675pdhedx97nTwj7i+nHtqHJmPKmkBhNip/
         73yxtIL2GO9MG9wZRyl3FvdJ/xFjS7LedFcZaVzSrF8HYR2xI1+XXuZZ2HE/BzlGdH
         qCDFbt1sUDd0llAHzpYue4/zgArk3jKrngqHuLsHBLZVREkPJu9S9/BghXwzJFIp0+
         OeM+QCGKXb4pw==
Date:   Wed, 11 Jul 2018 14:04:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Joel Stanley <joel@jms.id.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20180711140457.5c366429@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1eZtUXTwsZ5Tl_Ex05JZRCm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1eZtUXTwsZ5Tl_Ex05JZRCm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  MAINTAINERS

between commit:

  54e45716a84a ("scsi: remove NCR_D700 driver")

from Linus' tree and commit:

  01a21986f8ed ("MAINTAINERS: Add Sam as the maintainer for NCSI")

from the scsi-mkp tree.

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
index e5f8823b5f02,f3de5d37179a..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9810,17 -9750,6 +9810,11 @@@ F:	drivers/scsi/mac_scsi.
  F:	drivers/scsi/sun3_scsi.*
  F:	drivers/scsi/sun3_scsi_vme.c
 =20
- NCR DUAL 700 SCSI DRIVER (MICROCHANNEL)
- M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
- L:	linux-scsi@vger.kernel.org
- S:	Maintained
- F:	drivers/scsi/NCR_D700.*
-=20
 +NCSI LIBRARY:
 +M:	Samuel Mendoza-Jonas <sam@mendozajonas.com>
 +S:	Maintained
 +F:	net/ncsi/
 +
  NCT6775 HARDWARE MONITOR DRIVER
  M:	Guenter Roeck <linux@roeck-us.net>
  L:	linux-hwmon@vger.kernel.org

--Sig_/1eZtUXTwsZ5Tl_Ex05JZRCm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltFgekACgkQAVBC80lX
0GyLxgf/ZbdUKiln2In+FEmGRANJnGOnmXddqKfU4UAuekTRCCgtzdRrmya9Z8MC
s6yBnGM35QN0Hj34xv7aUVs2vfuHP61wEXu31CT+XLYt0TlPBkdr5Nlhe2IYnxak
8X5fuKhlSHSPoEC3X3Eo0US+Z/vMKDcdZfELtITOUpP7+sSEJAE70QDyzjHd6LCg
AK5AsYQ4epmsu9yNg3kCwbBVWAV1EU110cs0dbi+g6Sk6Unhv/Cu+RkTXk2ewz74
sbJf72QmesQ7OASwUtxo6hf+yKv/McP2A4AfISyfL8QRrolOD+ZiTwE2yOpvrZCz
2qj/DtnPiLNFU5gGtsdo9/zKxvZDSQ==
=l96p
-----END PGP SIGNATURE-----

--Sig_/1eZtUXTwsZ5Tl_Ex05JZRCm--
