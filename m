Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522162146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QtGULuSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522162146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeLFEsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:48:09 -0500
Received: from ozlabs.org ([203.11.71.1]:51373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbeLFEsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:48:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439NQD72QHz9rxp;
        Thu,  6 Dec 2018 15:48:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544071685;
        bh=Tm6K1xd8wClvCRP3gHUgh0TzV2xJs1SFxZU++Xzttz4=;
        h=Date:From:To:Cc:Subject:From;
        b=QtGULuSaiMM30KEFTAgqbs+9VqzkNxNyyl6uFgxYK48DOUshrJtGUCN0FLeV2IjGZ
         YAUli5MTIAM28z2LGF9Xdi3VZNU2H8gJat+BXD1m1YArOcHRV2cTb+ZRHYGqPzFWvu
         McqbBz4Mbil+Ckan1rEEeEl2Hw4nUxZNigF2jx9fcN0yHcWAYIfbeXCd7cax5sP+N5
         wxr0cbtAo9d3n+qsYSBN1W3ttF41XrHz0UFMYiF7iFzsL0f+wCEd4K5g0sXHJPAARB
         Df699yFUTie5+6Hech9ttMobwOVSnJQQjT7JEHpCwgG/i/RY7ndEVEAXu1ZFustged
         eph3E76vSwgag==
Date:   Thu, 6 Dec 2018 15:48:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: linux-next: manual merge of the char-misc tree with the mmc tree
Message-ID: <20181206154800.760ff17a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ffg39yqI/Vx32a1y1J=WXlm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ffg39yqI/Vx32a1y1J=WXlm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/misc/Makefile

between commit:

  4eb78924bf0e ("misc: cardreader: add new Alcor Micro Cardreader PCI drive=
r")

from the mmc tree and commit:

  fcb418cd567f ("pvpanic: move pvpanic to misc as common driver")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/misc/Makefile
index fe3134cf3008,b76d611c87de..000000000000
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@@ -57,4 -57,5 +57,5 @@@ obj-$(CONFIG_ASPEED_LPC_CTRL)	+=3D aspeed
  obj-$(CONFIG_ASPEED_LPC_SNOOP)	+=3D aspeed-lpc-snoop.o
  obj-$(CONFIG_PCI_ENDPOINT_TEST)	+=3D pci_endpoint_test.o
  obj-$(CONFIG_OCXL)		+=3D ocxl/
 -obj-$(CONFIG_MISC_RTSX)		+=3D cardreader/
 +obj-y		+=3D cardreader/
+ obj-$(CONFIG_PVPANIC)   	+=3D pvpanic.o

--Sig_/Ffg39yqI/Vx32a1y1J=WXlm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIqgAACgkQAVBC80lX
0Gyjjgf9FaEoV1AVFyRXqRMbZWAE40NHZfRtqVv1dlXmAKZfJggQIUMNBnpaj5X2
wFdPYZuFx4yqRA9ZA27dXn4sFUIrB1VJ6FQvZUmhktQDAVVMWTaoZrcmcglEpbha
z493m/9W/UPutwOD+f7swFdiiLIpmiCZVDgmVaF8Dav21sopHh8Zovf0R6JkTaoj
jYvG9bh85iVlHT6zpCwrJ/IOOmhqvgcpS9Sq4wNBZ0Fma2XXfFlWV6qi+P0shG9q
ZXl29FvwsPsAw0EePU1cuDKwK3vDKPSfLUcy4t7xSSUfBw940CfaUYcQF2nVeD+p
bJw9LJLVbHR3uc4l9ncfpuJkrkxmkg==
=k1v1
-----END PGP SIGNATURE-----

--Sig_/Ffg39yqI/Vx32a1y1J=WXlm--
