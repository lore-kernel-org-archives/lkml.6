Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D120645
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K9y1PMkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66D120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeHUFHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:07:42 -0400
Received: from ozlabs.org ([203.11.71.1]:54547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeHUFHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:07:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41vYWk653mz9rvt;
        Tue, 21 Aug 2018 11:49:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534816179;
        bh=0PfL2vTbhcQvDbXPIUQPfFEqDSr+sIZyCmWR/v72LIk=;
        h=Date:From:To:Cc:Subject:From;
        b=K9y1PMkWro6uA1+XaNU//CHliAYJLasm972JQPNWSs/gdSwpxvIlkoWZqhBn+uJVR
         VJujXlCIa+fJMoybF1rHr5lIkWEIGRJ9AeLJ55fI4ay1KJUsb/qVNkXYqb+BAGGKw7
         xzuVWux5c7C9iBtmlzalN0vNUrDS3Yw7pMkXcTS6FLcDHX5zSoDwGxIyg2S9LXPJQj
         wvzghnVUL2cI9ux9n1FXjqb2bBajyeFRiHi+L3ZtlCqT/o00jKN4QKTlZ4qpt8PK11
         TkcmtU9CaLCgD5B2cEnOsvrhUd9TFOMv/Tk0EAsRzVP8iYnDJ1Kj376lu/nnCH3Bs+
         +hAwRxcPU/XXQ==
Date:   Tue, 21 Aug 2018 11:49:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: linux-next: manual merge of the xarray tree with the nvdimm tree
Message-ID: <20180821114924.0133d568@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YYriHAKQDnmippWqdOewGUj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YYriHAKQDnmippWqdOewGUj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

Today's linux-next merge of the xarray tree got a conflict in:

  mm/memory-failure.c

between commit:

  6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagem=
ap pages")

from the nvdimm tree and commit:

  0c2b437d7e2b ("mm, memory_failure: Teach memory_failure() about dev_pagem=
ap pages")

from the xarray tree.

I fixed it up (the former looks like an updated version (after Linus'
"review", so I used that version) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I guess the xarray tree needs to be rebased on the changes in the
nvdimm tree.  :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/YYriHAKQDnmippWqdOewGUj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt7b6QACgkQAVBC80lX
0GwrPQf9GHnKNn9uuagOUzpUZWyAEOty6hY7/m2HCmZEYLDL5hMf87KkR5UYORLp
xesgfVLG35bsksbNtr2WP085sFvWJvwQIW4lVo+TB6D4thUK6M2ywGYTEprFUk15
Xp7S7VtyCw+qE1OVuOE7wHoYBM4i0PzHEkaE9Vm9TPh4uEiX+jzuPcAumJ+k+1e/
XZ4P1v4ZXTbgZYkTLDhI1rcTkG2IDxmHEPT7y2SE6EQXd1Gk/g4uXlzt/4gMeajT
62yyfqqeDWWvKXVCzox6etpKi6cVXt8Bt87yu3hjzKF6yF45mPcCVsXW8LeX35OO
N9dXuD+DuSTLKqnllclQdkyxHHH2JQ==
=oUTT
-----END PGP SIGNATURE-----

--Sig_/YYriHAKQDnmippWqdOewGUj--
