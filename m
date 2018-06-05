Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2079613-1528157987-2-7708270905591384612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528157986; b=dRm+VpIaohxExLfxf9zic2lnO5P4ST8wzp/XwvGoAkeIV+J/DU
    65fz60hZHakj/pihG4UCKzRk9Xg6kfjrDGGULasL1+1sm2ZX9T2h7/MKM5AN/In9
    DQZZZ9avDfQe72B544F7EoCkBIko+RksGc9LLW7lxYt6oepjP5XGe7VqvzXSuSCI
    ilk37kAy6Q6aalbIGzFAHPoRq3R77foA0scmMwKZghMxMKXWshr2qQBeY1BvbGfm
    iy4Mhk3liGkTTj69uaCIveHBU0ReVkph/uzamYLZl8tlqHTH8H+JoYyewHPO+r6/
    W0PKOn23FK/lY856E6MgF0Obb0qqodrhMPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1528157986; bh=j0D1bCnjpkg+QgvzbBG/N9dbbAkbgu
    MR8GncLx/lgRU=; b=dTEld2O8tlY0Y9Nsy76VI3aAECvZ7LYImwEeK0/b4Jgd/o
    yDyPBNClEZ1/jMZsuHI5kGpaIQJUwFi84KCzqQfAy119j8kd9V/raqa9HhixLU40
    iVQdGFeq5NQknLpktKd/YSCYtMD+KpQc3UxmtvnDhZy9Scv0N24L2HsgKe9DxPpK
    fQHIImv1n0yXva/+HXLczSASo+CX/HTv+2Wg4IJNp8D2P/8lG5cqpy15SNjBy5hb
    RCjBlFL5hxwEY3ufKpDkce+4sa4a1izNRiaft6FNwiqUZpj7Vz7NFWyIcwtkD5FA
    VjEhD/hrt0z/vdz7PITjPr82604GQAJ3F684qqDQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DMS8bTnK
    header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canb.auug.org.au header.result=pass
    header_org.domain=auug.org.au header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DMS8bTnK
      header.a=rsa-sha256 header.s=201702 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canb.auug.org.au header.result=pass
      header_org.domain=auug.org.au header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPFWXfFLahYZWHHzdM/D6BxJ/6CtCP5+JBLGm7l24dCp4XQEAmbG2Uuc3mvRm/1xiIzr2E5KLXJwTi4Myd9UcwUa7foZSntqg0sRi+BR8Lc7147eIwOX
    4qcXJ2v41rLTN22NigDpoQpxSGd2WE5t8JbCxOxXhkFR2gKnon97bYDnJ4dub1jxjjotlYLF/pjmA5/IisnKuibGxaCfnknv4bdoE5+E8lDo51g+Gw6IJTKq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=rOUgymgbAAAA:8
    a=W0t7Dq30BlKT5lTIRbAA:9 a=CjuIK1q_8ugA:10 a=yRzyimSbCoga3zRK9tQA:9
    a=VwQbUJbxAAAA:8 a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10
    a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeFEATp (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 20:19:45 -0400
Received: from ozlabs.org ([203.11.71.1]:56453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFEATo (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 20:19:44 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 10:19:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs
 tree
Message-ID: <20180605101938.2788323e@canb.auug.org.au>
In-Reply-To: <20180529113025.0eb4b16d@canb.auug.org.au>
References: <20180529113025.0eb4b16d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3PDq.+gSfu/fyHtx.zi9dBt"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/3PDq.+gSfu/fyHtx.zi9dBt
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

--Sig_/3PDq.+gSfu/fyHtx.zi9dBt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsV1xoACgkQAVBC80lX
0GzHeAgAodf/NkFmeHgIU2udwIQxOFWOZ7n9weDPFX2+74ecLImVFfBz+LlDlrFm
ybxTNT6X0pBLU7NnX21nShZvSzmRmR8KDUY00X2SwQbjaI/WVFGH6mBUc2Ln/oOV
1bEt/W2/k/E7hzv4h3AGjUGZ9MNFXt15PLrl88+SJ0rQOXz5ybttkNqC/u/zOhH4
CUdfvukFyosvFH56syVpy0D9EI9SGylxGDnjqckM/7oHpjMo1brhsFWZFiBrHiJv
pldvnHE3+F91GxxIRaSgBBHHyI0dIS42gl6rtyHV9y4gv6k49BTR2Pfmd5rB8Ofi
ESRgkxqBODgdb7ZAhaxiFdKgtN4r2g==
=JAQ1
-----END PGP SIGNATURE-----

--Sig_/3PDq.+gSfu/fyHtx.zi9dBt--
