Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2085946-1528159110-2-6463862941960153292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528159110; b=DVx6WrLIUxruxXX7Pe1FgsM72xJhT2CfckgT2a1sEy4MOiplLy
    DpChDGA2E0SQ4qeFQLefbwCJj4Sau0481eAHWA3365YMCi83cVX08WCFlUgjOeVk
    t95z2/XVddYSWYYKZuqwem29IKnM6ZeodVe1G8buUY5enJvwSbzl42ooxZs5qiGH
    VTX9PoHXehasIK46QdRI4n9zWilvlCMI+MrQU4DvAnwcf7HXaUwvyPfv5B5L/Msl
    EUELlxg5plWdaiUnxJpos3ewjxRp48uHoMy822jC5FFexb+iH1OzZHy9+rUrUCFR
    J7xk9fCnp5kYKfvDXvSfcr6RMW7iNfo6msmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1528159110; bh=1cQEmOcgYTLmjIQaBZ3oZCZfImZlsb
    KalUX2hLcL1g4=; b=lelAgsbp/lLMZwvT7rYFqT5+pyjNQJxTSzIGvkPECEzYTF
    rKxZ99Sg6xv62knfY5E7iMSq/wgiBjjUJMAZuGScOfL7hrtrKuEKTk5op/tp75d2
    XQjHQS99NfHBMlUPNxDVhvtNEm12Iwk1/BECAEA6T371Kf7cqzVtrNGDgPxauNEx
    l4AveieeQtOBkbJOKALskXQeVwa1Jquq6fy3ToRBLUChWc0fHDO5oht7fYJVfNDB
    8dOhWPU9JBEg4KihJ8yg9eyXvPnjDmybo0BEUQ/OAuq137f8R+uVNyVOLP1VZVyB
    4qk0F1EOnOFYHIXr16A8EoJb5woadBZoAbXneW4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JKxw2BuB
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JKxw2BuB
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
X-CM-Envelope: MS4wfLCJLAna/mL0Y1ZXZS7iHV8RFvmBcpFvRiD1AZJJ7h17tERk6VYq5npxtTFvy1/74HRPHmnQ7BxjHJo1XxoTdNrk/+jnuZ+TjY4BoRkG1mAM+tfZ0KuB
    uycIOEkitRAR0RvfIXoWGMQeZrHZY57WsqFyg4VJsftaD9WGt7jXoGu91vUudxFpcn80/g2zPyw8PxMvOTH12d2bci5Vd3q0ocdeAK0qhSr4IFrleqnsxPhe
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=rOUgymgbAAAA:8
    a=FAkn2J9eVS5B31cF7FMA:9 a=tplR3yYt2Bv0kzpw:21 a=zX74AJovuEVF-hd7:21
    a=CjuIK1q_8ugA:10 a=YXD88XBxZz-rm-vAJ2kA:9 a=VwQbUJbxAAAA:8
    a=fT6DY2neKoG22zCxINUA:9 a=x8gzFH9gYPwA:10 a=MP9ZtiD8KjrkvI0BhSjB:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeFEAi1 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 20:38:27 -0400
