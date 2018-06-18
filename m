Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11CAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FAA208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IykAXMa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FAA208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeFRDn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:43:29 -0400
Received: from ozlabs.org ([203.11.71.1]:54271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754562AbeFRDn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:43:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418H4Y2SS6z9s31;
        Mon, 18 Jun 2018 13:43:25 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293405;
        bh=YGHYZcyhNOAZdDITFyQHLmmP3AapJOJZgXpHftSe2yU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IykAXMa45p/zlmjJ8WioAfEUAiAK1TGFe2hBOOrrdwtbVqj1t3Mc9ybPOJHC3e/ao
         uO0zx6nPdtlrE2YTl0zmYj7uVH2ssygVy4cMoWXAN7Sft8JwiyGbE4A+E6rwki5Hyk
         lUzJNYOeGHT9anl7DUDFvt1ojUtiQZyNgciXCcKpgeCPaVYH2LmZSGLrmmauxLGNgj
         4mDqiFuheV50mL2hswGLLP7rA/b33YKAPMv2TZQLzlrOV4lUwzHX4n0th2jMjmjaVP
         5ETuJ60xheIDjd95sFb2eCM3bn7JnMuyMjm2koQvdb9LH5OB+nAaER0Aro2tk7/1uG
         LjFWxdk0tWj+A==
Date:   Mon, 18 Jun 2018 13:43:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs
 tree
Message-ID: <20180618134324.3f2e873b@canb.auug.org.au>
In-Reply-To: <20180529113025.0eb4b16d@canb.auug.org.au>
References: <20180529113025.0eb4b16d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DRzaTX_t4b7d+3qy7uCiQH="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DRzaTX_t4b7d+3qy7uCiQH=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 29 May 2018 11:30:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
>=20
>   fs/read_write.c
>=20
> between commit:
>=20
>   63ea46a359b2 ("vfs: dedupe: extract helper for a single dedup")
>=20
> from the overlayfs tree and commit:
>=20
>   227627114799 ("fs: avoid fdput() after failed fdget() in vfs_dedupe_fil=
e_range()")
>=20
> from the vfs tree.
>=20
> I can't see how to easily fix up this conflict, so I effectively dropped
> the vfs tree change.
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
> diff --cc fs/read_write.c
> index 4d61375a0de4,e83bd9744b5d..000000000000
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@@ -2055,21 -2021,46 +2055,20 @@@ int vfs_dedupe_file_range(struct file *
>  =20
>   		if (info->reserved) {
>   			info->status =3D -EINVAL;
>  -		} else if (!(is_admin || (dst_file->f_mode & FMODE_WRITE))) {
>  -			info->status =3D -EINVAL;
>  -		} else if (file->f_path.mnt !=3D dst_file->f_path.mnt) {
>  -			info->status =3D -EXDEV;
>  -		} else if (S_ISDIR(dst->i_mode)) {
>  -			info->status =3D -EISDIR;
>  -		} else if (dst_file->f_op->dedupe_file_range =3D=3D NULL) {
>  -			info->status =3D -EINVAL;
>  -		} else {
>  -			deduped =3D dst_file->f_op->dedupe_file_range(file, off,
>  -							len, dst_file,
>  -							info->dest_offset);
>  -			if (deduped =3D=3D -EBADE)
>  -				info->status =3D FILE_DEDUPE_RANGE_DIFFERS;
>  -			else if (deduped < 0)
>  -				info->status =3D deduped;
>  -			else
>  -				info->bytes_deduped +=3D deduped;
>  +			goto next_loop;
>   		}
>  =20
>  -next_file:
>  -		mnt_drop_write_file(dst_file);
>  -next_fdput:
>  -		fdput(dst_fd);
>  +		deduped =3D vfs_dedupe_file_range_one(file, off, dst_file,
>  +						    info->dest_offset, len);
>  +		if (deduped =3D=3D -EBADE)
>  +			info->status =3D FILE_DEDUPE_RANGE_DIFFERS;
>  +		else if (deduped < 0)
>  +			info->status =3D deduped;
>  +		else
>  +			info->bytes_deduped +=3D deduped;
>  +
>   next_loop:
>  +		fdput(dst_fd);
> -=20
>   		if (fatal_signal_pending(current))
>   			goto out;
>   	}

This is now a conflict between the overlayfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/DRzaTX_t4b7d+3qy7uCiQH=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnKlwACgkQAVBC80lX
0GzuZwf/SeEnMFb51TX7DxRzxbH8mf3PSZR94Vch2nG+ol9VIwy1T33m4Ko0BfBh
IYeiPdK9eoZRdNpgUD4Un35AQwEAX+BScGEBS8zib9nN1mRAPNXmTts3j7yd7kRb
mxUGOwM0oJ1jDAbm0iMTLIpn08aDifXKRFpXu3i6WCLQLiFcaR6InSVzgjt0DQDe
+cYe5LD2rW83/RLO9efZ/kw5bHq68cWZnMkcqjEkEXlewZeH9zmRUnvGvxE7XD6J
zNKawN1RGNAdXX34L7aRf5rKsKRDo0R0YZq2kLVOOJncAaBYp1AdDDFB7IjEsO8s
+sefde6mDBQwxsOORYPYOleP3Dq8qg==
=BeOC
-----END PGP SIGNATURE-----

--Sig_/DRzaTX_t4b7d+3qy7uCiQH=--
