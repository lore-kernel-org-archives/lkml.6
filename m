Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC69C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F4F218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Py/Y1rWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbeLUCAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:00:07 -0500
Received: from ozlabs.org ([203.11.71.1]:54111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbeLUCAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:00:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43LWzS2zKNz9sDN;
        Fri, 21 Dec 2018 13:00:04 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545357604;
        bh=FTvwa24DGwfRcIzOOzpgZioMUMe6ALxMX8+6yoIxPTg=;
        h=Date:From:To:Cc:Subject:From;
        b=Py/Y1rWIwXl3WcJBdyLsO7XzhkqwpxG0ssLmSu453AiEbDbYZ773bqqy2cKlF+/AO
         4IKMKfR383HcDUVsHF+0eh1/iENrrLAVHIhz75ekpz1BAWvbVOJhX8wheq7vKr2M2r
         wWf7jb/cZ6hBYBahOMY5EwWJjxR+ZbWSvjbe2kyhmCwxhn/5Wt4f3xYjmnDc4kceJH
         mbDuUzCSoeFqWlCAD5SDh7eK16f2f9oQSUAf5TiJ0qOShRqOd5ihsPHcpXUd6Q7kA2
         tj83KyQqjAF9XScWpb70aQa13hLs4r1+N7r+ZGBG/2xsQL9ppku107UkutOTjv8nTa
         b7gj4RIqfj7sQ==
Date:   Fri, 21 Dec 2018 12:59:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the pm tree with the kbuild tree
Message-ID: <20181221125945.0114b06c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OtcpDx96gi_Op+L3WGIkaGf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OtcpDx96gi_Op+L3WGIkaGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pm tree got a conflict in:

  arch/arm64/Kconfig

between commits:

  2eac9c2dfb2b ("PCI: consolidate the PCI_DOMAINS and PCI_DOMAINS_GENERIC c=
onfig options")
  20f1b79d3359 ("PCI: consolidate the PCI_SYSCALL symbol")

from the kbuild tree and commit:

  52146173a033 ("arm64: select ACPI PCI code only when both features are en=
abled")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/Kconfig
index 53233ab80744,bcb6262044d8..000000000000
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -163,9 -163,7 +163,9 @@@ config ARM6
  	select OF
  	select OF_EARLY_FLATTREE
  	select OF_RESERVED_MEM
 +	select PCI_DOMAINS_GENERIC if PCI
- 	select PCI_ECAM if ACPI
+ 	select PCI_ECAM if (ACPI && PCI)
 +	select PCI_SYSCALL if PCI
  	select POWER_RESET
  	select POWER_SUPPLY
  	select REFCOUNT_FULL

--Sig_/OtcpDx96gi_Op+L3WGIkaGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwcSREACgkQAVBC80lX
0Gwssgf/eRqT4c2Sxt7OKBlG0L1FLEoHi5BNMUmZvHJYWUijT/ziNctms/mJuvB0
ymP5h4eyTS0OuN9gA+TRhXnl1uWKjvq8NjfF0JfIo559Zfuvtu3ApOcvLGWvgdCU
zUb0MJqK9WJyfN+Mghcd6qUaaxFLNtigHjso9a+LE7LZP5UDdz5NVTib1f5OcnQF
Bpv2V7XIki7AB1ZP1G3eolevZkbZvJ0uU1So7SNGSJcMUy5pRwsHWXTxCalfxras
mfxhUC/CLhnuKtb0UXNFSsl733JNXwmSUBhq7hNTFF7M3+xt1oUnZCkAYsP3aZHp
WidPi+/k+NiD9lOJuhIVjkSVB20iug==
=pyEM
-----END PGP SIGNATURE-----

--Sig_/OtcpDx96gi_Op+L3WGIkaGf--
