Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19982C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0B020868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NRSs5s4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0B020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLGAxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:53:45 -0500
Received: from ozlabs.org ([203.11.71.1]:47707 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeLGAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:53:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439v9K4kQ6z9s4s;
        Fri,  7 Dec 2018 11:53:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544144022;
        bh=5BXN8eBwgorNw7fIjQL714vGUH1Im01QM5L0GwMy8bk=;
        h=Date:From:To:Cc:Subject:From;
        b=NRSs5s4JXTo7aYlUgGFQ0q8TonooYoGAWbWzjTOityJTRvVo0HoOYzFzQ2H1FtOgw
         GZCmmyA4+I84qKL70dfbsGu0QS/dDh1xf9nZUEtCro0WD7iNoBznZPTfhfHISWdPgr
         tJXQqwrdx5WHlubxnhqyLcCzxw4JVNgksaWZFXfSJFRdP/K4lBKJt9a7JttavILXee
         iTj1dHz/6MRsm/xphi8BUAyaBTe8r7fwKiPnZo58hfEIOZikeuD7HYAVv91carpO82
         8KPKmWB83KcLVTjC9SGAizGNk51/HHKuVPwye3fgyrUTYXdnAmbU+mKsrTCd9xpBl3
         V5ZTlryZF9Cbg==
Date:   Fri, 7 Dec 2018 11:53:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Eric Biggers <ebiggers@google.com>
Subject: linux-next: manual merge of the jc_docs tree with the fscrypt tree
Message-ID: <20181207115340.2465a854@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CEPcu3FO.paRPuD/SljvRJQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CEPcu3FO.paRPuD/SljvRJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/filesystems/index.rst

between commit:

  1b71a6809f96 ("fs-verity: add a documentation file")

from the fscrypt tree and commit:

  7bbfd9ad8eb2 ("Documentation: convert path-lookup from markdown to restur=
ctured text")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/filesystems/index.rst
index 818390c32be6,ba921bdd5b06..000000000000
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@@ -360,13 -360,13 +360,24 @@@ encryption of files and directories
 =20
      fscrypt
 =20
 +Verity API
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +
 +A library which filesystems can hook into to support transparent
 +authentication of read-only files.
 +
 +.. toctree::
 +    :maxdepth: 2
 +
 +    fsverity
++
+ Pathname lookup
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=20
+ Pathname lookup in Linux is a complex beast; the document linked below
+ provides a comprehensive summary for those looking for the details.
+=20
+ .. toctree::
+    :maxdepth: 2
+=20
+    path-lookup.rst

--Sig_/CEPcu3FO.paRPuD/SljvRJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwJxJQACgkQAVBC80lX
0GzszQf/YlYmIDVssO51Wa23m+eBSQb4K3ioft83i1KeNuVzYK4KPa4dYKWFQ2jG
FSLkpr1Ae9cqCggR381K/L/ufDavlEnK7QZlsWX/PbLRzeiHMrxCUwkAeOwDEf4r
12B4SZLghQ80m5yIdJUh1MToeDLfRVhlv2nBdFL0iTIaYlc2hBuc+sJoKMUxm0mU
cY9s3By5/JNHIrS0ftB/PKNKFXGToACjvENw/L8xLbVS04Q1MmiI18EGWB3l1Q4S
AqVWPfBz3qrsQa70lSIjzQ13OpilV775JsegvQKOcOWBT3DlMd1qk+16hNySUbcS
Y1b0uuLi6kJMwR4cde71W3j3rLMS8Q==
=V6dG
-----END PGP SIGNATURE-----

--Sig_/CEPcu3FO.paRPuD/SljvRJQ--
