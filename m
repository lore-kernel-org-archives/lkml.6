Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB406C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767B72174D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GdaYjYfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767B72174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbeHGNMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:12:55 -0400
Received: from ozlabs.org ([203.11.71.1]:54539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeHGNMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:12:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lBN801Jwz9ryt;
        Tue,  7 Aug 2018 20:59:03 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533639544;
        bh=bSuJScK1hoER4hVs3GGRGM0W7umPhuQv2vPhBqjO2LE=;
        h=Date:From:To:Cc:Subject:From;
        b=GdaYjYfxWz8lj3BNSBqQdQp0oJqPq+ryO3iDIkqHvxpRl6C0CBSIH7uSdpzNayxS5
         kismjQrNqb8yl84rtc62a+OPi/l0iJ2NAmgjlENKPib9YBufWs7tE3xBqPxcgcCZK+
         eQM2pKDppfHNGId/aEBIdiMSofzzHnvDGQTsXBA/8x+LTLJsLk3Ycg3MYkfs2xkMup
         dK/448LVX2a+zK3p/Eid5n+UveRrthNQEm/5MpWpwtRr9qyi3EDHZI9jf4hzw+PKpE
         bkgCPkMuZYNWRptuKGDsLHF3pBKdKIgqjpgCqcuWm4qzG+UeJJYfEsJsH7W2L7xyfG
         lNHUMVZHaKnfg==
Date:   Tue, 7 Aug 2018 20:58:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the vfs tree
Message-ID: <20180807205848.12025adc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jqTeiI2=TeK6KpzhhWzA3kN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jqTeiI2=TeK6KpzhhWzA3kN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

After merging the vfs tree, today's linux-next build (powercp
allyesconfig) failed like this (I have also included all the warnings):

samples/statx/test-fsinfo.c: In function 'fsinfo':
samples/statx/test-fsinfo.c:36:17: error: '__NR_fsinfo' undeclared (first u=
se in this function); did you mean '__NR_sysinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 __NR_sysinfo
samples/statx/test-fsinfo.c:36:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
samples/statx/test-fsinfo.c: In function 'dump_attr_LIMITS':
samples/statx/test-fsinfo.c:181:30: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64 {aka long=
 unsigned int}' [-Wformat=3D]
  printf("\tmax file size: %llx\n", f->max_file_size);
                           ~~~^     ~~~~~~~~~~~~~~~~
                           %lx
samples/statx/test-fsinfo.c:182:32: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64 {aka long=
 unsigned int}' [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                             ~~~^
                             %lx
         f->max_uid, f->max_gid, f->max_projid);
         ~~~~~~~~~~             =20
samples/statx/test-fsinfo.c:182:39: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 3 has type '__u64 {aka long=
 unsigned int}' [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                    ~~~^
                                    %lx
         f->max_uid, f->max_gid, f->max_projid);
                     ~~~~~~~~~~        =20
samples/statx/test-fsinfo.c:182:46: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 4 has type '__u64 {aka long=
 unsigned int}' [-Wformat=3D]
  printf("\tmax ids      : u=3D%llx g=3D%llx p=3D%llx\n",
                                           ~~~^
                                           %lx
         f->max_uid, f->max_gid, f->max_projid);
                                 ~~~~~~~~~~~~~=20
samples/statx/test-fsinfo.c: In function 'dump_attr_SUPPORTS':
samples/statx/test-fsinfo.c:198:24: warning: format '%llx' expects argument=
 of type 'long long unsigned int', but argument 2 has type '__u64 {aka long=
 unsigned int}' [-Wformat=3D]
  printf("\tstx_attr=3D%llx\n", f->stx_attributes);
                     ~~~^     ~~~~~~~~~~~~~~~~~
                     %lx
samples/statx/test-fsinfo.c: In function 'fsinfo':
samples/statx/test-fsinfo.c:37:1: warning: control reaches end of non-void =
function [-Wreturn-type]
 }
 ^
scripts/Makefile.host:90: recipe for target 'samples/statx/test-fsinfo' fai=
led
samples/statx/test-statx.c: In function 'dump_statx':
samples/statx/test-statx.c:160:29: warning: format '%llx' expects argument =
of type 'long long unsigned int', but argument 2 has type '__u64 {aka long =
unsigned int}' [-Wformat=3D]
   printf("Attributes: %016llx (", stx->stx_attributes);
                       ~~~~~~^     ~~~~~~~~~~~~~~~~~~~
                       %016lx
samples/statx/test-fs-query.c: In function 'fsopen':
samples/statx/test-fs-query.c:32:17: error: '__NR_fsopen' undeclared (first=
 use in this function); did you mean '__NR_open'?
  return syscall(__NR_fsopen, fs_name, flags);
                 ^~~~~~~~~~~
                 __NR_open
samples/statx/test-fs-query.c:32:17: note: each undeclared identifier is re=
ported only once for each function it appears in
samples/statx/test-fs-query.c: In function 'fsinfo':
samples/statx/test-fs-query.c:38:17: error: '__NR_fsinfo' undeclared (first=
 use in this function); did you mean '__NR_sysinfo'?
  return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
                 ^~~~~~~~~~~
                 __NR_sysinfo
samples/statx/test-fs-query.c: In function 'fsopen':
samples/statx/test-fs-query.c:33:1: warning: control reaches end of non-voi=
d function [-Wreturn-type]
 }
 ^
samples/statx/test-fs-query.c: In function 'fsinfo':
samples/statx/test-fs-query.c:39:1: warning: control reaches end of non-voi=
d function [-Wreturn-type]
 }
 ^

Caused by commit

  ba5214f7f40c ("vfs: Implement parameter value retrieval with fsinfo()")

which enabled CONFIG_SAMPLE_STATX.  I have disabled that again.  I assume
that problem is that these syscalls are not yet wired up on PowerPC ...

--=20
Cheers,
Stephen Rothwell

--Sig_/jqTeiI2=TeK6KpzhhWzA3kN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltpe2kACgkQAVBC80lX
0GyGPgf/R4ja5F8LGTYELmOXxlRDyY/VUD7b6WOFPua4pVUPGO7j1/XkWJmdXnfM
hnZ8iWnknjqZ/5JhNRFzoIzTrRiQOraFx0Np1aNwMu5r/MBgIqafOtinvjMC2G/U
eiij5ZLorLGVMMGDcqmsaBbYpBWi6ERTPMJr2uQTjO3dPgHnuLFjMp1s2HX+bLoZ
0K6nD595xvGXSfMSZ2QvnOV+tv2qOIF3CS/5eANMSK9BvVwwsUW1OgZMB+JU+yaj
zTX8BgptzD9mTdubGZ3+8HrRCm2cUq6ua6THhsbv5KIIIvmKDlBKij9Iqn6j0JI/
RNpwWN37x6aP2OUBUpF0uCbWN+b0ug==
=BcCI
-----END PGP SIGNATURE-----

--Sig_/jqTeiI2=TeK6KpzhhWzA3kN--
