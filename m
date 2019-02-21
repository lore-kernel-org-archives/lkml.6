Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168BD20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qL8MUzsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfBUUkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:40:04 -0500
Received: from ozlabs.org ([203.11.71.1]:59531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:40:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4455v60NrHz9s5c;
        Fri, 22 Feb 2019 07:40:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550781602;
        bh=pHqYZuo2PfFe5Wn3eDgfpJQ1HgVp0vDwrKYAM58cxYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=qL8MUzsWmwjuqxSMNhRy4kulUu8vpJVkyI4kA9/jdKzEHN8XZ8f+X8l/p1+MxozjW
         +sf5JEvKiA5pX3iNVziEB4Uubhsd/XRdhz97cjuZPEbFErsybUYIr/1VJ/hDEcUh6u
         JvCGyHLzH6JSa1j4YUWJDHtrQRoMznpnHLiP3vg9WtYoIvsc7j2PETOoPQ6d9caqNV
         VV/nvLNzSSIV+gvo60lJhkf66TKim6H243VyMcjz2A8T799GXArQuGMyc7pZFUISXT
         n/p6jqwgCpvE1XR6scstXnHG+v9QVUN5rfLapt8xatHmTqbviXQLAzkL5m9ghii6tp
         py2VmohjI4EKA==
Date:   Fri, 22 Feb 2019 07:39:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20190222073959.5accc9a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/d2IDwTjbDbdXOzL0VNZTwgb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d2IDwTjbDbdXOzL0VNZTwgb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

In commit

  8f4e80da764e ("block: bounce: make sure that bvec table is updated")

Fixes tag

  Fixes: 6dc4f100c ("block: allow bio_for_each_segment_all() to iterate ove=
r multi-page bvec")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/d2IDwTjbDbdXOzL0VNZTwgb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvDKAACgkQAVBC80lX
0GwEdgf+NQ9BrCjeYBU4miFrZTJgDOuQCie968O6KG+9/5yEZYexZBMXA6LUC+fo
YQACAW44XgiDIuiWYDVmI0LZGsgaKeuUsxGThub0s+dn5pYiiy50EG2JMK82+jte
0vDZSvALvVTQdznhEu9YatEKySwYOCOeNSSPxqVRIJIKgcRWd+MmXPxrbiYRstK6
jzZxJyMZgekHBXi7n9mLTVZ8WiUeWVM19qhQx6Pv+9GX5FiIvXXB4pAyqFWApvP3
37YUY0QWHZGTbPdf38fAhF+DGbmBqTlRK6ivP3JLy0jHXZvd+wnNzGbi4eWJ/+hC
W5Ml5kHQUQdqQxVH5nYogpTv8pFQbw==
=xxJa
-----END PGP SIGNATURE-----

--Sig_/d2IDwTjbDbdXOzL0VNZTwgb--
