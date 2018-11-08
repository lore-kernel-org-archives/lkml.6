Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JboGCEOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCB520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKHMGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:06:24 -0500
Received: from ozlabs.org ([203.11.71.1]:41121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeKHMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:06:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42r6lS2xdtz9sC7;
        Thu,  8 Nov 2018 13:33:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541644389;
        bh=Uhw/JuKStGDH/wqjzLBelhfQ3ZRHYZTYLokFoFpilU4=;
        h=Date:From:To:Cc:Subject:From;
        b=JboGCEOL9Z7nb5vmNlorl1tPORIzVbShOiQ7rkfsoFVAiNKsB2X56XOhWgQKOlre0
         sY2Z6QGN2wD9RrkZYr9kcTGazPiEWfz9ykk1gi6GgyFtzQHl1ALmst5EgQ1BYMWqA7
         o6tR71agHPR77Vf0kHlq/IM+y48fiYaNTXBTMUPQ+2HYtiFtjk6lELFtpHMgC6sWth
         1+aragLYv6VZO3pFqDsY1brZSLPNhVoy2BtHdZVjag3fHM+TuDxcQzfHqbcJ9dXBwy
         HWVwrEkdXCAAJlYR0MSOhN1uyj3Pu/7yX5l0Z2SW7s/W+rM1v+Uh5rkOO3D08WZT2Q
         SbWQ7pkvwcdzg==
Date:   Thu, 8 Nov 2018 13:33:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ioannis Valasakis <code@wizofe.uk>
Subject: linux-next: build warning after merge of the staging tree
Message-ID: <20181108133307.5cca74cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SlwN=.sg9eZoil28NjwGF1V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SlwN=.sg9eZoil28NjwGF1V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the staging tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/printk.h:336,
                 from include/linux/kernel.h:14,
                 from include/linux/clk.h:16,
                 from drivers/staging/media/tegra-vde/tegra-vde.c:12:
drivers/staging/media/tegra-vde/tegra-vde.c: In function 'tegra_vde_setup_i=
ram_tables':
drivers/staging/media/tegra-vde/tegra-vde.c:265:5: warning: format '%d' exp=
ects argument of type 'int', but argument 6 has type 'long unsigned int' [-=
Wformat=3D]
     "\tFrame %d: frame_num =3D %d B_frame =3D %d\n",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic=
_dev_dbg'
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                       ^~~
include/linux/device.h:1463:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
drivers/staging/media/tegra-vde/tegra-vde.c:264:4: note: in expansion of ma=
cro 'dev_dbg'
    dev_dbg(vde->miscdev.parent,
    ^~~~~~~

Introduced by commit

  42e764d05712 ("staging: tegravde: replace bit assignment with macro")

--=20
Cheers,
Stephen Rothwell

--Sig_/SlwN=.sg9eZoil28NjwGF1V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvjoGMACgkQAVBC80lX
0GzFTQf/fxQQacT0/1z3/WM1XuEtJhPZJDlZaevKTlvX+a6MimCcKeJJtRsq3I1H
s2ywSVuErjhGP1xVmHsohNcbGzXH/MUzypje13RBFHNcZ8vPC0N6BGywl9E0V1P6
nNnBruWQoUrX1bNafEzw2+++1W8YbkVmwTNY4skt6LZnkZaNNW/UWdObjf+MYNUz
rqimDqcRNGLnEpLFyg+M9/VXhRaKf5OLYliScxgZX0d39weO9Su4V+sk4FdyXKcl
DojTaX1/Lckgg+0dgNocX4hbl2jEhPGcGRM9KZkIqpHGVJ1A9KYhUFReSU90mmob
n55UjTtdv1cBR5FcraZmlIhtP8m1tQ==
=MIAK
-----END PGP SIGNATURE-----

--Sig_/SlwN=.sg9eZoil28NjwGF1V--
