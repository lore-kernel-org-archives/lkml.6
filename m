Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B365AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E20D20851
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eiDx/9K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E20D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeK1KKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:10:20 -0500
Received: from ozlabs.org ([203.11.71.1]:60921 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1KKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:10:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 434KJn3wf7z9s29;
        Wed, 28 Nov 2018 10:10:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543360250;
        bh=LsV7gXOxmTTkA156TUtDznRtZ6l5G5hDZNZpUGmIrsk=;
        h=Date:From:To:Cc:Subject:From;
        b=eiDx/9K5ei1BYzBiJR8fqjTwC3aWLqNdbzqXepZOVFxrpb4+hhnn3xDP+KYqAAp37
         t8O1Pe+xc8XF/ColGP9xQYYsUyG7HEwC/FuJ6cR3UzFAaAH/WIOt7AE16Kuzegl3YP
         epd6tNX1BeNfFM5ZJ6oAvt85b2IQv5IoJc0tR1zdWtQ+ZAYUPGJS9yOZnc9BkFXuC6
         L54WWQH0dkzJmy4/bT3ZKFRCvAz/80GoMHBadPGoYC5Gh4JjhtTqPFAGz5CJhNStBJ
         qBCoB28QrbxcOlzoWH0a59HcGXiIKroIoQjkrjkh/GHkOYK4cNl0WsXyPd5qgFKExQ
         twnx7EUKK9soA==
Date:   Wed, 28 Nov 2018 10:10:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20181128101048.01864df2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kwbht/nHU92K0rlCuHV/fVQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kwbht/nHU92K0rlCuHV/fVQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/Makefile

between commit:

  d44170a7ba48 ("fs: common implementation of file type")

from the ext3 tree and commits:

  229e55402816 ("vfs: Add configuration parser helpers")
  37744f3d21f8 ("vfs: Implement a filesystem superblock creation/configurat=
ion context")
  1d9c8fafbf6f ("vfs: syscall: Add fsopen() to prepare for superblock creat=
ion")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/Makefile
index 23fcd8c164a3,e3ea8093b178..000000000000
--- a/fs/Makefile
+++ b/fs/Makefile
@@@ -13,7 -13,7 +13,8 @@@ obj-y :=3D	open.o read_write.o file_table
  		seq_file.o xattr.o libfs.o fs-writeback.o \
  		pnode.o splice.o sync.o utimes.o d_path.o \
  		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 -		fs_context.o fs_parser.o fsopen.o
++		fs_context.o fs_parser.o fsopen.o \
 +		fs_types.o
 =20
  ifeq ($(CONFIG_BLOCK),y)
  obj-y +=3D	buffer.o block_dev.o direct-io.o mpage.o

--Sig_/kwbht/nHU92K0rlCuHV/fVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv9zvgACgkQAVBC80lX
0Gw2Agf/T0+1ogTrw7dBOrcSIyGa0MiqQLltpGlf5ztY2z0229pvG8t6HIIrMB7o
EVwBg9wHOmYylZqjm8TwQPJ2FLyDMmXhQzzzXbMUmjI1SjrbDnFXR0wbCqmI6/YV
Us0Opbyq8peWMvSpBZbtSCNUKqNvIfaY8SE2ZaS1BDkFp8kxut03D0A3T4eNSvO1
R4VqBu62QGzGzOtV6IKoaSXeL49DlcG5X2M54Fl0+BoRoLgwuUwKsBFEYftNexoH
p2ccgrcMNFSksK51c0GmX8hj0OtwV+H7ariGH0amAiIn97zoBiJTF9LfwH0rhMMc
UtgMORcod37QYCPzLdgt42+QpavZIg==
=IXae
-----END PGP SIGNATURE-----

--Sig_/kwbht/nHU92K0rlCuHV/fVQ--
