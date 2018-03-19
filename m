Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755120AbeCSDuL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 23:50:11 -0400
Received: from ozlabs.org ([103.22.144.67]:49201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755100AbeCSDuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 23:50:07 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 14:49:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greentime Hu <green.hu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Farhan Ali <alifm@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with the nds32
 tree
Message-ID: <20180319144924.290abdd3@canb.auug.org.au>
In-Reply-To: <20180226133445.6544ad34@canb.auug.org.au>
References: <20180226133445.6544ad34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LGEnlZW.OIKC+x8h59yr9CR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LGEnlZW.OIKC+x8h59yr9CR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2018 13:34:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvms390 tree got a conflict in:
>=20
>   drivers/video/console/Kconfig
>=20
> between commit:
>=20
>   2312dbf7462b ("drivers/video/concole: add negative dependency for VGA_C=
ONSOLE on nds32")
>=20
> from the nds32 tree and commits:
>=20
>   8da93aca3729 ("Kconfig : Remove HAS_IOMEM dependency for Graphics suppo=
rt")
>   416b744f4494 ("s390/setup : enable display support for KVM guest")
>=20
> from the kvms390 tree.
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
> diff --cc drivers/video/console/Kconfig
> index 27bb893cf6b2,b9c2c916247e..000000000000
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@@ -9,7 -9,7 +9,7 @@@ config VGA_CONSOL
>   	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
>   		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
>   		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> - 		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32
>  -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM && !S390
> ++		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && HAS_IOMEM && =
!S390
>   	default y
>   	help
>   	  Saying Y here will allow you to use Linux in text mode through a

This conflict is now between the kvm tree and the nds32 tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LGEnlZW.OIKC+x8h59yr9CR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvM0QACgkQAVBC80lX
0Gww7ggAmuUnq/DDK9sif2IPkD9iawYPRUHSk8vSmw8xPeKAIho6oXi0BtETJnb9
YOpWQjZ0tzQxzDUu1+tSZR2YK2R0eIzNq1XRV6C6iqBvbMrYWLdT137NVKCHTdWS
bt/oIy9uqhOJQMoHQeFBbt8sjP/1DQWsONOGE/jGKdAqkH7NjaRWVVJ/p4DZN9mX
I23BxOB6GGc1D7m5Ch4lxUamyOF2vVws7HC/MoOW964k0fpX9z2XH0HfZdkZQIVX
we0oqe2LTJhlZwt1ykvfYL70sIDipNENEC0FYbYJEBPDdkKWsfDh2DY9xuaP/SHS
CVaV6jGxGrNZ1Q6mPIPRIGs/QD8Ldw==
=phw+
-----END PGP SIGNATURE-----

--Sig_/LGEnlZW.OIKC+x8h59yr9CR--
