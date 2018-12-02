Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2742C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9152C20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XJYtbi2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9152C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbeLBWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:06:52 -0500
Received: from ozlabs.org ([203.11.71.1]:58329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeLBWGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:06:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437MfZ49clz9s47;
        Mon,  3 Dec 2018 09:06:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543788407;
        bh=eEz2kkIDsi2/9hZg1L1GBQdIh9gCmM8uEVy0TX6LW0s=;
        h=Date:From:To:Cc:Subject:From;
        b=XJYtbi2dIzFDY5waTEnSyoZRGOVXziatf6p4yN+e4eLS7p8PVq9ObPkC4Xjs4Bhyv
         Pvk44lH74VtdQlZrJBi5sZVUyHTj+9kV4YTEFafTH7yxLCxagqLSSQsZsvdyGa3s5V
         BiZkJuBtnLk0/tYg/Wf6EbfvjgIijL9B9ADgPHVwaVZpEO+9ZYixYCJ/hBzILJ729G
         JB2AIp42XKijnU/Eo2a1tuHIB10mPX/HSpjpv90fOYKQpGxQKk7YTxvbYvRsNX4tjy
         3fBNtSimN2twocYUfXNU2M8jFpjbGqrkZhsgH3cpXbtLWHfpxa7eaMpciA+EEAOFUv
         I06dDFAvz6PkA==
Date:   Mon, 3 Dec 2018 09:06:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQg?= =?UTF-8?B?UMOpcm9u?= 
        <peron.clem@gmail.com>
Subject: linux-next: manual merge of the arm-soc tree with the kbuild tree
Message-ID: <20181203090640.487321e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y35zpDCRjxf=8rLb+CbrFfj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y35zpDCRjxf=8rLb+CbrFfj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/mach-socfpga/Kconfig

between commit:

  2eac9c2dfb2b ("PCI: consolidate the PCI_DOMAINS and PCI_DOMAINS_GENERIC c=
onfig options")

from the kbuild tree and commit:

  fbc125afdc50 ("ARM: socfpga: Turn on ARM errata for L2 cache")

from the arm-soc tree.

I fixed it up (see below - I also resorted the select lines since they
seemed to be so before the former latter commit) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-socfpga/Kconfig
index d43798defdba,a04660918d71..000000000000
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@@ -3,6 -3,6 +3,9 @@@ menuconfig ARCH_SOCFPG
  	depends on ARCH_MULTI_V7
  	select ARCH_SUPPORTS_BIG_ENDIAN
  	select ARM_AMBA
++	select ARM_ERRATA_754322
++	select ARM_ERRATA_764369 if SMP
++	select ARM_ERRATA_775420
  	select ARM_GIC
  	select CACHE_L2X0
  	select DW_APB_TIMER_OF
@@@ -10,7 -10,14 +13,11 @@@
  	select HAVE_ARM_SCU
  	select HAVE_ARM_TWD if SMP
  	select MFD_SYSCON
 -	select PCI_DOMAINS if PCI
 -	select ARM_ERRATA_754322
 -	select ARM_ERRATA_764369 if SMP
 -	select ARM_ERRATA_775420
 +	select PCI_DOMAINS_GENERIC if PCI
+ 	select PL310_ERRATA_588369
+ 	select PL310_ERRATA_727915
+ 	select PL310_ERRATA_753970 if PL310
+ 	select PL310_ERRATA_769419
 =20
  if ARCH_SOCFPGA
  config SOCFPGA_SUSPEND

--Sig_/Y35zpDCRjxf=8rLb+CbrFfj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEV3AACgkQAVBC80lX
0GzvuwgAoC2WyAKFyQtmka9DPSfzrpWvkOBV9RwC4bEcGcgAFnVXmICcMbqlRFlE
EIlvhsf28ioSE+OPWQ3g82xssuDncpY83TncnkayI8Uf9rjYlIKkvoi3fcl+tc0Y
jcbL1TbeAwzn1miS8UU+nste/65lSQdxG+qYV1Rkv+b77++YVQxX02z6gCvtJx7/
o2SmoA86IVhrkgl1KDwVsqjYA4iRrkWqWiP9B6nn5LsayZLSWF2b9HV7AzfctCMz
sFaAKvuNgueVTfd66lvY6aFxZ0rI1VQmdk4PIVXXs6h3Iuz530SQf9vz6mzY3+If
BEjVoQ27vrjIJM7Ut9+n4jD3jbPsWA==
=UN20
-----END PGP SIGNATURE-----

--Sig_/Y35zpDCRjxf=8rLb+CbrFfj--
