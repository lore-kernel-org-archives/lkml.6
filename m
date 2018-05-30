Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeE3VjA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:39:00 -0400
Received: from ozlabs.org ([203.11.71.1]:49531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932337AbeE3Vi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:38:59 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 07:38:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180531073855.29c23fce@canb.auug.org.au>
In-Reply-To: <20180529132548.7f71c2ff@canb.auug.org.au>
References: <20180529132548.7f71c2ff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m+IEFHpsYnpF9ctA5CfVzTr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m+IEFHpsYnpF9ctA5CfVzTr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 29 May 2018 13:25:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfilte=
r_umh.o' is incompatible with i386:x86-64 output
>=20
> Caused by commit
>=20
>   d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
>=20
> In my builds, the host is PowerPC 64 LE ...
>=20
> I have reverted that commit along with
>=20
>   61a552eb487f ("bpfilter: fix build dependency")
>   13405468f49d ("bpfilter: don't pass O_CREAT when opening console for de=
bug")
>=20
> for today.

I am still getting this failure (well, at least yesterday I did).

--=20
Cheers,
Stephen Rothwell

--Sig_/m+IEFHpsYnpF9ctA5CfVzTr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPGe8ACgkQAVBC80lX
0Gz4uwf/Wc6DkgSCSKmMit9OkteyrD4GpuLS0bb1kBelk58xnQVIk2JcWGCsUM75
K99N2yjGFBLtkWO2VqfdLtyqTmpSyAQyjpBbuAgcWXA1j9luYzWSW8jvQi93eJTx
Lp7Fw1hC9bySO7Cy7sOAR3OLWlzhWibkYmQlX2QW0OLdz9wqHWzCtTm9geIPJiPq
P5wI30j5VpupIjOel0t9UMxKtFjuL1fLwyU//atX6PCaiwk/R5Rju6Ky8fQCyVco
Moz1WqpsfmWPpu3ukenNxNKm+Y7K2eAeOtf2ZEjZpcn1sVerHOV02U/phgffc78h
9AJzQeSMXLnCCIrAZu3o6d5+UKYc9g==
=/A4o
-----END PGP SIGNATURE-----

--Sig_/m+IEFHpsYnpF9ctA5CfVzTr--
