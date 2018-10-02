Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B82AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16C52089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F+jS6YVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16C52089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJBNLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:11:04 -0400
Received: from ozlabs.org ([203.11.71.1]:54555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeJBNLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:11:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PTl82D1Vz9s7T;
        Tue,  2 Oct 2018 16:29:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538461765;
        bh=jsyACEGVzhjRjhVfFFGd0JsnLfkJiiUx6BzLSp6OgaE=;
        h=Date:From:To:Cc:Subject:From;
        b=F+jS6YVebohvz7ExKNq1Sbv0Yt55apeHuFctHa9hY+DNhZ9seENvJzpcbt4O34BR9
         IXkk5c7mwh/VxXOcI4/A7+XMSCxdbxm7VRgVmuyO21eiI6FtDRfdzILJlLNyb4+ti0
         lA5FRbfB0dgOOH53zMy7JuRyi0oUdHFBTWC+Ab2h50rGakehGzPoTjtdW4WtQt1zvG
         ybQXf/pEVj++pNOK0CsBSH2fXkJBhGTRYws47hW+lVkoQWiWaIP39N02n8K8pkBT3r
         dzlptrFDSnItALnaDBBf2zl7BW7iQCT1F+QVKozsHZHHokHycI1Pe/Jczj9HoqUrpf
         emPxPXpoQtUpw==
Date:   Tue, 2 Oct 2018 16:29:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Walker <dwalker@fifo99.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the cisco tree with the vfs tree
Message-ID: <20181002162923.13f3f8b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DGnAiWvvdTQppxHM424be+R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DGnAiWvvdTQppxHM424be+R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Today's linux-next merge of the cisco tree got a conflict in:

  arch/x86/kernel/setup.c

between commit:

  dcf8001d292b ("vfs: Suppress MS_* flag defs within the kernel unless expl=
icitly enabled")

from the vfs tree and commit:

  2c070709ea75 ("This updates the x86 code to use the CONFIG_GENERIC_CMDLIN=
E")

from the cisco tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/setup.c
index e493202bf265,ee109f490b22..000000000000
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@@ -51,7 -51,7 +51,8 @@@
  #include <linux/kvm_para.h>
  #include <linux/dma-contiguous.h>
  #include <xen/xen.h>
 +#include <uapi/linux/mount.h>
+ #include <linux/cmdline.h>
 =20
  #include <linux/errno.h>
  #include <linux/kernel.h>

--Sig_/DGnAiWvvdTQppxHM424be+R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzEEMACgkQAVBC80lX
0GxkxQf9EE7kzod4YuuKGXoIWpIs4EMSYXo2/oGkQNSYWpA97vD5Dj3RuJ+nn710
eULcFfq/pHyYntMmfOCW5Zf+DEDngxmL7TbMDbGKGuPE0CQfhKdyOhuFo/C4EUCp
17HWd4Pw9nwbvB9qp84yfQ65XMduq+c8l4g20GkYcPHHZJgP2eS7e80xcRsINDpi
duVYvewtqf6QDnjRinJMX9juQyrXJHBSAme4LQ484j2SDM5METom44+WAgTwd7mT
tzB7NrGTXlmdvObtASo0bVezMZa+MwIZWulSXfXEzaDn7PPuBRNfbSRi8CQ4/42o
pINYMcaGKOOGwz2XIwh+9TDIVkpgzA==
=FNcI
-----END PGP SIGNATURE-----

--Sig_/DGnAiWvvdTQppxHM424be+R--
