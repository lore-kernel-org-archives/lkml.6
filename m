Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936126AbeEYKPb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:15:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935638AbeEYKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:15:29 -0400
Date: Fri, 25 May 2018 11:14:55 +0100
From: Mark Brown <broonie@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the arm tree
Message-ID: <20180525101455.GI4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SqJDPA0lBYgnDFWV"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SqJDPA0lBYgnDFWV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Yesterday's linux-next merge of the userns tree got a conflict in:

  arch/arm/mm/fault.c

between commit:

  8d9267cedb9e1d8edb8 ("ARM: spectre-v2: harden user aborts in kernel space=
")

=66rom the arm tree and commit:

  3eb0f5193b497083391 ("signal: Ensure every siginfo we send has all bits i=
nitialized")

=66rom the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm/mm/fault.c
index 3b1ba003c4f9,32034543f49c..000000000000
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
  {
  	struct siginfo si;
 =20
+ 	clear_siginfo(&si);
+=20
 +	if (addr > TASK_SIZE)
 +		harden_branch_predictor();
 +
  #ifdef CONFIG_DEBUG_USER
  	if (((user_debug & UDBG_SEGV) && (sig =3D=3D SIGSEGV)) ||
  	    ((user_debug & UDBG_BUS)  && (sig =3D=3D SIGBUS))) {

--SqJDPA0lBYgnDFWV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsH4h4ACgkQJNaLcl1U
h9AN/Af8DHm8jUlDa1D16t8lQPh7+oWpmZJFoK2133n5iHDnmmrZdQDWmOARZPQn
nv3NPGmzySF9ZCw/JGXSDqBGaV1LOPDclQxNKbHtT//2Dxvb6uGV2AlI4pi9mGbm
Thoy7PDXSW5q0pUEumcFQBtGfJ4E7sSUfJTb52f3uqlf1TTPwOIo8vCf3IbKjoMu
TLQecvhhZJedFJUHRyAXR44ZR76BLSvOFJRgT0mkC1Ww2Tp8DoKi/idZejth3umF
PtXY2HhmPDPmrQrcFRm2MytvfE2R4UdYRIHN51z4k42L7V4dTVbZ3F29qzoWBLs2
O9ysrEPXMcA8IQBr6g2Ckjp3muLbsw==
=k9nm
-----END PGP SIGNATURE-----

--SqJDPA0lBYgnDFWV--
