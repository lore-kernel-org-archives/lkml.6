Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748E820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ANxT/TwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748E820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIFHB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:01:56 -0400
Received: from ozlabs.org ([203.11.71.1]:39047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeIFHBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:01:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425Pdb0ZHVz9ryn;
        Thu,  6 Sep 2018 12:28:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536200931;
        bh=fCJf+yA3P7IPO18gInpNDi6GqiDSwVuDxX5rohiK+l8=;
        h=Date:From:To:Cc:Subject:From;
        b=ANxT/TwMzY8s1iYmW7GJCLob22NqeDNDVA/VyKqiEWP193gVIyp1t+0hFaPk6Ch2X
         V6DtIRwI1kYJMWJpb+rWCK4hXkrpt4pmt05Pzeq4BiDNbNMr2Q1FrZm/HqWnLpaSHZ
         dr1ymBSQBfRyxOfIrCHZ99AZqUV8Gbk1X6bFY0nLjjyPsxxfwSNNtLRf4Q/UfhhT42
         YNQrAB/VgHlVh7WwQf752yW8y7xBWtiOXaddKNiT+za4Ac8XnDZtP1K2gPyO/iHJnm
         tq+uULXyDyLP43jgfYgLz2PP60CJkwZIDuQzc8HDsRANuMWlTpJu8jzRJ0kihpqitk
         ik7w6wGbzzqig==
Date:   Thu, 6 Sep 2018 12:28:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180906122850.1fe3adb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e5hQG7+0Sa.gB8ua58fQgLC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e5hQG7+0Sa.gB8ua58fQgLC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (powerpc
allyesconfig) failed like this:

samples/mount_api/test-fsmount.c: In function 'fsopen':
samples/mount_api/test-fsmount.c:63:17: error: '__NR_fsopen' undeclared (fi=
rst use in this function); did you mean 'fsopen'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 fsopen
samples/mount_api/test-fsmount.c:63:17: note: each undeclared identifier is=
 reported only once for each function it appears in
samples/mount_api/test-fsmount.c: In function 'fsmount':
samples/mount_api/test-fsmount.c:68:17: error: '__NR_fsmount' undeclared (f=
irst use in this function); did you mean 'fsmount'?
  return syscall(__NR_fsmount, fsfd, flags, ms_flags);
                 ^~~~~~~~~~~~
                 fsmount
samples/mount_api/test-fsmount.c: In function 'fsconfig':
samples/mount_api/test-fsmount.c:74:17: error: '__NR_fsconfig' undeclared (=
first use in this function); did you mean 'fsconfig'?
  return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
                 ^~~~~~~~~~~~~
                 fsconfig
samples/mount_api/test-fsmount.c: In function 'move_mount':
samples/mount_api/test-fsmount.c:81:17: error: '__NR_move_mount' undeclared=
 (first use in this function); did you mean 'move_mount'?
  return syscall(__NR_move_mount,
                 ^~~~~~~~~~~~~~~
                 move_mount
samples/statx/test-fs-query.c: In function 'fsopen':
samples/statx/test-fs-query.c:32:17: error: '__NR_fsopen' undeclared (first=
 use in this function); did you mean 'fsopen'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 fsopen
samples/statx/test-fs-query.c:32:17: note: each undeclared identifier is re=
ported only once for each function it appears in
samples/statx/test-fs-query.c: In function 'fsinfo':
samples/statx/test-fs-query.c:38:17: error: '__NR_fsinfo' undeclared (first=
 use in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/statx/test-fsinfo.c: In function 'fsinfo':
samples/statx/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first u=
se in this function); did you mean 'fsinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 fsinfo
samples/statx/test-fsinfo.c:37:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
samples/statx/test-fsinfo.c: In function 'dump_attr_LIMITS':
samples/statx/test-fsinfo.c:180:30: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
  printf("\tmax file size: %llx\n", f->max_file_size);
                           ~~~^     ~~~~~~~~~~~~~~~~
                           %lx
samples/statx/test-fsinfo.c:181:32: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                             ~~~^
                             %lx
         f->max_uid, f->max_gid, f->max_projid);
         ~~~~~~~~~~
samples/statx/test-fsinfo.c:181:39: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                    ~~~^
                                    %lx
         f->max_uid, f->max_gid, f->max_projid);
                     ~~~~~~~~~~
samples/statx/test-fsinfo.c:181:46: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 4 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                           ~~~^
                                           %lx
         f->max_uid, f->max_gid, f->max_projid);
                                 ~~~~~~~~~~~~~
samples/statx/test-fsinfo.c: In function 'dump_attr_SUPPORTS':
samples/statx/test-fsinfo.c:197:24: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lo=
ng unsigned int'} [-Wformat=3D]
  printf("\tstx_attr=3D%llx\n", f->stx_attributes);
                     ~~~^     ~~~~~~~~~~~~~~~~~
                     %lx
samples/statx/test-statx.c: In function 'dump_statx':
samples/statx/test-statx.c:160:29: warning: format '%llx' expects argument =
of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'lon=
g unsigned int'} [-Wformat=3D]
   printf("Attributes: %016llx (", stx->stx_attributes);
                       ~~~~~~^     ~~~~~~~~~~~~~~~~~~~
                       %016lx

Caused by commits

  3e83f58bcc4f ("vfs: Add a sample program for the new mount API")
  67f668a6a913 ("vfs: syscall: Add fsinfo() to query filesystem information=
")

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 6 Sep 2018 12:15:23 +1000
Subject: [PATCH] mark samples/{mount_api,statx} as broken again

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 1c5658bc6224..daa17e9f3197 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -148,11 +148,13 @@ config SAMPLE_VFIO_MDEV_MBOCHS
=20
 config SAMPLE_STATX
 	bool "Build example extended-stat using code"
+	depends on BROKEN
 	help
 	  Build example userspace program to use the new extended-stat syscall.
=20
 config SAMPLE_MOUNT_API
 	bool "Build example code using the new mount API"
+	depends on BROKEN
 	help
 	  Build example userspace program(s) that use the new mount API.
=20
--=20
2.18.0

--=20
Cheers,
Stephen Rothwell

--Sig_/e5hQG7+0Sa.gB8ua58fQgLC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluQkOIACgkQAVBC80lX
0Gw4rgf8DHaYnRm1GqQMkZkoK5N8XbrG16RI6VsZaQlfPCo6R+YncabIdY0XJ2kY
DHhvRRwnNgOiYRdeu4qc/izYtDcbR9kawjFWt7aC0WrCRGLgOceys0yMaQZfEgKO
LyFNx9qzj3MSSDDxCXKPKirMYA9PdTj+m6cQh5nPKgCoovYmd5jWfRizIVLwMDnk
xNeJ1doSpRN0fgygSOqlfT2S7M4CGCp1MrZrKkXxQ1MZ3jj7VcjVrQSk3Qh+TJ3P
NLzxJF+wBybaoCfHhH0W7eta+mU1T+AoIpguDuKI6X0FdL3v0iaIiP56zN7HZESt
ofIeCN6QSMSZxXn+aPyi69pW5kslCQ==
=3fxj
-----END PGP SIGNATURE-----

--Sig_/e5hQG7+0Sa.gB8ua58fQgLC--
