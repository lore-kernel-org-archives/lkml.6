Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140D5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SbGY6Xxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbeGWGLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:11:51 -0400
Received: from ozlabs.org ([203.11.71.1]:50511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbeGWGLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:11:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YqP45wtVz9s2g;
        Mon, 23 Jul 2018 15:12:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532322745;
        bh=uEy685YQ3HSm4JjhPS9fLwAkPjoJLSDVwLiPEnfrtRc=;
        h=Date:From:To:Cc:Subject:From;
        b=SbGY6XxdfMqwq8hmLrT/PsccAwgFEl9wCi0gN80k7kthU7bpcu4lFC9qja49cuHtE
         lGBT+rCwGHGVkGoG5Ey3nlqmR7VaGUVBnJathA0WzGoZkKLV+xHtTygz0hCOSO1gKg
         M5VcHJksI5Ia+jZhCvc1MATTNq3GGezeD1ryg0cupDERjOTHIqhImiCFiGO8E8K09C
         wAhZi12d2wOy3AjuixJc1Nfe+r5kIIy3xDEM+o5vP3JDa4aYUQfOcSK4emyBC8/bbZ
         /yqJCydO/pEL83y+acFSQ9cKx7UFctAV+9UYYW2kBC2dg9eyg8qZxMnKJBOyn0/PXH
         04Ribqyq8PpLQ==
Date:   Mon, 23 Jul 2018 15:12:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rajat Jain <rajatja@google.com>
Subject: linux-next: manual merge of the driver-core tree with the net-next
 tree
Message-ID: <20180723151224.69a73892@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IOndqov/G_gyZt2cVw+4vKf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IOndqov/G_gyZt2cVw+4vKf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in:

  fs/sysfs/group.c

between commit:

  5f81880d5204 ("sysfs, kobject: allow creating kobject belonging to arbitr=
ary users")

from the net-next tree and commit:

  c855cf2759d2 ("sysfs: Fix internal_create_group() for named group updates=
")

from the driver-core tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/sysfs/group.c
index c7a716c4acc9,38240410f831..000000000000
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@@ -122,15 -118,23 +122,24 @@@ static int internal_create_group(struc
  			kobj->name, grp->name ?: "");
  		return -EINVAL;
  	}
 +	kobject_get_ownership(kobj, &uid, &gid);
  	if (grp->name) {
- 		kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
- 					  S_IRWXU | S_IRUGO | S_IXUGO,
- 					  uid, gid, kobj, NULL);
- 		if (IS_ERR(kn)) {
- 			if (PTR_ERR(kn) =3D=3D -EEXIST)
- 				sysfs_warn_dup(kobj->sd, grp->name);
- 			return PTR_ERR(kn);
+ 		if (update) {
+ 			kn =3D kernfs_find_and_get(kobj->sd, grp->name);
+ 			if (!kn) {
+ 				pr_warn("Can't update unknown attr grp name: %s/%s\n",
+ 					kobj->name, grp->name);
+ 				return -EINVAL;
+ 			}
+ 		} else {
 -			kn =3D kernfs_create_dir(kobj->sd, grp->name,
 -					       S_IRWXU | S_IRUGO | S_IXUGO,
 -					       kobj);
++			kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
++						  S_IRWXU | S_IRUGO | S_IXUGO,
++						  uid, gid, kobj, NULL);
+ 			if (IS_ERR(kn)) {
+ 				if (PTR_ERR(kn) =3D=3D -EEXIST)
+ 					sysfs_warn_dup(kobj->sd, grp->name);
+ 				return PTR_ERR(kn);
+ 			}
  		}
  	} else
  		kn =3D kobj->sd;

--Sig_/IOndqov/G_gyZt2cVw+4vKf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVY7gACgkQAVBC80lX
0GzHPQf+J0/auWMhpVVK4yFCEdUYpMxE7Rdox/lf6dwyOLQOM2TK1d1mWywV5eLy
qhIRwzOfSP7IJsAS5Oed/zZjdaNt6YYSFaKkzqiIq9yNasCqvr0fmvgfUucr/gE4
irv5YMDWKsBbJ1oOsTVsbc1MeB7RfPE5vekea3RWG1QqEeh09lyJcwtysCwUdM62
Nlw44p+oGPi+L+x/poGCOoPuUKBAtJsi5dqbCfeegdx0OyAA5kNnr1FadkCuL4sY
5Cwr7yj3ArhGrMMBuFwKnNCIO0efptr+kRaYp9O8jOA3X0o5zn8r3vRsRGadxu3e
N6Zd1ieT0ARvdJtAnZVUGRBqdkpcig==
=ImcX
-----END PGP SIGNATURE-----

--Sig_/IOndqov/G_gyZt2cVw+4vKf--
