Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0756FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2220873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZAhYpNyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeG3Htv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:49:51 -0400
Received: from ozlabs.org ([203.11.71.1]:40181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeG3Htv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:49:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41f8Tf5X9xz9ryl;
        Mon, 30 Jul 2018 16:16:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532931385;
        bh=tMcF9GR/fCJLwMRPNRHg0dlCyUnKv39qrgEgzB2isHk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZAhYpNygo+dPZc+3YHAaOKIYnqmwVbmUhB2kwe0arnNDIkMxJcqMNU1s6AxZRCBqN
         JNRvKef++ZnYaW1dDn8OcKCiW+UD4TJ3c6Zl+Oyk/6uxx41lBX4XbCAuQN4TV2rOWG
         ofDf1nI4EWTobOX8WQzPYAwHZ+BSqJwj9Yg5vk+Qc+QBiAcLMyvz4jBd2ZFdSbuh9z
         AfQM1G/AgrlUqOTjfcAmQHwoGTl/ohiEZ+9ZnzZ5s9re9EL6qhJuGc/FoW5L6GdE3k
         IVPBgQ9q3hOZQX4SOUqu+gPJAoKZ3HLiBMsBKT975FudK5pfRG8XxSS9fwUaBqO2k8
         QroTo3dfc9VDw==
Date:   Mon, 30 Jul 2018 16:16:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: linux-next: build failure after merge of the staging tree
Message-ID: <20180730161622.3837cb15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5n94owRThEz7nT8UOMe.cta"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5n94owRThEz7nT8UOMe.cta
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/staging/erofs/super.c: In function 'erofs_read_super':
drivers/staging/erofs/super.c:343:17: error: 'MS_RDONLY' undeclared (first =
use in this function); did you mean 'IS_RDONLY'?
  sb->s_flags |=3D MS_RDONLY | MS_NOATIME;
                 ^~~~~~~~~
                 IS_RDONLY
drivers/staging/erofs/super.c:343:17: note: each undeclared identifier is r=
eported only once for each function it appears in
drivers/staging/erofs/super.c:343:29: error: 'MS_NOATIME' undeclared (first=
 use in this function); did you mean 'S_NOATIME'?
  sb->s_flags |=3D MS_RDONLY | MS_NOATIME;
                             ^~~~~~~~~~
                             S_NOATIME
drivers/staging/erofs/super.c: In function 'erofs_mount':
drivers/staging/erofs/super.c:501:10: warning: passing argument 5 of 'mount=
_bdev' makes integer from pointer without a cast [-Wint-conversion]
   &priv, erofs_fill_super);
          ^~~~~~~~~~~~~~~~
In file included from include/linux/buffer_head.h:12:0,
                 from drivers/staging/erofs/super.c:14:
include/linux/fs.h:2151:23: note: expected 'size_t {aka long unsigned int}'=
 but argument is of type 'int (*)(struct super_block *, void *, int)'
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
                       ^~~~~~~~~~
drivers/staging/erofs/super.c:500:9: error: too few arguments to function '=
mount_bdev'
  return mount_bdev(fs_type, flags, dev_name,
         ^~~~~~~~~~
In file included from include/linux/buffer_head.h:12:0,
                 from drivers/staging/erofs/super.c:14:
include/linux/fs.h:2151:23: note: declared here
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
                       ^~~~~~~~~~
drivers/staging/erofs/super.c: At top level:
drivers/staging/erofs/super.c:518:20: error: initialization from incompatib=
le pointer type [-Werror=3Dincompatible-pointer-types]
  .mount          =3D erofs_mount,
                    ^~~~~~~~~~~
drivers/staging/erofs/super.c:518:20: note: (near initialization for 'erofs=
_fs_type.mount')
drivers/staging/erofs/super.c: In function 'erofs_remount':
drivers/staging/erofs/super.c:630:12: error: 'MS_RDONLY' undeclared (first =
use in this function); did you mean 'IS_RDONLY'?
  *flags |=3D MS_RDONLY;
            ^~~~~~~~~
            IS_RDONLY
drivers/staging/erofs/super.c: At top level:
drivers/staging/erofs/super.c:640:16: error: initialization from incompatib=
le pointer type [-Werror=3Dincompatible-pointer-types]
  .remount_fs =3D erofs_remount,
                ^~~~~~~~~~~~~

Caused by various commits creating erofs in the staging tree interacting
with various commits redoing the mount infrastructure in the vfs tree.

I have disabed CONFIG_EROFS_FS for now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Jul 2018 16:10:57 +1000
Subject: [PATCH] disable erofs for now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/staging/erofs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 663b755bf2fb..b37d994aa687 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	depends on BROKEN
 	help
 	  EROFS(Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/5n94owRThEz7nT8UOMe.cta
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlterTYACgkQAVBC80lX
0GxQzwf+JC+z/NHuK14NwbLp0qXCrTRMFs2GxQG7Hvh37VoJfYuPMmHJU83geggn
G6QxXuTsXABXhDFTrKVcH81fKcbbOTwK1qP6nsf2SMbUHYNvP9a91FZao826zzK7
Sc/bLchg7roxlSZ2PK2dbM61kVoCGYMCakqAhLIwWXCm8GleTSeo29tC2xZqdTVV
bh3laUZcv+jY0YB/gDPBvdS2tgsvkc7FLHWOmo49A47KoUsAR8UmDP6/J9wdxRNn
kQ94T9ljavixr37mi7Zw7pxvfI9mBIhDY0Hv7C4CffAsNCsFxwekZxPQfpRTveT+
70XZddCKsMW7lBMUnayCp42xUc86pQ==
=01Me
-----END PGP SIGNATURE-----

--Sig_/5n94owRThEz7nT8UOMe.cta--
