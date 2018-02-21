Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937935AbeBUOms (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:42:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:59851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934121AbeBUOmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:42:45 -0500
Date: Wed, 21 Feb 2018 15:42:40 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
Message-ID: <20180221144240.pfu2run3pixt3pzo@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sj7gzac6guuidn6w"
Content-Disposition: inline
In-Reply-To: <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:tphETNtZffCGLhc9PG/XHfZKTo+t309zL+K8PtzZjScI/l+gWko
 0LqU9QHKBfCq9upByLEub7IZ99w7XrLgN+db3kpcffiPbZTfPZdILy2gjBNJip6+HSTOOif
 HuPZl1ZtcoJHBU0cx5kn/shwQggSPkR/Ck4JuVlN89QebHz8zzLeYF3peLnBHqNlxURtDpp
 IxXY674Yz6rEdyQAkCVYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5+aw2Vfav1E=:5URRt6Gdi6g7xh5jJwMh4p
 b1eTVLtTc39fQNrSMmRBpgCgPa9XiinxpIKfjrvNQ7f4o/fqM5IFCDZHo2eneJPBeCk8SFmj0
 Ld4W6DwYC1sec7cVsbroN9EflrvY2bBNml+nm9+B4OvMW9UmxVy2AGuYF2mfm9x7PJ8qOvysp
 f8zc6+d7ee2QtYczHqBgDhYDLW3t6ARwnoEkbyNWQqrRIEwrb+eVDSoujak2m5W7nNETtfHYD
 kg446t6a9ffGGwcCkivDUGv8hoNWCxkRFzonYL8eb/BccoCvxPCgSwHduFUNSL6lQq2mawbPu
 7s6fRNRphrYS+NzZSZ0N75KOaGPuW4MgoMlpiHYsd0dtLq/rFpvbf+EFe9ILejiFwpSx2bs4s
 vF54E7l8it8BpgrMfj6ErfowDcHh5BLlqCyHvjIOigEJqpkgperHa4wZiIQ9Vr9H5+qTk29Qe
 B3+kfIhiIDgJM80JlXJesNlUWeLeMzp1sN5fSkAG6iKPAT1C7szGkBfDjxq8DPs2V7EJA0x8M
 K/2N7n7iu/6SCosLFZ4NGxUyZR+GTwXtDnZd2vXhqMGfY1PjFpyL4lt6Pr4i3VX36SSgAcSe3
 WZiIb8HL/5ci6zXf7mBhNOk7sJGIoJhm2hV0/+Gplqv8MgMpJwa3qxwawrlb34Wq2973h9Npd
 12DGK1aPynyqJF/uLKFphwq/C5Ghsl/OZjNKzAdka4dGX2yHsZUOa+VFAfL7Hvy0bIhE+B2fd
 oBD5LYqeTx1mEvFVSSrNBE1k9BMvID20fTF9hO+x6eu6zZDOWEr/6DnFUyQlTxhnNzqEj9YkB
 XcXPFpwhxKVMbsNe7U9GSdvnDldlw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sj7gzac6guuidn6w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2018 at 08:06:10AM +0100, Christophe LEROY wrote:
>=20
>=20
> Le 20/02/2018 =C3=A0 17:14, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > This patchset adds support for DISCONTIGMEM on 32-bit PowerPC. This is
> > required to properly support the Nintendo Wii's memory layout, in which
> > there are two blocks of RAM and MMIO in the middle.
> >=20
> > Previously, this memory layout was handled by code that joins the two
> > RAM blocks into one, reserves the MMIO hole, and permits allocations of
> > reserved memory in ioremap. This hack didn't work with resource-based
> > allocation (as used for example in the GPIO driver for Wii[1]), however.
> >=20
> > After this patchset, users of the Wii can either select CONFIG_FLATMEM
> > to get the old behaviour, or CONFIG_DISCONTIGMEM to get the new
> > behaviour.
>=20
> My question might me stupid, as I don't know PCC64 in deep, but when look=
ing
> at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling the PPC64
> implements ram by blocks. Isn't it what you are trying to achieve ? Would=
n't
> it be feasible to map to what's done in PPC64 for PPC32 ?

Using page_is_ram in __ioremap_caller and the same memblock-based
approach that's used on PPC64 on PPC32 *should* work, but I think due to
the following line in initmem_init, it won't:

	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);


Thanks,
Jonathan Neusch=C3=A4fer

--sj7gzac6guuidn6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajYVWAAoJEAgwRJqO81/bt2YQAJVWrBF/ocJJjhm+aS/UxJkD
QtVPunOENVzUa3TvGRkB+Snlik8tAon75OZBBj0OHllUqiLLVxzUC1OOz8wTzOdP
AFeBcN4KE+OV1iRlEoN6g42kPs+b9pHWnVnWDnLIdPGpUJxkDIoPV1AnhKjdiNMu
2X2ri0/aGzFYFBB8je9vV3b9rD9HVkUgDa4UjC01gVL5J+dX0qlPJ/Qj3xLzIFsf
TFkIQbeU2yuOWxdVk5ngI6J1tW+bzIklqk8ptwtvBMVysU7j4b1Zvx8xu2tZjhmu
F1/QNOZlcQAQdKvRJn+3O8wUyl3dseD/wXHHZkfeQi1bHnCNRWl7+peiNIdNlfWj
FneQf7NFENHRHdnblhmYkJuFNIIjJU/K5dFc4UMuYwOMwtyNSdQqnHfCwYRmjOq/
HynUlOiOSEok411GuOCtd+y2SmTsmdoSB7fqqIZTIrqlqqDUsmAdu/f0WNuPqG2t
yCrm/+8hrmylwloqWK+kQCpcRSkN90dHwQE/ZWiPDsI59qCdMdJSnfFYFbbgzbbK
br2sNx1YHXkwDPqkKLCI9gymCgO4BWJGeevuH4gJbfehBGC9+b2Oij5uP9plM4HC
QPATH4CmOZH7RbBrOaunuHtuva26VpX8f5+IVGzx+ilKFuaBPucsquoDFJu7/SmJ
LBIs6ol1cb/jr268Wlfl
=vWFI
-----END PGP SIGNATURE-----

--sj7gzac6guuidn6w--
