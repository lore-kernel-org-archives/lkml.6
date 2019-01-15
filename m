Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB795C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6745620859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rvK7oCaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfAOVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:02:55 -0500
Received: from ozlabs.org ([203.11.71.1]:55783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbfAOVCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:02:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43fN8W6ypxz9sDT;
        Wed, 16 Jan 2019 08:02:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547586172;
        bh=Miotuzu+2rYYrASxJnN4X0l3EOccBZzzadSlyGDZw50=;
        h=Date:From:To:Cc:Subject:From;
        b=rvK7oCaIcQXDkeZO7aCfTX96GS4Hmyu+ApzFNlfaX01SJhJKElL6JRhnyCUS1knsQ
         d9R9ByIqn8vGUUGkpVubAp8heV5h1HcLSX12F1dArukF6R9c2PXorMpzJq+0MsnRse
         OAMfGrqdV8Q2kHg/q/Eb5G6ebI8aXCmhjNKqg77WL/6CO5JcQABnA0xedHjO865TdH
         bhavK59MKNa4pFLrlzQ8raonjmL5uQuwXf/29/WkpaSiUj8hZ6uMCQF/izq5Kq3mOB
         SBmXvDs+LHKRVuviJj5tL6VG8NZXAcpT5PkhmbTDn0MOfwOm7fe8dS6/9PP8jnBx4m
         LvW/MK0Wz5hJw==
Date:   Wed, 16 Jan 2019 08:02:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Joe Thornber <ejt@redhat.com>
Subject: linux-next: Fixes tag needs work in the device-mapper tree
Message-ID: <20190116080251.17ba9771@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sn9ifLak1VTNRq8BPCH/Gzg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sn9ifLak1VTNRq8BPCH/Gzg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

[I am experimenting with checking the Fixes tags in commits in linux-next.
Please let me know if you think I am being too strict.]

Hi all,

Commit

  fc4d02aa0331 ("dm thin: fix passdown_double_checking_shared_status()")

has a malformed Fixes tag:

  Fixes: 00a0ea33b49 ("dm thin: do not queue freed thin mapping for next st=
age processing")

It should show at least 12 digits of the SHA1.

--=20
Cheers,
Stephen Rothwell

--Sig_/sn9ifLak1VTNRq8BPCH/Gzg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw+SnsACgkQAVBC80lX
0Gzhngf+PIayDhdeOyHBaz8uQS+ropz3F12wSk7JJrfzG++9DVSaKi62A7Gch7Rw
/EWGgW/Fg/i7FFymiQfC/pzlNGcL8dj8kmQN5ITfygHBztO+HbifblDPjnq1mP3O
w7yxHgFWrbVskfW+Q3BsyMH5KCuUfxmKKsgpR5Yw+64kthggYjjc1P43RZAh1RZF
YBfX4EMmix1LGiAR4/I7SMjMOyY2rDtIT0nPNhHEDd3mZq5RjqP5bFB88VHeqAmA
Mk6rIXprVLsR72X10abQne4ZDRae14JoLirokAPss/+swgOEUAHT9JRe3YAlkwep
SEWFwHOFvU4hccN0XUN4sbi1LpjN+w==
=5Utl
-----END PGP SIGNATURE-----

--Sig_/sn9ifLak1VTNRq8BPCH/Gzg--
