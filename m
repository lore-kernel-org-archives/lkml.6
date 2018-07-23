Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE1C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C731320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 02:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pnZXDgvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGWD2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 23:28:20 -0400
Received: from ozlabs.org ([203.11.71.1]:33157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbeGWD2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 23:28:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Ylmx1XnPz9s2g;
        Mon, 23 Jul 2018 12:29:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532312965;
        bh=HoLsReSp1+U2lLCwEwJl7XCaHXnvmoByLOR+QMunsHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnZXDgvGJ98VML3YbRbh7C4hKzAMNb3jRrTpwHjIqEXFfAUU3S0YtTwjtcUCQs58b
         BtPaK+AqUNkP9icMQHNlahPW25OZCitPMPFq1BK4Sz6NohLH6omQADADNcuMUhDXaA
         qwz9Peyx5IhXViCRArJbCsPsK2yAB0ifGAgHLKuM7RXJTT9y1UrIQ4k3uCt//srL/5
         30BSUjaKZQs9sim/Ei32t90aFPOIcoWmegqEt6knsrX0fmAL8/QaWnmTSt2KXVHr27
         XvQZEzFztQLPj/UlrucO24/SSms92dvl75Kk7v5EgaIUoXxBlVOD2VMl+bjTWYFOek
         7HspPFpL8XIGQ==
Date:   Mon, 23 Jul 2018 12:29:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20180723122900.60562ff8@canb.auug.org.au>
In-Reply-To: <20180713115419.1270c385@canb.auug.org.au>
References: <20180713115419.1270c385@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=6kqBa49ysBhdfu.ptLUJYi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=6kqBa49ysBhdfu.ptLUJYi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 13 Jul 2018 11:54:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> [Dave cc'd because this will probably turn up in the drm tree soon.]

And now it has ...

> After merging the drm-intel tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/i915/gvt/kvmgt.c: In function 'gvt_dma_map_page':
> drivers/gpu/drm/i915/gvt/kvmgt.c:188:17: error: 'pfn' undeclared (first u=
se in this function); did you mean 'gfn'?
>   if (!pfn_valid(pfn)) {
>                  ^~~
>=20
> Caused by commit
>=20
>   79e542f5af79 ("drm/i915/kvmgt: Support setting dma map for huge pages")
>=20
> interacting with commit
>=20
>   39b4cbadb9a9 ("drm/i915/kvmgt: Check the pfn got from vfio_pin_pages")
>=20
> from Linus' tree (v4.18-rc1).
>=20
> I added the following merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Jul 2018 11:48:41 +1000
> Subject: [PATCH] drm/i915/kvmgt: merge fixup for "Check the pfn got from
>  vfio_pin_pages"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index 718ab307a500..4d2f53ae9f0f 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -185,12 +185,6 @@ static int gvt_dma_map_page(struct intel_vgpu *vgpu,=
 unsigned long gfn,
>  	if (ret)
>  		return ret;
> =20
> -	if (!pfn_valid(pfn)) {
> -		gvt_vgpu_err("pfn 0x%lx is not mem backed\n", pfn);
> -		vfio_unpin_pages(mdev_dev(vgpu->vdev.mdev), &gfn, 1);
> -		return -EINVAL;
> -	}
> -
>  	/* Setup DMA mapping. */
>  	*dma_addr =3D dma_map_page(dev, page, 0, size, PCI_DMA_BIDIRECTIONAL);
>  	ret =3D dma_mapping_error(dev, *dma_addr);

--=20
Cheers,
Stephen Rothwell

--Sig_/=6kqBa49ysBhdfu.ptLUJYi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVPWwACgkQAVBC80lX
0Gx0+Qf/SiJ4LzDBTJ40ZAuwkVKuqpD0Eb3x3aLRpk2OiHfvQLfa4+H0YqFlXVzl
z+hEoCk2HEivWnYkePsknJcBqe3eroCdESZ3DebGGxTBL3I1+Qcll4bokNEnL6jJ
Khj5Ia4KVLfLFHyzyjFxnFjjjvb1pfB8wJh8gqDS2fVBDNH+WpPB5lHBwIAA9aIG
Fgzp5V5sTDzEsyix/EyXk/zY+pkIozTosQIZpJ0+22N1RwLCcJNY5befJXymUEtT
Ezu0frtWdOvlYUCc9dPJuCRF+x5wC36DnyatTgIM6b5z7tQqbgyH40GMTmlKrDQt
P6kJNVbGtB05kXkOh0Lqq7e6kdB9Zg==
=e9YC
-----END PGP SIGNATURE-----

--Sig_/=6kqBa49ysBhdfu.ptLUJYi--
