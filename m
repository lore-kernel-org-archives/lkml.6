Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeFAHIa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:08:30 -0400
Received: from ozlabs.org ([203.11.71.1]:40451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFAHI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:08:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 17:08:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@lst.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Liu <liumartin@google.com>
Subject: linux-next: manual merge of the driver-core tree with the
 dma-mapping tree
Message-ID: <20180601170825.622c7084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bqEmkEVkQtASFPNJQP1KVWS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bqEmkEVkQtASFPNJQP1KVWS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the driver-core tree got a conflict in:

  include/linux/device.h

between commit:

  3d6ce86ee794 ("drivers: remove force dma flag from buses")

from the dma-mapping tree and commit:

  8c97a46af04b ("driver core: hold dev's parent lock when needed")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/device.h
index 00b6c3b42437,beca424395dd..000000000000
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@@ -98,6 -96,10 +98,8 @@@ extern void bus_remove_file(struct bus_
   * @p:		The private data of the driver core, only the driver core can
   *		touch this.
   * @lock_key:	Lock class key for use by the lock validator
 - * @force_dma:	Assume devices on this bus should be set up by dma_configu=
re()
 - * 		even if DMA capability is not explicitly described by firmware.
+  * @need_parent_lock:	When probing or removing a device on this bus, the
+  *			device core should lock the device's parent.
   *
   * A bus is a channel between the processor and one or more devices. For =
the
   * purposes of the device model, all devices are connected via a bus, eve=
n if
@@@ -138,6 -138,9 +140,8 @@@ struct bus_type=20
 =20
  	struct subsys_private *p;
  	struct lock_class_key lock_key;
+=20
 -	bool force_dma;
+ 	bool need_parent_lock;
  };
 =20
  extern int __must_check bus_register(struct bus_type *bus);

--Sig_/bqEmkEVkQtASFPNJQP1KVWS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQ8OkACgkQAVBC80lX
0GzPQgf9HVJHPGMiMzHZ4GN7GYcVZdmQkyC4TfugkLVDdZWUQBYOurF93Fvsx0za
CLvMZRjoyJOGUvoEFc3j7j79brJnMZVQahTgszzKv86qEyi5Ic0gWiayi3E+QBjj
EmpWbHBp32RGzPgbK+HACY76vFAuhNGLzfC2G8EY2uHQs72UhWBPBr85UjgTz7G0
79dkZ6OCpj/SHVtbHcT0AIg/ZBQdYpq/1X35z6Pop5f+WmfpKhgDuB+JVamfcRV/
nlAwDURS8zHF57DlGdn816UdE6MyOJhhepcCCVNBKd4LwDHeI55MR0edOaSh/Uh4
ZLg5pl2FzPl//+cXjXBCn6KEpGQrwQ==
=lDXr
-----END PGP SIGNATURE-----

--Sig_/bqEmkEVkQtASFPNJQP1KVWS--
