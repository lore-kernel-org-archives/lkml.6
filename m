Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2723C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660652085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SW7tLj8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660652085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeKFJg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:36:58 -0500
Received: from ozlabs.org ([203.11.71.1]:35759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeKFJg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:36:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 42pqmX0wmNz9sN9; Tue,  6 Nov 2018 11:14:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1541463276;
        bh=1Lz08PXRQPdO0WtOwYG8tFdcAkgnk64lf/qcpgcmvco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SW7tLj8cqxw4/JyAAaYI1Kx8e7qDDvx3rlBAv8Uw2hvIXy3z+BlRD9RF8IGmDF27G
         f/6hQM3G3GXiUWFQQiynUQLKTu7TFPOMGt8gVqlP/0tGF8hun14wazJoRTH6QENVhb
         exm0WJOP0qBfe1MG/7dSeeqIJCY/Tje36z49kQMg=
Date:   Tue, 6 Nov 2018 11:07:00 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fadump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181106000700.GJ24365@umbus.hotspot.internet-for-guests.com>
References: <20181105150119.6452-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <20181105150119.6452-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 10:01:19AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kernel/fadump.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index a711d22339ea..2df5e04b5afc 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1531,17 +1531,7 @@ static struct kobj_attribute fadump_register_attr =
=3D __ATTR(fadump_registered,
>  						0644, fadump_register_show,
>  						fadump_register_store);
> =20
> -static int fadump_region_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, fadump_region_show, inode->i_private);
> -}
> -
> -static const struct file_operations fadump_region_fops =3D {
> -	.open    =3D fadump_region_open,
> -	.read    =3D seq_read,
> -	.llseek  =3D seq_lseek,
> -	.release =3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(fadump_region);
> =20
>  static void fadump_init_files(void)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvg2yIACgkQbDjKyiDZ
s5I0CxAAz4+1Mnh247XBLVKNEg6EUstffA89208Hl1942kHQmMPIyXzMNTNFm3DQ
0VcTSB/KX7ZSdJxeYfoiFAg5XPdgnyc8dLX983S9Iye7Ih7kp6sJBaByRg0/svoM
yduQ08EyTQ4kmVHehQfayUqUx1EJR+GFpI8INM3tYrEhf2WvjaKLcR+qDvorJkoX
Q/EPvthNqPBAjeuG08OWRfdX3TbocXk4BpWKYq4K4u7vqxyY4GTTJ1fbcTIqQVFM
S68C9iImTn8mUhGXoBOqP5zv4sPjv+Qp2lhCjdCN32440aAsk4NzsLHvsNH9YxAj
sHeawgsYRvRahzwVPnV10rApXBwWosvOS2UiQyZU28lAxTzzZOO+5j1yA4owrzY2
qTqQJ1shnHhXR7exyJcx7wslgDqPq+zDoXJQ8glN1wau4k6Im9ZsDFw3cFbstORy
Brv7xeVMy4HWC9zLuNhZ4vvrx9J1+bsgq4X44nBDrM4Ww0dUbi3coYg8cEpxOKc9
1ClZooX95hrwGmYufc5hlalWeeDhGzJI8O08AqDM9dwUevJ5eXQCDfTfbwURvCFG
MOFGaQS6qeDTpJcds6kwH3/iSh/8tJFmq5s79CnbicAM4cqPUbUJ9WcyJcNZhYk6
kt6sxo9jyttk6G+8gMB2VMIe0pBpYyJ7C2XPc+NWppIDuDarBtY=
=Zj3C
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--
