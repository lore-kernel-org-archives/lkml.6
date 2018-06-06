Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UkponjR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F9556070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeFFKTc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:19:32 -0400
Received: from ozlabs.org ([203.11.71.1]:47051 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeFFKTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:19:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 20:19:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: linux-next: manual merge of the y2038 tree with the staging tree
Message-ID: <20180606201927.7c4efad2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Afb0fnXM94H/AknFEebhBdz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Afb0fnXM94H/AknFEebhBdz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the y2038 tree got conflicts in:

  drivers/staging/lustre/lustre/llite/llite_lib.c
  drivers/staging/lustre/lustre/llite/namei.c
  drivers/staging/lustre/lustre/lmv/lmv_obd.c
  drivers/staging/lustre/lustre/mdc/mdc_reint.c
  drivers/staging/lustre/lustre/obdclass/obdo.c

between commit:

  be65f9ed267f ("staging: lustre: delete the filesystem from the tree.")

from the staging tree and commit:

  18a592632e61 ("lustre: Use long long type to print inode time")

from the y2038 tree.

I fixed it up (I removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Afb0fnXM94H/AknFEebhBdz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXtS8ACgkQAVBC80lX
0GwcTAgAkXBsrnxg5u6UYMlycpRtt7PlD8xTeuhc9tGdo16xZb5DT7EhfYzWMA7S
L7pNHpUoXPofnG+drZI9jCPTrvQg0Op/VycRE1ZbmbwzttxpbGHBtYTRRsOtCnvV
CnjDpniGH3draZaVgyuXXoHX0YEbaM9d+QHeFVnnWubaIIRE/bhxNI2diqtfXHlK
AjlKaDJ8+OhRPW1rE3U4cH0h6RQs+yxuR5tnEuCSmDX23pWSp6vfOcRs+mTiSuo6
QKL7Vx+9GwLP0YSkYTLGVSh+7XTjUJJ7xUnYqa06O8cL7pPshUqcVJWXD584CueL
nGMDe7MORnQETZDDVP7m0sIEFcEAPA==
=WdFL
-----END PGP SIGNATURE-----

--Sig_/Afb0fnXM94H/AknFEebhBdz--
