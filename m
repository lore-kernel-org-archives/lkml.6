Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753967AbeE2EeH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:34:07 -0400
Received: from ozlabs.org ([203.11.71.1]:40097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeE2EeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:34:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 14:33:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Joe Perches <joe@perches.com>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20180529143357.2a66b0af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bUzOcQuARamVCAf7sLtL+NB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bUzOcQuARamVCAf7sLtL+NB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/block/DAC960.c

between commit:

  3f3942aca6da ("proc: introduce proc_create_single{,_data}")

from the vfs tree and commit:

  5657a819a8d9 ("block drivers/block: Use octal not symbolic permissions")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/block/DAC960.c
index 6918c3d9482e,7c3887a7e534..000000000000
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@@ -6553,11 -6587,9 +6548,11 @@@ static void DAC960_CreateProcEntries(DA
  		 "c%d", Controller->ControllerNumber);
  	ControllerProcEntry =3D proc_mkdir(Controller->ControllerName,
  					 DAC960_ProcDirectoryEntry);
 -	proc_create_data("initial_status", 0, ControllerProcEntry, &dac960_initi=
al_status_proc_fops, Controller);
 -	proc_create_data("current_status", 0, ControllerProcEntry, &dac960_curre=
nt_status_proc_fops, Controller);
 +	proc_create_single_data("initial_status", 0, ControllerProcEntry,
 +			dac960_initial_status_proc_show, Controller);
 +	proc_create_single_data("current_status", 0, ControllerProcEntry,
 +			dac960_current_status_proc_show, Controller);
- 	proc_create_data("user_command", S_IWUSR | S_IRUSR, ControllerProcEntry,=
 &dac960_user_command_proc_fops, Controller);
+ 	proc_create_data("user_command", 0600, ControllerProcEntry, &dac960_user=
_command_proc_fops, Controller);
  	Controller->ControllerProcEntry =3D ControllerProcEntry;
  }
 =20

--Sig_/bUzOcQuARamVCAf7sLtL+NB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsM2DUACgkQAVBC80lX
0Gz6GAf/WZYKnCsIwE/4KiwtJOZLgnTjjOwmBEZvyrZMkoF627hyK03uxllo7qHP
eXBLiUQahcJPzAkangGEAUWapNMN1hlNSOKDpIqUDicIS7bXUrhzliXxutgjSjWP
Z22xOTYfMVTeFrN5k6zwk1QJEAIWdsr6y0I6UPLgsv8ojibvhFawyEmzVXFTYLEn
M0gIYKhpd/dtGfx9xnINu7AThqlPNXVEwnAuD7OsqpRxvDMhpIWhutvsue69RV7R
1sQsncK+kxiNf3k1A8Y+FPe6stnFhJEqgvVz633LYXkmkewcZZS5v1N77rdIfcJC
aeJ5HMigSvaM+xpnIvQJMNBvUm+SPw==
=ELzd
-----END PGP SIGNATURE-----

--Sig_/bUzOcQuARamVCAf7sLtL+NB--
