Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFFAQa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:16:30 -0400
Received: from ozlabs.org ([203.11.71.1]:35131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932125AbeFFAQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:16:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 10:16:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Russell King <rmk@armlinux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the userns tree with the arm tree
Message-ID: <20180606101623.1eacd4be@canb.auug.org.au>
In-Reply-To: <20180530183058.06a26dbe@canb.auug.org.au>
References: <20180530183058.06a26dbe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n0R.KydN=e3r=CWLZ7sM920"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n0R.KydN=e3r=CWLZ7sM920
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 30 May 2018 18:30:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   arch/arm/mm/fault.c
>=20
> between commit:
>=20
>   93a24d7e23e7 ("ARM: spectre-v2: harden user aborts in kernel space")
>=20
> from the arm tree and commit:
>=20
>   3eb0f5193b49 ("signal: Ensure every siginfo we send has all bits initia=
lized")
>=20
> from the userns tree.
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
> diff --cc arch/arm/mm/fault.c
> index 3b1ba003c4f9,32034543f49c..000000000000
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
>   {
>   	struct siginfo si;
>  =20
>  +	if (addr > TASK_SIZE)
>  +		harden_branch_predictor();
>  +
> + 	clear_siginfo(&si);
> +=20
>   #ifdef CONFIG_DEBUG_USER
>   	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
>   	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {

This is now a conflict between the arm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/n0R.KydN=e3r=CWLZ7sM920
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXJ9cACgkQAVBC80lX
0GwX5Qf9E7Uih5osvX8kLykC/NtUQEVKKQVQgFOzuTRByWSXAQBlGs3hw9dq4K3m
OUUqsmMfzqluPewluBnMOBJVQwTBisY0ZUxZLVIXgXKpFMxfnboDtg6D/e3XDLEk
dMcJPq+GhC93jTbl5eGbQmhbq3I0hWU05zrzxU7FdyKTYi3qdPgxwJ2HNiTVQW3j
JKvtOQb+IoiQm1Y6tlOriOvnp0qfPBq4ofk4LVuxQdmnYmL4daLyrA/m9d4bfKg/
GFbhaLitmCSiUf+VOdEt3r4bsQwMoCynIN8+2v2y8LYtTcWKquJMacEh70fycpwp
zfHR//sygxu3KEr1HuExhQ3/T9ajVw==
=VVCT
-----END PGP SIGNATURE-----

--Sig_/n0R.KydN=e3r=CWLZ7sM920--
