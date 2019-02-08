Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C8C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2562F21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BKvTH/Du"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBHBcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:32:10 -0500
Received: from ozlabs.org ([203.11.71.1]:57105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfBHBcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:32:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wd2Y2cfYz9s3q;
        Fri,  8 Feb 2019 12:32:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549589526;
        bh=EbtmWD4F5yoI/3DKUcj/i2i79L6NiF6KKXtj3XXbl8A=;
        h=Date:From:To:Cc:Subject:From;
        b=BKvTH/DuEo62298AY/24YzOxVn2/tKDH6PcJLqrSbOrCcoX5SxNFTvTGlYFMiiJIN
         fEdVBb4oc/Ws5BivW032jF3K97u3LGoSyf6ruBPGOVc2V6L7ILE3ZHZBGAbIpDp11R
         BhTblmq7negbey3kPIwi+dZTwKUB0vIL49blRXuvuILIpYD54Y/oeCoZ9Vi21HF6F3
         Ovd86c3lrEXoZNCsV9v6eAZdd1rtP2KyOjLdjDk1fP0yCRE/hV8JRdKAB//FDKJPDh
         BFOH5qyZXLnDnnmPGEAWb7KdDpkpKAGEmrOkVU8MW6vc4DBLBcWYlEh1KZTFvwlrpU
         7C6va0xhUEAPA==
Date:   Fri, 8 Feb 2019 12:32:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20190208123204.1be5d047@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hXVPOnLm3.eMKytNTgqaPIQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hXVPOnLm3.eMKytNTgqaPIQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function 'sun6i_dsi_probe':
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1053:9: warning: 'ret' may be used u=
ninitialized in this function [-Wmaybe-uninitialized]
  return ret;
         ^~~

Introduced by commit

  bb3b6fcb6849 ("sun6i: dsi: Convert to generic phy handling")

--=20
Cheers,
Stephen Rothwell

--Sig_/hXVPOnLm3.eMKytNTgqaPIQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxc3BQACgkQAVBC80lX
0GwplAf/ReukGG+lHsXsAfgLXJ1Tbr2ZvFi4psfJBOdXlxky/gFqxdbw5ZboxkCe
AtqPeDluqW3Zc/XTqFWMDNiAkEkXcKd5T4Cc041cPAy/6lDp6hDd44L6hdoMknV8
UHZ8eZreuS33+YZq2kbMZGYpUPQfIfBqtgtQM8U6tqm0+wKmqdyDGzDaZhylzx5a
TLfLncTaJGIjUFe9QIpJiWMRfViC/FDddXgWIELwgp9U27i4X6PlzLXdrpq8guTr
hI+yf0F+09AhpCxbtQVMQyvQIcc0OdtP3FcLBba8R/VUx9I2ZLMXPPQ0pKB6/ibk
TzPyjg8AWV7c7uxIE9Pq87w8QtPLqg==
=N4M2
-----END PGP SIGNATURE-----

--Sig_/hXVPOnLm3.eMKytNTgqaPIQ--
