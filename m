Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C078C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 23:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3B02070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 23:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Cpx717/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfAFX1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 18:27:41 -0500
Received: from ozlabs.org ([203.11.71.1]:33191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfAFX1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 18:27:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43Xvng62Fhz9s55;
        Mon,  7 Jan 2019 10:27:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546817257;
        bh=D969FbDSIMU2YMDYAbbFHJ1vJfaspc84mPPEGHbGKHo=;
        h=Date:From:To:Cc:Subject:From;
        b=Cpx717/ggBte8hwuOy+gfTSYUxdj+OI50WzPHq9RO4xnn6/B8/TZ96yW+YbMAAx+g
         wG1+G4VmAQ7Un/RX1RsPMFyNx0mNjr5VHmRx3MWCe5GHwzJexrGTVVYIpe2mM+TQ2D
         SyDxw0WQTUDleWl+UAVYiMKli04dmXrDT+3I1be8tw9UMqZjzQBgnByf2IPmX9YP+S
         x3nwex/RCi0vwiiDXTVa+kNp/3LBecS8rxjE+7rfitGSiwIBKjMznJlGKC7yqDcs5Q
         Dh1XdkqCLXTELvED+xU27ESXtRxBBVKEm0QmGYxsUpw4VgPFK1+rkaYJugwSHwFiSF
         wJPpyl/rvkUNg==
Date:   Mon, 7 Jan 2019 10:27:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20190107102727.0c67e3d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.Zc9CJH194ceCFRxm77Z9+b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Zc9CJH194ceCFRxm77Z9+b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guo,

Today's linux-next merge of the csky tree got a conflict in:

  Documentation/features/io/sg-chain/arch-support.txt

between commit:

  7c703e54cc71 ("arch: switch the default on ARCH_HAS_SG_CHAIN")

from Linus' tree and commit:

  ee8972b1ab82 ("Documentation/features: Add csky kernel features")

from the csky tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

You want to add "select ARCH_NO_SG_CHAIN" to your Kconfig somewhere
(see the commit from Linus' tree above).

--=20
Cheers,
Stephen Rothwell

--Sig_/.Zc9CJH194ceCFRxm77Z9+b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwyjt8ACgkQAVBC80lX
0Gy09Qf9Fkilw44ICvIepYWbFbRsQgrY2aVSAQIn1CeOx4OmVagXgJhe47936KVq
udfZkFF8N1NzZKBx2b/vQGyMi0RHUZUXhyEKat3EywVhGdNsgdTqtiP1UaKzKKk9
WUUdhCxLeXY780ukdtDJn70y/M7thXwcQmTbWYpRSCvzjp8vlOQ1eOzup5Ek95ei
V79b9urfXilzPDOsgyDgyUO7ycyFc84V8JLKlenxruiJ1GNeAGhG83IvmLNJJ8cw
yfNUrEVLeGRtu0dJoF/sxaTXAinYf+rCFMOgCz3lKAnUDLSKwkFg03a+nSd4VhRC
EZcTiTpPKL0fjHaqGVz0Ed1l7dLDOA==
=wXDZ
-----END PGP SIGNATURE-----

--Sig_/.Zc9CJH194ceCFRxm77Z9+b--
