Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0597208E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fnQC47b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0597208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbeHPDDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:03:54 -0400
Received: from ozlabs.org ([203.11.71.1]:46087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbeHPDDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:03:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41rRX95vl9z9s7c;
        Thu, 16 Aug 2018 10:09:13 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534378156;
        bh=E5BofNx+SR+LRN55tEndSzhhCF1j9zk1PZiycvZkYXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fnQC47b6OQJbrzPFWauiFDwoJzx7SoDqf4SJ5GI2q9txocYSskY39OtnVEkNZ2XXi
         TWC4wSoeIm2f/rGBgaqqiVSJPMx4KXmsKR1SLjIaX5+12h1QfSHA6zlgadrY89rp9y
         W6OYOGBf/L8l64Sn6xIHQ5DZiikKilpA3RkwYHHzhud8O3GiHG9cS+TcdEMt/3J8LU
         PJTE20b3OZOcfZZQsods8lBZE2I5MNaZ+a6TYwkrX67Pul75ArZmX+JWnUJWPu9z+L
         ShGey6BivRLyHIVfbs9lnNQZrHPa0V9QyL0dXqzOw4GONJs/GSSRv+qK2y1i/xbatw
         7XgZ9Oc6G/dow==
Date:   Thu, 16 Aug 2018 10:09:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: linux-next: build failure after merge of the xen-tip tree
Message-ID: <20180816100913.0ffa0df5@canb.auug.org.au>
In-Reply-To: <20180730151213.4b1e1af4@canb.auug.org.au>
References: <20180730151213.4b1e1af4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aBMld8MOi9ZBxBxSih09DoJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aBMld8MOi9ZBxBxSih09DoJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 30 Jul 2018 15:12:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the xen-tip tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/xen/gntdev-dmabuf.c:360:12: error: initialization from incompatib=
le pointer type [-Werror=3Dincompatible-pointer-types]
>   .attach =3D dmabuf_exp_ops_attach,
>             ^~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   a240d6e42e28 ("xen/gntdev: Implement dma-buf export functionality")
>=20
> interacting with commit
>=20
>   a19741e5e5a9 ("dma_buf: remove device parameter from attach callback v2=
")
>=20
> from the drm tree.
>=20
> I have added the following merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Jul 2018 15:08:21 +1000
> Subject: [PATCH] xen/gntdev: fix up for attach callback API change
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/xen/gntdev-dmabuf.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> index faaa4d3970ea..744cfe9b0311 100644
> --- a/drivers/xen/gntdev-dmabuf.c
> +++ b/drivers/xen/gntdev-dmabuf.c
> @@ -217,7 +217,6 @@ dmabuf_pages_to_sgt(struct page **pages, unsigned int=
 nr_pages)
>  }
> =20
>  static int dmabuf_exp_ops_attach(struct dma_buf *dma_buf,
> -				 struct device *target_dev,
>  				 struct dma_buf_attachment *attach)
>  {
>  	struct gntdev_dmabuf_attachment *gntdev_dmabuf_attach;

This is now a conflict between Linus' tree and the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/aBMld8MOi9ZBxBxSih09DoJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt0wKkACgkQAVBC80lX
0GwHrgf+O6FFsaNS9Ns/qqJwGQglbwJYGtok6HZHX+YpwBufT7zw0Kz566uGeYo2
ye73+FV1lIhF2iKb4R0Cq9MZuUkn9CiezYeQcnqjyjdVIJigYqb/9nBxnDMEPBlC
/4Np6/b6Dutrf5Lw8sW8R1+xakOw5xtdLHMwJM+gDoUEAhueAXlz24kRfpmk4XNw
dvWHQfkFHM0CyzVYO6WKJ/dko3uW31VwVQAqIcmbD+O27f4UsIaEs8oAtupuMB6o
AZD/tgsy26nzEuQnesQZ7tbNqx2B8Ziu8asekMQI9czIb4Ag0ZQKHPkDEhFS4xMY
JZETbXOfxG4qLvK4ZrZLpLRFAeIArg==
=jUg3
-----END PGP SIGNATURE-----

--Sig_/aBMld8MOi9ZBxBxSih09DoJ--
