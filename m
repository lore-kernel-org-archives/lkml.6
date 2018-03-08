Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964809AbeCHN2t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754988AbeCHN2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:28:47 -0500
Message-ID: <1520515725.3126.88.camel@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
From: Doug Ledford <dledford@redhat.com>
To: Leon Romanovsky <leonro@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 08 Mar 2018 08:28:45 -0500
In-Reply-To: <20180308060920.GQ15340@mtr-leonro.local>
References: <20180308164058.2ad5a158@canb.auug.org.au>
         <20180308060920.GQ15340@mtr-leonro.local>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HUls6Q3WZ2zcJvnTJtX8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HUls6Q3WZ2zcJvnTJtX8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-08 at 08:09 +0200, Leon Romanovsky wrote:
> On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Commit
> >=20
> >   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
> >=20
> > is missing a Signed-off-by from its author.
>=20
> Doug, something went wrong with your scripts
>=20
> In patchworks it is with SOB and lengthy commit message:
> https://patchwork.kernel.org/patch/10264089/
>=20
> In the tree, it is cut:
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=
=3Dfor-rc&id=3Daa0de36a40f446f5a21a7c1e677b98206e242edb

I use git am -s <mboxfile> to bring the patch in, so this usually
indicates that there was something wrong with the email and it caused
patchworks to improperly parse it.  Sure enough, when I look in
patchworks (https://patchwork.kernel.org/patch/10264089/, the exact link
you listed above so I'm surprised you didn't catch this), patchworks
parsed that separator line you put in the commit message:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
as the end of message and start of patch.  So, in patchworks, that line
and everything after it is considered part of the patch and not part of
the message.  So, when I download the mbox file, patchworks placed this:

---
2.6.12

at the end of the truncated commit message, so git am would also ignore
everything after your separator line.

Anyway, I've hand edited the mbox file and I pushed a rebased version of
my wip branch.  However, during the night Jason must have moved my
wip/for-rc branch to the official for-rc because it's there now, so the
only way to fix this (that I know of) in our official for-rc branch is a
rebase :-(

FWIW, be careful using those big separator lines like that.  They can
and, as you see here, do trip up the automated tools sometimes :-(.=20
Would be better to just not put a guard around the copied in stuff.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-HUls6Q3WZ2zcJvnTJtX8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlqhOo0ACgkQuCajMw5X
L90ZhRAArv7Ptf63g3IudJ2M1ciB71vV9x/zJRAtKyY564TJt85HI275XzaU2Nkc
QSEsY9pz8Np9h4DbKoJefzK29obPvooZvKpa+W4TZkRS1NlQrlnZJrxPSna957iN
nwGDgABTn3xy+RT/DaTnQF9tHkNao4xUhYE+khIeeNuoAQxvonn4LMtR9oTTKydy
726i6JQxr/cJwbU7+4RBqOXKu7178W2SVbOptODMiRMFtggeTU1kVpsMr47J4Lbx
X/Vl9XDBV4iw9WJTAS8x+xuISR6XXbKoFVMB3GY3fB9cLoIgxnSO4UUNAtiv4DAr
bMIcm/BgLZfuVfp+tOvzrKxM8/femzjaYpD1ehHB+mQbDEZ3xrYAPhQiQQxpGy6T
+bD/G5V/CEOcQnZrOmm18n68mn4EbceRh8oXBuTN7ZJKV4H6eZjPTuGxw06XS4tz
BDAiBPalmQqGA+yvfXtQZP4xOpVq73VcCz8xs2wd/WZoIyp1AnNGwKrrASCgEwBT
fPDBKMKi0w0PaTXuBE6vYp6R7OlJN9+rfUJIlUDqUdBPZEb2VPR4PpQQCEHQq4t7
UzHk3XGFfdC61jmxduSIoX4ZIFZJEOnhVlx9uasOCVnvc1HKdFW1OoXfuRER1Yed
2T8L2k6LK11fSYIlB/gs8vSsM1I352w8BXnbgeIUdcgZZDj83fE=
=EPEO
-----END PGP SIGNATURE-----

--=-HUls6Q3WZ2zcJvnTJtX8--
