Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A81217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pfih5w8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfBRGv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:51:29 -0500
Received: from ozlabs.org ([203.11.71.1]:52687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBRGv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:51:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442vfQ1jYCz9s1l;
        Mon, 18 Feb 2019 17:51:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550472686;
        bh=sK+8/kkYAV3+9S1t/Qg9chsaKyyI91xrwy4pSpP4Gh0=;
        h=Date:From:To:Cc:Subject:From;
        b=Pfih5w8Ch7fij1HEJQ0wo+OHXB7xzGw/IF18M5vkEOfS2S09w5zUjYZr/sFgPR5Iv
         FL67QRbskgXaSBh6M+7G7fjZ7uMlcBE0tJYItWTTUB/ancWS4C22BUSfKFJhsfjmt0
         cq47VEUJUQlITY9E/I13K1D4fN+vmr1uEb5/SvtuARmNpXFKAWVJqDtnFoyA/8S/DQ
         aDxxda9vljv9rko12abY+hDWN2PlASiM5/jdk7vYLV7Up/b0VR0kv87sUzFhVtB2vS
         VV9ml+xPBHrBYMRpxj9FQ1fLY9UWAAABmwm9omxOsTtTbtTA2ua5H7jmDwhkQadlrv
         lU/zamAYVdQOQ==
Date:   Mon, 18 Feb 2019 17:51:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20190218175120.3881e6e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VKDVsEiVnq5PvWNRVkS0Nrh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VKDVsEiVnq5PvWNRVkS0Nrh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  fs/binfmt_script.c

between commit:

  cb5b020a8d38 ("Revert "exec: load_script: don't blindly truncate shebang =
string"")

from Linus' tree and commit:

  76b21f3b9c4d ("exec: load_script: allow interpreter argument truncation")

from the akpm-current tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/VKDVsEiVnq5PvWNRVkS0Nrh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqVegACgkQAVBC80lX
0GwT5Af8D5P6csVxW2x9ywIHDc6vag/0xXSzxEXQ9xJXhUflctzGU0RiYYfdSbHy
l7KSbVI5Dw5Q1ES493UaboCAhOmokTSxnPCQskaxtzhqNCZvVOkWDu/nr8sEMTdB
hebyeUPl8W6vXLs3AToJPoreq+k6tCr15mSQTFjcejN2gIqU9fMzRGxDkL7Y/lMP
kmkEm+NHPnbX3Q+98oMvnfVRSJavxBkEj/pt23zX9nh1RcXmtKZf2gRfS5S+rOYy
GoJLB7Uo9J7cekhXuwjeRyas/xdZ7jRZzOuUn4aOsfukH1RXE0nbYQ7IaHlJ9yt8
2/ui44vm/6qq3oF/FfXgwIgvR4Oycg==
=HZCq
-----END PGP SIGNATURE-----

--Sig_/VKDVsEiVnq5PvWNRVkS0Nrh--
