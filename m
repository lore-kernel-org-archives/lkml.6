Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B048CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C782184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AstDRY2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfAWWxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:53:45 -0500
Received: from ozlabs.org ([203.11.71.1]:34405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfAWWxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:53:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lLDg4S16z9s3l;
        Thu, 24 Jan 2019 09:53:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548284020;
        bh=XiaXiK7fEXR9hi0xIIJnhntC//4z5yx8EPiVt5xZF/I=;
        h=Date:From:To:Cc:Subject:From;
        b=AstDRY2btpUrIQ+eYPPENu2Y5dKPm8h77I8vFZA8+MXouktaDAPF8p101fcUVMqIr
         yQUL9wrOylqq2UNCzf8yWUY1E179QQ59BH84uxc7BVjZ6EBsN+nSTLFjOFvQXSE7Mx
         Drf/jZcsnOdL2uvzz57DLNxtv5kM96WA2U7Wbif+kTD60QGJK6GFNi5z0pmwJgzKpk
         JxhZSJWx2lBooZ3us0VL7HRlYWESTODplUAL9GFj8QLhSG+EhRL2P6yzvi9tXsyAtD
         fX3zV6rPA0wflandFCgySyrfm1mbFH/3ooYtu9v3J4QWqW/Glp3euC2uVdYacZKkzR
         9KZ5SCKS/WzTA==
Date:   Thu, 24 Jan 2019 09:53:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20190124095338.523fc3a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+lP+2jeFj5G.UNcTA7vUQ2z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+lP+2jeFj5G.UNcTA7vUQ2z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

After merging the btrfs-kdave tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/btrfs/relocation.c: In function 'insert_dirty_subv':
fs/btrfs/relocation.c:2138:6: warning: unused variable 'root_objectid' [-Wu=
nused-variable]
  u64 root_objectid =3D root->root_key.objectid;
      ^~~~~~~~~~~~~

Introduced by commit

  7b837199c581 ("btrfs: relocation: Delay reloc tree deletion after merge_r=
eloc_roots()")

Presumably the ASSERT is compiled out in this configuration.

--=20
Cheers,
Stephen Rothwell

--Sig_/+lP+2jeFj5G.UNcTA7vUQ2z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxI8HIACgkQAVBC80lX
0GytqAf9EP4Z1WY2SQ9oF7osbfIWY1PH+C+C3Oe/dPor2lC9HXEUFtYSs3cNKMXv
FvChRWMplfLXUeu8qezW9xemZLQfX+pOnms7gM7RXSIXlVIMxJ84+0bKCSSIbxQs
nbe8U2LVE77jDq5ot8394xAGIA3Cc1SXKAyYHLqG3YhxXIQROrbMR37TQlS3nYOg
wJX2NQxkaNZRmn3FFDzIyqRMEciAgry/ZMKeJC1szQ0FCXyA5s6GgjxQ5jv53GsJ
3vK3ebrwv504+7SU/dTseRGunFjFjFSs1YH8Krw7cWdDw3dBQuPdZfsZX5xKRgYi
6e7r5jGhlOjqL3QAjr0LwBtKu0IEgw==
=phOG
-----END PGP SIGNATURE-----

--Sig_/+lP+2jeFj5G.UNcTA7vUQ2z--
