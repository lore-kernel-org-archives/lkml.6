Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFFEC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5F206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dEOG42dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeIJI1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:27:42 -0400
Received: from ozlabs.org ([203.11.71.1]:53005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeIJI1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:27:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 427twx5pfHz9s3x;
        Mon, 10 Sep 2018 13:35:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536550545;
        bh=cmV0Gra1G8SuTB1WUm6C8Ie2OLqImLDz8Af6VJbLHkc=;
        h=Date:From:To:Cc:Subject:From;
        b=dEOG42ddH41wEO4C3yoU4x6xh7Mz9mINiYdqN1sp4/MWcD9aVamFBV0i4OdcoseVz
         U2mP1qypjuKu3bigpyEq652ZmuVLCa8oBcDfFcA7mekUzkD2PdaZ+nMFy7shB1+oKN
         ieTqvrJn1fe4CKYIZ/pspSx44zFafNWrMlP3j3kPBbE4PDZU5IpvSyf8IVkL+dFm5v
         +3px2c/VD9MPC8818CJBc+cYkN5qGn57wLkMOcZbHyDGCOqavew2/fubSuAE45KspR
         Kwso3uWBVhw0XB5uevXjTQzd7WeTZl2Dl8tKOeAlgaXfGpYqAM32kROYcUwO4J90MM
         01vUIbZxEbXUg==
Date:   Mon, 10 Sep 2018 13:35:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180910133525.28c5dd20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HlhqzU84DhyvSzcdPActBVD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HlhqzU84DhyvSzcdPActBVD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (powerpc
allyesconfig) failed like this:

samples/vfs/test-fsinfo.c: In function 'fsinfo':
samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first use=
 in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/vfs/test-fsinfo.c:37:17: note: each undeclared identifier is report=
ed only once for each function it appears in
samples/vfs/test-fsinfo.c: In function 'dump_attr_LIMITS':
samples/vfs/test-fsinfo.c:180:30: warning: format '%llx' expects argument o=
f type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long=
 unsigned int'} [-Wformat=3D]
  printf("\tmax file size: %llx\n", f->max_file_size);
                           ~~~^     ~~~~~~~~~~~~~~~~
                           %lx
samples/vfs/test-fsinfo.c:181:32: warning: format '%llx' expects argument o=
f type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long=
 unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                             ~~~^
                             %lx
         f->max_uid, f->max_gid, f->max_projid);
         ~~~~~~~~~~
samples/vfs/test-fsinfo.c:181:39: warning: format '%llx' expects argument o=
f type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long=
 unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                    ~~~^
                                    %lx
         f->max_uid, f->max_gid, f->max_projid);
                     ~~~~~~~~~~
samples/vfs/test-fsinfo.c:181:46: warning: format '%llx' expects argument o=
f type 'long long unsigned int', but argument 4 has type '__u64' {aka 'long=
 unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                           ~~~^
                                           %lx
         f->max_uid, f->max_gid, f->max_projid);
                                 ~~~~~~~~~~~~~
samples/vfs/test-fsinfo.c: In function 'dump_attr_SUPPORTS':
samples/vfs/test-fsinfo.c:197:24: warning: format '%llx' expects argument o=
f type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long=
 unsigned int'} [-Wformat=3D]
  printf("\tstx_attr=3D%llx\n", f->stx_attributes);
                     ~~~^     ~~~~~~~~~~~~~~~~~
                     %lx
samples/vfs/test-fsmount.c: In function 'fsopen':
samples/vfs/test-fsmount.c:63:17: error: '__NR_fsopen' undeclared (first us=
e in this function); did you mean 'fsopen'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 fsopen
samples/vfs/test-fsmount.c:63:17: note: each undeclared identifier is repor=
ted only once for each function it appears in
samples/vfs/test-fsmount.c: In function 'fsmount':
samples/vfs/test-fsmount.c:68:17: error: '__NR_fsmount' undeclared (first u=
se in this function); did you mean 'fsmount'?
  return syscall(__NR_fsmount, fsfd, flags, ms_flags);
                 ^~~~~~~~~~~~
                 fsmount
samples/vfs/test-fsmount.c: In function 'fsconfig':
samples/vfs/test-fsmount.c:74:17: error: '__NR_fsconfig' undeclared (first =
use in this function); did you mean 'fsconfig'?
  return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
                 ^~~~~~~~~~~~~
                 fsconfig
samples/vfs/test-fsmount.c: In function 'move_mount':
samples/vfs/test-fsmount.c:81:17: error: '__NR_move_mount' undeclared (firs=
t use in this function); did you mean 'move_mount'?
  return syscall(__NR_move_mount,
                 ^~~~~~~~~~~~~~~
                 move_mount
samples/vfs/test-fs-query.c: In function 'fsopen':
samples/vfs/test-fs-query.c:32:17: error: '__NR_fsopen' undeclared (first u=
se in this function); did you mean 'fsopen'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 fsopen
samples/vfs/test-fs-query.c:32:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
samples/vfs/test-fs-query.c: In function 'fsinfo':
samples/vfs/test-fs-query.c:38:17: error: '__NR_fsinfo' undeclared (first u=
se in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/vfs/test-statx.c: In function 'dump_statx':
samples/vfs/test-statx.c:160:29: warning: format '%llx' expects argument of=
 type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long =
unsigned int'} [-Wformat=3D]
   printf("Attributes: %016llx (", stx->stx_attributes);
                       ~~~~~~^     ~~~~~~~~~~~~~~~~~~~
                       %016lx

Caused by commits

  2615362dc9ce ("vfs: Add a sample program for the new mount API")
  e9078278ec11 ("vfs: syscall: Add fsinfo() to query filesystem information=
")

The directory name has changed, but the errors persist!

I have applied this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 10 Sep 2018 13:19:20 +1000
Subject: [PATCH] disable building the VFS sample programs

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 0431af2589ac..c8823d9d97db 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -148,6 +148,7 @@ config SAMPLE_VFIO_MDEV_MBOCHS
=20
 config SAMPLE_VFS
 	bool "Build example programs that use new VFS system calls"
+	depends on BROKEN
 	help
 	  Build example userspace programs that use new VFS system calls such
 	  as mount API and statx()
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/HlhqzU84DhyvSzcdPActBVD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluV5n0ACgkQAVBC80lX
0GxNSwf+KuutIU/V8fjQO7mk8/TNr7r9YYdX0S8/aW6KqsTqNqyJLjgcaeiwJQYy
SKXw672EvvExKQH82rwrkS0tMw0rJFZYold2ySpbakjYUTDLRVtZ+Ftd4S21nHuf
ODQSojAp6Yb2FRBPSYVOwZxHQw247dQ9yCDoL1R4ghOnek1G+3PRMMXF/PpDifaq
1z+QdodiAgXU6A3zhpZglLGXS6pscAsf+zfZrDxGCzsiueSqfqXXTa8KtneSypgW
+DUpzqfxzuIsKvthEB2vD96iDnpTLpecKyWRu51zs267GZEC4gKUQ0gPh1TunLdW
ICsr/JDwPIIpCFy9YHSDsu/QsVlN4w==
=leGP
-----END PGP SIGNATURE-----

--Sig_/HlhqzU84DhyvSzcdPActBVD--
