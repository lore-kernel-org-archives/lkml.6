Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeFAB43 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:56:29 -0400
Received: from ozlabs.org ([203.11.71.1]:53737 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeFAB4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:56:25 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 11:56:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20180601115619.73a8f966@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bC5Wm7niohz05lU=S8+p8Nf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bC5Wm7niohz05lU=S8+p8Nf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  include/linux/fs.h

between commit:

  29aca8b3f7cd ("fsnotify: introduce prototype struct fsnotify_obj")

from the ext3 tree and commit:

  d9a08a9e616b ("fs: Add aio iopriority support")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/fs.h
index d1f3d572349f,482563fe549c..000000000000
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@@ -36,7 -36,7 +36,8 @@@
  #include <linux/delayed_call.h>
  #include <linux/uuid.h>
  #include <linux/errseq.h>
 +#include <linux/fsnotify_obj.h>
+ #include <linux/ioprio.h>
 =20
  #include <asm/byteorder.h>
  #include <uapi/linux/fs.h>
@@@ -1717,9 -1713,10 +1719,11 @@@ struct file_operations=20
  	int (*iterate) (struct file *, struct dir_context *);
  	int (*iterate_shared) (struct file *, struct dir_context *);
  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
+ 	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
+ 	__poll_t (*poll_mask) (struct file *, __poll_t);
  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
  	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 +	int (*pre_mmap) (struct file *, unsigned long, unsigned long);
  	int (*mmap) (struct file *, struct vm_area_struct *);
  	unsigned long mmap_supported_flags;
  	int (*open) (struct inode *, struct file *);

--Sig_/bC5Wm7niohz05lU=S8+p8Nf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQp8MACgkQAVBC80lX
0GzUgAgAjU7XasGRJdj+YD03VTFu87ln/F63NDUNlmaElNjXb0XmndzFvqQkQUKj
KAgJ+TGFMn96EIYzk26i3ArA8R29QPk52Kl1hRZ6iRRfI0YqMlii4asEWfhyxREA
G+4U5Qkfk5cS+xp/9AslDGu0ppKl98A2MXURcSSze8APiYwyDR5NweZsj6M6JBAL
KnYWgcruV3fHgZoM5Nr9A1dNHKX1y3PiMbUUI2V4zAdsGlfXN7pZsnHjiVMBsI92
mVEkGG2f9VKYjT7sGBn4InbKMFFLO60MMztgjHC6jCZeJynkBRIv3xMWiNqhoukC
Tl2PtiZbrhfW5ykIwtwE5skGTsAUWA==
=aDcS
-----END PGP SIGNATURE-----

--Sig_/bC5Wm7niohz05lU=S8+p8Nf--
