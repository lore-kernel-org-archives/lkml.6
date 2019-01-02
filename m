Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1255C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B4208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KEMCKpa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfABA0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:26:22 -0500
Received: from ozlabs.org ([203.11.71.1]:36697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfABA0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:26:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43TsKk5m4Gz9s4s;
        Wed,  2 Jan 2019 11:26:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546388779;
        bh=gk6JosYufo9mggqSHtiEZlXpwt8dJYGgvwHhlnJmcTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KEMCKpa1xzksKVBsaIWSmgLEmgFOzidoW1JV/YKg9r1pBTZSAHYlwHboaZDBOHOU1
         dsYtFAaYNOVYQqlkfAmrA7NiiYI5L0UYL5FyN8N1v6K01xQvZyewXySVR7DSWylsbu
         bta6vSHk7hP+wzZUm/j1Ufu5daFc/fR+SE/Gu3ig55SPkWtBEtBmyfc22FxBDPh5JV
         ESQIav+ZKhR7AkSSuus/kxHLEgiMHBAePqK6GP/40xOYpADjHkZvxGlyQAiI2Vu+Yy
         D9ktI++1xTORfhqK5BujY2MQjj+tCRLaN3nfNXPYtRrIdFWS3+Em8FMWGRfm5+T/te
         hNYdl4sdJ508w==
Date:   Wed, 2 Jan 2019 11:26:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the f2fs tree with the fscrypt tree
Message-ID: <20190102112610.3bc5fb97@canb.auug.org.au>
In-Reply-To: <20181211101322.438946fe@canb.auug.org.au>
References: <20181211101322.438946fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oSPUQt/zVrd5X9qD0buRkfQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oSPUQt/zVrd5X9qD0buRkfQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Dec 2018 10:13:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the f2fs tree got a conflict in:
>=20
>   fs/f2fs/dir.c
>=20
> between commit:
>=20
>   848a010287e6 ("f2fs: use IS_ENCRYPTED() to check encryption status")
>=20
> from the fscrypt tree and commit:
>=20
>   4e240d1bab1e ("f2fs: check memory boundary by insane namelen")
>=20
> from the f2fs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/f2fs/dir.c
> index cf9e2564388d,c0c845da12fa..000000000000
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@@ -808,7 -808,18 +808,18 @@@ int f2fs_fill_dentries(struct dir_conte
>   		de_name.name =3D d->filename[bit_pos];
>   		de_name.len =3D le16_to_cpu(de->name_len);
>  =20
> + 		/* check memory boundary before moving forward */
> + 		bit_pos +=3D GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> + 		if (unlikely(bit_pos > d->max)) {
> + 			f2fs_msg(sbi->sb, KERN_WARNING,
> + 				"%s: corrupted namelen=3D%d, run fsck to fix.",
> + 				__func__, le16_to_cpu(de->name_len));
> + 			set_sbi_flag(sbi, SBI_NEED_FSCK);
> + 			err =3D -EINVAL;
> + 			goto out;
> + 		}
> +=20
>  -		if (f2fs_encrypted_inode(d->inode)) {
>  +		if (IS_ENCRYPTED(d->inode)) {
>   			int save_len =3D fstr->len;
>  =20
>   			err =3D fscrypt_fname_disk_to_usr(d->inode,

This is now a conflict between the fscrypt tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oSPUQt/zVrd5X9qD0buRkfQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsBSIACgkQAVBC80lX
0GyzVwf+LbzKgJ/S30mYe9TrC/Jlp3kD3VDfsUFtXLaK1WOs1mDfkDuU7bQDmPr8
F/l6TFyuA9OKkSZpu/bYBuwwE/5Q+FdoFnT1yvTOUbh/XBL9RXKPyPrkab8jikna
eP5VHiphKCgUsrbQFYAHv6HxGPc1S/P/g78neJ1zCBSN0qGPpNFdbzmygmL602t2
YRUdDvXRcZGIuZkzsHbO6uEW3QrPIw2FAV+4iAq8ZLksWBDEJPlHljE9hwgU/0vK
2juzugF5+P0n4YjmukNCFClH2H4h6TNEQDzAVm8aZ1UjoXTBcIzE1vQ3DDeafyHF
rV+runCJJvBAn2jknx5T/NO/g/XLnw==
=N6wc
-----END PGP SIGNATURE-----

--Sig_/oSPUQt/zVrd5X9qD0buRkfQ--
