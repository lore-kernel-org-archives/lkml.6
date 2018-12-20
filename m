Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DBCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAA821720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R8Lu5mFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeLTHoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:44:14 -0500
Received: from ozlabs.org ([203.11.71.1]:34289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLTHoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:44:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43L3fy6swbz9s55;
        Thu, 20 Dec 2018 18:44:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545291851;
        bh=2YEYlPAXDFcCftQOV6l43AAopcpizVCyWN0tOED/g/0=;
        h=Date:From:To:Cc:Subject:From;
        b=R8Lu5mFhE9RjtBdr+0td7C/hLLsj/EpdobBJG70uuGVU6CZzBVgLXp/G3rcHIdcI+
         4JgRihVy9crceGn2beAygV0u8bKUPO/KUjLDD1q1E7Di5juXWUGrXmX/7ERDCMPwZs
         q+0iqCmdnL1HzZVrEfKsGZtk7yjnbBZNX2wiXMCFbeI7dG3upq+wwv6hBpP6cGY5Kr
         yjZ1O/S3Uw3cX8rXd9iJBamyUQv8Lsr67b/UTf1g/1F1ogEEeRh72Y5+5qUqd3MNnz
         cOVkDJr9wOvHWw2txbNALemaMZVTYKkoyhGpj1wFj12mnKHWR+xz5Xms6ikv9milXN
         YmjK7z/ZKl9pQ==
Date:   Thu, 20 Dec 2018 18:44:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20181220184403.464d0e3f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NUFyURPUj4tlatfFTLUZIz/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NUFyURPUj4tlatfFTLUZIz/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/sh/include/asm/Kbuild

between commit:

  2b3c5a99d5f3 ("sh: generate uapi header and syscall table header files")

from the asm-generic tree and commit:

  548211e87ba0 ("sh: include: convert to SPDX identifiers")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/sh/include/asm/Kbuild
index b15caf34813a,f4440779deab..000000000000
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@@ -1,4 -1,4 +1,5 @@@
+ # SPDX-License-Identifier: GPL-2.0
 +generated-y +=3D syscall_table.h
  generic-y +=3D compat.h
  generic-y +=3D current.h
  generic-y +=3D delay.h

--Sig_/NUFyURPUj4tlatfFTLUZIz/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwbSEMACgkQAVBC80lX
0GzShgf/T5RSzdQNcTuGZpLDZGkVG3MNj9Lnc4z13HYouxP0cYXzajshfVvDlfpH
TSgF59k8IX46bq9IH5xWn4/1/XczeThCqR8M7pUq/lFMWCDGuRRi+oBdy92yNLZV
mtQ0si2Lgc7e0/JXrHAjKzBhZ2WZiS9MYYG73mQoM3TWsfRSBTt+X1Hq+hei7LAk
UNWiOQcVSWJXMWpfcB4DmtuSjiQUezc70JURrG7mXfnv5LmLeuyHg9G2goXaIr11
letF/r+8Ycc5V1lT1DHjkEchojVAuXTaPmqpxTb3KUDRjktSe5S2ACdI94M4EX6u
crer9eRdWMs7M5qqWl4q7eYBgVRj+w==
=Vhyn
-----END PGP SIGNATURE-----

--Sig_/NUFyURPUj4tlatfFTLUZIz/--
