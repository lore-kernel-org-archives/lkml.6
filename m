Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EE0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37698253B5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AfW8RzDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37698253B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeFYBS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:18:57 -0400
Received: from ozlabs.org ([203.11.71.1]:33865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752288AbeFYBSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:18:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41DWXX0Tncz9s2t;
        Mon, 25 Jun 2018 11:18:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529889533;
        bh=/pMPHrS+SPoPLbYbQyjqPRoyD+SeQpY5Ef59lUdH0Po=;
        h=Date:From:To:Cc:Subject:From;
        b=AfW8RzDYrKi3Xyhr+MX7p5EYXtyw9qy5uPNw8K2k1D3zlDBnq7VxQ484NYveYjS1w
         Qwjo5VL64EY9T5sMIb/vsgTQm3V0NgWCiqzMn13ZT/PkTBhw4k/KRK/t1Zf6YI2ul8
         9JBdulebTEFSKXUWGHM9PQX6dRpA8fHBP1wa2DVc41/qPHZMtIN2PViTz+PBzg7CKt
         KrBehT4v0bvVEXuMmJn2MGOdvDEv7PvGEWMiBYQm5Uv86HjYV4GRQMZk4l1fCxF8dS
         P5G9dvoT3lxD4STKApPlXTN3UlJUICqWEtdRJZRG2rxXqyz57eP/vP0lCA/CyLVlE0
         WyHAMkLFJJtqw==
Date:   Mon, 25 Jun 2018 11:18:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: linux-next: build failure after merging the drm tree
Message-ID: <20180625111850.63faef0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WLb.geg72bz9i5VfY541+6s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WLb.geg72bz9i5VfY541+6s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

samples/vfio-mdev/mbochs.c:827:3: error: 'struct dma_buf_ops' has no member=
 named 'map_atomic'
  .map_atomic   =3D mbochs_kmap_atomic_dmabuf,
   ^~~~~~~~~~
samples/vfio-mdev/mbochs.c:827:18: error: positional initialization of fiel=
d in 'struct' declared with 'designated_init' attribute [-Werror=3Ddesignat=
ed-init]
  .map_atomic   =3D mbochs_kmap_atomic_dmabuf,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
samples/vfio-mdev/mbochs.c:827:18: note: (near initialization for 'mbochs_d=
mabuf_ops')
samples/vfio-mdev/mbochs.c:827:18: error: initialization from incompatible =
pointer type [-Werror=3Dincompatible-pointer-types]
samples/vfio-mdev/mbochs.c:827:18: note: (near initialization for 'mbochs_d=
mabuf_ops.unmap')

Caused by commit

  f664a5269542 ("dma-buf: remove kmap_atomic interface")

interacting with commit

  a5e6e6505f38 ("sample: vfio bochs vbe display (host device for bochs-drm)=
")

from Linus' tree (v4.18-rc1).

I added the following just to disable the sample code until it can
be repaired.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 25 Jun 2018 11:11:38 +1000
Subject: [PATCH] sample: disable the VFIO mdpy example mediated device samp=
le code

it was broken by the removal of the dmap-buf kmap_atomic interface.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 samples/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index bd133efc1a56..84bf618ad628 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -135,6 +135,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
 config SAMPLE_VFIO_MDEV_MBOCHS
 	tristate "Build VFIO mdpy example mediated device sample code -- loadable=
 modules only"
 	depends on VFIO_MDEV_DEVICE && m
+	depends on BROKEN
 	select DMA_SHARED_BUFFER
 	help
 	  Build a virtual display sample driver for use as a VFIO
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/WLb.geg72bz9i5VfY541+6s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlswQvoACgkQAVBC80lX
0GzRkwf/cwZJX+DiR/pNP2SxV4eJJ0BkGE3n81a19SNLhDIQkgtQZtb1Qw9DRjwD
xpNmtzyA9QB0SSv4mBQhkiypVvDyC7rdDDT1jW4UZGc4lC0QGHGI3UJvVSiQRMM9
twlCJE8AlqrP+1OFYFExq/XaRpojn7D2sdR+yhsGDBFmG1J/LerO1U2opk9jSoP7
unjEiUKm9l7K9xaG2NRWgp8gZGzeoNLPQU794DtWK/BQwRpyQIVFh3jtTKSTqn2F
U2agrBriz58YFGiigGYVSxg+BUgBky/bg5Y5wDgy24dFeW7V2RzQ0srKagIwlmoC
X5ks+fbfBYDRsYcJVzBtCgKw9N3GQA==
=uPil
-----END PGP SIGNATURE-----

--Sig_/WLb.geg72bz9i5VfY541+6s--
