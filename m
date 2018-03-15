Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeCOHhI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:37:08 -0400
Received: from ozlabs.org ([103.22.144.67]:48717 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeCOHhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:37:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 18:36:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rpmsg tree with the asm-generic
 tree
Message-ID: <20180315183633.7da597e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Gv7Ekw1nP6fYHnKxhNq8acW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gv7Ekw1nP6fYHnKxhNq8acW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Today's linux-next merge of the rpmsg tree got a conflict in:

  samples/Makefile

between commit:

  e7e57f690e38 ("arch: remove blackfin port")

from the asm-generic tree and commit:

  842891be96bd ("samples: Introduce Qualcomm QMI sample client")

from the rpmsg tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc samples/Makefile
index 70cf3758dcf2,a30833a2a19e..000000000000
--- a/samples/Makefile
+++ b/samples/Makefile
@@@ -2,5 -2,5 +2,5 @@@
 =20
  obj-$(CONFIG_SAMPLES)	+=3D kobject/ kprobes/ trace_events/ livepatch/ \
  			   hw_breakpoint/ kfifo/ kdb/ hidraw/ rpmsg/ seccomp/ \
 -			   configfs/ connector/ v4l/ trace_printk/ blackfin/ \
 +			   configfs/ connector/ v4l/ trace_printk/ \
- 			   vfio-mdev/ statx/
+ 			   vfio-mdev/ statx/ qmi/

--Sig_/Gv7Ekw1nP6fYHnKxhNq8acW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqIoEACgkQAVBC80lX
0GyJFQf+OJ9O/EAJYA/uIntYfBoQB1zofONsrQzr58GhwxSJgr0fP3JZeH1OpUqc
4p9EXcLABB8pyGkWfcPLk1KLMGqc/0503QH/WzPoadBAMLrEK7mWnBkjrYaqxJK2
gkaPguwWtxETO7V8ukz/i1D9yKPKcJc/wzyVBxffvKGl4vUUu99r8uKgI55AgRnJ
9laPmG7wPpYbX6yOhThul4MLKl7hjG8Mw2oP12B4ewpvvJZmdC1P0Or7jxUZtbNh
flrA5ZTz8W8kMW/lVmnfFaxe+yNbJ95jGIIQLyJX87wn/ZG5lP9im5iAEFcniI63
3KoBWXUtEwkbCHr/F8UxA6OCTF6/yA==
=RbU6
-----END PGP SIGNATURE-----

--Sig_/Gv7Ekw1nP6fYHnKxhNq8acW--