Received: from ozlabs.org ([203.11.71.1]:33699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeFEAi0 (ORCPT <rfc822;linux-next@vger.kernel.org>);
        Mon, 4 Jun 2018 20:38:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 5 Jun 2018 10:38:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20180605103823.2ce02805@canb.auug.org.au>
In-Reply-To: <20180605103403.3e5b2c91@canb.auug.org.au>
References: <20180605103403.3e5b2c91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X4xRD2gfPK5/0=N=lZZ8RQa"; protocol="application/pgp-signature"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--Sig_/X4xRD2gfPK5/0=N=lZZ8RQa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 5 Jun 2018 10:34:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the xfs tree got a conflict in:
>=20
>   fs/gfs2/bmap.c
>=20
> between commit:
>=20
>   628e366df11c ("gfs2: Iomap cleanups and improvements")
>=20
> from Linus' tree and commit:
>=20
>   7ee66c03e40a ("iomap: move IOMAP_F_BOUNDARY to gfs2")
>=20
> from the xfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Forgot the diff :-(
--=20
Cheers,
Stephen Rothwell

diff --cc fs/gfs2/bmap.c
index a7b586e02693,8efa6297e19c..000000000000
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@@ -767,12 -680,13 +767,13 @@@ static void gfs2_stuffed_iomap(struct i
  		      sizeof(struct gfs2_dinode);
  	iomap->offset =3D 0;
  	iomap->length =3D i_size_read(inode);
- 	iomap->type =3D IOMAP_MAPPED;
- 	iomap->flags =3D IOMAP_F_DATA_INLINE;
+ 	iomap->type =3D IOMAP_INLINE;
  }
 =20
+ #define IOMAP_F_GFS2_BOUNDARY IOMAP_F_PRIVATE
+=20
  /**
 - * gfs2_iomap_begin - Map blocks from an inode to disk blocks
 + * gfs2_iomap_get - Map blocks from an inode to disk blocks
   * @inode: The inode
   * @pos: Starting position in bytes
   * @length: Length to map, in bytes
@@@ -838,20 -770,20 +839,20 @@@ static int gfs2_iomap_get(struct inode=20
  	if (*ptr =3D=3D 0)
  		goto do_alloc;
 =20
 -	iomap->type =3D IOMAP_MAPPED;
 -	iomap->addr =3D be64_to_cpu(*ptr) << inode->i_blkbits;
 +	bh =3D mp->mp_bh[ip->i_height - 1];
 +	len =3D gfs2_extent_length(bh->b_data, bh->b_size, ptr, len, &eob);
 =20
 -	bh =3D mp.mp_bh[ip->i_height - 1];
 -	len =3D gfs2_extent_length(bh->b_data, bh->b_size, ptr, lend - lblock, &=
eob);
 +	iomap->addr =3D be64_to_cpu(*ptr) << inode->i_blkbits;
 +	iomap->length =3D len << inode->i_blkbits;
 +	iomap->type =3D IOMAP_MAPPED;
 +	iomap->flags =3D IOMAP_F_MERGED;
  	if (eob)
- 		iomap->flags |=3D IOMAP_F_BOUNDARY;
+ 		iomap->flags |=3D IOMAP_F_GFS2_BOUNDARY;
 -	iomap->length =3D (u64)len << inode->i_blkbits;
 =20
 -out_release:
 -	release_metapath(&mp);
 -	bmap_unlock(ip, flags & IOMAP_WRITE);
  out:
 -	trace_gfs2_iomap_end(ip, iomap, ret);
 +	iomap->bdev =3D inode->i_sb->s_bdev;
 +unlock:
 +	up_read(&ip->i_rw_mutex);
  	return ret;
 =20
  do_alloc:

--Sig_/X4xRD2gfPK5/0=N=lZZ8RQa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsV238ACgkQAVBC80lX
0GyauwgAlVhiYB9DYApT38VM3the3KD3DvpIlv8BSa9hUCvNGWmb1AxyXVskmg55
n8gkLYVHifBor3kJ/8bJiN8ou6K1OxemowaKu6WX1vYvlt7gWIkoDHIGo7WCjbPP
N7+kxv4sNjevQqyJ2fld0NOgWKJ1uC1g6yMtKRnGwyWZUWSEbzdNlxkywIlZSCd7
oTVWXYtvVxsTM7FHX3uNpmH/JPmGn4NB0WUBb3IB0orDKT520SSjVXXatVfBQN36
MG9rsCXhHHrLQ38hcZ5+mJzyy6Q2ibKuNALKXOh1plGFXDVWcSBHtp2YaOZarlsN
rQQG6rllqhIDd7fEAZ6rbmWJVIYViA==
=Srn3
-----END PGP SIGNATURE-----

--Sig_/X4xRD2gfPK5/0=N=lZZ8RQa--
