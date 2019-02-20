Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25977C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DC3218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a5pYyngH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfBTX65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:58:57 -0500
Received: from ozlabs.org ([203.11.71.1]:59615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTX6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:58:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444ZLz6KG6z9s4Y;
        Thu, 21 Feb 2019 10:58:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550707133;
        bh=D3A/fWRja260UBY+fluyTtxW+P5qQS/+4GLWgUrHwuQ=;
        h=Date:From:To:Cc:Subject:From;
        b=a5pYyngHnKXZdppcso4g3YlFovdbeppoqw59J5JFrPpqveaGiySz1qeloFAZbeLTO
         SiZorH1HJfITQxSGy98okE15uLbYa/DnVhu1KZyK11gAFSVpEA7kh5T5k4isGW51YX
         kKVvPVCMO+cmKdk/y53G5OD2QPirNnfucab/2/YlY6h+RWGj+54Xa1BAZW71SCQ8xz
         BK7MasAXyWzjPiSEHmRmuHbDRT0lB0CN/cd+JSQ5kDSagoDDYPIc1o2HOgpW5ec7JB
         OeTZMixYZivyVSImUhEtWgWq2TATdMsIFFQYxEgJhuSUAQsBR+dsy/jbQVO6rAnvqw
         S4wKHZquylmEg==
Date:   Thu, 21 Feb 2019 10:58:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: manual merge of the v4l-dvb tree with the dma-mapping
 tree
Message-ID: <20190221105851.5b0a9b20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9qZbnT/+rkMau5rPE3RXGXh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9qZbnT/+rkMau5rPE3RXGXh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c

between commit:

  82c5de0ab8db ("dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag")

from the dma-mapping tree and commit:

  43a445f188e1 ("media: sh_mobile_ceu_camera: remove obsolete soc_camera dr=
iver")

from the v4l-dvb tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/9qZbnT/+rkMau5rPE3RXGXh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxt6bsACgkQAVBC80lX
0GxEcQf/d2kq/a1lx+IVPNdHYa1ZDF2Wl4/WoHlZx14OQ0cU4mmawzvzfhmYqulI
bfF2LwPEbmJ3f+yOns9APDyWZCREcjfQxSKX5g0JbRLkoK2ZZjVQtglexOAF/+0G
D4QL6H3E76oqzhtZ32G3VUJt1KqfU+BaNp+OMjHzclQ39iYFlUuFrKCtwb/tl9H7
+BgagX8wp80SBMxHS7sntcm8g8Q/AuyLihitEWe7+AI6sGEK3EBAh9h3WSn8VRRa
PbfKdKLGJJtKRE9QDeZCyCOva/Vj/SxaaLzVGBL0p51MeQ+XuYkBERZvgKOTp4p3
sFpmw+YoG0qCS/GdkabExDrmpyzuEw==
=NlNm
-----END PGP SIGNATURE-----

--Sig_/9qZbnT/+rkMau5rPE3RXGXh--
