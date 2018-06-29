Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56381C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0176D27964
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DRRQ/rQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0176D27964
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeF2E5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:57:25 -0400
Received: from ozlabs.org ([203.11.71.1]:49609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbeF2E5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:57:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41H4Bp1ZPlz9ryk;
        Fri, 29 Jun 2018 14:57:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530248242;
        bh=a1sTxScuLDR63KKwxgKldZsOkqbM3jETwnX6rQbbmV4=;
        h=Date:From:To:Cc:Subject:From;
        b=DRRQ/rQmlU4gdIgoKIBQlkLdkH3owEUqP3FFOstP0OInQimlb0+Y+xyAQ0czFVi8K
         jqiqW3VUw+cqfY2hMFoGuUaMmsHb6GXQR78SqejPI90x5EiguQBDn/RbVxXeSaFR1V
         O6BdMhv0xvrTDonxaPObX8YKenh5b/I01yLzpu4Xy9m0XBQYAEXS6p/mT858EfbXY8
         WmtkHefXRczhOxjsSyO3TbcXp3N5PMVsIZUY7+XVRyHnv7cD+9+I1N1mPks9wnTuqM
         WZwJrjunnp+D35+t9cmfqtLxTwO36yEEPl29XAYJcMqdFuupbYRNcmliMU96qcXQzV
         izrj+NLm5IeBw==
Date:   Fri, 29 Jun 2018 14:57:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Li Jun <jun.li@nxp.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20180629145719.0d7b8fe7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L40r_4KLPcaV2A3wfd+01p="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L40r_4KLPcaV2A3wfd+01p=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/staging/typec/Kconfig

between commit:

  e16711c32bca ("staging/typec: fix tcpci_rt1711h build errors")

from the usb.current tree and commit:

  990da41530b3 ("staging: typec: tcpci: move tcpci drivers out of staging")

from the usb tree.

I fixed it up (I removed the file and allpied the patch below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 29 Jun 2018 14:54:04 +1000
Subject: [PATCH] usb: update for tcpci drivers moving out of staging

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 972fd1911045..ee808903983f 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -65,6 +65,7 @@ config TYPEC_TCPCI
=20
 config TYPEC_RT1711H
 	tristate "Richtek RT1711H Type-C chip driver"
+	depends on I2C
 	select TYPEC_TCPCI
 	help
 	  Richtek RT1711H Type-C chip driver that works with
--=20
2.17.1


--=20
Cheers,
Stephen Rothwell

--Sig_/L40r_4KLPcaV2A3wfd+01p=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls1vC8ACgkQAVBC80lX
0GzydggAov5EbQ+wOVAxirdqIjoX9a99U9dblvLIduzdGc0O2ufxgxLe5R48QNVL
nc78eta7q+wzrx4DtYgYVXoxqvy1c+ZCDeJBCV7JwD2bxtcP0vgcVfx0aY7grQ2Q
cqntGtjzPSaJM84VA4vFT+Z3G/KsGZiSOav3ajxfiWGq3NlMFPGWXUxT2WYrp9FN
KyIc79GaWXws1Eyge23F15UKVQnIEjV2yrMDzK8K5VOkO6AA7S063epBYLMKQXgm
Rqoit2fbYpEUjammqXMSdmUWdx6ne2UT5DcZRj9a0gALwHNPwnTvDFrwHz0WUzw0
TKe9ADgr8donOu47vOD9qP8P+dRzyQ==
=lkU6
-----END PGP SIGNATURE-----

--Sig_/L40r_4KLPcaV2A3wfd+01p=--
