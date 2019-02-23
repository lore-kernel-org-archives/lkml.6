Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F015C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC01D205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TrOSSpob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfBWORT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:17:19 -0500
Received: from ozlabs.org ([203.11.71.1]:38499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBWORS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:17:18 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4469JX1yDsz9s71;
        Sun, 24 Feb 2019 01:17:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550931436;
        bh=dlQmNtzN3ifsoj+XFEZsIifWKEHp5zQvQ9vll7984HA=;
        h=Date:From:To:Cc:Subject:From;
        b=TrOSSpoba5JziNE2mga1khahpqaKhc6qX5GbvclXelVRCVm1O24R5mNj4da3qgcKT
         898kjwjZBmOeglrTOT7cTEzbKoCS4sRTZ5nMGOgfJ9gaYaSHCgvhfhnijsThEjhYaZ
         2NLsEYyc36eykWxSTRrNmNx1YPNw4AyVUt8vyWsx8Jh/KC8fyC7IdSWdjs6dMXy9tG
         zBTQZ0EfiVYHBa7PlxYGDHEf/sqJrzDKuyUZeuZV3i0+AzyaoO2Qc8Lldrnpz61xpY
         W9FEgBh6PY+tSScguPp9qxwvGvL0jPMSph3ff/zb69EmI7UDcFWBeiZZ2hUpX4iDEZ
         0QnOYJCMSNUTQ==
Date:   Sun, 24 Feb 2019 01:17:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the device-mapper tree
Message-ID: <20190224011714.0d72b6ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1jNdi.VcJAdx5+P6/1zIl/1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1jNdi.VcJAdx5+P6/1zIl/1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  eeee919c8a63 ("dm: always call blk_queue_split() in dm_process_bio()")

Fixes tag

  Fixes: 568c73a355e ("dm: update dm_process_bio() to split bio if in ->mak=
e_request_fn()")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/1jNdi.VcJAdx5+P6/1zIl/1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxxVeoACgkQAVBC80lX
0GyjcAf+LhRt827AX4Q9A+S8sxCNq2kgWch4Tqnv4TtWWUnVoHEPB06QdDsXoEn7
FUQ/MvFCZSJldaD689qJneGTNLL4UPLzf/8JRpOP/sFtdbEnkZgs3AMRZHE2cVG0
jpccyM4mv/sc3HxMWWoa/+bFk7fWAd+vrtUts0VhXeEKrwtfxSD6vBh3odZ9t86z
bfqMLZd4973jAh5fPYUq7yELQVZtupeklbLbQ6N6irBmnSdk5aU2p/xAQpdGVDm4
A+Z35UcLepCtLHXILyPfwG9E8AH/3+zq+yb+GyDY23CngOGJ2iXPzWW31be92Sjr
SailG8oLiUigMv/tSY++rAbGPDFsvw==
=eDnb
-----END PGP SIGNATURE-----

--Sig_/1jNdi.VcJAdx5+P6/1zIl/1--
