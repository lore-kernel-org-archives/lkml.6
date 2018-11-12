Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D051E2250E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oZN+UzTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D051E2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbeKMI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:26:23 -0500
Received: from ozlabs.org ([203.11.71.1]:36943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbeKMI0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:26:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42v57y32ckz9s0n;
        Tue, 13 Nov 2018 09:31:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1542061870;
        bh=IWOoimvEOMs1BYZ9mOGBa2FpLEkLzJM28GGSKTVdNsQ=;
        h=Date:From:To:Cc:Subject:From;
        b=oZN+UzTVKAZHnjqA8Ir2XuaNKAYHGA/gREuKIop8V5b3iMdk4eRHjk5Gk1y86FY++
         6ruRlRbkjjpaE7DYxhRsZcoPpP3GKBA6R/qgSBDh36W5zt/t2uWExd/MrkBw8lH1T/
         v5LhB9zlNTjyRjm2F1HJjiK+7JQiBPGdf6G9cIjNl7zC5hhDtgJdB5oodj9P7SlxcM
         oAbYxpXJ4MHJxwg2aJMCIKQBXt3Us7VRnyn+vxOx+/EXqRRsNDjb/suzgu2rGL+XZv
         VOBfQ1FE9dKaroX+mWCa2gMYafXrRVEMOVFgFOvcGC3IX4pY5tGTpjWet0k+5haz4I
         kjZnlNde+LFFA==
Date:   Tue, 13 Nov 2018 09:30:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: linux-next: manual merge of the kbuild tree with the kbuild-current
 tree
Message-ID: <20181113093050.6785eec5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z.WKk4aE08LlmMrFOkFR+GV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z.WKk4aE08LlmMrFOkFR+GV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  init/Kconfig

between commit:

  f9af851aa8e7 ("kernel hacking: support building kernel with -Og optimizat=
ion level")

from the kbuild-current tree and commit:

  a4219aff51b8 ("kernel hacking: support building kernel with -Og optimizat=
ion level")

from the kbuild tree.

I fixed it up (I used the kbuild-current tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z.WKk4aE08LlmMrFOkFR+GV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvp/xoACgkQAVBC80lX
0GwrrQf/ZZFknZNh1+SpQvjKmllbRqc549c4i9odUL5r/bfu+tJOFYf++KksxeaA
oMION/jNRZKqfrL+Epmna+VRYf5bAA0biH3GvJnJpBHH322jn7fsFdLY5ndInXqS
rxiIl8fbvDQUAQe6GbnU5emXA3147OydgcL28ng2NG9BaqCjc2SNLOPjWvDGLAez
n4NzUIWbBOETfmtwH2PLAV43JrgYY4XiX2KNB7D/O3cljLL1assWYKDV7q/jFT0h
Qo2sh2q7ACofMsESLcCTuZW6qmgMW1QYl5C8Jm3/qEnwsYpjl5orh6gv7OuD4RLj
8yLF21Hu3jtSG3Jo79+rxYqyn6U9wA==
=XOFO
-----END PGP SIGNATURE-----

--Sig_/Z.WKk4aE08LlmMrFOkFR+GV--
