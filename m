Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6100C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962C0208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JebwrLp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962C0208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeFRDmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:42:18 -0400
Received: from ozlabs.org ([203.11.71.1]:60633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754562AbeFRDmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:42:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418H3C2QhHz9s31;
        Mon, 18 Jun 2018 13:42:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293335;
        bh=klB4cP5M8LjGGsazrWZu6MYtevy6l8XVpt3MhcO0Bm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JebwrLp0VIGd6snHIh8wtOAQRS5jpPEOil1hr69tw/4C+XZtmn/g+BJT5hQaOIw/R
         sM/FrQNMWcZppPr1Yu6TLDUihHCiI6+E9gubd7jAbhV4oNnDX40MExNVhXtJMMelmg
         nofC1eNs7mziKVWnqKXbkXPtxLQDNYJdfLej7Ou3BL7H49KzMO7eor2qTAnU7t0qTM
         50aPX9V4GlRvS7iSE4eN3i4C47cBLE0EzR5j5LugiY6t1IrqiISP+sIUxRHeB7wrmy
         bnulIMzWxJLPkkZDONnZzD0H66rZbW4Vz56Vnzhp2wfuLR+hJZOjvqq7TfcKIcT4LV
         mqETsA3p8Q2zQ==
Date:   Mon, 18 Jun 2018 13:42:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Sterba <dsterba@suse.cz>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>
Subject: Re: linux-next: manual merge of the overlayfs tree with the
 btrfs-kdave tree
Message-ID: <20180618134212.31202019@canb.auug.org.au>
In-Reply-To: <20180529095250.097524cf@canb.auug.org.au>
References: <20180529095250.097524cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+y3zg5iDTuMYT_4tlQ.0zby"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+y3zg5iDTuMYT_4tlQ.0zby
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 29 May 2018 09:52:50 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the overlayfs tree got a conflict in:
>=20
>   fs/btrfs/ioctl.c
>=20
> between commit:
>=20
>   0b4dc087e29a ("Btrfs: dedupe_file_range ioctl: remove 16MiB restriction=
")
>=20
> from the btrfs-kdave tree and commits:
>=20
>   83d499febfac ("vfs: dedpue: return loff_t")
>   7765f19ed5f9 ("vfs: dedupe: rationalize args")
>=20
> from the overlayfs tree.
>=20
> [I note the typo in the subject of commit 83d499febfac]
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
> diff --cc fs/btrfs/ioctl.c
> index 4d88d54d042d,70eac76804df..000000000000
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@@ -3637,14 -3192,20 +3637,15 @@@ out_free
>   	return ret;
>   }
>  =20
> - ssize_t btrfs_dedupe_file_range(struct file *src_file, u64 loff, u64 ol=
en,
> - 				struct file *dst_file, u64 dst_loff)
>  -#define BTRFS_MAX_DEDUPE_LEN	SZ_16M
>  -
> + loff_t btrfs_dedupe_file_range(struct file *src_file, loff_t loff,
> + 			       struct file *dst_file, loff_t dst_loff,
> + 			       loff_t olen)
>   {
>   	struct inode *src =3D file_inode(src_file);
>   	struct inode *dst =3D file_inode(dst_file);
>   	u64 bs =3D BTRFS_I(src)->root->fs_info->sb->s_blocksize;
> - 	ssize_t res;
> + 	int res;
>  =20
>  -	if (olen > BTRFS_MAX_DEDUPE_LEN)
>  -		olen =3D BTRFS_MAX_DEDUPE_LEN;
>  -
>   	if (WARN_ON_ONCE(bs < PAGE_SIZE)) {
>   		/*
>   		 * Btrfs does not support blocksize < page_size. As a

This is now a conflict between the overlayfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+y3zg5iDTuMYT_4tlQ.0zby
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnKhQACgkQAVBC80lX
0GzjpQgAlnXCgTzLvn2p4t+OUemvsWHNu2szRIK6C57nDkna1EgO3wW56bHpAkSq
CUiWkksQ4WjaZp2hg+9TBXIvPi6fJzqonfeU64KB9G1HB9V22OBD/fxQEeLpmSA7
2z9RPde5j5K1h40SvEHJvjh1etZAu+wFd+x5aoj+411XA5MwdjbzNbBvbNsekclf
ls44IZG8/jbGdE4bT9BDRqNZpLy5o4G3bnSwqUanYVuws+RqMq3tyMT/SwD9hPpr
26Drv7Hyl4jXZU39AU2SibC6Uq31HYbG1+F1bPF4mIjvO/zxkFkVGk2kmEqc/bCF
yYV3Uwb46bHNYc1tX9ETVm/AQXdR3A==
=2uQS
-----END PGP SIGNATURE-----

--Sig_/+y3zg5iDTuMYT_4tlQ.0zby--
