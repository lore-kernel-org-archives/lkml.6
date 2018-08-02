Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E16C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3445E208A6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eBV05Bct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3445E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeHBCUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:20:05 -0400
Received: from ozlabs.org ([203.11.71.1]:51133 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeHBCUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:20:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41grhT1D78z9rxx;
        Thu,  2 Aug 2018 10:31:37 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533169898;
        bh=/rnTS2IxoRcskhSo/4x7j2JE54L9OyOLM3g2wJeG7vM=;
        h=Date:From:To:Cc:Subject:From;
        b=eBV05BctMqjA+j/PNT1QdvACxZmaf8+u9mpE1saOpDltQaRCuyZAi0+QqBN7XVmp6
         D1VBWuqMgJsDvvMmXMbT2LF2GxPBiZFvDjmSV2s+letaqx305qJec4cyE8vQMpot6m
         dDLK+J9UfCU8Z3a/NpKC4nlWYs8fvQPLh/8LxtGLebkjVnKGsygr61bPmTRrZHj+U4
         a/A1qKzu1mviMOYooTDjkAsWvG2RZYEE+LJzuNeijxG4hk7+w/AV0JaJpLENYKof8S
         V5mvnqzENDF+872UCh2fl+X/jiaXUsW6gOjGetUZQ5HybVNkltMMkTZc02ePV5+sw7
         5F1iHY1PFbkcA==
Date:   Thu, 2 Aug 2018 10:31:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, David Sterba <dsterba@suse.cz>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the btrfs-kdave tree
Message-ID: <20180802103135.2e620406@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vh.0A_YFaE02YjdQCvIbXix"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vh.0A_YFaE02YjdQCvIbXix
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got conflicts in:

  fs/btrfs/inode.c
  fs/btrfs/tree-log.c

Commits

  8e5d411c91c1 ("btrfs: simplify btrfs_iget()")
  cfac83868124 ("btrfs: lift make_bad_inode() into btrfs_iget()")
  efa119590db3 ("btrfs: IS_ERR(p) && PTR_ERR(p) =3D=3D n is a weird way to =
spell p =3D=3D ERR_PTR(n)")
  353dd669cc08 ("btrfs: btrfs_iget() never returns an is_bad_inode() inode.=
")

from the vfs tree are duplicated as commits

  5ee149473042 ("btrfs: simplify btrfs_iget")
  083a7dddaecc ("btrfs: lift make_bad_inode into btrfs_iget")
  8bca6b1de61e ("btrfs: simplify IS_ERR/PTR_ERR checks")
  7ffab8b69edc ("btrfs: btrfs_iget never returns an is_bad_inode inode")

in the btrfs-kdave tree :-( (except 5ee149473042 has an extra comment
and efa119590db3 has na extra space)

I fixed it up (the obvious way) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vh.0A_YFaE02YjdQCvIbXix
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiUOcACgkQAVBC80lX
0GwyFQf+P0LMf4GYJpGP0tDHwZW5k1HeDEsRzRr2umwyMHXCWytrGRVtd+6T1cvC
Mkj8BlxD26P59GErSZzLNEbumEoEbjko0r2Ev672suIA2lMWH4M96w1dTi0zYdr4
GEwcLQl73RaGhpjIpxQ5yaR0y2Y7i+53oTXISObM2W5AcSp1J2JlyM4OjfkYX+aP
9xzmiYyDfC4ag3MDl3Xj3xtLdDTsG0n5y0Mh5thLQlGXaoslxESh+FO7q75qijS3
lZKPMw6UDpSkxUYNQhRG9VTbhyRjbWUyRsUN7c4XehBurL+mj1g1Kl4abrIw9Oe7
Ncnnelgc5j3hyTgQrdkNzA5QjXz1EA==
=PnE8
-----END PGP SIGNATURE-----

--Sig_/vh.0A_YFaE02YjdQCvIbXix--
