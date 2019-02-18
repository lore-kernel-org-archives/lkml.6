Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B10C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34CA218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pe/+4cm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfBRFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:10:41 -0500
Received: from ozlabs.org ([203.11.71.1]:58043 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBRFKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:10:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442sQ62Bcgz9s3l;
        Mon, 18 Feb 2019 16:10:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550466638;
        bh=qkO5R85w5LpgQJy5MM8088T7PFrwtPrAkvVKGj0/8yc=;
        h=Date:From:To:Cc:Subject:From;
        b=pe/+4cm50iyLRMPJ7CgU9TwjO2i/pw3+4qH9xsT8VKcKc/rtMNCWlO9ikblAryAy1
         G+1A+X7d9ePzjGNyOjBc269zm/3Ei9amXn1VDOJY1M2vBQtKzgSONtYpUVryEG97fw
         T+eBmvovExMIlgZnIE0brIPvucNOjUzqZaRJxB7BO7Y1QpsAxu+Ts7gfEGFF8OQukN
         ujOazfuymvZ8kdSjFGYNAZRH3URoedURdmlIxNVduZAXnLjja0ThSMrVyMuJd162i/
         OkR4XbzNBXAf9DfOVIG/yYWjMaSJyE2xEUhV6AoeLOPdlDbjcL70caFon4VHqMq3bd
         qRkIh8Bd3yqYw==
Date:   Mon, 18 Feb 2019 16:10:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: manual merge of the scsi tree with the block tree
Message-ID: <20190218161036.3ffad994@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DXxYkEiD7GxEtC1sgPOogGx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DXxYkEiD7GxEtC1sgPOogGx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got conflicts in:

  fs/exofs/ore.c
  fs/exofs/ore_raid.c

between commit:

  6dc4f100c175 ("block: allow bio_for_each_segment_all() to iterate over mu=
lti-page bvec")

from the block tree and commit:

  80f2121380ca ("scsi: fs: remove exofs")

from the scsi tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/DXxYkEiD7GxEtC1sgPOogGx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqPkwACgkQAVBC80lX
0GyESAf/Qy86EkO5htP6HwTYFDxCPoWEZRpsjj1i9IoKFohlnkDWBcOZ84zuhYn5
iqlexm8ey7RSpMW7/f6EWCUrUbs39XB41QeR001cy+eQi5YKPogSvttp+H1KHi1c
qbyLBVmUG98A0lqJeE+4/v/ZbY5znd1vV5VmWUJvLvZPBMwlHoHfuTIc4myzxEp+
grkEgG+E0j79J7dSsk58OhKs7Fn0GKFtTpWnFQ/+XMcgFMUV6qItqewPtaQjWQBb
kJvT+ZxAZkqBmq0QoOc2wsB8R0mv7r+5LPIrSKiG/1g/ykObO592+W7yws0hub7E
WWSROradj9tfI9Kk/9ZY1OwYnMBVdg==
=7RLM
-----END PGP SIGNATURE-----

--Sig_/DXxYkEiD7GxEtC1sgPOogGx--
