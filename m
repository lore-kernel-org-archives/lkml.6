Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47B3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE9208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vB+qhRPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCE9208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeJBJsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:48:50 -0400
Received: from ozlabs.org ([203.11.71.1]:36095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeJBJst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:48:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PPGX672Fz9s55;
        Tue,  2 Oct 2018 13:07:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538449669;
        bh=Z5aFgl+6brQtSDxTwqUv1fvWNnW3/6UKueJTbvFY+b0=;
        h=Date:From:To:Cc:Subject:From;
        b=vB+qhRPp12z0AQYS6kLnOsk1NoczxSnsbgfn69Tbz2mi6ue841wLTlrXGgYbgJXUI
         /VdeMLDzjh5gN8motBRTKnOXM1H+eSlTE/3yoU/apvTl1PPQpZIeCOhx7WUFWu2zOF
         N1+o9AlprFU2kEnqM/mLk+2/Di4bOvx6G/bYMyZyVxsq8tJ6TBmCKXhsi5Z4myRagF
         irb+l8GcRS+LfxNRnFw37Ib66krnsDFLks+uXCiU8z+z8miGC7DhBpubBxlAU9LuWJ
         DvGHB7D0JheBz9ukdbA7vVIHoRWTVYtYSNJ3oHYSoMJIIPI0rAiwYFayauIdJHINrx
         QPFjM2hY3SZ9g==
Date:   Tue, 2 Oct 2018 13:07:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: linux-next: build warning after merge of the regulator tree
Message-ID: <20181002130748.61e33ad1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lWcejf6.y1SUup2Oj10x+Z."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lWcejf6.y1SUup2Oj10x+Z.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the regulator tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/mfd/rohm-bd718x7.c: In function 'bd718xx_i2c_probe':
drivers/mfd/rohm-bd718x7.c:101:23: warning: cast from pointer to integer of=
 different size [-Wpointer-to-int-cast]
  bd718xx->chip_type =3D (unsigned int)
                       ^

Introduced by commit

  494edd266b94 ("regulator/mfd: Support ROHM BD71847 power management IC")

--=20
Cheers,
Stephen Rothwell

--Sig_/lWcejf6.y1SUup2Oj10x+Z.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluy4QQACgkQAVBC80lX
0GwbcAf+MsjPOmu3Z29V95rFk2s9TsbOK2F3/8MvHrmZImRvckGcvjuqiXIOcT7t
hOrZF8+BZi4tMjgy0ROyoCmnod4gujEZS0vnNGxLYtl4voEdBuQyy0T9xw2iTUds
0D2cpzxXLD3sk6JhjG+HLTpfedzaAFwLglDV/Byi0Sc2XO9mi3EWcMl47ASqXj7n
imjibhXVVYEktRKjzTI+czj/Dd6XV2CCIDms2ZkrdGxLkFGu0X4elbWYxWMuPbGn
7/ZP/DAhGj21BTr7CDVKhxQTNjZ76oOZvmm2IsVLwvLo1KVd90QOLFlnZB/iOOaw
vBL4X0q3otF6nMY/LqqBhEuI5uL2Hg==
=JOgX
-----END PGP SIGNATURE-----

--Sig_/lWcejf6.y1SUup2Oj10x+Z.--
