Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB002085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sSowMEhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfAGCQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:16:04 -0500
Received: from ozlabs.org ([203.11.71.1]:49127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfAGCQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:16:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43XzX1159Gz9s7h;
        Mon,  7 Jan 2019 13:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546827361;
        bh=KMECz8wt4TC5nH6d47Z0QQOdHJgpHjwUMTYjc/AoM0c=;
        h=Date:From:To:Cc:Subject:From;
        b=sSowMEhvCLxVwBRzgUiJbF5/ehP5tILXtxvGZwfWYGfNs9UWite0HMFAmLvPLqi3R
         F+Rp+1Q0OBAJzOGRfwpPtuaqx8gWpz7e4vphenm6oSAcItJwAm0NGBBr7PcIjHJMzG
         1gbNjq/OFmZVdcOoJwjHqaTNB6jZcXIUhehBo84DolEWFJcuZKpXa46yY34m5p29EK
         qCkoEn4DFuUZ+43jh9CCvl/2mm8VK1GK5ipxMlJpcdvmyJBKSTADnLCrHP30HSMxaC
         1hxhCumwv1tP4SOrNVtNnIm436t5asF1o8WGXaKOIeH82qP9m6mEqtewTAQYfWqaD/
         JmsAtMb65Ibxg==
Date:   Mon, 7 Jan 2019 13:16:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20190107131600.4a33b1df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IgU6laMv6xfhT4VrJeoT8Ra"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IgU6laMv6xfhT4VrJeoT8Ra
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/mincore.c

between commit:

  574823bfab82 ("Change mincore() to count "mapped" pages rather than "cach=
ed" pages")

from Linus' tree and commit:

  86ee23ad82b6 ("mm: fix race between swapoff and mincore")

from the akpm-current tree.

I fixed it up (the former removed the code modified by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/IgU6laMv6xfhT4VrJeoT8Ra
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwytmAACgkQAVBC80lX
0GysVgf+JzcYJQ9CEc5VC9M/QTL9a5C5y3Q7wkeshfYzFj/3ybJLRkL+4cM/Gl1Z
yGafNUEWL2WJkmYEx/Q+g4jPHHM0T4M/rlBafnJXwCHqsBYqGMNi+pWh+BYH1ILI
p0JnZ6GUHiJnIKPd0NwmhRuCMruZmlF0RfzwrQa7kVRou49WOCMuIouXZAx/vLxi
oA991CsB04TnWzunukLgVVEsvyo25Fv/8oQkf7M6mHg969Oy7nZDQnCok9a76RqQ
SFCD5ogf3Ckx1w/q2A3EWOGCUreDRPF+t/u4gIR+3R8BPQx5ywEDTkQs1GRw0qMA
jnaa06WkGySakwefcMQH9fpvBX0Ygw==
=9RDF
-----END PGP SIGNATURE-----

--Sig_/IgU6laMv6xfhT4VrJeoT8Ra--
