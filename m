Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE4EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637F520663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b8HeXG6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfBGUjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:39:47 -0500
Received: from ozlabs.org ([203.11.71.1]:53955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfBGUjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:39:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wVYD20Vsz9sDr;
        Fri,  8 Feb 2019 07:39:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549571984;
        bh=V64LPX5iXjx7YvLwwFcD0tMn41eYvxkY6rUoBWYjAmI=;
        h=Date:From:To:Cc:Subject:From;
        b=b8HeXG6+bJ11CmXR28gprB7fFBpJRS1f7BkYmpmwaot7jc57dxne/MmrHPwfDCYgv
         0Z514raCNP6+5sFb3IHVWj6Kp3GU6mcIJR1vp4jUl912v/afQ6QV6HDx/Jrv/lcb2n
         HpkvMovYRQXaxRNsLnhGk8wOH3dHD0CmfVxaDlj2jwpXBKEFA9ESXKF1GNBd4ImJxq
         BW1sHf0lxrFmTvH6rsE1TWZMeCrXJ0aUz96I3HOiascRrEapT423zcNgV15KLmO3Ab
         0PTQwoLd/RjVBi3NXgaijLWnLgyBacUUwkpOUAbnCtd5SIa+JU0WM8db5mLA6IiSSr
         ySivj+tF/SMyw==
Date:   Fri, 8 Feb 2019 07:39:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "Lucas A. M. =?UTF-8?B?TWFnYWxow6Nlcw==?=" <lucmaga@gmail.com>
Subject: linux-next: Fixes tags need some work in the v4l-dvb tree
Message-ID: <20190208073943.0317d5ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aTJTitUrGHEGzsnvTdXsFnI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aTJTitUrGHEGzsnvTdXsFnI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

In commit

  c2d88e7d66f9 ("media: vb2: Fix buf_out_validate documentation")

Fixes tag

  Fixes: 28d77c21cb ("media: vb2: add buf_out_validate callback")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  adc589d2a208 ("media: vimc: Add vimc-streamer for stream control")

Fixes tag

  Fixes: f2fe89061d797 ("vimc: Virtual Media Controller core, capture

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/aTJTitUrGHEGzsnvTdXsFnI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxcl48ACgkQAVBC80lX
0GysvAgAgu5WnSrelhXf2Jf0WHsXlx43cgzfSZDH1iYsR0setTzVpRU+5sbrBBF1
py3SaLAJv9ll8cwCWqhQ9gk1+pQ5fec4RXBNDYfjiropM1hjt6y83j6cEnZlrmNM
zpcR8jVZ8fGfdGnrdL3j30rP/dUPSXDC1DsWBW3vic1piS7GZlovO1SscPYVIWsm
aEXvUXAgHOVRRgUFzRHaqSvb2vdyiWOB8l47/eqQGQfha5qf3KXveiYZ3Y0BauoL
bhYozUSjRaxFnAIFmtjwEVDVaFUtV4QoO36M+CVWqeiaU3Bka5BqGeceV18VBkGS
IL50vZESus3c308x8PGALN61BbT9uQ==
=mNyq
-----END PGP SIGNATURE-----

--Sig_/aTJTitUrGHEGzsnvTdXsFnI--
