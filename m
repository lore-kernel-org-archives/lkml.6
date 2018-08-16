Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04636C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6FE208E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AK/b5w/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6FE208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbeHPC7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:59:50 -0400
Received: from ozlabs.org ([203.11.71.1]:37175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbeHPC7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:59:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRRX25vtz9s8f;
        Thu, 16 Aug 2018 10:05:12 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534377913;
        bh=ZB6ZICEWRa8hrRZsDpBILkFrxccQbOLcO1NGTumTJBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AK/b5w/0wPiQzgjEihoSwl3ebTb0Q4gxBuGmNo3FpS8BZtPG4dPbd5P3eyg6EpRvn
         LmeTGdWAjo/6ZQv2baE4TWui/MqQ1jJHtcJqS2QH4K+cpetouqoxu671SZHXkLykTx
         S+MPTp9JWKs43U5wrp5v0YeoTFsPvZZmQAAkTCeiH0EnlnbJOex0h/gZdUnFMsFrzH
         4ZFB+9uitdQP1fxPK/50G9Eyqo7quC/yFui+W7l2Tw3mf7TASXbfzfxoaWrVcUeU5O
         B6pAi3bWQZYW+crepznVvoTCXn7XUW6DzwcCHNMT27fPRyWrHDgBuRD35E6RXUqTAC
         NNnUrSCAR7lgw==
Date:   Thu, 16 Aug 2018 10:05:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 xen-tip tree
Message-ID: <20180816100511.2377dda2@canb.auug.org.au>
In-Reply-To: <20180730190210.48a75b72@canb.auug.org.au>
References: <20180730190210.48a75b72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hgsa92rdqXObSy_yITGi8Ub"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hgsa92rdqXObSy_yITGi8Ub
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Jul 2018 19:02:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   drivers/xen/gntdev.c
>=20
> between commit:
>=20
>   1d3145675538 ("xen/gntdev: Make private routines/structures accessible")
>=20
> from the xen-tip tree and commit:
>=20
>   aaefcabe9c25 ("mm, oom: distinguish blockable mode for mmu notifiers")
>=20
> from the akpm-current tree.
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
> diff --cc drivers/xen/gntdev.c
> index c866a62f766d,55b4f0e3f4d6..000000000000
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@@ -479,7 -441,20 +479,20 @@@ static const struct vm_operations_struc
>  =20
>   /* ------------------------------------------------------------------ */
>  =20
>  -static bool in_range(struct grant_map *map,
> ++static bool in_range(struct gntdev_grant_map *map,
> + 			      unsigned long start, unsigned long end)
> + {
> + 	if (!map->vma)
> + 		return false;
> + 	if (map->vma->vm_start >=3D end)
> + 		return false;
> + 	if (map->vma->vm_end <=3D start)
> + 		return false;
> +=20
> + 	return true;
> + }
> +=20
>  -static void unmap_if_in_range(struct grant_map *map,
>  +static void unmap_if_in_range(struct gntdev_grant_map *map,
>   			      unsigned long start, unsigned long end)
>   {
>   	unsigned long mstart, mend;
> @@@ -503,15 -472,26 +510,26 @@@
>   	WARN_ON(err);
>   }
>  =20
> - static void mn_invl_range_start(struct mmu_notifier *mn,
> + static int mn_invl_range_start(struct mmu_notifier *mn,
>   				struct mm_struct *mm,
> - 				unsigned long start, unsigned long end)
> + 				unsigned long start, unsigned long end,
> + 				bool blockable)
>   {
>   	struct gntdev_priv *priv =3D container_of(mn, struct gntdev_priv, mn);
>  -	struct grant_map *map;
>  +	struct gntdev_grant_map *map;
> + 	int ret =3D 0;
> +=20
> + 	/* TODO do we really need a mutex here? */
> + 	if (blockable)
> + 		mutex_lock(&priv->lock);
> + 	else if (!mutex_trylock(&priv->lock))
> + 		return -EAGAIN;
>  =20
> - 	mutex_lock(&priv->lock);
>   	list_for_each_entry(map, &priv->maps, next) {
> + 		if (in_range(map, start, end)) {
> + 			ret =3D -EAGAIN;
> + 			goto out_unlock;
> + 		}
>   		unmap_if_in_range(map, start, end);
>   	}
>   	list_for_each_entry(map, &priv->freeable_maps, next) {

This is now a conflict between Linus' tree and the akpm-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hgsa92rdqXObSy_yITGi8Ub
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0v7cACgkQAVBC80lX
0GyT9Af9FHUkWlJA+c6mKp7D4Zcr12z3D0N2E1osk+wFOvnqG5GLz98lOetUCMQc
ObTE3lkBmDYsDFscrrJCPNwin6bgddwsqoDCRTYzmEebk576k2LjFFMqXybWFoFe
He8Mj7LE26U6ydU99CHuvhUUn8UmlaFjc32sEhMp0IqTdSV0RE880NlXhc5raUNs
RuEEOK4S8IXSYr1aLAyTnUKT+aDsbZ0k949fAzQvOQR76jTu6+zjl02g9fWpnS/Y
3tAM8YW7DjFIj5mj5OOkuc2PfSIB+sriR/qANJ9yjT+8yoPI7u6FzORsDnNvAyjb
lZqStevQoY+M5qlDspeS6bfCfV5LDg==
=OJCs
-----END PGP SIGNATURE-----

--Sig_/Hgsa92rdqXObSy_yITGi8Ub--
