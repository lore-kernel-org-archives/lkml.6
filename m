Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E29C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E071C217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YBK2omNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeLWWYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:24:01 -0500
Received: from ozlabs.org ([203.11.71.1]:37601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLWWYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:24:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43NH2h5gFkz9sDT;
        Mon, 24 Dec 2018 09:23:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545603838;
        bh=WEZ/fL8vniMinN+CrIK3XGV036ncyB18ATdH4oGkYWU=;
        h=Date:From:To:Cc:Subject:From;
        b=YBK2omNmPMO4cN27EngnV0DDyEFVvqmN6gLDWqLItEc7HG08yG9YYgntmgp3Y0NYc
         3RLt1+5ZvVsYqzFKcPl0ImERppWirS3+yCLVnVONTNx8Nj7QmlrTQ8XqprD57fKF0z
         ApUI1csJT2kOEYAc24ANfe4Xy2TGRul0nlm/2/aMz247V4ABZ3Xt0zVP1mqUfz6IVY
         PU2GKsIl526DlarCHX8fIsEt6KtgteD+GgjdpNdg/5szH5BTi+5XqPcoxhgqzX3GDd
         IiwQ53Jw9Pc6340IsI70MBwjkEa5RcXG1CZxk5Daf/FVLKSPi/pdpt1uGGYQcNWmon
         aDfSj2DfVcW2g==
Date:   Mon, 24 Dec 2018 09:23:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Hogan <james.hogan@mips.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Roese <sr@denx.de>, Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the kbuild tree with the mips-fixes
 tree
Message-ID: <20181224092351.4f58c1ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L28VHnv2MMg8dsHidwMlIzx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L28VHnv2MMg8dsHidwMlIzx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  arch/mips/ralink/Kconfig

between commit:

  0b15394475e3 ("MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8")

from the mips-fixes tree and commit:

  eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")

from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/mips/ralink/Kconfig
index 613d61763433,4c8006b4a5f7..000000000000
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@@ -38,8 -38,7 +38,8 @@@ choic
 =20
  	config SOC_MT7620
  		bool "MT7620/8"
 +		select CPU_MIPSR2_IRQ_VI
- 		select HW_HAS_PCI
+ 		select HAVE_PCI
 =20
  	config SOC_MT7621
  		bool "MT7621"

--Sig_/L28VHnv2MMg8dsHidwMlIzx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwgCvcACgkQAVBC80lX
0GxVqAf7Bf/uVndq/44LOJzR2dy8386B7/+ti6cqLEK0G6W12Hc5VFH/OSyMOgsq
2Lav+4EpZME014MY718+hYM73+Rmn9DXE/pEZFm/ILT/UrkgpHB4zgbCRJslFMVV
JuLRyZcD6zORE5fhkCJiKrjrb9ccu3VJyI7pzlVf+UzX1zFHDNOpxKN4Drp0tW8s
6/Jv+voou/PalxXcwHRBu1lwHNWwnB+pNpC9LGdA9TA11cq1tNoedTnhyl632Qjm
q28ahgBck9Nb9cRa7GHEK+uvHHa85lvpM6cq7FIlG0t8nrmXLs7bkzVoiUTlpdsd
580Hhds7WgHT+WM3dFXttcnF5TZeIQ==
=K4o4
-----END PGP SIGNATURE-----

--Sig_/L28VHnv2MMg8dsHidwMlIzx--
