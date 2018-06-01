Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750931AbeFAAJp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 20:09:45 -0400
Received: from ozlabs.org ([203.11.71.1]:45749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFAAJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 20:09:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 10:09:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the cifs tree
Message-ID: <20180601100922.56e98097@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ktz4CCX786EbJPYusXy+G6p"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ktz4CCX786EbJPYusXy+G6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/cifs/connect.c: In function 'cifs_mount':
fs/cifs/connect.c:3967:10: error: 'struct cifs_tcon' has no member named 'p=
osix_extensions'
  if (tcon->posix_extensions)
          ^~

Caused by commit

  12a778233fc4 ("smb3: Add posix create context for smb3.11 posix mounts")

# CONFIG_CIFS_SMB311 is not set

I have used the cifs tree from next-20180531 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ktz4CCX786EbJPYusXy+G6p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQjrIACgkQAVBC80lX
0GzvYwf+JO+qL0q6LfIZRfeby/D0fduDc+zbzkfL+6NWKBfb1kx05knSOFLZvoXg
O03y66z7iEQ2zoVe70Xd6X8NvnJdocnzhmb/yySvdm7UeeDm73Jt2dGyE8gaFef5
gzm5NuFKldwMYJXChyp9g4m20m2HlOPnN091tTEaGgVXNq7hy4W1IyiF84jnJA/H
UVfJQ4iL3lyVeCyi07ExQFAqJcqEyI1AGgLNcCPBiUwwQscripfzhQIncPrI3bIE
pVxcWx2RMYU9riKVBu0OaBsN6yT1y9o3A1Mc0FPw4g7dLCHnQ5xAQB28zIusNkqu
uKQpwJzER4UHQ3IbH5WtES/jzH4ogg==
=noZ+
-----END PGP SIGNATURE-----

--Sig_/ktz4CCX786EbJPYusXy+G6p--
