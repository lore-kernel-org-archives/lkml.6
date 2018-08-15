Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE8DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCFA21470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BryGH6fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCFA21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbeHPChZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:37:25 -0400
Received: from ozlabs.org ([203.11.71.1]:47097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbeHPChY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:37:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rQxq0p6dz9ryn;
        Thu, 16 Aug 2018 09:42:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534376575;
        bh=xZPQddJ3TnC0K97c2p59BgnSsKf0Z4GPCwAB5++LlMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BryGH6fStLVg+1SMKcZ1eaNfXpsBqg35nGunmjf7hCERJtXcFSEQWqvNePLgAs4hF
         RH4gM/cgqPtnY9nBJ+lYhhhGdbcXlaUm3TjtCbl6EbHC2FbHTTUejeyyVdtqmqqegT
         8C4LDeYA8dHVZJ+S1egRlTu9jHmd5OWn0jYqlg+caOgvEsScyhzFd0TnRk4KNWkifa
         5pCpi9o9+vHPEb3gJdG5pFPBlERPwKGRpbNqa5j0w0p8NhY4L99vKyEGq4xnBteOSb
         F3/SGkV3AEU4uLFqkDYXOiMQwvgFEz8N21GM0zC/0WLRQacSLq8iPmn1QPw8+oc0EB
         Lrwovk4xsl+wg==
Date:   Thu, 16 Aug 2018 09:42:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 net-next tree
Message-ID: <20180816094254.6e0bd68c@canb.auug.org.au>
In-Reply-To: <20180723062046.GA2577@kroah.com>
References: <20180723151224.69a73892@canb.auug.org.au>
        <20180723062046.GA2577@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bh9Se7w29RaC.i6IXyvTQXF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bh9Se7w29RaC.i6IXyvTQXF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 Jul 2018 08:20:46 +0200 Greg KH <greg@kroah.com> wrote:
>
> On Mon, Jul 23, 2018 at 03:12:24PM +1000, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the driver-core tree got a conflict in:
> >=20
> >   fs/sysfs/group.c
> >=20
> > between commit:
> >=20
> >   5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to ar=
bitrary users")
> >=20
> > from the net-next tree and commit:
> >=20
> >   c855cf2759d2 ("sysfs: Fix internal_create_group() for named group upd=
ates")
> >=20
> > from the driver-core tree.
> >=20
> > I fixed it up (I think - see below) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc fs/sysfs/group.c
> > index c7a716c4acc9,38240410f831..000000000000
> > --- a/fs/sysfs/group.c
> > +++ b/fs/sysfs/group.c
> > @@@ -122,15 -118,23 +122,24 @@@ static int internal_create_group(struc
> >   			kobj->name, grp->name ?: "");
> >   		return -EINVAL;
> >   	}
> >  +	kobject_get_ownership(kobj, &uid, &gid);
> >   	if (grp->name) {
> > - 		kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > - 					  S_IRWXU | S_IRUGO | S_IXUGO,
> > - 					  uid, gid, kobj, NULL);
> > - 		if (IS_ERR(kn)) {
> > - 			if (PTR_ERR(kn) =3D=3D -EEXIST)
> > - 				sysfs_warn_dup(kobj->sd, grp->name);
> > - 			return PTR_ERR(kn);
> > + 		if (update) {
> > + 			kn =3D kernfs_find_and_get(kobj->sd, grp->name);
> > + 			if (!kn) {
> > + 				pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > + 					kobj->name, grp->name);
> > + 				return -EINVAL;
> > + 			}
> > + 		} else {
> >  -			kn =3D kernfs_create_dir(kobj->sd, grp->name,
> >  -					       S_IRWXU | S_IRUGO | S_IXUGO,
> >  -					       kobj);
> > ++			kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > ++						  S_IRWXU | S_IRUGO | S_IXUGO,
> > ++						  uid, gid, kobj, NULL);
> > + 			if (IS_ERR(kn)) {
> > + 				if (PTR_ERR(kn) =3D=3D -EEXIST)
> > + 					sysfs_warn_dup(kobj->sd, grp->name);
> > + 				return PTR_ERR(kn);
> > + 			}
> >   		}
> >   	} else
> >   		kn =3D kobj->sd; =20
>=20
>=20
> I think this is correct.  Rajat, can you verify it please?

This is now a conflict between Linus' tree and the driver-core tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/bh9Se7w29RaC.i6IXyvTQXF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0un4ACgkQAVBC80lX
0GyHMgf/a2VZOQWc1+FZ6tJHxodPJcLTFq3WaG66u4m+NUQScbi70y6AcxiGfFs2
2PWaVGWrnAbkNv8eX/ZVygPJG7OwKKj6aZuf9EkM7poW1Kod3PHt+ouju2CbSUbA
bjvQu0+J7nSppnOF/qcp48Ywnhywy6/Y0IFss9PuOdP2l+TfE28+FzYaputLY9UL
0IPREiCY7dUrL5tfWpCI40M0n51oTM0/6JmWWSo4uEOFoBJZLV1hEzV29DpQPi+0
IMPBehBI3CLwWYyQ90b/7KLFA3e7Z0nxusmVne+tIm009VwtK1btBPRpjhjO5evY
yL/jFPoDFQnxP3DhDRSATeyK8muRKg==
=sRWr
-----END PGP SIGNATURE-----

--Sig_/bh9Se7w29RaC.i6IXyvTQXF--
