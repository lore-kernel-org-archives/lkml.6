Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A771C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CED214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DiBZEKbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CED214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJQLQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:16:40 -0400
Received: from ozlabs.org ([203.11.71.1]:41419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbeJQLQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:16:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ZcvD10GKz9s8T;
        Wed, 17 Oct 2018 14:23:03 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539746586;
        bh=kVTjVNkCUs8Z3hsRS2WQCbVYefnOXos9h09B4LRhlGQ=;
        h=Date:From:To:Cc:Subject:From;
        b=DiBZEKbMJp2GA3Hoc7IG3angOJCNfjd3A+jkXh2ExIAdkt229IqSJ/+cSS3IDTT2N
         Oa34PlWEE6sF51e8e1gCF85jLbYIb7AN5GgX8+8fGWR+v/wlTpiFM0/gZ+GSiAO01I
         gStZALP6wXeiRcwsR/2BNqsGjEwp/0wQ5fQQAwaOf8W9uSEvLpNKV0/DsD2SxOKlPJ
         jV8OZ7arS0MXRRGO6IFnrxwCVoVYzwaRL4tQC1fbf5DhlQqOZPU9UXpXrbwK3Kk74z
         2Ge7Cv9lJ39YR6I81hOhxxHoY+9MUqWngm2HJWPAmBYJ9K0QeUlPdAe/bA8nVWErq8
         iuMcEdBO628jA==
Date:   Wed, 17 Oct 2018 14:22:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the char-misc tree with the drm tree
Message-ID: <20181017142257.5002799b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u6tzD0qr8bKobG/tey.t=0x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u6tzD0qr8bKobG/tey.t=0x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  MAINTAINERS

between commit:

  fbb0de795078 ("Add udmabuf misc device")

from the drm tree and commit:

  9793c1fd1775 ("MAINTAINERS: Clarify UIO vs UIOVEC maintainer")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 7d70a6c5eeee,a38c13c7da9a..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -15594,14 -15365,12 +15595,20 @@@ F:	arch/x86/um
  F:	fs/hostfs/
  F:	fs/hppfs/
 =20
+ USERSPACE COPYIN/COPYOUT (UIOVEC)
+ M:	Alexander Viro <viro@zeniv.linux.org.uk>
+ S:	Maintained
+ F:	lib/iov_iter.c
+ F:	include/linux/uio.h
+=20
 +USERSPACE DMA BUFFER DRIVER
 +M:	Gerd Hoffmann <kraxel@redhat.com>
 +S:	Maintained
 +L:	dri-devel@lists.freedesktop.org
 +F:	drivers/dma-buf/udmabuf.c
 +F:	include/uapi/linux/udmabuf.h
 +T:	git git://anongit.freedesktop.org/drm/drm-misc
 +
  USERSPACE I/O (UIO)
  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  S:	Maintained

--Sig_/u6tzD0qr8bKobG/tey.t=0x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvGqxEACgkQAVBC80lX
0Gw6iQf/cDYDE0VokyqOGGwFDaVpEMwzmWcDAm/nI3Df0a43ROCRebxEFJkBCE/X
XR9ERvs44oXOBvMIC3MVYBXkZJVb5jhjgcXQtNoUPjVpEwQiL5rIQhZ8JQDQC7lO
7BLGYi08A92x0r+kBd4gB+IxbczbuMeONVhBivfEprDlmxXB3xeykAkDb2I98V7m
706r1WuhI1p6TkgGzKOS6g68JVXBNpGFc9Y8kkeY3hFO+hbKijvdmdoVenqULSYW
u0ErCgxjSqntIu1s6mzltEvjTh4FV75PJZ1rtOriDGY3mcXzli2uicehIAvDxkND
rWwFKXt0AGW/4/h1PMP1HE3gXjE5DQ==
=bMUP
-----END PGP SIGNATURE-----

--Sig_/u6tzD0qr8bKobG/tey.t=0x--
