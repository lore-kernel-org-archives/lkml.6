Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7060813F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2570E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ThOzpurm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2570E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeG3KgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:36:15 -0400
Received: from ozlabs.org ([203.11.71.1]:47365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeG3KgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:36:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fD8z35Xsz9ryl;
        Mon, 30 Jul 2018 19:02:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532941331;
        bh=ChEokd+d79J7ZlmISjyYJpf9LwVCaNngVY4aL8LXnqg=;
        h=Date:From:To:Cc:Subject:From;
        b=ThOzpurm/CXMYYuIqbjJTSDL+rraJK5x/HnWsJJsHKJXap5MkapGzgWhtuRgsPzxn
         56QmNVJtlWBZTz7KVY+49ykX7hFJn2SXTiPsNR18e+20/LlnljY512LmXgoC8BpWtP
         mN0/e5VfXrevtPzPvG3L6fHDTmq5eAP1UoKBpi0w+YK/PCl6iJPO3V2nX6lYuQIWUv
         AkWJtTfw/Zsiaeu7XDIKTKRrnPrX6IZNw6PwaeJwHHnolnsJkPtSaSEGcx6S+aZnMo
         FJSD4g/oNxQbcsYn+7kNe9jtNTCYXJVeL8tcx09x1r22ZSBEgmi7KU4PDDFV77Dc91
         BfE1F3ZYVkAZA==
Date:   Mon, 30 Jul 2018 19:02:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Hocko <mhocko@suse.com>
Subject: linux-next: manual merge of the akpm-current tree with the xen-tip
 tree
Message-ID: <20180730190210.48a75b72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RQ/f9UhlBN2KABzauLfOSxw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RQ/f9UhlBN2KABzauLfOSxw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  drivers/xen/gntdev.c

between commit:

  1d3145675538 ("xen/gntdev: Make private routines/structures accessible")

from the xen-tip tree and commit:

  aaefcabe9c25 ("mm, oom: distinguish blockable mode for mmu notifiers")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/xen/gntdev.c
index c866a62f766d,55b4f0e3f4d6..000000000000
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@@ -479,7 -441,20 +479,20 @@@ static const struct vm_operations_struc
 =20
  /* ------------------------------------------------------------------ */
 =20
 -static bool in_range(struct grant_map *map,
++static bool in_range(struct gntdev_grant_map *map,
+ 			      unsigned long start, unsigned long end)
+ {
+ 	if (!map->vma)
+ 		return false;
+ 	if (map->vma->vm_start >=3D end)
+ 		return false;
+ 	if (map->vma->vm_end <=3D start)
+ 		return false;
+=20
+ 	return true;
+ }
+=20
 -static void unmap_if_in_range(struct grant_map *map,
 +static void unmap_if_in_range(struct gntdev_grant_map *map,
  			      unsigned long start, unsigned long end)
  {
  	unsigned long mstart, mend;
@@@ -503,15 -472,26 +510,26 @@@
  	WARN_ON(err);
  }
 =20
- static void mn_invl_range_start(struct mmu_notifier *mn,
+ static int mn_invl_range_start(struct mmu_notifier *mn,
  				struct mm_struct *mm,
- 				unsigned long start, unsigned long end)
+ 				unsigned long start, unsigned long end,
+ 				bool blockable)
  {
  	struct gntdev_priv *priv =3D container_of(mn, struct gntdev_priv, mn);
 -	struct grant_map *map;
 +	struct gntdev_grant_map *map;
+ 	int ret =3D 0;
+=20
+ 	/* TODO do we really need a mutex here? */
+ 	if (blockable)
+ 		mutex_lock(&priv->lock);
+ 	else if (!mutex_trylock(&priv->lock))
+ 		return -EAGAIN;
 =20
- 	mutex_lock(&priv->lock);
  	list_for_each_entry(map, &priv->maps, next) {
+ 		if (in_range(map, start, end)) {
+ 			ret =3D -EAGAIN;
+ 			goto out_unlock;
+ 		}
  		unmap_if_in_range(map, start, end);
  	}
  	list_for_each_entry(map, &priv->freeable_maps, next) {

--Sig_/RQ/f9UhlBN2KABzauLfOSxw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlte1BIACgkQAVBC80lX
0GyG1wf+KGs6g2d6zFRQetpC8V37YhGvenZX4vHrVb7nXp9wmUVt3fRrOGvAJFGx
r9aZVBdZeBDIt1Hj5XClOm4xB3MkDUAzEAC0qp8zQxh+OopZwALw/rT+laHdTlLY
9UhtdxjieNyHVr56160LUtInU6dh13GS8nvowWMz0QRahdHnObEu/rffWgbOluKv
wPmS8tGiY/blbx5oNqMYZPUQ7I80iTrml7OrDLRQq9bWRlAaDWOe7fH6e6gbfuVF
DP89e2ojb8N9kl2UR77cJiy6XjzNvGqrbyOYiolmhqy4D2FZMiAoLSPBDwEC9OiQ
JFolvw3vycLsazHFkuuTJmlD2CdGug==
=BIWe
-----END PGP SIGNATURE-----

--Sig_/RQ/f9UhlBN2KABzauLfOSxw--
